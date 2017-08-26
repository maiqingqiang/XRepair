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
use EasyWeChat\Foundation\Application;

class TestController extends WebAppBaseController {

    protected $options=[
        /**
         * Debug 模式，bool 值：true/false
         *
         * 当值为 false 时，所有的日志都不会记录
         */
        'debug'  => true,
        /**
         * 账号基本信息，请从微信公众平台/开放平台获取
         */
        'app_id' => 'wxc00e21f6bd3b9b17',
        'secret' => 'c8ad4335766c9f082ecd21f4919636bd',
        'token'  => '',
        'aes_key' => '',
        'we_name'=>'',
        'we_id'=>'',
        'we_number'=>'',
        'we_type'=>1,
        /**
         * 日志配置
         *
         * level: 日志级别, 可选为：
         *         debug/info/notice/warning/error/critical/alert/emergency
         * permission：日志文件权限(可选)，默认为null（若为null值,monolog会取0644）
         * file：日志文件位置(绝对路径!!!)，要求可写权限
         */
        'log' => [
            'level'      => 'debug',
            'permission' => 0777,
            'file'       => './data/runtime/temp/easywechat.log',
        ],
        /**
         * OAuth 配置
         *
         * scopes：公众平台（snsapi_userinfo / snsapi_base），开放平台：snsapi_login
         * callback：OAuth授权完成后的回调页地址
         */
        'oauth' => [
            'scopes'   => ['snsapi_userinfo'],
            'callback' => '/examples/oauth_callback.php',
        ],
        /**
         * 微信支付
         */
        'payment' => [
            'merchant_id'        => 'your-mch-id',
            'key'                => 'key-for-signature',
            'cert_path'          => 'path/to/your/cert.pem', // XXX: 绝对路径！！！！
            'key_path'           => 'path/to/your/key',      // XXX: 绝对路径！！！！
            // 'device_info'     => '013467007045764',
            // 'sub_app_id'      => '',
            // 'sub_merchant_id' => '',
            // ...
        ],
        /**
         * Guzzle 全局设置
         *
         * 更多请参考： http://docs.guzzlephp.org/en/latest/request-options.html
         */
        'guzzle' => [
            'timeout' => 300.0, // 超时时间（秒）
            //'verify' => false, // 关掉 SSL 认证（强烈不建议！！！）
        ],
    ];

    public function index(){
        $app = new Application($this->options);
        $notice = $app->notice;
        $messageId = $notice->send([
            'touser' => 'oZgVbwOCnngg5U_7D7_ECP8KZYhs',
            'template_id' => 'gXySaTk_CP1R8Zh9cLUBq78yOskg2wZJ2lEznLqu9f8',
            'url' => 'xxxxx',
            'data' => [
                'first'=>132
            ],
        ]);

        dump($messageId);
    }
}