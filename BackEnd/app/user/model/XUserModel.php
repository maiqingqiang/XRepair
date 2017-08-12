<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/11
 * Time: 21:28
 */

namespace app\user\model;

use think\Db;
use think\Model;

class XUserModel extends Model {


    /**
     * @param $user
     *
     * @return int 0|注册成功,1|注册成功,需验证,2|注册失败
     */
    public function register($user) {
        $userQuery = Db::name("user");

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
        $userId = $userQuery->insertGetId($data);
        if ($userId) {
            if ($userStatus==1){
                return 0;
            }else{
                return 1;
            }
        } else {
            return 2;
        }
    }
}