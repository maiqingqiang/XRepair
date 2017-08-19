<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/19
 * Time: 20:12
 */

namespace app\general\controller;

use app\general\model\GeneralCategoryModel;
use app\general\service\GeneralService;
use app\xrepair\model\RepairRegionModel;
use cmf\controller\AdminBaseController;
use think\Db;

class IndexController extends AdminBaseController {
    public function index() {
        $param = $this->request->param();

        $regionId = $this->request->param('region', 0, 'intval');
        $categoryId = $this->request->param('category', 0, 'intval');

        $postService = new GeneralService();
        $data = $postService->repairList($param);

        $data->appends($param);

        $generalCategoryModel = new GeneralCategoryModel();
        $categoryTree = $generalCategoryModel->adminCategoryTree($categoryId);

        $repairRegionModel = new RepairRegionModel();

        $regionTree = $repairRegionModel->adminCategoryTree($regionId);

        $this->assign('start_time', isset($param['start_time']) ? $param['start_time'] : '');
        $this->assign('end_time', isset($param['end_time']) ? $param['end_time'] : '');
        $this->assign('name', isset($param['name']) ? $param['name'] : '');
        $this->assign('list', $data->items());
        $this->assign('category_tree', $categoryTree);
        $this->assign('region_tree', $regionTree);
        $this->assign('category', $categoryId);
        $this->assign('region', $regionId);
        $this->assign('page', $data->render());

        //        dump($data->items());
        return $this->fetch();
    }

    public function order() {

        $ids = $this->request->param('ids/a');

        $result = Db::name('RepairOrder')->where(['id' => ['in',
            $ids],
            'status' => 0])->update(['status' => 1,
            'repairer_id' => cmf_get_current_admin_id(),
            'order_time' => time(),
            'update_time' => time()]);
        if ($result) {
            $this->success("接单成功！", '');
        } else {
            $this->success("接单失败！", '');

        }
    }

    public function feedback() {
        $param = $this->request->param();
        $result = Db::name('RepairOrder')->where(['id' => $param['id'],
            'repairer_id' => cmf_get_current_admin_id(),
            'status' => 2])->update(['feedback' => $param['feedback'],
            'update_time' => time()]);
        if ($result) {
            $this->success("反馈成功！", '');
        } else {
            $this->success("反馈失败！", '');

        }
    }

    public function complete() {

        $ids = $this->request->param('ids/a');

        $result = Db::name('RepairOrder')->where(['id' => ['in',
            $ids],
            'repairer_id' => cmf_get_current_admin_id(),
            'status' => 1])->update(['status' => 2,
            'complete_time' => time(),
            'update_time' => time()]);

        if ($result) {
            $this->success("完成订单！", '');
        } else {
            $this->success("完成失败！", '');
        }

    }

    public function details() {

        $id = input('id');
        if ($id) {
            $result = Db::view('RepairOrder', 'id,type,create_time,update_time,order_time,complete_time,status,feedback')
                ->view('User', ['user_nickname' => 'repairer_name', 'mobile' => 'repairer_mobile'], 'RepairOrder.repairer_id=User.id', 'LEFT')
                ->view('GeneralOrder', 'name,mobile,region,desc', 'GeneralOrder.oid = RepairOrder.id', 'LEFT')
                ->view('RepairRegion', ['GROUP_CONCAT(distinct RepairRegion.name ORDER BY RepairRegion.id ASC)' => 'address'], 'FIND_IN_SET(RepairRegion.id,GeneralOrder.region)', 'LEFT')
                ->view('GeneralCategory', ['GROUP_CONCAT(distinct GeneralCategory.name ORDER BY GeneralCategory.id ASC)' => 'cate'], 'FIND_IN_SET(GeneralCategory.id,GeneralOrder.category)', 'LEFT')
                ->where('RepairOrder.id', $id)
                ->find();
            $this->assign('result', $result);
            return $this->fetch();
        } else {
            $this->error("非法操作！", '');
        }
    }
}