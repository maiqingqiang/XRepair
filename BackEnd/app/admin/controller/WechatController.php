<?php
/**
 * Created by PhpStorm.
 * User: Mak
 * Email：xiaomak@qq.com
 * Date: 2017/8/27
 * Time: 1:33
 */

namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Exception;

class WechatController extends AdminBaseController {
    public function index() {
        $appid = config('wechat.appid');
        $secret = config('wechat.secret');

        $this->assign("appid", $appid);
        $this->assign("secret", $secret);

        return $this->fetch();
    }

    public function edit() {

        if ($this->request->isPost()) {
            $data = ['appid' => $this->request->param('appid'),
                'secret' => $this->request->param('secret')];

            $file = APP_PATH . 'extra/wechat.php';

            try {
                file_put_contents($file, "<?php\treturn " . var_export($data, true) . ";");
                $this->success("保存成功！", '');
            } catch (Exception $e) {
                $this->error("保存失败！error" . $e->getMessage(), '');
            }
        }
    }
}