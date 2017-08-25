<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/20
 * Time: 21:12
 */

namespace app\service\controller;

use app\general\service\GeneralService;
use app\service\model\RepairOrderModel;
use Exception;
use Firebase\JWT\JWT;
use think\Db;

class AdminController extends BaseController {
    public function getGeneralRepair() {
        $param = request()->param();

        $postService = new GeneralService();
        $data = $postService->repairListApi($param);

        if ($data) {
            return json(['code' => 200,
                'message' => '获取成功',
                'result' => $data]);
        } else {
            return json(['code' => 300,
                'message' => '获取失败']);
        }
    }

    public function orderGeneralRepair() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $id = input('id');
                $result = Db::name('RepairOrder')->where(['id' => ['in',
                    $id],
                    'status' => 0])->update(['status' => 1,
                    'repairer_id' => $userInfo['id'],
                    'order_time' => time(),
                    'update_time' => time()]);
                if ($result) {
                    return json(['code' => 200,
                        'message' => '接单成功']);
                } else {
                    return json(['code' => 400,
                        'message' => '接单失败']);
                }
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function getMyGeneralOrder() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $param = request()->param();

                $postService = new GeneralService();
                $data = $postService->myOrderListApi($param, $userInfo['id']);

                if ($data) {
                    return json(['code' => 200,
                        'message' => '获取成功',
                        'result' => $data]);
                } else {
                    return json(['code' => 300,
                        'message' => '获取失败']);
                }
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function feedback() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $param = request()->param();
                $result = Db::name('RepairOrder')->where(['id' => $param['id'],
                    'repairer_id' => $userInfo['id'],
                    'status' => 2])->update(['feedback' => $param['feedback'],
                    'update_time' => time()]);
                if ($result) {
                    return json(['code' => 200,
                        'message' => '反馈成功']);
                } else {
                    return json(['code' => 400,
                        'message' => '反馈失败']);
                }
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function complete() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $id = input('id');
                $result = Db::name('RepairOrder')->where(['id' => $id,
                    'repairer_id' => $userInfo['id'],
                    'status' => 1])->update(['status' => 2,
                    'complete_time' => time(),
                    'update_time' => time()]);

                if ($result) {
                    return json(['code' => 200,
                        'message' => '完成']);
                } else {
                    return json(['code' => 400,
                        'message' => '完成失败']);
                }
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }

    }
}