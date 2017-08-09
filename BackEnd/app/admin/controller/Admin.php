<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\model\Admin as AdminModel;
use app\admin\model\AuthRule;
use think\Db;
use think\Cache;

class Admin extends Base
{
	/**
	 * 管理员列表
	 */
	public function admin_list()
	{
		$search_name=input('search_name');
		$this->assign('search_name',$search_name);
		$map=array();
		if($search_name){
			$map['admin_username']= array('like',"%".$search_name."%");
		}
		$admin_list=Db::name('admin')->where($map)->order('admin_id')->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
		$page = $admin_list->render();
		$this->assign('admin_list',$admin_list);
		$this->assign('page',$page);
		return $this->fetch();
	}
	/**
	 * 管理员添加
	 */
	public function admin_add()
	{
		$auth_group=Db::name('auth_group')->select();
		$this->assign('auth_group',$auth_group);
		return $this->fetch();
	}
	/**
	 * 管理员添加操作
	 */
	public function admin_runadd()
	{
		$admin_id=AdminModel::add(input('admin_username'),'',input('admin_pwd'),input('admin_email',''),input('admin_tel',''),input('admin_open',0),input('admin_realname',''),input('group_id'));
		if($admin_id){
			$this->success('管理员添加成功',url('admin/Admin/admin_list'));
		}else{
			$this->error('管理员添加失败',url('admin/Admin/admin_list'));
		}
	}
	/**
	 * 管理员修改
	 */
	public function admin_edit()
	{
		$auth_group=Db::name('auth_group')->select();
		$admin_list=Db::name('admin')->find(input('admin_id'));
		$auth_group_access=Db::name('auth_group_access')->where(array('uid'=>$admin_list['admin_id']))->value('group_id');
		$this->assign('admin_list',$admin_list);
		$this->assign('auth_group',$auth_group);
		$this->assign('auth_group_access',$auth_group_access);
		return $this->fetch();
	}
	/**
	 * 管理员修改操作
	 */
	public function admin_runedit()
	{
		$data=input('post.');
		$rst=AdminModel::edit($data);
		if($rst!==false){
			$this->success('管理员修改成功',url('admin/Admin/admin_list'));
		}else{
			$this->error('管理员修改失败',url('admin/Admin/admin_list'));
		}
	}
	/**
	 * 管理员删除
	 */
	public function admin_del()
	{
		$admin_id=input('admin_id');
		if (empty($admin_id)){
			$this->error('用户ID不存在',url('admin/Admin/admin_list'));
		}
		//对应会员ID
		$member_id=Db::name('admin')->where('admin_id',$admin_id)->value('member_id');
		Db::name('admin')->delete($admin_id);
		//删除对应会员
		if($member_id){
			Db::name('member_list')->delete($member_id);
		}
		$rst=Db::name('auth_group_access')->where('uid',$admin_id)->delete();
		if($rst!==false){
			$this->success('管理员删除成功',url('admin/Admin/admin_list'));
		}else{
			$this->error('管理员删除失败',url('admin/Admin/admin_list'));
		}
	}
	/**
	 * 管理员开启/禁止
	 */
	public function admin_state()
	{
		$id=input('x');
		if (empty($id)){
			$this->error('用户ID不存在',url('admin/Admin/admin_list'));
		}
		$status=Db::name('admin')->where('admin_id',$id)->value('admin_open');//判断当前状态情况
		if($status==1){
			$statedata = array('admin_open'=>0);
			Db::name('admin')->where('admin_id',$id)->setField($statedata);
			$this->success('状态禁止');
		}else{
			$statedata = array('admin_open'=>1);
			Db::name('admin')->where('admin_id',$id)->setField($statedata);
			$this->success('状态开启');
		}
	}
	/**
	 * 用户组列表
	 */
	public function admin_group_list()
	{
		$auth_group=Db::name('auth_group')->select();
		$this->assign('auth_group',$auth_group);
		return $this->fetch();
	}
	/**
	 * 用户组添加
	 */
	public function admin_group_add()
	{
		return $this->fetch();
	}
	/**
	 * 用户组添加操作
	 */
	public function admin_group_runadd()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Admin/admin_group_list'));
		}else{
			$sldata=array(
				'title'=>input('title'),
				'status'=>input('status',0),
				'addtime'=>time(),
			);
			$rst=Db::name('auth_group')->insert($sldata);
			if($rst!==false){
				$this->success('用户组添加成功',url('admin/Admin/admin_group_list'));
			}else{
				$this->error('用户组添加失败',url('admin/Admin/admin_group_list'));
			}
		}
	}
	/**
	 * 用户组删除操作
	 */
	public function admin_group_del()
	{
		$rst=Db::name('auth_group')->delete(input('id'));
		if($rst!==false){
			$this->success('用户组删除成功',url('admin/Admin/admin_group_list'));
		}else{
			$this->error('用户组删除失败',url('admin/Admin/admin_group_list'));
		}
	}
	/**
	 * 用户组编辑
	 */
	public function admin_group_edit()
	{
		$group=Db::name('auth_group')->find(input('id'));
		$this->assign('group',$group);
		return $this->fetch();
	}
	/**
	 * 用户组编辑操作
	 */
	public function admin_group_runedit()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Admin/admin_group_list'));
		}else{
			$sldata=array(
				'id'=>input('id'),
				'title'=>input('title'),
				'status'=>input('status'),
			);
			Db::name('auth_group')->update($sldata);
			$this->success('用户组修改成功',url('admin/Admin/admin_group_list'));
		}
	}
	/**
	 * 用户组开启/禁用
	 */
	public function admin_group_state()
	{
		$id=input('x');
		$status=Db::name('auth_group')->where('id',$id)->value('status');//判断当前状态情况
		if($status==1){
			$statedata = array('status'=>0);
			Db::name('auth_group')->where('id',$id)->setField($statedata);
			$this->success('状态禁止');
		}else{
			$statedata = array('status'=>1);
			Db::name('auth_group')->where('id',$id)->setField($statedata);
			$this->success('状态开启');
		}
	}
	/**
	 * 权限配置
	 */
	public function admin_group_access()
	{
		$admin_group=Db::name('auth_group')->where(array('id'=>input('id')))->find();
		$data=AuthRule::get_ruels_tree();
		$this->assign('admin_group',$admin_group);
		$this->assign('datab',$data);
		return $this->fetch();
	}
	/**
	 * 权限配置保存
	 */
	public function admin_group_runaccess()
	{
		$new_rules = input('new_rules/a');
		$imp_rules = implode(',', $new_rules);
		$sldata=array(
			'id'=>input('id'),
			'rules'=>$imp_rules,
		);
		if(Db::name('auth_group')->update($sldata)!==false){
			Cache::clear();
			$this->success('权限配置成功',url('admin/Admin/admin_group_list'));
		}else{
			$this->error('权限配置失败',url('admin/Admin/admin_group_list'));
		}
	}
	/*
	 * 管理员信息
	 */
	public function profile()
	{
		$admin=array();
		if(session('admin_auth.aid')){
			$admin=Db::name('admin')->alias("a")->join(config('database.prefix').'auth_group_access b','a.admin_id =b.uid')
					->join(config('database.prefix').'auth_group c','b.group_id = c.id')
					->where(array('a.admin_id'=>session('admin_auth.aid')))->find();
			$news_count=Db::name('News')->where(array('news_auto'=>session('admin_auth.member_id')))->count();
			$admin['news_count']=$news_count;
		}
		$this->assign('admin', $admin);
		return $this->fetch();
	}
	/*
	 * 管理员头像
	 */
	public function avatar()
	{
		$imgurl=input('imgurl');
		//去'/'
		$imgurl=str_replace('/','',$imgurl);
		$url='/data/upload/avatar/'.$imgurl;
		$state=false;
		if(config('storage.storage_open')){
			//七牛
			$upload = \Qiniu::instance();
			$info = $upload->uploadOne('.'.$url,"image/");
			if ($info) {
				$state=true;
				$imgurl= config('storage.domain').$info['key'];
				@unlink('.'.$url);
			}
		}
		if($state !=true){
			//本地
			//写入数据库
			$data['uptime']=time();
			$data['filesize']=filesize('.'.$url);
			$data['path']=$url;
			Db::name('plug_files')->insert($data);
		}
		$admin=Db::name('admin')->where(array('admin_id'=>session('admin_auth.aid')))->find();
		$admin['admin_avatar']=$imgurl;
		$rst=Db::name('admin')->where(array('admin_id'=>session('admin_auth.aid')))->update($admin);
		if($rst!==false){
			session('admin_avatar',$imgurl);
			$this->success ('头像更新成功',url('admin/Admin/profile'));
		}else{
			$this->error ('头像更新失败',url('admin/Admin/profile'));
		}
	}
}