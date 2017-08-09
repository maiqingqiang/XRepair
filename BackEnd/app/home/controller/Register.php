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
use think\captcha\Captcha;
use think\Validate;

class Register extends Base
{

    public function index()
    {
	    if(session('hid')){ //已经登录时直接跳到首页
	        $this->redirect(__ROOT__."/");
	    }else{
			return $this->view->fetch('user:register');
	    }
	}
	//验证码
	public function verify()
    {
        if (session('hid')) {
            $this->redirect(__ROOT__."/");
        }
		ob_end_clean();
		$verify = new Captcha (config('verify'));
		return $verify->entry('reg');
    }

    public function runregister()
    {
		if(request()->isPost()){
			$member_list_username=input('member_list_username');
			$member_list_email=input('member_list_email');
			$password=input('password');
			$repassword=input('repassword');
			$verify=input('verify');
			$verify_obj =new Captcha ();
			if (!$verify_obj->check($verify, 'reg')) {
				$this->error(lang('verifiy incorrect'));
			}
			$rule = [
				['member_list_email','require|email','{%email empty}|{%email format incorrect}'],
				['password','require|length:5,20','{%pwd empty}|{%pwd length}'],
				['member_list_username','require','{%username empty}'],
				['repassword','require|confirm:password','{%repassword empty}|{%repassword incorrect}']
			];
			$validate = new Validate($rule);
			$rst   = $validate->check(array(
				'member_list_username'=>$member_list_username,
				'password'=>$password,
				'repassword'=>$repassword,
				'member_list_email'=>$member_list_email
			));
			$users_model=Db::name("member_list");
			if(true !==$rst){
				$this->error(join('|',$validate->getError()));
			}
			//用户名需过滤的字符的正则
			$stripChar = '?<*.>\'"';
			if(preg_match('/['.$stripChar.']/is', $member_list_username)==1){
				$this->error(lang('username format incorrect',['stripChar'=>$stripChar]));
			}
			//判断是否存在
			$result = $users_model->where('member_list_username',$member_list_username)->whereOr('member_list_email',$member_list_email)->count();
			if($result){
				$this->error(lang('username exists'));
			}else{
				$member_list_salt=random(10);
				$active_options=get_active_options();
				$sl_data=array(
					'member_list_username'=>$member_list_username,
					'member_list_nickname'=>$member_list_username,
					'member_list_salt' => $member_list_salt,
					'member_list_pwd'=>encrypt_password($password,$member_list_salt),
					'member_list_email'=>$member_list_email,
					'member_list_groupid'=>1,
					'member_list_open'=>1,
					'member_list_addtime'=>time(),
					'user_status'=>empty($active_options['email_active'])?1:0,//需要激活,则为未激活状态,否则为激活状态
				);
				$rst=$users_model->insertGetId($sl_data);
				if($rst!==false){
					if(!empty($active_options['email_active'])){
						$activekey=md5($rst.time().uniqid());//激活码
						$result=$users_model->where(array("member_list_id"=>$rst))->update(array("user_activation_key"=>$activekey));
						if(!$result){
							$this->error(lang('activation code generation failed'));
						}
						//生成激活链接
						$url = url('home/Register/active',array("hash"=>$activekey), "", true);
						$template = $active_options['email_tpl'];
						$content = str_replace(array('http://#link#','#username#'), array($url,$member_list_username),$template);
						$send_result=sendMail($member_list_email, $active_options['email_title'], $content);
						if($send_result['error']){
							$this->error(lang('send active email failed'));
						}else{
							$this->success(lang('send active email success'),url('home/Login/index'));
						}
					}else{
						//更新字段
						$data = array(
							'last_login_time' => time(),
							'last_login_ip' => request()->ip(),
						);
						$sl_data['last_login_time']=$data['last_login_time'];
						$sl_data['last_login_ip']=$data['last_login_ip'];
						$users_model->where(array('member_list_id'=>$rst))->update($data);
						session('hid',$rst);
						session('user',$sl_data);
						$this->success(lang('register success'),url('home/Index/index'));
					}
				}else{
					$this->error(lang('register failed'));
				}
			}
		}
	}
	//激活
    public function active()
    {
		$hash=input('hash','');
		if(empty($hash)){
			$this->error(lang('pwd reset hash incorrect'));
		}
		$users_model=Db::name("member_list");
		$find_user=$users_model->where(array("user_activation_key"=>$hash))->find();
		if($find_user){
			$result=$users_model->where(array("user_activation_key"=>$hash))->update(array("user_activation_key"=>"","user_status"=>1));
			if($result){
				$find_user['user_status']=1;
				//更新字段
				$data = array(
					'last_login_time' => time(),
					'last_login_ip' => request()->ip(),
				);
				$find_user['last_login_time']=$data['last_login_time'];
				$find_user['last_login_ip']=$data['last_login_ip'];
				$users_model->where(array('member_list_id'=>$find_user["member_list_id"]))->update($data);
				session('hid',$find_user['member_list_id']);
				session('user',$find_user);
				$this->success(lang('active success'),url('home/Index/index'));
			}else{
				$this->error(lang('active failed'),url("home/Login/index"));
			}
		}else{
			$this->error(lang('pwd reset hash incorrect'),url("home/Login/index"));
		}
	}
}