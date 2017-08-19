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

    /**
     * 添加通用报修单
     *
     * @param $data array 报修信息
     *
     * @return bool|mixed
     */
    public function addGeneralOrder($data) {
        self::startTrans();
        try {
            $this->allowField(true)->save($data);
            $data['oid'] = $this->id;
            $generalOrderModel = new GeneralOrderModel();
            $generalOrderModel->allowField(true)->save($data);
            self::commit();

            return $data['oid'];
        } catch (\Exception $e) {
            self::rollback();

            return false;
        }
    }

    /**
     * 查询报修
     *
     * @param $user_id int 用户id
     * @param $page    int 页码
     *
     * @return array
     */
    public function getRepairList($user_id, $page) {

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

        return $repairLists;
    }

    /**
     * 统计报修次数
     *
     * @param $user_id int 用户id
     *
     * @return int|string
     */
    public function getRepairCount($user_id) {
        return $this->where('user_id', '=', $user_id)->count();
    }

    /**
     * 获取报修详情
     * @param $oid int 报修id
     * @param $user_id int 用户id
     *
     * @return array|false|\PDOStatement|string|Model
     */
    public function getRepairDetails($oid, $user_id) {
//        $result = $this->field('id,type,create_time,update_time,order_time,complete_time,status,feedback')->where(['id' => $oid,
//            'user_id' => $user_id])->find();

        $result = Db::view('RepairOrder','id,type,create_time,update_time,order_time,complete_time,status,feedback')
            ->view('User',['user_nickname'=>'repairer_name','mobile'=>'repairer_mobile'],'RepairOrder.repairer_id=User.id','LEFT')
            ->where(['id' => $oid, 'user_id' => $user_id])
            ->find();

        switch ($result['type']) {
            case 'general':
                $general = Db::view('GeneralOrder', 'name,mobile,region,desc')->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name)' => 'address'], 'FIND_IN_SET(RepairRegion.id,GeneralOrder.region)', 'LEFT')->view('GeneralCategory', ['GROUP_CONCAT(distinct GeneralCategory.name)' => 'cate'], 'FIND_IN_SET(GeneralCategory.id,GeneralOrder.category)', 'LEFT')->where('oid', '=', $result['id'])->group('GeneralOrder.id')->find();
                $result=array_merge($result,$general);
                break;
            case 'net':
                $net = Db::view('NetOrder', 'name,account,mobile,desc')->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name)' => 'address'], 'FIND_IN_SET(RepairRegion.id,NetOrder.region)', 'LEFT')->view('NetOperator', ['name' => 'operator'], 'NetOperator.id=NetOrder.operator_id', 'LEFT')->where('oid', '=', $result['id'])->group('NetOrder.id')->find();
                $result=array_merge($result,$net);
                break;
        }

        return $result;
    }

}