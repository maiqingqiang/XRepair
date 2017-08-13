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

class RegionController extends AdminBaseController{
    public function index(){
        $repairRegionModel = new RepairRegionModel();
        $categoryTree        = $repairRegionModel->adminCategoryTableTree();

        $this->assign('category_tree', $categoryTree);
        return $this->fetch();
    }

    public function add()
    {
        $parentId            = $this->request->param('parent', 0, 'intval');
        $repairRegionModel = new RepairRegionModel();
        $categoriesTree      = $repairRegionModel->adminCategoryTree($parentId);

        $this->assign('categories_tree', $categoriesTree);
        return $this->fetch();
    }

    public function addPost()
    {
        $repairRegionModel = new RepairRegionModel();

        $data = $this->request->param();

        $result = $this->validate($data, 'Region');

        if ($result !== true) {
            $this->error($result);
        }

        $result = $repairRegionModel->addCategory($data);

        if ($result === false) {
            $this->error('添加失败!');
        }

        $this->success('添加成功!', url('Region/index'));

    }

    public function edit()
    {
        $id = $this->request->param('id', 0, 'intval');
        if ($id > 0) {
            $category = RepairRegionModel::get($id)->toArray();

            $repairRegionModel = new RepairRegionModel();
            $categoriesTree      = $repairRegionModel->adminCategoryTree($category['parent_id'], $id);

            $this->assign($category);
            $this->assign('categories_tree', $categoriesTree);
            return $this->fetch();
        } else {
            $this->error('操作错误!');
        }
    }

    public function editPost()
    {
        $data = $this->request->param();

        $result = $this->validate($data, 'Region');

        if ($result !== true) {
            $this->error($result);
        }

        $repairRegionModel = new RepairRegionModel();

        $result = $repairRegionModel->editCategory($data);

        if ($result === false) {
            $this->error('保存失败!');
        }

        $this->success('保存成功!', url('Region/index'));
    }

    public function listOrder()
    {
        parent::listOrders(Db::name('repair_region'));
        $this->success("排序更新成功！", '');
    }

    public function delete()
    {
        $repairRegionModel = new RepairRegionModel();
        $id                  = $this->request->param('id');
        //获取删除的内容
        $findCategory = $repairRegionModel->where('id', $id)->find();

        if (empty($findCategory)) {
            $this->error('区域不存在!');
        }

        $categoryChildrenCount = $repairRegionModel->where('parent_id', $id)->count();

        if ($categoryChildrenCount > 0) {
            $this->error('此区域有下级区域无法删除!');
        }

        $data   = [
            'object_id'   => $findCategory['id'],
            'create_time' => time(),
            'table_name'  => 'repair_region',
            'name'        => $findCategory['name']
        ];
        $result = $repairRegionModel
            ->where('id', $id)
            ->update(['delete_time' => time()]);
        if ($result) {
            Db::name('recycleBin')->insert($data);
            $this->success('删除成功!');
        } else {
            $this->error('删除失败');
        }
    }
}