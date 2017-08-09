<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------

namespace app\admin\model;

use think\Model;

/**
 * 文章模型
 * @package app\admin\model
 */
class News extends Model
{
	protected $insert = ['news_hits' => 200];
	public function user()
	{
		return $this->belongsTo('MemberList','member_list_id');
	}
	public function menu()
	{
		return $this->belongsTo('Menu','id');
	}
}
