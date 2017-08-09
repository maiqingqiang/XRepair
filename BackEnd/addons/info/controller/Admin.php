<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace addons\info\controller;

use think\addons\Base;
use app\common\model\Addon as AddonModel;

class Admin extends Base
{
	protected function _initialize()
	{
		//调用admin/Base控制器的初始化
		action('admin/Base/_initialize');
	}
	/*
	 * 设置
	 */
	public function config()
	{
        $model=new AddonModel;
	    if(request()->isAjax()){
		    $display=input('display',0,'intval');
            $rst=$model->setConfig('info.display',$display);
            if($rst){
                $this->success('更新设置成功',url('admin/Addons/addons_list'));
            }else{
                $this->error('更新设置失败',url('admin/Addons/addons_list'));
            }
        }else{
		    $config=$model->getConfig('info');
		    $this->assign('config',$config);
            return $this->fetch();
        }
	}
}