/************************************************************* 所有带确认的ajax提交btn ********************************************************/
/* get执行并返回结果，执行后不带跳转 */
$(function () {
	$('body').on('click','.rst-btn',function () {
        var $url = this.href;
        $.get($url, function (data) {
            if (data.code == 1) {
                layer.alert(data.msg, {icon: 6});
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* get执行并返回结果，执行后带跳转 */
$(function () {
	$('body').on('click','.rst-url-btn',function () {
        var $url = this.href;
        $.get($url, function (data) {
            if (data.code==1) {
                layer.alert(data.msg, {icon: 6}, function (index) {
                    layer.close(index);
                    window.location.href = data.url;
                });
            } else {
                layer.alert(data.msg, {icon: 5}, function (index) {
                    layer.close(index);
                });
            }
        }, "json");
        return false;
    });
});
/* 直接跳转 */
$(function () {
	$('body').on('click','.confirm-btn',function () {
        var $url = this.href,
            $info = $(this).data('info');
        layer.confirm($info, {icon: 3}, function (index) {
            layer.close(index);
            window.location.href = $url;
        });
        return false;
    });
});
/* post执行并返回结果，执行后不带跳转 */
$(function () {
	$('body').on('click','.confirm-rst-btn',function () {
        var $url = this.href,
            $info = $(this).data('info');
        layer.confirm($info, {icon: 3}, function (index) {
            layer.close(index);
            $.post($url, {}, function (data) {
                layer.alert(data.msg, {icon: 6});
            }, "json");
        });
        return false;
    });
});
/* get执行并返回结果，执行后带跳转 */
$(function () {
	$('body').on('click','.confirm-rst-url-btn',function () {
        var $url = this.href,
            $info = $(this).data('info');
        layer.confirm($info, {icon: 3}, function (index) {
            layer.close(index);
            $.get($url, function (data) {
                if (data.code==1) {
                    layer.alert(data.msg, {icon: 6}, function (index) {
                        layer.close(index);
                        window.location.href = data.url;
                    });
                } else {
                    layer.alert(data.msg, {icon: 5}, function (index) {
                        layer.close(index);
                    });
                }
            }, "json");
        });
        return false;
    });
});
$(function () {
    $('body').on('click','.confirm-url-btn',function () {
        var $url = this.href,
            $info = $(this).data('info');
        layer.confirm($info, {icon: 3}, function (index) {
            layer.close(index);
            window.location.href = $url;
        });
        return false;
    });
});
/*************************************************************************** 所有状态类的ajax提交btn ********************************************************/
/* 审核状态操作 */
$(function () {
	$('body').on('click','.state-btn',function () {
        var $url = this.href,
            val = $(this).data('id'),
            $btn=$(this);
        $.post($url, {x: val}, function (data) {
            if (data.code==1) {
                if (data.msg == '未审') {
                    var a = '<button class="btn btn-minier btn-danger">未审</button>';
                    $btn.children('div').html(a).attr('title','未审');
                    return false;
                } else {
                    var b = '<button class="btn btn-minier btn-yellow">已审</button>';
                    $btn.children('div').html(b).attr('title','已审');
                    return false;
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
$(function () {
	$('body').on('click','#btnorder',function () {
        var $url=$(this).attr("href");
        if(!$url){
            $url=$(this).parents('form').attr('action');
        }
        $.post($url, $("input.list_order").serialize(), function (data) {
            if (data.code==1) {
                layer.alert(data.msg, {icon: 6}, function (index) {
					window.location.href = data.url;
                    layer.close(index);
                });
            }else{
                layer.alert(data.msg, {icon: 5}, function (index) {
                    layer.close(index);
                });
            }
        }, "json");
        return false;
    });
});
/* 启用状态操作 */
$(function () {
	$('body').on('click','.open-btn',function () {
        var $url = this.href,
            val = $(this).data('id'),
            $btn=$(this);
        $.post($url, {x: val}, function (data) {
            if (data.code==1) {
                if (data.msg == '状态禁止') {
                    var a = '<button class="btn btn-minier btn-danger">禁用</button>';
                    $btn.children('div').html(a).attr('title','已禁用');
                    return false;
                } else {
                    var b = '<button class="btn btn-minier btn-yellow">开启</button>';
                    $btn.children('div').html(b).attr('title','已开启');
                    return false;
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 显示状态操作 */
$(function () {
	$('body').on('click','.display-btn',function () {
        var $url = this.href,
            val = $(this).data('id'),
            $btn=$(this);
        $.post($url, {x: val}, function (data) {
            if (data.code==1) {
                if (data.msg == '状态禁止') {
                    var a = '<button class="btn btn-minier btn-danger">隐藏</button>';
                    $btn.children('div').html(a).attr('title','已隐藏');
                    return false;
                } else {
                    var b = '<button class="btn btn-minier btn-yellow">显示</button>';
                    $btn.children('div').html(b).attr('title','已显示');
                    return false;
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 检测状态操作 */
$(function () {
    $('body').on('click','.notcheck-btn',function () {
        var $url = this.href,
            val = $(this).data('id'),
            $btn=$(this);
        $.post($url, {x: val}, function (data) {
            if (data.code==1) {
                if (data.msg == '检测') {
                    var a = '<button class="btn btn-minier btn-yellow">检测</button>';
                    $btn.children('div').html(a).attr('title','检测');
                    return false;
                } else {
                    var b = '<button class="btn btn-minier btn-danger">不检测</button>';
                    $btn.children('div').html(b).attr('title','不检测');
                    return false;
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 激活状态操作 */
$(function () {
	$('body').on('click','.active-btn',function () {
        var $url = this.href,
            val = $(this).data('id'),
            $btn=$(this);
        $.post($url, {x: val}, function (data) {
            if (data.code==1) {
                if (data.msg == '未激活') {
                    var a = '<button class="btn btn-minier btn-danger">未激活</button>';
                    $btn.children('div').html(a).attr('title','未激活');
                    return false;
                } else {
                    var b = '<button class="btn btn-minier btn-yellow">已激活</button>';
                    $btn.children('div').html(b).attr('title','已激活');
                    return false;
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/*************************************************************************** 所有ajaxForm提交 ********************************************************/
/* 通用表单不带检查操作，失败不跳转 */
$(function () {
    $('.ajaxForm').ajaxForm({
        success: complete2, // 这是提交后的方法
        dataType: 'json'
    });
});
/* 通用表单不带检查操作，失败跳转 */
$(function () {
    $('.ajaxForm2').ajaxForm({
        success: complete, // 这是提交后的方法
        dataType: 'json'
    });
});
/* 通用含验证码表单不带检查操作，失败不跳转 */
$(function () {
    $('.ajaxForm3').ajaxForm({
        success: complete3, // 这是提交后的方法
        dataType: 'json'
    });
});
/* 会员增加编辑表单，带检查 */
$(function () {
    $('.memberform').ajaxForm({
        beforeSubmit: checkmemberForm, // 此方法主要是提交前执行的方法，根据需要设置
        success: complete, // 这是提交后的方法
        dataType: 'json'
    });
});
/* admin增加编辑表单，带检查 */
$(function () {
    $('.adminform').ajaxForm({
        beforeSubmit: checkadminForm, // 此方法主要是提交前执行的方法，根据需要设置
        success: complete, // 这是提交后的方法
        dataType: 'json'
    });
});
/* 多选删除操作 */
$(function () {
    $('#alldel').ajaxForm({
        beforeSubmit: checkselectForm, // 此方法主要是提交前执行的方法，根据需要设置，一般是判断为空获取其他规则
        success: complete2, // 这是提交后的方法
        dataType: 'json'
    });
});
//失败跳转
function complete(data) {
    if (data.code == 1) {
        layer.alert(data.msg, {icon: 6}, function (index) {
            layer.close(index);
            window.location.href = data.url;
        });
    } else {
        layer.alert(data.msg, {icon: 5}, function (index) {
            layer.close(index);
            window.location.href = data.url;
        });
        return false;
    }
}
//失败不跳转
function complete2(data) {
    if (data.code == 1) {
        layer.alert(data.msg, {icon: 6}, function (index) {
            layer.close(index);
            window.location.href = data.url;
        });
    } else {
        layer.alert(data.msg, {icon: 5}, function (index) {
            layer.close(index);
        });
    }
}
//失败不跳转,验证码刷新
function complete3(data) {
    if (data.code == 1) {
        window.location.href = data.url;
    } else {
        $("#verify").val('');
        $("#verify_img").click();
        layer.alert(data.msg, {icon: 5});
    }
}
//admin表单检查
function checkadminForm() {
    var admin_username = $.trim($('input[name="admin_username"]').val()); //获取INPUT值
    var myReg = /^[\u4e00-\u9fa5]+$/;//验证中文
    if (admin_username.indexOf(" ") >= 0) {
        layer.alert('登录用户名包含了空格，请重新输入', {icon: 5}, function (index) {
            layer.close(index);
            $('#admin_username').focus();
        });
        return false;
    }
    if (myReg.test(admin_username)) {
        layer.alert('用户名必须是字母，数字，符号', {icon: 5}, function (index) {
            layer.close(index);
            $('#admin_username').focus();
        });
        return false;
    }
    if (!$("#admin_tel").val().match(/^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/)) {
        layer.alert('电话号码格式不正确', {icon: 5}, function (index) {
            layer.close(index);
            $('#admin_tel').focus();
        });
        return false;
    }
}
//member表单检查
function checkmemberForm() {
    if (!$("#member_list_tel").val().match(/^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/)) {
        layer.alert('电话号码格式不正确', {icon: 5}, function (index) {
            layer.close(index);
            $('#member_list_tel').focus();
        });
        return false;
    }
}
//多选表单检查
function checkselectForm() {
    var chk_value = [];
    $('input[id="navid"]:checked').each(function () {
        chk_value.push($(this).val());
    });

    if (!chk_value.length) {
        layer.alert('至少选择一个删除项', {icon: 5});
        return false;
    }
}
/*************************************************************************** 所有css操作 ********************************************************/
/* 菜单样式 */
$(function () {
    //插入header-nav
    $('#sidebar2').insertBefore('.page-content');
    $('.navbar-toggle[data-target="#sidebar2"]').insertAfter('#menu-toggler');
    //固定
    $(document).on('settings.ace.two_menu', function (e, event_name, event_val) {
        if (event_name == 'sidebar_fixed') {
            if ($('#sidebar').hasClass('sidebar-fixed')) {
                $('#sidebar2').addClass('sidebar-fixed');
                $('#navbar').addClass('h-navbar');
            }
            else {
                $('#sidebar2').removeClass('sidebar-fixed');
                $('#navbar').removeClass('h-navbar');
            }
        }
    }).triggerHandler('settings.ace.two_menu', ['sidebar_fixed', $('#sidebar').hasClass('sidebar-fixed')]);
});
/* 多选判断 */
function unselectall() {
    if (document.myform.chkAll.checked) {
        document.myform.chkAll.checked = document.myform.chkAll.checked & 0;
    }
}
function CheckAll(form) {
    for (var i = 0; i < form.elements.length; i++) {
        var e = form.elements[i];
        if (e.Name != 'chkAll' && e.disabled == false) {
            e.checked = form.chkAll.checked;
        }
    }
}
/* 日期选择器 */
var dateInput = $("input.js-date")
if (dateInput.length) {
	dateInput.datePicker();
}
/* 权限配置 */
$(function () {
    //动态选择框，上下级选中状态变化
    $('input.checkbox-parent').on('change', function () {
        var dataid = $(this).attr("dataid");
        $('input[dataid^=' + dataid + '-]').prop('checked', $(this).is(':checked'));
    });
    $('input.checkbox-child').on('change', function () {
        var dataid = $(this).attr("dataid");
        dataid = dataid.substring(0, dataid.lastIndexOf("-"));
        var parent = $('input[dataid=' + dataid + ']');
        if ($(this).is(':checked')) {
            parent.prop('checked', true);
            //循环到顶级
            while (dataid.lastIndexOf("-") != 2) {
                dataid = dataid.substring(0, dataid.lastIndexOf("-"));
                parent = $('input[dataid=' + dataid + ']');
                parent.prop('checked', true);
            }
        } else {
            //父级
            if ($('input[dataid^=' + dataid + '-]:checked').length == 0) {
                parent.prop('checked', false);
                //循环到顶级
                while (dataid.lastIndexOf("-") != 2) {
                    dataid = dataid.substring(0, dataid.lastIndexOf("-"));
                    parent = $('input[dataid=' + dataid + ']');
                    if ($('input[dataid^=' + dataid + '-]:checked').length == 0) {
                        parent.prop('checked', false);
                    }
                }
            }
        }
    });
});
//模态框状态
$(document).ready(function () {
    $("#myModaledit").hide();
    $("#gb").click(function () {
        $("#myModaledit").hide(200);
    });
    $("#gbb").click(function () {
        $("#myModaledit").hide(200);
    });
    $("#gbbb").click(function () {
        $("#myModaledit").hide(200);
    });
});
$(document).ready(function () {
    $("#myModal").hide();
    $("#gb").click(function () {
        $("#myModal").hide(200);
    });
    $("#gbb").click(function () {
        $("#myModal").hide(200);
    });
    $("#gbbb").click(function () {
        $("#myModal").hide(200);
    });
});
/*************************************************************************** 所有ajax获取编辑数据 ********************************************************/
/* 会员组修改操作 */
$(function () {
	$('body').on('click','.memberedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {member_group_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#editmember_group_id").val(data.member_group_id);
                $("#editmember_group_name").val(data.member_group_name);
                $("#editmember_group_open").val(data.member_group_open);
                $("#editmember_group_toplimit").val(data.member_group_toplimit);
                $("#editmember_group_bomlimit").val(data.member_group_bomlimit);
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 友链类型 */
function openWindow(a, b, c) {
    $("#myModal").show(300);
    $("#plug_linktype_id").val(a);
    $("#newplug_linktype_name").val(b);
    $("#newplug_linktype_order").val(c);
}
/* 模型添加到menu */
function addmenu(a) {
    $("#myModal").show(300);
    $("#model_id").val(a);
}
/* we菜单添加 */
function add_we_menu(a) {
    $('#myModal').modal('show');
    $("#we_menu_leftid").val(a);
}
/* 路由规则编辑 */
$(function () {
    $('body').on('click','.routeedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#editroute_id").val(data.id);
                $("#editroute_full_url").val(data.full_url);
                $("#editroute_url").val(data.url);
                if (data.status == 1) {
                    $("#editroute_status").prop("checked",true);
                } else {
                    $("#editroute_status").prop("checked", false);
                }
                $("#editroute_listorder").val(data.listorder);
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 友链编辑 */
$(function () {
	$('body').on('click','.linkedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {plug_link_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#editplug_link_id").val(data.plug_link_id);
				$("#editplug_link_l").val(data.plug_link_l);
                $("#editplug_link_name").val(data.plug_link_name);
                $("#editplug_link_url").val(data.plug_link_url);
                $("#editplug_link_target").val(data.plug_link_target);
                $("#editplug_link_qq").val(data.plug_link_qq);
                $("#editplug_link_order").val(data.plug_link_order);
                $("#editplug_link_typeid").val(data.plug_link_typeid);
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 广告位编辑 */
$(function () {
	$('body').on('click','.adtypeedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {plug_adtype_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#adtype_id").val(data.plug_adtype_id);
                $("#adtype_name").val(data.plug_adtype_name);
                $("#adtype_order").val(data.plug_adtype_order);
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 回复留言 */
$(function () {
	$('body').on('click','.sugreply-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {plug_sug_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModal").show(300);
                $("#plug_sug_toemail").val(data.plug_sug_email);
                $("#plug_sug_toname").val(data.plug_sug_name);
                $("#plug_sug_id").val(data.plug_sug_id);
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 来源编辑 */
$(function () {
	$('body').on('click','.sourceedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {source_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#editsource_id").val(data.source_id);
                $("#editsource_name").val(data.source_name);
                $("#editsource_order").val(data.source_order);
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
//来源
function souadd(val) {
    $('#news_source').val(val);
}
/* 微信菜单编辑 */
$(function () {
	$('body').on('click','.menuedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {we_menu_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#editwe_menu_id").val(data.we_menu_id);
                $("#editwe_menu_name").val(data.we_menu_name);
                $("#editwe_menu_leftid").val(data.we_menu_leftid);
                $("#editwe_menu_type").val(data.we_menu_type);
                $("#editwe_menu_typeval").val(data.we_menu_typeval);
                $("#editwe_menu_order").val(data.we_menu_order);
                if(data.we_menu_open){
                    $("#editwe_menu_open").prop("checked",true);
                }else{
                    $("#editwe_menu_open").prop("checked",false);
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/* 微信关键词回复编辑 */
$(function () {
	$('body').on('click','.replyedit-btn',function () {
        var $url = this.href,
            val = $(this).data('id');
        $.post($url, {we_reply_id: val}, function (data) {
            if (data.code == 1) {
                $("#myModaledit").show(300);
                $("#editwe_reply_id").val(data.we_reply_id);
                $("#editwe_reply_key").val(data.we_reply_key);
                $("#editwe_reply_type").val(data.we_reply_type);
				var Modal=$("#editwe_reply_type").parents('.modal');
				if(data.we_reply_type=='news'){
					Modal.find("#input-text").hide();
					Modal.find("#input-news").show();
					$("#editnews_title").val(data.we_reply_content.title);
					$("#editnews_description").val(data.we_reply_content.description);
					$("#editnews_url").val(data.we_reply_content.url);
					$("#editnews_image").val(data.we_reply_content.image);
				}else{
					Modal.find("#input-news").hide();
					Modal.find("#input-text").show();
					$("#editwe_reply_content").val(data.we_reply_content);
				}
                if(data.we_reply_open){
                    $("#editwe_reply_open").prop("checked",true);
                }else{
                    $("#editwe_reply_open").prop("checked",false);
                }
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        }, "json");
        return false;
    });
});
/*************************************************************************** 单图/多图操作********************************************************/
/* 单图上传 */
$("#file0").change(function () {
    var objUrl = getObjectURL(this.files[0]);
    console.log("objUrl = " + objUrl);
    if (objUrl) {
        $("#img0").attr("src", objUrl);
    }
});
//
$("input[id^=file_]").change(function () {
    var field=$(this).data('field'),objUrl = getObjectURL2(this.files[0],field);
    console.log("objUrl = " + objUrl);
    if (objUrl) {
        $("#img_"+field).attr("src", objUrl);
    }
});
function getObjectURL(file) {
    var url = null;
    if (window.createObjectURL != undefined) { // basic
        $("#oldcheckpic").val("nopic");
        url = window.createObjectURL(file);
    } else if (window.URL != undefined) { // mozilla(firefox)
        $("#oldcheckpic").val("nopic");
        url = window.URL.createObjectURL(file);
    } else if (window.webkitURL != undefined) { // webkit or chrome
        $("#oldcheckpic").val("nopic");
        url = window.webkitURL.createObjectURL(file);
    }
    return url;
}
function getObjectURL2(file,field) {
    var url = null;
    if (window.createObjectURL != undefined) { // basic
        $("#oldcheckpic_"+field).val("nopic");
        url = window.createObjectURL(file);
    } else if (window.URL != undefined) { // mozilla(firefox)
        $("#oldcheckpic_"+field).val("nopic");
        url = window.URL.createObjectURL(file);
    } else if (window.webkitURL != undefined) { // webkit or chrome
        $("#oldcheckpic_"+field).val("nopic");
        url = window.webkitURL.createObjectURL(file);
    }
    return url;
}
function backpic2(picurl,field) {
    $("#img_"+field).attr("src", picurl);//还原修改前的图片
    $("#file_"+field).val("");//清空文本框的值
    $("#oldcheckpic_"+field).val(picurl);//清空文本框的值
}
function backpic(picurl) {
    $("#img0").attr("src", picurl);//还原修改前的图片
    $("input[name='file0']").val("");//清空文本框的值
    $("input[name='oldcheckpic']").val(picurl);//清空文本框的值
}
/* 新闻多图删除 */
function delall(id, url) {
    $('#id' + id).hide();
    var str = $('#pic_oldlist').val();//最原始的完整路径
    var surl = url + ',';
    var pic_newold = str.replace(surl, "");
    $('#pic_oldlist').val(pic_newold);
}
/*************************************************************************** 数据备份还原********************************************************/
/* 数据库备份、优化、修复 */
(function ($) {
    $("a[id^=optimize_]").click(function () {
        $.get(this.href, function (data) {
            if (data.code==1) {
                layer.alert(data.msg, {icon: 6});
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        });
        return false;
    });
    $("a[id^=repair_]").click(function () {
        $.get(this.href, function (data) {
            if (data.code==1) {
                layer.alert(data.msg, {icon: 6});
            } else {
                layer.alert(data.msg, {icon: 5});
            }
        });
        return false;
    });

    var $form = $("#export-form"), $export = $("#export"), tables
    $optimize = $("#optimize"), $repair = $("#repair");

    $optimize.add($repair).click(function () {
		var that=this;
        $.post(this.href, $form.serialize(), function (data) {
            if (data.code==1) {
                layer.alert(data.msg, {icon: 6}, function (index) {
                    layer.close(index);
                });
            } else {
                layer.alert(data.msg, {icon: 5}, function (index) {
                    layer.close(index);
                });
            }
            setTimeout(function () {
                $('#top-alert').find('button').click();
                $(that).removeClass('disabled').prop('disabled', false);
            }, 1500);
        }, "json");
        return false;
    });

    $export.click(function () {
        $export.children().addClass("disabled");
        $export.children().text("正在发送备份请求...");
		var that=this;
        $.post(
            $form.attr("action"),
            $form.serialize(),
            function (data) {
                if (data.code==1) {
                    tables = data.tables;
                    $export.children().text(data.msg + "开始备份，请不要关闭本页面！");
                    backup(data.tab);
                    window.onbeforeunload = function () {
                        return "正在备份数据库，请不要关闭！"
                    }
                } else {
                    layer.alert(data.msg, {icon: 5});
                    $export.children().removeClass("disabled");
                    $export.children().text("立即备份");
                    setTimeout(function () {
                        $('#top-alert').find('button').click();
                        $(that).removeClass('disabled').prop('disabled', false);
                    }, 1500);
                }
            },
            "json"
        );
        return false;
    });

    function backup(tab, status) {
        status && showmsg(tab.id, "开始备份...(0%)");
		var that=this;
        $.get($form.attr("action"), tab, function (data) {
            if (data.code==1) {
                showmsg(tab.id, data.msg);
                if (!$.isPlainObject(data.tab)) {
                    $export.children().removeClass("disabled");
                    $export.children().text("备份完成，点击重新备份");
                    window.onbeforeunload = null;
                }
				if(data.tab !=undefined){
					backup(data.tab, tab.id != data.tab.id);					
				}
            } else {
                updateAlert(data.msg, 'alert-error');
                $export.children().removeClass("disabled");
                $export.children().text("立即备份");
                setTimeout(function () {
                    $('#top-alert').find('button').click();
                    $(that).removeClass('disabled').prop('disabled', false);
                }, 1500);
            }
        }, "json");
    }

    function showmsg(id, msg) {
        $tr=$form.find("input[value=" + tables[id] + "]").closest("tr");
        $tr.find(".green").html("");
        $tr.find(".info").html("");
        $tr.find(".backup").html(msg);
    }
})(jQuery);
/*************************************************************************** 其它********************************************************/
/* textarea字数提示 */
$(function () {
    $('textarea.limited').maxlength({
        'feedback': '.charsLeft',
    });
    $('textarea.limited1').maxlength({
        'feedback': '.charsLeft1',
    });
    $('textarea.limited2').maxlength({
        'feedback': '.charsLeft2',
    });
    $('textarea.limited3').maxlength({
        'feedback': '.charsLeft3',
    });
    $('textarea.limited4').maxlength({
        'feedback': '.charsLeft4',
    });
    $('textarea.limited5').maxlength({
        'feedback': '.charsLeft5',
    });
});
$(function () {
    $("[data-toggle='tooltip']").tooltip();
});
/*************************************************************************** 生成安全文件********************************************************/
(function ($) {
	$('body').on('click','#security_generate',function () {
        $(this).children().addClass("disabled");
        $(this).find("span").text("正在生成安全文件...");
        $.get(this.href, function (data) {
            if (data.code==1) {
                layer.alert(data.msg, {icon: 6}, function (index) {
                    layer.close(index);
                    window.location.href = data.url;
                });
            } else {
                layer.alert(data.msg, {icon: 5}, function (index) {
                    layer.close(index);
                });
            }
            $(this).children().removeClass("disabled");
            $(this).find("span").text("重新生成安全文件");
        });
        return false;
});
})(jQuery);
/*************************************************************************** 选择列表框change事件********************************************************/
(function ($) {
	$('body').on('change','.ajax_change',function () {		
        var $form = $(this).parents("form");
		$.ajax({
		    url:$form.attr('action'),
			type:"POST",
			data:$form.serialize(),            
			success: function(data,status){
				$("#ajax-data").html(data);
			}
		});	
    });
    $('body').on('click','.range_inputs .applyBtn',function () {
        var reservation=$('#reservation');
        var $form = reservation.parents("form");
        reservation.val($('input[name="daterangepicker_start"]').val()+' - '+$('input[name="daterangepicker_end"]').val());
        $.ajax({
            url:$form.attr('action'),
            type:"POST",
            data:$form.serialize(),
            success: function(data,status){
                $("#ajax-data").html(data);
            }
        });
    });
    })(jQuery);
(function ($) {
	$('body').on('change','.submit_change',function () {		
        var $form = $(this).parents("form");	
        $form.submit();
    });
    })(jQuery);
function ajax_page(page) {
	$.ajax({
		type:"POST",
		data:$('#list-filter').serialize()+'&page='+page,            
		success: function(data,status){
			$("#ajax-data").html(data);
		}
	});
}
/*搜索form*/
$(function () {
	$('body').on('click','.ajax-search-form',function () {
		$.ajax({
			type:"POST",
			data:$(this).parents("form").serialize(),            
			success: function(data,status){
				$("#ajax-data").html(data);
			}
		});	
        return false;
    });
});
/*搜索type*/
$(function () {
	$('body').on('click','.ajax-search-type',function () {
		$(this).parents("form")[0].reset();
		alert($(this).data('type'));
		$.ajax({
			type:"POST",
			data:{type:$(this).data('type')},            
			success: function(data,status){
				$("#ajax-data").html(data);
			}
		});	
        return false;
    });
});
/*搜索form显示全部*/
$(function () {
	$('body').on('click','.ajax-display-all',function () {
		$(this).parents("form")[0].reset();
		$.ajax({
			type:"POST",
			data:{},            
			success: function(data,status){
				$("#ajax-data").html(data);
			}
		});	
        return false;
    });
});
/*清空*/
$(function () {
	$('body').on('click','.ajax-drop',function () {
		$(this).parents("form")[0].reset();
		var url=$(this).parent('a').attr('href');
		$.ajax({
			type:"POST",
			url:url,
			data:{},            
			success: function(data,status){
				layer.alert(data.msg, {icon: 6}, function (index) {
                    layer.close(index);
                    window.location.href = data.url;
                });
			}
		});	
        return false;
    });
});
/*详情*/
$(function () {
	$('body').on('click','.show-details-btn',function (e) {
		e.preventDefault();
		$(this).closest('tr').next().toggleClass('open');
		$(this).find(ace.vars['.icon']).toggleClass('fa-angle-double-down').toggleClass('fa-angle-double-up');
    });
});
$(function () {
    /*权限管理*/
	$('body').on('click','.rule-list',function () {
		var $a=$(this),$tr=$a.parents('tr');
		var $pid=$tr.attr('id');
		if($a.find('span').hasClass('fa-minus')){
			$("tr[id^='"+$pid+"-']").attr('style','display:none');
			$a.find('span').removeClass('fa-minus').addClass('fa-plus');
		}else{
			if($("tr[id^='"+$pid+"-']").length>0){
				$("tr[id^='"+$pid+"-']").attr('style','');
				$a.find('span').removeClass('fa-plus').addClass('fa-minus');
			}else{
				var $url = this.href,$id=$a.data('id'),$level=$a.data('level');
				$.post($url,{pid:$id,level:$level,id:$pid}, function (data) {
					if (data) {
						$a.find('span').removeClass('fa-plus').addClass('fa-minus');
						$tr.after(data);
					}else{
						$a.find('span').removeClass('fa-plus').addClass('fa-minus');
					}
				}, "json");
			}
		}
        return false;
    }).on('change','.ajax_change_news_columnid',function () {
        var obj=$(this).siblings('.action');
        var old_id=obj.find('.cancel-change-columnid').data('columnid'),new_id=$(this).val();
        if(old_id != new_id){
            obj.find('.change-columnid').data('columnid',new_id);
            obj.removeClass('none');
        }else{
            obj.addClass('none');
        }
    }).on('click','a.change-columnid',function () {
        var $url=this.href,$news_columnid=$(this).data('columnid'),$n_id=$(this).data('id');
        var obj=$(this);
        $.post($url,{news_columnid:$news_columnid,n_id:$n_id}, function (data) {
            if (data.code==1) {
                obj.parent().addClass('none');
                obj.siblings('.cancel-change-columnid').data('columnid',$news_columnid);
                layer.msg(data.msg,{icon: 6});
            }else{
                layer.msg(data.msg,{icon: 5});
            }
        }, "json");
        return false;
    }).on('click','a.cancel-change-columnid',function () {
        var old_id=$(this).data('columnid'),obj=$(this).parent();
        obj.addClass('none').siblings('.ajax_change_news_columnid').val(old_id);
        return false;
    });
	//极验验证
    $('#geetest_on').click(function(){
        $("#geetest").toggle(200);
    });
});