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

class Center extends Base
{
	protected function _initialize()
    {
		parent::_initialize();
		$this->check_login();
	}
	public function index()
    {
		$this->assign($this->user);
		return $this->view->fetch('user:center');
    }
    //编辑用户资料
	public function edit()
    {
		$province = Db::name('Region')->where ( array('pid'=>1) )->select ();
		$city=Db::name('Region')->where ( array('pid'=>$this->user['member_list_province']) )->select ();
		$town=Db::name('Region')->where ( array('pid'=>$this->user['member_list_city']) )->select ();
		$this->assign('province',$province);
		$this->assign('city',$city);
		$this->assign('town',$town);
		$this->assign($this->user);
		return $this->view->fetch('user:edit');
    }
    public function runedit()
    {
    	if(request()->isPost()){
			$post=input('post.');
			$rst=Db::name('member_list')->where(array('member_list_id'=>$this->user['member_list_id']))->update($post);
			if ($rst!==false) {
				$this->user=Db::name('member_list')->find($this->user['member_list_id']);
				session('user',$this->user);
				$this->success(lang('save success'),url("home/Center/edit"));
			} else {
				$this->error(lang('save failed'));
			}
    	}
    }
	//修改密码
	public function password()
    {
		$this->assign($this->user);
		return $this->view->fetch('user:password');
    }
	public function runchangepwd()
    {
    	if (request()->isPost()) {
			$old_password=input('old_password');
    		$password=input('password');
			$repassword=input('repassword');
    		if(empty($old_password)){
    			$this->error(lang('old pwd empty'));
    		}
    		if(empty($password)){
    			$this->error(lang('new pwd empty'));
    		}
			if($password!==$repassword){
    			$this->error(lang('pwd not same'));
    		}
			$member=Db::name('member_list');
    		$user=$member->where(array('member_list_id'=>$this->user['member_list_id']))->find();
			$member_list_salt=$user['member_list_salt'];
    		if(encrypt_password($old_password,$member_list_salt)===$user['member_list_pwd']){
				if(encrypt_password($password,$member_list_salt)==$user['member_list_pwd']){
					$this->error(lang('new pwd the same as old pwd'));
				}else{
					$data['member_list_pwd']=encrypt_password($password,$member_list_salt);
					$data['member_list_id']=$this->user['member_list_id'];
					$rst=$member->update($data);
					if ($rst!==false) {
						$this->success(lang('revise success'),url('home/Center/index'));
					} else {
						$this->error(lang('revise failed'));
					}
				}
    		}else{
    			$this->error(lang('old pwd not correct'));
    		}
    	}
    }
	public function avatar()
    {
        $imgurl=input('imgurl');
        //去'/'
        $imgurl=str_replace('/','',$imgurl);
        $rst=Db::name('member_list')->where(array('member_list_id'=>$this->user['member_list_id']))->update(array('member_list_headpic'=>$imgurl));
        if($rst!==false){
            session('user_avatar',$imgurl);
			$this->user['member_list_headpic']=$imgurl;
			$url='/data/upload/avatar/'.$imgurl;
			//写入数据库
			$data['uptime']=time();
			$data['filesize']=filesize('./'.$url);
			$data['path']=$url;
			Db::name('plug_files')->insert($data);
            $this->success (lang('avatar update success'),url('home/Center/index'));
        }else{
            $this->error (lang('avatar update failed'),url('home/Center/index'));
        }
    }
    public function bang()
    {
    	$oauth_user_model=Db::name("OauthUser");
    	$oauths=$oauth_user_model->where(array("uid"=>$this->user['member_list_id']))->select();
    	$new_oauths=array();
    	foreach ($oauths as $oa){
    		$new_oauths[strtolower($oa['oauth_from'])]=$oa;
    	}
    	$this->assign("oauths",$new_oauths);
		return $this->view->fetch('user:bang');
    }
    public function fav()
    {
		$favorites_model=Db::name("favorites");
        $favorites=$favorites_model->alias("a")->join(config('database.prefix').'news b','a.t_id =b.n_id')->where(array('uid'=>$this->user['member_list_id']))->order('a.id asc')->paginate(config('paginate.list_rows'));
		$show=$favorites->render();
		$this->assign('page',$show);
		$this->assign("favorites",$favorites);
		return $this->view->fetch('user:favorite');
	}
    public function delete_favorite()
    {
        $id=input("id",0,"intval");
        $p=input("p",1,"intval");
        $favorites_model=Db::name("favorites");
        $result=$favorites_model->where(array('id'=>$id,'uid'=>$this->user['member_list_id']))->delete();
        if($result){
            $this->success(lang('cancel collection success'),url('home/Center/fav',array('p'=>$p)));
        }else {
            $this->error(lang('cancel collection failed'));
        }
    }
}
