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
use app\admin\model\Menu as MenuModel;
use app\admin\model\Options as OptionsModel;

class Menu extends Base
{
    public function _initialize()
	{
		parent::_initialize();
    }
    /**
     * 前台菜单列表
     */
	public function news_menu_list()
	{
		$menu_l=input('menu_l');
		$where=array();
		if(!empty($menu_l)){
			$where['menu_l']=array('eq',$menu_l);
		}
        if(!config('lang_switch_on')){
            $where['menu_l']=  $this->lang;
        }
		$menu_model=new MenuModel;
		$menus=$menu_model->where($where)->order('menu_l Desc,listorder')->select();
        $menus=get_menu_model($menus);
		$show='';
		$arr = menu_left($menus,'id','parentid');
		$this->assign('arr',$arr);
		$this->assign('menu_l',$menu_l);
		$this->assign('page',$show);
		if(request()->isAjax()){
			return $this->fetch('ajax_news_menu_list');
		}else{
			return $this->fetch();
		}
	}
    /**
     * 前台菜单添加显示
     */
	public function news_menu_add()
	{
		$parentid=input('id',0);
		//id不为0,取lang
		$menu_l='';
		$menu_model=new MenuModel;
		if($parentid){
			$menu_l=$menu_model->where('id',$parentid)->value('menu_l');
		}
        $where=array();
        if(!empty($menu_l)){
            $where['menu_l']=array('eq',$menu_l);
        }
        if(!config('lang_switch_on')){
            $where['menu_l']=  $this->lang;
        }
		$options_model=new OptionsModel;
		$tpls=$options_model->tpls($this->lang);
		$model=Db::name('model')->select();
        $this->assign('model',$model);
        $menu_text=$menu_model->where($where)->order('menu_l Desc,listorder')->select();
        $menu_text = menu_left($menu_text,'id','parentid');
        $this->assign('menu_text',$menu_text);
		$this->assign('parentid',$parentid);
		$this->assign('menu_l',$menu_l);
		$this->assign('tpls',$tpls);
		return $this->fetch();
	}
    /**
     * 前台菜单添加操作
     */
	public function news_menu_runadd()
	{
		$lang_list=input('lang_list');
		if(empty($lang_list)) $lang_list=input('menu_l',$this->lang);
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
		}else{
			//处理图片
			$img_url='';
			$file = request()->file('file0');
			if($file){
				if(config('storage.storage_open')){
					//七牛
					$upload = \Qiniu::instance();
					$info = $upload->upload();
					$error = $upload->getError();
					if ($info) {
						$img_url= config('storage.domain').$info[0]['key'];
					}else{
						$this->error($error,url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
					}
				}else{
					$validate=config('upload_validate');
					$info = $file->validate($validate)->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
					if($info) {
						$img_url=config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
						//写入数据库
						$data['uptime']=time();
						$data['filesize']=$info->getSize();
						$data['path']=$img_url;
						Db::name('plug_files')->insert($data);
					}else{
						$this->error($file->getError(),url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
					}
				}
			}
			//处理语言
            $parentid=input('parentid',0,'intval');
			if($parentid){
                $menu_l=Db::name('menu')->where('id',$parentid)->value('menu_l');
            }else{
			    $menu_l=input('menu_l',$this->lang);
            }
			//构建数组
			$data=array(
				'menu_name'=>input('menu_name'),
				'menu_l'=>$menu_l,
				'menu_enname'=>input('menu_enname'),
				'menu_type'=>input('menu_type'),
                'menu_modelid'=>input('menu_modelid',0,'intval'),
				'parentid'=>$parentid,
				'menu_listtpl'=>input('menu_listtpl'),
				'menu_newstpl'=>input('menu_newstpl'),
				'menu_address'=>input('menu_address'),
				'menu_open'=>input('menu_open',0),
				'listorder'=>input('listorder'),
				'menu_seo_title'=>input('menu_seo_title'),
				'menu_seo_key'=>input('menu_seo_key'),
				'menu_seo_des'=>input('menu_seo_des'),
				'menu_content'=>htmlspecialchars_decode(input('menu_content')),
				'menu_img'=>$img_url,
			);
			$rst=MenuModel::create($data);
			$menu_model=new MenuModel;
			if($rst!==false){
				$arr=MenuModel::get(input('parentid'));
				if(input('menu_type')==3 && $arr['menu_type']==3){
					$menu_model->where(array('id'=>input('parentid')))->setField('menu_type',1);
				}
				cache('site_nav_main',null);
				$this->success('菜单添加成功',url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
			}else{
				$this->error('菜单添加失败',url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
			}
		}
	}
    /**
     * 前台菜单编辑显示
     */
	public function news_menu_edit()
	{
		$menu=MenuModel::get(input('id'));
		$options_model=new OptionsModel;
		$tpls=$options_model->tpls($this->lang);
        $model=Db::name('model')->select();
        $this->assign('model',$model);
        $where=array();
        $where['menu_l']=array('eq',$menu['menu_l']);
        if(!config('lang_switch_on')){
            $where['menu_l']=  $this->lang;
        }
        $menu_text=Db::name('menu')->where($where)->order('menu_l Desc,listorder')->select();
        $menu_text = menu_left($menu_text,'id','parentid');
        $this->assign('menu_text',$menu_text);
		$this->assign('menu',$menu);
		$this->assign('tpls',$tpls);
		return $this->fetch();
	}
    /**
     * 前台菜单编辑操作
     */
	public function news_menu_runedit()
	{
		$lang_list=input('lang_list');
        if(empty($lang_list)) $lang_list=input('menu_l',$this->lang);
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
		}else{
			$checkpic=input('checkpic');
			$oldcheckpic=input('oldcheckpic');
			$img_url='';
			if ($checkpic!=$oldcheckpic){
				$file = request()->file('file0');
				if($file){
					if(config('storage.storage_open')){
						//七牛
						$upload = \Qiniu::instance();
						$info = $upload->upload();
						$error = $upload->getError();
						if ($info) {
							$img_url= config('storage.domain').$info[0]['key'];
						}else{
							$this->error($error,url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));//否则就是上传错误，显示错误原因
						}
					}else{
						$validate=config('upload_validate');
						$info = $file->validate($validate)->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
						if($info) {
							$img_url=config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
							//写入数据库
							$data['uptime']=time();
							$data['filesize']=$info->getSize();
							$data['path']=$img_url;
							Db::name('plug_files')->insert($data);
						}else{
							$this->error($file->getError(),url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
						}
					}
				}
			}
            //处理语言
            $parentid=input('parentid',0,'intval');
            if($parentid){
                $menu_l=Db::name('menu')->where('id',$parentid)->value('menu_l');
            }else{
                $menu_l=input('menu_l',$this->lang);
            }
			$data=array(
				'id'=>input('id'),
				'menu_name'=>input('menu_name'),
				'menu_enname'=>input('menu_enname'),
				'menu_type'=>input('menu_type'),
                'menu_modelid'=>input('menu_modelid',0,'intval'),
				'parentid'=>$parentid,
                'menu_l'=>$menu_l,
				'menu_listtpl'=>input('menu_listtpl'),
				'menu_newstpl'=>input('menu_newstpl'),
				'menu_address'=>input('menu_address'),
				'menu_open'=>input('menu_open',0),
				'listorder'=>input('listorder'),
				'menu_seo_title'=>input('menu_seo_title'),
				'menu_seo_key'=>input('menu_seo_key'),
				'menu_seo_des'=>input('menu_seo_des'),
				'menu_content'=>htmlspecialchars_decode(input('menu_content')),
			);
			if ($checkpic!=$oldcheckpic){
				$data['menu_img']=$img_url;
			}
			$rst=MenuModel::update($data);
			if($rst!==false){
				cache('site_nav_main',null);
				$this->success('菜单修改成功',url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
			}else{
				$this->error('菜单修改失败',url('admin/Menu/news_menu_list',array('menu_l'=>$lang_list)));
			}
		}
	}
    /**
     * 前台菜单删除
     */
	public function news_menu_del()
	{
		$lang_list=input('lang_list');
		$id=input('id');
		$arr=MenuModel::get($id);
		$model_id=$arr['menu_modelid'];
		$parentid=$arr['parentid'];
		$parent_arr=MenuModel::get($parentid);
		$ids=get_menu_byid($id,1,2);//返回含自身id及子菜单id数组
		$rst=MenuModel::destroy($ids);
		$menu_model=new MenuModel;
		//处理父级
		if($rst!==false){
			//判断其父菜单是否还存在子菜单，如无子菜单，且父菜单类型为1
			if($parentid && $parent_arr['menu_type']==1){
				$child=$menu_model->where(array('parentid'=>$parentid))->select();
				if(empty($child)){
					$menu_model->where(array('id'=>$parentid))->update(['menu_type'=>3,'menu_modelid'=>$model_id]);
				}
			}
			cache('site_nav_main',null);
			$this->success('菜单删除成功',url('admin/Menu/news_menu_list',['menu_l'=>$lang_list]));
		}else{
			$this -> error("菜单删除失败！",url('admin/Menu/news_menu_list',['menu_l'=>$lang_list]));
		}
	}
    /**
     * 前台菜单排序
     */
	public function news_menu_order(){
		$lang_list=input('lang_list');
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Menu/news_menu_list',['menu_l'=>$lang_list]));
		}else{
			$list=[];
			foreach (input('post.') as $id => $sort){
				$list[]=['id'=>$id,'listorder'=>$sort];
			}
			$menu_model=new MenuModel;
			$menu_model->saveAll($list);
			cache('site_nav_main',null);
			$this->success('排序更新成功',url('admin/Menu/news_menu_list',['menu_l'=>$lang_list]));
		}
	}
    /**
     * 前台菜单开启/禁止
     */
	public function news_menu_state()
	{
		$id=input('x');
		$menu_model=new MenuModel;
		$status=$menu_model->where(array('id'=>$id))->value('menu_open');//判断当前状态情况
		if($status==1){
			$statedata = array('menu_open'=>0);
			$menu_model->where(array('id'=>$id))->setField($statedata);
			cache('site_nav_main',null);
			$this->success('状态禁止');
		}else{
			$statedata = array('menu_open'=>1);
			$menu_model->where(array('id'=>$id))->setField($statedata);
			cache('site_nav_main',null);
			$this->success('状态开启');
		}
	}
}