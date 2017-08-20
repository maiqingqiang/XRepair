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

class AdminController extends BaseController{
    public function getGeneralRepair(){
        $param = $this->request->param();

        $postService = new GeneralService();
        $data = $postService->repairList($param);


        if ($data){

        }else{

        }
    }
}