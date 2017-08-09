<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use think\Db;
use think\Cache;

class Model extends Base
{
    protected $cms_pk='id';
    protected $cms_cid='';
    protected $cms_table='';
    protected $cms_model=[];
    protected $cms_db_engine='MyISAM';
    protected $cms_fields_list=[];
    protected $cms_fields_edit=[];
    protected $cms_fields_search=[];
    protected $cms_fields=[];
    protected $cms_allfields=[];
    /**
     * 模型列表
     */
    public function model_list()
    {
		$models=Db::name('model')->order('create_time desc')->select();
        $admin_rule=Db::name('auth_rule')->order('sort')->select();
        $admin_rule = menu_left($admin_rule);
        $this->assign('admin_rule',$admin_rule);
		$this->assign('models',$models);
		return $this->fetch();
	}
    /**
     * 模型状态操作
     */
	public function model_state()
    {
		$id=input('x');
		$status=Db::name('model')->where(array('model_id'=>$id))->value('model_status');//判断当前状态情况
		if($status==1){
			$statedata = array('model_status'=>0);
			Db::name('model')->where(array('model_id'=>$id))->setField($statedata);
			$this->success('状态禁止');
		}else{
			$statedata = array('model_status'=>1);
			Db::name('model')->where(array('model_id'=>$id))->setField($statedata);
			$this->success('状态开启');
		}
	}
    /**
     * 模型后台菜单添加
     */
    public function model_addmenu()
    {
        $model_id=input('model_id');
        $model=Db::name('model')->where('model_id',$model_id)->find();
        if (empty($model)){
            $this->error('参数错误',url('admin/Model/model_list'));
        }else{
            //添加顶级菜单
            $rst=Db::name('auth_rule')->where('name','Model/cmslist?id='.$model_id)->find();
            if(empty($rst)){
                $admin_rule_pid=input('admin_rule_pid',0,'intval');
                if($admin_rule_pid==0){
                    $level=0;
                }else{
                    $rule_pid=Db::name('auth_rule')->find($admin_rule_pid);
                    $level=$rule_pid['level'];
                }
                //不存在
                $sldata=array(
                    'name'=>'Model',
                    'title'=>input('menu_name',$model['model_title']),
                    'css'=>input('css','fa-list'),
                    'pid'=>$admin_rule_pid,
                    'level'=>$level+1,
                    'sort'=>input('sort',50,'intval'),
                    'addtime'=>time()
                );
                $pid1=Db::name('auth_rule')->insertGetId($sldata);
                if($pid1){
                    //增加模型数据
                    $sldata=array(
                        'name'=>'admin/Model/cmsadd?id='.$model_id,
                        'title'=>'增加'.$model['model_title'],
                        'pid'=>$pid1,
                        'level'=>$level+2,
                        'sort'=>20,
                        'addtime'=>time()
                    );
                    $pid2=Db::name('auth_rule')->insertGetId($sldata);
                    if($pid2){
                        $sldata=array(
                            'name'=>'admin/Model/cmsrunadd',
                            'title'=>'增加操作',
                            'pid'=>$pid2,
                            'level'=>$level+3,
                            'sort'=>10,
                            'status'=>0,
                            'addtime'=>time()
                        );
                        Db::name('auth_rule')->insert($sldata);
                    }else{
                        $this -> error("添加失败，请稍后重试",url('admin/Model/model_list'));
                    }
                    //添加列表
                    $sldata=array(
                        'name'=>'admin/Model/cmslist?id='.$model_id,
                        'title'=>$model['model_title'].'列表',
                        'pid'=>$pid1,
                        'level'=>$level+2,
                        'sort'=>10,
                        'addtime'=>time()
                    );
                    $pid2=Db::name('auth_rule')->insertGetId($sldata);
                    if($pid2){
                        //删除、状态、编辑显示、编辑操作、排序、全部删除
                        $sldata=[
                            ['name'=>'admin/Model/cmsdel','title'=>'删除操作','pid'=>$pid2,'level'=>$level+3,'status'=>0,'addtime'=>time()],
                            ['name'=>'admin/Model/cmsstate','title'=>'状态操作','pid'=>$pid2,'level'=>$level+3,'status'=>0,'addtime'=>time()],
                            ['name'=>'admin/Model/cmsorder','title'=>'排序操作','pid'=>$pid2,'level'=>$level+3,'status'=>0,'addtime'=>time()],
                            ['name'=>'admin/Model/cmsalldel','title'=>'全部删除','pid'=>$pid2,'level'=>$level+3,'status'=>0,'addtime'=>time()],
                            ['name'=>'admin/Model/cmsedit','title'=>'编辑显示','pid'=>$pid2,'level'=>$level+3,'status'=>0,'addtime'=>time()],
                            ['name'=>'admin/Model/cmsrunedit','title'=>'编辑操作','pid'=>$pid2,'level'=>$level+3,'status'=>0,'addtime'=>time()],
                        ];
                        Db::name('auth_rule')->insertAll($sldata);
                        Cache::clear();
                        $this->success('菜单添加成功',url('admin/Model/model_list'));
                    }else{
                        $this -> error("添加失败，请稍后重试",url('admin/Model/model_list'));
                    }
                }else{
                    $this -> error("添加失败，请稍后重试",url('admin/Model/model_list'));
                }
            }else{
                $this -> error("已存在，请确认！",url('admin/Model/model_list'));
            }
        }
    }
    /**
     * 模型删除
     */
    public function model_del()
    {
        $model_id=input('model_id');
        $model=Db::name('model')->where('model_id',$model_id)->find();
        if (empty($model)){
            $this->error('参数错误',url('admin/Model/model_list'));
        }else{
            //备份
            static $db = null;
            static $db_prefix = null;
            $db_prefix = config('database.prefix');
            if (null === $db) {
                $db = Db::connect([], true);
            }
            $tablename=$model['model_name'];
            $path=ROOT_PATH.'data/backup/';
            if (!file_exists($path)) {
                @mkdir($path,0777,true);
            }
            $content=db_get_insert_sqls($model['model_name']);
            file_put_contents($path.$db_prefix.$tablename.'.sql', $content);
            //删除
            $sql="DROP TABLE `$db_prefix$tablename`;";
            $rst=$db->execute($sql);
            if($rst===false){
                $this -> error("模型删除失败！",url('admin/Model/model_list'));
            }
            //删模型
            $rst=Db::name('model')->where('model_id',$model_id)->delete();
            //删权限菜单
            if($rst!==false){
                $rule=Db::name('auth_rule')->where('name','Model/cmslist?id='.$model_id)->find();
                if($rule){
                    $pid=$rule['pid'];//顶级菜单
                    $arr=Db::name('auth_rule')->select();
                    $tree=new \Tree();
                    $tree->init($arr,['parentid'=>'pid']);
                    $arrTree=$tree->get_childs($arr,$pid,true,true);
                    if($arrTree){
                        Db::name('auth_rule')->where('id','in',$arrTree)->delete();
                        Cache::clear();
                    }
                }

                $this->success('模型删除成功',url('admin/Model/model_list'));
            }else{
                $this -> error("模型删除失败！",url('admin/Model/model_list'));
            }
        }
    }
    /**
     * 模型添加
     */
    public function model_add()
    {
		return $this->fetch();
	}
    /**
     * 模型添加操作
     */
    public function model_runadd()
    {
		static $db = null;
        static $db_prefix = null;
        $db_prefix = config('database.prefix');
        if (null === $db) {
            $db = Db::connect([], true);
        }
        //表名
        $model_name = input('model_name', '');
        if (empty ($model_name)) {
            $this->error('请设置模型名');
        }
		$rst=$db->name('model')->where('model_name',$model_name)->find();
        if($rst){
            $this->error('已存在'.$model_name.'标识的模型');
        }		
        //主键
        $model_pk = input('model_pk', '');
        if (empty ($model_pk)) {
            $this->error('请设置主键');
        }
        //引擎
        $model_engine = input('model_engine', 'MyISAM');
        //字段数组,2维[0][字段名,字段标题,字段类型,字段数据,字段说明,字段长度,字段规则,默认值]
		$fields=input('fields');
		$model_fields=$fields?$this->fields(json_decode($fields,true)):array();
        if (empty ($model_fields)) {
            $this->error('请设置模型字段');
        }
		$fields=json_encode($model_fields);
        //保存到model数据表中
        $sl_data=array(
            'model_name'=>$model_name,
            'model_title'=>input('model_title',''),
            'model_pk'=>$model_pk,
            'model_cid'=>input('model_cid',$model_name.'_cid'),
            'model_order'=>input('model_order',$model_name.'_order'),
            'model_sort'=>input('model_sort',$model_name.'_order'),
            'model_fields'=>$fields,
			'model_list'=>input('model_list',''),
			'model_edit'=>input('model_edit',''),
            'model_indexes'=>input('model_indexes',''),
            'search_list'=>input('search_list',''),
            'create_time'=>time(),
            'update_time'=>time(),
            'model_status'=>1,
            'model_engine'=>$model_engine

        );
        $model_id=$db->name('model')->insertGetId($sl_data);
        if($model_id===false){
            $this->error('创建模型失败');
        }
        //加上cid order字段
        $model_fields[input('model_cid',$model_name.'_cid')]=array(
            'name'=>input('model_cid',$model_name.'_cid'),
            'title'=>'前台栏目',
            'type'=>'selecttext',
            'data'=>'menu|id|menu_name|id',
            'description'=>'前台栏目',
            'length'=>100,
            'rules'=>'',
            'default'=>''
        );
        $model_fields[input('model_order',$model_name.'_order')]=array(
            'name'=>input('model_cid',$model_name.'_order'),
            'title'=>'排序',
            'type'=>'number',
            'data'=>'',
            'description'=>'排序,越小越靠前',
            'length'=>3,
            'rules'=>'',
            'default'=>50
        );
		//删除
		$sql="DROP TABLE IF EXISTS `$db_prefix$model_name`;";
		$db->execute($sql);
        switch (config('database.type')) {
            case 'mysql' :
                //创建
                $sql = ("CREATE TABLE `$db_prefix$model_name` (
                    `$model_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                    %FIELDS_SQL%
                    %PRIMARY_KEY_SQL%
                    %UNIQUE_KEY_SQL%
                    %KEY_SQL%
                    ) ENGINE=$model_engine AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;");

                $sql_fields = array();
                $sql_primary_key = "PRIMARY KEY (`$model_pk`)";
                $sql_unique_key = array();
                $sql_key = array();

                foreach ($model_fields as $f=>$fi) {
                    $rules = explode(',', str_replace(' ', '', $fi ['rules']));
                    switch ($fi ['type']) {
                        //百度地图字段，双精度型
                        case 'baidu_map':
                            $defaults = explode(',', $fi['default']);
                            $sql_fields [] = "`${f}_lng` DOUBLE NOT NULL DEFAULT ".($defaults[0]?"$defaults[0]":"0")." COMMENT '$fi[title]'";
                            $sql_fields [] = "`${f}_lat` DOUBLE NOT NULL DEFAULT ".($defaults[1]?"$defaults[1]":"0")." COMMENT '$fi[title]'";
                            break;
                        //变长或固定字符串型
                        case 'text' :
                        case 'imagefile' :
                        case 'file' :
                        case 'selecttext' :
                        case 'checkbox' :
                            if (empty ($fi ['length'])) {
                                $fi ['length'] = 200;
                            }
                            $ftype = 'VARCHAR';
                            //固定长度
                            if (in_array('lengthfixed', $rules)) {
                                $ftype = 'CHAR';
                            }
                            $fnull = '';
                            //非空
                            if (in_array('required', $rules)) {
                                $fnull = 'NOT NULL';
                                $fi['default']=$fi['default']?:'未填写';
                            }
                            $sql_fields [] = "`$f` $ftype($fi[length]) $fnull DEFAULT '$fi[default]' COMMENT '$fi[title]'";
                            break;
                        //bigint型
                        case 'currency':
                        case 'large_number':
                            $funsigned = '';
                            //非负数
                            if (in_array('unsigned', $rules)) {
                                $funsigned = 'UNSIGNED';
                            }
                            $fnull = '';
                            if (in_array('required', $rules)) {
                                $fnull = 'NOT NULL';
                                $fi['default']=isset($fi['default'])?$fi['default']:'0';
                            }
                            $sql_fields [] = "`$f` BIGINT $funsigned $fnull ".($fi['default']?"DEFAULT $fi[default]":"")." COMMENT '$fi[title]'";
                            break;
                        //整数型
                        case 'number' :
                        case 'datetime' :
                        case 'date' :
                        case 'selectnumber' :
                            $funsigned = '';
                            if (in_array($fi ['type'], array(
                                    'date',
                                    'datetime'
                                )) || in_array('unsigned', $rules)
                            ) {
                                $funsigned = 'UNSIGNED';
                            }
                            $fnull = '';
                            if (in_array('required', $rules)) {
                                $fnull = 'NOT NULL';
                                $fi['default']=isset($fi['default'])?$fi['default']:'0';
                            }
                            $sql_fields [] = "`$f` INT $funsigned $fnull ".($fi['default']?"DEFAULT $fi[default]":"")." COMMENT '$fi[title]'";
                            break;
                        //text型
                        case 'richtext' :
                        case 'bigtext' :
                        case 'images':
                        case 'files':
                            $sql_fields [] = "`$f` TEXT COMMENT '$fi[title]'";
                            break;
                        //TINYINT型
                        case 'switch' :
                            $sql_fields [] = "`$f` TINYINT UNSIGNED NOT NULL DEFAULT ".($fi['default']?"1":"0")." COMMENT '$fi[title]'";
                            break;
                        default :
                            $this->error('不能识别字段类型');
                    }
                    if (in_array($fi ['type'], array(
                        'switch',
                        'text',
                        'number',
                        'datetime',
                        'date',
                        'selecttext',
                        'selectnumber',
                        'checkbox'
                    ))) {
                        //不重复
                        if (in_array('unique', $rules)) {
                            $sql_unique_key [] = "UNIQUE KEY $f ($f)";
                        }
                    }
                }
                //索引数组
                $model_indexes=input('model_indexes','')?explode(',',input('model_indexes','')):array();
                if (!empty($model_indexes)) {
                    foreach ($model_indexes as $indexes) {
                        $sql_key[] = "INDEX IX_" . join('_', $indexes) . "(" . join(',', $indexes) . ")";
                    }
                }
                //替换sql语句
                $sql = str_replace(array(
                    '%FIELDS_SQL%',
                    '%PRIMARY_KEY_SQL%',
                    '%UNIQUE_KEY_SQL%',
                    '%KEY_SQL%'
                ), array(
                    join(",\n", $sql_fields) . ((empty ($sql_primary_key) && empty ($sql_unique_key) && empty ($sql_key)) ? '' : ",\n"),
                    $sql_primary_key . ((empty ($sql_primary_key) || (empty ($sql_unique_key) && empty ($sql_key))) ? '' : ",\n"),
                    join(",\n", $sql_unique_key) . ((empty ($sql_unique_key) || empty ($sql_key)) ? '' : ",\n"),
                    join(",\n", $sql_key)
                ), $sql);
                $rst=$db->execute($sql);//创建模型数据表
                if($rst===false){
                    //删除model里的数据
                    Db::name('model')->delete($model_id);
                    $this->error('创建模型失败');
                }
                break;
            //TODO mysql以外数据类型
            default :
                $this->error('不支持的数据库类型');
        }
        $this->success('创建模型成功',url('admin/Model/model_list'));
    }
    /**
     * 模型编辑
     */
    public function model_edit()
    {
		$model_id = input('model_id');
		$model=Db::name('model')->where('model_id',$model_id)->find();
		$fields=json_decode($model['model_fields'],true);
		$this->assign('model',$model);
		$this->assign('fields',$fields);
		return $this->fetch();
	}
    /**
     * 模型复制
     */
    public function model_copy()
    {
        $model_id = input('model_id');
        $model=Db::name('model')->where('model_id',$model_id)->find();
        $fields=json_decode($model['model_fields'],true);
        $this->assign('model',$model);
        $this->assign('fields',$fields);
        return $this->fetch();
    }
    /**
     * 模型编辑操作
     */
    public function model_runedit()
    {
		static $db = null;
        static $db_prefix = null;
        $db_prefix = config('database.prefix');
        if (null === $db) {
            $db = Db::connect([], true);
        }
        $model_id = input('model_id', 0);
		$old_model=$db->name('model')->where('model_id',$model_id)->find();
		if(empty($old_model)){
			$this->error('模型不存在');
		}
		//表名
        $model_name = input('model_name', '');
        if (empty ($model_name)) {
            $this->error('请设置模型名');
        }
        //主键
        $model_pk = input('model_pk', '');
        if (empty ($model_pk)) {
            $this->error('请设置主键');
        }
        //引擎
        $model_engine = input('model_engine', 'MyISAM');
        //字段数组,2维[0][字段名,字段标题,字段类型,字段数据,字段说明,字段长度,字段规则,默认值]
		$fields=input('fields');
		$model_fields=$fields?$this->fields(json_decode($fields,true)):array();
        if (empty ($model_fields)) {
            $this->error('请设置模型字段');
        }
		$fields=json_encode($model_fields);
        //保存到model数据表中
        $sl_data=array(
            'model_name'=>$model_name,
            'model_title'=>input('model_title',''),
            'model_pk'=>$model_pk,
            'model_cid'=>input('model_cid',$model_name.'_cid'),
            'model_order'=>input('model_order',$model_name.'_order'),
            'model_sort'=>input('model_sort',$model_name.'_order'),
            'model_fields'=>$fields,
			'model_list'=>input('model_list',''),
			'model_edit'=>input('model_edit',''),
            'model_indexes'=>input('model_indexes',''),
            'search_list'=>input('search_list',''),
            'update_time'=>time(),
            'model_status'=>1,
            'model_engine'=>$model_engine

        );
        $old_table=$old_model['model_name'];
        if($this->build_table_exists($old_table)){
            //备份
            $path=ROOT_PATH.'data/backup/';
            if (!file_exists($path)) {
                @mkdir($path,0777,true);
            }
            $content=db_get_insert_sqls($old_table);
            file_put_contents($path.$db_prefix.$old_table.'.sql', $content);
            //修改为临时文件名
            if($db->execute("RENAME TABLE `$db_prefix$old_table` TO `$db_prefix$old_table"."_temp`;")!==false){
                $old_table=$old_table.'_temp';
            }
        }
        //加上cid order字段
        $model_fields[input('model_cid',$model_name.'_cid')]=array(
            'name'=>input('model_cid',$model_name.'_cid'),
            'title'=>'前台栏目',
            'type'=>'selecttext',
            'data'=>'menu|id|menu_name|id',
            'description'=>'前台栏目',
            'length'=>100,
            'rules'=>'',
            'default'=>''
        );
        $model_fields[input('model_order',$model_name.'_order')]=array(
            'name'=>input('model_cid',$model_name.'_order'),
            'title'=>'排序',
            'type'=>'number',
            'data'=>'',
            'description'=>'排序,越小越靠前',
            'length'=>3,
            'rules'=>'',
            'default'=>50
        );
		//删除
		$sql="DROP TABLE IF EXISTS `$db_prefix$model_name`;";
		$db->execute($sql);
        switch (config('database.type')) {
            case 'mysql' :
                //重新创建
                $sql = ("CREATE TABLE `$db_prefix$model_name` (
                    `$model_pk` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                    %FIELDS_SQL%
                    %PRIMARY_KEY_SQL%
                    %UNIQUE_KEY_SQL%
                    %KEY_SQL%
                    )ENGINE=$model_engine AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;");
                $sql_fields = array();
                $sql_primary_key = "PRIMARY KEY (`$model_pk`)";
                $sql_unique_key = array();
                $sql_key = array();
                foreach ($model_fields as $f=>$fi) {
                    $rules = explode(',', str_replace(' ', '', $fi ['rules']));
                    switch ($fi ['type']) {
                        //百度地图字段，双精度型
                        case 'baidu_map':
                            $defaults = explode(',', $fi['default']);
                            $sql_fields [] = "`${f}_lng` DOUBLE NOT NULL DEFAULT ".($defaults[0]?"$defaults[0]":"0")." COMMENT '$fi[title]'";
                            $sql_fields [] = "`${f}_lat` DOUBLE NOT NULL DEFAULT ".($defaults[1]?"$defaults[1]":"0")." COMMENT '$fi[title]'";
                            break;
                        //变长或固定字符串型
                        case 'text' :
                        case 'imagefile' :
                        case 'file' :
                        case 'selecttext' :
                        case 'checkbox' :
                            if (empty ($fi ['length'])) {
                                $fi ['length'] = 200;
                            }
                            $ftype = 'VARCHAR';
                            //固定长度
                            if (in_array('lengthfixed', $rules)) {
                                $ftype = 'CHAR';
                            }
                            $fnull = '';
                            //非空
                            if (in_array('required', $rules)) {
                                $fnull = 'NOT NULL';
                                $fi['default']=$fi['default']?:'未填写';
                            }
                            $sql_fields [] = "`$f` $ftype($fi[length]) $fnull DEFAULT '$fi[default]' COMMENT '$fi[title]'";
                            break;
                        //bigint型
                        case 'currency':
                        case 'large_number':
                            $funsigned = '';
                            //非负数
                            if (in_array('unsigned', $rules)) {
                                $funsigned = 'UNSIGNED';
                            }
                            $fnull = '';
                            if (in_array('required', $rules)) {
                                $fnull = 'NOT NULL';
                                $fi['default']=isset($fi['default'])?$fi['default']:'0';
                            }
                            $sql_fields [] = "`$f` BIGINT $funsigned $fnull ".($fi['default']?"DEFAULT $fi[default]":"")." COMMENT '$fi[title]'";
                            break;
                        //整数型
                        case 'number' :
                        case 'datetime' :
                        case 'date' :
                        case 'selectnumber' :
                            $funsigned = '';
                            if (in_array($fi ['type'], array(
                                    'date',
                                    'datetime'
                                )) || in_array('unsigned', $rules)
                            ) {
                                $funsigned = 'UNSIGNED';
                            }
                            $fnull = '';
                            if (in_array('required', $rules)) {
                                $fnull = 'NOT NULL';
                                $fi['default']=isset($fi['default'])?$fi['default']:'0';
                            }
                            $sql_fields [] = "`$f` INT $funsigned $fnull ".($fi['default']?"DEFAULT $fi[default]":"")." COMMENT '$fi[title]'";
                            break;
                        //text型
                        case 'richtext' :
                        case 'bigtext' :
                        case 'images':
                        case 'files':
                            $sql_fields [] = "`$f` TEXT COMMENT '$fi[title]'";
                            break;
                        //TINYINT型
                        case 'switch' :
                            $sql_fields [] = "`$f` TINYINT UNSIGNED NOT NULL DEFAULT ".($fi['default']?"1":"0")." COMMENT '$fi[title]'";
                            break;
                        default :
                            $this->error('不能识别字段类型');
                    }
                    if (in_array($fi ['type'], array(
                        'switch',
                        'text',
                        'number',
                        'datetime',
                        'date',
                        'selecttext',
                        'selectnumber',
                        'checkbox'
                    ))) {
                        //不重复
                        if (in_array('unique', $rules)) {
                            $sql_unique_key [] = "UNIQUE KEY $f ($f)";
                        }
                    }
                }
                //索引数组
                $model_indexes=input('model_indexes','')?explode(',',input('model_indexes','')):array();
                if (!empty($model_indexes)) {
                    foreach ($model_indexes as $indexes) {
                        $sql_key[] = "INDEX IX_" . join('_', $indexes) . "(" . join(',', $indexes) . ")";
                    }
                }
                //替换sql语句
                $sql = str_replace(array(
                    '%FIELDS_SQL%',
                    '%PRIMARY_KEY_SQL%',
                    '%UNIQUE_KEY_SQL%',
                    '%KEY_SQL%'
                ), array(
                    join(",\n", $sql_fields) . ((empty ($sql_primary_key) && empty ($sql_unique_key) && empty ($sql_key)) ? '' : ",\n"),
                    $sql_primary_key . ((empty ($sql_primary_key) || (empty ($sql_unique_key) && empty ($sql_key))) ? '' : ",\n"),
                    join(",\n", $sql_unique_key) . ((empty ($sql_unique_key) || empty ($sql_key)) ? '' : ",\n"),
                    join(",\n", $sql_key)
                ), $sql);
				$rst=$db->execute($sql);
                if($rst===false){
                    //改回原来的数据表
                    $db->execute("RENAME TABLE `$db_prefix$old_table` TO `$db_prefix{$old_model['model_name']}`;");
                    $this->error('编辑模型失败');
                }else{
                    $rst=$db->name('model')->where('model_id',$model_id)->update($sl_data);
                    if($rst===false){
					    $sql="DROP TABLE IF EXISTS `$db_prefix$model_name`;";
                        $db->execute($sql);
                        $sql="RENAME TABLE `$db_prefix$old_table` TO `$db_prefix{$old_model['model_name']}`;";
                        $db->execute($sql);
                        $this->error('编辑模型失败');
                    }else{
						//删除改名的数据表
						$sql="DROP TABLE IF EXISTS `$db_prefix$old_table`;";
                        $db->execute($sql);
                    }
                }
                break;
            //TODO mysql以外数据类型
            default :
                $this->error('不支持的数据库类型');
        }
        $this->success('编辑模型成功，原数据已备份',url('admin/Model/model_list'));
    }
    /**
     * 具体模型数据列表
     */
    public function cmslist()
    {
        $model_id=input('id',0);
        $keyy=input('key','');
        if(!$this->cms_init($model_id,false,true,true)){
            $this->error('不存在的模型');
        }
		//栏目过滤
        $map=array();
        $model_cid=input($this->cms_cid,'');
        if ($model_cid!=''){
            $ids=get_menu_byid($model_cid,1,2);
            $map[$this->cms_cid]= array('in',implode(",", $ids));
        }
        //处理搜索字段
        $where='';
		if(!empty($keyy)){
            $where=join('|',$this->cms_fields_search);
        }
        $order=$this->cms_model['model_sort']?:$this->cms_model['model_order'];
		if($where){
            $data=Db::name($this->cms_table)->where($map)->where($where,'like',"%".$keyy."%")->field(join(',',$this->cms_fields_list))->order($order)->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
        }else{
            $data=Db::name($this->cms_table)->where($map)->field(join(',',$this->cms_fields_list))->order($order)->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
        }
		//处理分页
		$show = $data->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
		//处理数据
		$data_list = array();
		foreach($data as &$v){
			$item=array();
			foreach($v as $kk=>$vv){
				if ($kk == $this->cms_pk) {
					$item [$kk] = $vv;
					continue;
				}
				switch ($this->cms_fields [$kk] ['type']) {
					case 'images':
						$images = array();
						if ($vv) {
							foreach (explode(',', $vv) as $vvv) {
								$images[] = '<img src="' . get_imgurl($vvv) . '" style="max-width:40px;max-height:40px;" /></a>';
							}
							$item [$kk] = join(' ', $images);
						} else {
							$item [$kk] = '';
						}
						break;
					case 'text' :
					case 'number' :
					case 'large_number':
					    $item [$kk] = htmlspecialchars($vv);
                        break;
					case 'currency':
						$item[$kk] = long_currency((float)$vv);
						break;
					case 'datetime' :
						$item [$kk] = date('Y-m-d H:i:s', $vv);
						break;	
					case 'date' :
						$item [$kk] = date('Y-m-d', $vv);
						break;	
					case 'imagefile' :
						if ($vv) {
							$item [$kk] = '<img src="' . get_imgurl($vv) . '" style="max-width:40px;max-height:40px;" /></a>';
						} else {
							$item [$kk] = '';
						}
						break;	
					case 'switch' :
						if ($vv) {
							$item [$kk] = '<a class="red open-btn" href="'.url('admin/Model/cmsstate',['key'=>$kk,'id'=>$model_id]).'" data-id="'.$v[$this->cms_pk].'" title="已开启"><div><button class="btn btn-minier btn-yellow">开启</button></div></a>';
						} else {
							$item [$kk] = '<a class="red open-btn" href="'.url('admin/Model/cmsstate',['key'=>$kk,'id'=>$model_id]).'" data-id="'.$v[$this->cms_pk].'" title="已禁用"><div><button class="btn btn-minier btn-danger">禁用</button></div></a>';
						}
						break;
					case 'bigtext' :
					case 'richtext' :
						$item [$kk] = htmlspecialchars(html_trim($vv,20));
						break;	
					case 'selecttext' :
					case 'selectnumber' :
					case 'checkbox' :
						$item [$kk] = $this->cms_field_option_get_titles($this->cms_fields [$kk] ['data'], explode(',', $vv));
						$item [$kk] = htmlspecialchars(join(',', $item [$kk]));
						break;
					case 'baidu_map':
						$item[$kk] = htmlspecialchars($vv);
						break;
                    //文件
                    case 'file':
                        if ($vv) {
                            $item [$kk] = '<a href="' . get_imgurl($vv) . '" target="_blank">查看</a>';
                        } else {
                            $item [$kk] = '';
                        }
                        break;
                    //多文件
                    case 'files':
                        $files = array();
                        if ($vv) {
                            foreach (explode(',', $vv) as $vvv) {
                                $files[] = '<a href="' . get_imgurl($vvv) . '" target="_blank">查看</a>';
                            }
                            $item [$kk] = join(' ', $files);
                        } else {
                            $item [$kk] = '';
                        }
                        break;
				}
			}
			$data_list[]= $item;
		}
		//字段数组
        $fields=array();
        foreach ($this->cms_fields_list as $key){
            $fields[$key]=$this->cms_fields[$key];
        }
        //栏目数据
        $map=[];
        if(!config('lang_switch_on')){
            $map['menu_l']=  $this->lang;
        }
        $menu_next=Db::name('menu')->where('menu_type <> 4 and menu_type <> 2')->where($map)-> order('menu_l desc,listorder') -> select();
        $arr = menu_left($menu_next,'id','parentid');
        $this->assign('menu',$arr);
        $this->assign('model_cid',$model_cid);
		$this->assign('page',$show);
		$this->assign('data',$data_list);
		$this->assign('model_id', $model_id);
		$this->assign('model', $this->cms_model);
        $this->assign('keyy', $keyy);
		$this->assign('fields', $fields);
		if(request()->isAjax()){
			return $this->fetch('ajax_cmslist');
		}else{
			return $this->fetch();
		}
    }
    /**
     * 具体模型数据添加
     */
    public function cmsadd()
    {
        $model_id=input('id',0);
        if(!$this->cms_init($model_id)){
            $this->error('不存在的模型');
        }
        $model_cid=input($this->cms_cid,0);
        $data=array_reduce($this->cms_fields, create_function('$v,$w', '$v[$w["name"]]=$w["default"];return $v;'));
        $fields_data=$this->handle_data($model_id,$this->cms_allfields,$data);
		$this->assign('model_id',$model_id);
		$this->assign('model',$this->cms_model);
        $this->assign('model_cid',$model_cid);
		$this->assign('fields_data', $fields_data);
		return $this->fetch();
    }
    /**
     * 具体模型数据添加操作
     */
    public function cmsrunadd()
    {
        $model_id=input('id',0);
        if(!$this->cms_init($model_id)){
            $this->error('不存在的模型');
        }
        $postdata=$this->handle_postdata(0,$this->cms_allfields,false,true);
        $rst=Db::name($this->cms_table)->insert($postdata);
        if($rst!==false){
            $this->success('增加成功',url('admin/Model/cmslist',['id'=>$model_id]));
        }else{
            $this->error('增加失败');
        }
    }
    /**
     * 具体模型数据编辑
     */
    public function cmsedit()
    {
        $model_id=input('id',0);
        if(!$this->cms_init($model_id,true)){
            $this->error('不存在的模型');
        }
		//主键id
		$model_pkid=input($this->cms_pk,0);
        $data=Db::name($this->cms_table)->where($this->cms_pk,$model_pkid)->find();
        $model_cid=$data[$this->cms_cid];
        $fields_data=$this->handle_data($model_id,$this->cms_fields_edit,$data);
		$this->assign('model_pkid',$model_pkid);
		$this->assign('model_id',$model_id);
		$this->assign('model',$this->cms_model);
        $this->assign('model_cid',$model_cid);
		$this->assign('fields_data', $fields_data);
		return $this->fetch();
	}
    /**
     * 具体模型数据编辑操作
     */
    public function cmsrunedit()
    {
        $model_id=input('id',0);
        if(!$this->cms_init($model_id,true)){
            $this->error('不存在的模型');
        }
        $model_pkid=input($this->cms_pk,0);
        $postdata=$this->handle_postdata($model_pkid,$this->cms_fields_edit,true);
        $rst=Db::name($this->cms_table)->where($this->cms_pk,$model_pkid)->update($postdata);
        if($rst!==false){
            $this->success('修改成功',url('admin/Model/cmslist',['id'=>$model_id]));
        }else{
            $this->error('修改失败');
        }
    }
    /**
     * 具体模型数据删除(单个)
     */
    public function cmsdel()
    {
        $model_id=input('id',0);
        $model=Db::name('model')->where('model_id',$model_id)->find();
        if(empty($model)){
            $this->error('不存在的模型');
        }
        //主键id
        $model_pkid=input($model['model_pk'],0);
        $rst=Db::name($model['model_name'])->where($model['model_pk'],$model_pkid)->delete();
        if($rst!==false){
            $this->success('删除成功',url('admin/Model/cmslist',['id'=>$model_id]));
        }else{
            $this -> error("删除失败！",url('admin/Model/cmslist',['id'=>$model_id]));
        }
    }
    /**
     * 具体模型数据全选删除
     */
    public function cmsalldel()
    {
        $model_id=input('id',0);
        $model=Db::name('model')->where('model_id',$model_id)->find();
        if(empty($model)){
            $this->error('不存在的模型');
        }
        $ids = input($model['model_pk'].'/a');
        if(empty($ids)){
            $this -> error("请选择要删除的ID",url('admin/Model/cmslist',['id'=>$model_id]));
        }
        $ids=is_array($ids)?$ids:(array)$ids;
        $rst=Db::name($model['model_name'])->where($model['model_pk'],'in',$ids)->delete();
        if($rst!==false){
            $this->success("全部删除成功",url('admin/Model/cmslist',['id'=>$model_id]));
        }else{
            $this -> error("删除失败！",url('admin/Model/cmslist',['id'=>$model_id]));
        }
    }
    /**
     * 具体模型数据状态操作
     */
    public function cmsstate()
    {
        $model_id=input('id',0);
        $model=Db::name('model')->where('model_id',$model_id)->find();
        if(empty($model)){
            $this->error('不存在的模型');
        }
        $model_pkid=input('x');
        $key=input('key');
        $status=Db::name($model['model_name'])->where($model['model_pk'],$model_pkid)->value($key);//判断当前状态情况
        if($status==1){
            $statedata = array($key=>0);
            Db::name($model['model_name'])->where($model['model_pk'],$model_pkid)->setField($statedata);
            $this->success('状态禁止');
        }else{
            $statedata = array($key=>1);
            Db::name($model['model_name'])->where($model['model_pk'],$model_pkid)->setField($statedata);
            $this->success('状态开启');
        }
    }
    /**
     * 具体模型数据排序
     */
	public function cmsorder()
    {
		$model_id=input('id',0);
		$model=Db::name('model')->where('model_id',$model_id)->find();
		if(empty($model)){
			$this->error('不存在的模型');
		}
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Model/cmslist',['id'=>$model_id]));
		}else{
			foreach (input('post.') as $cms_id => $cms_order){
				Db::name($model['model_name'])->where($model['model_pk'],$cms_id)->setField($model['model_order'] , $cms_order);
			}
			$this->success('排序更新成功',url('admin/Model/cmslist',['id'=>$model_id]));
		}
    }
    //model_fields处理
    private function fields($fields)
    {
        $rst=array();
		foreach($fields as $v){
			//[字段名,字段标题,字段类型,字段数据,字段说明,字段长度,字段规则,默认值]
			$rst[$v[0]]=array(
			    'name'=>$v[0],
                'title'=>$v[1],
                'type'=>$v[2],
                'data'=>$v[3],
                'description'=>$v[4],
                'length'=>$v[5],
                'rules'=>$v[6],
                'default'=>$v[7]
            );
		}
		return $rst;
    }
	//字段选项取标题
	private function cms_field_option_get_titles($data, $value)
	{
		if (!is_array($value)) {
			$value = array(
				$value
			);
		}
		$value = array_unique($value);
		$rets = array();
		if (!empty ($value)) {
			if(stripos($data,'|') != false){
				@list ($model, $vfield, $vtitle,$sort,$where)=explode('|', $data);
				$fields=Db::name($model)->field($vtitle)->where($vfield,'in',$value)->where($where)->order($sort)->select();
				foreach ($fields as $v){
					$rets [] = $v [$vtitle];
				}
			}else{
				$arr=explode(',', $data);
				$data=array();
				foreach ($arr as $v) {
					@list($kk,$vv)=explode(':', $v);
					$data[$kk]=$vv;
				}
				foreach ($value as $v) {
					$rets [] = isset ($data [$v]) ? $data [$v] : $v;
				}
			}
		}
		return $rets;
	}
	//字段选项转换成数组
	private function cms_field_option_conv($data)
	{
        $rets = array();
	    if(stripos($data,'|') != false){
            @list ($model, $vfield, $vtitle,$sort,$where)=explode('|', $data);
            $fields=Db::name($model)->field($vfield . ',' . $vtitle)->where($where)->order($sort)->select();
            foreach ($fields as $v){
                $rets [$v [$vfield]] = $v [$vtitle];
            }
        }else{
            $arr=explode(',', $data);
            foreach ($arr as $v) {
                @list($kk,$vv)=explode(':', $v);
                $rets[$kk]=$vv;
            }
        }
        return $rets;
	}
    //检测字段选项是否有效
    private function cms_field_option_valid($data, $value)
    {
        $data=$this->cms_field_option_conv($data);
        if (!is_array($value)) {
            $value = array($value);
        }
        $value = array_unique($value);//去重复
        if (!empty ($value)) {
            foreach ($value as $v) {
                if (!isset ($data [$v])) {
                    return false;
                }
            }
        }
        return true;
    }
    //判断表是否存在
	protected function build_table_exists($table)
    {
        static $tables = null;
        static $db_prefix = null;

        $db_prefix = config('database.prefix');
        if (null === $tables) {
            $tables = db_get_tables(true);
        }

        if (in_array($db_prefix . $table, $tables)) {
            return true;
        }
        return false;
    }
    //初始化
    protected function cms_init($model_id,$is_edit=false,$is_search=false,$is_list=false)
    {
        $model=Db::name('model')->find($model_id);
        if($model){
            $this->cms_pk=$model['model_pk'];
            $this->cms_model=$model;
            $this->cms_table=$model['model_name'];
            $this->cms_cid=$model['model_cid'];
            $this->cms_db_engine=$model['model_engine'];
            $this->cms_fields[$model['model_pk']]=[
                'name'=>$model['model_pk'],
                'title'=>'ID',
                'type'=>'number',
                'data'=>'',
                'description'=>'',
                'length'=>'',
                'rules'=>'',
                'default'=>''];
            $this->cms_fields[$model['model_order']]=[
                'name'=>$model['model_order'],
                'title'=>'排序',
                'type'=>'number',
                'data'=>'',
                'description'=>'排序,越小越靠前',
                'length'=>3,
                'rules'=>'',
                'default'=>50];
            $this->cms_fields[$model['model_cid']]=[
                'name'=>$model['model_cid'],
                'title'=>'前台栏目',
                'type'=>'selecttext',
                'data'=>'menu|id|menu_name|id',
                'description'=>'前台栏目',
                'length'=>100,
                'rules'=>'',
                'default'=>''];
            $this->cms_fields=array_merge($this->cms_fields,$model['model_fields']?json_decode($model['model_fields'],true):array());
            //处理baidu_map
            $fields=array();
            foreach ($this->cms_fields as $key=>$field){
                if($field['type']=='baidu_map'){
                    @list($lng,$lat)=explode(',',$field['default']);
                    $field['name']=$this->cms_fields[$key]['name'].'_lng';
                    $field['description']=$this->cms_fields[$key]['description'].'(lng)';
                    $fields[$key.'_lng']=$field;
                    $fields[$key.'_lng']['default']=$lng;
                    $field['name']=$this->cms_fields[$key]['name'].'_lat';
                    $field['description']=$this->cms_fields[$key]['description'].'(lat)';
                    $fields[$key.'_lat']=$field;
                    $fields[$key.'_lat']['default']=$lat;
                    unset($this->cms_fields[$key]);
                }
            }
            if($fields){
                $this->cms_fields=array_merge($this->cms_fields,$fields);
            }
            $this->cms_allfields=array_keys($this->cms_fields);
            if($is_edit){
                $this->cms_fields_edit=$model['model_edit']?explode(',',$model['model_edit']):array();
                if(empty($this->cms_fields_edit)){
                    $this->cms_fields_edit=$this->cms_allfields;
                }else{
                    //处理baidu_map
                    $fields=array();
                    foreach ($this->cms_fields_edit as $key=>$v){
                        if($this->cms_fields[$v]['type']=='baidu_map'){
                            $fields[]=$v.'_lng';
                            $fields[]=$v.'_lat';
                            unset($this->cms_fields_edit[$key]);
                        }
                    }
                    if($fields){
                        $this->cms_fields_edit=array_merge($this->cms_fields_edit,$fields);
                    }
                    $this->cms_fields_edit=array_intersect($this->cms_fields_edit,$this->cms_allfields);
                }
            }
            if($is_search){
                $this->cms_fields_search=$model['search_list']?explode(',',$model['search_list']):array();
                if(empty($this->cms_fields_search)){
                    $this->cms_fields_search=$this->cms_allfields;
                }else{
                    //处理baidu_map
                    $fields=array();
                    foreach ($this->cms_fields_search as $key=>$v){
                        if($this->cms_fields[$v]['type']=='baidu_map'){
                            $fields[]=$v.'_lng';
                            $fields[]=$v.'_lat';
                            unset($this->cms_fields_search[$key]);
                        }
                    }
                    if($fields){
                        $this->cms_fields_search=array_merge($this->cms_fields_search,$fields);
                    }
                    $this->cms_fields_search=array_intersect($this->cms_fields_search,$this->cms_allfields);
                }
            }
            if($is_list){
                $this->cms_fields_list=$model['model_list']?explode(',',$model['model_list']):array();
                if(empty($this->cms_fields_list)){
                    $this->cms_fields_list=$this->cms_allfields;
                }else{
                    //处理baidu_map
                    $fields=array();
                    foreach ($this->cms_fields_list as $key=>$v){
                        if($this->cms_fields[$v]['type']=='baidu_map'){
                            $fields[]=$v.'_lng';
                            $fields[]=$v.'_lat';
                            unset($this->cms_fields_list[$key]);
                        }
                    }
                    if($fields){
                        $this->cms_fields_list=array_merge($this->cms_fields_list,$fields);
                    }
                    $this->cms_fields_list=array_intersect($this->cms_fields_list,$this->cms_allfields);
                    $this->cms_fields_list=array_merge([$model['model_pk'],$model['model_order'],$model['model_cid']],$this->cms_fields_list);
                }
            }
            return true;
        }else{
            return false;
        }
    }
    //处理cms的add edit的值、option数据
    protected function handle_data($model_id,$fields,$data)
    {
        $fields_data = array();
        foreach ($fields as $k) {
            //主键跳过
            if($k==$this->cms_pk){
                continue;
            }
            $fields_data [$k] = $this->cms_fields [$k];
            $fields_data [$k] ['rules'] = explode(',', $fields_data [$k] ['rules']);
            switch ($fields_data [$k] ['type']) {
                case 'images':
                    $fields_data [$k] ['images'] = array_filter(explode(",", $data [$k]));
                    $fields_data [$k] ['value'] = join(',',$fields_data [$k] ['images']);
                    break;
                case 'files':
                    $fields_data [$k] ['files'] = array_filter(explode(",", $data [$k]));
                    $fields_data [$k] ['value'] = $fields_data [$k] ['files'];
                    break;
                case 'baidu_map':
                    if(isset($data[$k])){
                        $fields_data [$k] ['value'] = $data [$k];
                    }else{
                        $fields_data [$k] ['value'] = $fields_data [$k] ['default'];
                    }
                    break;
                case 'text' :
                case 'number' :
                case 'switch' :
                case 'bigtext' :
                case 'richtext' :
                case 'large_number' :
                case 'imagefile' :
                case 'file' :
                    $fields_data [$k] ['value'] = $data [$k];
                    break;
                case 'date' :
                case 'datetime' :
                    $fields_data [$k] ['value'] = $data [$k];
                    if (empty ($fields_data [$k] ['value'])) {
                        $fields_data [$k] ['value'] = time();
                    }
                    break;
                case 'currency':
                    $fields_data [$k] ['value'] = long_currency((float)$data [$k]);
                    break;
                case 'selectnumber' :
                case 'selecttext' :
                    $fields_data [$k] ['value'] = $data [$k];
                    if($k!=$this->cms_cid){
                        $fields_data [$k] ['option'] = $this->cms_field_option_conv($fields_data [$k] ['data']);
                    }else{
                        $arr=Db::name('menu')->where(['menu_modelid'=>$model_id,'menu_type'=>3])->select();
                        $fields_data [$k] ['option']=menu_left($arr,'id','parentid');
                    }
                    break;
                case 'checkbox' :
                    $fields_data [$k] ['value'] = explode(',', $data [$k]);
                    $fields_data [$k] ['option'] = $this->cms_field_option_conv($fields_data [$k] ['data']);
                    break;
                default :
                    $this->error('未知字段 ' . $fields_data [$k] ['type']);
                    break;
            }
        }
        return $fields_data;
    }
    //处理cms的add edit的post提交数据
    protected function handle_postdata($model_pkid,$fields,$is_edit=true,$is_add=false)
    {
        $postdata=array();
        foreach ($fields as $k) {
            //主键跳过
            if($k==$this->cms_pk){
                continue;
            }
            $f=$this->cms_fields[$k];
            $rules = explode('|', $f ['rules']);
            //非只读或非编辑时处理input数据
            if(!$is_edit || !in_array('readonly', $rules)){
                switch ($f ['type']) {
                    case 'images':
                        //判断是否有传多图,目前只支持1个字段为多图
                        $files = request()->file('pic_all');
                        $picall_url='';
                        if(!empty($files)){
                            if(config('storage.storage_open')){
                                //七牛
                                $upload = \Qiniu::instance();
                                $info = $upload->upload();
                                $error = $upload->getError();
                                if ($info) {
                                    if(!empty($info['pic_all'])) {
                                        foreach ($info['pic_all'] as $file) {
                                            $img_url=config('storage.domain').$file['key'];
                                            $picall_url = $picall_url.($picall_url?',':'').$img_url;
                                        }
                                    }else{
                                        foreach ($info as $file) {
                                            $img_url=config('storage.domain').$file['key'];
                                            $picall_url = $picall_url.($picall_url?',':'').$img_url;
                                        }
                                    }
                                }else{
                                    $this->error($error);//否则就是上传错误，显示错误原因
                                }
                            }else{
                                $validate = config('upload_validate');
                                //多图
                                foreach ($files as $file) {
                                    $info = $file->validate($validate)->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
                                    if ($info) {
                                        $img_url = config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
                                        //写入数据库
                                        $data['uptime'] = time();
                                        $data['filesize'] = $info->getSize();
                                        $data['path'] = $img_url;
                                        Db::name('plug_files')->insert($data);
                                        $picall_url = $picall_url.($picall_url?',':'').$img_url;
                                    } else {
                                        $this->error($file->getError());//否则就是上传错误，显示错误原因
                                    }
                                }
                            }
                        }
                        $pic_oldlist=input('pic_oldlist','');
                        if($picall_url){
                            $postdata[$k]=$pic_oldlist.($pic_oldlist?',':'').$picall_url;
                        }else{
                            $postdata[$k]=$pic_oldlist;
                        }
                        break;
                    case 'files':
                        //判断是否有传多文件,目前只支持1个字段为多文件
                        $files = request()->file('file_all');
                        $fileall_url='';
                        if(!empty($files)){
                            if(config('storage.storage_open')){
                                //七牛
                                $upload = \Qiniu::instance(['exts'=> []]);//不限制后缀
                                $info = $upload->upload();
                                $error = $upload->getError();
                                if ($info) {
                                    if(!empty($info['file_all'])) {
                                        foreach ($info['file_all'] as $file) {
                                            $file_url=config('storage.domain').$file['key'];
                                            $fileall_url = $fileall_url.($fileall_url?',':'').$file_url;
                                        }
                                    }else{
                                        foreach ($info as $file) {
                                            $file_url=config('storage.domain').$file['key'];
                                            $fileall_url = $fileall_url.($fileall_url?',':'').$file_url;
                                        }
                                    }
                                }else{
                                    $this->error($error);//否则就是上传错误，显示错误原因
                                }
                            }else{
                                $validate = config('upload_validate');
                                unset($validate['ext']);//不限制后缀
                                //多文件
                                foreach ($files as $file) {
                                    $info = $file->validate($validate)->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
                                    if ($info) {
                                        $file_url = config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
                                        //写入数据库
                                        $data['uptime'] = time();
                                        $data['filesize'] = $info->getSize();
                                        $data['path'] = $file_url;
                                        Db::name('plug_files')->insert($data);
                                        $fileall_url = $fileall_url.($fileall_url?',':'').$file_url;
                                    } else {
                                        $this->error($file->getError());//否则就是上传错误，显示错误原因
                                    }
                                }
                            }
                        }
                        $file_oldlist=input('oldfile/a');
                        $file_oldlist=$file_oldlist?join(',',$file_oldlist):'';
                        if($fileall_url){
                            $postdata[$k]=$file_oldlist.($file_oldlist?',':'').$fileall_url;
                        }else{
                            $postdata[$k]=$file_oldlist;
                        }
                        break;
                    case 'imagefile':
                        $file = request()->file('pic_one_'.$k);
                        $img_one='';
                        if(!empty($file)){
                            if(config('storage.storage_open')){
                                //七牛
                                $upload = \Qiniu::instance();
                                $info = $upload->upload();
                                $error = $upload->getError();
                                if ($info) {
                                    if(!empty($info['pic_one_'.$k])){
                                        $img_one= config('storage.domain').$info['pic_one_'.$k][0]['key'];
                                    }else{
                                        $img_one= config('storage.domain').$info[0]['key'];
                                    }
                                }else{
                                    $this->error($error);//否则就是上传错误，显示错误原因
                                }
                            }else{
                                $validate = config('upload_validate');
                                //单图
                                $info = $file[0]->validate($validate)->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
                                if ($info) {
                                    $img_url = config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
                                    //写入数据库
                                    $data['uptime'] = time();
                                    $data['filesize'] = $info->getSize();
                                    $data['path'] = $img_url;
                                    Db::name('plug_files')->insert($data);
                                    $img_one = $img_url;
                                } else {
                                    $this->error($file->getError());//否则就是上传错误，显示错误原因
                                }
                            }
                        }
                        if(!empty($img_one)){
                            $postdata[$k]=$img_one;
                        }
                        break;
                    case 'file':
                        //支持多个字段单文件
                        $file = request()->file('file_one_'.$k);
                        $file_one='';
                        if(!empty($file)){
                            if(config('storage.storage_open')){
                                //七牛
                                $upload = \Qiniu::instance(['exts'=> []]);//不限制后缀
                                $info = $upload->upload();
                                $error = $upload->getError();
                                if ($info) {
                                    if(!empty($info['file_one_'.$k])){
                                        $file_one= config('storage.domain').$info['file_one_'.$k][0]['key'];
                                    }else{
                                        $file_one= config('storage.domain').$info[0]['key'];
                                    }
                                }else{
                                    $this->error($error);//否则就是上传错误，显示错误原因
                                }
                            }else{
                                $validate = config('upload_validate');
                                unset($validate['ext']);//不限制后缀
                                //单图
                                $info = $file[0]->validate($validate)->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
                                if ($info) {
                                    $file_url = config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
                                    //写入数据库
                                    $data['uptime'] = time();
                                    $data['filesize'] = $info->getSize();
                                    $data['path'] = $file_url;
                                    Db::name('plug_files')->insert($data);
                                    $file_one = $file_url;
                                } else {
                                    $this->error($file->getError());//否则就是上传错误，显示错误原因
                                }
                            }
                        }
                        if(!empty($file_one)){
                            $postdata[$k]=$file_one;
                        }
                        break;
                    case 'baidu_map':
                        $postdata [$k] = input("${k}", 0, 'floatval');
                        break;
                    case 'text' :
                    case 'bigtext' :
                        $postdata [$k] = input("$k", '', 'trim');
                        break;
                    case 'number' :
                    case 'switch' :
                        $postdata [$k] = input("$k", 0, 'intval');
                        break;
                    case 'large_number' :
                        $postdata [$k] = input("$k", 0);
                        break;
                    case 'currency':
                        $postdata [$k] = currency_long(input("$k", '', 'trim'));
                        break;
                    case 'datetime' :
                    case 'date' :
                        $postdata [$k] = input("$k", '', 'strtotime');
                        break;
                    case 'selectnumber' :
                        $postdata [$k] = input("$k", 0, 'intval');
                        if (in_array('required', $rules) && !$this->cms_field_option_valid($f ['data'], $postdata [$k])) {
                            $this->error($f ['title'] . ' 无效');
                        }
                        break;
                    case 'selecttext' :
                        $postdata [$k] = input("$k", '', 'trim');
                        if (in_array('required', $rules) && !$this->cms_field_option_valid($f ['data'], $postdata [$k])) {
                            $this->error($f ['title'] . ' 无效');
                        }
                        break;
                    case 'checkbox' :
                        $postdata [$k] = input("{$k}".'/a', array());
                        if (in_array('required', $rules) && !$this->cms_field_option_valid($f ['data'], $postdata [$k])) {
                            $this->error($f ['title'] . ' 无效');
                        }
                        $postdata [$k] = join(',', $postdata [$k]);
                        break;
                    case 'richtext' :
                        $postdata [$k] = htmlspecialchars_decode(input("$k"));
                        break;
                    default :
                        $this->error('未知字段 ' . $f ['title'] . ':' . $f ['type']);
                        break;
                }
            }
            //处理特殊规则-必须
            if (in_array('required', $rules)) {
                if (!isset ($postdata [$k]) || '' === $postdata [$k]) {
                    $this->error($f ['title'] . ' 不能为空');
                }
            }
            //处理特殊规则-唯一
            if (in_array('unique', $rules)) {
                $one = Db::name($this->cms_table)->where(array(
                    $k => $postdata [$k]
                ))->find();
                if ($one) {
                    if($is_edit && $one [$this->cms_pk] != $model_pkid ){
                        $this->error($f ['title'] . ' 不能重复');
                    }
                    if($is_add){
                        $this->error($f ['title'] . ' 不能重复');
                    }
                }
            }
        }
        return $postdata;
    }
}