<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/13
 * Time: 15:13
 */

namespace app\service\controller;

use app\service\model\RepairOrderModel;
use Exception;
use Firebase\JWT\JWT;
use think\Db;
use tree\XTree;

class CommonController extends BaseController {

    public function getRegion() {
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

    public function getRepairList() {
//        $authinfo = apache_request_headers();
//        $key = base64_encode(config('jwt_key'));
//        try {
//            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
//            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $page=input('page');
                $model = new RepairOrderModel();
//                $result = $model->getRepairList($userInfo['id']);
                $result = $model->getRepairList(1,$page);
                if ($result) {
                    return json(['code' => 200,
                        'message' => '获取报修列表成功',
                        'result' => $result,
                        'row' => count($result)]);
                } else {
                    return json(['code' => 400,
                        'message' => '没有数据']);
                }
            }
//        } catch (Exception $e) {
//            header('HTTP/1.0 401 Unauthorized');
//            die('Service API authentication failed');
//        }
    }
}