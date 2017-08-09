<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------

namespace app\admin\model;

use app\admin\model\MemberList;
use think\Model;
use think\Db;

/**
 * 后台用户模型
 * @package app\admin\model
 */
class Admin extends Model
{

    protected $autoWriteTimestamp = true;
    protected $createTime = 'admin_addtime';
    protected $updateTime = false;
    /**
     * 用户登录
     * @param string $username 用户名
     * @param string $password 密码
     * @param bool $rememberme 记住登录
     * @return bool|mixed
     */
    public function login($username = '', $password = '', $rememberme = false)
    {
        $username = trim($username);
        $password = trim($password);
		$map['admin_username']=$username;
		$map['admin_open']=1;
        $user = self::get($map);
        if (!$user) {
            $this->error = '用户不存在或被禁用！';
        } else {
            if (encrypt_password($password,$user['admin_pwd_salt'])!==$user['admin_pwd']) {
                $this->error = '密码错误！';
            } else {
                $aid = $user['admin_id'];
                // 更新登录信息
                $user['admin_last_ip']   = request()->ip();
                $user['admin_last_time'] = time();
				$user['admin_hits']	   = $user['admin_hits']+1;
                if ($user->save()) {
                    // 自动登录
                    $this->auto_login(self::get($aid), $rememberme);
                }
                return $aid;
            }
        }
        return false;
    }

    /**
     * 自动登录
     * @param mixed $user 用户对象
     * @param bool $rememberme 是否记住登录，默认7天
     */
    public function auto_login($user, $rememberme = false)
    {
		// 记录登录
        $auth = array(
            'aid'             			 => $user->admin_id,
            'admin_avatar'    			 => $user->admin_avatar,
            'admin_last_change_pwd_time' => $user->admin_changepwd,
            'admin_realname'       		 => $user->admin_realname,
            'admin_username'          	 => $user->admin_username,
            'member_id'        			 => $user->member_id,
            'admin_last_ip' 			 => $user->admin_last_ip,
            'admin_last_time'   		 => $user->admin_last_time
        );
        session('admin_auth', $auth);
		session('admin_auth_sign', data_signature($auth));

        // 记住登录
        if ($rememberme) {
            $signin_token = $user->admin_username.$user->admin_id.$user->admin_last_time;
            cookie('aid', $user->admin_id, 24 * 3600 * 7);
            cookie('signin_token', data_signature($signin_token), 24 * 3600 * 7);
        }
 		//根据需要决定是否记录前台登陆
 		session('hid',$auth['member_id']);
		cookie('yf_logged_user', jiami("{$auth['member_id']}.{$auth['admin_last_time']}"));
		$member=Db::name('member_list')->where('member_list_id',$auth['member_id'])->find();
		if($member) session('user',$member);
     }

    /**
     * 判断是否登录
     * @return int 0或用户id
     */
    public function is_login()
    {
        $user = session('admin_auth');
        if (empty($user)) {
            if (cookie('?aid') && cookie('?signin_token')) {
                $user = $this::get(cookie('aid'));
                if ($user) {
                    $signin_token = data_signature($user['admin_username'].$user['admin_id'].$user['admin_last_time']);
                    if (cookie('signin_token') == $signin_token) {
                        $this->auto_login($user, true);
                        return $user['admin_id'];
                    }
                }
            };
            return 0;
        }else{
            return session('admin_auth_sign') == data_signature($user) ? $user['aid'] : 0;
        }
    }
    /**
     * 增加管理员
     */
    public static function add($admin_username,$admin_pwd_salt='',$admin_pwd,$admin_email='',$admin_tel='',$admin_open=0,$admin_realname='',$group_id=1)
    {
        $admin_pwd_salt=$admin_pwd_salt?:random(10);
        $sldata=array(
            'admin_username'=>$admin_username,
            'admin_pwd_salt' => $admin_pwd_salt,
            'admin_pwd'=>encrypt_password($admin_pwd,$admin_pwd_salt),
            'admin_email'=>$admin_email,
            'admin_tel'=>$admin_tel,
            'admin_open'=>$admin_open,
            'admin_realname'=>$admin_realname,
            'admin_ip'=>request()->ip(),
            'admin_addtime'=>time(),
            'admin_changepwd'=>time(),
        );
        $admin=self::create($sldata);
        if($admin){
            //添加管理组
            $admin_id=$admin['admin_id'];
            $accdata=array(
                'uid'=>$admin_id,
                'group_id'=>$group_id,
            );
            Db::name('auth_group_access')->insert($accdata);
            //添加会员
            $member_id=MemberList::add($admin_username,$admin_pwd_salt,$admin_pwd,1,$admin_realname,$admin_email,$admin_tel,1,1);
            //修改admin对应member_id
            if($member_id) self::update(['admin_id' =>$admin_id, 'member_id' =>$member_id]);
            return $admin_id;
        }else{
            return 0;
        }
    }
    /**
     * 修改管理员
     * @param array
     * @return bool
     */
    public static function edit($data)
    {
        $admin=self::get($data['admin_id'])->toArray();
        $admin['admin_username']=$data['admin_username'];
        $admin['admin_email']=$data['admin_email'];
        $admin['admin_tel']=$data['admin_tel'];
        $admin['admin_realname']=$data['admin_realname'];
        $admin['admin_open']=$data['admin_open'];
        if($data['admin_pwd']){
            $admin['admin_pwd_salt']=random(10);
            $admin['admin_pwd']=encrypt_password($data['admin_pwd'],$admin['admin_pwd_salt']);
            $admin['admin_changepwd']=time();
        }
        $rst=self::where('admin_id',$data['admin_id'])->update($admin);
        if($rst!==false){
            $access=Db::name('auth_group_access')->where('uid',$data['admin_id'])->find();
            if($access){
                //修改
                if($access['group_id']!=$data['group_id']){
                    Db::name('auth_group_access')->where('uid',$data['admin_id'])->setField('group_id',$data['group_id']);
                }
            }else{
                //增加
                $access['uid']=$data['admin_id'];
                $access['group_id']=$data['group_id'];
                Db::name('auth_group_access')->insert($access);
            }
            return true;
        }else{
            return false;
        }
    }
}
