<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Date: 2017/8/9
 * Time: 10:36
 */

namespace app\service\controller;


use Jwt\JWT;
use think\captcha\Captcha;
use think\Db;
use think\Loader;
use think\Validate;

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

    //验证码
    public function verify()
    {
        ob_end_clean();
        $verify = new Captcha(config('verify'));
        return $verify->entry('reg');
    }

    public function register()
    {

        if (request()->isPost()) {
            $member_list_username = input('username');
            $member_list_nickname = input('nickname');
            $member_list_tel = input('tel');
            $password = input('password');
            $repassword = input('repassword');
            $verify = input('verify');

            $verify_obj = new Captcha ();
            if (!$verify_obj->check($verify, 'reg')) {
                return json(['code' => 401, 'message' => '验证码错误！']);
            }

            $rule = [
                ['member_list_tel', 'require|max:11|min:11', '手机号码不能为空|手机不能大于11位|手机不能小于11位'],
                ['password', 'require|length:5,20', '{%pwd empty}|{%pwd length}'],
                ['member_list_username', 'require', '{%username empty}'],
                ['member_list_nickname', 'require', '真实姓名不能为空'],
                ['repassword', 'require|confirm:password', '{%repassword empty}|{%repassword incorrect}']
            ];
            $validate = new Validate($rule);
            $rst = $validate->check(array(
                'member_list_username' => $member_list_username,
                'member_list_nickname' => $member_list_nickname,
                'password' => $password,
                'repassword' => $repassword,
                'member_list_tel' => $member_list_tel
            ));
            $users_model = Db::name("member_list");
            if (true !== $rst) {
                return json(['code' => 401, 'message' => join('|', $validate->getError())]);
            }
            //用户名需过滤的字符的正则
            $stripChar = '?<*.>\'"';
            if (preg_match('/[' . $stripChar . ']/is', $member_list_username) == 1) {
//                $this->error(lang('username format incorrect',['stripChar'=>$stripChar]));
                return json(['code' => 401, 'message' => '用户名格式不正确！']);
            }

            if (preg_match('/[' . $stripChar . ']/is', $member_list_nickname) == 1) {
//                $this->error(lang('username format incorrect',['stripChar'=>$stripChar]));
                return json(['code' => 401, 'message' => '正式姓名格式不正确！']);
            }


            //判断是否存在
            $result = $users_model->where('member_list_username', $member_list_username)->count();
            if ($result) {
                return json(['code' => 401, 'message' => '用户名已存在！']);
            } else {
                $member_list_salt = random(10);
                $sl_data = array(
                    'member_list_username' => $member_list_username,
                    'member_list_nickname' => $member_list_nickname,
                    'member_list_salt' => $member_list_salt,
                    'member_list_pwd' => encrypt_password($password, $member_list_salt),
                    'member_list_tel' => $member_list_tel,
                    'member_list_groupid' => 1,
                    'member_list_open' => 1,
                    'member_list_addtime' => time(),
                    'user_status' => 1,//需要激活,则为未激活状态,否则为激活状态
                );
                $rst = $users_model->insertGetId($sl_data);
                if ($rst !== false) {
                    //更新字段
                    $data = array(
                        'last_login_time' => time(),
                        'last_login_ip' => request()->ip(),
                    );
                    $sl_data['last_login_time'] = $data['last_login_time'];
                    $sl_data['last_login_ip'] = $data['last_login_ip'];
                    $users_model->where(array('member_list_id' => $rst))->update($data);
                    return json(['code' => 200, 'message' => '注册成功！']);
                } else {
                    return json(['code' => 400, 'message' => '注册失败！']);
                }
            }
        }
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