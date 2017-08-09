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
use think\Validate;

class Plug extends Base
{
	protected $files_res_exists;
	protected $files_res_used;
	protected $files_unused;
	/*
     * 留言列表
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_sug_list()
	{
		$plug_sug=Db::name('plug_sug')->order('plug_sug_open,plug_sug_addtime desc')->paginate(config('paginate.list_rows'));
		$show=$plug_sug->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
		$this->assign('plug_sug',$plug_sug);
		$this->assign('page',$show);
		if(request()->isAjax()){
			return $this->fetch('ajax_plug_sug_list');
		}else{
			return $this->fetch();
		}
	}
	/*
	 * 留言回复返回数据
	 * @author rainfer <81818832@qq.com>
	 */
	public function plug_sug_reply()
	{
		$plug_sug_id=input('plug_sug_id');
		$plug_sug=Db::name('plug_sug')->where(array('plug_sug_id'=>$plug_sug_id))->find();
		$rule = [
			['plug_sug_email','require|email','留言邮箱为空|留言邮箱格式不正确'],
		];
		$validate = new Validate($rule);
		$rst   = $validate->check(array(
			'plug_sug_email'=>$plug_sug['plug_sug_email']
		));
		if(true !==$rst){
			$sl_data['code']=0;
			$sl_data['msg']=$validate->getError();
		}else{
			$sl_data['plug_sug_email']=$plug_sug['plug_sug_email'];
			$sl_data['plug_sug_name']=$plug_sug['plug_sug_name'];
			$sl_data['plug_sug_id']=$plug_sug['plug_sug_id'];
			$sl_data['code']=1;
		}
		return json($sl_data);
	}
	/*
	 * 留言回复
	 * @author rainfer <81818832@qq.com>
	 */
	public function plug_sug_runreply()
	{
		$email=input('plug_sug_toemail');
		$name=input('plug_sug_toname');
		$plug_sug_id=input('plug_sug_id');
		$content=htmlspecialchars_decode(input('plug_sug_replycontent'));
		$send_result=sendMail($email,"Reply:". $name, $content);
		if($send_result['error']){
			$this->error('邮箱设置不正确或对方邮箱地址不存在',url('admin/Plug/plug_sug_list'));
		}else{
			$rst=Db::name('plug_sug')->where('plug_sug_id',$plug_sug_id)->setField('plug_sug_open',1);
			if($rst!==false){
				$this->success('回复留言成功',url('admin/Plug/plug_sug_list'));
			}else{
				$this->error('回复留言失败',url('admin/Plug/plug_sug_list'));
			}
		}
	}
	/*
     * 留言删除
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_sug_del()
	{
		$p = input('p');
		$plug_sug_id=input('plug_sug_id');
		$rst=Db::name('plug_sug')->where(array('plug_sug_id'=>$plug_sug_id))->delete();
		if($rst!==false){
			$this->success('留言删除成功',url('admin/Plug/plug_sug_list',array('p'=>$p)));
		}else{
			$this->error('留言删除失败',url('admin/Plug/plug_sug_list',array('p'=>$p)));
		}
	}
	/*
     * 留言删除(全选)
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_sug_alldel()
	{
		$p = input('p');
		$ids = input('sug_id/a');
		if(empty($ids)){
			$this -> error("请选择删除留言",url('admin/Plug/plug_sug_list',array('p'=>$p)));
		}
		if(is_array($ids)){
			$where = 'plug_sug_id in('.implode(',',$ids).')';
		}else{
			$where = 'plug_sug_id='.$ids;
		}
		$rst=Db::name('plug_sug')->where($where)->delete();
		if($rst!==false){
			$this->success("留言删除成功！",url('admin/Plug/plug_sug_list',array('p'=>$p)));
		}else{
			$this -> error("删除留言失败！",url('admin/Plug/plug_sug_list',array('p' => $p)));
		}
	}
	/*
     * 友情链接列表
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_link_list()
	{
		$type=input('type');
		$val=input('val');
		$plug_link_l=input('plug_link_l');
		$map=array();
		if (!empty($type)){
			$map['plug_link_typeid']=  array('eq',input('type'));
		}
		if (!empty($val)){
			$map['plug_link_name|plug_link_url'] = array('like',"%".$val."%");
		}
		if (!empty($plug_link_l)){
			$map['plug_link_l']=  array('eq',$plug_link_l);
		}
		if(!config('lang_switch_on')){
            $map['plug_link_l']=  $this->lang;
        }
		$link_type=Db::name('plug_linktype')->select();
		$plug_link=Db::name('Plug_link')->alias("a")->join(config('database.prefix').'plug_linktype b','a.plug_link_typeid =b.plug_linktype_id')->where($map)->order('plug_link_addtime desc')->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
		$show = $plug_link->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
		$this->assign('plug_link',$plug_link);
		$this->assign('link_type',$link_type);
		$this->assign('val',$val);
		$this->assign('type',$type);
		$this->assign('plug_link_l',$plug_link_l);
		$this->assign('page',$show);
		if(request()->isAjax()){
			return $this->fetch('ajax_plug_link_list');
		}else{
			return $this->fetch();
		}	
	}


	/*
     * 友情链接添加操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_link_runadd()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_link_list'));
		}else{
			$sl_data=array(
				'plug_link_name'=>input('plug_link_name'),
				'plug_link_l'=>input('plug_link_l','zh-cn'),
				'plug_link_url'=>input('plug_link_url'),
				'plug_link_target'=>input('plug_link_target'),
				'plug_link_typeid'=>input('plug_link_typeid'),
				'plug_link_qq'=>input('plug_link_qq'),
				'plug_link_order'=>input('plug_link_order'),
				'plug_link_addtime'=>time(),
				'plug_link_open'=>input('plug_link_open',0),
			);
			$rst=Db::name('plug_link')->insert($sl_data);
			if($rst!==false){
				$this->success('友情链接添加成功',url('admin/Plug/plug_link_list'));
			}else{
				$this->error('友情链接添加失败',url('admin/Plug/plug_link_list'));
			}
		}
	}

	/*
     * 友情链接删除操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_link_del()
	{
		$p=input('p');
		$rst=Db::name('plug_link')->where(array('plug_link_id'=>input('plug_link_id')))->delete();
		if($rst!==false){
			$this->success('友情链接删除成功',url('admin/Plug/plug_link_list',array('p' => $p)));
		}else{
			$this->error('友情链接删除失败',url('admin/Plug/plug_link_list',array('p' => $p)));
		}
	}

	/*
     * 友情链接状态操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_link_state()
	{
		$id=input('x');
		$status=Db::name('plug_link')->where(array('plug_link_id'=>$id))->value('plug_link_open');//判断当前状态情况
		if($status==1){
			$statedata = array('plug_link_open'=>0);
			Db::name('plug_link')->where(array('plug_link_id'=>$id))->setField($statedata);
			$this->success('状态禁止');
		}else{
			$statedata = array('plug_link_open'=>1);
			Db::name('plug_link')->where(array('plug_link_id'=>$id))->setField($statedata);
			$this->success('状态开启');
		}
	}

	/*
     * 友情链接修改返回值操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_link_edit()
	{
		$plug_link_id=input('plug_link_id');
		$plug_link=Db::name('plug_link')->where(array('plug_link_id'=>$plug_link_id))->find();
		$sl_data['plug_link_id']=$plug_link['plug_link_id'];
		$sl_data['plug_link_l']=$plug_link['plug_link_l'];
		$sl_data['plug_link_name']=$plug_link['plug_link_name'];
		$sl_data['plug_link_url']=$plug_link['plug_link_url'];
		$sl_data['plug_link_qq']=$plug_link['plug_link_qq'];
		$sl_data['plug_link_target']=$plug_link['plug_link_target'];
		$sl_data['plug_link_order']=$plug_link['plug_link_order'];
		$sl_data['plug_link_open']=$plug_link['plug_link_open'];
		$sl_data['plug_link_typeid']=$plug_link['plug_link_typeid'];
		$sl_data['code']=1;
		return json($sl_data);
	}

	/*
     * 友情 链接修改操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_link_runedit()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_link_list'));
		}else{
			$sl_data=array(
				'plug_link_id'=>input('plug_link_id'),
				'plug_link_l'=>input('plug_link_l','zh-cn'),
				'plug_link_name'=>input('plug_link_name'),
				'plug_link_url'=>input('plug_link_url'),
				'plug_link_target'=>input('plug_link_target'),
				'plug_link_typeid'=>input('plug_link_typeid'),
				'plug_link_qq'=>input('plug_link_qq'),
				'plug_link_order'=>input('plug_link_order'),

			);
			Db::name('plug_link')->update($sl_data);
			$this->success('友情链接修改成功',url('admin/Plug/plug_link_list'));
		}
	}

	/*
     * 友情链接类型列表
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_linktype_list()
	{
		$link_type=Db::name('plug_linktype')->order('plug_linktype_order')->select();
		$this->assign('link_type',$link_type);
		return $this->fetch();
	}
	/*
     * 友情链接类型删除
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_linktype_del()
	{
		$rst=Db::name('plug_linktype')->where(array('plug_linktype_id'=>input('plug_linktype_id')))->delete();
		if($rst!==false){
			$this->success('友链类型删除成功',url('admin/Plug/plug_linktype_list'));
		}else{
			$this->error('友链类型删除失败',url('admin/Plug/plug_linktype_list'));
		}
	}

	/*
     * 友情链接类型添加
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_linktype_runadd()
	{
		Db::name('plug_linktype')->insert(input('post.'));
		$this->success('栏目添加成功',url('admin/Plug/plug_linktype_list'));
	}

	/*
     * 友情链接类型修改
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_linktype_runedit()
	{
		$sl_data=array(
			'plug_linktype_id'=>input('plug_linktype_id'),
			'plug_linktype_name'=>input('plug_linktype_name'),
			'plug_linktype_order'=>input('plug_linktype_order'),
		);
		Db::name('plug_linktype')->update($sl_data);
		$this->success('友情链接栏目修改成功',url('admin/Plug/plug_linktype_list'));
	}

	/*
     * 友情链接类型排序
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_linktype_order()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_linktype_list'));
		}else{
			$post=input('post.');
			foreach ($post as $plug_linktype_id => $plug_linktype_order){
				Db::name('plug_linktype')->where(array('plug_linktype_id' => $plug_linktype_id ))->setField('plug_linktype_order' , $plug_linktype_order);
			}
			$this->success('排序更新成功',url('admin/Plug/plug_linktype_list'));
		}
	}
	/*
     * 广告管理
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_list()
	{
		$key=input('key');
		$plug_ad_l=input('plug_ad_l');
		$map['plug_ad_name'] = array('like',"%".$key."%");
		if (!empty($plug_ad_l)){
			$map['plug_ad_l']=  array('eq',$plug_ad_l);
		}
		if(!config('lang_switch_on')){
            $map['plug_ad_l']=  $this->lang;
        }
		$plug_adtype_list=Db::name('plug_adtype')->order('plug_adtype_order')->select();//获取所有广告位
		$plug_ad_list=Db::name('plug_ad')->alias("a")->join(config('database.prefix').'plug_adtype b','a.plug_ad_adtypeid =b.plug_adtype_id')->where($map)->order('plug_ad_order')->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
		$show = $plug_ad_list->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
		$this->assign('plug_ad_list',$plug_ad_list);
		$this->assign('plug_adtype_list',$plug_adtype_list);
		$this->assign('page',$show);
		$this->assign('val',$key);
		$this->assign('plug_ad_l',$plug_ad_l);
		if(request()->isAjax()){
			return $this->fetch('ajax_plug_ad_list');
		}else{
			return $this->fetch();
		}	
	}
	/*
     * 添加广告操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_runadd()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_ad_list'));
		}else{
			//处理图片
			$img_url='';
			$file = request()->file('file0');
			if($file){
				if(config('storage.storage_open')){
					$upload = \Qiniu::instance();
					$info = $upload->upload();
					$error = $upload->getError();
					if ($info) {
						$img_url= config('storage.domain').$info[0]['key'];
					}else{
						$this->error($error,url('admin/Plug/plug_ad_list'));//否则就是上传错误，显示错误原因
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
						$this->error($file->getError(),url('admin/Plug/plug_ad_list'));//否则就是上传错误，显示错误原因
					}
				}
			}
			//构建数组
			$sl_data=array(
				'plug_ad_adtypeid'=>input('plug_ad_adtypeid'),
				'plug_ad_name'=>input('plug_ad_name'),
				'plug_ad_l'=>input('plug_ad_l','zh-cn'),
				'plug_ad_pic'=>$img_url,
				'plug_ad_url'=>input('plug_ad_url',''),
				'plug_ad_checkid'=>input('plug_ad_checkid'),
				'plug_ad_js'=>input('plug_ad_js'),
				'plug_ad_open'=>input('plug_ad_open',0),
				'plug_ad_order'=>input('plug_ad_order',50,'intval'),
                'plug_ad_content'=>input('plug_ad_content',''),
				'plug_ad_addtime'=>time(),
			);
			$rst=Db::name('plug_ad')->insert($sl_data);
			if($rst!==false){
				$this->success('广告添加成功',url('admin/Plug/plug_ad_list'));
			}else{
				$this->error('广告添加失败',url('admin/Plug/plug_ad_list'));
			}
		}
	}

	/*
     * 广告删除
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_del()
	{
		$plug_ad_id=input('plug_ad_id');
		$rst=Db::name('plug_ad')->where(array('plug_ad_id'=>$plug_ad_id))->delete();
		if($rst!==false){
			$this->success('广告删除成功',url('admin/Plug/plug_ad_list'));
		}else{
			$this->error('广告删除失败',url('admin/Plug/plug_ad_list'));
		}
	}

	/*
     * 批量排序
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_order()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_ad_list'));
		}else{
			$post=input('post.');
			foreach ($post as $id => $sort){
				Db::name('plug_ad')->where(array('plug_ad_id' => $id ))->setField('plug_ad_order' , $sort);
			}
			$this->success('广告排序更新成功',url('admin/Plug/plug_ad_list'));
		}
	}

	/*
     * 广告状态
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_state()
	{
		$id=input('x');
		$status=Db::name('plug_ad')->where(array('plug_ad_id'=>$id))->value('plug_ad_open');//判断当前状态情况
		if($status==1){
			$statedata = array('plug_ad_open'=>0);
			Db::name('plug_ad')->where(array('plug_ad_id'=>$id))->setField($statedata);
			$this->success('状态禁止');
		}else{
			$statedata = array('plug_ad_open'=>1);
			Db::name('plug_ad')->where(array('plug_ad_id'=>$id))->setField($statedata);
			$this->success('状态开启');
		}
	}

	/*
     * 广告位修改操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_edit()
	{
		$plug_adtype_list=Db::name('plug_adtype')->select();
		$plug_ad_id=input('plug_ad_id');
		$plug_ad=Db::name('plug_ad')->where(array('plug_ad_id'=>$plug_ad_id))->find();
		$this->assign('plug_adtype_list',$plug_adtype_list);
		$this->assign('plug_ad',$plug_ad);
		return $this->fetch();

	}

	/*
     * 修改广告操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_ad_runedit()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_ad_list'));
		}else{
			$checkpic=input('checkpic');
			$oldcheckpic=input('oldcheckpic');
			$img_url='';
			if ($checkpic!=$oldcheckpic){
				$file = request()->file('file0');
				if(!empty($file)){
					if(config('storage.storage_open')){
						//七牛
						$upload = \Qiniu::instance();
						$info = $upload->upload();
						$error = $upload->getError();
						if ($info) {
							$img_url= config('storage.domain').$info[0]['key'];
						}else{
							$this->error($error,url('admin/Plug/plug_ad_list'));//否则就是上传错误，显示错误原因
						}
					}else{
						//本地
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
							$this->error($file->getError(),url('admin/Plug/plug_ad_list'));//否则就是上传错误，显示错误原因
						}
					}
				}
			}
			$sl_data=array(
				'plug_ad_id'=>input('plug_ad_id'),
				'plug_ad_l'=>input('plug_ad_l','zh-cn'),
				'plug_ad_adtypeid'=>input('plug_ad_adtypeid'),
				'plug_ad_name'=>input('plug_ad_name'),
				'plug_ad_url'=>input('plug_ad_url'),
				'plug_ad_order'=>input('plug_ad_order'),
				'plug_ad_checkid'=>input('plug_ad_checkid'),
                'plug_ad_content'=>input('plug_ad_content'),
				'plug_ad_js'=>input('plug_ad_js'),
			);
			if ($checkpic!=$oldcheckpic){
				$sl_data['plug_ad_pic']=$img_url;
			}
			$rst=Db::name('plug_ad')->update($sl_data);
			if($rst!==false){
				$this->success('广告设置修改成功',url('admin/Plug/plug_ad_list'));
			}else{
				$this->error('广告设置修改失败',url('admin/Plug/plug_ad_list'));
			}
		}
	}
	/*
     * 广告位列表
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_adtype_list()
	{
		$key=input('key');
		$map['plug_adtype_name '] = array('like',"%".$key."%");
		$plug_adtype_list=Db::name('plug_adtype')->where($map)->order('plug_adtype_order')->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
		$show = $plug_adtype_list->render();
		$this->assign('plug_adtype_list',$plug_adtype_list);
		$this->assign('page',$show);
		$this->assign('val',$key);
		return $this->fetch();
	}
	/*
     * 广告位添加操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_adtype_runadd()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_adtype_list'));
		}else{
			$rst=Db::name('plug_adtype')->insert(input('post.'));
			if($rst!==false){
				$this->success('广告位添加成功',url('admin/Plug/plug_adtype_list'));			
			}else{
				$this->error('广告位添加失败',url('admin/Plug/plug_adtype_list'));	
			}
		}
	}

	/*
     * 广告位修改操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_adtype_edit()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_adtype_list'));
		}else{
			$plug_adtype_id=input('plug_adtype_id');
			$plug_adtype=Db::name('plug_adtype')->where(array('plug_adtype_id'=>$plug_adtype_id))->find();
			$sl_data['plug_adtype_id']=$plug_adtype['plug_adtype_id'];
			$sl_data['plug_adtype_name']=$plug_adtype['plug_adtype_name'];
			$sl_data['plug_adtype_order']=$plug_adtype['plug_adtype_order'];
			$sl_data['code']=1;
			return json($sl_data);
		}
	}

	/*
     * 广告位修改操作
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_adtype_runedit()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_adtype_list'));
		}else{
			$rst=Db::name('plug_adtype')->update(input('post.'));
			if($rst!==false){
				$this->success('广告位修改成功',url('admin/Plug/plug_adtype_list'));
			}else{
				$this->error('广告位修改失败',url('admin/Plug/plug_adtype_list'));
			}
			
		}
	}

	/*
     * 广告位删除
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_adtype_del()
	{
		$p = input('p');
        $rst=Db::name('plug_ad')->where(array('plug_ad_adtypeid'=>input('plug_adtype_id')))->delete();//删除该广告位所有广告
		if($rst!==false){
			$rst=Db::name('plug_adtype')->where(array('plug_adtype_id'=>input('plug_adtype_id')))->delete();//删除广告位
			if($rst!==false){
				$this->success('广告位删除成功',url('admin/Plug/plug_adtype_list', array('p' => $p)));
			}else{
				$this->error('广告位删除失败',url('admin/Plug/plug_adtype_list', array('p' => $p)));
			}
		}else{
			$this->error('广告位删除失败',url('admin/Plug/plug_adtype_list', array('p' => $p)));
		}
	}

	/*
     * 广告位排序
	 * @author rainfer <81818832@qq.com>
     */
	public function plug_adtype_order()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('admin/Plug/plug_adtype_list'));
		}else{
			$post=input('post.');
			foreach ($post as $id => $sort){
				Db::name('plug_adtype')->where(array('plug_adtype_id' => $id ))->setField('plug_adtype_order' , $sort);
			}
			$this->success('广告位排序更新成功',url('admin/Plug/plug_adtype_list'));
		}
	}
	/*
    * 本地文件列表
    * @author rainfer <81818832@qq.com>
    */
	public function plug_file_list()
	{
        $map=array();
        //查询：时间格式过滤
        $sldate=input('reservation','');//获取格式 2015-11-12 - 2015-11-18
        $arr = explode(" - ",$sldate);//转换成数组
        if(count($arr)==2){
            $arrdateone=strtotime($arr[0]);
            $arrdatetwo=strtotime($arr[1].' 23:55:55');
            $map['uptime'] = array(array('egt',$arrdateone),array('elt',$arrdatetwo),'AND');
        }
        //查询文件路径
        $val=input('val');
        if(!empty($val)){
            $map['path']= array('like',"%".$val."%");
        }
		$plug_files=Db::name('plug_files')->where($map)->order('id desc')->paginate(config('paginate.list_rows'),false,['query'=>get_query()]);
		$show = $plug_files->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
		$this->assign('page',$show);
		$this->assign('plug_files',$plug_files);
		$this->assign('sldate',$sldate);
		$this->assign('val',$val);
		if(request()->isAjax()){
			return $this->fetch('ajax_plug_file_list');
		}else{
			return $this->fetch();
		}
	}
	/**
	 * 文件过滤
	 */
	public function plug_file_filter()
	{
		//获取本地文件数组，'./data/upload/2016-01-21/56a03ff96b6ff.jpg' => int 224138
		$file_list=list_file('data/upload');
		$path="/data/upload/";
		$this->files_res_exists=array();
		foreach ($file_list as $a){
			if ($a ['isDir']) {
				foreach (list_file($a ['pathname'] . '/') as $d) {
					if (!$d ['isDir']) {
						//文件
						if($d['ext']!='html' && $d['ext']!='lock'){
							$this->files_res_exists [$path . $a ['filename'] . '/' . $d ['filename']] = $d ['size'];
						}
					}
				}
			}
		}
		//获取数据表datafile已存记录，并删除资源数组里的成员，完毕后得到未存入数据表datafile的资源文件
		$datas = Db::name('plug_files')->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				$f = $d ['path'];
				if (isset ($this->files_res_exists [$f])) {
					unset ($this->files_res_exists [$f]);
				}
			}
		}
		//未存入数据表的数据写入数据表
		$time=time();
		foreach ($this->files_res_exists as $d => $v) {
			Db::name('plug_files')->insert(array(
				'path' => $d,
				'uptime' => $time,
				'filesize' => $v
			));
		}
		//获取利用到的资源文件
		$this->files_res_used=array();
		//avatar,涉及表admin里字段admin_avatar，member_list里member_list_headpic,头像只保存头像图片名
		$datas = Db::name('admin')->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				if($d['admin_avatar']){
					if(stripos($d['admin_avatar'],'http')===false){
						//本地头像
						$this->files_res_used['/data/upload/avatar/' . $d['admin_avatar']]=true;
					}
				}
			}
		}
		$datas = Db::name('member_list')->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				if($d['member_list_headpic']){
					if(stripos($d['member_list_headpic'],'http')===false){
						//本地头像
						$this->files_res_used['/data/upload/avatar/' . $d['member_list_headpic']]=true;
					}
				}
			}
		}
		//news里的news_img,news_pic_allurl,news_content
		$datas = Db::name('news')->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				//字段保存'/data/....'
				if($d['news_img']){
					if(stripos($d['news_img'],'http')===false){
						$this->files_res_used[$d['news_img']]=true;
					}
				}
				//字段保存'/data/....'
				if($d['news_pic_allurl']){
					$imgs=array_filter(explode(",",$d['news_pic_allurl']));
					foreach ($imgs as &$f) {
						if(stripos($f,'http')===false && !empty($f)){
							$this->files_res_used[$f]=true;
						}
					}
				}
				if($d['news_content']){
					//匹配'/网站目录/data/....'
					$preg_match=__ROOT__.'\/data\/upload\/([0-9]{4}[-][0-9]{2}[-][0-9]{2}\/[a-z0-9]{13}\.[a-z0-9]+)/i';
					@preg_match_all($preg_match, $d['news_content'], $mat);
                    if(!empty($mat [1])){
						foreach ($mat [1] as &$f) {
							$this->files_res_used['/data/upload/'.$f]=true;
						}
					}

					//匹配'./data/....'
					$preg_match='/\.\/data\/upload\/([0-9]{4}[-][0-9]{2}[-][0-9]{2}\/[a-z0-9]{13}\.[a-z0-9]+)/i';
					@preg_match_all($preg_match, $d['news_content'], $mat);
					if(!empty($mat [1])){
						foreach ($mat [1] as &$f) {
							$this->files_res_used['/data/upload/'.$f]=true;
						}
					}
				}
			}
		}
		//options里'option_name'=>'site_options'的site_logo、site_qr,字段保存'/data/....'
		$datas = Db::name('options')->where(array('option_name'=>'site_options'))->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				if($d['option_value']){
					$smeta=json_decode($d['option_value'],true);
					if($smeta['site_logo'] && stripos($smeta['site_logo'],'http')===false){
						$this->files_res_used[$smeta['site_logo']]=true;
					}
					if(!empty($smeta['site_qr']) && stripos($smeta['site_qr'],'http')===false){
						$this->files_res_used[$smeta['site_qr']]=true;
					}
				}
			}
		}
		//plug_ad里plug_ad_pic,字段保存'/data/....'
		$datas = Db::name('plug_ad')->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				if($d['plug_ad_pic']){
					if(stripos($d['plug_ad_pic'],'http')===false){
						//本地图片
						$this->files_res_used[$d['plug_ad_pic']]=true;
					}
				}
			}
		}
		//menu里menu_img,字段保存'/data/....'
		$datas = Db::name('menu')->select();
		if (is_array($datas)) {
			foreach ($datas as &$d) {
				if($d['menu_img']){
					if(stripos($d['menu_img'],'http')===false){
						//本地图片
						$this->files_res_used[$d['menu_img']]=true;
					}
				}
			}
		}
		//model自定义模型
        $table_arr=Db::name('model')->column('model_name,model_fields','model_name');
		foreach ($table_arr as $table=>$fields){
		    $fields=json_decode($fields,true);
		    foreach ($fields as $field){
                //文件或图片或富文本字段
		        if(in_array($field['type'],['imagefile','images','file','files','richtext'])){
                    $datas=Db::name($table)->field($field['name'])->select();
                    foreach ($datas as $d) {
                        if($d[$field['name']]){
                            if($field['type']=='richtext'){
                                //匹配'/网站目录/data/....'
                                $preg_match=__ROOT__.'\/data\/upload\/([0-9]{4}[-][0-9]{2}[-][0-9]{2}\/[a-z0-9]{13}\.[a-z0-9]+)/i';
                                @preg_match_all($preg_match, $d[$field['name']], $mat);
                                if(!empty($mat [1])){
                                    foreach ($mat [1] as &$f) {
                                        $this->files_res_used['/data/upload/'.$f]=true;
                                    }
                                }

                                //匹配'./data/....'
                                $preg_match='/\.\/data\/upload\/([0-9]{4}[-][0-9]{2}[-][0-9]{2}\/[a-z0-9]{13}\.[a-z0-9]+)/i';
                                @preg_match_all($preg_match, $d[$field['name']], $mat);
                                if(!empty($mat [1])){
                                    foreach ($mat [1] as &$f) {
                                        $this->files_res_used['/data/upload/'.$f]=true;
                                    }
                                }
                            }elseif($field['type']=='imagefile' || $field['type']=='file'){
                                if(stripos($d[$field['name']],'http')===false){
                                    //本地图片
                                    $this->files_res_used[$d[$field['name']]]=true;
                                }
                            }else{
                                //字段保存'/data/....'
                                if($d[$field['name']]){
                                    $imgs=array_filter(explode(",",$d[$field['name']]));
                                    foreach ($imgs as &$f) {
                                        if(stripos($f,'http')===false && !empty($f)){
                                            $this->files_res_used[$f]=true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        //找出未使用的资源文件
        $this->files_unused=array();
        $ids=array();
        $datas = Db::name('plug_files')->select();
        if (is_array($datas)) {
            foreach ($datas as &$d) {
                $f = $d ['path'];
                if (isset ($this->files_res_used[$f])) {
                    unset ($this->files_res_used[$f]);
                } else {
                    $ids[]=$d ['id'];
                    $this->files_unused [] = array(
                        'id' => $d ['id'],
                        'filesize' =>$d['filesize'],
                        'path' => $f,
                        'uptime' => $d ['uptime']
                    );
                }
            }
        }
        //数据库
		$where=array();
		$plug_files=array();
		$show='';
		if(!empty($ids)){
			$where['id']=array('in',$ids);
			$plug_files=Db::name('plug_files')->where($where)->order('id desc')->paginate(config('paginate.list_rows'));
			$show = $plug_files->render();
			$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
		}
		$this->assign('plug_files',$plug_files);
		$this->assign('page',$show);
		if(request()->isAjax()){
			return $this->fetch('ajax_plug_file_filter');
		}else{
			return $this->fetch();
		}
	}
	/**
	 * 文件删除(全选)
	 */
	public function plug_file_alldel(){
		$p = input('p');
		$ids = input('id/a');
		if(empty($ids)){
			$this -> error("请选择要删除的文件",url('admin/Plug/plug_file_filter',array('p'=>$p)));
		}
		if(is_array($ids)){
			$where = 'id in('.implode(',',$ids).')';
			foreach (Db::name('plug_files')->field('path')->where($where)->select() as $r) {
				$file = $r ['path'];
				if(stripos($file, "/")===0){
					$file=substr($file,1);
				}
				if (file_exists($file)) {
					unlink($file);
				}
			}
			if (Db::name('plug_files')->where($where)->delete()!==false) {
				$this->success("删除文件成功！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
			} else {
				$this->error("删除文件失败！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
			}
		}else{
			$r=Db::name('plug_files')->find($ids);
			if($r){
				$file=$r['path'];
				if(stripos($file, "/")===0){
					$file=substr($file,1);
				}
				if (file_exists($file)) {
					unlink($file);
				}
				if (Db::name('plug_files')->delete($ids)!==false) {
					$this->success("删除文件成功！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
				}else{
					$this->error("删除文件失败！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
				}
			}else{
				$this->error("删除文件失败！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
			}
		}
	}
	/**
	 * 文件删除
	 */
	public function plug_file_del()
	{
		$id=input('id');
		$p = input('p');
		if (empty($id)){
			$this->error('参数错误',url('admin/Plug/plug_file_filter',array('p'=>$p)));
		}else{
			$r=Db::name('plug_files')->find($id);
			if($r){
				$file=$r['path'];
				if(stripos($file, "/")===0){
					$file=substr($file,1);
				}
				if (file_exists($file)) {
					unlink($file);
				}
				if (Db::name('plug_files')->delete($id)!==false) {
					$this->success("删除文件成功！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
				}else{
					$this->error("删除文件失败！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
				}
			}else{
				$this->error("删除文件失败！",url('admin/Plug/plug_file_filter',array('p'=>$p)));
			}
		}
	} 
}