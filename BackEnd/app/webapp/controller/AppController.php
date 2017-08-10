<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/10
 * Time: 23:03
 */

namespace app\webapp\controller;

use cmf\controller\WebAppBaseController;

class AppController extends WebAppBaseController {
    public function index(){
        return $this->fetch();
    }
}