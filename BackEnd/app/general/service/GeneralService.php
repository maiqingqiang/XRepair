<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 老猫 <thinkcmf@126.com>
// +----------------------------------------------------------------------
namespace app\general\service;

use think\Db;

class GeneralService
{

    public function repairList($filter){

        $where="RepairOrder.type = 'general'";

        $category = empty($filter['category']) ? 0 : intval($filter['category']);
        if (!empty($category)) {
            $where.=' and FIND_IN_SET('.$category.',GeneralOrder.category)';
        }


        $region = empty($filter['region']) ? 0 : intval($filter['region']);
        if (!empty($region)) {
            $where.=' and FIND_IN_SET('.$region.',GeneralOrder.region)';
        }

        $name = empty($filter['name']) ? 0 : intval($filter['name']);
        if (!empty($name)) {
            $where.=' and like %'.$name.'%';
        }

        $startTime = empty($filter['start_time']) ? 0 : strtotime($filter['start_time']);
        $endTime   = empty($filter['end_time']) ? 0 : strtotime($filter['end_time']);
        if (!empty($startTime) && !empty($endTime)) {
            $where.=' and RepairOrder.create_time >='.$startTime.' and RepairOrder.create_time <='.$endTime;
        } else {
            if (!empty($startTime)) {
                $where.=' and RepairOrder.create_time >='.$startTime;
            }
            if (!empty($endTime)) {
                $where.=' and RepairOrder.create_time <='.$endTime;
            }
        }


        $result = Db::view('RepairOrder','id,type,create_time,update_time,order_time,complete_time,status,feedback')
            ->view('User',['user_nickname'=>'repairer_name','mobile'=>'repairer_mobile'],'RepairOrder.repairer_id=User.id','LEFT')
            ->view('GeneralOrder', 'name,mobile,region,desc','GeneralOrder.oid = RepairOrder.id','LEFT')
            ->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name ORDER BY RepairRegion.id ASC)' => 'address'], 'FIND_IN_SET(RepairRegion.id,GeneralOrder.region)', 'LEFT')
            ->view('GeneralCategory', ['GROUP_CONCAT(distinct GeneralCategory.name ORDER BY GeneralCategory.id ASC)' => 'cate'], 'FIND_IN_SET(GeneralCategory.id,GeneralOrder.category)', 'LEFT')
            ->where($where)->order('create_time','DESC')->group('GeneralOrder.id')->paginate(10);

        return $result;
    }

}