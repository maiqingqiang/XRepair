<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
class Alisms
{
	private $method = 'GET';
	private $api = 'https://sms.aliyuncs.com/';		//短信接口
	private $dateTimeFormat = 'Y-m-d\TH:i:s\Z'; 
	private $config = [
        'Format'    => 'json',
        'Version' => '2016-09-27',  
        'SignatureMethod'     => 'HMAC-SHA1', 
        'SignatureVersion'      => "1.0", 
        'signName'      => '', //管理控制台中配置的短信签名（状态必须是验证通过）
        'TemplateCode'      => '', 
        'AccessKeyId'      => '', 
        'accessKeySecret '      => '', 

    ];

    public function __construct($config = [])
    {
        $this->config($config);
    }
    
    /*读取配置*/
    public function config($config = [])
    {
    	/**
	     *发送短信
	     *@AccessKeyId      阿里云申请的 Access Key ID
	     *@AccessKeySecret  阿里云申请的 Access Key Secret
	    */
        if(config('think_sdk_sms.AccessKeyId')) $conf['AccessKeyId']=config('think_sdk_sms.AccessKeyId');
        if(config('think_sdk_sms.accessKeySecret')) $conf['accessKeySecret']=config('think_sdk_sms.accessKeySecret');
        if(config('think_sdk_sms.signName')) $conf['signName']=config('think_sdk_sms.signName');
        if(config('think_sdk_sms.TemplateCode')) $conf['TemplateCode']=config('think_sdk_sms.TemplateCode');
        $this->config = array_merge($this->config, $conf);
        $this->config = array_merge($this->config, $config);
        if(!config('think_sdk_sms.sms_open')){
        	throw new Exception("短信系统尚未配置和未开启!");
        }else{
        	return $this;
        }
    
    }

    /**
	*发送短信
	*@mobile  目标手机号，多个手机号可以逗号分隔 
	*@code 短信模板的模板CODE
	*@ParamString  短信模板中的变量；,参数格式{“no”:”123456”}， 个人用户每个变量长度必须小于15个字符
	*/
	public function smsend($mobile,$ParamString,$code='')
    {
        date_default_timezone_set("GMT");
        $dateTimeFormat = 'Y-m-d\TH:i:s\Z'; // ISO8601规范 
        if(!$code){
            $code = $this->config['TemplateCode'];
        } 
        $data = array(
            'SignName'           => $this->config['signName'],
            'Format'             => $this->config['Format'],
            'Version'            => $this->config['Version'],
            'AccessKeyId'        => $this->config['AccessKeyId'],
            'SignatureVersion'   => $this->config['SignatureVersion'],
            'SignatureMethod'    => $this->config['SignatureMethod'],
            'SignatureNonce'     => md5('estxiu.com').rand(100000,999999).uniqid(), //唯一随机数
            'Timestamp'          => date($dateTimeFormat),
            // 接口参数 
            'Action'             => 'SingleSendSms',
            'TemplateCode'       => $code,
            'RecNum'             => $mobile,
            'ParamString'        => $ParamString,
        );
        $data['Signature'] = $this->computeSignature($data,$this->config['accessKeySecret']);
        //var_dump($data);exit;
        $data = $this->http($this->api, $data, $this->method);
        return $data;
	}

    /**
     * 发送HTTP请求方法，目前只支持CURL发送请求
     * @param  string $url 请求URL
     * @param  array $params 请求参数
     * @param  string $method 请求方法GET/POST
     * @return array  $data   响应数据
     */
    protected function http($url, $params, $method = 'GET', $header = array(), $multi = false)
    {
        $opts = array(
            CURLOPT_TIMEOUT => 30,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => false,
            CURLOPT_HTTPHEADER => $header
        );

        /* 根据请求类型设置特定参数 */
        switch (strtoupper($method)) {
            case 'GET':
                $opts[CURLOPT_URL] = $url . '?' . http_build_query($params);
                break;
            case 'POST':
                //判断是否传输文件
                $params = $multi ? $params : http_build_query($params);
                $opts[CURLOPT_URL] = $url;
                $opts[CURLOPT_POST] = 1;
                $opts[CURLOPT_POSTFIELDS] = $params;
                break;
            default:
                exception('不支持的请求方式！');
        }

        /* 初始化并执行curl请求 */
        $ch = curl_init();
        curl_setopt_array($ch, $opts);
        $data = curl_exec($ch);
        $error = curl_error($ch);
        curl_close($ch);
        if ($error)
            exception('请求发生错误：' . $error);
        return $data;
    }

	//生成取短信签名
    private function computeSignature($parameters, $accessKeySecret)
    {
        ksort($parameters);
        $canonicalizedQueryString = '';
        foreach($parameters as $key => $value){
            $canonicalizedQueryString .= '&' . $this->percentEncode($key). '=' . $this->percentEncode($value);
        }   
        $stringToSign = $this->method.'&%2F&' . $this->percentencode(substr($canonicalizedQueryString, 1));
        $signature = $this->signString($stringToSign, $accessKeySecret."&");
        return $signature;
    }
    private function percentEncode($str)
    {
        $res = urlencode($str);
        $res = preg_replace('/\+/', '%20', $res);
        $res = preg_replace('/\*/', '%2A', $res);
        $res = preg_replace('/%7E/', '~', $res);
        return $res;
    }
    private function signString($source, $accessSecret)
    {
        return  base64_encode(hash_hmac('sha1', $source, $accessSecret, true));
    }
	


}

    