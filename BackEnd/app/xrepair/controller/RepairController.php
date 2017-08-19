<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/13
 * Time: 14:20
 */

namespace app\xrepair\controller;

use app\xrepair\model\RepairRegionModel;
use cmf\controller\AdminBaseController;
use think\Db;

class RepairController extends AdminBaseController{
    public function index(){
        $repairRegionModel = new RepairRegionModel();
        $categoryTree        = $repairRegionModel->adminCategoryTableTree();

        $this->assign('category_tree', $categoryTree);
        return $this->fetch();
    }
}