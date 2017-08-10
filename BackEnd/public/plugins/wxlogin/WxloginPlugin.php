<?php
// +----------------------------------------------------------------------
// | Wxlogin [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 Tangchao All rights reserved.
// +----------------------------------------------------------------------
// | Author: Tangchao <79300975@qq.com>
// +----------------------------------------------------------------------
namespace plugins\wxlogin;
use cmf\lib\Plugin;

class WxloginPlugin extends Plugin
{

    public $info = array(
        'name'        => 'Wxlogin',
        'title'       => '微信登录',
        'description' => '微信登录',
        'status'      => 1,
        'author'      => 'Tangchao',
        'version'     => '1.0'
    );

    public $hasAdmin = 0;//插件是否有后台管理界面

    public function install()
    {
        return true;
    }

    public function uninstall()
    {
        return true;
    }

    public function footerStart($param)
    {
        echo $this->fetch('scripts');
    }

}