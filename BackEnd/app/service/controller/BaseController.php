<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Date: 2017/8/11
 * Time: 15:38
 */

namespace app\service\controller;

use Exception;
use Firebase\JWT\JWT;

class BaseController {
    protected $userInfo;

    public function __construct() {

        if (strtoupper($_SERVER['REQUEST_METHOD']) == 'OPTIONS') {
            die('welcome to XRepair');
        }
    }

    //登录判断
    protected function isLogin() {
        if (!$this->userInfo) {
            $authinfo = apache_request_headers();
            $key = base64_encode('xrepair2016');
            try {
                $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
                $this->userInfo = object_array($payload->data);
            } catch (Exception $e) {
                header('HTTP/1.0 401 Unauthorized');
                die('Service API authentication failed');
            }
        }
    }

    /**
     * 获取用户登录token
     * @param $data
     *
     * @return mixed
     */
    public function getLoginInfo($data) {
        try{
            $tokenId = base64_encode($this->uuid());
            $issuedAt = time();
            $notBefore = $issuedAt;
            $expire = $notBefore + 86400;
            $serverName = get_client_ip();
            //载荷
            $payload = ['iat' => $issuedAt,
                'jti' => $tokenId,
                'iss' => $serverName,
                'nbf' => $notBefore,
                'exp' => $expire,
                'data' => ['id' => $data['id'],
                    'name' => $data['name'],
                    'account' => $data['account'],
                    'email' => $data['email'],
                    'mobile' => $data['mobile'],
                    'isAdmin' => $data['isAdmin']]];
            $key = config('jwt_key');
            $secretKey = base64_encode($key);
            $token = JWT::encode($payload, $secretKey);

            $result['token'] = $token;
            $result['userInfo'] = array('name' => $data['name'],
                'account' => $data['account'],
                'email' => $data['email'],
                'mobile' => $data['mobile']);

            return $result;
        }catch (Exception $e){
            return false;
        }
    }


    public function uuid() {
        $charid = md5(uniqid(mt_rand(), true));
        $hyphen = chr(45);// "-"
        $uuid = chr(123)// "{"
            . substr($charid, 0, 8) . $hyphen . substr($charid, 8, 4) . $hyphen . substr($charid, 12, 4) . $hyphen . substr($charid, 16, 4) . $hyphen . substr($charid, 20, 12) . chr(125);// "}"
        return $uuid;
    }
}