<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/11
 * Time: 21:28
 */

namespace app\service\model;

use think\Db;
use think\Exception;
use think\Model;

class UserModel extends Model {


    /**
     * @param $user
     *
     * @return int 0|注册成功,1|注册成功,需验证,2|注册失败
     */
    public function register($user) {


        self::startTrans();

        try {
            $userStatus = 1;

            //        if (!cmf_is_open_registration()) {
            //            $userStatus = 2;
            //        }

            $data = ['user_login' => $user['user_login'],
                'user_email' => $user['user_email'],
                'mobile' => $user['mobile'],
                'user_nickname' => $user['user_nickname'],
                'user_pass' => cmf_password($user['user_pass']),
                'last_login_ip' => get_client_ip(0, true),
                'create_time' => time(),
                'last_login_time' => time(),
                'user_status' => $userStatus,
                "user_type" => 2,];
            $userId = self::insertGetId($data);

            //            if ($userStatus == 1) {
            //                return 0;
            //            } else {
            //                return 1;
            //            }

            if ($user['wechat']) {
                $thirdPartyUserModel = Db::name('ThirdPartyUser');

                $wxData = ['user_id' => $userId,
                    'create_time' => time(),
                    'nickname' => $user['wechat']['nickname'],
                    'third_party' => 'wechat',
                    'openid' => $user['wechat']['openid'],
                    'headimgurl' => $user['wechat']['headimgurl'],
                    'sex' => $user['wechat']['sex'],
                    'app_id' => config('wechat.appid')];

                $thirdPartyUserModel->insert($wxData);
            }
            self::commit();

            return 0;

        } catch (Exception $exception) {
            self::rollback();

            echo $exception;


            return 2;
        }


    }

    public function updateUserInfo($id, $user) {

        $data = ['user_email' => $user['email'],
            'mobile' => $user['mobile'],
            'user_nickname' => $user['name']];

        try {
            self::where('id', $id)->update($data);

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function updatePassword($id, $user) {
        $result = self::where('id', $id)->find();
        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['old_password'], $result['user_pass']);
            if ($comparePasswordResult) {
                $data = ['user_pass' => cmf_password($user['password'])];
                try {
                    self::where('id', $id)->update($data);

                    return 1;
                } catch (Exception $e) {
                    return 2;
                }
            } else {
                return 3;
            }
        } else {
            return 4;
        }
    }

    public function doMobile($user) {

        $result = self::where('mobile', $user['mobile'])->find();


        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['user_pass'], $result['user_pass']);
            if ($comparePasswordResult) {
                //拉黑判断。
                if ($result['user_status'] == 0) {
                    return array('status' => 3);
                }
                $data = ['last_login_time' => time(),
                    'last_login_ip' => get_client_ip(0, true),];
                self::where('id', $result["id"])->update($data);

                $thirdPartyUserModel = Db::name('ThirdPartyUser');
                $wechat = $thirdPartyUserModel->field('headimgurl,nickname,openid,sex')->where('user_id', $result['id'])->find();

                return array('status' => 0,
                    'userInfo' => array('id' => $result['id'],
                        'name' => $result['user_nickname'],
                        'account' => $result['user_login'],
                        'email' => $result['user_email'],
                        'mobile' => $result['mobile'],
                        'isAdmin' => $result['user_type'] == 1 ? 1 : 0),
                    'wechat' => $wechat);
            }

            return array('status' => 1);
        }

        return array('status' => 2);
    }

    public function doName($user) {

        $result = self::where('user_login', $user['user_login'])->find();
        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['user_pass'], $result['user_pass']);
            if ($comparePasswordResult) {
                //拉黑判断。
                if ($result['user_status'] == 0) {
                    return array('status' => 3);
                }
                session('user', $result);
                $data = ['last_login_time' => time(),
                    'last_login_ip' => get_client_ip(0, true),];
                self::where('id', $result["id"])->update($data);

                $thirdPartyUserModel = Db::name('ThirdPartyUser');
                $wechat = $thirdPartyUserModel->field('headimgurl,nickname,openid,sex')->where('user_id', $result['id'])->find();

                return array('status' => 0,
                    'userInfo' => array('id' => $result['id'],
                        'name' => $result['user_nickname'],
                        'account' => $result['user_login'],
                        'email' => $result['user_email'],
                        'mobile' => $result['mobile'],
                        'isAdmin' => $result['user_type'] == 1 ? 1 : 0),
                    'wechat' => $wechat);
            }

            return array('status' => 1);
        }

        return array('status' => 2);
    }

    public function doEmail($user) {


        $result = self::where('user_email', $user['user_email'])->find();


        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['user_pass'], $result['user_pass']);

            if ($comparePasswordResult) {
                //拉黑判断。
                if ($result['user_status'] == 0) {
                    return array('status' => 3);
                }
                session('user', $result);
                $data = ['last_login_time' => time(),
                    'last_login_ip' => get_client_ip(0, true),];
                self::where('id', $result["id"])->update($data);

                $thirdPartyUserModel = Db::name('ThirdPartyUser');
                $wechat = $thirdPartyUserModel->field('headimgurl,nickname,openid,sex')->where('user_id', $result['id'])->find();

                return array('status' => 0,
                    'userInfo' => array('id' => $result['id'],
                        'name' => $result['user_nickname'],
                        'account' => $result['user_login'],
                        'email' => $result['user_email'],
                        'mobile' => $result['mobile'],
                        'isAdmin' => $result['user_type'] == 1 ? 1 : 0),
                    'wechat' => $wechat);
            }

            return array('status' => 1);
        }

        return array('status' => 2);
    }

    public function doWxOpenId($openId) {

        $thirdPartyUserModel = Db::name('ThirdPartyUser');

        $wechat = $thirdPartyUserModel->field('user_id,headimgurl,nickname,openid,sex')->where('openid', $openId)->find();
        if ($wechat) {

            $result = self::where('id', $wechat['user_id'])->find();
            if (!empty($result)) {

                unset($wechat['user_id']);

                //拉黑判断。
                if ($result['user_status'] == 0) {
                    return array('status' => 3);
                }
                session('user', $result);
                $data = ['last_login_time' => time(),
                    'last_login_ip' => get_client_ip(0, true),];
                self::where('id', $result["id"])->update($data);

                return array('status' => 0,
                    'userInfo' => array('id' => $result['id'],
                        'name' => $result['user_nickname'],
                        'account' => $result['user_login'],
                        'email' => $result['user_email'],
                        'mobile' => $result['mobile'],
                        'isAdmin' => $result['user_type'] == 1 ? 1 : 0),'wechat'=>$wechat);
            }

        }

        return array('status' => 2);
    }
}