<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace addons\info;

use think\Addons;

/**
 * 后台首页信息显示
 */
class Info extends Addons
{
    public $info = [
        'name' => 'Info',
        'title' => '后台信息',
        'description' => '后台首页信息显示',
        'status' => 1,
        'author' => 'rainfer',
        'version'=> '0.1',
        'admin'  => '0',//是否有管理页面
    ];

    /**
     * @var string 原数据库表前缀
     * 用于在导入插件sql时，将原有的表前缀转换成系统的表前缀
     * 一般插件自带sql文件时才需要配置
     */
    public $database_prefix = '';

    /**
     * @var array 插件钩子
     */
    public $hooks = [
        // 钩子名称 => 钩子说明
        'gitinfo'=>'git信息钩子',
        'sysinfo' => '框架信息钩子'
    ];

    /**
     * @var array 插件管理方法,格式:['控制器/操作方法',[参数数组]])
     */
    public $admin_actions = [
        'index'=>[],//管理首页
        'config'=>['Admin/config'],//设置页
        'edit' => [],//编辑页
        'add'=>[],//增加页
    ];

    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {
        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {
        return true;
    }

    /**
     * 实现的gitinfo钩子方法
     * @return mixed
     */
    public function gitinfo()
    {
        $config=$this->getConfig();
		if($config['display']) return $this->fetch('gitinfo');
    }
	    /**
     * 实现的sysinfo钩子方法
     * @return mixed
     */
    public function sysinfo()
    {
        $config=$this->getConfig();
		if($config['display']){
			//系统信息
			$info = array(
				'PCTYPE'=>PHP_OS,
				'RUNTYPE'=>$_SERVER["SERVER_SOFTWARE"],
				'ONLOAD'=>ini_get('upload_max_filesize'),
				'ThinkPHPTYE'=>THINK_VERSION,
			);
			$this->assign('info',$info);
			//版本
			$ver_curr=substr(config('yfcmf_version'),1);
			$update_check=config('update_check');
			$this->assign('update_check',$update_check);
			$ver_str='';
			$ver_last='';
			if($update_check){
				//版本检查
				$version=cache('ver_last');
				if(empty($version)){
					$version = checkVersion();
					cache('ver_last',$version);
				}
				$ver_last=substr($version,1);
				if(version_compare($ver_curr,$ver_last)===-1){
					$ver_str='最新版本V'.$ver_last;
				}else{
					$ver_str='已经是最新版本';
					$ver_last='';
				}
			}
			$this->assign('ver_str',$ver_str);
			$this->assign('ver_last',$ver_last);
			return $this->fetch('sysinfo');
		}
    }
}