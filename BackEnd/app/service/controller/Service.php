<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Date: 2017/8/9
 * Time: 10:36
 */

namespace app\service\controller;


use Jwt\JWT;
use think\Loader;

class Service extends Base
{
    protected function _initialize()
    {
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept,Authorization');
        header('Access-Control-Allow-Methods: GET, POST, PUT,DELETE');
    }

    public function login()
    {
        $account = I('account');
        $password = md5(I('password'));
        ($account && $password) || $this->ajaxReturn(array('code' => 300, 'message' => '账号或密码不能为空'));
        $entity = D('User')->where(array('account' => $account, 'password' => $password))->find();
        if ($entity) {
            $result = $this->getLoginInfo($entity);
            $this->ajaxReturn(array('code' => 200, 'message' => '登录成功', 'result' => $result));
        } else {
            $this->ajaxReturn(array('code' => 300, 'message' => '登录失败'));
        }
    }

    public function register(){

    }

    //获取当前登录用户TOKEN
    public function getToken()
    {
        $entity = session('userInfo');

        $entity = array(
            'id' => 126, //2997
            'nickname' => '365D1!',
            'phone' => '15078812525'
        );

        $result = $this->getLoginInfo($entity);

        return $result;
    }

    private function getLoginInfo($entity)
    {
        $tokenId = base64_encode(self::uuid());
        $issuedAt = time();
        $notBefore = $issuedAt;
        $expire = $notBefore + 86400;
        $serverName = $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'];
        //载荷
        $payload = [
            'iat' => $issuedAt,
            'jti' => $tokenId,
            'iss' => $serverName,
            'nbf' => $notBefore,
            'exp' => $expire,
            'data' => [
                'id' => $entity['id'],
                'nickname' => $entity['nickname'],
                'phone' => $entity['phone'],
            ]
        ];
        $key = config('x_repair.api_key');
        $secretKey = base64_encode($key);
        $token = JWT::encode($payload, $secretKey);
        return $token;
    }

    private static function uuid()
    {
        $charid = md5(uniqid(mt_rand(), true));
        $hyphen = chr(45); // "-"
        $uuid = chr(123) // "{"
            . substr($charid, 0, 8) . $hyphen
            . substr($charid, 8, 4) . $hyphen
            . substr($charid, 12, 4) . $hyphen
            . substr($charid, 16, 4) . $hyphen
            . substr($charid, 20, 12)
            . chr(125); // "}"
        return $uuid;
    }
}