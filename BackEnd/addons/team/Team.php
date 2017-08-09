<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace addons\team;

use think\Addons;

/**
 * 显示团队
 */
class Team extends Addons
{
    public $info = [
        'name' => 'Team',
        'title' => '团队&贡献者',
        'description' => '后台首页团队&贡献者显示',
        'status' => 0,
        'author' => 'rainfer',
        'version' => '0.1',
        'admin'=>'0'
    ];

    /**
     * @var array 插件钩子
     */
    public $hooks = [
        // 钩子名称 => 钩子说明
        'team'=>'团队钩子'
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
     * 实现的team钩子方法
     * @return mixed
     */
    public function team()
    {
        $config=$this->getConfig();
		if($config['display']) return $this->fetch('team');
    }
}
