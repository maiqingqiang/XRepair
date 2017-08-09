<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/9
 * Time: 21:50
 */

namespace app\webapp\controller;

class App{
    public function index(){
        return view();
    }
//    public function index() {
//        $code = I('code');
//        $url = I('reurl');
//        $reurl = getHost() . '/Webapp/App/?v=1.0.0#' . $url;
//        if ($code) {
//            header('Location: ' . $reurl);
//            exit;
//        } else {
//            if ($url) {
//                header('Location: ' . $reurl);
//                exit;
//            } else {
//                $version = I('v');
//                if ($version) {
//                    $this->display();
//                } else {
//                    header('Location: ' . $reurl);
//                }
//            }
//        }
//    }
}