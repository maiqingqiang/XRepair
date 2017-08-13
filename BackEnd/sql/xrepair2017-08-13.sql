/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : xrepair

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-08-13 23:50:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for x_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `x_admin_menu`;
CREATE TABLE `x_admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float unsigned NOT NULL DEFAULT '10000' COMMENT '排序ID',
  `app` varchar(15) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parent_id`),
  KEY `model` (`controller`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';

-- ----------------------------
-- Records of x_admin_menu
-- ----------------------------
INSERT INTO `x_admin_menu` VALUES ('1', '0', '0', '1', '20', 'admin', 'Plugin', 'default', '', '插件管理', 'cloud', '插件管理');
INSERT INTO `x_admin_menu` VALUES ('2', '1', '1', '1', '10000', 'admin', 'Hook', 'index', '', '钩子管理', '', '钩子管理');
INSERT INTO `x_admin_menu` VALUES ('3', '2', '1', '0', '10000', 'admin', 'Hook', 'plugins', '', '钩子插件管理', '', '钩子插件管理');
INSERT INTO `x_admin_menu` VALUES ('4', '2', '2', '0', '10000', 'admin', 'Hook', 'pluginListOrder', '', '钩子插件排序', '', '钩子插件排序');
INSERT INTO `x_admin_menu` VALUES ('5', '0', '0', '1', '0', 'admin', 'Setting', 'default', '', '设置', 'cogs', '系统设置入口');
INSERT INTO `x_admin_menu` VALUES ('6', '5', '1', '1', '50', 'admin', 'Link', 'index', '', '友情链接', '', '友情链接管理');
INSERT INTO `x_admin_menu` VALUES ('7', '6', '1', '0', '10000', 'admin', 'Link', 'add', '', '添加友情链接', '', '添加友情链接');
INSERT INTO `x_admin_menu` VALUES ('8', '6', '2', '0', '10000', 'admin', 'Link', 'addPost', '', '添加友情链接提交保存', '', '添加友情链接提交保存');
INSERT INTO `x_admin_menu` VALUES ('9', '6', '1', '0', '10000', 'admin', 'Link', 'edit', '', '编辑友情链接', '', '编辑友情链接');
INSERT INTO `x_admin_menu` VALUES ('10', '6', '2', '0', '10000', 'admin', 'Link', 'editPost', '', '编辑友情链接提交保存', '', '编辑友情链接提交保存');
INSERT INTO `x_admin_menu` VALUES ('11', '6', '2', '0', '10000', 'admin', 'Link', 'delete', '', '删除友情链接', '', '删除友情链接');
INSERT INTO `x_admin_menu` VALUES ('12', '6', '2', '0', '10000', 'admin', 'Link', 'listOrder', '', '友情链接排序', '', '友情链接排序');
INSERT INTO `x_admin_menu` VALUES ('13', '6', '2', '0', '10000', 'admin', 'Link', 'toggle', '', '友情链接显示隐藏', '', '友情链接显示隐藏');
INSERT INTO `x_admin_menu` VALUES ('14', '5', '1', '1', '10', 'admin', 'Mailer', 'index', '', '邮箱配置', '', '邮箱配置');
INSERT INTO `x_admin_menu` VALUES ('15', '14', '2', '0', '10000', 'admin', 'Mailer', 'indexPost', '', '邮箱配置提交保存', '', '邮箱配置提交保存');
INSERT INTO `x_admin_menu` VALUES ('16', '14', '1', '0', '10000', 'admin', 'Mailer', 'template', '', '邮件模板', '', '邮件模板');
INSERT INTO `x_admin_menu` VALUES ('17', '14', '2', '0', '10000', 'admin', 'Mailer', 'templatePost', '', '邮件模板提交', '', '邮件模板提交');
INSERT INTO `x_admin_menu` VALUES ('18', '14', '1', '0', '10000', 'admin', 'Mailer', 'test', '', '邮件发送测试', '', '邮件发送测试');
INSERT INTO `x_admin_menu` VALUES ('19', '5', '1', '0', '10000', 'admin', 'Menu', 'index', '', '后台菜单', '', '后台菜单管理');
INSERT INTO `x_admin_menu` VALUES ('20', '19', '1', '0', '10000', 'admin', 'Menu', 'lists', '', '所有菜单', '', '后台所有菜单列表');
INSERT INTO `x_admin_menu` VALUES ('21', '19', '1', '0', '10000', 'admin', 'Menu', 'add', '', '后台菜单添加', '', '后台菜单添加');
INSERT INTO `x_admin_menu` VALUES ('22', '19', '2', '0', '10000', 'admin', 'Menu', 'addPost', '', '后台菜单添加提交保存', '', '后台菜单添加提交保存');
INSERT INTO `x_admin_menu` VALUES ('23', '19', '1', '0', '10000', 'admin', 'Menu', 'edit', '', '后台菜单编辑', '', '后台菜单编辑');
INSERT INTO `x_admin_menu` VALUES ('24', '19', '2', '0', '10000', 'admin', 'Menu', 'editPost', '', '后台菜单编辑提交保存', '', '后台菜单编辑提交保存');
INSERT INTO `x_admin_menu` VALUES ('25', '19', '2', '0', '10000', 'admin', 'Menu', 'delete', '', '后台菜单删除', '', '后台菜单删除');
INSERT INTO `x_admin_menu` VALUES ('26', '19', '2', '0', '10000', 'admin', 'Menu', 'listOrder', '', '后台菜单排序', '', '后台菜单排序');
INSERT INTO `x_admin_menu` VALUES ('27', '19', '1', '0', '10000', 'admin', 'Menu', 'getActions', '', '导入新后台菜单', '', '导入新后台菜单');
INSERT INTO `x_admin_menu` VALUES ('28', '5', '1', '1', '30', 'admin', 'Nav', 'index', '', '导航管理', '', '导航管理');
INSERT INTO `x_admin_menu` VALUES ('29', '28', '1', '0', '10000', 'admin', 'Nav', 'add', '', '添加导航', '', '添加导航');
INSERT INTO `x_admin_menu` VALUES ('30', '28', '2', '0', '10000', 'admin', 'Nav', 'addPost', '', '添加导航提交保存', '', '添加导航提交保存');
INSERT INTO `x_admin_menu` VALUES ('31', '28', '1', '0', '10000', 'admin', 'Nav', 'edit', '', '编辑导航', '', '编辑导航');
INSERT INTO `x_admin_menu` VALUES ('32', '28', '2', '0', '10000', 'admin', 'Nav', 'editPost', '', '编辑导航提交保存', '', '编辑导航提交保存');
INSERT INTO `x_admin_menu` VALUES ('33', '28', '2', '0', '10000', 'admin', 'Nav', 'delete', '', '删除导航', '', '删除导航');
INSERT INTO `x_admin_menu` VALUES ('34', '28', '1', '0', '10000', 'admin', 'NavMenu', 'index', '', '导航菜单', '', '导航菜单');
INSERT INTO `x_admin_menu` VALUES ('35', '34', '1', '0', '10000', 'admin', 'NavMenu', 'add', '', '添加导航菜单', '', '添加导航菜单');
INSERT INTO `x_admin_menu` VALUES ('36', '34', '2', '0', '10000', 'admin', 'NavMenu', 'addPost', '', '添加导航菜单提交保存', '', '添加导航菜单提交保存');
INSERT INTO `x_admin_menu` VALUES ('37', '34', '1', '0', '10000', 'admin', 'NavMenu', 'edit', '', '编辑导航菜单', '', '编辑导航菜单');
INSERT INTO `x_admin_menu` VALUES ('38', '34', '2', '0', '10000', 'admin', 'NavMenu', 'editPost', '', '编辑导航菜单提交保存', '', '编辑导航菜单提交保存');
INSERT INTO `x_admin_menu` VALUES ('39', '34', '2', '0', '10000', 'admin', 'NavMenu', 'delete', '', '删除导航菜单', '', '删除导航菜单');
INSERT INTO `x_admin_menu` VALUES ('40', '34', '2', '0', '10000', 'admin', 'NavMenu', 'listOrder', '', '导航菜单排序', '', '导航菜单排序');
INSERT INTO `x_admin_menu` VALUES ('41', '1', '1', '1', '10000', 'admin', 'Plugin', 'index', '', '插件列表', '', '插件列表');
INSERT INTO `x_admin_menu` VALUES ('42', '41', '2', '0', '10000', 'admin', 'Plugin', 'toggle', '', '插件启用禁用', '', '插件启用禁用');
INSERT INTO `x_admin_menu` VALUES ('43', '41', '1', '0', '10000', 'admin', 'Plugin', 'setting', '', '插件设置', '', '插件设置');
INSERT INTO `x_admin_menu` VALUES ('44', '41', '2', '0', '10000', 'admin', 'Plugin', 'settingPost', '', '插件设置提交', '', '插件设置提交');
INSERT INTO `x_admin_menu` VALUES ('45', '41', '2', '0', '10000', 'admin', 'Plugin', 'install', '', '插件安装', '', '插件安装');
INSERT INTO `x_admin_menu` VALUES ('46', '41', '2', '0', '10000', 'admin', 'Plugin', 'update', '', '插件更新', '', '插件更新');
INSERT INTO `x_admin_menu` VALUES ('47', '41', '2', '0', '10000', 'admin', 'Plugin', 'uninstall', '', '卸载插件', '', '卸载插件');
INSERT INTO `x_admin_menu` VALUES ('48', '108', '0', '1', '10000', 'admin', 'User', 'default', '', '管理组', '', '管理组');
INSERT INTO `x_admin_menu` VALUES ('49', '48', '1', '1', '10000', 'admin', 'Rbac', 'index', '', '角色管理', '', '角色管理');
INSERT INTO `x_admin_menu` VALUES ('50', '49', '1', '0', '10000', 'admin', 'Rbac', 'roleAdd', '', '添加角色', '', '添加角色');
INSERT INTO `x_admin_menu` VALUES ('51', '49', '2', '0', '10000', 'admin', 'Rbac', 'roleAddPost', '', '添加角色提交', '', '添加角色提交');
INSERT INTO `x_admin_menu` VALUES ('52', '49', '1', '0', '10000', 'admin', 'Rbac', 'roleEdit', '', '编辑角色', '', '编辑角色');
INSERT INTO `x_admin_menu` VALUES ('53', '49', '2', '0', '10000', 'admin', 'Rbac', 'roleEditPost', '', '编辑角色提交', '', '编辑角色提交');
INSERT INTO `x_admin_menu` VALUES ('54', '49', '2', '0', '10000', 'admin', 'Rbac', 'roleDelete', '', '删除角色', '', '删除角色');
INSERT INTO `x_admin_menu` VALUES ('55', '49', '1', '0', '10000', 'admin', 'Rbac', 'authorize', '', '设置角色权限', '', '设置角色权限');
INSERT INTO `x_admin_menu` VALUES ('56', '49', '2', '0', '10000', 'admin', 'Rbac', 'authorizePost', '', '角色授权提交', '', '角色授权提交');
INSERT INTO `x_admin_menu` VALUES ('57', '0', '1', '0', '10000', 'admin', 'RecycleBin', 'index', '', '回收站', '', '回收站');
INSERT INTO `x_admin_menu` VALUES ('58', '57', '2', '0', '10000', 'admin', 'RecycleBin', 'restore', '', '回收站还原', '', '回收站还原');
INSERT INTO `x_admin_menu` VALUES ('59', '57', '2', '0', '10000', 'admin', 'RecycleBin', 'delete', '', '回收站彻底删除', '', '回收站彻底删除');
INSERT INTO `x_admin_menu` VALUES ('60', '5', '1', '1', '10000', 'admin', 'Route', 'index', '', 'URL美化', '', 'URL规则管理');
INSERT INTO `x_admin_menu` VALUES ('61', '60', '1', '0', '10000', 'admin', 'Route', 'add', '', '添加路由规则', '', '添加路由规则');
INSERT INTO `x_admin_menu` VALUES ('62', '60', '2', '0', '10000', 'admin', 'Route', 'addPost', '', '添加路由规则提交', '', '添加路由规则提交');
INSERT INTO `x_admin_menu` VALUES ('63', '60', '1', '0', '10000', 'admin', 'Route', 'edit', '', '路由规则编辑', '', '路由规则编辑');
INSERT INTO `x_admin_menu` VALUES ('64', '60', '2', '0', '10000', 'admin', 'Route', 'editPost', '', '路由规则编辑提交', '', '路由规则编辑提交');
INSERT INTO `x_admin_menu` VALUES ('65', '60', '2', '0', '10000', 'admin', 'Route', 'delete', '', '路由规则删除', '', '路由规则删除');
INSERT INTO `x_admin_menu` VALUES ('66', '60', '2', '0', '10000', 'admin', 'Route', 'ban', '', '路由规则禁用', '', '路由规则禁用');
INSERT INTO `x_admin_menu` VALUES ('67', '60', '2', '0', '10000', 'admin', 'Route', 'open', '', '路由规则启用', '', '路由规则启用');
INSERT INTO `x_admin_menu` VALUES ('68', '60', '2', '0', '10000', 'admin', 'Route', 'listOrder', '', '路由规则排序', '', '路由规则排序');
INSERT INTO `x_admin_menu` VALUES ('69', '60', '1', '0', '10000', 'admin', 'Route', 'select', '', '选择URL', '', '选择URL');
INSERT INTO `x_admin_menu` VALUES ('70', '5', '1', '1', '0', 'admin', 'Setting', 'site', '', '网站信息', '', '网站信息');
INSERT INTO `x_admin_menu` VALUES ('71', '70', '2', '0', '10000', 'admin', 'Setting', 'sitePost', '', '网站信息设置提交', '', '网站信息设置提交');
INSERT INTO `x_admin_menu` VALUES ('72', '5', '1', '0', '10000', 'admin', 'Setting', 'password', '', '密码修改', '', '密码修改');
INSERT INTO `x_admin_menu` VALUES ('73', '72', '2', '0', '10000', 'admin', 'Setting', 'passwordPost', '', '密码修改提交', '', '密码修改提交');
INSERT INTO `x_admin_menu` VALUES ('74', '5', '1', '1', '10000', 'admin', 'Setting', 'upload', '', '上传设置', '', '上传设置');
INSERT INTO `x_admin_menu` VALUES ('75', '74', '2', '0', '10000', 'admin', 'Setting', 'uploadPost', '', '上传设置提交', '', '上传设置提交');
INSERT INTO `x_admin_menu` VALUES ('76', '5', '1', '0', '10000', 'admin', 'Setting', 'clearCache', '', '清除缓存', '', '清除缓存');
INSERT INTO `x_admin_menu` VALUES ('77', '5', '1', '1', '40', 'admin', 'Slide', 'index', '', '幻灯片管理', '', '幻灯片管理');
INSERT INTO `x_admin_menu` VALUES ('78', '77', '1', '0', '10000', 'admin', 'Slide', 'add', '', '添加幻灯片', '', '添加幻灯片');
INSERT INTO `x_admin_menu` VALUES ('79', '77', '2', '0', '10000', 'admin', 'Slide', 'addPost', '', '添加幻灯片提交', '', '添加幻灯片提交');
INSERT INTO `x_admin_menu` VALUES ('80', '77', '1', '0', '10000', 'admin', 'Slide', 'edit', '', '编辑幻灯片', '', '编辑幻灯片');
INSERT INTO `x_admin_menu` VALUES ('81', '77', '2', '0', '10000', 'admin', 'Slide', 'editPost', '', '编辑幻灯片提交', '', '编辑幻灯片提交');
INSERT INTO `x_admin_menu` VALUES ('82', '77', '2', '0', '10000', 'admin', 'Slide', 'delete', '', '删除幻灯片', '', '删除幻灯片');
INSERT INTO `x_admin_menu` VALUES ('83', '77', '1', '0', '10000', 'admin', 'SlideItem', 'index', '', '幻灯片页面列表', '', '幻灯片页面列表');
INSERT INTO `x_admin_menu` VALUES ('84', '83', '1', '0', '10000', 'admin', 'SlideItem', 'add', '', '幻灯片页面添加', '', '幻灯片页面添加');
INSERT INTO `x_admin_menu` VALUES ('85', '83', '2', '0', '10000', 'admin', 'SlideItem', 'addPost', '', '幻灯片页面添加提交', '', '幻灯片页面添加提交');
INSERT INTO `x_admin_menu` VALUES ('86', '83', '1', '0', '10000', 'admin', 'SlideItem', 'edit', '', '幻灯片页面编辑', '', '幻灯片页面编辑');
INSERT INTO `x_admin_menu` VALUES ('87', '83', '2', '0', '10000', 'admin', 'SlideItem', 'editPost', '', '幻灯片页面编辑提交', '', '幻灯片页面编辑提交');
INSERT INTO `x_admin_menu` VALUES ('88', '83', '2', '0', '10000', 'admin', 'SlideItem', 'delete', '', '幻灯片页面删除', '', '幻灯片页面删除');
INSERT INTO `x_admin_menu` VALUES ('89', '83', '2', '0', '10000', 'admin', 'SlideItem', 'ban', '', '幻灯片页面隐藏', '', '幻灯片页面隐藏');
INSERT INTO `x_admin_menu` VALUES ('90', '83', '2', '0', '10000', 'admin', 'SlideItem', 'cancelBan', '', '幻灯片页面显示', '', '幻灯片页面显示');
INSERT INTO `x_admin_menu` VALUES ('91', '83', '2', '0', '10000', 'admin', 'SlideItem', 'listOrder', '', '幻灯片页面排序', '', '幻灯片页面排序');
INSERT INTO `x_admin_menu` VALUES ('92', '5', '1', '1', '10000', 'admin', 'Storage', 'index', '', '文件存储', '', '文件存储');
INSERT INTO `x_admin_menu` VALUES ('93', '92', '2', '0', '10000', 'admin', 'Storage', 'settingPost', '', '文件存储设置提交', '', '文件存储设置提交');
INSERT INTO `x_admin_menu` VALUES ('94', '5', '1', '1', '20', 'admin', 'Theme', 'index', '', '模板管理', '', '模板管理');
INSERT INTO `x_admin_menu` VALUES ('95', '94', '1', '0', '10000', 'admin', 'Theme', 'install', '', '安装模板', '', '安装模板');
INSERT INTO `x_admin_menu` VALUES ('96', '94', '2', '0', '10000', 'admin', 'Theme', 'uninstall', '', '卸载模板', '', '卸载模板');
INSERT INTO `x_admin_menu` VALUES ('97', '94', '2', '0', '10000', 'admin', 'Theme', 'installTheme', '', '模板安装', '', '模板安装');
INSERT INTO `x_admin_menu` VALUES ('98', '94', '2', '0', '10000', 'admin', 'Theme', 'update', '', '模板更新', '', '模板更新');
INSERT INTO `x_admin_menu` VALUES ('99', '94', '2', '0', '10000', 'admin', 'Theme', 'active', '', '启用模板', '', '启用模板');
INSERT INTO `x_admin_menu` VALUES ('100', '94', '1', '0', '10000', 'admin', 'Theme', 'files', '', '模板文件列表', '', '启用模板');
INSERT INTO `x_admin_menu` VALUES ('101', '94', '1', '0', '10000', 'admin', 'Theme', 'fileSetting', '', '模板文件设置', '', '模板文件设置');
INSERT INTO `x_admin_menu` VALUES ('102', '94', '1', '0', '10000', 'admin', 'Theme', 'fileArrayData', '', '模板文件数组数据列表', '', '模板文件数组数据列表');
INSERT INTO `x_admin_menu` VALUES ('103', '94', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataEdit', '', '模板文件数组数据添加编辑', '', '模板文件数组数据添加编辑');
INSERT INTO `x_admin_menu` VALUES ('104', '94', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '', '模板文件数组数据添加编辑提交保存');
INSERT INTO `x_admin_menu` VALUES ('105', '94', '2', '0', '10000', 'admin', 'Theme', 'fileArrayDataDelete', '', '模板文件数组数据删除', '', '模板文件数组数据删除');
INSERT INTO `x_admin_menu` VALUES ('106', '94', '2', '0', '10000', 'admin', 'Theme', 'settingPost', '', '模板文件编辑提交保存', '', '模板文件编辑提交保存');
INSERT INTO `x_admin_menu` VALUES ('107', '94', '1', '0', '10000', 'admin', 'Theme', 'dataSource', '', '模板文件设置数据源', '', '模板文件设置数据源');
INSERT INTO `x_admin_menu` VALUES ('108', '0', '0', '1', '10', 'user', 'AdminIndex', 'default', '', '用户管理', 'group', '用户管理');
INSERT INTO `x_admin_menu` VALUES ('109', '48', '1', '1', '10000', 'admin', 'User', 'index', '', '管理员', '', '管理员管理');
INSERT INTO `x_admin_menu` VALUES ('110', '109', '1', '0', '10000', 'admin', 'User', 'add', '', '管理员添加', '', '管理员添加');
INSERT INTO `x_admin_menu` VALUES ('111', '109', '2', '0', '10000', 'admin', 'User', 'addPost', '', '管理员添加提交', '', '管理员添加提交');
INSERT INTO `x_admin_menu` VALUES ('112', '109', '1', '0', '10000', 'admin', 'User', 'edit', '', '管理员编辑', '', '管理员编辑');
INSERT INTO `x_admin_menu` VALUES ('113', '109', '2', '0', '10000', 'admin', 'User', 'editPost', '', '管理员编辑提交', '', '管理员编辑提交');
INSERT INTO `x_admin_menu` VALUES ('114', '109', '1', '0', '10000', 'admin', 'User', 'userInfo', '', '个人信息', '', '管理员个人信息修改');
INSERT INTO `x_admin_menu` VALUES ('115', '109', '2', '0', '10000', 'admin', 'User', 'userInfoPost', '', '管理员个人信息修改提交', '', '管理员个人信息修改提交');
INSERT INTO `x_admin_menu` VALUES ('116', '109', '2', '0', '10000', 'admin', 'User', 'delete', '', '管理员删除', '', '管理员删除');
INSERT INTO `x_admin_menu` VALUES ('117', '109', '2', '0', '10000', 'admin', 'User', 'ban', '', '停用管理员', '', '停用管理员');
INSERT INTO `x_admin_menu` VALUES ('118', '109', '2', '0', '10000', 'admin', 'User', 'cancelBan', '', '启用管理员', '', '启用管理员');
INSERT INTO `x_admin_menu` VALUES ('119', '0', '0', '1', '30', 'portal', 'AdminIndex', 'default', '', '门户管理', 'th', '门户管理');
INSERT INTO `x_admin_menu` VALUES ('120', '119', '1', '1', '10000', 'portal', 'AdminArticle', 'index', '', '文章管理', '', '文章列表');
INSERT INTO `x_admin_menu` VALUES ('121', '120', '1', '0', '10000', 'portal', 'AdminArticle', 'add', '', '添加文章', '', '添加文章');
INSERT INTO `x_admin_menu` VALUES ('122', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'addPost', '', '添加文章提交', '', '添加文章提交');
INSERT INTO `x_admin_menu` VALUES ('123', '120', '1', '0', '10000', 'portal', 'AdminArticle', 'edit', '', '编辑文章', '', '编辑文章');
INSERT INTO `x_admin_menu` VALUES ('124', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'editPost', '', '编辑文章提交', '', '编辑文章提交');
INSERT INTO `x_admin_menu` VALUES ('125', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'delete', '', '文章删除', '', '文章删除');
INSERT INTO `x_admin_menu` VALUES ('126', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'publish', '', '文章发布', '', '文章发布');
INSERT INTO `x_admin_menu` VALUES ('127', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'top', '', '文章置顶', '', '文章置顶');
INSERT INTO `x_admin_menu` VALUES ('128', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'recommend', '', '文章推荐', '', '文章推荐');
INSERT INTO `x_admin_menu` VALUES ('129', '120', '2', '0', '10000', 'portal', 'AdminArticle', 'listOrder', '', '文章排序', '', '文章排序');
INSERT INTO `x_admin_menu` VALUES ('130', '119', '1', '1', '10000', 'portal', 'AdminCategory', 'index', '', '分类管理', '', '文章分类列表');
INSERT INTO `x_admin_menu` VALUES ('131', '130', '1', '0', '10000', 'portal', 'AdminCategory', 'add', '', '添加文章分类', '', '添加文章分类');
INSERT INTO `x_admin_menu` VALUES ('132', '130', '2', '0', '10000', 'portal', 'AdminCategory', 'addPost', '', '添加文章分类提交', '', '添加文章分类提交');
INSERT INTO `x_admin_menu` VALUES ('133', '130', '1', '0', '10000', 'portal', 'AdminCategory', 'edit', '', '编辑文章分类', '', '编辑文章分类');
INSERT INTO `x_admin_menu` VALUES ('134', '130', '2', '0', '10000', 'portal', 'AdminCategory', 'editPost', '', '编辑文章分类提交', '', '编辑文章分类提交');
INSERT INTO `x_admin_menu` VALUES ('135', '130', '1', '0', '10000', 'portal', 'AdminCategory', 'select', '', '文章分类选择对话框', '', '文章分类选择对话框');
INSERT INTO `x_admin_menu` VALUES ('136', '130', '2', '0', '10000', 'portal', 'AdminCategory', 'listOrder', '', '文章分类排序', '', '文章分类排序');
INSERT INTO `x_admin_menu` VALUES ('137', '130', '2', '0', '10000', 'portal', 'AdminCategory', 'delete', '', '删除文章分类', '', '删除文章分类');
INSERT INTO `x_admin_menu` VALUES ('138', '119', '1', '1', '10000', 'portal', 'AdminPage', 'index', '', '页面管理', '', '页面管理');
INSERT INTO `x_admin_menu` VALUES ('139', '138', '1', '0', '10000', 'portal', 'AdminPage', 'add', '', '添加页面', '', '添加页面');
INSERT INTO `x_admin_menu` VALUES ('140', '138', '2', '0', '10000', 'portal', 'AdminPage', 'addPost', '', '添加页面提交', '', '添加页面提交');
INSERT INTO `x_admin_menu` VALUES ('141', '138', '1', '0', '10000', 'portal', 'AdminPage', 'edit', '', '编辑页面', '', '编辑页面');
INSERT INTO `x_admin_menu` VALUES ('142', '138', '2', '0', '10000', 'portal', 'AdminPage', 'editPost', '', '编辑页面提交', '', '编辑页面提交');
INSERT INTO `x_admin_menu` VALUES ('143', '138', '2', '0', '10000', 'portal', 'AdminPage', 'delete', '', '删除页面', '', '删除页面');
INSERT INTO `x_admin_menu` VALUES ('144', '119', '1', '1', '10000', 'portal', 'AdminTag', 'index', '', '文章标签', '', '文章标签');
INSERT INTO `x_admin_menu` VALUES ('145', '144', '1', '0', '10000', 'portal', 'AdminTag', 'add', '', '添加文章标签', '', '添加文章标签');
INSERT INTO `x_admin_menu` VALUES ('146', '144', '2', '0', '10000', 'portal', 'AdminTag', 'addPost', '', '添加文章标签提交', '', '添加文章标签提交');
INSERT INTO `x_admin_menu` VALUES ('147', '144', '2', '0', '10000', 'portal', 'AdminTag', 'upStatus', '', '更新标签状态', '', '更新标签状态');
INSERT INTO `x_admin_menu` VALUES ('148', '144', '2', '0', '10000', 'portal', 'AdminTag', 'delete', '', '删除文章标签', '', '删除文章标签');
INSERT INTO `x_admin_menu` VALUES ('149', '0', '1', '0', '10000', 'user', 'AdminAsset', 'index', '', '资源管理', 'file', '资源管理列表');
INSERT INTO `x_admin_menu` VALUES ('150', '149', '2', '0', '10000', 'user', 'AdminAsset', 'delete', '', '删除文件', '', '删除文件');
INSERT INTO `x_admin_menu` VALUES ('151', '108', '0', '1', '10000', 'user', 'AdminIndex', 'default1', '', '用户组', '', '用户组');
INSERT INTO `x_admin_menu` VALUES ('152', '151', '1', '1', '10000', 'user', 'AdminIndex', 'index', '', '本站用户', '', '本站用户');
INSERT INTO `x_admin_menu` VALUES ('153', '152', '2', '0', '10000', 'user', 'AdminIndex', 'ban', '', '本站用户拉黑', '', '本站用户拉黑');
INSERT INTO `x_admin_menu` VALUES ('154', '152', '2', '0', '10000', 'user', 'AdminIndex', 'cancelBan', '', '本站用户启用', '', '本站用户启用');
INSERT INTO `x_admin_menu` VALUES ('155', '151', '1', '1', '10000', 'user', 'AdminOauth', 'index', '', '第三方用户', '', '第三方用户');
INSERT INTO `x_admin_menu` VALUES ('156', '155', '2', '0', '10000', 'user', 'AdminOauth', 'delete', '', '删除第三方用户绑定', '', '删除第三方用户绑定');
INSERT INTO `x_admin_menu` VALUES ('157', '5', '1', '1', '10000', 'user', 'AdminUserAction', 'index', '', '用户操作管理', '', '用户操作管理');
INSERT INTO `x_admin_menu` VALUES ('158', '0', '0', '1', '40', 'general', 'AdminIndex', 'default', '', '通用报修', '', '');
INSERT INTO `x_admin_menu` VALUES ('159', '158', '1', '1', '10000', 'general', 'GeneralCategory', 'index', '', '报修分类管理', '', '');
INSERT INTO `x_admin_menu` VALUES ('160', '0', '0', '1', '10000', 'xrepair', 'AdminIndex', 'default', '', 'X报修系统管理', '', '');
INSERT INTO `x_admin_menu` VALUES ('161', '160', '1', '1', '10000', 'xrepair', 'Region', 'index', '', '区域管理', '', '');

-- ----------------------------
-- Table structure for x_asset
-- ----------------------------
DROP TABLE IF EXISTS `x_asset`;
CREATE TABLE `x_asset` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `file_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件路径,相对于upload目录,可以为url',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `more` text COMMENT '其它详细信息,JSON格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

-- ----------------------------
-- Records of x_asset
-- ----------------------------

-- ----------------------------
-- Table structure for x_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_access`;
CREATE TABLE `x_auth_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of x_auth_access
-- ----------------------------
INSERT INTO `x_auth_access` VALUES ('1', '3', 'xrepair/adminindex/default', 'admin_url');
INSERT INTO `x_auth_access` VALUES ('2', '3', 'xrepair/region/index', 'admin_url');

-- ----------------------------
-- Table structure for x_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_rule`;
CREATE TABLE `x_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(15) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `module` (`app`,`status`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb4 COMMENT='权限规则表';

-- ----------------------------
-- Records of x_auth_rule
-- ----------------------------
INSERT INTO `x_auth_rule` VALUES ('1', '1', 'admin', 'admin_url', 'admin/Hook/index', '', '钩子管理', '');
INSERT INTO `x_auth_rule` VALUES ('2', '1', 'admin', 'admin_url', 'admin/Hook/plugins', '', '钩子插件管理', '');
INSERT INTO `x_auth_rule` VALUES ('3', '1', 'admin', 'admin_url', 'admin/Hook/pluginListOrder', '', '钩子插件排序', '');
INSERT INTO `x_auth_rule` VALUES ('4', '1', 'admin', 'admin_url', 'admin/Link/index', '', '友情链接', '');
INSERT INTO `x_auth_rule` VALUES ('5', '1', 'admin', 'admin_url', 'admin/Link/add', '', '添加友情链接', '');
INSERT INTO `x_auth_rule` VALUES ('6', '1', 'admin', 'admin_url', 'admin/Link/addPost', '', '添加友情链接提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('7', '1', 'admin', 'admin_url', 'admin/Link/edit', '', '编辑友情链接', '');
INSERT INTO `x_auth_rule` VALUES ('8', '1', 'admin', 'admin_url', 'admin/Link/editPost', '', '编辑友情链接提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('9', '1', 'admin', 'admin_url', 'admin/Link/delete', '', '删除友情链接', '');
INSERT INTO `x_auth_rule` VALUES ('10', '1', 'admin', 'admin_url', 'admin/Link/listOrder', '', '友情链接排序', '');
INSERT INTO `x_auth_rule` VALUES ('11', '1', 'admin', 'admin_url', 'admin/Link/toggle', '', '友情链接显示隐藏', '');
INSERT INTO `x_auth_rule` VALUES ('12', '1', 'admin', 'admin_url', 'admin/Mailer/index', '', '邮箱配置', '');
INSERT INTO `x_auth_rule` VALUES ('13', '1', 'admin', 'admin_url', 'admin/Mailer/indexPost', '', '邮箱配置提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('14', '1', 'admin', 'admin_url', 'admin/Mailer/template', '', '邮件模板', '');
INSERT INTO `x_auth_rule` VALUES ('15', '1', 'admin', 'admin_url', 'admin/Mailer/templatePost', '', '邮件模板提交', '');
INSERT INTO `x_auth_rule` VALUES ('16', '1', 'admin', 'admin_url', 'admin/Mailer/test', '', '邮件发送测试', '');
INSERT INTO `x_auth_rule` VALUES ('17', '1', 'admin', 'admin_url', 'admin/Menu/index', '', '后台菜单', '');
INSERT INTO `x_auth_rule` VALUES ('18', '1', 'admin', 'admin_url', 'admin/Menu/lists', '', '所有菜单', '');
INSERT INTO `x_auth_rule` VALUES ('19', '1', 'admin', 'admin_url', 'admin/Menu/add', '', '后台菜单添加', '');
INSERT INTO `x_auth_rule` VALUES ('20', '1', 'admin', 'admin_url', 'admin/Menu/addPost', '', '后台菜单添加提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('21', '1', 'admin', 'admin_url', 'admin/Menu/edit', '', '后台菜单编辑', '');
INSERT INTO `x_auth_rule` VALUES ('22', '1', 'admin', 'admin_url', 'admin/Menu/editPost', '', '后台菜单编辑提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('23', '1', 'admin', 'admin_url', 'admin/Menu/delete', '', '后台菜单删除', '');
INSERT INTO `x_auth_rule` VALUES ('24', '1', 'admin', 'admin_url', 'admin/Menu/listOrder', '', '后台菜单排序', '');
INSERT INTO `x_auth_rule` VALUES ('25', '1', 'admin', 'admin_url', 'admin/Menu/getActions', '', '导入新后台菜单', '');
INSERT INTO `x_auth_rule` VALUES ('26', '1', 'admin', 'admin_url', 'admin/Nav/index', '', '导航管理', '');
INSERT INTO `x_auth_rule` VALUES ('27', '1', 'admin', 'admin_url', 'admin/Nav/add', '', '添加导航', '');
INSERT INTO `x_auth_rule` VALUES ('28', '1', 'admin', 'admin_url', 'admin/Nav/addPost', '', '添加导航提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('29', '1', 'admin', 'admin_url', 'admin/Nav/edit', '', '编辑导航', '');
INSERT INTO `x_auth_rule` VALUES ('30', '1', 'admin', 'admin_url', 'admin/Nav/editPost', '', '编辑导航提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('31', '1', 'admin', 'admin_url', 'admin/Nav/delete', '', '删除导航', '');
INSERT INTO `x_auth_rule` VALUES ('32', '1', 'admin', 'admin_url', 'admin/NavMenu/index', '', '导航菜单', '');
INSERT INTO `x_auth_rule` VALUES ('33', '1', 'admin', 'admin_url', 'admin/NavMenu/add', '', '添加导航菜单', '');
INSERT INTO `x_auth_rule` VALUES ('34', '1', 'admin', 'admin_url', 'admin/NavMenu/addPost', '', '添加导航菜单提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('35', '1', 'admin', 'admin_url', 'admin/NavMenu/edit', '', '编辑导航菜单', '');
INSERT INTO `x_auth_rule` VALUES ('36', '1', 'admin', 'admin_url', 'admin/NavMenu/editPost', '', '编辑导航菜单提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('37', '1', 'admin', 'admin_url', 'admin/NavMenu/delete', '', '删除导航菜单', '');
INSERT INTO `x_auth_rule` VALUES ('38', '1', 'admin', 'admin_url', 'admin/NavMenu/listOrder', '', '导航菜单排序', '');
INSERT INTO `x_auth_rule` VALUES ('39', '1', 'admin', 'admin_url', 'admin/Plugin/default', '', '插件管理', '');
INSERT INTO `x_auth_rule` VALUES ('40', '1', 'admin', 'admin_url', 'admin/Plugin/index', '', '插件列表', '');
INSERT INTO `x_auth_rule` VALUES ('41', '1', 'admin', 'admin_url', 'admin/Plugin/toggle', '', '插件启用禁用', '');
INSERT INTO `x_auth_rule` VALUES ('42', '1', 'admin', 'admin_url', 'admin/Plugin/setting', '', '插件设置', '');
INSERT INTO `x_auth_rule` VALUES ('43', '1', 'admin', 'admin_url', 'admin/Plugin/settingPost', '', '插件设置提交', '');
INSERT INTO `x_auth_rule` VALUES ('44', '1', 'admin', 'admin_url', 'admin/Plugin/install', '', '插件安装', '');
INSERT INTO `x_auth_rule` VALUES ('45', '1', 'admin', 'admin_url', 'admin/Plugin/update', '', '插件更新', '');
INSERT INTO `x_auth_rule` VALUES ('46', '1', 'admin', 'admin_url', 'admin/Plugin/uninstall', '', '卸载插件', '');
INSERT INTO `x_auth_rule` VALUES ('47', '1', 'admin', 'admin_url', 'admin/Rbac/index', '', '角色管理', '');
INSERT INTO `x_auth_rule` VALUES ('48', '1', 'admin', 'admin_url', 'admin/Rbac/roleAdd', '', '添加角色', '');
INSERT INTO `x_auth_rule` VALUES ('49', '1', 'admin', 'admin_url', 'admin/Rbac/roleAddPost', '', '添加角色提交', '');
INSERT INTO `x_auth_rule` VALUES ('50', '1', 'admin', 'admin_url', 'admin/Rbac/roleEdit', '', '编辑角色', '');
INSERT INTO `x_auth_rule` VALUES ('51', '1', 'admin', 'admin_url', 'admin/Rbac/roleEditPost', '', '编辑角色提交', '');
INSERT INTO `x_auth_rule` VALUES ('52', '1', 'admin', 'admin_url', 'admin/Rbac/roleDelete', '', '删除角色', '');
INSERT INTO `x_auth_rule` VALUES ('53', '1', 'admin', 'admin_url', 'admin/Rbac/authorize', '', '设置角色权限', '');
INSERT INTO `x_auth_rule` VALUES ('54', '1', 'admin', 'admin_url', 'admin/Rbac/authorizePost', '', '角色授权提交', '');
INSERT INTO `x_auth_rule` VALUES ('55', '1', 'admin', 'admin_url', 'admin/RecycleBin/index', '', '回收站', '');
INSERT INTO `x_auth_rule` VALUES ('56', '1', 'admin', 'admin_url', 'admin/RecycleBin/restore', '', '回收站还原', '');
INSERT INTO `x_auth_rule` VALUES ('57', '1', 'admin', 'admin_url', 'admin/RecycleBin/delete', '', '回收站彻底删除', '');
INSERT INTO `x_auth_rule` VALUES ('58', '1', 'admin', 'admin_url', 'admin/Route/index', '', 'URL美化', '');
INSERT INTO `x_auth_rule` VALUES ('59', '1', 'admin', 'admin_url', 'admin/Route/add', '', '添加路由规则', '');
INSERT INTO `x_auth_rule` VALUES ('60', '1', 'admin', 'admin_url', 'admin/Route/addPost', '', '添加路由规则提交', '');
INSERT INTO `x_auth_rule` VALUES ('61', '1', 'admin', 'admin_url', 'admin/Route/edit', '', '路由规则编辑', '');
INSERT INTO `x_auth_rule` VALUES ('62', '1', 'admin', 'admin_url', 'admin/Route/editPost', '', '路由规则编辑提交', '');
INSERT INTO `x_auth_rule` VALUES ('63', '1', 'admin', 'admin_url', 'admin/Route/delete', '', '路由规则删除', '');
INSERT INTO `x_auth_rule` VALUES ('64', '1', 'admin', 'admin_url', 'admin/Route/ban', '', '路由规则禁用', '');
INSERT INTO `x_auth_rule` VALUES ('65', '1', 'admin', 'admin_url', 'admin/Route/open', '', '路由规则启用', '');
INSERT INTO `x_auth_rule` VALUES ('66', '1', 'admin', 'admin_url', 'admin/Route/listOrder', '', '路由规则排序', '');
INSERT INTO `x_auth_rule` VALUES ('67', '1', 'admin', 'admin_url', 'admin/Route/select', '', '选择URL', '');
INSERT INTO `x_auth_rule` VALUES ('68', '1', 'admin', 'admin_url', 'admin/Setting/default', '', '设置', '');
INSERT INTO `x_auth_rule` VALUES ('69', '1', 'admin', 'admin_url', 'admin/Setting/site', '', '网站信息', '');
INSERT INTO `x_auth_rule` VALUES ('70', '1', 'admin', 'admin_url', 'admin/Setting/sitePost', '', '网站信息设置提交', '');
INSERT INTO `x_auth_rule` VALUES ('71', '1', 'admin', 'admin_url', 'admin/Setting/password', '', '密码修改', '');
INSERT INTO `x_auth_rule` VALUES ('72', '1', 'admin', 'admin_url', 'admin/Setting/passwordPost', '', '密码修改提交', '');
INSERT INTO `x_auth_rule` VALUES ('73', '1', 'admin', 'admin_url', 'admin/Setting/upload', '', '上传设置', '');
INSERT INTO `x_auth_rule` VALUES ('74', '1', 'admin', 'admin_url', 'admin/Setting/uploadPost', '', '上传设置提交', '');
INSERT INTO `x_auth_rule` VALUES ('75', '1', 'admin', 'admin_url', 'admin/Setting/clearCache', '', '清除缓存', '');
INSERT INTO `x_auth_rule` VALUES ('76', '1', 'admin', 'admin_url', 'admin/Slide/index', '', '幻灯片管理', '');
INSERT INTO `x_auth_rule` VALUES ('77', '1', 'admin', 'admin_url', 'admin/Slide/add', '', '添加幻灯片', '');
INSERT INTO `x_auth_rule` VALUES ('78', '1', 'admin', 'admin_url', 'admin/Slide/addPost', '', '添加幻灯片提交', '');
INSERT INTO `x_auth_rule` VALUES ('79', '1', 'admin', 'admin_url', 'admin/Slide/edit', '', '编辑幻灯片', '');
INSERT INTO `x_auth_rule` VALUES ('80', '1', 'admin', 'admin_url', 'admin/Slide/editPost', '', '编辑幻灯片提交', '');
INSERT INTO `x_auth_rule` VALUES ('81', '1', 'admin', 'admin_url', 'admin/Slide/delete', '', '删除幻灯片', '');
INSERT INTO `x_auth_rule` VALUES ('82', '1', 'admin', 'admin_url', 'admin/SlideItem/index', '', '幻灯片页面列表', '');
INSERT INTO `x_auth_rule` VALUES ('83', '1', 'admin', 'admin_url', 'admin/SlideItem/add', '', '幻灯片页面添加', '');
INSERT INTO `x_auth_rule` VALUES ('84', '1', 'admin', 'admin_url', 'admin/SlideItem/addPost', '', '幻灯片页面添加提交', '');
INSERT INTO `x_auth_rule` VALUES ('85', '1', 'admin', 'admin_url', 'admin/SlideItem/edit', '', '幻灯片页面编辑', '');
INSERT INTO `x_auth_rule` VALUES ('86', '1', 'admin', 'admin_url', 'admin/SlideItem/editPost', '', '幻灯片页面编辑提交', '');
INSERT INTO `x_auth_rule` VALUES ('87', '1', 'admin', 'admin_url', 'admin/SlideItem/delete', '', '幻灯片页面删除', '');
INSERT INTO `x_auth_rule` VALUES ('88', '1', 'admin', 'admin_url', 'admin/SlideItem/ban', '', '幻灯片页面隐藏', '');
INSERT INTO `x_auth_rule` VALUES ('89', '1', 'admin', 'admin_url', 'admin/SlideItem/cancelBan', '', '幻灯片页面显示', '');
INSERT INTO `x_auth_rule` VALUES ('90', '1', 'admin', 'admin_url', 'admin/SlideItem/listOrder', '', '幻灯片页面排序', '');
INSERT INTO `x_auth_rule` VALUES ('91', '1', 'admin', 'admin_url', 'admin/Storage/index', '', '文件存储', '');
INSERT INTO `x_auth_rule` VALUES ('92', '1', 'admin', 'admin_url', 'admin/Storage/settingPost', '', '文件存储设置提交', '');
INSERT INTO `x_auth_rule` VALUES ('93', '1', 'admin', 'admin_url', 'admin/Theme/index', '', '模板管理', '');
INSERT INTO `x_auth_rule` VALUES ('94', '1', 'admin', 'admin_url', 'admin/Theme/install', '', '安装模板', '');
INSERT INTO `x_auth_rule` VALUES ('95', '1', 'admin', 'admin_url', 'admin/Theme/uninstall', '', '卸载模板', '');
INSERT INTO `x_auth_rule` VALUES ('96', '1', 'admin', 'admin_url', 'admin/Theme/installTheme', '', '模板安装', '');
INSERT INTO `x_auth_rule` VALUES ('97', '1', 'admin', 'admin_url', 'admin/Theme/update', '', '模板更新', '');
INSERT INTO `x_auth_rule` VALUES ('98', '1', 'admin', 'admin_url', 'admin/Theme/active', '', '启用模板', '');
INSERT INTO `x_auth_rule` VALUES ('99', '1', 'admin', 'admin_url', 'admin/Theme/files', '', '模板文件列表', '');
INSERT INTO `x_auth_rule` VALUES ('100', '1', 'admin', 'admin_url', 'admin/Theme/fileSetting', '', '模板文件设置', '');
INSERT INTO `x_auth_rule` VALUES ('101', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayData', '', '模板文件数组数据列表', '');
INSERT INTO `x_auth_rule` VALUES ('102', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataEdit', '', '模板文件数组数据添加编辑', '');
INSERT INTO `x_auth_rule` VALUES ('103', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('104', '1', 'admin', 'admin_url', 'admin/Theme/fileArrayDataDelete', '', '模板文件数组数据删除', '');
INSERT INTO `x_auth_rule` VALUES ('105', '1', 'admin', 'admin_url', 'admin/Theme/settingPost', '', '模板文件编辑提交保存', '');
INSERT INTO `x_auth_rule` VALUES ('106', '1', 'admin', 'admin_url', 'admin/Theme/dataSource', '', '模板文件设置数据源', '');
INSERT INTO `x_auth_rule` VALUES ('107', '1', 'admin', 'admin_url', 'admin/User/default', '', '管理组', '');
INSERT INTO `x_auth_rule` VALUES ('108', '1', 'admin', 'admin_url', 'admin/User/index', '', '管理员', '');
INSERT INTO `x_auth_rule` VALUES ('109', '1', 'admin', 'admin_url', 'admin/User/add', '', '管理员添加', '');
INSERT INTO `x_auth_rule` VALUES ('110', '1', 'admin', 'admin_url', 'admin/User/addPost', '', '管理员添加提交', '');
INSERT INTO `x_auth_rule` VALUES ('111', '1', 'admin', 'admin_url', 'admin/User/edit', '', '管理员编辑', '');
INSERT INTO `x_auth_rule` VALUES ('112', '1', 'admin', 'admin_url', 'admin/User/editPost', '', '管理员编辑提交', '');
INSERT INTO `x_auth_rule` VALUES ('113', '1', 'admin', 'admin_url', 'admin/User/userInfo', '', '个人信息', '');
INSERT INTO `x_auth_rule` VALUES ('114', '1', 'admin', 'admin_url', 'admin/User/userInfoPost', '', '管理员个人信息修改提交', '');
INSERT INTO `x_auth_rule` VALUES ('115', '1', 'admin', 'admin_url', 'admin/User/delete', '', '管理员删除', '');
INSERT INTO `x_auth_rule` VALUES ('116', '1', 'admin', 'admin_url', 'admin/User/ban', '', '停用管理员', '');
INSERT INTO `x_auth_rule` VALUES ('117', '1', 'admin', 'admin_url', 'admin/User/cancelBan', '', '启用管理员', '');
INSERT INTO `x_auth_rule` VALUES ('118', '1', 'portal', 'admin_url', 'portal/AdminArticle/index', '', '文章管理', '');
INSERT INTO `x_auth_rule` VALUES ('119', '1', 'portal', 'admin_url', 'portal/AdminArticle/add', '', '添加文章', '');
INSERT INTO `x_auth_rule` VALUES ('120', '1', 'portal', 'admin_url', 'portal/AdminArticle/addPost', '', '添加文章提交', '');
INSERT INTO `x_auth_rule` VALUES ('121', '1', 'portal', 'admin_url', 'portal/AdminArticle/edit', '', '编辑文章', '');
INSERT INTO `x_auth_rule` VALUES ('122', '1', 'portal', 'admin_url', 'portal/AdminArticle/editPost', '', '编辑文章提交', '');
INSERT INTO `x_auth_rule` VALUES ('123', '1', 'portal', 'admin_url', 'portal/AdminArticle/delete', '', '文章删除', '');
INSERT INTO `x_auth_rule` VALUES ('124', '1', 'portal', 'admin_url', 'portal/AdminArticle/publish', '', '文章发布', '');
INSERT INTO `x_auth_rule` VALUES ('125', '1', 'portal', 'admin_url', 'portal/AdminArticle/top', '', '文章置顶', '');
INSERT INTO `x_auth_rule` VALUES ('126', '1', 'portal', 'admin_url', 'portal/AdminArticle/recommend', '', '文章推荐', '');
INSERT INTO `x_auth_rule` VALUES ('127', '1', 'portal', 'admin_url', 'portal/AdminArticle/listOrder', '', '文章排序', '');
INSERT INTO `x_auth_rule` VALUES ('128', '1', 'portal', 'admin_url', 'portal/AdminCategory/index', '', '分类管理', '');
INSERT INTO `x_auth_rule` VALUES ('129', '1', 'portal', 'admin_url', 'portal/AdminCategory/add', '', '添加文章分类', '');
INSERT INTO `x_auth_rule` VALUES ('130', '1', 'portal', 'admin_url', 'portal/AdminCategory/addPost', '', '添加文章分类提交', '');
INSERT INTO `x_auth_rule` VALUES ('131', '1', 'portal', 'admin_url', 'portal/AdminCategory/edit', '', '编辑文章分类', '');
INSERT INTO `x_auth_rule` VALUES ('132', '1', 'portal', 'admin_url', 'portal/AdminCategory/editPost', '', '编辑文章分类提交', '');
INSERT INTO `x_auth_rule` VALUES ('133', '1', 'portal', 'admin_url', 'portal/AdminCategory/select', '', '文章分类选择对话框', '');
INSERT INTO `x_auth_rule` VALUES ('134', '1', 'portal', 'admin_url', 'portal/AdminCategory/listOrder', '', '文章分类排序', '');
INSERT INTO `x_auth_rule` VALUES ('135', '1', 'portal', 'admin_url', 'portal/AdminCategory/delete', '', '删除文章分类', '');
INSERT INTO `x_auth_rule` VALUES ('136', '1', 'portal', 'admin_url', 'portal/AdminIndex/default', '', '门户管理', '');
INSERT INTO `x_auth_rule` VALUES ('137', '1', 'portal', 'admin_url', 'portal/AdminPage/index', '', '页面管理', '');
INSERT INTO `x_auth_rule` VALUES ('138', '1', 'portal', 'admin_url', 'portal/AdminPage/add', '', '添加页面', '');
INSERT INTO `x_auth_rule` VALUES ('139', '1', 'portal', 'admin_url', 'portal/AdminPage/addPost', '', '添加页面提交', '');
INSERT INTO `x_auth_rule` VALUES ('140', '1', 'portal', 'admin_url', 'portal/AdminPage/edit', '', '编辑页面', '');
INSERT INTO `x_auth_rule` VALUES ('141', '1', 'portal', 'admin_url', 'portal/AdminPage/editPost', '', '编辑页面提交', '');
INSERT INTO `x_auth_rule` VALUES ('142', '1', 'portal', 'admin_url', 'portal/AdminPage/delete', '', '删除页面', '');
INSERT INTO `x_auth_rule` VALUES ('143', '1', 'portal', 'admin_url', 'portal/AdminTag/index', '', '文章标签', '');
INSERT INTO `x_auth_rule` VALUES ('144', '1', 'portal', 'admin_url', 'portal/AdminTag/add', '', '添加文章标签', '');
INSERT INTO `x_auth_rule` VALUES ('145', '1', 'portal', 'admin_url', 'portal/AdminTag/addPost', '', '添加文章标签提交', '');
INSERT INTO `x_auth_rule` VALUES ('146', '1', 'portal', 'admin_url', 'portal/AdminTag/upStatus', '', '更新标签状态', '');
INSERT INTO `x_auth_rule` VALUES ('147', '1', 'portal', 'admin_url', 'portal/AdminTag/delete', '', '删除文章标签', '');
INSERT INTO `x_auth_rule` VALUES ('148', '1', 'user', 'admin_url', 'user/AdminAsset/index', '', '资源管理', '');
INSERT INTO `x_auth_rule` VALUES ('149', '1', 'user', 'admin_url', 'user/AdminAsset/delete', '', '删除文件', '');
INSERT INTO `x_auth_rule` VALUES ('150', '1', 'user', 'admin_url', 'user/AdminIndex/default', '', '用户管理', '');
INSERT INTO `x_auth_rule` VALUES ('151', '1', 'user', 'admin_url', 'user/AdminIndex/default1', '', '用户组', '');
INSERT INTO `x_auth_rule` VALUES ('152', '1', 'user', 'admin_url', 'user/AdminIndex/index', '', '本站用户', '');
INSERT INTO `x_auth_rule` VALUES ('153', '1', 'user', 'admin_url', 'user/AdminIndex/ban', '', '本站用户拉黑', '');
INSERT INTO `x_auth_rule` VALUES ('154', '1', 'user', 'admin_url', 'user/AdminIndex/cancelBan', '', '本站用户启用', '');
INSERT INTO `x_auth_rule` VALUES ('155', '1', 'user', 'admin_url', 'user/AdminOauth/index', '', '第三方用户', '');
INSERT INTO `x_auth_rule` VALUES ('156', '1', 'user', 'admin_url', 'user/AdminOauth/delete', '', '删除第三方用户绑定', '');
INSERT INTO `x_auth_rule` VALUES ('157', '1', 'user', 'admin_url', 'user/AdminUserAction/index', '', '用户操作管理', '');
INSERT INTO `x_auth_rule` VALUES ('158', '1', 'general', 'admin_url', 'general/AdminIndex/default', '', '通用报修', '');
INSERT INTO `x_auth_rule` VALUES ('159', '1', 'general', 'admin_url', 'general/GeneralCategory/index', '', '报修分类管理', '');
INSERT INTO `x_auth_rule` VALUES ('160', '1', 'xrepair', 'admin_url', 'xrepair/AdminIndex/default', '', 'X报修系统管理', '');
INSERT INTO `x_auth_rule` VALUES ('161', '1', 'xrepair', 'admin_url', 'xrepair/Region/index', '', '区域管理', '');

-- ----------------------------
-- Table structure for x_comment
-- ----------------------------
DROP TABLE IF EXISTS `x_comment`;
CREATE TABLE `x_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text COMMENT '评论内容',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`),
  KEY `comment_post_ID` (`object_id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parent_id`),
  KEY `table_id_status` (`table_name`,`object_id`,`status`),
  KEY `createtime` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of x_comment
-- ----------------------------

-- ----------------------------
-- Table structure for x_general_category
-- ----------------------------
DROP TABLE IF EXISTS `x_general_category`;
CREATE TABLE `x_general_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL COMMENT '分类描述',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';

-- ----------------------------
-- Records of x_general_category
-- ----------------------------
INSERT INTO `x_general_category` VALUES ('7', '0', '1', '0', '0', '水类故障', '', null);
INSERT INTO `x_general_category` VALUES ('8', '0', '1', '0', '0', '电类故障', '', null);
INSERT INTO `x_general_category` VALUES ('9', '0', '1', '0', '0', '门窗故障', '', null);

-- ----------------------------
-- Table structure for x_general_order
-- ----------------------------
DROP TABLE IF EXISTS `x_general_order`;
CREATE TABLE `x_general_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名称',
  `mobile` varchar(255) NOT NULL COMMENT '手机号码',
  `region` varchar(255) NOT NULL COMMENT '区域',
  `category` varchar(255) NOT NULL COMMENT '报修类型',
  `desc` varchar(255) NOT NULL COMMENT '描述',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL COMMENT '更新时间',
  `order_time` int(11) unsigned DEFAULT NULL COMMENT '接单时间',
  `complete_time` int(11) unsigned DEFAULT NULL COMMENT '完成时间',
  `status` int(255) DEFAULT '0' COMMENT '状态:-1|取消报修,0|未接单,1|已接单,2|完成',
  `feedback` varchar(255) DEFAULT NULL COMMENT '反馈信息',
  `repairer_id` int(11) unsigned DEFAULT NULL COMMENT '维修人员',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of x_general_order
-- ----------------------------
INSERT INTO `x_general_order` VALUES ('6', '麦青强', '18587733312', '19', '7', '宿舍没水了', '1502636625', '1502636625', null, null, '0', null, null, '0');
INSERT INTO `x_general_order` VALUES ('5', '麦青强', '18587733312', '13,15', '8', '宿舍已经不通电了', '1502636565', '1502636565', null, null, '0', null, null, '0');
INSERT INTO `x_general_order` VALUES ('7', '麦青强', '18587733312', '13,15', '9', '宿舍门坏了', '1502636656', '1502636656', null, null, '0', null, null, '0');
INSERT INTO `x_general_order` VALUES ('8', '小明', '18587733312', '13,15', '9', '门坏了', '1502638196', '1502638196', null, null, '0', null, null, '1');
INSERT INTO `x_general_order` VALUES ('9', 'admin', '18587733312', '13,15', '7', '没水', '1502639106', '1502639106', null, null, '0', null, null, '1');
INSERT INTO `x_general_order` VALUES ('10', 'admin', '18587733312', '14,17', '8', '没电了', '1502639245', '1502639245', null, null, '0', null, null, '1');

-- ----------------------------
-- Table structure for x_hook
-- ----------------------------
DROP TABLE IF EXISTS `x_hook`;
CREATE TABLE `x_hook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(30) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子表';

-- ----------------------------
-- Records of x_hook
-- ----------------------------
INSERT INTO `x_hook` VALUES ('1', '1', '0', '应用初始化', 'app_init', 'cmf', '应用初始化');
INSERT INTO `x_hook` VALUES ('2', '1', '0', '应用开始', 'app_begin', 'cmf', '应用开始');
INSERT INTO `x_hook` VALUES ('3', '1', '0', '模块初始化', 'module_init', 'cmf', '模块初始化');
INSERT INTO `x_hook` VALUES ('4', '1', '0', '控制器开始', 'action_begin', 'cmf', '控制器开始');
INSERT INTO `x_hook` VALUES ('5', '1', '0', '视图输出过滤', 'view_filter', 'cmf', '视图输出过滤');
INSERT INTO `x_hook` VALUES ('6', '1', '0', '应用结束', 'app_end', 'cmf', '应用结束');
INSERT INTO `x_hook` VALUES ('7', '1', '0', '日志write方法', 'log_write', 'cmf', '日志write方法');
INSERT INTO `x_hook` VALUES ('8', '1', '0', '输出结束', 'response_end', 'cmf', '输出结束');
INSERT INTO `x_hook` VALUES ('9', '1', '0', '后台控制器初始化', 'admin_init', 'cmf', '后台控制器初始化');
INSERT INTO `x_hook` VALUES ('10', '1', '0', '前台控制器初始化', 'home_init', 'cmf', '前台控制器初始化');
INSERT INTO `x_hook` VALUES ('11', '1', '1', '发送手机验证码', 'send_mobile_verification_code', 'cmf', '发送手机验证码');
INSERT INTO `x_hook` VALUES ('12', '3', '0', '模板 body标签开始', 'body_start', '', '模板 body标签开始');
INSERT INTO `x_hook` VALUES ('13', '3', '0', '模板 head标签结束前', 'before_head_end', '', '模板 head标签结束前');
INSERT INTO `x_hook` VALUES ('14', '3', '0', '模板底部开始', 'footer_start', '', '模板底部开始');
INSERT INTO `x_hook` VALUES ('15', '3', '0', '模板底部开始之前', 'before_footer', '', '模板底部开始之前');
INSERT INTO `x_hook` VALUES ('16', '3', '0', '模板底部结束之前', 'before_footer_end', '', '模板底部结束之前');
INSERT INTO `x_hook` VALUES ('17', '3', '0', '模板 body 标签结束之前', 'before_body_end', '', '模板 body 标签结束之前');
INSERT INTO `x_hook` VALUES ('18', '3', '0', '模板左边栏开始', 'left_sidebar_start', '', '模板左边栏开始');
INSERT INTO `x_hook` VALUES ('19', '3', '0', '模板左边栏结束之前', 'before_left_sidebar_end', '', '模板左边栏结束之前');
INSERT INTO `x_hook` VALUES ('20', '3', '0', '模板右边栏开始', 'right_sidebar_start', '', '模板右边栏开始');
INSERT INTO `x_hook` VALUES ('21', '3', '0', '模板右边栏结束之前', 'before_right_sidebar_end', '', '模板右边栏结束之前');
INSERT INTO `x_hook` VALUES ('22', '3', '1', '评论区', 'comment', '', '评论区');
INSERT INTO `x_hook` VALUES ('23', '3', '1', '留言区', 'guestbook', '', '留言区');
INSERT INTO `x_hook` VALUES ('24', '2', '0', '后台首页仪表盘', 'admin_dashboard', 'admin', '后台首页仪表盘');
INSERT INTO `x_hook` VALUES ('25', '4', '0', '后台模板 head标签结束前', 'admin_before_head_end', '', '后台模板 head标签结束前');
INSERT INTO `x_hook` VALUES ('26', '4', '0', '后台模板 body 标签结束之前', 'admin_before_body_end', '', '后台模板 body 标签结束之前');
INSERT INTO `x_hook` VALUES ('27', '2', '0', '后台登录页面', 'admin_login', 'admin', '后台登录页面');
INSERT INTO `x_hook` VALUES ('28', '1', '1', '前台模板切换', 'switch_theme', 'cmf', '前台模板切换');
INSERT INTO `x_hook` VALUES ('29', '1', '1', '登录逻辑开始之前', 'user_login_start', 'cmf', '登录逻辑开始之前');

-- ----------------------------
-- Table structure for x_hook_plugin
-- ----------------------------
DROP TABLE IF EXISTS `x_hook_plugin`;
CREATE TABLE `x_hook_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(30) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(30) NOT NULL DEFAULT '' COMMENT '插件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子插件表';

-- ----------------------------
-- Records of x_hook_plugin
-- ----------------------------

-- ----------------------------
-- Table structure for x_link
-- ----------------------------
DROP TABLE IF EXISTS `x_link`;
CREATE TABLE `x_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`),
  KEY `link_visible` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='友情链接表';

-- ----------------------------
-- Records of x_link
-- ----------------------------
INSERT INTO `x_link` VALUES ('1', '1', '1', '8', 'thinkcmf官网', 'http://www.thinkcmf.com', 'ThinkCMF', '', '_blank', '');

-- ----------------------------
-- Table structure for x_nav
-- ----------------------------
DROP TABLE IF EXISTS `x_nav`;
CREATE TABLE `x_nav` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_main` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航位置表';

-- ----------------------------
-- Records of x_nav
-- ----------------------------
INSERT INTO `x_nav` VALUES ('1', '1', '主导航', '主导航');
INSERT INTO `x_nav` VALUES ('2', '0', '底部导航', '');

-- ----------------------------
-- Table structure for x_nav_menu
-- ----------------------------
DROP TABLE IF EXISTS `x_nav_menu`;
CREATE TABLE `x_nav_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='前台导航菜单表';

-- ----------------------------
-- Records of x_nav_menu
-- ----------------------------
INSERT INTO `x_nav_menu` VALUES ('1', '1', '0', '1', '0', '首页', '', 'home', '', '0-1');

-- ----------------------------
-- Table structure for x_option
-- ----------------------------
DROP TABLE IF EXISTS `x_option`;
CREATE TABLE `x_option` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autoload` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='全站配置表';

-- ----------------------------
-- Records of x_option
-- ----------------------------
INSERT INTO `x_option` VALUES ('7', '1', 'site_info', '{\"site_name\":\"X\\u62a5\\u4fee\",\"site_seo_title\":\"X\\u62a5\\u4fee\",\"site_seo_keywords\":\"X\\u62a5\\u4fee\",\"site_seo_description\":\"X\\u62a5\\u4fee\",\"site_icp\":\"\",\"site_admin_email\":\"\",\"site_analytics\":\"\",\"urlmode\":\"1\",\"html_suffix\":\"\"}');
INSERT INTO `x_option` VALUES ('8', '1', 'cmf_settings', '{\"open_registration\":\"1\",\"banned_usernames\":\"\"}');
INSERT INTO `x_option` VALUES ('9', '1', 'cdn_settings', '{\"cdn_static_root\":\"\"}');
INSERT INTO `x_option` VALUES ('10', '1', 'admin_settings', '{\"admin_password\":\"\",\"admin_style\":\"flatadmin\"}');

-- ----------------------------
-- Table structure for x_plugin
-- ----------------------------
DROP TABLE IF EXISTS `x_plugin`;
CREATE TABLE `x_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件表';

-- ----------------------------
-- Records of x_plugin
-- ----------------------------

-- ----------------------------
-- Table structure for x_portal_category
-- ----------------------------
DROP TABLE IF EXISTS `x_portal_category`;
CREATE TABLE `x_portal_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `list_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类文章页模板',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';

-- ----------------------------
-- Records of x_portal_category
-- ----------------------------

-- ----------------------------
-- Table structure for x_portal_category_post
-- ----------------------------
DROP TABLE IF EXISTS `x_portal_category_post`;
CREATE TABLE `x_portal_category_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';

-- ----------------------------
-- Records of x_portal_category_post
-- ----------------------------

-- ----------------------------
-- Table structure for x_portal_post
-- ----------------------------
DROP TABLE IF EXISTS `x_portal_post`;
CREATE TABLE `x_portal_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `post_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_like` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `more` text COMMENT '扩展属性,如缩略图;格式为json',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  KEY `post_parent` (`parent_id`),
  KEY `post_author` (`user_id`),
  KEY `post_date` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='portal应用 文章表';

-- ----------------------------
-- Records of x_portal_post
-- ----------------------------

-- ----------------------------
-- Table structure for x_portal_tag
-- ----------------------------
DROP TABLE IF EXISTS `x_portal_tag`;
CREATE TABLE `x_portal_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章标签表';

-- ----------------------------
-- Records of x_portal_tag
-- ----------------------------

-- ----------------------------
-- Table structure for x_portal_tag_post
-- ----------------------------
DROP TABLE IF EXISTS `x_portal_tag_post`;
CREATE TABLE `x_portal_tag_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '标签 id',
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文章 id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布',
  PRIMARY KEY (`id`),
  KEY `term_taxonomy_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';

-- ----------------------------
-- Records of x_portal_tag_post
-- ----------------------------

-- ----------------------------
-- Table structure for x_recycle_bin
-- ----------------------------
DROP TABLE IF EXISTS `x_recycle_bin`;
CREATE TABLE `x_recycle_bin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT=' 回收站';

-- ----------------------------
-- Records of x_recycle_bin
-- ----------------------------
INSERT INTO `x_recycle_bin` VALUES ('2', '8', '1502607052', 'repair_region', '1栋2');

-- ----------------------------
-- Table structure for x_repair_region
-- ----------------------------
DROP TABLE IF EXISTS `x_repair_region`;
CREATE TABLE `x_repair_region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL COMMENT '分类描述',
  `more` text COMMENT '扩展属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';

-- ----------------------------
-- Records of x_repair_region
-- ----------------------------
INSERT INTO `x_repair_region` VALUES ('13', '0', '1', '0', '0', '里建校区', '', null);
INSERT INTO `x_repair_region` VALUES ('14', '0', '1', '0', '0', '长堽校区', '', null);
INSERT INTO `x_repair_region` VALUES ('15', '13', '1', '0', '0', '1栋', '', null);
INSERT INTO `x_repair_region` VALUES ('16', '14', '1', '0', '0', '桂江阁', '', null);
INSERT INTO `x_repair_region` VALUES ('17', '14', '1', '0', '0', '长江阁', '', null);
INSERT INTO `x_repair_region` VALUES ('18', '14', '1', '0', '0', '黄河阁', '', null);
INSERT INTO `x_repair_region` VALUES ('19', '0', '1', '0', '0', '大沙田校区', '', null);

-- ----------------------------
-- Table structure for x_role
-- ----------------------------
DROP TABLE IF EXISTS `x_role`;
CREATE TABLE `x_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `parentId` (`parent_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of x_role
-- ----------------------------
INSERT INTO `x_role` VALUES ('1', '0', '1', '1329633709', '1329633709', '0', '超级管理员', '拥有网站最高管理员权限！');
INSERT INTO `x_role` VALUES ('2', '0', '1', '1329633709', '1329633709', '0', '普通管理员', '权限由最高管理员分配！');
INSERT INTO `x_role` VALUES ('3', '0', '1', '0', '0', '0', '维修人员', '');

-- ----------------------------
-- Table structure for x_role_user
-- ----------------------------
DROP TABLE IF EXISTS `x_role_user`;
CREATE TABLE `x_role_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Records of x_role_user
-- ----------------------------

-- ----------------------------
-- Table structure for x_route
-- ----------------------------
DROP TABLE IF EXISTS `x_route`;
CREATE TABLE `x_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='url路由表';

-- ----------------------------
-- Records of x_route
-- ----------------------------

-- ----------------------------
-- Table structure for x_slide
-- ----------------------------
DROP TABLE IF EXISTS `x_slide`;
CREATE TABLE `x_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

-- ----------------------------
-- Records of x_slide
-- ----------------------------

-- ----------------------------
-- Table structure for x_slide_item
-- ----------------------------
DROP TABLE IF EXISTS `x_slide_item`;
CREATE TABLE `x_slide_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COMMENT '幻灯片内容',
  `more` text COMMENT '链接打开方式',
  PRIMARY KEY (`id`),
  KEY `slide_cid` (`slide_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片子项表';

-- ----------------------------
-- Records of x_slide_item
-- ----------------------------

-- ----------------------------
-- Table structure for x_theme
-- ----------------------------
DROP TABLE IF EXISTS `x_theme`;
CREATE TABLE `x_theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_theme
-- ----------------------------
INSERT INTO `x_theme` VALUES ('19', '0', '0', '0', '0', 'simpleboot3', 'simpleboot3', '1.0.2', 'http://demo.thinkcmf.com', '', 'ThinkCMF', 'http://www.thinkcmf.com', 'zh-cn', 'ThinkCMF模板', 'ThinkCMF默认模板');

-- ----------------------------
-- Table structure for x_theme_file
-- ----------------------------
DROP TABLE IF EXISTS `x_theme_file`;
CREATE TABLE `x_theme_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_theme_file
-- ----------------------------
INSERT INTO `x_theme_file` VALUES ('105', '0', '10', 'simpleboot3', '文章页', 'portal/Article/index', 'portal/article', '文章页模板文件', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"name\":\"hot_articles_category_id\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"name\":\"hot_articles_category_id\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', null);
INSERT INTO `x_theme_file` VALUES ('106', '0', '10', 'simpleboot3', '联系我们页', 'portal/Page/index', 'portal/contact', '联系我们页模板文件', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', null);
INSERT INTO `x_theme_file` VALUES ('107', '0', '5', 'simpleboot3', '首页', 'portal/Index/index', 'portal/index', '首页模板文件', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `x_theme_file` VALUES ('108', '0', '10', 'simpleboot3', '文章列表页', 'portal/List/index', 'portal/list', '文章列表模板文件', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `x_theme_file` VALUES ('109', '0', '10', 'simpleboot3', '单页面', 'portal/Page/index', 'portal/page', '单页面模板文件', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', null);
INSERT INTO `x_theme_file` VALUES ('110', '0', '10', 'simpleboot3', '搜索页面', 'portal/search/index', 'portal/search', '搜索模板文件', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', null);
INSERT INTO `x_theme_file` VALUES ('111', '1', '0', 'simpleboot3', '模板全局配置', 'public/Config', 'public/config', '模板全局配置文件', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', null);
INSERT INTO `x_theme_file` VALUES ('112', '1', '1', 'simpleboot3', '导航条', 'public/Nav', 'public/nav', '导航条模板文件', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', null);

-- ----------------------------
-- Table structure for x_third_party_user
-- ----------------------------
DROP TABLE IF EXISTS `x_third_party_user`;
CREATE TABLE `x_third_party_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方惟一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户表';

-- ----------------------------
-- Records of x_third_party_user
-- ----------------------------

-- ----------------------------
-- Table structure for x_user
-- ----------------------------
DROP TABLE IF EXISTS `x_user`;
CREATE TABLE `x_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:会员',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '0' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '用户手机号',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of x_user
-- ----------------------------
INSERT INTO `x_user` VALUES ('1', '1', '0', '0', '1502639213', '0', '0', '1502376647', '1', 'admin', '###a04c0a7d37be47f3bee8d0c2c56d4b64', 'admin', 'xiaomak@qq.com', '', '', '', '192.168.31.155', '', '');

-- ----------------------------
-- Table structure for x_user_action
-- ----------------------------
DROP TABLE IF EXISTS `x_user_action`;
CREATE TABLE `x_user_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作表';

-- ----------------------------
-- Records of x_user_action
-- ----------------------------

-- ----------------------------
-- Table structure for x_user_action_log
-- ----------------------------
DROP TABLE IF EXISTS `x_user_action_log`;
CREATE TABLE `x_user_action_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user_id`,`object`,`action`),
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';

-- ----------------------------
-- Records of x_user_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for x_user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `x_user_favorite`;
CREATE TABLE `x_user_favorite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `url` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) CHARACTER SET utf8 DEFAULT '' COMMENT '收藏内容的描述',
  `table_name` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) unsigned DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏表';

-- ----------------------------
-- Records of x_user_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for x_user_login_attempt
-- ----------------------------
DROP TABLE IF EXISTS `x_user_login_attempt`;
CREATE TABLE `x_user_login_attempt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';

-- ----------------------------
-- Records of x_user_login_attempt
-- ----------------------------

-- ----------------------------
-- Table structure for x_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `x_user_score_log`;
CREATE TABLE `x_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作积分等奖励日志表';

-- ----------------------------
-- Records of x_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for x_user_token
-- ----------------------------
DROP TABLE IF EXISTS `x_user_token`;
CREATE TABLE `x_user_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户客户端登录 token 表';

-- ----------------------------
-- Records of x_user_token
-- ----------------------------
INSERT INTO `x_user_token` VALUES ('3', '1', '1518186244', '1502634244', 'd0edd89e4923a865208f332d2d231fd8f0fd4736b478d2d1b38bd29730e229c8', 'web');

-- ----------------------------
-- Table structure for x_verification_code
-- ----------------------------
DROP TABLE IF EXISTS `x_verification_code`;
CREATE TABLE `x_verification_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';

-- ----------------------------
-- Records of x_verification_code
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;
