<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
use think\Db;
use think\Request;
use think\Response;
use app\admin\controller\Auth;
use think\Lang;
// 应用公共文件
/**
 * 所有用到密码的不可逆加密方式
 * @author rainfer <81818832@qq.com>
 * @param string $password
 * @param string $password_salt
 * @return string
 */
function encrypt_password($password, $password_salt)
{
	return md5(md5($password) . md5($password_salt));
}
/**
 * 列出本地目录的文件
 * @author rainfer <81818832@qq.com>
 * @param string $path
 * @param string $pattern
 * @return array
 */
function list_file($path, $pattern = '*')
{
    if (strpos($pattern, '|') !== false) {
        $patterns = explode('|', $pattern);
    } else {
        $patterns [0] = $pattern;
    }
    $i = 0;
    $dir = array();
    if (is_dir($path)) {
        $path = rtrim($path, '/') . '/';
    }
    foreach ($patterns as $pattern) {
        $list = glob($path . $pattern);
        if ($list !== false) {
            foreach ($list as $file) {
                $dir [$i] ['filename'] = basename($file);
                $dir [$i] ['path'] = dirname($file);
                $dir [$i] ['pathname'] = realpath($file);
                $dir [$i] ['owner'] = fileowner($file);
                $dir [$i] ['perms'] = substr(base_convert(fileperms($file), 10, 8), -4);
                $dir [$i] ['atime'] = fileatime($file);
                $dir [$i] ['ctime'] = filectime($file);
                $dir [$i] ['mtime'] = filemtime($file);
                $dir [$i] ['size'] = filesize($file);
                $dir [$i] ['type'] = filetype($file);
                $dir [$i] ['ext'] = is_file($file) ? strtolower(substr(strrchr(basename($file), '.'), 1)) : '';
                $dir [$i] ['isDir'] = is_dir($file);
                $dir [$i] ['isFile'] = is_file($file);
                $dir [$i] ['isLink'] = is_link($file);
                $dir [$i] ['isReadable'] = is_readable($file);
                $dir [$i] ['isWritable'] = is_writable($file);
                $i++;
            }
        }
    }
    $cmp_func = create_function('$a,$b', '
		if( ($a["isDir"] && $b["isDir"]) || (!$a["isDir"] && !$b["isDir"]) ){
			return  $a["filename"]>$b["filename"]?1:-1;
		}else{
			if($a["isDir"]){
				return -1;
			}else if($b["isDir"]){
				return 1;
			}
			if($a["filename"]  ==  $b["filename"])  return  0;
			return  $a["filename"]>$b["filename"]?-1:1;
		}
		');
    usort($dir, $cmp_func);
    return $dir;
}
/**
 * 删除文件夹
 * @author rainfer <81818832@qq.com>
 * @param string
 * @param int
 */
function remove_dir($dir, $time_thres = -1)
{
    foreach (list_file($dir) as $f) {
        if ($f ['isDir']) {
            remove_dir($f ['pathname'] . '/');
        } else if ($f ['isFile'] && $f ['filename']) {
            if ($time_thres == -1 || $f ['mtime'] < $time_thres) {
                @unlink($f ['pathname']);
            }
        }
    }
}
/**
 * 格式化字节大小
 * @param  number $size      字节数
 * @param  string $delimiter 数字和单位分隔符
 * @return string            格式化后的带单位的大小
 * @author rainfer <81818832@qq.com>
 */
function format_bytes($size, $delimiter = '')
{
    $units = array(' B', ' KB', ' MB', ' GB', ' TB', ' PB');
    for ($i = 0; $size >= 1024 && $i < 5; $i++) $size /= 1024;
    return round($size, 2) . $delimiter . $units[$i];
}
/**
 * 版本检测
 * @return string
 * @author rainfer <81818832@qq.com>
 */
function checkVersion()
{
	if(extension_loaded('curl')){
		$url = 'http://www.yfcmf.net/index.php?m=home&c=upgrade&a=check';
		$params = array(
				'version' => config('yfcmf_version'),
				'domain'  => $_SERVER['HTTP_HOST'],
		);
		$vars = http_build_query($params);
		//获取版本数据
		$data = go_curl($url, 'post', $vars);
		if(!empty($data) && strlen($data)<400){
			return $data;
		}else{
			return '';
		}
	}else{
		return '';
	}
}
/**
 * curl访问
 * @author rainfer <81818832@qq.com>
 * @param  string $url
 * @param string $type
 * @param boolean $data
 * @param string $err_msg
 * @param int $timeout
 * @param array $cert_info
 * @return string
 */
function go_curl($url, $type, $data = false, &$err_msg = null, $timeout = 20, $cert_info = array())
{
	$type = strtoupper($type);
    if ($type == 'GET' && is_array($data)) {
        $data = http_build_query($data);
    }
    $option = array();
    if ( $type == 'POST' ) {
        $option[CURLOPT_POST] = 1;
    }
    if ($data) {
        if ($type == 'POST') {
            $option[CURLOPT_POSTFIELDS] = $data;
        } elseif ($type == 'GET') {
            $url = strpos($url, '?') !== false ? $url.'&'.$data :  $url.'?'.$data;
        }
    }
    $option[CURLOPT_URL]            = $url;
    $option[CURLOPT_FOLLOWLOCATION] = TRUE;
    $option[CURLOPT_MAXREDIRS]      = 4;
    $option[CURLOPT_RETURNTRANSFER] = TRUE;
    $option[CURLOPT_TIMEOUT]        = $timeout;
    //设置证书信息
    if(!empty($cert_info) && !empty($cert_info['cert_file'])) {
        $option[CURLOPT_SSLCERT]       = $cert_info['cert_file'];
        $option[CURLOPT_SSLCERTPASSWD] = $cert_info['cert_pass'];
        $option[CURLOPT_SSLCERTTYPE]   = $cert_info['cert_type'];
    }
    //设置CA
    if(!empty($cert_info['ca_file'])) {
        // 对认证证书来源的检查，0表示阻止对证书的合法性的检查。1需要设置CURLOPT_CAINFO
        $option[CURLOPT_SSL_VERIFYPEER] = 1;
        $option[CURLOPT_CAINFO] = $cert_info['ca_file'];
    } else {
        // 对认证证书来源的检查，0表示阻止对证书的合法性的检查。1需要设置CURLOPT_CAINFO
        $option[CURLOPT_SSL_VERIFYPEER] = 0;
    }
    $ch = curl_init();
    curl_setopt_array($ch, $option);
    $response = curl_exec($ch);
    $curl_no  = curl_errno($ch);
    $curl_err = curl_error($ch);
    curl_close($ch);
    // error_log
    if($curl_no > 0) {
        if($err_msg !== null) {
            $err_msg = '('.$curl_no.')'.$curl_err;
        }
    }
    return $response;
}
/**
 * 设置全局配置到文件
 *
 * @param $key
 * @param $value
 * @return boolean
 */
function sys_config_setbykey($key, $value)
{
    $file = ROOT_PATH.'data/conf/config.php';
    $cfg = array();
    if (file_exists($file)) {
        $cfg = include $file;
    }
    $item = explode('.', $key);
    switch (count($item)) {
        case 1:
            $cfg[$item[0]] = $value;
            break;
        case 2:
            $cfg[$item[0]][$item[1]] = $value;
            break;
    }
    return file_put_contents($file, "<?php\nreturn " . var_export($cfg, true) . ";");
}
/**
 * 设置全局配置到文件
 *
 * @param array
 * @return boolean
 */
function sys_config_setbyarr($data)
{
    $file = ROOT_PATH.'data/conf/config.php';
    if(file_exists($file)){
        $configs=include $file;
    }else {
        $configs=array();
    }
    $configs=array_merge($configs,$data);
    return file_put_contents($file, "<?php\treturn " . var_export($configs, true) . ";");
}
/**
 * 获取全局配置
 *
 * @param $key
 * @return array|null
 */
function sys_config_get($key)
{
    $file = ROOT_PATH.'data/conf/config.php';
    $cfg = array();
    if (file_exists($file)) {
        $cfg = (include $file);
    }
    return isset($cfg[$key]) ? $cfg[$key] : null;
}
/**
 * 返回带协议的域名
 * @author rainfer <81818832@qq.com>
 */
function get_host()
{
    $host=$_SERVER["HTTP_HOST"];
    $protocol=Request::instance()->isSsl()?"https://":"http://";
    return $protocol.$host;
}
/**
 * ajax数据返回，规范格式
 * @param array $data   返回的数据，默认空数组
 * @param string $msg   信息，一般用于错误信息提示
 * @param int $code     错误码，0-未出现错误|其他出现错误
 * @param array $extend 扩展数据
 * @return string
 */
function ajax_return($data = [], $msg = "", $code = 0, $extend = [])
{
    $msg=empty($msg)?'失败':$msg;
    $ret = ["code" => $code, "msg" => $msg, "data" => $data];
    $ret = array_merge($ret, $extend);
    return Response::create($ret, 'json');
}
/**
 * 根据用户id获取用户组,返回值为数组
 * @param   int $uid    用户id
 * @return string
 */
function get_groups($uid)
{
    $auth = new Auth();
    $group = $auth->getGroups($uid);
    return $group[0]['title'];
}
/**
 * 随机字符
 * @param int $length 长度
 * @param string $type 类型
 * @param int $convert 转换大小写 1大写 0小写
 * @return string
 */
function random($length=10, $type='letter', $convert=0)
{
    $config = array(
        'number'=>'1234567890',
        'letter'=>'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        'string'=>'abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789',
        'all'=>'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
    );

    if(!isset($config[$type])) $type = 'letter';
    $string = $config[$type];

    $code = '';
    $strlen = strlen($string) -1;
    for($i = 0; $i < $length; $i++){
        $code .= $string{mt_rand(0, $strlen)};
    }
    if(!empty($convert)){
        $code = ($convert > 0)? strtoupper($code) : strtolower($code);
    }
    return $code;
}
/**
 * 是否存在控制器
 * @param string $module 模块
 * @param string $controller 待判定控制器名
 * @return boolean
 */
function has_controller($module,$controller)
{
	$arr=\ReadClass::readDir(APP_PATH . $module. DS .'controller');
    if((!empty($arr[$controller])) && $arr[$controller]['class_name']==$controller){
        return true;
    }else{
        return false;
    }
}
/**
 * 是否存在方法
 * @param string $module 模块
 * @param string $controller 待判定控制器名
 * @param string $action 待判定控制器名
 * @return number 方法结果，0不存在控制器 1存在控制器但是不存在方法 2存在控制和方法
 */
function has_action($module,$controller,$action)
{
	$arr=\ReadClass::readDir(APP_PATH . $module. DS .'controller');
    if((!empty($arr[$controller])) && $arr[$controller]['class_name']==$controller ){
		$method_name=array_map('array_shift',$arr[$controller]['method']);
        if(in_array($action, $method_name)){
           return 2;
        }else{
           return 1;
        }
    }else{
        return 0;
    }
}
/**
 * 返回不含前缀的数据库表数组
 *
 * @author rainfer <81818832@qq.com>
 * @param bool
 * @return array
 */
function db_get_tables($prefix=false)
{
    $db_prefix =config('database.prefix');
    $list  = Db::query('SHOW TABLE STATUS FROM '.config('database.database'));
    $list  = array_map('array_change_key_case', $list);
    $tables = array();
    foreach($list as $k=>$v){
        if(empty($prefix)){
            if(stripos($v['name'],strtolower(config('database.prefix')))===0){
                $tables [] = strtolower(substr($v['name'], strlen($db_prefix)));
            }
        }else{
            $tables [] = strtolower($v['name']);
        }

    }
    return $tables;
}
/**
 * 返回数据表的sql
 *
 * @author rainfer <81818832@qq.com>
 *
 * @param $table : 不含前缀的表名
 * @return string
 */
function db_get_insert_sqls($table)
{
    $db_prefix =config('database.prefix');
    $db_prefix_re = preg_quote($db_prefix);
    $db_prefix_holder = db_get_db_prefix_holder();
    $export_sqls = array();
    $export_sqls [] = "DROP TABLE IF EXISTS $db_prefix_holder$table";
    switch (config('database.type')) {
        case 'mysql' :
            if (!($d = Db::query("SHOW CREATE TABLE $db_prefix$table"))) {
                $this->error("'SHOW CREATE TABLE $table' Error!");
            }
            $table_create_sql = $d [0] ['Create Table'];
            $table_create_sql = preg_replace('/' . $db_prefix_re . '/', $db_prefix_holder, $table_create_sql);
            $export_sqls [] = $table_create_sql;
            $data_rows = Db::query("SELECT * FROM $db_prefix$table");
            $data_values = array();
            foreach ($data_rows as &$v) {
                foreach ($v as &$vv) {
                    //TODO mysql_real_escape_string替换方法
                    //$vv = "'" . @mysql_real_escape_string($vv) . "'";
					$vv = "'" . addslashes(str_replace(array("\r","\n"),array('\r','\n'),$vv)) . "'";
                }
                $data_values [] = '(' . join(',', $v) . ')';
            }
            if (count($data_values) > 0) {
                $export_sqls [] = "INSERT INTO `$db_prefix_holder$table` VALUES \n" . join(",\n", $data_values);
            }
            break;
    }
    return join(";\n", $export_sqls) . ";";
}
/**
 * 检测当前数据库中是否含指定表
 *
 * @author rainfer <81818832@qq.com>
 *
 * @param $table : 不含前缀的数据表名
 * @return bool
 */
function db_is_valid_table_name($table)
{
    return in_array($table, db_get_tables());
}
/**
 * 不检测表前缀,恢复数据库
 *
 * @author rainfer <81818832@qq.com>
 *
 * @param $file
 * @param $prefix
 */
function db_restore_file($file,$prefix='')
{
    $prefix=$prefix?:db_get_db_prefix_holder();
    $db_prefix=config('database.prefix');
    $sqls = file_get_contents($file);
    $sqls = str_replace($prefix, $db_prefix, $sqls);
    $sqlarr = explode(";\n", $sqls);
    foreach ($sqlarr as &$sql) {
        Db::execute($sql);
    }
}
/**
 * 返回表前缀替代符
 * @author rainfer <81818832@qq.com>
 *
 * @return string
 */
function db_get_db_prefix_holder()
{
    return '<--db-prefix-->';
}
/**
 * 强制下载
 * @author rainfer <81818832@qq.com>
 *
 * @param string $filename
 * @param string $content
 */
function force_download_content($filename, $content)
{
    header("Pragma: public");
    header("Expires: 0");
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
    header("Content-Type: application/force-download");
    header("Content-Transfer-Encoding: binary");
    header("Content-Disposition: attachment; filename=$filename");
    echo $content;
    exit ();
}
/**
 * 数据表导出excel
 *
 * @author rainfer <81818832@qq.com>
 *
 * @param string $table,不含前缀表名,必须
 * @param string $file,保存的excel文件名,默认表名为文件名
 * @param string $fields,需要导出的字段名,默认全部,以半角逗号隔开
 * @param string $field_titles,需要导出的字段标题,需与$field一一对应,为空则表示直接以字段名为标题,以半角逗号隔开
 * @param string $tag,筛选条件 以字符串方式传入,例："limit:0,8;order:post_date desc,listorder desc;where:id>0;"
 *      limit:数据条数,可以指定从第几条开始,如3,8(表示共调用8条,从第3条开始)
 *      order:排序方式，如：post_date desc
 *      where:查询条件，字符串形式，和sql语句一样
 */
function export2excel($table,$file='',$fields='',$field_titles='',$tag='')
{
    //处理传递的参数
    if(stripos($table,config('database.prefix'))==0){
        //含前缀的表,去除表前缀
        $table=substr($table,strlen(config('database.prefix')));
    }
    $file=empty($file)?config('database.prefix').$table:$file;
    $fieldsall=Db::name($table)->getTableInfo('','fields');
    $field_titles=empty($field_titles)?array():explode(",",$field_titles);
    if(empty($fields)){
        $fields=$fieldsall;
        //成员数不一致,则取字段名为标题
        if(count($fields)!=count($field_titles)){
            $field_titles=$fields;
        }
    }else{
        $fields=explode(",",$fields);
        $rst=array();
        $rsttitle=array();
        $title_y_n=(count($fields)==count($field_titles))?true:false;
        foreach($fields as $k=>$v){
            if(in_array($v,$fieldsall)){
                $rst[]=$v;
                //一一对应则取指定标题,否则取字段名
                $rsttitle[]=$title_y_n?$field_titles[$k]:$v;
            }
        }
        $fields=$rst;
        $field_titles=$rsttitle;
    }
    //处理tag标签
    $tag=param2array($tag);
    $limit = !empty($tag['limit']) ? $tag['limit'] : '';
    $order = !empty($tag['order']) ? $tag['order'] : '';
    $where=array();
    if (!empty($tag['where'])) {
        $where_str = $tag['where'];
    }else{
		$where_str='';
    }
    //处理数据
    $data= Db::name($table)->field(join(",",$fields))->where($where_str)->where($where)->order($order)->limit($limit)->select();
    //import("Org.Util.PHPExcel");
    error_reporting(E_ALL);
    date_default_timezone_set('Asia/chongqing');
    $objPHPExcel = new \PHPExcel();
    //import("Org.Util.PHPExcel.Reader.Excel5");
    /*设置excel的属性*/
    $objPHPExcel->getProperties()->setCreator("rainfer")//创建人
    ->setLastModifiedBy("rainfer")//最后修改人
    ->setKeywords("excel")//关键字
    ->setCategory("result file");//种类

    //第一行数据
    $objPHPExcel->setActiveSheetIndex(0);
    $active = $objPHPExcel->getActiveSheet();
    foreach($field_titles as $i=>$name){
        $ck = num2alpha($i++) . '1';
        $active->setCellValue($ck, $name);
    }
    //填充数据
    foreach($data as $k => $v){
        $k=$k+1;
        $num=$k+1;//数据从第二行开始录入
        $objPHPExcel->setActiveSheetIndex(0);
        foreach($fields as $i=>$name){
            $ck = num2alpha($i++) . $num;
            $active->setCellValue($ck, $v[$name]);
        }
    }
    $objPHPExcel->getActiveSheet()->setTitle($table);
    $objPHPExcel->setActiveSheetIndex(0);
    header('Content-Type: application/vnd.ms-excel');
    header('Content-Disposition: attachment;filename="'.$file.'.xls"');
    header('Cache-Control: max-age=0');
    $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
    $objWriter->save('php://output');
    exit;
}
/**
 * 生成参数列表,以数组形式返回
 * @author rainfer <81818832@qq.com>
 * @param string
 * @return array
 */
function param2array($tag = '')
{
    $param = array();
    $array = explode(';',$tag);
    foreach ($array as $v){
        $v=trim($v);
        if(!empty($v)){
            list($key,$val) = explode(':',$v);
            $param[trim($key)] = trim($val);
        }
    }
    return $param;
}
/**
 * 数字到字母列
 * @author rainfer <81818832@qq.com>
 * @param int
 * @param int
 * @return string
 */
function num2alpha($index, $start = 65)
{
    $str = '';
    if (floor($index / 26) > 0) {
        $str .= num2alpha(floor($index / 26)-1);
    }
    return $str . chr($index % 26 + $start);
}
/**
 * 读取excel文件到数组
 * @param string $filename,excel文件名（含路径）
 * @param string $type,excel文件类型 'Excel2007', 'Excel5', 'Excel2003XML','OOCalc', 'SYLK', 'Gnumeric', 'HTML','CSV'
 * @return array
 * @author rainfer <81818832@qq.com>
 */
function read($filename,$type='Excel5')
{
    $objReader = \PHPExcel_IOFactory::createReader($type);
    $objPHPExcel = $objReader->load($filename);
    $objWorksheet = $objPHPExcel->getActiveSheet();
    $highestRow = $objWorksheet->getHighestRow();
    $highestColumn = $objWorksheet->getHighestColumn();
    $highestColumnIndex = \PHPExcel_Cell::columnIndexFromString($highestColumn);
    $excelData = array();
    for ($row = 1; $row <= $highestRow; $row++) {
        for ($col = 0; $col < $highestColumnIndex; $col++) {
            $excelData[$row][] =(string)$objWorksheet->getCellByColumnAndRow($col, $row)->getValue();
        }
    }
    return $excelData;
}
/**
 * 获取新闻分类ids
 * @author rainfer <81818832@qq.com>
 *
 * @param int $id 待获取的id
 * @param  boolean $self 是否返回自身，默认false
 * @param int $open 1表示只显示menu_open=1的，0表示只显示menu_open=0的，2表示不限制
 * @param string $field 默认只返回id数组(一维),其它如:"*"表示全部字段，"id,menu_name"表示返回二维数组
 * @param boolean $lang 是否只返回当前语言下分类，默认false
 * @return array|mixed
 */
function get_menu_byid($id=0,$self=false,$open=0,$field='id',$lang=false)
{
    if(empty($open)){
        $where['menu_open']=0;
    }elseif($open==1){
        $where['menu_open']=1;
    }else{
        $where=array();
    }
	if($lang){
		$where['menu_l']=Lang::detect();
	}
    $arr=Db::name('menu')->where($where)->where(array('id'=>$id))->select();
    if($arr){
        $tree=new \Tree();
        $tree->init($arr);
        $rst=$tree->get_childs($arr,$id,true,true);
    }else{
        $rst=$self?array($id):array();
    }
    if(empty($field) || $field=='id'){
        return $rst;
    }else{
        $where=array();
        $where['id']=array('in',$rst);
        $arr=Db::name('menu')->where($where)->field($field)->order('listorder asc')->select();
        return $arr;
    }
}
/**
 * 截取文字
 * @author rainfer <81818832@qq.com>
 *
 * @param string $text
 * @param int $length
 * @return string
 */
function subtext($text, $length)
{
    if(mb_strlen($text, 'utf8') > $length)
        return mb_substr($text, 0, $length, 'utf8').'...';
    return $text;
}
/**
 * 将内容存到Storage中，返回转存后的文件路径
 * @author rainfer <81818832@qq.com>
 * @param string $ext
 * @param string $content
 * @return string
 */
function save_storage_content($ext = null, $content = null)
{
    $newfile = '';
    $path='./data/upload/';
    $path=substr($path,0,2)=='./' ? substr($path,2) :$path;
    $path=substr($path,0,1)=='/' ? substr($path,1) :$path;
    if ($ext && $content) {
        do {
            $newfile = $path.date('Y-m-d/') . uniqid() . '.' . $ext;
        } while (file_exists($newfile));
        $dir = dirname($newfile);
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        file_put_contents($newfile, $content);
    }
    return $newfile;
}
/**
 * 获取所有友情连接
 * @author rainfer <81818832@qq.com>
 * @param int
 * @return array|mixed
 */
function get_links($type=1)
{
	$links=Db::name("plug_link")->where('plug_link_l',Lang::detect())->where(array('plug_link_typeid'=>$type,'plug_link_open'=>1))->order("plug_link_order ASC")->select();
	return $links;
}
/**
 * 返回指定id的菜单
 * @param int $id 表示获得这个ID下的所有子级
 * @param string $top_ul_id 顶级菜单ul的id
 * @param string $childtpl 子菜单模板
 * @param string $parenttpl 父菜单模板
 * @param int $showlevel 直接显示层级数，其余为异步显示，0为全部限制
 * @param string $ul_class 子菜单ul样式
 * @param string $li_class 子菜单li样式
 * @param string $top_ul_class 顶级菜单ul的样式
 * @param string $dropdown 有子元素时li的class
 * @return string
 */
function get_menu($id=0,$top_ul_id="",$childtpl="<span class='file'>\$label</span>",$parenttpl="<span class='folder'>\$label</span>",$ul_class="" ,$li_class="" ,$top_ul_class="filetree",$showlevel=6,$dropdown='hasChild')
{
	$navs=cache("site_nav");
	if(empty($navs)){
		$navs=get_menu_datas();
	}
	$tree = new \Tree();
	$tree->init($navs);
	return $tree->get_treeview_menu($id,$top_ul_id, $childtpl, $parenttpl,  $showlevel,$ul_class,$li_class,  $top_ul_class,  1, FALSE, $dropdown);
}
/**
 * 返回指定id的菜单
 * @return array|mixed
 */
function get_menu_datas()
{
    $navs= Db::name("menu")->where('menu_l',Lang::detect())->where(array('menu_open'=>1))->order(array("listorder" => "ASC"))->select();
    foreach ($navs as $key=>$nav){
        if($nav['menu_type']==2){
            $nav['href']=$nav['menu_address'];
        }elseif($nav['menu_type']==4){
			//为了匹配单页路由
			$nav['href']=url('home/Listn/index?id='.$nav['id']);
        }else{
			$nav['href']=url('home/Listn/index',array('id'=>$nav['id']));
            if(strtolower($nav['menu_enname'])=='home' && $nav['parentid']==0){
                $nav['href']=url('home/Index/index');
            }
		}
        $navs[$key]=$nav;
    }
    cache("site_nav",$navs);
    return $navs;
}
/**
 * 返回指定id的菜单
 * @param int
 * @return array
 */
function get_menu_tree($id)
{
    $navs=cache("site_nav");
    if(empty($navs)){
        $navs=get_menu_datas();
    }
    $tree = new \Tree();
    $tree->init($navs);
    return $tree->get_tree_array($id);
}
/**
 * 查询文章列表，支持分页或不分页
 * @author rainfer <81818832@qq.com>
 * @param string $tag  查询标签，以字符串方式传入,例："cid:1,2;field:news_title,news_content;limit:0,8;order:news_time desc,news_hits desc;where:n_id>5;"<br>
 *  ids:调用指定id的一个或多个数据,如 1,2,3<br>
 * 	cid:数据所在分类,可调出一个或多个分类数据,如 1,2,3 默认值为全部,在当前分类为:'.$cid.'<br>
 * 	field:调用post指定字段,如(n_id,news_title...) 默认全部<br>
 * 	limit:数据条数,默认值为10,可以指定从第几条开始,如3,8(表示共调用8条,从第3条开始),使用分页时无效
 * 	order:排序方式，如：news_hits desc<br>
 *	where:查询条件，字符串形式，和sql语句一样
 * @param bool $ispage 是否分页
 * @param int $pagesize
 * @param string $type 查询类型,可以为'cid',可以为'keyword',可以为'tag'
 * @param string $v 当查询类型为'cid'或'keyword'时,待搜索的值
 * @param array $where 查询条件，（暂只支持数组），格式和thinkphp where方法一样；
 * @param int $currentPage
 * @return array|mixed
 */
function get_news($tag,$ispage=false,$pagesize=10,$type=null,$v=null,$where=array(),$currentPage=null)
{
    $where=is_array($where)?$where:array();
    $tag=param2array($tag);
    $field = !empty($tag['field']) ? $tag['field'] : '*';
    $limit = !empty($tag['limit']) ? $tag['limit'] : '';
    $order = !empty($tag['order']) ? $tag['order'] : 'news_time';
	$config=array();
	if(!empty($currentPage)) $config['page']=intval($currentPage);
    switch($type){
        case 'keyword':
            $where['news_title|news_key'] = array('like','%' . $v . '%');//关键字
            break;
        case 'tag':
            $where['news_tag'] = array('like','%,' . $v . ',%');//标签
            break;
        case 'cid':
            $cid=intval($v);
            $catids=get_menu_byid($cid,1,0,'id',1);
            if(!empty($catids)){
                $catids=implode(",", $catids);
            }else{
                $catids="";
            }
            $tag['cid']=$catids;//重新生成条件
            break;
        default:
    }
    //根据参数生成查询条件
    $where['news_open'] = array('eq',1);
	$where['news_l'] = array('eq',Lang::detect());
    $where['news_back'] = array('eq',0);
    if (!empty($tag['cid'])) {
        $where['news_columnid'] = array('in',$tag['cid']);
    }
    if (!empty($tag['ids'])) {
        $where['n_id'] = array('in',$tag['ids']);
    }
    if (!empty($tag['where'])) {
        $where_str = $tag['where'];
    }else{
		$where_str='';
    }
    if($ispage){
        //使用分页
        $pagesize=$pagesize?$pagesize:config('paginate.list_rows');
        $count=Db::name("news")->field($field)->where($where_str)->where($where)->count();
        $news=Db::name("news")->alias("a")->join(config('database.prefix').'member_list b','a.news_auto =b.member_list_id')->field($field)->where($where_str)->where($where)->order($order)->paginate($pagesize,false,$config);
        $show=$news->render();
        $content['page']=$show;
        $content['news']=$news;
        $content['count']=$count;
        return $content;
    }else{
        //不使用分页
        $news=Db::name("news")->alias("a")->join(config('database.prefix').'member_list b','a.news_auto =b.member_list_id')->field($field)->where($where_str)->where($where)->order($order)->limit($limit)->select();
        return $news;
    }
}
/**
 * 获取评论
 * @param string $tag
 * @param array $where //按照thinkphp where array格式
 * @return array|mixed
 */
function get_comments($tag="field:*;limit:0,5;order:createtime desc;",$where=array())
{
    $where=is_array($where)?$where:array();
    $tag=param2array($tag);
    $field = !empty($tag['field']) ? $tag['field'] : '*';
    $limit = !empty($tag['limit']) ? $tag['limit'] : '5';
    $order = !empty($tag['order']) ? $tag['order'] : 'createtime desc';
    //根据参数生成查询条件
    $mwhere['c_status'] = array('eq',1);

    if(is_array($where)){
        $where=array_merge($mwhere,$where);
    }else{
        $where=$mwhere;
    }
    $comments=Db::name("comments")->alias("a")->join(config('database.prefix').'member_list b','a.uid =b.member_list_id')->field($field)->where($where)->order($order)->limit($limit)->select();
    return $comments;
}
/**
 * 根据广告位获取所有广告
 * @author rainfer <81818832@qq.com>
 * @param int $plug_ad_adtypeid 广告位id
 * @param int $limit
 * @param string $order
 * @return array|mixed;
 */
function get_ads($plug_ad_adtypeid,$limit=5,$order = "plug_ad_order ASC")
{
    if($order == ''){
        $order = "plug_ad_order ASC";
    }
    if ($limit == 0) {
        $limit = 5;
    }
    return Db::name("plug_ad")->where('plug_ad_l',Lang::detect())->where(array('plug_ad_open'=>1,'plug_ad_adtypeid'=>$plug_ad_adtypeid))->order($order)->limit('0,'.$limit)->select();
}
/**
 * 截取待html的文本
 * @author rainfer <81818832@qq.com>
 * @param string $html
 * @param int $max
 * @param string $suffix
 * @return string;
 */
function html_trim($html, $max, $suffix='...')
{
    $html = trim($html);
    if(strlen($html)<= $max){
		return $html;
    }
	$non_paired_tags = array('br', 'hr', 'img', 'input', 'param');
    $html = preg_replace('/<img([^>]+)>/i', '', $html);
    $count = 0;
    $tag_status = 0;
    $nodes = array();
    $segment = '';
    $tag_name = '';
    for($i=0;$i<strlen($html);$i++)
    {
        $char = $html[$i];
        $segment .= $char;
        if($tag_status == 4)
        {
            $tag_status = 0;
        }
        if($tag_status == 0 && $char == '<')
        {
            $tag_status = 1;
        }
        if($tag_status == 1 && $char != '<')
        {
            $tag_status = 2;
            $tag_name = '';
            $nodes[] = array(0, substr($segment, 0, strlen($segment)-2), 'text', 0);
            $segment = '<'.$char;
        }
        if($tag_status == 2)
        {
            if($char == ' ' || $char == '>' || $char == "\t")
            {
                $tag_status = 3;
            }else
            {
                $tag_name .= $char;
            }
        }
        if($tag_status == 3 && $char == '>')
        {
            $tag_status = 4;
            $tag_name = strtolower($tag_name);
            $tag_type = 1;
            if(in_array($tag_name, $non_paired_tags))
            {
                $tag_type = 0;
            }elseif($tag_name[0] == '/')
            {
                $tag_type = 2;
            }
            $nodes[] = array(1, $segment, $tag_name, $tag_type);
            $segment = '';
        }
        if($tag_status == 0)
        {
            if($char == '&')
            {
                for($e=1;$e<=10;$e++)
                {
                    if($html[$i+$e] == ';')
                    {
                        $segment .= substr($html, $i+1, $e);
                        $i += $e;
                        break;
                    }
                }
            }else
            {
                $char_code = ord($char);
                if($char_code >= 224)
                {
                    $segment .= $html[$i+1].$html[$i+2];
                    $i += 2;
                }elseif($char_code >= 129)
                {
                    $segment .= $html[$i+1];
                    $i += 1;
                }
            }
            $count ++;
            if($count == $max)
            {
                $nodes[] = array(0, $segment.$suffix, 'text',0);
                break;
            }
        }
    }
    $html = '';
    $tag_open_stack = array();
    for($i=0;$i<count($nodes);$i++)
    {
        $node = $nodes[$i];
        if($node[3] == 1)
        {
            array_push($tag_open_stack, $node[2]);
        }elseif($node[3] == 2)
        {
            array_pop($tag_open_stack);
        }
        $html .= $node[1];
    }
    while($tag_name = array_pop($tag_open_stack))
    {
        $html .= '</'.$tag_name.'>';
    }
    return $html;
}
/**
 * 获取当前request参数数组,去除值为空
 * @param string
 * @param int
 * @param int
 * @param string
 * @param bool
 * @return string
 */
function msubstr($str, $start=0, $length, $charset="utf-8", $suffix=true)
{
    if(function_exists("mb_substr"))
        $slice = mb_substr($str, $start, $length, $charset);
    elseif(function_exists('iconv_substr')) {
        $slice = iconv_substr($str,$start,$length,$charset);
        if(false === $slice) {
            $slice = '';
        }
    }else{
        $re['utf-8']   = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";
        $re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";
        $re['gbk']    = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";
        $re['big5']   = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";
        preg_match_all($re[$charset], $str, $match);
        $slice = join("",array_slice($match[0], $start, $length));
    }
    return ($suffix && $slice!=$str)? $slice.'...' : $slice;
}
/**
 * 获取单页面菜单
 * @author rainfer <81818832@qq.com>
 *
 * @param int $id 菜单id
 * @return array;
 */
function get_menu_one($id)
{
    $rst=array();
    if($id){
        $rst=Db::name('menu')->where('menu_l',Lang::detect())->where(array('menu_type'=>4,'id'=>$id))->find();
    }
    return $rst;
}
/**
 * 检查用户对某个url,内容的可访问性，用于记录如是否赞过，是否访问过等等;开发者可以自由控制，对于没有必要做的检查可以不做，以减少服务器压力
 * @param string $object 访问对象的id,格式：不带前缀的表名+id;如news1表示xx_news表里id为1的记录;如果object为空，表示只检查对某个url访问的合法性
 * @param int $count_limit 访问次数限制,如1，表示只能访问一次,0表示不限制
 * @param boolean $ip_limit ip限制,false为不限制，true为限制
 * @param int $expire 距离上次访问的最小时间单位s，0表示不限制，大于0表示最后访问$expire秒后才可以访问
 * @return true 可访问，false不可访问
 */
function check_user_action($object="",$count_limit=1,$ip_limit=false,$expire=0)
{
    $action=request()->module()."-".request()->controller()."-".request()->action();
    $userid=session('hid')?session('hid'):0;
    $ip=request()->ip();
    $where=array("uid"=>$userid,"action"=>$action,"object"=>$object);
    if($ip_limit){
        $where['ip']=$ip;
    }
    $find_log=Db::name("action_log")->where($where)->find();
    $time=time();
    if($find_log){
        //次数限制
        if($count_limit>0 && $find_log['count']>=$count_limit){
            return false;
        }
        //时间限制
        if($expire>0 && ($time-$find_log['last_time'])<$expire){
            return false;
        }
        Db::name("action_log")->where($where)->update(array("count"=>array("exp","count+1"),"last_time"=>$time,"ip"=>$ip));
    }else{
        Db::name("action_log")->insert(array("uid"=>$userid,"action"=>$action,"object"=>$object,"count"=>array("exp","count+1"),"last_time"=>$time,"ip"=>$ip));
    }
    return true;
}
/**
 * 用于生成收藏内容用的key
 * @param string $table 收藏内容所在表
 * @param int $object_id 收藏内容的id
 * @return string
 */
function get_favorite_key($table,$object_id)
{
    $key=encrypt_password($table.'-'.$object_id,$table);
    return $key;
}
/**
 * 发送邮件
 * @author rainfer <81818832@qq.com>
 * @param string $to 收件人邮箱
 * @param string $title 标题
 * @param string $content 内容
 * @return array
 */
function sendMail($to, $title, $content)
{
    $email_options=get_email_options();
    if($email_options && $email_options['email_open']){
        $mail = new PHPMailer(); //实例化
        // 设置PHPMailer使用SMTP服务器发送Email
        $mail->IsSMTP();
        $mail->Mailer='smtp';
        $mail->IsHTML(true);
        // 设置邮件的字符编码，若不指定，则为'UTF-8'
        $mail->CharSet='UTF-8';
        // 添加收件人地址，可以多次使用来添加多个收件人
        $mail->AddAddress($to);
        // 设置邮件正文
        $mail->Body=$content;
        // 设置邮件头的From字段。
        $mail->From=$email_options['email_name'];
        // 设置发件人名字
        $mail->FromName=$email_options['email_rename'];
        // 设置邮件标题
        $mail->Subject=$title;
        // 设置SMTP服务器。
        $mail->Host=$email_options['email_smtpname'];
        //by Rainfer
        // 设置SMTPSecure。
        $mail->SMTPSecure=$email_options['smtpsecure'];
        // 设置SMTP服务器端口。
        $port=$email_options['smtp_port'];
        $mail->Port=empty($port)?"25":$port;
        // 设置为"需要验证"
        $mail->SMTPAuth=true;
        // 设置用户名和密码。
        $mail->Username=$email_options['email_emname'];
        $mail->Password=$email_options['email_pwd'];
        // 发送邮件。
        if(!$mail->Send()) {
            $mailerror=$mail->ErrorInfo;
            return array("error"=>1,"message"=>$mailerror);
        }else{
            return array("error"=>0,"message"=>"success");
        }
    }else{
        return array("error"=>1,"message"=>'未开启邮件发送或未配置');
    }
}
/**
 * 获取后台管理设置的邮件连接
 * @author rainfer <81818832@qq.com>
 * @return array
 */
function get_email_options()
{
    $email_options = cache("email_options");
    if(empty($email_options)){
        $option = Db::name("Options")->where('option_l',Lang::detect())->where("option_name='email_options'")->find();
        if($option){
            $email_options = json_decode($option['option_value'],true);
        }else{
            $email_options = array();
        }
        cache("email_options", $email_options);
    }
    return $email_options;
}
/**
 * 获取后台管理设置的邮件激活连接
 * @author rainfer <81818832@qq.com>
 * @return array
 */
function get_active_options()
{
    $active_options = cache("active_options");
    if(empty($active_options)){
        $option = Db::name("Options")->where('option_l',Lang::detect())->where("option_name='active_options'")->find();
        if($option){
            $active_options = json_decode($option['option_value'],true);
        }else{
            $active_options = array();
        }
        cache("active_options", $active_options);
    }
    return $active_options;
}
/**
 * 实时显示提示信息
 * @param  string $msg 提示信息
 * @param  string $class 输出样式（success:成功，error:失败）
 * @author huajie <banhuajie@163.com>
 */
function showmsg($msg, $class = '')
{
    echo "<script type=\"text/javascript\">showmsg(\"{$msg}\", \"{$class}\")</script>";
    flush();
    ob_flush();
}
/**
 * 加密函数
 * @param string $txt 需加密的字符串
 * @param string $key 加密密钥，默认读取data_auth_key配置
 * @return string 加密后的字符串
 */
function jiami($txt, $key = null)
{
	empty($key) && $key = config('data_auth_key');
	$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-=_";
	$nh = rand(0, 64);
	$ch = $chars[$nh];
	$mdKey = md5($key . $ch);
	$mdKey = substr($mdKey, $nh % 8, $nh % 8 + 7);
	$txt = base64_encode($txt);
	$tmp = '';
	$k = 0;
	for ($i = 0; $i < strlen($txt); $i++) {
		$k = $k == strlen($mdKey) ? 0 : $k;
		$j = ($nh + strpos($chars, $txt [$i]) + ord($mdKey[$k++])) % 64;
		$tmp .= $chars[$j];
	}
	return $ch . $tmp;
}

/**
 * 解密函数
 * @param string $txt 待解密的字符串
 * @param string $key 解密密钥，默认读取data_auth_key配置
 * @return string 解密后的字符串
 */
function jiemi($txt, $key = null)
{
	empty($key) && $key = config('data_auth_key');
	$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-=_";
	$ch = $txt[0];
	$nh = strpos($chars, $ch);
	$mdKey = md5($key . $ch);
	$mdKey = substr($mdKey, $nh % 8, $nh % 8 + 7);
	$txt = substr($txt, 1);
	$tmp = '';
	$k = 0;
	for ($i = 0; $i < strlen($txt); $i++) {
		$k = $k == strlen($mdKey) ? 0 : $k;
		$j = strpos($chars, $txt[$i]) - $nh - ord($mdKey[$k++]);
		while ($j < 0) {
			$j += 64;
		}
		$tmp .= $chars[$j];
	}
	return base64_decode($tmp);
}
/**
 * 获取图片完整路径
 * @param string $url 待获取图片url
 * @param int $cat 待获取图片类别 0为文章 1前台头像 2后台头像
 * @return string 完整图片imgurl
 */
function get_imgurl($url,$cat=0)
{
    if(stripos($url,'http')!==false){
        //网络图片
        return $url;
    }elseif($url && stripos($url,'/')===false && stripos($url,'\\')===false){
       //头像
        return __ROOT__.'/data/upload/avatar/'.$url;
    }elseif(empty($url)){
        //$url为空
        if($cat==2){
            $imgurl='girl.jpg';
        }elseif($cat==1){
            $imgurl='headicon.png';
        }else{
            $imgurl='no_img.jpg';
        }
        return __ROOT__.'/public/img/'.$imgurl;
    }else{
        //本地上传图片
        return __ROOT__.$url;
    }
}
/**
 * 获取当前request参数数组,去除值为空
 * @return array
 */
function get_query()
{
	$param=request()->except(['s']);
	$rst=array();
	foreach($param as $k=>$v){
		if(!empty($v)){
			$rst[$k]=$v;
		}
	}
	return $rst;
}
/**
 * 货币转换
 * @param float
 * @return string
 */
function long_currency($long)
{
    return sprintf('%d.%02d', intval($long / 100), intval($long % 100));
}
/**
 * 货币转换
 * @param string
 * @return float
 */
function currency_long($currency)
{
    $s = explode('.', trim($currency));
    switch (count($s)) {
        case 1:
            return $s[0] * 100;
        case 2:
            if (strlen($s[1]) == 1) {
                $s[1] .= '0';
            } else if (strlen($s[1]) > 2) {
                $s[1] = substr($s[1], 0, 2);
            }
            return $s[0] * 100 + $s[1];
    }
    return 0;
}
/**
 * 返回前台菜单含model_name model_id model_title的菜单数组
 * @author  rainfer520@qq.com
 * @param array
 * @return array
 */
function get_menu_model($menus)
{
    $rst=array();
    foreach ($menus as $menu){
        $menu['model_name']='';
        $menu['model_title']='';
        if(!empty($menu['menu_modelid'])) {
            $model=Db::name('model')->find($menu['menu_modelid']);
            $menu['model_name']=$model['model_name'];
            $menu['model_title']=$model['model_title'];
        }
        $rst[]=$menu;
    }
    return $rst;
}
/**
 * 通用获取数据表数据
 * @author  rainfer520@qq.com
 * @param string $table 如'news'不含前缀形式
 * @param string $join 如 'member_list'不含前缀形式
 * @param string $joinon 'a.news_auto =b.member_list_id'字符串形式,$table为a表,$join为b表
 * @param string $ids 如'id:1,2,3'形式或'1,2,3'形式
 * @param string $cid 如'cid:1,2,3'形式或'1,2,3'形式
 * @param string $field 多个字段用','隔开，类似sql如'a,b,c,d'形式
 * @param string $limit 类似sql的limit如'5,10'或'5'形式
 * @param string $order 类似sql的order如'a,b desc,c'形式
 * @param string $where_str 类似sql的where字符串如"news_open=1 and news_title='aa'"形式
 * @param boolean $ispage 是否分页
 * @param int $pagesize 单页分页数
 * @param string $key 搜索的关键字
 * @param int $page 取第几页
 * @return array
 */
function get_data($table,$join,$joinon,$ids,$cid,$field,$limit,$order,$where_str,$ispage,$pagesize,$key,$page=0)
{	
	$where=array();
	$config=array();
	if(!empty($page)){
		$config['page']=intval($page);
	}
	$model=Db::name('model')->where('model_name',$table)->find();
	//处理$key
	if($key){
		if(stripos($key,':')!==false){
			list($field_search,$k)=explode(':',$key);
			$search_list=str_replace(',','|',$field_search);
			$where[$search_list]=array('like','%' . $k . '%');
		}else{
			$k=$key;
			if($model){
				$search_list=$model['search_list']?explode(',',$model['search_list']):array_keys($model['model_fields']?json_decode($model['model_fields'],true):array());
				if($search_list){
					$search_list=join('|',$search_list);
					$where[$search_list]=array('like','%' . $k . '%');
				}
			}
		}
	}
	//处理ids
	if($ids){
		if(stripos($ids,':')!==false){
			list($field_id,$id)=explode(':',$ids);
			$where[$field_id]=array('in',$id);
		}else{
			$id=$ids;
			if($model){
				$where[$model['model_pk']]=array('in',$id);
			}
		}
	}
	//处理cid
	if($cid){
		if(stripos($cid,':')!==false){
			list($field_cid,$id)=explode(':',$cid);
			$where[$field_cid]=array('in',$id);
		}else{
			$id=$cid;
			if($model){
				$where[$model['model_cid']]=array('in',$id);
			}
		}			
	}
	$count=Db::name($table)->field($field)->where($where_str)->where($where)->count();
	if($ispage=='true'){
		if($join && $joinon){
			$data=Db::name($table)->alias('a')->join(config('database.prefix').$join.' b',$joinon)->field($field)->where($where_str)->where($where)->order($order)->paginate($pagesize,false,$config);
		}else{
			$data=Db::name($table)->field($field)->where($where_str)->where($where)->order($order)->paginate($pagesize,false,$config);
		}
		$show=$data->render();
	}else{
		if($join && $joinon){
			$data=Db::name($table)->alias('a')->join(config('database.prefix').$join.' b',$joinon)->field($field)->where($where_str)->where($where)->order($order)->limit($limit)->select();
		}else{
			$data=Db::name($table)->field($field)->where($where_str)->where($where)->order($order)->limit($limit)->select();
		}
		$show='';
	}
	$content['ajax_page']=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);;
	$content['page']=$show;
	$content['data']=$data;
	$content['count']=$count;
	return $content;
}
/**
 * 获取客户端浏览器信息 添加win10 edge浏览器判断
 * @author  Jea杨
 * @return string
 */
function getBroswer()
{
	$sys = $_SERVER['HTTP_USER_AGENT'];  //获取用户代理字符串
	if (stripos($sys, "Firefox/") > 0) {
		preg_match("/Firefox\/([^;)]+)+/i", $sys, $b);
		$exp[0] = "Firefox";
		$exp[1] = $b[1];  //获取火狐浏览器的版本号
	} elseif (stripos($sys, "Maxthon") > 0) {
		preg_match("/Maxthon\/([\d\.]+)/", $sys, $aoyou);
		$exp[0] = "傲游";
		$exp[1] = $aoyou[1];
	} elseif (stripos($sys, "MSIE") > 0) {
		preg_match("/MSIE\s+([^;)]+)+/i", $sys, $ie);
		$exp[0] = "IE";
		$exp[1] = $ie[1];  //获取IE的版本号
	} elseif (stripos($sys, "OPR") > 0) {
		preg_match("/OPR\/([\d\.]+)/", $sys, $opera);
		$exp[0] = "Opera";
		$exp[1] = $opera[1];
	} elseif (stripos($sys, "Edge") > 0) {
		//win10 Edge浏览器 添加了chrome内核标记 在判断Chrome之前匹配
		preg_match("/Edge\/([\d\.]+)/", $sys, $Edge);
		$exp[0] = "Edge";
		$exp[1] = $Edge[1];
	} elseif (stripos($sys, "Chrome") > 0) {
		preg_match("/Chrome\/([\d\.]+)/", $sys, $google);
		$exp[0] = "Chrome";
		$exp[1] = $google[1];  //获取google chrome的版本号
	} elseif (stripos($sys, 'rv:') > 0 && stripos($sys, 'Gecko') > 0) {
		preg_match("/rv:([\d\.]+)/", $sys, $IE);
		$exp[0] = "IE";
		$exp[1] = $IE[1];
	} elseif (stripos($sys, 'Safari') > 0) {
		preg_match("/safari\/([^\s]+)/i", $sys, $safari);
		$exp[0] = "Safari";
		$exp[1] = $safari[1];
	} else {
		$exp[0] = "未知浏览器";
		$exp[1] = "";
	}
	return $exp[0] . '(' . $exp[1] . ')';
}

/**
 * 获取客户端操作系统信息包括win10
 * @author  Jea杨
 * @return string
 */
function getOs()
{
	$agent = $_SERVER['HTTP_USER_AGENT'];

	if (preg_match('/win/i', $agent) && strpos($agent, '95')) {
		$os = 'Windows 95';
	} else if (preg_match('/win 9x/i', $agent) && strpos($agent, '4.90')) {
		$os = 'Windows ME';
	} else if (preg_match('/win/i', $agent) && preg_match('/98/i', $agent)) {
		$os = 'Windows 98';
	} else if (preg_match('/win/i', $agent) && preg_match('/nt 6.0/i', $agent)) {
		$os = 'Windows Vista';
	} else if (preg_match('/win/i', $agent) && preg_match('/nt 6.1/i', $agent)) {
		$os = 'Windows 7';
	} else if (preg_match('/win/i', $agent) && preg_match('/nt 6.2/i', $agent)) {
		$os = 'Windows 8';
	} else if (preg_match('/win/i', $agent) && preg_match('/nt 10.0/i', $agent)) {
		$os = 'Windows 10';#添加win10判断
	} else if (preg_match('/win/i', $agent) && preg_match('/nt 5.1/i', $agent)) {
		$os = 'Windows XP';
	} else if (preg_match('/win/i', $agent) && preg_match('/nt 5/i', $agent)) {
		$os = 'Windows 2000';
	} else if (preg_match('/win/i', $agent) && preg_match('/nt/i', $agent)) {
		$os = 'Windows NT';
	} else if (preg_match('/win/i', $agent) && preg_match('/32/i', $agent)) {
		$os = 'Windows 32';
	} else if (preg_match('/linux/i', $agent)) {
		$os = 'Linux';
	} else if (preg_match('/unix/i', $agent)) {
		$os = 'Unix';
	} else if (preg_match('/sun/i', $agent) && preg_match('/os/i', $agent)) {
		$os = 'SunOS';
	} else if (preg_match('/ibm/i', $agent) && preg_match('/os/i', $agent)) {
		$os = 'IBM OS/2';
	} else if (preg_match('/Mac/i', $agent)) {
		$os = 'Mac';
	} else if (preg_match('/PowerPC/i', $agent)) {
		$os = 'PowerPC';
	} else if (preg_match('/AIX/i', $agent)) {
		$os = 'AIX';
	} else if (preg_match('/HPUX/i', $agent)) {
		$os = 'HPUX';
	} else if (preg_match('/NetBSD/i', $agent)) {
		$os = 'NetBSD';
	} else if (preg_match('/BSD/i', $agent)) {
		$os = 'BSD';
	} else if (preg_match('/OSF1/i', $agent)) {
		$os = 'OSF1';
	} else if (preg_match('/IRIX/i', $agent)) {
		$os = 'IRIX';
	} else if (preg_match('/FreeBSD/i', $agent)) {
		$os = 'FreeBSD';
	} else if (preg_match('/teleport/i', $agent)) {
		$os = 'teleport';
	} else if (preg_match('/flashget/i', $agent)) {
		$os = 'flashget';
	} else if (preg_match('/webzip/i', $agent)) {
		$os = 'webzip';
	} else if (preg_match('/offline/i', $agent)) {
		$os = 'offline';
	} elseif (preg_match('/ucweb|MQQBrowser|J2ME|IUC|3GW100|LG-MMS|i60|Motorola|MAUI|m9|ME860|maui|C8500|gt|k-touch|X8|htc|GT-S5660|UNTRUSTED|SCH|tianyu|lenovo|SAMSUNG/i', $agent)) {
		$os = 'mobile';
	} else {
		$os = '未知操作系统';
	}
	return $os;
}
/**
 * 返回按层级加前缀的菜单数组
 * @author  rainfer
 * @param array|mixed $menu 待处理菜单数组
 * @param string $id_field 主键id字段名
 * @param string $pid_field 父级字段名
 * @param string $lefthtml 前缀
 * @param int $pid 父级id
 * @param int $lvl 当前lv
 * @param int $leftpin 左侧距离
 * @return array
 */
function menu_left($menu,$id_field='id',$pid_field='pid',$lefthtml = '─' , $pid=0 , $lvl=0, $leftpin=0)
{
    $arr=array();
    foreach ($menu as $v){
        if($v[$pid_field]==$pid){
            $v['lvl']=$lvl + 1;
            $v['leftpin']=$leftpin;
            $v['lefthtml']='├'.str_repeat($lefthtml,$lvl);
            $arr[]=$v;
            $arr= array_merge($arr,menu_left($menu,$id_field,$pid_field,$lefthtml,$v[$id_field], $lvl+1 ,$leftpin+20));
        }
    }
    return $arr;
}
/**
 * 返回后台news相关菜单层级text数组
 * @author  rainfer
 * @return array|mixed
 */
function menu_text($lang='zh-cn')
{
	$menu_text=cache('menu_text');
	if(empty($menu_text)){
        $map=[];
        if(!config('lang_switch_on')){
            $map['menu_l']=  $lang;
        }
		$menu_text=Db::name('menu')->where('menu_type <> 4 and menu_type <> 2')->where($map)-> order('menu_l desc,listorder') -> select();
		$menu_text = menu_left($menu_text,'id','parentid');
		cache('menu_text',$menu_text);
	}
	return $menu_text;
}
/**
 * 数据签名
 * @param array $data 被认证的数据
 * @return string 签名
 */
function data_signature($data = [])
{
    if(!is_array($data)){
        $data = (array)$data;
    }
    ksort($data);
    $code = http_build_query($data);
    $sign = sha1($code);
    return $sign;
}