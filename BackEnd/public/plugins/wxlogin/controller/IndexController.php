<?php
// +----------------------------------------------------------------------
// | Wxlogin [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 Tangchao All rights reserved.
// +----------------------------------------------------------------------
// | Author: Tangchao <79300975@qq.com>
// +----------------------------------------------------------------------
namespace plugins\wxlogin\controller;
use cmf\controller\PluginBaseController;
use think\Db;
use app\user\model\UserModel;

class IndexController extends PluginBaseController
{
    function index()
    {
        $this->config = $this->getPlugin('Wxlogin')->getConfig();
        $appid = $this->config['appid'];
        $appkey = $this->config['appkey'];
        $redirect_uri = cmf_plugin_url('Wxlogin://Index/index',array(),true);//回调地址
        $year = date("Y");
        $month = date("m");
        $day = date("d");
        $dayBegin = mktime(0, 0, 0, $month, $day, $year);
        if (!isset($_GET['code'])) {
            $state = md5(uniqid(rand(), true));
            $callback = urlencode($redirect_uri);
            $wxurl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=$appid&redirect_uri=$callback&response_type=code&scope=snsapi_userinfo&state=$state#wechat_redirect";
            header("Location: $wxurl");
        }else{
            $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=' . $appid .'&secret=' . $appkey . '&code=' . $_GET['code'] .'&grant_type=authorization_code';
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_URL, $url);
            $json = curl_exec($ch);
            curl_close($ch);
            $arr = json_decode($json, 1);
            $access_token = $arr['access_token'];
            $url = 'https://api.weixin.qq.com/sns/userinfo?access_token=' . $arr['access_token'] .
                '&openid=' . $arr['openid'] . '&lang=zh_CN';
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_URL, $url);
            $json = curl_exec($ch);
            curl_close($ch);
            $userinfo = json_decode($json, 1);
            $openid = $userinfo['openid'];

            if($openid==""){
                echo "登录失败";
                die();
            }

            $guid=GetGuid();
            $userinfo['login'] = "yt_".$guid;
            $userinfo['user_pass'] = $guid;
            $userinfo['openid'] = $openid;

            $log = registerOauth($userinfo);
        }
        return $this->fetch("/index");
    }
}

function GetGuid() {
    $s = str_replace('.', '', trim(uniqid('yt', true), 'yt'));
    return $s;
}

function registerOauth($user){
        $openid = $user['openid'];
        $result = Db::name("third_party_user")->where('openid', $openid)->find();
        if (empty($result)) {
            $data   = [
                'user_login'      => $user['login'],
                'user_email'      => '',
                'mobile'          => '',
                'user_nickname'   => $user['nickname'],
                'avatar'          => $user['headimgurl'],
                'user_pass'       => cmf_password($user['user_pass']),
                'last_login_ip'   => get_client_ip(0, true),
                'create_time'     => time(),
                'last_login_time' => time(),
                'user_status'     => 1,
                "user_type"       => 2,//会员
            ];
            $userId = Db::name("user")->insertGetId($data);
            $data   = Db::name("user")->where('id', $userId)->find();
            $userdata   = [
                'user_id'      => $userId,
                'openid'      => $openid,
                'third_party'      => "微信",
                'union_id'      => "WX",
                'create_time'      => time(),
                'last_login_time'      => time(),
            ];
            $partyuserId = Db::name("third_party_user")->insertGetId($userdata);
            cmf_update_current_user($data);
            return 0;
        }else{
            $data   = Db::name("user")->where('id', $result['user_id'])->find();
            cmf_update_current_user($data);
            return 0;
        }
        return 1;
}