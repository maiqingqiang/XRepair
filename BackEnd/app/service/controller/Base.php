<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Date: 2017/8/9
 * Time: 10:41
 */
namespace app\service\controller;

class Base{
    protected $userInfo;

    protected function _initialize() {
        $this->userInfo = session('userInfo');
        if (getHost() != 'https://www.syd666.com') {
            header('Access-Control-Allow-Origin: *');
            header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept,Authorization');
            header('Access-Control-Allow-Methods: GET, POST, PUT,DELETE,OPTIONS');
        }

        if (strtoupper($_SERVER['REQUEST_METHOD']) == 'OPTIONS') {
            die('welcome to C2B Technology Co.,Ltd');
        }
    }

    //登录判断
    protected function isLogin() {
        if (!$this->userInfo) {
            $authinfo = apache_request_headers();
            $key = base64_encode(C('API_AUTH_KEY'));
            try {
                $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
                $this->userInfo = object_array($payload->data);
            } catch (Exception $e) {
                header('HTTP/1.0 401 Unauthorized');
                die('Service API authentication failed');
            }
        }
    }

    public function getUserInfo() {
        $this->ajaxResult(200, '获取成功', $this->userInfo);
    }

    protected function ajaxResult($code, $message, $list = array()) {
        $data['code'] = $code;
        $data['message'] = $message;
        $data['result'] = $list;
        $this->ajaxReturn($data, "JSON");
    }
}