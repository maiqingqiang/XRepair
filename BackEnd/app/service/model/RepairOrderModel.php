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

    public function getRepairList(){

        $data=Db::field('*')
            ->name('RepairOrder')
            ->union(function($query){
                $query->field('name,mobile,region,category,desc')->name('GeneralOreder')->where('RepairOrder.id = GeneralOreder.oid');
            })
            ->union(function($query){
                $query->field('name,desc,op')->name('NetOreder')->where('RepairOrder.id = NetOreder.oid');
            })
            ->select();
        dump($data);
    }

}