<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/13
 * Time: 17:28
 */

namespace app\service\controller;

use app\service\model\RepairOrderModel;
use Exception;
use Firebase\JWT\JWT;
use think\Db;
use think\Model;
use think\Validate;
use tree\XTree;

class GeneralController extends BaseController {
    public function getCategory() {
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

    public function addOrder() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $validate = new Validate(['name' => 'require',
                    'mobile' => 'require|length:11',
                    'regions' => 'require',
                    'categorys' => 'require',
                    'desc' => 'require',]);
                $validate->message(['name.require' => '姓名不能为空',
                    'mobile.require' => '手机号码不能为空',
                    'mobile.length' => '手机号码长度为11位',
                    'regions.require' => '请选择区域',
                    'categorys.require' => '请选择报修类型',
                    'desc.require' => '故障描述不能为空']);

                $data = request()->post();
                if (!$validate->check($data)) {
                    return json(['code' => 400,
                        'message' => $validate->getError()]);
                }

                $order = ['name' => $data['name'],
                    'type'=>'general',
                    'mobile' => $data['mobile'],
                    'region' => implode(',', $data['regions']),
                    'category' => implode(',', $data['categorys']),
                    'desc' => $data['desc'],
                    'create_time' => time(),
                    'update_time' => time(),
                    'user_id' => $userInfo['id']];


                $model = new RepairOrderModel();


                $orderId = $model->addGeneralOrder($order);

                if ($orderId) {
                    return json(['code' => 200,
                        'message' => '提交成功',
                        'result' => $orderId]);
                } else {
                    return json(['code' => 400,
                        'message' => '提交失败']);
                }
            } else {
                return json(['code' => 500,
                    'message' => '请求错误']);
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function test(){
//        $result = Db::view('RepairOrder','*')
//            ->view('GeneralOrder','name,mobile,region,category,desc','GeneralOrder.oid=RepairOrder.id and RepairOrder.type="general"')
//            ->view('NetOrder','name,mobile,desc','NetOrder.oid=RepairOrder.id and RepairOrder.type="net"')
//            ->select();
//        $result=Db::field('*')
//            ->name('RepairOrder')
//            ->union(function($query){
//                $query->field('name,mobile,region,category,desc')->name('GeneralOrder')->where('RepairOrder.id = GeneralOrder.oid');
//            })
//            ->union(function($query){
//                $query->field('name,desc,op')->name('NetOrder')->where('RepairOrder.id = NetOrder.oid');
//            })
//            ->select();

    }
}