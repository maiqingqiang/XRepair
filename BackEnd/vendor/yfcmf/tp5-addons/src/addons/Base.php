<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace think\addons;

use think\Request;
use think\Hook;
use think\Config;
use think\Loader;
use think\Controller;

/**
 * 插件基类控制器
 * Class Base
 * @package think\addons
 */
class Base extends Controller
{
    // 当前插件操作
    protected $addon = null;
    protected $controller = null;
    protected $action = null;
    // 当前template
    protected $template;
    // 模板配置信息
    protected $config = [
        'type' => 'Think',
        'view_path' => '',
        'view_suffix' => 'html',
        'strip_space' => true,
        'view_depr' => DS,
        'tpl_begin' => '{',
        'tpl_end' => '}',
        'taglib_begin' => '{',
        'taglib_end' => '}',
    ];

    /**
     * 架构函数
     * @param Request $request Request对象
     * @access public
     */
    public function __construct(Request $request = null)
    {
        // 生成request对象
        $this->request = is_null($request) ? Request::instance() : $request;
        // 初始化配置信息
        $this->config = Config::get('template') ?: $this->config;
        // 处理路由参数
        $route = $this->request->param('route', '');
        $param = explode('-', $route);
        // 是否自动转换控制器和操作名(是否转换为小写)
        $convert = Config::get('url_convert');
        // 格式化路由的插件位置
        $this->action = $convert ? strtolower(array_pop($param)) : array_pop($param);
        $this->controller = $convert ? strtolower(array_pop($param)) : array_pop($param);
        $this->addon = $convert ? strtolower(array_pop($param)) : array_pop($param);

        // 生成view_path
        $view_path = $this->config['view_path'] ?: 'view';

        // 重置配置
        Config::set('template.view_path', ADDON_PATH . $this->addon . DS . $view_path . DS);

        parent::__construct($request);
    }

    /**
     * 加载模板输出
     * @access protected
     * @param string $template 模板文件名
     * @param array $vars 模板输出变量
     * @param array $replace 模板替换
     * @param array $config 模板参数
     * @return mixed
     */
    protected function fetch($template = '', $vars = [], $replace = [], $config = [])
    {
        $controller = Loader::parseName($this->controller);
        if ('think' == strtolower($this->config['type']) && $controller && 0 !== strpos($template, '/')) {
            $depr = $this->config['view_depr'];
            $template = str_replace(['/', ':'], $depr, $template);
            if ('' == $template) {
                // 如果模板文件名为空 按照默认规则定位
                $template = str_replace('.', DS, $controller) . $depr . $this->action;
            } elseif (false === strpos($template, $depr)) {
                $template = str_replace('.', DS, $controller) . $depr . $template;
            }
        }
        return parent::fetch($template, $vars, $replace, $config);
    }
    /**
     * 插件内方法执行
     */
    public function execute()
    {
        if ($this->addon && $this->controller && $this->action) {
            // 获取类的命名空间
            $class = get_addon_class($this->addon, 'controller', $this->controller);
            if (class_exists($class)) {
                $obj = new $class();
                if ($obj === false) {
                    abort(500, lang('addon init fail'));
                }
                // 调用操作
                if (!method_exists($obj, $this->action)) {
                    abort(500, lang('Controller Class Method Not Exists'));
                }
                // 监听addons_init
                Hook::listen('addons_init', $this);
                return call_user_func_array([$obj, $this->action], [Request::instance()]);
            } else {
                abort(500, lang('Controller Class Not Exists'));
            }
        }
        abort(500, lang('addon cannot name or action'));
    }
}
