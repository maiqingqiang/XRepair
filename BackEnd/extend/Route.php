<?php

class Route
{

    public  function route_rule()
    {
        $routes = $this->get_route();
        if (is_array($routes)) {
            foreach ($routes as $key => $route) {
                \think\Route::rule($route[0], $route[1], $route[2], $route[3], $route[4]);
            }
        }
    }

    private  function get_route()
    {
        $routes = \think\Cache::get('routes');
		if(empty($routes) && config('url_route_on')){
			switch (config('url_route_mode')) {
				// 标准模式
				case null:
				case '1':
					$rules = [
					];
					foreach ($rules as $key => $rule) {
						$routes[] = [$key, $rule, 'post|get', [], []];
					}
					\think\Cache::set('routes', $routes);
					break;
				// 高级模式
				case '2':
					// 内容模块
					$rules = [
					];
					if(file_exists(ROOT_PATH.'data/install.lock')){
						$data=\think\Db::name("route")->where("status=1")->order("listorder asc")->column('full_url','url');
						$data=array_merge($rules,$data);
						foreach ($data as $key => $rule) {
						$routes[] = [$key, $rule, 'post|get', [], []];
						}	
					}
					\think\Cache::set('routes', $routes);
					break;
				default:
					break;
			}			
		}
        return $routes;
    }

    private function category_route($categorys, $pid = 0, $path = [], &$res)
    {
        foreach ($categorys as $key => $category) {
            if ($category['pid'] == $pid) {
                $tpath = array_merge($path, [$category['name']]);
                $this->category_route($categorys, $category['id'], $tpath, $res);
                if ($tpath) {
                    $res[] = [implode('/', $tpath) . '$', 'index/content/index?id=' . $category['id'], 'get|post', [], []];
                    $res[] = [implode('/', $tpath) . '/:id$', 'index/content/detail?category_id=' . $category['id'], 'get|post', [], []];
                    $res[] = [implode('/', $tpath) . '/:filename$', 'index/content/detail?category_id=' . $category['id'], 'get|post', [], []];
                }
            }
        }
    }

    private  function single_route($single, &$routes)
    {
        if ($single) {
            foreach ($single as $id => $path) {
                if ($path) {
                    $routes[] = [substr($path, 1), 'index/single/index?id=' . $id, 'get|post', [], []];
                }
            }
        }
    }

}