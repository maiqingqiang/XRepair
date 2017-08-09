<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\home\controller;

use think\Db;

class Oauth extends Base
{
	
	public function login($type = null,$redirect = null)
    {
		empty($type) && $this->error(lang('parameter error'));
		if(!empty($redirect)){session('login_http_referer',$redirect);}
		$sns  = \thinksdk\ThinkOauth::getInstance($type);
		if(request()->isMobile()){
			$sns->setDisplay('mobile');
		}
		$this->redirect($sns->getRequestCodeURL());
	}

	public function callback($type = null, $code = null)
    {
		(empty($type)) && $this->error(lang('parameter error'));
		if(empty($code)){
			$this->redirect(__ROOT__."/");
		}	
		$sns  = \thinksdk\ThinkOauth::getInstance($type);
		$extend = null;
		if($type == 'tencent'){
			$extend = array('openid' => input("openid"), 'openkey' => input("openkey"));
		}
		$ignore_stat = true;  //验证stat 防刷
		$token = $sns->getAccessToken($code , $extend);
		//获取当前登录用户信息
		if(is_array($token)){
			$user_info = $sns->userinfo();
			$oauth_bang_s=session('oauth_bang');
			if($oauth_bang_s){
				$this->_bang_handle($user_info, $type, $token);
				
			}else{
				$this->_login_handle($user_info, $type, $token);
				
			}
		}else{
			$this->success(lang('login failed'),$this->_get_login_redirect());
		}
	}

    public function bang($type="")
    {
		if(session('hid')){
			empty($type) && $this->error(lang('parameter error'));
			$sns  = \thinksdk\ThinkOauth::getInstance($type);
			session('oauth_bang',1);
			$this->redirect($sns->getRequestCodeURL());
		}else{
			$this->error(lang('not logged'));
		}
		
		
	}
	
	private function _get_login_redirect()
    {
		$login_http_referer_s=session('login_http_referer');
		return empty($login_http_referer_s)?__ROOT__."/":$login_http_referer_s;
	}
	
	//绑定第三方账号
	private function _bang_handle($user_info, $type, $token)
    {
		$current_uid=session('hid');
		$type=strtolower($type);
		$oauth_id=($type=='wechat' || $type=='weixin')?'unionid':'openid';
		$find_oauth_user = Db::name('OauthUser')->where(array("oauth_from"=>$type,$oauth_id=>$token[$oauth_id]))->find();
		$need_bang=true;
		if($find_oauth_user){
			if($find_oauth_user['uid']==$current_uid){
				session('oauth_bang',null);
				$this->error(lang('bound already'),url('home/Center/bang'));exit;
			}else{
				session('oauth_bang',null);
				$this->error(lang('bound other account'),url('home/Center/bang'));exit;
			}
		}
		
		if($need_bang){
			if($current_uid){
				//第三方用户表中创建数据
				$new_oauth_user_data = array(
						'oauth_from' => $type,
						'name' => $user_info['name'],
						'head_img' => $user_info['head'],
						'create_time' =>time(),
						'uid' => $current_uid,
						'last_login_time' => time(),
						'last_login_ip' => request()->ip(),
						'login_times' => 1,
						'user_status' => 1,
						'access_token' => $token['access_token'],
						'expires_date' => (int)(time()+$token['expires_in']),
						$oauth_id => $token[$oauth_id],
				);
				$new_oauth_user_data['openid']=$user_info['openid'];
				$new_oauth_user_id=Db::name('OauthUser')->insertGetId($new_oauth_user_data);
				if($new_oauth_user_id){
					session('oauth_bang',null);
					$this->success(lang('bind success'),url('home/Center/bang'));
				}else{
					session('oauth_bang',null);
					$this->error(lang('bind failed'),url('home/Center/bang'));
				}
			}else{
				session('oauth_bang',null);
				$this->error(lang('bind failed'),url('home/Center/bang'));
			}
		}
	}
	
	//登陆
	private function _login_handle($user_info, $type, $token)
    {
		$type=strtolower($type);
		$oauth_id=($type=='wechat' || $type=='weixin')?'unionid':'openid';
		$find_oauth_user = Db::name('OauthUser')->where(array("oauth_from"=>$type,$oauth_id=>$token[$oauth_id]))->find();
		$need_register=true;
		if($find_oauth_user){
			//更新第三方表
			$data=array(
				'last_login_time' => time(),
				'last_login_ip' => request()->ip(),
				'access_token' => $token['access_token'],
				'expires_date' => (int)(time()+$token['expires_in']),
				'name' => $user_info['name'],
				'head_img' => $user_info['head'],
			);
			Db::name('OauthUser')->where(array("oauth_from"=>$type,$oauth_id=>$token[$oauth_id]))->update($data);
			$find_user = Db::name("member_list")->where(array("member_list_id"=>$find_oauth_user['uid']))->find();
			if($find_user){
				$need_register=false;
				if($find_user['member_list_open']==0){
					$this->error(lang('user disabled'),$this->_get_login_redirect());
				}
				//更新字段
				$data = array(
					'last_login_time' => time(),
					'last_login_ip' => request()->ip(),
				);
				Db::name("member_list")->where(array('member_list_id'=>$find_user["member_list_id"]))->update($data);
				session('hid',$find_user['member_list_id']);
				session('user',$find_user);
				
				//根据需要决定是否同步后台登录状态
				$admin=Db::name('admin')->where('member_id',$find_user["member_list_id"])->find();
                if($admin){
                    // 记录登录
                    $auth = array(
                        'aid'             			 => $admin['admin_id'],
                        'admin_avatar'    			 => $admin['admin_avatar'],
                        'admin_last_change_pwd_time' => $admin['admin_changepwd'],
                        'admin_realname'       		 => $admin['admin_realname'],
                        'admin_username'          	 => $admin['admin_username'],
                        'member_id'        			 => $admin['member_id'],
                        'admin_last_ip' 			 => $admin['admin_last_ip'],
                        'admin_last_time'   		 => $admin['admin_last_time']
                    );
                    session('admin_auth', $auth);
                    session('admin_auth_sign', data_signature($auth));
                }
				
				$this->redirect($this->_get_login_redirect());
			}else{
				$need_register=true;
			}
		}
		
		if($need_register){
			//本地用户中创建对应一条数据
			$new_user_data = array(
					'member_list_username' => $user_info['name'],
					'member_list_nickname' => $user_info['name'],
					'member_list_headpic' => $user_info['head'],
					'member_list_addtime' => time(),
					'member_list_groupid'=>1,
					'member_list_sex'=>3,
					'member_list_open'=>1,
					'member_list_from'=>$type,
					'last_login_time' => time(),
					'last_login_ip' => request()->ip(),
					'user_status'=>1,//第三方默认已激活
			);
			$users_model=Db::name("member_list");
			$new_user_id = Db::name("member_list")->insertGetId($new_user_data);
			$new_user_data=Db::name("member_list")->find($new_user_id);
			if($new_user_id){
				//第三方用户表中创建数据
				$new_oauth_user_data = array(
					'oauth_from' => $type,
					'name' => $user_info['name'],
					'head_img' => $user_info['head'],
					'create_time' =>time(),
					'uid' => $new_user_id,
					'last_login_time' => time(),
					'last_login_ip' => request()->ip(),
					'login_times' => 1,
					'user_status' => 1,
					'access_token' => $token['access_token'],
					'expires_date' => (int)(time()+$token['expires_in']),
					$oauth_id => $token[$oauth_id],
				);
				$new_oauth_user_data['openid']=$user_info['openid'];
				$new_oauth_user_id=Db::name("OauthUser")->insertGetId($new_oauth_user_data);
				if($new_oauth_user_id){
					session('hid',$new_user_id);
					session('user',$new_user_data);
					$this->redirect($this->_get_login_redirect());
				}else{
					$users_model->where(array("member_list_id"=>$new_user_id))->delete();
					$this->error(lang('login failed'),$this->_get_login_redirect());
				}
			}else{
				$this->error(lang('login failed'),$this->_get_login_redirect());
			}
			
		}
	}
}