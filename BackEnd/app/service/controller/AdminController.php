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
}