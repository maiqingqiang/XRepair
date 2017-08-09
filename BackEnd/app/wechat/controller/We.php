<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\wechat\controller;

use think\Db;
use think\Validate;
use EasyWeChat\Message\Article;

class We extends WeBase
{
	public function _initialize()
    {
		parent::_initialize();
		$config=config('we_options');
		if(!empty($config)) $this->options=array_merge($this->options,$config);
	}
	//微信设置显示
	public function wesys()
    {
		$this->assign('sys',$this->options);
		return $this->fetch();
	}

	//保存微信设置
	public function runwesys()
    {
		if (!request()->isAjax()){
			$this->error('提交方式不正确',url('wechat/We/wesys'));
		}else{
			$we_options=input('post.');
			$rst=sys_config_setbyarr($we_options);
			if($rst!==false){
				$this->options=array_merge($this->options,$we_options['we_options']);
				$this->success('微信设置保存成功',url('wechat/We/wesys'));
			}else{
				$this->error('提交参数不正确',url('wechat/We/wesys'));
			}
		}
	}
    public function menu_list()
    {
        $menu=Db::name('we_menu')->order('we_menu_order')->select();
        $menu=menu_left($menu,'we_menu_id','we_menu_leftid');
        $this->assign('menu',$menu);
        if(request()->isAjax()){
            return $this->fetch('ajax_menu_list');
        }else{
            return $this->fetch();
        }
    }
    public function menu_runadd()
    {
        if(!request()->isAjax()){
            $this->error('提交方式不正确');
        }else{
			$we_menu_type=input('we_menu_type',1,'intval');
			$we_menu_typeval=input('we_menu_typeval','');
			if($we_menu_type==1){
				$rule = [
					['we_menu_typeval','url','URL地址无效']
				];
				$validate = new Validate($rule);
				$rst   = $validate->check(array(
				'we_menu_typeval'=>$we_menu_typeval
				));
				if(true !==$rst){
					$this->error('URL地址无效');
				}
			}
            $we_menu=Db::name('we_menu');
            $we_menu_leftid=input('we_menu_leftid',0,'intval');
            if($we_menu_leftid==0){
                $top_menu=$we_menu->where(['we_menu_leftid'=>0,'we_menu_open'=>1])->count();
                if ($top_menu>2){
                    $this->error('顶级菜单不能超过3个',url('wechat/We/menu_list'));
                }
            }else{
                $child_menu=$we_menu->where(['we_menu_leftid'=>$we_menu_leftid,'we_menu_open'=>1])->count();
                if ($child_menu>4){
                    $this->error('子菜单不能超过5个',url('wechat/We/menu_list'));
                }
            }
            $sldata=array(
                'we_menu_leftid'=>$we_menu_leftid,
                'we_menu_name'=>input('we_menu_name'),
                'we_menu_type'=>$we_menu_type,
                'we_menu_typeval'=>$we_menu_typeval,
                'we_menu_order'=>input('we_menu_order',50),
                'we_menu_open'=>input('we_menu_open',0),
            );
            $rst=$we_menu->insert($sldata);
            if($rst!==false){
                $this->success('菜单添加成功',url('wechat/We/menu_list'));
            }else{
                $this->error('菜单添加失败',url('wechat/We/menu_list'));
            }
        }
    }
    public function menu_state()
    {
        $id=input('x');
        $we_menu=Db::name('we_menu');
        $statusone=$we_menu->where('we_menu_id',$id)->value('we_menu_open');
        if($statusone==1){
            $statedata = array('we_menu_open'=>0);
            $we_menu->where('we_menu_id',$id)->setField($statedata);
            $this->success('状态禁止');
        }else{
            $statedata = array('we_menu_open'=>1);
            $we_menu->where('we_menu_id',$id)->setField($statedata);
            $this->success('状态开启');
        }
    }
    public function menu_order()
    {
        if (!request()->isAjax()){
            $this->error('提交方式不正确');
        }else{
            $we_menu=Db::name('we_menu');
            foreach (input('post.') as $id => $sort){
                $we_menu->where('we_menu_id',$id)->setField('we_menu_order' , $sort);
            }
            $this->success('排序更新成功',url('wechat/We/menu_list'));
        }
    }
    public function menu_del()
    {
        $menu=Db::name('we_menu')->select();
        $tree=new \Tree();
        $tree->init($menu,['parentid'=>'we_menu_leftid','id'=>'we_menu_id']);
        $ids=$tree->get_childs($menu,input('we_menu_id'),true,true);
        $rst=Db::name('we_menu')->where('we_menu_id','in',$ids)->delete();
        if($rst!==false){
            $this->success('菜单删除成功',url('wechat/We/menu_list'));
        }else{
            $this->error('菜单删除失败',url('wechat/We/menu_list'));
        }
    }
    public function menu_edit()
    {
        $we_menu_id=input('we_menu_id');
        $menu=Db::name('we_menu')->where('we_menu_id',$we_menu_id)->find();
        $menu['code']=1;
        return json($menu);
    }
    public function menu_runedit()
    {
        if(!request()->isAjax()){
            $this->error('提交方式不正确');
        }else{
			$we_menu_type=input('we_menu_type',1,'intval');
			$we_menu_typeval=input('we_menu_typeval','');
			if($we_menu_type==1){
				$rule = [
					['we_menu_typeval','url','URL地址无效']
				];
				$validate = new Validate($rule);
				$rst   = $validate->check(array(
				'we_menu_typeval'=>$we_menu_typeval
				));
				if(true !==$rst){
					$this->error('URL地址无效');
				}
			}
			$we_menu=Db::name('we_menu');
            $sldata=array(
                'we_menu_leftid'=>input('we_menu_leftid',0,'intval'),
                'we_menu_name'=>input('we_menu_name'),
                'we_menu_type'=>$we_menu_type,
                'we_menu_typeval'=>$we_menu_typeval,
                'we_menu_order'=>input('we_menu_order',50),
                'we_menu_open'=>input('we_menu_open',0),
            );
            $rst=$we_menu->where('we_menu_id',input('we_menu_id'))->update($sldata);
            if($rst!==false){
                $this->success('菜单编辑成功',url('wechat/We/menu_list'));
            }else{
                $this->error('菜单编辑失败',url('wechat/We/menu_list'));
            }
        }
    }
    public function menu_make()
    {
		//判断是否配置
		if(empty($this->options['app_id']) || empty($this->options['secret'])){
			$this->error('微信配置不正确',url('wechat/We/menu_list'));
		}
        //组装数据
        $we_menu=Db::name('we_menu')->where(array('we_menu_leftid'=>0,'we_menu_open'=>1))->order('we_menu_id')->limit(3)->select();
        if(empty($we_menu)){
            $this->error('没有菜单需要生成',url('wechat/We/menu_list'));
        }
        $new_menu = array();
        $menu_count = 0;
        foreach ($we_menu as $v){
            $new_menu[$menu_count]['name'] = $v['we_menu_name'];
            $c_menus = Db::name('we_menu')->where(array('we_menu_leftid'=>$v['we_menu_id'],'we_menu_open'=>1))->limit(5)->select();
            if($c_menus){
                foreach($c_menus as $vv){
                    $c_menu = array();
                    $c_menu['name'] = $vv['we_menu_name'];
                    $c_menu['type'] = ($vv['we_menu_type']==1)?'view':(($vv['we_menu_type']==2)?'click':$vv['we_menu_type']);
                    if($c_menu['type'] == 'view'){
                        $c_menu['url'] = $vv['we_menu_typeval'];
                    }else{
                        $c_menu['key'] = $vv['we_menu_typeval'];
                    }
                    $c_menu['sub_button'] = array();
                    if($c_menu['name']){
                        $new_menu[$menu_count]['sub_button'][] = $c_menu;
                    }
                }
            }else{
                $new_menu[$menu_count]['type'] = ($v['we_menu_type']==1)?'view':(($v['we_menu_type']==2)?'click':$v['we_menu_type']);
                if($new_menu[$menu_count]['type'] == 'view'){
                    $new_menu[$menu_count]['url'] = $v['we_menu_typeval'];
                }else{
                    $new_menu[$menu_count]['key'] = $v['we_menu_typeval'];
                }
            }
            $menu_count++;
        }
		//生成
		$menu = $this->app->menu;
		//先删除现有的
		$menu->destroy();
		//再创建
		$return=$menu->add($new_menu);
        $return=json_decode($return,true);
        if($return['errcode'] == 0){
            $this->success('菜单已成功生成',url('wechat/We/menu_list'));
        }else{
            $this->error('生成失败,错误:'.$return['errcode'],url('wechat/We/menu_list'));
        }
    }
	//同步服务端菜单到本地数据库
	public function menu_get()
    {
		$menu = $this->app->menu;
		$menus=$menu->current();
		$we_menu=Db::name('we_menu');
        if($menus['selfmenu_info']['button']){
            $we_menu->where('we_menu_id','gt',0)->delete();
        }
        $i=10;
		foreach($menus['selfmenu_info']['button'] as $v){
			//1级菜单
			$name=$v['name'];
			if(!empty($v['sub_button'])){
				//先插入数据库获得主键
				$sldata=array(
					'we_menu_leftid'=>0,
					'we_menu_name'=>$name,
					'we_menu_type'=>1,
					'we_menu_typeval'=>'',
					'we_menu_order'=>$i,
					'we_menu_open'=>1,
				);
				$we_menu_leftid=$we_menu->insertGetId($sldata);
				if($we_menu_leftid){
					//2级菜单
                    $data=array();
                    $j=10;
					foreach($v['sub_button']['list'] as $vv){
						$name=$vv['name'];
						$type=$vv['type'];
						if($type=='click'){
							$typeval=$vv['key'];
						}else{
							$typeval=$vv['url'];
						}
						$data[]=array(
						    'we_menu_name'=>$name,
                            'we_menu_type'=>($type=='click')?2:(($type=='view')?1:$type),
                            'we_menu_typeval'=>$typeval,
                            'we_menu_leftid'=>$we_menu_leftid,
                            'we_menu_order'=>$j,
                            'we_menu_open'=>1
                        );
						$j=$j+10;
					}
					//插入数据库
                    $we_menu->insertAll($data);
				}
			}else{
				$type=$v['type'];
				if($type=='click'){
					$typeval=$v['key'];
				}else{
					$typeval=$v['url'];
				}
				//插入数据库
				$sldata=array(
					'we_menu_leftid'=>0,
					'we_menu_name'=>$name,
					'we_menu_type'=>($type=='click')?2:(($type=='view')?1:$type),
					'we_menu_typeval'=>$typeval,
					'we_menu_order'=>$i,
					'we_menu_open'=>1,
				);
				$we_menu->insertGetId($sldata);
			}
            $i=$i+10;
		}
        $this->success('菜单已同步到数据库',url('wechat/We/menu_list'));
	}
	//自动回复
	public function reply_list()
    {
        $reply_list=Db::name('we_reply')->paginate(config('paginate.list_rows'));
		$show=$reply_list->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
        $this->assign('reply_list',$reply_list);
		$this->assign('page',$show);
        if(request()->isAjax()){
            return $this->fetch('ajax_reply_list');
        }else{
            return $this->fetch();
        }
    }
    public function reply_edit()
    {
        $we_reply_id=input('we_reply_id');
        $reply=Db::name('we_reply')->where('we_reply_id',$we_reply_id)->find();
		switch($reply['we_reply_type']){
			case 'image':
				$we_reply_content=$reply['we_replyimage_mediaid'];
				break;
			case 'voice':
				$we_reply_content=$reply['we_replyvoice_mediaid'];
				break;
			case 'news':
				$we_reply_content=json_decode($reply['we_replynews'],true);
				break;
			default:
				$we_reply_content=$reply['we_replytext_content'];
				break;
		}
		$reply['we_reply_content']=$we_reply_content;
        $reply['code']=1;
        return json($reply);
    }
    public function reply_runedit()
    {
        if(!request()->isAjax()){
            $this->error('提交方式不正确');
        }else{
			//回复内容
			$we_reply_type=input('we_reply_type','text');
			$field_content='we_replytext_content';
			switch($we_reply_type){
				case 'image':
					$field_content='we_replyimage_mediaid';
					$we_reply_content=input('we_reply_content');
					break;
				case 'voice':
					$field_content='we_replyvoice_mediaid';
					$we_reply_content=input('we_reply_content');
					break;
				case 'news':
					$field_content='we_replynews';
					$news_array=array(
						'title'       => input('news_title',''),
						'description' => input('news_description',''),
						'url'         => input('news_url',''),
						'image'       => input('news_image',''),
					);
					$we_reply_content=json_encode($news_array);
					break;
				default:
					$we_reply_content=input('we_reply_content');
					break;
			}
            $sldata=array(
                'we_reply_key'=>input('we_reply_key'),
                'we_reply_type'=>$we_reply_type,
                $field_content=>$we_reply_content,
                'we_reply_open'=>input('we_reply_open',0),
            );
            $rst=Db::name('we_reply')->where('we_reply_id',input('we_reply_id'))->update($sldata);
            if($rst!==false){
                $this->success('关键词回复编辑成功',url('wechat/We/reply_list'));
            }else{
                $this->error('关键词回复编辑失败',url('wechat/We/reply_list'));
            }
        }
    }
    public function reply_runadd()
    {
        if(!request()->isAjax()){
            $this->error('提交方式不正确');
        }else{
			//回复内容
			$we_reply_type=input('we_reply_type','text');
			$field_content='we_replytext_content';
			switch($we_reply_type){
				case 'image':
					$field_content='we_replyimage_mediaid';
					$we_reply_content=input('we_reply_content');
					break;
				case 'voice':
					$field_content='we_replyvoice_mediaid';
					$we_reply_content=input('we_reply_content');
					break;
				case 'news':
					$field_content='we_replynews';
					$news_array=array(
						'title'       => input('news_title',''),
						'description' => input('news_description',''),
						'url'         => input('news_url',''),
						'image'       => input('news_image',''),
					);
					$we_reply_content=json_encode($news_array);
					break;
				default:
					$we_reply_content=input('we_reply_content');
					break;
			}
            $sldata=array(
                'we_reply_key'=>input('we_reply_key'),
                'we_reply_type'=>$we_reply_type,
                $field_content=>$we_reply_content,
                'we_reply_open'=>input('we_reply_open',0),
				'we_reply_addtime'=>time()
            );
            $rst=Db::name('we_reply')->insert($sldata);
            if($rst!==false){
                $this->success('关键词回复添加成功',url('wechat/We/reply_list'));
            }else{
                $this->error('关键词回复添加失败',url('wechat/We/reply_list'));
            }
        }
    }
    public function reply_state()
    {
        $id=input('x');
        $we_reply=Db::name('we_reply');
        $statusone=$we_reply->where('we_reply_id',$id)->value('we_reply_open');
        if($statusone==1){
            $statedata = array('we_reply_open'=>0);
            $we_reply->where('we_reply_id',$id)->setField($statedata);
            $this->success('状态禁止');
        }else{
            $statedata = array('we_reply_open'=>1);
            $we_reply->where('we_reply_id',$id)->setField($statedata);
            $this->success('状态开启');
        }
    }
	//全选删除
	public function reply_alldel()
    {
		$p = input('p');
		$ids = input('we_reply_id/a');
		if(empty($ids)){
			$this -> error("请选择删除的关键词回复",url('wechat/We/reply_list',array('p'=>$p)));
		}
		if(!is_array($ids)){
			$ids[]=$ids;
		}
		$rst=Db::name('we_reply')->where('we_reply_id','in',$ids)->delete();
		if($rst!==false){
			$this->success("关键词回复删除成功",url('wechat/We/reply_list',array('p'=>$p)));
		}else{
			$this -> error("关键词回复删除失败",url('wechat/We/reply_list',array('p'=>$p)));
		}
	}
	public function reply_del()
    {
		$p=input('p');
		$we_reply_id=input('we_reply_id');
		$rst=Db::name('we_reply')->where('we_reply_id',$we_reply_id)->delete();
		if($rst!==false){
			$this->success('关键词回复删除成功',url('wechat/We/reply_list',array('p'=>$p)));
		}else{
			$this->error('关键词回复删除失败',url('wechat/We/reply_list',array('p'=>$p)));
		}
	}
	public function mats_list()
    {
        $mats_list=Db::name('we_mats')->paginate(config('paginate.list_rows'));
		$show=$mats_list->render();
		$show=preg_replace("(<a[^>]*page[=|/](\d+).+?>(.+?)<\/a>)","<a href='javascript:ajax_page($1);'>$2</a>",$show);
        $this->assign('mats_list',$mats_list);
		$this->assign('page',$show);
        if(request()->isAjax()){
            return $this->fetch('ajax_mats_list');
        }else{
            return $this->fetch();
        }
    }
	//同步服务端素材到本地数据库
	public function mats_get()
    {
		$mats=Db::name('we_mats');
		$material = $this->app->material;
		$types=array('image','video','voice','news');
		$data=array();
		foreach($types as $type){
			$lists = $material->lists($type, 0, 20);
			$lists=json_decode($lists,true);
			if(!isset($lists['item'])){
				continue;
			}
			$total_count=$lists['total_count'];
			foreach($lists['item'] as $item){
				foreach($item['content']['news_item'] as $key=>$news_item){
					$sldata=array(
						'mats_name'=>($type=='news')?$news_item['title']:$item['name'],
						'mats_type'=>$type,
						'media_id'=>$item['media_id'],
						'update_time'=>$item['update_time'],
						'create_time'=>$item['update_time'],
						'news_content'=>($type=='news')?json_encode($news_item):'',
						'news_index'=>($type=='news')?$key:0,
						'url'=>($type=='news')?'':(isset($item['url'])?$item['url']:''),
					);
					$data[]=$sldata;
				}
			}
			$i=1;
			$total_count=$total_count-20;
			while($total_count>0){
				$start=$i*20-1;
				$lists = $material->lists($type, $start, 20);
				$lists=json_decode($lists,true);
				if(!isset($lists['item'])){
					continue;
				}
				foreach($lists['item'] as $item){
					foreach($item['content']['news_item'] as $key=>$news_item){
						$sldata=array(
							'mats_name'=>($type=='news')?$news_item['title']:$item['name'],
							'mats_type'=>$type,
							'media_id'=>$item['media_id'],
							'update_time'=>$item['update_time'],
							'create_time'=>$item['update_time'],
							'news_content'=>($type=='news')?json_encode($news_item):'',
							'news_index'=>($type=='news')?$key:0,
							'url'=>($type=='news')?'':(isset($item['url'])?$item['url']:''),
						);
						$data[]=$sldata;
					}
				}
				$total_count=$total_count-20;
				$i++;
			}
		}
		$mats->insertAll($data);
		$this->success('同步素材列表成功',url('wechat/We/mats_list'));
	}
	public function mats_edit()
    {
		$mats_id=input('mats_id');
        $mats_list=Db::name('we_mats')->find($mats_id);
		$mats_list['news_content']=json_decode($mats_list['news_content'],true);
		$mats_list['video_content']=json_decode($mats_list['video_content'],true);
        $this->assign('mats_list',$mats_list);
        return $this->fetch();
    }
	public function mats_runedit()
    {
		$mats_id=input('mats_id');
		$news_index=input('news_index',0,'intval');
        $mats_list_old=Db::name('we_mats')->find($mats_id);
		$mats_content_old=json_decode($mats_list_old['news_content'],true);
		$title=input('mats_title');
		$mats_author=input('mats_author');
		$mats_digest=input('mats_digest');
		$mats_content_source_url=input('mats_content_source_url');
		$mats_thumb_media_id=input('mats_thumb_media_id');
		$mats_show_cover_pic=input('mats_show_cover_pic',0,'intval');
		$mats_content=htmlspecialchars_decode(input('mats_content'));
		//比较是否有修改
		if($title!=$mats_content_old['title'] || $mats_author!=$mats_content_old['author'] || $mats_digest!=$mats_content_old['digest'] || $mats_content_source_url!=$mats_content_old['content_source_url'] || $mats_thumb_media_id!=$mats_content_old['thumb_media_id'] || $mats_show_cover_pic!=$mats_content_old['show_cover_pic'] || $mats_content!=$mats_content_old['content']){
            $new_data=array(
                'title'=> $title,
                'thumb_media_id' => $mats_thumb_media_id,
                'author' => $mats_author,
                'digest' => $mats_digest,
                'show_cover_pic' => $mats_show_cover_pic,
                'content_source_url' => $mats_content_source_url,
                'content' => $mats_content
            );
            $result = $this->app->material->updateArticle($mats_list_old['media_id'], $new_data,$news_index);
            $result=json_decode($result,true);
            if(isset($result['errcode']) && $result['errcode']==0){
                //修改本地
                $mats_content_old=array_merge($mats_content_old,$new_data);
                $sldata=array(
                    'mats_name'=>$title,
                    'news_content'=>json_encode($mats_content_old),
                    'update_time'=>time()
                );
                Db::name('we_mats')->where('mats_id',$mats_id)->update($sldata);
                $this->success('修改成功',url('wechat/We/mats_list'));
            }else{
                $this->error('修改失败',url('wechat/We/mats_list'));
            }
		}else{
			$this->success('未修改,直接返回',url('wechat/We/mats_list'));
		}
    }
    public function mats_add()
    {
        return $this->fetch();
    }
    public function mats_runadd()
    {
        $mats_type=input('mats_type');
        $mats_name=input('mats_name');
        if($mats_type=='news'){
            $mediaId='';
            $show_cover_pic=input('show_cover_pic',0,'intval');
            $file=request()->file('news_thumb');
            if($file && $show_cover_pic){
                $info = $file->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
                if($info) {
                    $file_url=ROOT_PATH.config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
                    //上传微信
                    $material = $this->app->material;
                    $result = $material->uploadThumb($file_url,input('video_title'),input('video_introduction'));
                    $mediaId = $result->media_id;
                    if($mediaId){
                    }else{
                        $file = null;
                        @unlink($file_url);
                        $this->error('上传微信平台失败',url('wechat/We/mats_list'));
                    }
                }else{
                    $this->error($file->getError(),url('wechat/We/mats_list'));
                }
            }
            //加入素材数据库
            $new_data=array(
                'title'=> input('news_title'),
                'thumb_media_id' => $mediaId,
                'author' => input('news_author'),
                'digest' => input('news_digest'),
                'show_cover_pic' => $show_cover_pic,
                'content_source_url' => input('content_source_url'),
                'content' => htmlspecialchars_decode(input('mats_content'))
            );
            //上传图文素材
            $article = new Article($new_data);
            $result=$this->app->material->uploadArticle($article);
            $mediaId = $result->media_id;
            if($mediaId){
                $sldata=array(
                    'mats_name'=>$mats_name,
                    'mats_type'=>$mats_type,
                    'media_id'=>$mediaId,
                    'news_content'=>json_encode($new_data),
                    'create_time'=>time(),
                    'update_time'=>time()
                );
                Db::name('we_mats')->insert($sldata);
                $this->success('上传成功',url('wechat/We/mats_list'));
            }else{
                $this->error('上传微信平台失败',url('wechat/We/mats_list'));
            }
        }else{
            $url=$mediaId='';
            $file=request()->file('mats_file');
            if($file){
                $info = $file->rule('uniqid')->move(ROOT_PATH . config('upload_path') . DS . date('Y-m-d'));
                if($info) {
                    $file_url=ROOT_PATH.config('upload_path'). '/' . date('Y-m-d') . '/' . $info->getFilename();
                    //上传微信
                    $material = $this->app->material;
                    switch ($mats_type){
                        case 'voice':
                            $result = $material->uploadVoice($file_url);
                            $mediaId = $result->media_id;
                            break;
                        case 'video':
                            $result = $material->uploadVideo($file_url,input('video_title'),input('video_introduction'));
                            $mediaId = $result->media_id;
                            break;
                        case 'thumb':
                            $result = $material->uploadThumb($file_url,input('video_title'),input('video_introduction'));
                            $mediaId = $result->media_id;
                            break;
                         default :
                             $result = $material->uploadImage($file_url,input('video_title'),input('video_introduction'));
                             $mediaId = $result->media_id;
                             $url = $result->url;
                             break;
                    }
                    if($mediaId){
                        if($mats_type=='image'){
                            $data['mtime']=time();
                            $data['url']=$url;
                            Db::name('we_pic')->insert($data);
                        }
                        //加入素材数据库
                        $sldata=array(
                            'mats_name'=>$mats_name,
                            'mats_type'=>$mats_type,
                            'media_id'=>$mediaId,
                            'url'=>$url,
                            'create_time'=>time(),
                            'update_time'=>time()
                        );
                        if($mats_type=='video'){
                            $sldata['video_content']=json_encode(['title'=>input('video_title'),'introduction'=>input('video_introduction')]);
                        }
                        Db::name('we_mats')->insert($sldata);
                        $file = null;
                        @unlink($file_url);
                        $this->success('上传成功',url('wechat/We/mats_list'));
                    }else{
                        $file = null;
                        @unlink($file_url);
                        $this->error('上传微信平台失败',url('wechat/We/mats_list'));
                    }
                }else{
                    $this->error($file->getError(),url('wechat/We/mats_list'));
                }
            }else{
                $this->error('文件上传失败',url('wechat/We/mats_list'));
            }
        }
    }
    public function mats_del()
    {
        $mats_id=input('mats_id');
        $mast_list=Db::name('we_mats')->find($mats_id);
        if(empty($mast_list)){
            $this->error('不存在此素材',url('wechat/We/mats_list'));
        }
        $mediaId=$mast_list['media_id'];
        $result=$this->app->material->delete($mediaId);
        $result=json_decode($result,true);
        if(isset($result['errcode']) && $result['errcode']==0){
            Db::name('we_mats')->delete($mats_id);
            $this->success('素材删除成功',url('wechat/We/mats_list'));
        }else{
            $this->error('素材删除失败',url('wechat/We/mats_list'));
        }
    }
    public function mats_alldel()
    {
        $mats_ids=input('mats_id_id/a');
        if(!is_array($mats_ids)){
            $mats_ids[]=$mats_ids;
        }
        foreach ($mats_ids as $mats_id){
            $mast_list=Db::name('we_mats')->find($mats_id);
            if(empty($mast_list)){
                continue;
            }
            $mediaId=$mast_list['media_id'];
            $result=$this->app->material->delete($mediaId);
            $result=json_decode($result,true);
            if(isset($result['errcode']) && $result['errcode']==0){
                Db::name('we_mats')->delete($mats_id);
            }else{
                continue;
            }
        }
        $this->success('素材删除成功',url('wechat/We/mats_list'));
    }
}