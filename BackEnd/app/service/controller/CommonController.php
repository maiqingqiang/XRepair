<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/13
 * Time: 15:13
 */

namespace app\service\controller;

use think\Db;
use tree\XTree;

class CommonController extends BaseController {

    public function getRegion() {
        if (strtoupper(request()->method()) == 'OPTIONS') {
            die('welcome to XRepair');
        }
        $where = ['delete_time' => 0];
        $result = Db::name('repair_region')->order("list_order ASC")->where($where)->select()->toArray();
        if ($result) {
            $tree = new XTree();
            $tree->init($result);
            $list = $tree->getTreeArray(0);

            return json(['code' => 200,
                'message' => '获取区域成功',
                'result' => $list]);
        } else {
            return json(['code' => 400,
                'message' => '获取区域失败']);
        }

    }
}