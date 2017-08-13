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

    public function doMobile($user)
    {
        $userQuery = Db::name("user");

        $result = $userQuery->where('mobile', $user['mobile'])->find();


        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['user_pass'], $result['user_pass']);
            if ($comparePasswordResult) {
                //拉黑判断。
                if($result['user_status']==0){
                    return array('status'=>3);
                }
                $data = [
                    'last_login_time' => time(),
                    'last_login_ip'   => get_client_ip(0, true),
                ];
                $userQuery->where('id', $result["id"])->update($data);
                return array(
                    'status'=>0,
                    'userInfo'=>array(
                        'id'=>$result['id'],
                        'name'=>$result['user_nickname'],
                        'email'=>$result['user_email'],
                        'mobile'=>$result['mobile'],
                    )
                );
            }
            return array('status'=>1);
        }
        return array('status'=>2);
    }

    public function doName($user)
    {
        $userQuery = Db::name("user");

        $result = $userQuery->where('user_login', $user['user_login'])->find();
        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['user_pass'], $result['user_pass']);
            if ($comparePasswordResult) {
                //拉黑判断。
                if($result['user_status']==0){
                    return array('status'=>3);
                }
                session('user', $result);
                $data = [
                    'last_login_time' => time(),
                    'last_login_ip'   => get_client_ip(0, true),
                ];
                $userQuery->where('id', $result["id"])->update($data);
                return array(
                    'status'=>0,
                    'userInfo'=>array(
                        'id'=>$result['id'],
                        'name'=>$result['user_nickname'],
                        'email'=>$result['user_email'],
                        'mobile'=>$result['mobile'],
                    )
                );
            }
            return array('status'=>1);
        }

        return array('status'=>2);
    }

    public function doEmail($user)
    {

        $userQuery = Db::name("user");

        $result = $userQuery->where('user_email', $user['user_email'])->find();


        if (!empty($result)) {
            $comparePasswordResult = cmf_compare_password($user['user_pass'], $result['user_pass']);

            if ($comparePasswordResult) {
                //拉黑判断。
                if($result['user_status']==0){
                    return array('status'=>3);
                }
                session('user', $result);
                $data = [
                    'last_login_time' => time(),
                    'last_login_ip'   => get_client_ip(0, true),
                ];
                $userQuery->where('id', $result["id"])->update($data);
                return array(
                    'status'=>0,
                    'userInfo'=>array(
                        'id'=>$result['id'],
                        'name'=>$result['user_nickname'],
                        'email'=>$result['user_email'],
                        'mobile'=>$result['mobile'],
                    )
                );
            }
            return array('status'=>1);
        }
        return array('status'=>2);
    }
}