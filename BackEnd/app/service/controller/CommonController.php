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
use app\service\model\UserModel;
use Exception;
use Firebase\JWT\JWT;
use think\Db;
use think\Validate;
use tree\XTree;

class CommonController extends BaseController {


    /**
     * 获取区域
     * @return \think\response\Json
     */
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

    /**
     * 获取报修列表
     * @return \think\response\Json
     */
    public function getRepairList() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $page = input('page');
                $model = new RepairOrderModel();
                $result = $model->getRepairList($userInfo['id'], $page);
                //                $result = $model->getRepairList(1, $page);
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
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    /**
     * 获取报修次数
     * @return \think\response\Json
     */
    public function getRepairCount() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            $model = new RepairOrderModel();
            $result = $model->getRepairCount($userInfo['id']);
            if ($result) {
                return json(['code' => 200,
                    'message' => '获取报修列表成功',
                    'result' => $result]);
            } else {
                return json(['code' => 400,
                    'message' => '没有数据']);
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function getRepairDetails() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $id = input('id');
                $model = new RepairOrderModel();
                $result = $model->getRepairDetails($id);
                //            $result = $model->getRepairDetails($id, 1);
                if ($result) {
                    return json(['code' => 200,
                        'message' => '获取报修列表成功',
                        'result' => $result]);
                } else {
                    return json(['code' => 400,
                        'message' => '没有数据']);
                }
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function updateUserInfo() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $rules = ['name' => 'require|min:2|chs',
                    'email' => 'require|email',
                    'mobile' => 'require|length:11'];
                $validate = new Validate($rules);
                $validate->message(['name.require' => '姓名不能为空',
                    'name.min' => '真是姓名不能小于2个字符',
                    'name.chs' => '真是姓名只能为中文',
                    'email.require' => '邮箱不能为空',
                    'email.email' => '真是姓名只能为中文',
                    'mobile.require' => '手机号码不能为空',
                    'mobile.length' => '手机号码长度只能为11位']);
                $model = new UserModel();

                $data = request()->post();

                if (array_key_exists('mobile', $data)) {
                    $data['mobile'] = str_replace(' ', '', $data['mobile']);
                }

                if (!$validate->check($data)) {
                    return json(['code' => 400,
                        'message' => $validate->getError()]);
                }
                $result = $model->updateUserInfo($userInfo['id'], $data);
                if ($result) {
                    return json(['code' => 200,
                        'message' => '更新成功']);
                } else {
                    return json(['code' => 400,
                        'message' => '更新失败']);
                }
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function changePassword() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $rules = ['old_password' => 'require',
                    'password' => 'require|min:5|confirm|different:old_password'];

                $validate = new Validate($rules);
                $validate->message(['old_password.require' => '原密码不能为空',
                    'password.require' => '新密码不能为空',
                    'password.min' => '新密码不能小于5个字符',
                    'password.confirm' => '两个密码不一样',
                    'password.different' => '新密码不能于原密码相同']);
                $data = request()->post();
                if (!$validate->check($data)) {
                    return json(['code' => 400,
                        'message' => $validate->getError()]);
                }

                $model = new UserModel();
                $result = $model->updatePassword($userInfo['id'], $data);

                switch ($result) {
                    case 1:
                        return json(['code' => 200,
                            'message' => '修改密码成功']);
                        break;
                    case 2:
                        return json(['code' => 400,
                            'message' => '修改密码失败']);
                        break;
                    case 3:
                        return json(['code' => 400,
                            'message' => '原密码不正确']);
                        break;
                    case 4:
                        header('HTTP/1.0 401 Unauthorized');
                        die('非法操作');
                        break;
                }

            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function updateToken() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            $result = Db::name('User')->where('id', $userInfo['id'])->find();

            $data = ['id' => $result['id'],
                'name' => $result['user_nickname'],
                'account' => $result['user_login'],
                'email' => $result['user_email'],
                'mobile' => $result['mobile'],
                'isAdmin' => $result['user_type'] == 1 ? 1 : 0];

            $result = $this->getLoginInfo($data);

            if ($result) {
                return json(['code' => 200,
                    'message' => '更新token',
                    'result' => $result]);
            } else {
                header('HTTP/1.0 401 Unauthorized');
                die('系统错误');
            }
        } catch (Exception $e) {
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }

    public function cancelOrder() {
        $authinfo = apache_request_headers();
        $key = base64_encode(config('jwt_key'));
        try {
            $payload = JWT::decode($authinfo['Authorization'], $key, array('HS256'));
            $userInfo = object_array($payload->data);
            if (request()->isPost()) {
                $id = input('id');
                $model = new RepairOrderModel();
                $result = $model->where(['id' => $id,
                    'user_id' => $userInfo['id']])->update(['status' => -1,
                    'update_time' => time()]);
                if ($result) {
                    return json(['code' => 200,
                        'message' => '撤销成功']);
                } else {
                    return json(['code' => 400,
                        'message' => '撤销失败']);
                }
            }
        } catch (Exception $e) {
            echo $e->getMessage();
            header('HTTP/1.0 401 Unauthorized');
            die('Service API authentication failed');
        }
    }
}