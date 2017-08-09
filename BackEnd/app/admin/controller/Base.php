<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\common\controller\Common;
use app\admin\model\AuthRule;

class Base extends Common 
{
	public function _initialize()
	{
        parent::_initialize();
 		if(!$this->check_admin_login()) $this->redirect('admin/Login/login');//未登录
 		$auth=new AuthRule;
		$id_curr=$auth->get_url_id();
        if(!$auth->check_auth($id_curr)) $this->error('没有权限',url('admin/Index/index'));
		//获取有权限的菜单tree
		$menus=$auth->get_admin_menus();
		$this->assign('menus',$menus);
		//当前方法倒推到顶级菜单ids数组
		$menus_curr=$auth->get_admin_parents($id_curr);
		$this->assign('menus_curr',$menus_curr);
		//取当前操作菜单父节点下菜单 当前菜单id(仅显示状态)
        $menus_child=$auth->get_admin_parent_menus($id_curr);
		$this->assign('menus_child',$menus_child);
		$this->assign('id_curr',$id_curr);
		$this->assign('admin_avatar',session('admin_auth.admin_avatar'));
	}
}