<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/13
 * Time: 13:11
 */
namespace app\general\controller;

use app\general\model\GeneralCategoryModel;
use cmf\controller\AdminBaseController;
use think\Db;


class GeneralCategoryController extends AdminBaseController {

    public function index(){
        $generalCategoryModel = new GeneralCategoryModel();
        $categoryTree        = $generalCategoryModel->adminCategoryTableTree();

        $this->assign('category_tree', $categoryTree);
        return $this->fetch();
    }

    public function add()
    {
        $parentId            = $this->request->param('parent', 0, 'intval');
        $generalCategoryModel = new GeneralCategoryModel();
        $categoriesTree      = $generalCategoryModel->adminCategoryTree($parentId);

        $this->assign('categories_tree', $categoriesTree);
        return $this->fetch();
    }

    public function addPost()
    {
        $generalCategoryModel = new GeneralCategoryModel();

        $data = $this->request->param();

        $result = $this->validate($data, 'GeneralCategory');

        if ($result !== true) {
            $this->error($result);
        }

        $result = $generalCategoryModel->addCategory($data);

        if ($result === false) {
            $this->error('添加失败!');
        }

        $this->success('添加成功!', url('GeneralCategory/index'));

    }

    public function edit()
    {
        $id = $this->request->param('id', 0, 'intval');
        if ($id > 0) {
            $category = GeneralCategoryModel::get($id)->toArray();

            $generalCategoryModel = new GeneralCategoryModel();
            $categoriesTree      = $generalCategoryModel->adminCategoryTree($category['parent_id'], $id);

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

        $result = $this->validate($data, 'GeneralCategory');

        if ($result !== true) {
            $this->error($result);
        }

        $generalCategoryModel = new GeneralCategoryModel();

        $result = $generalCategoryModel->editCategory($data);

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
        $generalCategoryModel = new GeneralCategoryModel();
        $id                  = $this->request->param('id');
        //获取删除的内容
        $findCategory = $generalCategoryModel->where('id', $id)->find();

        if (empty($findCategory)) {
            $this->error('分类不存在!');
        }

        $categoryChildrenCount = $generalCategoryModel->where('parent_id', $id)->count();

        if ($categoryChildrenCount > 0) {
            $this->error('此分类有子类无法删除!');
        }

        $data   = [
            'object_id'   => $findCategory['id'],
            'create_time' => time(),
            'table_name'  => 'general_category',
            'name'        => $findCategory['name']
        ];
        $result = $generalCategoryModel
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