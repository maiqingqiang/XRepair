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
use think\helper\Time;
use app\admin\model\News as NewsModel;
use app\admin\model\MemberList;

class Index extends Base
{
    /**
     * 后台首页
     */
	public function index()
	{
		$news_model=new NewsModel;
		$member_model=new MemberList;
		//热门文章排行
		$news_list=$news_model->where('news_l',$this->lang)->order('news_hits desc')->limit(0,10)->select();
		$this->assign('news_list',$news_list);
		//总文章数
		$news_count=$news_model->count();
		$this->assign('news_count',$news_count);
        //总会员数
        $members_count=$member_model->count();
        $this->assign('members_count',$members_count);
        //总留言数
        $sugs_count=Db::name('plug_sug')->count();
        $this->assign('sugs_count',$sugs_count);
        //总评论数
        $coms_count=Db::name('comments')->count();
        $this->assign('coms_count',$coms_count);
		
		//日期时间戳
		list($start_t, $end_t) = Time::today();
		list($start_y, $end_y) = Time::yesterday();

		//今日发表文章数
		$tonews_count=$news_model->whereTime('news_time', 'between', [$start_t, $end_t])->count();
		$this->assign('tonews_count',$tonews_count);

		//昨日文章数
		$ztnews_count=$news_model->whereTime('news_time', 'between', [$start_y, $end_y])->count();
		$this->assign('ztnews_count',$ztnews_count);
		//今日提升比
		$difday=($ztnews_count>0)?($tonews_count-$ztnews_count)/$ztnews_count*100:0;
		$this->assign('difday',$difday);
		
		//今日增加会员
        $tomembers_count=$member_model->whereTime('member_list_addtime', 'between', [$start_t, $end_t])->count();
        $this->assign('tomembers_count',$tomembers_count);
        //昨日会员数
        $ztmembers_count=$member_model->whereTime('member_list_addtime', 'between', [$start_y, $end_y])->count();
        $this->assign('ztmembers_count',$ztmembers_count);
		//今日提升比
        $difday_m=($ztmembers_count>0)?($tomembers_count-$ztmembers_count)/$ztmembers_count*100:0;
        $this->assign('difday_m',$difday_m);
		
        //今日留言
        $tosugs_count=Db::name('plug_sug')->whereTime('plug_sug_addtime', 'between', [$start_t, $end_t])->count();
        $this->assign('tosugs_count',$tosugs_count);
		//昨日留言
        $ztsugs_count=Db::name('plug_sug')->whereTime('plug_sug_addtime', 'between', [$start_y, $end_y])->count();
        $this->assign('ztsugs_count',$ztsugs_count);
		//今日提升比
        $difday_s=($ztsugs_count>0)?($tosugs_count-$ztsugs_count)/$ztsugs_count*100:0;
        $this->assign('difday_s',$difday_s);
		
        //今日评论
        $tocoms_count=Db::name('comments')->whereTime('createtime', 'between', [$start_t, $end_t])->count();
        $this->assign('tocoms_count',$tocoms_count);
		//昨日评论
        $ztcoms_count=Db::name('comments')->whereTime('createtime', 'between', [$start_y, $end_y])->count();
        $this->assign('ztcoms_count',$ztcoms_count);
		//今日提升比
        $difday_c=($ztcoms_count>0)?($tocoms_count-$ztcoms_count)/$ztcoms_count*100:0;
        $this->assign('difday_c',$difday_c);
		//渲染模板
        return $this->fetch();
	}
    /**
     * 后台多语言切换
     */
	public function lang()
	{
		if (!request()->isAjax()){
			$this->error('提交方式不正确');
		}else{
			$lang=input('lang_s');
			session('login_http_referer',$_SERVER["HTTP_REFERER"]);
			switch ($lang) {
				case 'cn':
					cookie('think_var', 'zh-cn');
				break;
				case 'en':
					cookie('think_var', 'en-us');
				break;
				//其它语言
				default:
					cookie('think_var', 'zh-cn');
			}
			Cache::clear();
			$this->success('切换成功',session('login_http_referer'));
		}
	}
}