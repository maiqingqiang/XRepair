<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/13
 * Time: 17:28
 */
namespace app\service\controller;

use think\Db;
use tree\XTree;

class GeneralController extends BaseController{
    public function getCategory(){
        $where = ['delete_time' => 0];
        $result = Db::name('general_category')->order("list_order ASC")->where($where)->select()->toArray();
        if ($result) {
            $tree = new XTree();
            $tree->init($result);
            $list = $tree->getTreeArray(0);

            return json(['code' => 200,
                'message' => '获取报修类型成功',
                'result' => $list]);
        } else {
            return json(['code' => 400,
                'message' => '获取报修类型失败']);
        }
    }
}