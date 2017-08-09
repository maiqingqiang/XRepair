<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------

use think\Hook;
use think\Config;
use think\Loader;
use think\Cache;
use think\Route;
use think\Db;

// 定义插件目录
define('ADDON_PATH', ROOT_PATH . 'addons' . DS);

// 定义路由
Route::any('addons/execute/:route', "\\think\\addons\\Base@execute");

// 如果插件目录不存在则创建
if (!is_dir(ADDON_PATH)) {
    @mkdir(ADDON_PATH, 0777, true);
}

// 注册类的根命名空间
Loader::addNamespace('addons', ADDON_PATH);

// 闭包初始化行为
Hook::add('action_begin', function () {
    // 插件相关数据表
    if(!Config::get('addons_sql') && file_exists(ROOT_PATH.'data/install.lock')){
        install_sql();
        sys_config_setbykey('addons_sql',true);
    }elseif(!file_exists(ROOT_PATH.'data/install.lock')){
		sys_config_setbykey('addons_sql',false);
    }
    //所有有效钩子-插件
    $hook_addons = Cache::get('hook_addons');
    if (empty($hook_addons) && Config::get('addons_sql')) {
        $hook_addons=Db::name('hook_addon')->alias('a')
            ->join(Config::get('database.prefix').'hook b','a.hook =b.name')
            ->join(Config::get('database.prefix').'addon c','a.addon =c.name')
            ->where('a.status&b.status&c.status', 1)
            ->column('a.addon','a.hook');
        Cache::set('hook_addons', $hook_addons);
    }
    if($hook_addons){
        foreach ($hook_addons as $key=>$value) {
            Hook::add($key, get_addon_class($value));
        }
    }
});

function install_sql()
{
    $db=Db::connect(Config::get('database'),true);
    //hook钩子数据表
    if(!db_is_valid_table_name('hook')){
        $sql="CREATE TABLE IF NOT EXISTS `".Config::get('database.prefix')."hook` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `name` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子名称',
            `addon` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子来自哪个插件',
            `description` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子描述',
            `system` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否为系统钩子',
            `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
            `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
            `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
            PRIMARY KEY (`id`)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='钩子表' AUTO_INCREMENT=1 ;";
        $db->execute($sql);
    }
    //addon插件数据表
    if(!db_is_valid_table_name('addon')){
        $sql="CREATE TABLE IF NOT EXISTS `".Config::get('database.prefix')."addon` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `name` varchar(32) NOT NULL DEFAULT '' COMMENT '插件名称',
            `title` varchar(32) NOT NULL DEFAULT '' COMMENT '插件标题',
            `icon` varchar(64) NOT NULL DEFAULT '' COMMENT '图标',
            `description` text NOT NULL COMMENT '插件描述',
            `author` varchar(32) NOT NULL DEFAULT '' COMMENT '作者',
            `author_url` varchar(255) NOT NULL DEFAULT '' COMMENT '作者主页',
            `config` text NOT NULL COMMENT '配置信息',
			`admin_actions` text COMMENT '管理操作',
            `version` varchar(16) NOT NULL DEFAULT '' COMMENT '版本号',
            `identifier` varchar(64) NOT NULL DEFAULT '' COMMENT '插件唯一标识符',
            `admin` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理',
            `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
            `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
            `sort` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
            `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
            PRIMARY KEY (`id`)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='插件表' AUTO_INCREMENT=1 ;";
        $db->execute($sql);
    }
    //hook_addon钩子-插件数据表
    if(!db_is_valid_table_name('hook_addon')){
        $sql="CREATE TABLE IF NOT EXISTS `".Config::get('database.prefix')."hook_addon` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `hook` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子id',
            `addon` varchar(32) NOT NULL DEFAULT '' COMMENT '插件标识',
            `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
            `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
            `sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '排序',
            `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
            PRIMARY KEY (`id`)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='钩子-插件对应表' AUTO_INCREMENT=1 ;";
        $db->execute($sql);
    }
}

/**
 * 处理插件钩子
 * @param string $hook 钩子名称
 * @param mixed $params 传入参数
 * @return void
 */
function hook($hook, $params = [])
{
    Hook::listen($hook, $params);
}

/**
 * 获取插件类的类名
 * @param string $name 插件名
 * @param string $type 返回命名空间类型
 * @param string $class 当前类名
 * @return string
 */
function get_addon_class($name, $type = 'hook', $class = null)
{
    $name = Loader::parseName($name);
    // 处理多级控制器情况
    if (!is_null($class) && strpos($class, '.')) {
        $class = explode('.', $class);
        foreach ($class as $key => $cls) {
            $class[$key] = Loader::parseName($cls, 1);
        }
        $class = implode('\\', $class);
    } else {
        $class = Loader::parseName(is_null($class) ? $name : $class, 1);
    }
    switch ($type) {
        case 'controller':
            $namespace = "\\addons\\" . $name . "\\controller\\" . $class;
            break;
        default:
            $namespace = "\\addons\\" . $name . "\\" . $class;
    }

    return class_exists($namespace) ? $namespace : '';
}

/**
 * 获取插件类的配置文件数组
 * @param string $name 插件名
 * @return array
 */
function get_addon_config($name)
{
    $class = get_addon_class($name);
    if (class_exists($class)) {
        $addon = new $class();
        return $addon->getConfig();
    } else {
        return [];
    }
}

/**
 * 插件显示内容里生成访问插件的url
 * @param $url
 * @param array $param
 * @return bool|string
 * @param bool|string $suffix 生成的URL后缀
 * @param bool|string $domain 域名
 */
function addon_url($url, $param = [], $suffix = true, $domain = false)
{
    $url = parse_url($url);
    $case = Config::get('url_convert');
    $addons = $case ? Loader::parseName($url['scheme']) : $url['scheme'];
    $controller = $case ? Loader::parseName($url['host']) : $url['host'];
    $action = trim($case ? strtolower($url['path']) : $url['path'], '/');

    /* 解析URL带的参数 */
    if (isset($url['query'])) {
        parse_str($url['query'], $query);
        $param = array_merge($query, $param);
    }

    // 生成插件链接新规则
    $actions = "{$addons}-{$controller}-{$action}";

    return url("addons/execute/{$actions}", $param, $suffix, $domain);
}