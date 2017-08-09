<?php

/**
 * 通用的树型类，可以生成任何树型结构
 * author:phpcms
 * edit：rainfer
 */
class Tree
{

    /**
     * 生成树型结构所需要的2维数组
     * @var array
     */
    public $arr = array();

    /**
     * 生成树型结构所需修饰符号，可以换成图片
     * @var array
     */
    private $icon = array('│', '├', '└');
    private $nbsp = '&nbsp;';
    private $str='';
    private $ret = '';
    private $config=array(
        'id'=>'id',
        'parentid'=>'parentid',
        'name'=>'name',
        'child'=>'child',
    );

    /**
     * 构造函数，初始化类
     * @param array 2维数组，例如：
     * array(
     *      1 => array('id'=>'1','parentid'=>0,'name'=>'一级栏目一'),
     *      2 => array('id'=>'2','parentid'=>0,'name'=>'一级栏目二'),
     *      3 => array('id'=>'3','parentid'=>1,'name'=>'二级栏目一'),
     *      4 => array('id'=>'4','parentid'=>1,'name'=>'二级栏目二'),
     *      5 => array('id'=>'5','parentid'=>2,'name'=>'二级栏目三'),
     *      6 => array('id'=>'6','parentid'=>3,'name'=>'三级栏目一'),
     *      7 => array('id'=>'7','parentid'=>3,'name'=>'三级栏目二')
     *      )
     * @param array $config 配置数组字段名称
     * @return boolean
     */
    public function init($arr=array(),$config=array())
    {
        $this->arr = $arr;
        $this->ret = '';
		$this->str='';
		if($config) $this->config=array_merge($this->config,$config);
        return is_array($arr);
    }
    /**
     * 递归重组节点信息为多维数组
     * @param array
     * @param int
     * @param string
     * @param string
     * @param string
     * @return array
     */
    public function get_arraylist(&$node, $pid = 0)
    {
        $arr = array();
        foreach ($node as $v) {
            if ($v [$this->config['parentid']] == $pid) {
                $v [$this->config['child']] = $this->get_arraylist($node, $v [$this->config['id']]);
                $arr [] = $v;
            }
        }
        return $arr;
    }
    /**
     * 得到父级数组的同级数组
     * @param int $myid 菜单id
     * @return array|mixed
     */
    public function get_parent($myid)
    {
        $newarr = array();
        if (!isset($this->arr[$myid])) return false;
        $pid = $this->arr[$myid][$this->config['parentid']];//父级id
        $pid = $this->arr[$pid][$this->config['parentid']];//祖级id
        if (is_array($this->arr)) {
            foreach ($this->arr as $id => $a) {
                if ($a[$this->config['parentid']] == $pid)
                    $newarr[$id] = $a;
            }
        }
        return $newarr;
    }

    /**
     * 得到子级数组的同级数组
     * @param int $myid
     * @return array|mixed
     */
    public function get_child($myid)
    {
        $newarr = array();
        if (is_array($this->arr)) {
            foreach ($this->arr as $id => $a) {
                if ($a[$this->config['parentid']] == $myid)
                    $newarr[$id] = $a;
            }
        }
        return $newarr ? $newarr : false;
    }
    /**
     * 获取所有子节点
     * @param  array  $lists 数据集
     * @param  int $pid   父级id
     * @param  bool  $only_id 是否只取id
     * @param  bool  $self 是否包含自身
     * @return array
     */
    public function get_childs($lists=[],$pid=0,$only_id=false,$self=false)
    {
        $result = [];
		if (is_array($lists)) {
			foreach ($lists as $id => $a) {
				if ($a[$this->config['parentid']] == $pid) {
					$result[] = $only_id?$a[$this->config['id']]:$a;
					unset($lists[$id]);
					$result = array_merge($result, $this->get_childs($lists,$a[$this->config['id']],$only_id,$self));
				}elseif($self && $a[$this->config['id']] == $pid){
					$result[] = $only_id?$a[$this->config['id']]:$a;
				}
			}
		}
        return $result;
    }
    /**
     * 得到当前位置数组
     * @param int 位置
     * @param array
     * @return array|mixed
     */
    public function get_pos($index, &$newarr)
    {
        $a = array();
        if (!isset($this->arr[$index])) return false;
        $newarr[] = $this->arr[$index];
        $pid = $this->arr[$index][$this->config['parentid']];
        if (isset($this->arr[$pid])) {
            $this->get_pos($pid, $newarr);
        }
		//一直到顶级的数组
        if (is_array($newarr)) {
            krsort($newarr);//降序排序
            foreach ($newarr as $v) {
                $a[$v[$this->config['id']]] = $v;
            }
        }
        return $a;
    }

    /**
     * 得到树型结构
     * @param int $myid，表示获得这个ID下的所有子级
     * @param string $str 生成树型结构的基本代码，例如："<option value=\$id \$selected>\$spacer\$name</option>"
     * @param int $sid 被选中的ID, 比如在做树形下拉框的时候需要用到
     * @param string $adds
     * @param string $str_group
     * @return string
     */
    public function get_tree($myid, $str, $sid = 0, $adds = '', $str_group = '')
    {
        $number = 1;
        //一级栏目
        $child = $this->get_child($myid);//得到子级同级数组
        if (is_array($child)) {
            $total = count($child);//子级数组个数
            foreach ($child as $id => $value) {
                $j = $k = '';
                if ($number == $total) {
                    $j .= $this->icon[2];//最后1个，前置符号为“└”
                } else {
                    $j .= $this->icon[1];//否则，前置符号为“├”
                    $k = $adds ? $this->icon[0] : '';//额外前置符号
                }
                $spacer = $adds ? $adds . $j : '';
                $selected = $id == $sid ? 'selected' : '';
                @extract($value);
                $parentid == 0 && $str_group ? eval("\$nstr = \"$str_group\";") : eval("\$nstr = \"$str\";");//顶级
                $this->ret .= $nstr;
                $nbsp = $this->nbsp;
                $this->get_tree($id, $str, $sid, $adds . $k . $nbsp, $str_group);//递归子级数组
                $number++;
            }
        }
        return $this->ret;
    }
    
    /**
     * 得到树型结构数组
     * @param int $myid，表示获得这个ID下的所有子级
     * @return array
     */
    public function get_tree_array($myid=0)
    {
        $retarray = array();
        //一级栏目数组
        $child = $this->get_child($myid);
        if (is_array($child)) {
            foreach ($child as $id => $value) {
                $retarray[$value[$this->config['id']]] = $value;
                $retarray[$value[$this->config['id']]][$this->config['child']] = $this->get_tree_array($id);
            }
        }
        return $retarray;
    }

    /**
     * 同get_tree,但允许多选
     * @param int $myid，表示获得这个ID下的所有子级
     * @param string $str 生成树型结构的基本代码，例如："<option value=\$id \$selected>\$spacer\$name</option>"
     * @param int $sid 被选中的ID, 比如在做树形下拉框的时候需要用到
     * @param string $adds
     * @return string
     */
    public function get_tree_multi($myid, $str, $sid = 0, $adds = '')
    {
        $number = 1;
        $child = $this->get_child($myid);
        if (is_array($child)) {
            $total = count($child);
            foreach ($child as $id => $a) {
                $j = $k = '';
                if ($number == $total) {
                    $j .= $this->icon[2];
                } else {
                    $j .= $this->icon[1];
                    $k = $adds ? $this->icon[0] : '';
                }
                $spacer = $adds ? $adds . $j : '';
                $selected = $this->have($sid, $id) ? 'selected' : '';
                @extract($a);
                eval("\$nstr = \"$str\";");
                $this->ret .= $nstr;
                $this->get_tree_multi($id, $str, $sid, $adds . $k . $this->nbsp);
                $number++;
            }
        }
        return $this->ret;
    }

    /**
     * @param int $myid 要查询的ID
     * @param string $str   第一种HTML代码方式
     * @param string $str2  第二种HTML代码方式
     * @param int $sid  默认选中
     * @param string $adds 前缀
     * @return string $adds 前缀
     */
    public function get_tree_category($myid, $str, $str2, $sid = 0, $adds = '')
    {
        $number = 1;
        $child = $this->get_child($myid);
        if (is_array($child)) {
            $total = count($child);
            foreach ($child as $id => $a) {
                $j = $k = '';
                if ($number == $total) {
                    $j .= $this->icon[2];
                } else {
                    $j .= $this->icon[1];
                    $k = $adds ? $this->icon[0] : '';
                }
                $spacer = $adds ? $adds . $j : '';
                $selected = $this->have($sid, $id) ? 'selected' : '';
                @extract($a);
                if (empty($html_disabled)) {
                    eval("\$nstr = \"$str\";");
                } else {
                    eval("\$nstr = \"$str2\";");
                }
                $this->ret .= $nstr;
                $this->get_tree_category($id, $str, $str2, $sid, $adds . $k . $this->nbsp);
                $number++;
            }
        }
        return $this->ret;
    }

    /**
     * 同上一类方法，jquery treeview 风格，可伸缩样式（需要treeview插件支持）
     * @param int $myid 表示获得这个ID下的所有子级
     * @param string $effected_id 需要生成treeview目录数的id
     * @param string $str 末级样式
     * @param string $str2 目录级别样式
     * @param int $showlevel 直接显示层级数，其余为异步显示，0为全部限制
     * @param string $style 目录样式 默认 filetree 可增加其他样式如'filetree treeview-famfamfam'
     * @param int $currentlevel 计算当前层级，递归使用 适用改函数时不需要用该参数
     * @param boolean $recursion 递归使用 外部调用时为FALSE
     * @return string
     */
    public function get_treeview($myid, $effected_id='example', $str="<span class='file'>\$name</span>", $str2="<span class='folder'>\$name</span>", $showlevel = 0, $style='filetree ', $currentlevel = 1, $recursion=FALSE)
    {
        $child = $this->get_child($myid);
        if (!defined('EFFECTED_INIT')) {
            $effected = ' id="' . $effected_id . '"';
            define('EFFECTED_INIT', 1);
        } else {
            $effected = '';
        }
        $placeholder = '<ul><li><span class="placeholder"></span></li></ul>';
        if (!$recursion)
            $this->str .='<ul' . $effected . '  class="' . $style . '">';
		if (is_array($child)) {
			foreach ($child as $id => $a) {
				@extract($a);
				if ($showlevel > 0 && $showlevel == $currentlevel && $this->get_child($id))
					$folder = 'hasChildren'; //如设置显示层级模式@2011.07.01
				$floder_status = isset($folder) ? ' class="' . $folder . '"' : '';
				$this->str .= $recursion ? '<ul><li' . $floder_status . ' id=\'' . $id . '\'>' : '<li' . $floder_status . ' id=\'' . $id . '\'>';
				$recursion = FALSE;
				//判断是否为终极栏目
				if ($child == 1) {
					eval("\$nstr = \"$str2\";");
					$this->str .= $nstr;
					if ($showlevel == 0 || ($showlevel > 0 && $showlevel > $currentlevel)) {
						$this->get_treeview($id, $effected_id, $str, $str2, $showlevel, $style, $currentlevel + 1, TRUE);
					} elseif ($showlevel > 0 && $showlevel == $currentlevel) {
						$this->str .= $placeholder;
					}
				} else {
					eval("\$nstr = \"$str\";");
					$this->str .= $nstr;
				}
				$this->str .=$recursion ? '</li></ul>' : '</li>';
			}		
		}
        if (!$recursion)
            $this->str .='</ul>';
        return $this->str;
    }
    
    /**
     * 生成树形菜单
     * @param int $myid 表示获得这个ID下的所有子级
     * @param string $top_ul_id 顶级菜单ul的id
     * @param string $childtpl 子菜单模板
     * @param string $parenttpl 父菜单模板
     * @param int $showlevel 直接显示层级数，其余为异步显示，0为全部限制
     * @param string $ul_class 子菜单ul样式
     * @param string $li_class 子菜单li样式
     * @param string $top_ul_class 顶级菜单ul的样式
     * @param int $currentlevel 计算当前层级，递归使用 适用改函数时不需要用该参数
     * @param boolean $recursion 递归使用 外部调用时为FALSE,内部为true
     * @param string $dropdown 有子元素时li的class
     * @return string
     */

    public function get_treeview_menu($myid,$top_ul_id='', $childtpl="<a href='\$href' class='sf-with-ul'>\$menu_name</a>", $parenttpl="<a href='#' class='sf-with-ul'>\$menu_name<span class='sf-sub-indicator'><i class='fa fa-angle-down'></i></span></a>", $showlevel = 0,  $ul_class="" ,$li_class="" , $top_ul_class='filetree ', $currentlevel = 1, $recursion=FALSE, $dropdown='hasChild')
    {
        //取出子菜单数组
    	$child = $this->get_child($myid);
    	if (!defined('EFFECTED_INIT')) {
    		$effected = ' id="' . $top_ul_id . '"';
    		define('EFFECTED_INIT', 1);
    	} else {
    		$effected = '';
    	}
	    $placeholder = '<ul><li><span class="placeholder"></span></li></ul>';
    	if (!$recursion){
    		$this->str .='<ul' . $effected . '  class="' . $top_ul_class . '">';//顶级菜单ul
    	}
		if (is_array($child)) {
			foreach ($child as $id => $a) {
				@extract($a);
				if ($showlevel > 0 && is_array($this->get_child($a[$this->config['id']]))){
					$class_str = " class='$dropdown $li_class'";
				}else{
					$class_str = " class='$li_class'";
				}
				$this->str .= $recursion ? "<ul class='$ul_class'><li  $class_str id= 'menu-item-$id'>" : "<li  $class_str   id= 'menu-item-$id'>";
				$recursion = FALSE;
				//判断是否含有子菜单
				if ($this->get_child($a[$this->config['id']])) {
					eval("\$nstr = \"$parenttpl\";");
					$this->str .= $nstr;
					if ($showlevel == 0 || ($showlevel > 0 && $showlevel > $currentlevel)) {
						$this->get_treeview_menu($a[$this->config['id']], $top_ul_id, $childtpl, $parenttpl, $showlevel,   $ul_class ,$li_class ,$top_ul_class, $currentlevel + 1, TRUE,$dropdown);
					} elseif ($showlevel > 0 && $showlevel == $currentlevel) {
						$this->str .= $placeholder;
					}
				} else {
					eval("\$nstr = \"$childtpl\";");
					$this->str .= $nstr;
				}
				$this->str .=$recursion ? '</li></ul>' : '</li>';
			}		
		}
    	if (!$recursion) $this->str .='</ul>';
    	return $this->str;
    }
    /**
     * 某list是否有某item
     * @param string $list
     * @param string $item
     * @return int|boolean
     */	
    private function have($list, $item)
    {
        return(strpos(',,' . $list . ',', ',' . $item . ','));
    }
}