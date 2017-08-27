<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Date: 2017/8/11
 * Time: 15:41
 */

namespace app\service\controller;

use app\user\model\XUserModel;
use Firebase\JWT\JWT;
use geetest\GeetestLib;
use GuzzleHttp\Client;
use think\Db;
use think\Validate;

class PublicController extends BaseController {
    protected function _initialize() {
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept,Authorization');
        header('Access-Control-Allow-Methods: GET, POST, PUT,DELETE');
    }

    public function getAppId() {
        if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) {
            $appId = config('wechat.appid');
            if ($appId) {
                return json(['code' => 200,
                    'message' => '成功',
                    'result' => $appId]);
            } else {
                return json(['code' => 300,
                    'message' => '失败']);
            }
        }
    }

    public function getWxUserInfo() {
        if (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false) {
            if (request()->isPost()) {
                $code = input('code');
                $appid = config('wechat.appid');
                $secret = config('wechat.secret');

                $client = new Client();
                $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=' . $appid . '&secret=' . $secret . '&code=' . $code . '&grant_type=authorization_code';
                $response = $client->request('GET', $url);

                return $response->getBody();
            }
        }
    }

    /**
     * 登录
     * @return \think\response\Json
     */
    public function login() {
        if (request()->isPost()) {
            $validate = new Validate(['username' => 'require',
                'password' => 'require|min:5',]);
            $validate->message(['username.require' => '用户名不能为空',
                'password.require' => '密码不能为空',
                'password.min' => '密码不能小于5个字符',]);

            $data = request()->post();
            if (!$validate->check($data)) {
                return json(['code' => 400,
                    'message' => $validate->getError()]);
            }

            if (!$this->captcha($data['random'], $data['offline'], $data['geetest_challenge'], $data['geetest_validate'], $data['geetest_seccode'])) {
                return json(['code' => 401,
                    'message' => '验证码错误']);
            }

            $userModel = new XUserModel();
            $user['user_pass'] = $data['password'];
            if (filter_var($data['username'], FILTER_VALIDATE_EMAIL)) {
                $user['user_email'] = $data['username'];
                $result = $userModel->doEmail($user);
            } else if (preg_match('/(^(13\d|15[^4\D]|17[13678]|18\d)\d{8}|170[^346\D]\d{7})$/', $data['username'])) {
                $user['mobile'] = $data['username'];
                $result = $userModel->doMobile($user);
            } else {
                $user['user_login'] = $data['username'];
                $result = $userModel->doName($user);
            }
            switch ($result['status']) {
                case 0:
                    $data = $this->getLoginInfo($result['userInfo']);
                    if ($data) {
                        return json(['code' => 200,
                            'message' => '登录成功',
                            'result' => $data]);
                    } else {
                        return json(['code' => 500,
                            'message' => '系统错误']);
                    }
                    break;
                case 1:
                    return json(['code' => 400,
                        'message' => '登录密码错误']);
                    break;
                case 2:
                    return json(['code' => 400,
                        'message' => '账户不存在']);
                    break;
                case 3:
                    return json(['code' => 400,
                        'message' => '账号被禁止访问系统']);
                    break;
                default :
                    return json(['code' => 400,
                        'message' => '未受理的请求']);
            }
        } else {
            return json(['code' => 500,
                'message' => '请求错误']);
        }
    }

    /**
     * 注册
     * @return \think\response\Json
     */
    public function register() {
        if (request()->isPost()) {
            $rules = ['username' => 'require|min:4|max:10|alphaDash|unique:user,user_login',
                'name' => 'require|min:2|chs',
                'email' => 'require|email|unique:user,user_email',
                'mobile' => 'require|length:11|unique:user,mobile',
                'password' => 'require|min:5|confirm'];

            $isOpenRegistration = cmf_is_open_registration();

            if (!$isOpenRegistration) {
                return json(['code' => 403,
                    'message' => '系统不开放注册,请联系管理员!']);
            }

            $validate = new Validate($rules);
            $validate->message(['username.require' => '用户名不能为空',
                'username.min' => '用户名不能小于4个字符',
                'username.max' => '用户名不能大于10个字符',
                'username.alphaDash' => '用户名存在不支持字符',
                'username.unique' => '用户名已存在',
                'name.require' => '姓名不能为空',
                'name.min' => '真是姓名不能小于2个字符',
                'name.chs' => '真是姓名只能为中文',
                'email.require' => '邮箱不能为空',
                'email.email' => '真是姓名只能为中文',
                'email.unique' => '邮箱已使用',
                'mobile.require' => '手机号码不能为空',
                'mobile.length' => '手机号码长度只能为11位',
                'mobile.unique' => '手机号码已使用',
                'password.require' => '密码不能为空',
                'password.min' => '密码不能小于5个字符',
                'password.confirm' => '两个密码不一样',]);

            $data = request()->post();

            if (array_key_exists('mobile', $data)) {
                $data['mobile'] = str_replace(' ', '', $data['mobile']);
            }

            if (!$validate->check($data)) {
                return json(['code' => 400,
                    'message' => $validate->getError()]);
            }

            if (!$this->captcha($data['random'], $data['offline'], $data['geetest_challenge'], $data['geetest_validate'], $data['geetest_seccode'])) {
                return json(['code' => 401,
                    'message' => '验证码错误']);
            }

            $model = new XUserModel();

            $user['user_login'] = $data['username'];
            $user['user_nickname'] = $data['name'];
            $user['mobile'] = $data['mobile'];
            $user['user_email'] = $data['email'];
            $user['user_pass'] = $data['password'];
            $log = $model->register($user);

            switch ($log) {
                case 0:
                    return json(['code' => 200,
                        'message' => '注册成功']);
                    break;
                case 2:
                    return json(['code' => 400,
                        'message' => '注册失败']);
                    break;
                default :
                    return json(['code' => 500,
                        'message' => '未受理的请求']);
            }
        } else {
            return json(['code' => 403,
                'message' => '请求错误']);
        }

    }

    /**
     * 检验验证码
     *
     * @param $random
     * @param $offline
     * @param $geetest_challenge
     * @param $geetest_validate
     * @param $geetest_seccode
     *
     * @return bool
     */
    private function captcha($random, $offline, $geetest_challenge, $geetest_validate, $geetest_seccode) {
        $data = array("user_id" => $random,
            "client_type" => "h5",
            "ip_address" => get_client_ip());

        $GtSdk = new GeetestLib(config('geetest_captcha_id'), config('geetest_private_key'));

        if ($offline == 1) {   //服务器正常
            if ($GtSdk->fail_validate($geetest_challenge, $geetest_validate, $geetest_seccode)) {
                return true;
            } else {
                return false;
            }
        } else {  //服务器宕机,走failback模式
            $result = $GtSdk->success_validate($geetest_challenge, $geetest_validate, $geetest_seccode, $data);
            if ($result) {
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * 初始化验证码
     * @return mixed
     */
    public function initCaptcha() {
        $random = input('random');

        $GtSdk = new GeetestLib(config('geetest_captcha_id'), config('geetest_private_key'));

        $data = array("user_id" => $random,
            "client_type" => "h5",
            "ip_address" => get_client_ip());

        $GtSdk->pre_process($data, 1);

        return $GtSdk->get_response_str();
    }


    public function getToken() {

        $result = Db::name('User')->where('id', 1)->find();


        $data = ['id' => $result['id'],
            'name' => $result['user_nickname'],
            'account' => $result['user_login'],
            'email' => $result['user_email'],
            'mobile' => $result['mobile'],
            'isAdmin' => 1];
        $result = $this->getLoginInfo($data);

        return json(['code' => 200,
            'message' => '登录成功',
            'result' => $result]);
    }
}