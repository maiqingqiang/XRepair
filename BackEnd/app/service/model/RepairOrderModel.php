<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/15
 * Time: 23:00
 */

namespace app\service\model;

use think\Db;
use think\Model;

class RepairOrderModel extends Model {

    protected $autoWriteTimestamp = true;

    public function addGeneralOrder($data) {
        self::startTrans();
        try {
            $this->allowField(true)->save($data);
            $data['id'] = $this->id;
            $generalOrderModel = new GeneralOrderModel();
            $generalOrderModel->allowField(true)->save($data);
            self::commit();

            return $data['id'];
        } catch (\Exception $e) {
            self::rollback();

            return false;
        }
    }

    public function getRepairList($user_id) {

        $repairLists = $this->where('user_id','=',$user_id)->select()->toArray();
        foreach ($repairLists as $key => $val) {
            switch ($val['type']) {
                case 'general':
                    $repairLists[$key]['data'] = Db::view('GeneralOrder', 'name,mobile,region,desc')->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name)' => 'address'], 'FIND_IN_SET(RepairRegion.id,GeneralOrder.region)', 'LEFT')->view('GeneralCategory', ['GROUP_CONCAT(distinct GeneralCategory.name)' => 'cate'], 'FIND_IN_SET(GeneralCategory.id,GeneralOrder.category)', 'LEFT')->where('oid', '=', $val['id'])->group('GeneralOrder.id')->find();
                    break;
                case 'net':
                    $repairLists[$key]['data'] = Db::view('NetOrder', 'name,mobile,desc')->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name)' => 'address'], 'FIND_IN_SET(RepairRegion.id,NetOrder.region)', 'LEFT')->view('NetOperator', ['name' => 'operator'], 'NetOperator.id=NetOrder.operator_id', 'LEFT')->where('oid', '=', $val['id'])->group('NetOrder.id')->find();
                    break;
            }
        }

        return $repairLists;
    }

}