<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------

if(config('log.clear_on')){
	// 删除指定时间的日志(默认1个月)
	$timebf=config('timebf')?:2592000;
	foreach (list_file(LOG_PATH) as $f) {
		if ($f ['isDir']) {
			foreach (list_file($f ['pathname'] . '/', '*.log') as $ff) {
				if ($ff ['isFile']) {
					if (time() - $ff ['mtime'] > $timebf) {
						@unlink($ff ['pathname']);
					}
				}
			}
		}
	}
}