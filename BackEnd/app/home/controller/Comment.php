<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace app\home\controller;

use think\Db;

class Comment extends Base
{
	//个人中心-我的评论
    public function index()
    {
		$this->check_login();
		$uid=$this->user['member_list_id'];
		$where=array("uid"=>$uid);
		$comments=Db::name('comments')->alias("a")->join(config('database.prefix').'news b','a.t_id =b.n_id')->where($where)
		->order("createtime desc")
		->paginate(config('paginate.list_rows'));
		$show=$comments->render();
		$this->assign('page',$show);
		$this->assign("comments",$comments);
		return $this->view->fetch('user:comment');
	}
	//发表评论
    public function runcomment()
    {
        if(!config('comment.t_open')){
            $this->error(lang('comment not open'));
        }
		$this->check_login();
        $this->check_last_action(config('comment.t_limit'));//评论间隔时间
		if (request()->isPost()){
            $data['t_name']='news';
            $data['t_id']=input('n_id');
            $data['uid']=$this->user['member_list_id'];
            $data['to_uid']=input('to_uid',0,'intval');
            $data['full_name']=$this->user['member_list_username'];
            $data['email']=$this->user['member_list_email'];
            $data['createtime']=time();
            $data['c_content']=htmlspecialchars_decode(input('c_content'));
            $data['parentid']=input('parentid',0,'intval');
			$result=Db::name('comments')->insertGetId($data);
			if ($result!==false){
				//评论计数
				$table_model=Db::name($data['t_name']);
				$pk=$table_model->getPk();
				$table_model->where(array($pk=>$data['t_id']))->update(array("comment_count"=>array("exp","comment_count+1")));
				//更新path字段
				if($data['parentid']){
					$rst=Db::name('comments')->find($data['parentid']);
					$path=$rst['path'].'-'.$result;
				}else{
					$path='0-'.$result;
				}
				Db::name('comments')->where(array('c_id'=>$result))->setField('path',$path);
				return json(array("id"=>$result,'user'=>$this->user,'msg'=>lang('comment success'),'code'=>1));
			} else {
				$this->error(lang('comment failed'));
			}
		}else{
            $this->error(lang('submission mode incorrect'));
        }
	}
}