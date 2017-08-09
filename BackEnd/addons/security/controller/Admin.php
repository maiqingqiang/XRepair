<?php
// +----------------------------------------------------------------------
// | YFCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.rainfer.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: rainfer <81818832@qq.com>
// +----------------------------------------------------------------------
namespace addons\security\controller;

use think\addons\Base;

class Admin extends Base
{
	protected function _initialize()
	{
		//调用admin/Base控制器的初始化
		action('admin/Base/_initialize');
	}
	/*
	 * 安全文件列表
	 */
	public function security_list()
	{
		$security_dir=ROOT_PATH.'data/security/';
		if (!file_exists($security_dir)) {
			@mkdir($security_dir);
		}
		$finger_files = list_file($security_dir, '*.finger');
		$this->assign('finger_files',$finger_files);
		return $this->fetch();
	}
	/*
	 * 安全文件生成
	 */
	public function security_generate()
	{
		$security_dir=ROOT_PATH.'data/security/';
		if (!file_exists($security_dir)) {
			@mkdir($security_dir);
		}
		$filename = $security_dir . 'file_finger_' . date('YmdHi') . '_' . random(10) . '.finger';
		$f = fopen($filename, 'w');
		fwrite($f, "GENE: RCF V" . THINK_VERSION . "\n");
		fwrite($f, "TIME: " . date('Y-m-d H:i:s') . "\n");
		fwrite($f, "ROOT: \n");
		$files_md5 = array();
		foreach (array(
					//检测目录
					 'vendor',
					 'app',
					 'extend',
					 'public',
					 'thinkphp',
					 'addons'
				 ) as $dir) {
			foreach ($this->security_filefingergenerate('./' . $dir . '/', $dir . '/') as $file_md5) {
				$files_md5 [] = $file_md5;
				fwrite($f, $file_md5 [1] . '|' . $file_md5 [0] . "\n");
			}
		}
		fclose($f);
		$this->success('成功生成安全文件',addon_url('security://Admin/security_list'));
	}
	/*
	 * 安全文件删除
	 */
	public function security_delete()
	{
		$security_dir=ROOT_PATH.'data/security/';
		if (!file_exists($security_dir)) {
			$this->error('文件不存在',addon_url('security://Admin/security_list'));
		}
		$file=input('file');
		foreach (list_file($security_dir, '*.finger') as $f) {
			if (md5($f ['filename']) == $file) {
				@unlink($f ['pathname']);
			}
		}
		$this->success('成功删除',addon_url('security://Admin/security_list'));
	}
	/*
	 * 安全检测
	 */
	public function security_check()
	{
		$security_dir=ROOT_PATH.'data/security/';
		if (!file_exists($security_dir)) {
			$this->error('文件不存在',addon_url('security://Admin/security_list'));
		}
		$md5_file = null;
		$file=input('file');
		foreach (list_file($security_dir, '*.finger') as $f) {
			if (md5($f ['filename']) == $file) {
				$md5_file = $f ['pathname'];
				break;
			}
		}
		if (null != $md5_file) {
			if (!file_exists($md5_file) || !is_file($md5_file)) {
				$this->error('文件不存在',addon_url('security://Admin/security_list'));
			}
			$lines = explode("\n", file_get_contents($md5_file));
			if (count($lines) < 3) {
				$this->error('安全文件错误',addon_url('security://Admin/security_list'));
			}
			if (!preg_match('/^GENE: RCF V.*?$/', $lines [0]) || !preg_match('/^TIME: \\d+\\-\\d+\\-\\d+ \\d+:\\d+:\\d+$/', $lines [1]) || !preg_match('/^ROOT: ([\\/\\.]*)/', $lines [2])) {
				$this->error('安全文件错误',addon_url('security://Admin/security_list'));
			}
			$finger_file_root = trim(substr($lines [2], 5));
			$basedir = str_replace('\\', '/', rtrim(realpath($finger_file_root), '\\/')) . '/';
			unset ($lines [0], $lines [1], $lines [2]);
			$error_msgs = array();
			$file_should_exists = array();
			foreach ($lines as $line) {
				$line = trim($line);
				if ($line) {
					$l = explode('|', $line);
					if (count($l) == 2) {
						$file = trim($l [1]);
						$md5 = trim($l [0]);
						$file_should_exists [$file] = $md5;
						if (file_exists($filename = $basedir . $file)) {
							if ($md5 != md5_file($filename)) {
								$error_msgs [] = '文件被篡改 : ' . $file;
							}
						} else {
							$error_msgs [] = '缺少文件 : ' . $file;
						}
					} else {
						$error_msgs [] = '错误行 : ' . $line;
					}
				}
			}
			$this->assign('error_msgs',$error_msgs);
			return $this->fetch();
		}else{
			$this->error('文件不存在',addon_url('security://Admin/security_list'));
		}
	}
	//安全文件生成
	private function security_filefingergenerate($dir = '', $prefix = '')
	{
		static $allow_file_exts = array(
			'php' => true,
			'js' => true,
			'html' => true,
			'htm' => true
		);
		$file_arrs = array();
		foreach (list_file($dir) as $file) {
			if ($file ['isDir']) {
				$file_arrs = array_merge($file_arrs, $this->security_filefingergenerate($file ['pathname'] . '/', $prefix . $file ['filename'] . '/'));
			} else if ($file ['isFile']) {
				if (isset ($allow_file_exts [$file ['ext']])) {
					$file_saved = $prefix . str_replace('\\', '/', $file ['filename']);
					$file_arrs [] = array(
						$file_saved,
						md5_file($file ['pathname'])
					);
				}
			}
		}
		return $file_arrs;
	}
}