<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Date: 2017/8/11
 * Time: 15:41
 */

namespace app\service\controller;

use app\user\model\XUserModel;
use geetest\GeetestLib;
use think\Validate;

class PublicController extends BaseController {
    protected function _initialize() {
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept,Authorization');
        header('Access-Control-Allow-Methods: GET, POST, PUT,DELETE');
    }

    public function register() {
        if (request()->isPost()) {
            $rules = ['username' => 'require|min:4|max:12|alphaDash|unique:user,user_login',
                'name' => 'require|min:2|chs',
                'email' => 'require|email|unique:user,user_email',
                'mobile' => 'require|length:11|unique:user,mobile',
//                'captcha' => 'require',
                'password' => 'require|min:6|max:32|confirm',];

            $isOpenRegistration = cmf_is_open_registration();

            if (!$isOpenRegistration) {
                return json(['code' => 403,
                    'message' => '系统不开放注册,请联系管理员!']);
            }

            $validate = new Validate($rules);
            $validate->message(['username.require' => '用户名不能为空',
                'username.min' => '用户名不能小于4个字符',
                'username.max' => '用户名不能大于12个字符',
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
//                'captcha.require' => '验证码不能为空',
                'password.require' => '密码不能为空',
                'password.max' => '密码不能超过32个字符',
                'password.min' => '密码不能小于6个字符',
                'password.confirm' => '两个密码不一样',]);

            $data = request()->post();

            if (array_key_exists('mobile', $data)) {
                $data['mobile'] = str_replace(' ', '', $data['mobile']);
            }

            if (!$validate->check($data)) {
                return json(['code' => 400,
                    'message' => $validate->getError()]);
            }

//            if (!cmf_captcha_check($data['captcha'])) {
//                return json(['code' => 400,
//                    'message' => '验证码错误']);
//            }

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

    public function captcha($geetest_challenge,$geetest_validate,$geetest_seccode)
    {
        $GtSdk = new GeetestLib(config('geetest_captcha_id'), config('geetest_private_key'));
        if ($GtSdk->fail_validate($_POST['geetest_challenge'], $_POST['geetest_validate'], $_POST['geetest_seccode'])) {
            echo '{"status":"success"}';
        } else {
            echo '{"status":"fail"}';
        }
    }

    public function initCaptcha()
    {
        $GtSdk = new GeetestLib(config('geetest_captcha_id'), config('geetest_private_key'));
        $GtSdk->pre_process();
        return $GtSdk->get_response_str();
    }
}