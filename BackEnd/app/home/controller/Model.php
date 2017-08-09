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

class Model extends Base
{
    //模型内页
    public function index()
    {
		//内容id
		$id=input('id');
		//栏目id
		$cid=input('cid');
		$menu=Db::name('menu')->find($cid);
		$tplname=$menu['menu_newstpl'];
    	$tplname=$tplname?$tplname:'news';
		$model=Db::name('model')->find($menu['menu_modelid']);
		$data=Db::name($model['model_name'])->find($id);
		if(empty($data)){
		    $this->error(lang('operation not valid'));
		}
		$this->assign($data);
		return $this->view->fetch(":$tplname");
    }
}
