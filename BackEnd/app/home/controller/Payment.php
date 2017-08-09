<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\home\controller;

use think\Db;
use Payment\ChargeContext;
use Payment\Config;
use Payment\Common\PayException;

use Payment\NotifyContext;

class Payment extends Base
{
	public function index()
    {
		return $this->view->fetch('payment:index');
	}
	public function runpay()
    {
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('home/payment/index'));
		}else{
			$charge = new ChargeContext();
			$time = time();
			$payment_model=Db::name("payment");
			$out_trade_no = $charge->createPayid();
            $money = input('coins'); 
            $paytype = input('pay_type');
            $product_name = input('product_name');
            $product_body = input('product_body');
            $pay_config = config("payment.{$paytype}");
            if(empty($pay_config['display'])){
                $return_data = array('coode'=>'eroor','info'=>'支付方式未开启或未配置!!');
                return $return_data;
                exit();
            }
            if(!$money || !$paytype){
                $return_data = array('coode'=>'eroor','info'=>'订单参数错误,获取不完整!!');
                return $return_data;
                exit();
            }
			$sl_data = array(
				'out_trade_no' => $out_trade_no,
				'money'        => $money,
				'status'       => 0,
				'type'         => $paytype,
				'uid'          => 1,
				'create_time'  => $time,
				'update_time'  => $time,
				'client_ip'    => request()->ip(),
				'product_name' => $product_name,
				'product_body' => $product_body
				);
			$rst=$payment_model->insertGetId($sl_data);
			if($rst){
				//$this->redirect('home/payment/dopay',array('out_trade_no'=>$out_trade_no,'sign'=>md5($out_trade_no.request()->ip())));
                $url = '/home/payment/dopay?out_trade_no='.$out_trade_no.'&sign='.md5($out_trade_no.request()->ip());
                $return_data = array('code'=>'SUCCESS','paytype'=>$paytype,'info'=>'生成订单成功,准备跳转支付页面!!','url'=>$url
                    );
                return $return_data;
			}


		}
	}
	public function dopay($out_trade_no='NULL',$sign='NULL')
    {
		if(!$out_trade_no || !$sign || $sign!==md5($out_trade_no.request()->ip())){echo 'error sgin!!';exit();}
		$payment_model=Db::name("payment");
		$pay_info = $payment_model->where(array("out_trade_no"=>$out_trade_no,"status"=>0))->find();
		if($pay_info){
			$pay_type = $pay_info['type'];
			$pay_config = config("payment.{$pay_type}");
			$payData = [
                "order_no"  => $pay_info['out_trade_no'],
                "amount"    => $pay_info['money'],// 单位为元 ,最小为0.01
                "client_ip" => $pay_info['client_ip'],
                "subject"   => $pay_info['product_name'],
                "body"      => $pay_info['product_body'],
                "show_url"  => $pay_info['product_url'],// 支付宝手机网站支付接口 该参数必须上传 。其他接口忽略
                "extra_param"   => $pay_info['extra_param'],
            ]; 
            $payData['product_id']  = '123456';
            //获取OPENID 
            // TODO 暂时先用COOKE之后改查数据表
            if($pay_type=='wxpaypub' || $pay_type=='wxpayapp'){
                $openid=isset($_COOKIE['openid'])?$_COOKIE['openid']:'';
                if(empty($openid)){
                    $url = 'http://'.$_SERVER['SERVER_NAME'].':'.$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"]; 
                    //绑定要设定cookie  setcookie('openid',$openid,time()+86400*30);  
                    $this->redirect('home/Oauth/bang',array('type'=>'Wechat','redirect'=>$url));  
                }else{
                $payData['openid']=$openid;
                }              
            }
            //获取OPENID结束
            $charge = new ChargeContext();
            try {
            	switch ($pay_type){
            	        case 'aliwappay':  
            	        $type = Config::ALI_CHANNEL_WAP;
                        break;
                        case 'alipay':
                        $type = Config::ALI_CHANNEL_WEB;
                        break;
                        case 'alipayapp':
                        $type = Config::ALI_CHANNEL_APP;
                        break;
                        case 'wxpayqrcode':
                        $type = Config::WX_CHANNEL_QR;
                        break;
                        case 'wxpayapp':
                        $type = Config::WX_CHANNEL_APP;
                        break;
                        case 'wxpaypub':
                        $type = Config::WX_CHANNEL_PUB;
                        break;
            }
                $charge->initCharge($type, $pay_config);
                $ret = $charge->charge($payData);
               } catch (PayException $e) {
            echo $e->errorMessage();exit;
            }
            if ($type === Config::ALI_CHANNEL_APP) {   //阿里app支付
                var_dump($ret);
                } elseif ($type === Config::WX_CHANNEL_QR) {  //微信QRCODE支付
                $url = urlencode($ret);
                $pay_qrcode_url = "http://paysdk.weixin.qq.com/example/qrcode.php?data={$url}";
                $this->assign('pay_qrcode_url',$pay_qrcode_url);
                $this->assign('out_trade_no',$pay_info['out_trade_no']); //amount
                $this->assign('money',$pay_info['money']);
                $this->assign('sgin',$sign);
                return $this->view->fetch('payment:wxqrcode');
                } elseif ($type === Config::WX_CHANNEL_PUB) {  //微信JSAPI
                $json = $ret;
                $this->assign('json',$json);
                return $this->view->fetch('payment:wxpaypub');
                //var_dump($json);
                } elseif (stripos($type, 'wx') !== false) {  //微信app支付
                var_dump($ret);
                } elseif (stripos($type, 'ali') !== false) {
                // 跳转支付宝
                header("Location:{$ret}");
            }

		}else{
			$this->error('订单不合法验证失败',url('home/payment/index'));exit;
		}

	}
    
    /*支付成功-跳转页面*/
    public function pay_success()
    {
        $this->success('支付完成',url('home/Payment/index'));
    }

	public function wxqrcodequery($out_trade_no='NULL',$sgin='NULL')
    {
        if(!$out_trade_no || !$sgin || $sgin!==md5($out_trade_no.request()->ip())){echo 'error sgin!!';exit();}
        $payment_model=Db::name("payment");
        $pay_info = $payment_model->where(array("out_trade_no"=>$out_trade_no))->find();
        $data = array('status'=>$pay_info['status']);
        return $data;
	}

    public function wxqrcode_notify_url()
    {
        $notify = new NotifyContext();
        $callback = new PaymentNotify();
        $pay_config = config("payment.wxpayqrcode");
        try {
            $notify->initNotify(Config::WEIXIN, $pay_config);
            $ret = $notify->notify($callback);
           } catch (PayException $e) {
        echo $e->errorMessage();exit;
        }
    }

    public function wxpub_notify_url()
    {
        $notify = new NotifyContext();
        $callback = new PaymentNotify();
        $pay_config = config("payment.wxpaypub");
        try {
            $notify->initNotify(Config::WEIXIN, $pay_config);
            $ret = $notify->notify($callback);
           } catch (PayException $e) {
        echo $e->errorMessage();exit;
        }
    }

    public function ali_notify_url()
    {
        $notify = new NotifyContext();
        $callback = new PaymentNotify();
        $pay_config = config("payment.alipay");
        try {
            $notify->initNotify(Config::ALI, $pay_config);
            $ret = $notify->notify($callback);
           } catch (PayException $e) {
        echo $e->errorMessage();exit;
        }
    }

    public function aliwap_notify_url()
    {
        $notify = new NotifyContext();
        $callback = new PaymentNotify();
        $pay_config = config("payment.alipay");
        try {
            $notify->initNotify(Config::ALI, $pay_config);
            $ret = $notify->notify($callback);
           } catch (PayException $e) {
        echo $e->errorMessage();exit;
        }
    }


	
}