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
use app\common\model\Hook as HookModel;

/**
 * 钩子-插件模型
 * @package app\admin\model
 */
class HookAddon extends Model
{
    protected $autoWriteTimestamp = true;

    /**
     * 启用插件钩子
     * @param string $addon_name 插件名称
     * @return bool
     */
    public static function enable($addon_name = '')
    {
        return self::where('addon', $addon_name)->setField('status', 1);
    }

    /**
     * 禁用插件钩子
     * @param string $addon_name 插件名称
     * @return int
     */
    public static function disable($addon_name = '')
    {
        return self::where('addon', $addon_name)->setField('status', 0);
    }

    /**
     * 添加钩子-插件对照
     * @param array $hooks 钩子
     * @param string $addon_name 插件名称
     * @return bool
     */
    public static function addHooks($hooks = [], $addon_name = '')
    {
        if ($hooks && is_array($hooks)) {
            // 添加钩子
            if (!HookModel::addHooks($hooks, $addon_name)) {
                return false;
            }
            $data=[];
            foreach ($hooks as $name => $description) {
                if (is_numeric($name)) {
                    $name = $description;
                }
                $data[] = [
                    'hook'        => $name,
                    'addon'      => $addon_name,
                    'create_time' => request()->time(),
                    'update_time' => request()->time(),
                ];
            }
            return self::insertAll($data);
        }
        return false;
    }

    /**
     * 删除钩子
     * @param string $addon_name 钩子名称
     * @return bool
     */
    public static function deleteHooks($addon_name = '')
    {
        if ($addon_name) {
            // 删除钩子
            if (!HookModel::deleteHooks($addon_name)) {
                return false;
            }
            if (false === self::where('addon', $addon_name)->delete()) {
                return false;
            }
        }
        return true;
    }
}