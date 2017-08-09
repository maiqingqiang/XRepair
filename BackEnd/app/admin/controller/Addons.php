<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use think\Db;
use app\common\model\Addon as AddonModel;
use app\common\model\HookAddon as HookAddonModel;

/**
 * 插件后台管理页面
 */
class Addons extends Base
{
    /**
     * 插件列表
     */
    public function addons_list()
    {
        $addons_model=new AddonModel;
        $addons=$addons_model->getAll();
        $this->assign('addons',$addons);
        return $this->fetch();
    }

    /**
     * 安装插件
     */
    public function install()
    {
        $addon_name = input('name','');
        if ($addon_name == '') $this->error('插件不存在！');

        $addon_class = get_addon_class($addon_name);
        if (!class_exists($addon_class)) $this->error('插件不存在！');

        // 实例化插件
        $addon = new $addon_class;
        // 插件预安装
        if(!$addon->install()) $this->error('插件预安装失败!'. $addon->getError());

        // 添加钩子
        if (isset($addon->hooks) && $addon->hooks) {
            if (!HookAddonModel::addHooks($addon->hooks, $addon_name)) {
                $this->error('安装插件钩子时出现错误');
            }
            cache('hook_addons', null);
        }
        // 执行安装插件sql文件
        $sql_file = realpath(ADDON_PATH.$addon_name.'/install.sql');
        if (file_exists($sql_file)) {
            if (isset($addon->database_prefix) && $addon->database_prefix != '') {
                db_restore_file($sql_file,$addon->database_prefix);
            } else {
                db_restore_file($sql_file);
            }
        }

        // 插件配置信息
        $addon_info = $addon->info;
        if(!$addon->checkInfo()) $this->error('插件信息不完整');
        // 并入插件配置值
        $addon_info['config'] = $addon->getConfig();

        //插件管理操作
        if(property_exists($addon,'admin_actions')){
            $addon_info['admin_actions']=$addon->admin_actions;
        }
        // 将插件信息写入数据库
        if (AddonModel::create($addon_info)) {
            cache('addon_all',null);
            $this->success('插件安装成功');
        } else {
            $this->error('插件安装失败');
        }
    }

    /**
     * 卸载插件
     */
    public function uninstall()
    {
        $addon_name = input('name','');
        if ($addon_name == '') $this->error('插件不存在！');

        $class = get_addon_class($addon_name);
        if (!class_exists($class)) $this->error('插件不存在！');

        // 实例化插件
        $addon = new $class;
        // 插件预卸
        if(!$addon->uninstall()) {
            $this->error('插件预卸载失败!原因：'. $addon->getError());
        }

        // 卸载插件自带钩子
        if (isset($addon->hooks) && $addon->hooks) {
            if (false === HookAddonModel::deleteHooks($addon_name)) {
                $this->error('卸载插件钩子时出现错误');
            }
            cache('hook_addons', null);
        }

        // 执行卸载插件sql文件
        $sql_file = realpath(config('plugin_path').$addon_name.'/uninstall.sql');
        if (file_exists($sql_file)) {
            if (isset($addon->database_prefix) && $addon->database_prefix != '') {
                db_restore_file($sql_file,$addon->database_prefix);
            } else {
                db_restore_file($sql_file);
            }
        }
        $addon_model=new AddonModel;
        // 删除插件信息
        if ($addon_model->where('name', $addon_name)->delete()) {
            cache('addon_all', null);
            $this->success('插件卸载成功');
        } else {
            $this->error('插件卸载失败');
        }
    }
    /**
     * 禁用插件
     */
    public function disable()
    {
        $id=input('id');
        if (empty($id)){
            $this->error('插件不存在',url('admin/Addons/addons_list'));
        }
        $rst=Db::name('addon')->where('id',$id)->setField('status',0);
        if($rst!==false){
            cache('addon_all',null);
            cache('hook_addons',null);
            $this->success('禁用成功',url('admin/Addons/addons_list'));
        }else{
            $this->error('禁用失败',url('admin/Addons/addons_list'));
        }
    }
    /**
     * 启用插件
     */
    public function enable()
    {
        $id=input('id');
        if (empty($id)){
            $this->error('插件不存在',url('admin/Addons/addons_list'));
        }
        $rst=Db::name('addon')->where('id',$id)->setField('status',1);
        if($rst!==false){
            cache('addon_all',null);
            cache('hook_addons',null);
            $this->success('启用成功',url('admin/Addons/addons_list'));
        }else{
            $this->error('启用失败',url('admin/Addons/addons_list'));
        }
    }
    /**
     * 插件排序
     */
    public function addons_order()
    {
        $list=[];
        foreach (input('post.') as $id => $sort){
            $list[]=['id'=>$id,'sort'=>$sort];
        }
        $model=new AddonModel;
        $model->saveAll($list);
        cache('addon_all',null);
        $this->success('排序成功',url('admin/Addons/addons_list'));
    }
}
