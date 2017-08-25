<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/25
 * Time: 21:58
 */

namespace app\xrepair\controller;

use cmf\controller\AdminBaseController;

class MyOrderController extends AdminBaseController{
    public function index(){
        $repairLists = $this->field('id,type,create_time,update_time,order_time,complete_time,status,feedback')->where('user_id', '=', $user_id)->page($page, 10)->order(['create_time' => 'desc',
            'id' => 'desc'])->select()->toArray();
        foreach ($repairLists as $key => $val) {
            switch ($val['type']) {
                case 'general':
                    $repairLists[$key]['data'] = Db::view('GeneralOrder', 'name,mobile,region,desc')->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name)' => 'address'], 'FIND_IN_SET(RepairRegion.id,GeneralOrder.region)', 'LEFT')->view('GeneralCategory', ['GROUP_CONCAT(distinct GeneralCategory.name)' => 'cate'], 'FIND_IN_SET(GeneralCategory.id,GeneralOrder.category)', 'LEFT')->where('oid', '=', $val['id'])->group('GeneralOrder.id')->find();
                    break;
                case 'net':
                    $repairLists[$key]['data'] = Db::view('NetOrder', 'name,account,mobile,desc')->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name)' => 'address'], 'FIND_IN_SET(RepairRegion.id,NetOrder.region)', 'LEFT')->view('NetOperator', ['name' => 'operator'], 'NetOperator.id=NetOrder.operator_id', 'LEFT')->where('oid', '=', $val['id'])->group('NetOrder.id')->find();
                    break;
            }
        }
    }
}