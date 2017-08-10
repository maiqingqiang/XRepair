<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +---------------------------------------------------------------------
// | Author: 小夏 < 449134904@qq.com>
// +----------------------------------------------------------------------
namespace cmf\controller;

use think\Db;

class WebAppBaseController extends BaseController
{

    public function _initializeView()
    {
        $root = cmf_get_root();

        $viewReplaceStr = [
            '__ROOT__'     => $root,
            '__TMPL__'     => "{$root}",
            '__STATIC__'   => "{$root}/static",
            '__WEB_ROOT__' => $root
        ];

        $viewReplaceStr = array_merge(config('view_replace_str'), $viewReplaceStr);
        config('template.view_base', "./");
        config('view_replace_str', $viewReplaceStr);
    }

}