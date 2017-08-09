<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------

namespace app\common\model;

use think\Model;

/**
 * 插件模型
 */
class Addon extends Model
{
    protected $autoWriteTimestamp = true;

    public function setConfigAttr($value)
    {
        return $value?json_encode($value):'';
    }
    public function setAdminActionsAttr($value)
    {
        return $value?json_encode($value):'';
    }
    /**
     * 获取所有插件信息
     * @return array|bool
     */
    public function getAll()
    {
        $result = cache('addon_all');
        if (!$result) {
            // 获取插件目录下的所有插件目录
            $dirs = array_map('basename', glob(ADDON_PATH.'*', GLOB_ONLYDIR));
            if ($dirs === false || !file_exists(ADDON_PATH)) {
                $this->error = '插件目录不可读或者不存在';
                return false;
            }
            $dirs=array_map('ucfirst',$dirs);
            // 读取数据库插件表
            $addons = self::order('sort asc,id desc')->column('*', 'name');
            // 读取未安装的插件
            foreach ($dirs as $addon) {
                if (!isset($addons[$addon])) {
                    $addons[$addon]['name'] = $addon;
                    // 获取插件类名
                    $class = get_addon_class($addon);
                    // 插件类不存在则跳过实例化
                    if (!class_exists($class)) {
                        $addons[$addon]['status'] = '-2';
                        continue;
                    }
                    // 实例化插件
                    $obj = new $class;
                    // 插件插件信息缺失
                    if (!isset($obj->info) || empty($obj->info) || !$this->checkInfo($obj->info)) {
                        // 插件信息缺失！
                        $addons[$addon]['status'] = '-2';
                        continue;
                    }
                    // 插件未安装
                    $addons[$addon] = $obj->info;
                    $addons[$addon]['status'] = '-1';

                }
            }
            // 处理插件按钮
            foreach ($addons as &$addon) {
                switch ($addon['status']) {
                    case '-2':
                        $addon['actions'] = '<button class="btn btn-xs btn-inverse" type="button" disabled>不可操作</button>';
                        break;
                    case '-1': // 未安装
                        $addon['actions'] = '<a class="btn btn-xs btn-success rst-url-btn" href="'.url('admin/Addons/install', ['name' => $addon['name']]).'">安装</a>';
                        break;
                    case '0': // 禁用
                        $addon['admin_actions']=json_decode($addon['admin_actions'],true);
                        $addon['actions'] = '<a class="btn btn-xs btn-success rst-url-btn" href="'.url('admin/Addons/enable', ['id' => $addon['id']]).'">启用</a> ';
                        $addon['actions'] .= '<a class="btn btn-xs btn-danger confirm-rst-url-btn" data-info="如果包括数据库，将同时删除数据库！确认?" href="'.url('uninstall', ['name' => $addon['name']]).'">卸载</a> ';
                        if (isset($addon['config']) && $addon['config'] != '' && $addon['admin_actions']['config']) {
                            if(count($addon['admin_actions']['config'])==2){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['config'][0],$addon['name'].'://'.$addon['admin_actions']['config'][1]);
                            }elseif(count($addon['admin_actions']['config'])==1){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['config'][0]);
                            }else{
                                $url='';
                            }
                            if($url){
                                $addon['actions'] .= '<a class="btn btn-xs btn-info" href="'.$url.'">设置</a> ';
                            }
                        }
                        if ($addon['admin'] != '0' && $addon['admin_actions']['index']) {
                            if(count($addon['admin_actions']['index'])==2){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['index'][0],$addon['name'].'://'.$addon['admin_actions']['index'][1]);
                            }elseif(count($addon['admin_actions']['index'])==1){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['index'][0]);
                            }else{
                                $url='';
                            }
                            $addon['actions'] .= '<a class="btn btn-xs btn-primary" href="'.$url.'">管理</a> ';
                        }
                        break;
                    case '1': // 启用
                        $addon['admin_actions']=json_decode($addon['admin_actions'],true);
                        $addon['actions'] = '<a class="btn btn-xs btn-yellow rst-url-btn" href="'.url('admin/Addons/disable', ['id' => $addon['id']]).'">禁用</a> ';
                        $addon['actions'] .= '<a class="btn btn-xs btn-danger confirm-rst-url-btn" data-info="如果包括数据库，将同时删除数据库！确认?" href="'.url('uninstall', ['name' => $addon['name']]).'">卸载</a> ';
                        if (isset($addon['config']) && $addon['config'] != '' && $addon['admin_actions']['config']) {
                            if(count($addon['admin_actions']['config'])==2){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['config'][0],$addon['name'].'://'.$addon['admin_actions']['config'][1]);
                            }elseif(count($addon['admin_actions']['config'])==1){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['config'][0]);
                            }else{
                                $url='';
                            }
                            if($url){
                                $addon['actions'] .= '<a class="btn btn-xs btn-info" href="'.$url.'">设置</a> ';
                            }
                        }
                        if ($addon['admin'] != '0' && $addon['admin_actions']['index']) {
                            if(count($addon['admin_actions']['index'])==2){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['index'][0],$addon['name'].'://'.$addon['admin_actions']['index'][1]);
                            }elseif(count($addon['admin_actions']['index'])==1){
                                $url=addon_url($addon['name'].'://'.$addon['admin_actions']['index'][0]);
                            }else{
                                $url='';
                            }
                            $addon['actions'] .= '<a class="btn btn-xs btn-primary" href="'.$url.'">管理</a> ';
                        }
                        break;
                    default: // 未知
                        $addon['actions'] = '';
                        break;
                }
            }
            $result=$addons;
            cache('addon_all', $result);
        }
        return $result;
    }

    /**
     * 检查插件插件信息是否完整
     * @param array $info 插件插件信息
     * @return bool
     */
    private function checkInfo($info = [])
    {
        $default_item = ['name','title','author','version'];
        foreach ($default_item as $item) {
            if (!isset($info[$item]) || $info[$item] == '') {
                return false;
            }
        }
        return true;
    }

    /**
     * 获取插件配置
     * @param string $addon_name 插件名称
     * @param string $item 指定返回的插件配置项,多个配置项,隔开
     * @return array|mixed
     */
    public function getConfig($addon_name = '', $item = '')
    {
        $config = cache('addon_config_'.$addon_name);
        if (!$config) {
            $config = self::where('name', $addon_name)->value('config');
            if (!$config) {
                return [];
            }
            $config = json_decode($config, true);
            cache('addon_config_'.$addon_name, $config);
        }
        if ($item) {
            $items = explode(',', $item);
            if (count($items) == 1) {
                return isset($config[$item]) ? $config[$item] : '';
            }

            $result = [];
            foreach ($items as $item) {
                $result[$item] = isset($config[$item]) ? $config[$item] : '';
            }
            return $result;
        }
        return $config;
    }

    /**
     * 设置插件配置
     * @param string $addon_name 插件名.配置名
     * @param string $value 配置值
     * @return bool
     */
    public static function setConfig($addon_name = '', $value = '')
    {
        $item = '';
        if (strpos($addon_name, '.')) {
            list($addon_name, $item) = explode('.', $addon_name);
        }
        $config = cache('addon_config_'.$addon_name);
        if (!$config) {
            $config = self::where('name', $addon_name)->value('config');
            if (!$config) {
                return false;
            }
            $config = json_decode($config, true);
        }
        if ($item === '') {
            // 批量更新
            if (!is_array($value) || empty($value)) {
                // 值的格式错误，必须为数组
                return false;
            }
            $config = array_merge($config, $value);
        } else {
            // 更新单个值
            $config[$item] = $value;
        }
        if (false === self::where('name', $addon_name)->setField('config', json_encode($config))) {
            return false;
        }
        //更新缓存
        cache('addon_config_'.$addon_name, $config);
        return true;
    }
}