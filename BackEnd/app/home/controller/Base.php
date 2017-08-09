<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\home\controller;

use app\common\controller\Common;
use app\admin\model\Options;
use think\Db;

class Base extends Common
{
	protected $view;
	protected $user;
	protected $yf_theme_path;
	protected function _initialize()
    {
        parent::_initialize();
		//主题
		$site_options=Options::get_options('site_options',$this->lang);
        $site_options['site_tongji']=htmlspecialchars_decode($site_options['site_tongji']);
        $site_options['site_copyright']=htmlspecialchars_decode($site_options['site_copyright']);
        if(request()->isMobile()){
            $theme=$site_options['site_tpl_m']?:$site_options['site_tpl'];
        }else{
            $theme=$site_options['site_tpl'];
        }
		$this->view=$this->view->config('view_path',APP_PATH.request()->module().'/view/'.$theme.'/');
		$yf_theme_path=__ROOT__.'/app/home/view/'.$theme.'/';
		$this->assign($site_options);
		$this->assign('yf_theme_path',$yf_theme_path);
		$address='';
		$this->user=array();
		$uid=session('hid');
		if(empty($uid)){
			//检测cookies
			$cookie = cookie('yf_logged_user');//'id'.'时间'
			$cookie = explode(".", jiemi($cookie));
			$uid=empty($cookie[0])?0:$cookie[0];
			if($uid && !empty($cookie[1])){
				//判断是否存在此用户
				$member=Db::name("member_list")->find($uid);
				if($member && (time()-intval($cookie[1]))<config('cookie.expire')){
					//更新字段
					$data = array(
						'last_login_time' => time(),
						'last_login_ip' => request()->ip(),
					);
					Db::name("member_list")->where(array('member_list_id'=>$member["member_list_id"]))->update($data);
					$member['last_login_time']=$data['last_login_time'];
					$member['last_login_ip']=$data['last_login_ip'];
					//设置session
					session('hid',$member['member_list_id']);
					session('user',$member);
				}
			}
		}
		$is_admin=false;
		if(session('hid')){
			$this->user=Db::name('member_list')->find(session('hid'));
			if(!empty($this->user['member_list_province'])){
				$rst=Db::name('region')->field('name')->find($this->user['member_list_province']);
				$address.=$rst?$rst['name'].lang('province'):'';
			}
			if(!empty($this->user['member_list_city'])){
				$rst=Db::name('region')->field('name')->find($this->user['member_list_city']);
				$address.=$rst?$rst['name'].lang('city'):'';
			}
			if(!empty($this->user['member_list_town'])){
				$rst=Db::name('region')->field('name')->find($this->user['member_list_town']);
				$address.=$rst?$rst['name']:'';
			}
			//判断是否为管理员
			$admin=Db::name('admin')->where('member_id',$this->user['member_list_id'])->find();
			if($admin){
				$is_admin=true;
			}
		}
		$this->user['address']=$address;
		$this->assign("user",$this->user);
		$this->assign("is_admin",$is_admin);
	}
	/**
	 * 检查用户登录
	 */
	protected function check_login()
    {
		if(!session('hid')){
			$this->error(lang('not logged'),__ROOT__."/");
		}
	}
	/**
	 * 检查操作频率
	 * @param int $t_check 距离最后一次操作的时长
	 */
	protected function check_last_action($t_check)
    {
		$action=MODULE_NAME."-".CONTROLLER_NAME."-".ACTION_NAME;
		$time=time();
		$action_s=session('last_action.action');
		if(!empty($action_s) && $action=$action_s){
			$t=$time-session('last_action.time');
			if($t_check>$t){
				$this->error(lang('frequent operation'));
			}else{
				session('last_action.time',$time);
			}
		}else{
			session('last_action.action',$action);
			session('last_action.time',$time);
		}
	}
}