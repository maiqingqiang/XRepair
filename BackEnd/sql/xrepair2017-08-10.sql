/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : xrepair

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-08-10 09:59:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for x_action_log
-- ----------------------------
DROP TABLE IF EXISTS `x_action_log`;
CREATE TABLE `x_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT '0' COMMENT '用户id',
  `object` varchar(100) DEFAULT NULL COMMENT '访问对象的id,格式：不带前缀的表名+id;如news1表示xx_news表里id为1的记录',
  `action` varchar(50) DEFAULT NULL COMMENT '操作名称；格式规定为：应用名+控制器+操作名；也可自己定义格式只要不发生冲突且惟一；',
  `count` int(11) DEFAULT '0' COMMENT '访问次数',
  `last_time` int(11) DEFAULT '0' COMMENT '最后访问的时间戳',
  `ip` varchar(15) DEFAULT NULL COMMENT '访问者最后访问ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`uid`,`object`,`action`),
  KEY `user_object_action_ip` (`uid`,`object`,`action`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='访问记录表';

-- ----------------------------
-- Records of x_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for x_addon
-- ----------------------------
DROP TABLE IF EXISTS `x_addon`;
CREATE TABLE `x_addon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '插件名称',
  `title` varchar(32) NOT NULL DEFAULT '' COMMENT '插件标题',
  `icon` varchar(64) NOT NULL DEFAULT '' COMMENT '图标',
  `description` text NOT NULL COMMENT '插件描述',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '作者',
  `author_url` varchar(255) NOT NULL DEFAULT '' COMMENT '作者主页',
  `config` text NOT NULL COMMENT '配置信息',
  `admin_actions` text COMMENT '管理操作',
  `version` varchar(16) NOT NULL DEFAULT '' COMMENT '版本号',
  `identifier` varchar(64) NOT NULL DEFAULT '' COMMENT '插件唯一标识符',
  `admin` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of x_addon
-- ----------------------------
INSERT INTO `x_addon` VALUES ('17', 'Maintain', '日常维护', '', '后台首页日常维护', 'rainfer', '', '{\"display\":\"1\"}', '{\"index\":[],\"config\":[],\"edit\":[],\"add\":[]}', '0.1', '', '0', '1487424935', '1487425273', '15', '1');
INSERT INTO `x_addon` VALUES ('15', 'Security', '安全检测', '', '网站安全检测', 'rainfer', '', '', '{\"index\":[\"Admin\\/security_list\"],\"config\":[],\"edit\":[],\"add\":[]}', '0.1', '', '1', '1487422525', '1487425273', '40', '1');
INSERT INTO `x_addon` VALUES ('13', 'Info', '后台信息', '', '后台首页信息显示', 'rainfer', '', '{\"display\":\"1\"}', '{\"index\":[],\"config\":[\"Admin\\/config\"],\"edit\":[],\"add\":[]}', '0.1', '', '0', '1487419743', '1487425273', '100', '1');
INSERT INTO `x_addon` VALUES ('16', 'Team', '团队&贡献者', '', '后台首页团队&贡献者显示', 'rainfer', '', '{\"display\":\"1\"}', null, '0.1', '', '0', '1487422724', '1487425273', '10', '1');

-- ----------------------------
-- Table structure for x_admin
-- ----------------------------
DROP TABLE IF EXISTS `x_admin`;
CREATE TABLE `x_admin` (
  `admin_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `admin_username` varchar(20) NOT NULL COMMENT '管理员用户名',
  `admin_pwd` varchar(70) NOT NULL COMMENT '管理员密码',
  `admin_pwd_salt` char(10) NOT NULL,
  `admin_changepwd` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更改密码时间',
  `admin_email` varchar(30) NOT NULL COMMENT '邮箱',
  `admin_realname` varchar(10) DEFAULT NULL COMMENT '真实姓名',
  `admin_avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `admin_tel` varchar(30) DEFAULT NULL COMMENT '电话号码',
  `admin_hits` int(8) NOT NULL DEFAULT '1' COMMENT '登陆次数',
  `admin_ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
  `admin_time` int(11) unsigned DEFAULT '0' COMMENT '登陆时间',
  `admin_last_ip` varchar(20) DEFAULT NULL COMMENT '上次登陆ip',
  `admin_last_time` int(11) unsigned DEFAULT '0' COMMENT '上次登陆时间',
  `admin_addtime` int(11) NOT NULL COMMENT '添加时间',
  `admin_mdemail` varchar(50) NOT NULL DEFAULT '0' COMMENT '传递修改密码参数加密',
  `admin_open` tinyint(2) NOT NULL DEFAULT '0' COMMENT '审核状态',
  `member_id` int(6) unsigned NOT NULL COMMENT '对应会员ID',
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_admin
-- ----------------------------
INSERT INTO `x_admin` VALUES ('1', 'admin', '58ce64f0ccccfeef795f3cccdb8cae82', 'mANIviADaC', '1502245979', 'xiaomak@qq.com', '', '', '', '2', '0.0.0.0', '0', '0.0.0.0', '1502245995', '1502245979', '', '1', '1');

-- ----------------------------
-- Table structure for x_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_group`;
CREATE TABLE `x_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text NOT NULL,
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_auth_group
-- ----------------------------
INSERT INTO `x_auth_group` VALUES ('1', '超级管理员', '1', '1,2,6,59,151,10,62,154,19,60,152,26,43,63,64,65,66,67,155,57,61,153,3,4,89,90,159,5,85,86,87,88,160,15,16,68,69,70,71,72,73,156,17,55,56,74,75,76,77,78,157,18,79,80,81,82,83,84,158,40,41,92,162,42,91,161,7,8,11,94,95,96,100,101,175,12,93,174,25,97,98,99,173,9,13,103,104,105,106,107,172,14,102,171,22,23,24,27,29,37,108,109,110,111,112,113,114,170,38,115,116,117,118,119,120,169,30,28,31,32,129,128,130,131,132,167,34,133,134,135,136,166,44,45,138,139,140,141,142,143,165,46,144,145,146,147,148,164,48,49,137,163,35,36,39,121,122,123,124,125,126,127,168,', '1212451252');
INSERT INTO `x_auth_group` VALUES ('2', '管理员', '1', '1,2,6,151,10,154,19,152,43,65,67,155,57,153,184,190,3,4,159,5,160,15,16,68,70,156,17,74,77,157,176,18,82,158,177,40,41,162,42,161,178,179,180,7,8,11,94,175,12,174,25,173,9,13,105,172,14,171,22,23,24,27,29,37,108,110,170,38,119,169,28,31,32,131,167,34,166,44,45,142,165,46,145,164,181,182,36,39,124,168,48,49,137,185,186,198,199,201,', '1212451252');

-- ----------------------------
-- Table structure for x_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_group_access`;
CREATE TABLE `x_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_auth_group_access
-- ----------------------------
INSERT INTO `x_auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for x_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_rule`;
CREATE TABLE `x_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `notcheck` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0需要验证 1不需要',
  `css` varchar(20) NOT NULL COMMENT '样式',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` int(5) NOT NULL DEFAULT '0' COMMENT '父栏目ID',
  `level` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '菜单等级',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `addtime` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=327 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_auth_rule
-- ----------------------------
INSERT INTO `x_auth_rule` VALUES ('1', 'admin/Sys', '系统设置', '1', '1', '0', 'fa-tachometer', '', '0', '1', '1', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('2', 'admin/Sys/sys', '系统参数设置', '1', '1', '0', '', '', '1', '2', '10', '1446535789');
INSERT INTO `x_auth_rule` VALUES ('3', 'admin/Sys/database', '数据备份还原', '1', '1', '0', '', '', '1', '2', '30', '1446535805');
INSERT INTO `x_auth_rule` VALUES ('4', 'admin/Sys/import', '数据库还原', '1', '1', '0', '', '', '3', '3', '20', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('5', 'admin/Sys/database', '数据库备份', '1', '1', '0', '', '', '3', '3', '10', '1446535834');
INSERT INTO `x_auth_rule` VALUES ('6', 'admin/Sys/sys', '站点设置', '1', '1', '0', '', '', '2', '3', '10', '1446535843');
INSERT INTO `x_auth_rule` VALUES ('7', 'admin/News', '文章管理', '1', '1', '0', 'fa-folder', '', '0', '1', '13', '1446535875');
INSERT INTO `x_auth_rule` VALUES ('9', 'admin/Menu', '前台菜单', '1', '1', '0', 'fa-desktop', '', '0', '1', '9', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('10', 'wechat/We/wesys', '微信设置', '1', '1', '0', '', '', '2', '3', '40', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('11', 'admin/News/news_list', '文章列表', '1', '1', '0', '', '', '7', '2', '10', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('12', 'admin/News/news_add', '添加文章', '1', '1', '0', '', '', '7', '2', '20', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('13', 'admin/Menu/news_menu_list', '菜单列表', '1', '1', '0', '', '', '9', '2', '10', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('14', 'admin/Menu/news_menu_add', '添加菜单', '1', '1', '0', '', '', '9', '2', '20', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('15', 'admin/Admin', '管理员管理', '1', '1', '0', 'fa-users', '', '0', '1', '3', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('16', 'admin/Admin/admin_list', '管理员列表', '1', '1', '0', '', '', '15', '2', '10', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('17', 'admin/Admin/admin_group_list', '用户组列表', '1', '1', '0', '', '', '15', '2', '20', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('18', 'admin/Sys', '后台菜单', '1', '1', '0', 'fa-desktop', '', '0', '1', '7', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('19', 'admin/Sys/emailsys', '邮件连接', '1', '1', '0', '', '', '2', '3', '20', '1446535750');
INSERT INTO `x_auth_rule` VALUES ('22', 'admin/Help', '帮助中心', '1', '1', '0', 'fa-cogs', '', '0', '1', '99', '1446711367');
INSERT INTO `x_auth_rule` VALUES ('23', 'admin/Help/soft', '软件下载', '1', '1', '0', '', '', '22', '2', '10', '1446711421');
INSERT INTO `x_auth_rule` VALUES ('24', 'admin/Help/soft', '下载列表', '1', '1', '0', '', '', '23', '3', '10', '1446711448');
INSERT INTO `x_auth_rule` VALUES ('25', 'admin/News/news_back', '回收站', '1', '1', '0', '', '', '7', '2', '30', '1447039310');
INSERT INTO `x_auth_rule` VALUES ('26', 'admin/Sys/paysys', '支付配置', '1', '1', '0', '', '', '2', '3', '35', '1447231369');
INSERT INTO `x_auth_rule` VALUES ('27', 'admin/Member', '会员管理', '1', '1', '0', 'fa-users', '', '0', '1', '5', '1447231507');
INSERT INTO `x_auth_rule` VALUES ('28', 'admin/Plug', '扩展管理', '1', '1', '0', 'fa-cubes', '', '0', '1', '90', '1447231590');
INSERT INTO `x_auth_rule` VALUES ('239', 'admin/Sys/logsys', '日志显示', '1', '0', '0', '', '', '228', '4', '10', '1482844815');
INSERT INTO `x_auth_rule` VALUES ('30', 'admin/Member/member_score', '积分管理', '1', '0', '0', '', '', '27', '2', '30', '1447232133');
INSERT INTO `x_auth_rule` VALUES ('31', 'admin/Plug/plug_link_list', '友情链接', '1', '1', '0', '', '', '28', '2', '10', '1447232183');
INSERT INTO `x_auth_rule` VALUES ('32', 'admin/Plug/plug_link_list', '链接列表', '1', '1', '0', '', '', '31', '3', '10', '1447639935');
INSERT INTO `x_auth_rule` VALUES ('129', 'admin/Plug/plug_link_del', '删除操作', '1', '0', '0', '', '', '32', '4', '20', '1460345954');
INSERT INTO `x_auth_rule` VALUES ('34', 'admin/Plug/plug_linktype_list', '所属栏目', '1', '1', '0', '', '', '31', '3', '20', '1447640839');
INSERT INTO `x_auth_rule` VALUES ('35', 'wechat/We', '微信基本功能', '1', '1', '0', 'fa-weixin', '', '0', '1', '80', '1447842435');
INSERT INTO `x_auth_rule` VALUES ('44', 'admin/Plug/plug_ad_list', '广告管理', '1', '1', '0', '', '', '28', '2', '20', '1450314265');
INSERT INTO `x_auth_rule` VALUES ('37', 'admin/Member/member_list', '会员列表', '1', '1', '0', '', '', '27', '2', '10', '1448413219');
INSERT INTO `x_auth_rule` VALUES ('38', 'admin/Member/member_group_list', '会员组', '1', '1', '0', '', '', '27', '2', '20', '1448413248');
INSERT INTO `x_auth_rule` VALUES ('39', 'wechat/We/menu_list', '菜单管理', '1', '1', '0', '', '', '35', '2', '10', '1448501584');
INSERT INTO `x_auth_rule` VALUES ('40', 'admin/Sys/excel_export', 'Excel导入/导出', '1', '1', '0', '', '', '1', '2', '40', '1448613588');
INSERT INTO `x_auth_rule` VALUES ('41', 'admin/Sys/excel_import', 'Excel导入', '1', '1', '0', '', '', '40', '3', '20', '1448613614');
INSERT INTO `x_auth_rule` VALUES ('42', 'admin/Sys/excel_export', 'Excel导出', '1', '1', '0', '', '', '40', '3', '10', '1448613651');
INSERT INTO `x_auth_rule` VALUES ('43', 'admin/Sys/source_list', '来源管理', '1', '1', '0', '', '', '28', '2', '5', '1448940532');
INSERT INTO `x_auth_rule` VALUES ('45', 'admin/Plug/plug_ad_list', '广告设置', '1', '1', '0', '', '', '44', '3', '10', '1450314297');
INSERT INTO `x_auth_rule` VALUES ('46', 'admin/Plug/plug_adtype_list', '广告位设置', '1', '1', '0', '', '', '44', '3', '20', '1450314324');
INSERT INTO `x_auth_rule` VALUES ('138', 'admin/Plug/plug_ad_runadd', '添加操作', '1', '0', '0', '', '', '45', '4', '15', '1460346513');
INSERT INTO `x_auth_rule` VALUES ('48', 'admin/Plug', '留言管理', '1', '1', '0', 'fa-book', '', '0', '1', '17', '1451267354');
INSERT INTO `x_auth_rule` VALUES ('49', 'admin/Plug/plug_sug_list', '留言列表', '1', '1', '0', '', '', '48', '2', '10', '1451267369');
INSERT INTO `x_auth_rule` VALUES ('51', 'wechat/We/we_datum_tp', '图文素材', '1', '0', '0', '', '', '50', '3', '50', '1453255857');
INSERT INTO `x_auth_rule` VALUES ('52', 'wechat/We/we_datum_pic', '图片', '1', '0', '0', '', '', '50', '3', '50', '1453255922');
INSERT INTO `x_auth_rule` VALUES ('53', 'wechat/We/we_datum_voice', '语音', '1', '0', '0', '', '', '50', '3', '50', '1453255953');
INSERT INTO `x_auth_rule` VALUES ('54', 'wechat/We/we_datum_video', '视频', '1', '0', '0', '', '', '50', '3', '50', '1453255995');
INSERT INTO `x_auth_rule` VALUES ('55', 'admin/Admin/admin_group_runadd', '添加操作', '1', '0', '0', '', '', '17', '3', '15', '1460110505');
INSERT INTO `x_auth_rule` VALUES ('56', 'admin/Admin/admin_group_del', '删除操作', '1', '0', '0', '', '', '17', '3', '20', '1460110551');
INSERT INTO `x_auth_rule` VALUES ('68', 'admin/Admin/admin_add', '添加显示', '1', '0', '0', '', '', '16', '3', '15', '1460301646');
INSERT INTO `x_auth_rule` VALUES ('85', 'admin/Sys/export', '备份多表', '1', '0', '0', '', '', '5', '4', '15', '1460302396');
INSERT INTO `x_auth_rule` VALUES ('57', 'admin/Sys/activesys', '帐号激活', '1', '1', '0', '', '', '2', '3', '30', '1460299219');
INSERT INTO `x_auth_rule` VALUES ('60', 'admin/Sys/runemail', '保存操作', '1', '0', '0', '', '', '19', '4', '20', '1460299500');
INSERT INTO `x_auth_rule` VALUES ('59', 'admin/Sys/runsys', '编辑操作', '1', '0', '0', '', '', '6', '4', '20', '1460299338');
INSERT INTO `x_auth_rule` VALUES ('61', 'admin/Sys/runactive', '编辑操作', '1', '0', '0', '', '', '57', '4', '20', '1460299563');
INSERT INTO `x_auth_rule` VALUES ('62', 'wechat/We/runwesys', '编辑操作', '1', '0', '0', '', '', '10', '4', '20', '1460299610');
INSERT INTO `x_auth_rule` VALUES ('63', 'admin/Sys/source_runadd', '添加操作', '1', '0', '0', '', '', '43', '3', '20', '1460299680');
INSERT INTO `x_auth_rule` VALUES ('64', 'admin/Sys/source_del', '删除操作', '1', '0', '0', '', '', '43', '3', '20', '1460299709');
INSERT INTO `x_auth_rule` VALUES ('65', 'admin/Sys/source_edit', '编辑显示', '1', '0', '0', '', '', '43', '3', '30', '1460299760');
INSERT INTO `x_auth_rule` VALUES ('66', 'admin/Sys/source_runedit', '编辑操作', '1', '0', '0', '', '', '43', '3', '40', '1460299803');
INSERT INTO `x_auth_rule` VALUES ('67', 'admin/Sys/source_order', '排序操作', '1', '0', '0', '', '', '43', '3', '50', '1460299827');
INSERT INTO `x_auth_rule` VALUES ('69', 'admin/Admin/admin_runadd', '添加操作', '1', '0', '0', '', '', '16', '3', '20', '1460301671');
INSERT INTO `x_auth_rule` VALUES ('70', 'admin/Admin/admin_edit', '编辑显示', '1', '0', '0', '', '', '16', '3', '30', '1460301711');
INSERT INTO `x_auth_rule` VALUES ('71', 'admin/Admin/admin_runedit', '编辑操作', '1', '0', '0', '', '', '16', '3', '40', '1460301751');
INSERT INTO `x_auth_rule` VALUES ('72', 'admin/Admin/admin_del', '删除操作', '1', '0', '0', '', '', '16', '3', '50', '1460301774');
INSERT INTO `x_auth_rule` VALUES ('73', 'admin/Admin/admin_state', '状态操作', '1', '0', '0', '', '', '16', '3', '60', '1460301806');
INSERT INTO `x_auth_rule` VALUES ('74', 'admin/Admin/admin_group_edit', '编辑显示', '1', '0', '0', '', '', '17', '3', '30', '1460301956');
INSERT INTO `x_auth_rule` VALUES ('75', 'admin/Admin/admin_group_runedit', '编辑操作', '1', '0', '0', '', '', '17', '3', '40', '1460301980');
INSERT INTO `x_auth_rule` VALUES ('76', 'admin/Admin/admin_group_state', '状态操作', '1', '0', '0', '', '', '17', '3', '50', '1460302008');
INSERT INTO `x_auth_rule` VALUES ('77', 'admin/Admin/admin_group_access', '权限配置', '1', '0', '0', '', '', '17', '3', '60', '1460302033');
INSERT INTO `x_auth_rule` VALUES ('78', 'admin/Admin/admin_group_runaccess', '权限配置操作', '1', '0', '0', '', '', '17', '3', '70', '1460302062');
INSERT INTO `x_auth_rule` VALUES ('79', 'admin/Sys/admin_rule_runadd', '添加操作', '1', '0', '0', '', '', '158', '3', '15', '1460302177');
INSERT INTO `x_auth_rule` VALUES ('80', 'admin/Sys/admin_rule_state', '状态操作', '1', '0', '0', '', '', '158', '3', '20', '1460302201');
INSERT INTO `x_auth_rule` VALUES ('81', 'admin/Sys/admin_rule_order', '排序操作', '1', '0', '0', '', '', '158', '3', '30', '1460302223');
INSERT INTO `x_auth_rule` VALUES ('82', 'admin/Sys/admin_rule_edit', '编辑显示', '1', '0', '0', '', '', '158', '3', '40', '1460302247');
INSERT INTO `x_auth_rule` VALUES ('83', 'admin/Sys/admin_rule_runedit', '编辑操作', '1', '0', '0', '', '', '158', '3', '50', '1460302266');
INSERT INTO `x_auth_rule` VALUES ('84', 'admin/Sys/admin_rule_del', '删除操作', '1', '0', '0', '', '', '158', '3', '60', '1460302287');
INSERT INTO `x_auth_rule` VALUES ('86', 'admin/Sys/exportsql', '备份单表', '1', '0', '0', '', '', '5', '4', '20', '1460302429');
INSERT INTO `x_auth_rule` VALUES ('87', 'admin/Sys/repair', '修复表', '1', '0', '0', '', '', '5', '4', '30', '1460302464');
INSERT INTO `x_auth_rule` VALUES ('88', 'admin/Sys/optimize', '优化表', '1', '0', '0', '', '', '5', '4', '40', '1460302487');
INSERT INTO `x_auth_rule` VALUES ('89', 'admin/Sys/del', '删除操作', '1', '0', '0', '', '', '4', '4', '15', '1460302516');
INSERT INTO `x_auth_rule` VALUES ('90', 'admin/Sys/restore', '还原操作', '1', '0', '0', '', '', '4', '4', '20', '1460302545');
INSERT INTO `x_auth_rule` VALUES ('91', 'admin/Sys/excel_runexport', '导出操作', '1', '0', '0', '', '', '42', '4', '15', '1460302639');
INSERT INTO `x_auth_rule` VALUES ('92', 'admin/Sys/excel_runimport', '导入操作', '1', '0', '0', '', '', '41', '4', '15', '1460302665');
INSERT INTO `x_auth_rule` VALUES ('93', 'admin/News/news_runadd', '添加操作', '1', '0', '0', '', '', '12', '3', '15', '1460335746');
INSERT INTO `x_auth_rule` VALUES ('94', 'admin/News/news_edit', '编辑显示', '1', '0', '0', '', '', '11', '3', '15', '1460335887');
INSERT INTO `x_auth_rule` VALUES ('95', 'admin/News/news_runedit', '编辑操作', '1', '0', '0', '', '', '11', '3', '20', '1460335925');
INSERT INTO `x_auth_rule` VALUES ('96', 'admin/News/news_del', '删到回收站', '1', '0', '0', '', '', '11', '3', '30', '1460335982');
INSERT INTO `x_auth_rule` VALUES ('97', 'admin/News/news_back_open', '还原', '1', '0', '0', '', '', '25', '3', '15', '1460336269');
INSERT INTO `x_auth_rule` VALUES ('98', 'admin/News/news_back_del', '删除操作', '1', '0', '0', '', '', '25', '3', '20', '1460341080');
INSERT INTO `x_auth_rule` VALUES ('99', 'admin/News/news_back_alldel', '删除全部', '1', '0', '0', '', '', '25', '3', '30', '1460341109');
INSERT INTO `x_auth_rule` VALUES ('100', 'admin/News/news_alldel', '删除全部', '1', '0', '0', '', '', '11', '3', '40', '1460341178');
INSERT INTO `x_auth_rule` VALUES ('101', 'admin/News/news_state', '状态操作', '1', '0', '0', '', '', '11', '3', '50', '1460341216');
INSERT INTO `x_auth_rule` VALUES ('102', 'admin/Menu/news_menu_runadd', '添加操作', '1', '0', '0', '', '', '14', '3', '15', '1460341752');
INSERT INTO `x_auth_rule` VALUES ('103', 'admin/Menu/news_menu_del', '删除操作', '1', '0', '0', '', '', '13', '3', '15', '1460341796');
INSERT INTO `x_auth_rule` VALUES ('104', 'admin/Menu/news_menu_order', '排序操作', '1', '0', '0', '', '', '13', '3', '20', '1460341845');
INSERT INTO `x_auth_rule` VALUES ('105', 'admin/Menu/news_menu_edit', '编辑显示', '1', '0', '0', '', '', '13', '3', '30', '1460341972');
INSERT INTO `x_auth_rule` VALUES ('106', 'admin/Menu/news_menu_runedit', '编辑操作', '1', '0', '0', '', '', '13', '3', '40', '1460342057');
INSERT INTO `x_auth_rule` VALUES ('107', 'admin/Menu/news_menu_state', '状态操作', '1', '0', '0', '', '', '13', '3', '50', '1460342099');
INSERT INTO `x_auth_rule` VALUES ('108', 'admin/Member/member_add', '添加显示', '1', '0', '0', '', '', '37', '3', '15', '1460343493');
INSERT INTO `x_auth_rule` VALUES ('109', 'admin/Member/member_runadd', '添加操作', '1', '0', '0', '', '', '37', '3', '20', '1460343550');
INSERT INTO `x_auth_rule` VALUES ('110', 'admin/Member/member_edit', '编辑显示', '1', '0', '0', '', '', '37', '3', '30', '1460343589');
INSERT INTO `x_auth_rule` VALUES ('111', 'admin/Member/member_runedit', '编辑操作', '1', '0', '0', '', '', '37', '3', '40', '1460343773');
INSERT INTO `x_auth_rule` VALUES ('112', 'admin/Member/member_state', '排序操作', '1', '0', '0', '', '', '37', '3', '50', '1460343804');
INSERT INTO `x_auth_rule` VALUES ('113', 'admin/Member/member_del', '删除操作', '1', '0', '0', '', '', '37', '3', '60', '1460343932');
INSERT INTO `x_auth_rule` VALUES ('114', 'admin/Member/member_userpic', '头像上传', '1', '0', '0', '', '', '37', '3', '70', '1460344029');
INSERT INTO `x_auth_rule` VALUES ('115', 'admin/Member/member_group_runadd', '添加操作', '1', '0', '0', '', '', '38', '3', '15', '1460344133');
INSERT INTO `x_auth_rule` VALUES ('116', 'admin/Member/member_group_del', '删除操作', '1', '0', '0', '', '', '38', '3', '20', '1460344158');
INSERT INTO `x_auth_rule` VALUES ('117', 'admin/Member/member_group_state', '状态操作', '1', '0', '0', '', '', '38', '3', '30', '1460344212');
INSERT INTO `x_auth_rule` VALUES ('118', 'admin/Member/member_group_order', '排序操作', '1', '0', '0', '', '', '38', '3', '40', '1460344255');
INSERT INTO `x_auth_rule` VALUES ('119', 'admin/Member/member_group_edit', '编辑显示', '1', '0', '0', '', '', '38', '3', '50', '1460344294');
INSERT INTO `x_auth_rule` VALUES ('120', 'admin/Member/member_group_runedit', '编辑操作', '1', '0', '0', '', '', '38', '3', '60', '1460344347');
INSERT INTO `x_auth_rule` VALUES ('121', 'wechat/We/menu_runadd', '添加操作', '1', '0', '0', '', '', '39', '3', '15', '1460345046');
INSERT INTO `x_auth_rule` VALUES ('122', 'wechat/We/menu_state', '状态操作', '1', '0', '0', '', '', '39', '3', '20', '1460345151');
INSERT INTO `x_auth_rule` VALUES ('123', 'wechat/We/menu_order', '排序操作', '1', '0', '0', '', '', '39', '3', '30', '1460345176');
INSERT INTO `x_auth_rule` VALUES ('124', 'wechat/We/menu_edit', '编辑显示', '1', '0', '0', '', '', '39', '3', '40', '1460345280');
INSERT INTO `x_auth_rule` VALUES ('125', 'wechat/We/menu_runedit', '编辑操作', '1', '0', '0', '', '', '39', '3', '50', '1460345306');
INSERT INTO `x_auth_rule` VALUES ('126', 'wechat/We/menu_del', '删除操作', '1', '0', '0', '', '', '39', '3', '60', '1460345332');
INSERT INTO `x_auth_rule` VALUES ('127', 'wechat/We/menu_make', '生成菜单', '1', '0', '0', '', '', '39', '3', '70', '1460345377');
INSERT INTO `x_auth_rule` VALUES ('128', 'admin/Plug/plug_link_runadd', '添加操作', '1', '0', '0', '', '', '32', '4', '15', '1460345848');
INSERT INTO `x_auth_rule` VALUES ('130', 'admin/Plug/plug_link_state', '状态操作', '1', '0', '0', '', '', '32', '4', '30', '1460345976');
INSERT INTO `x_auth_rule` VALUES ('131', 'admin/Plug/plug_link_edit', '编辑显示', '1', '0', '0', '', '', '32', '4', '40', '1460345999');
INSERT INTO `x_auth_rule` VALUES ('132', 'admin/Plug/plug_link_runedit', '编辑操作', '1', '0', '0', '', '', '32', '4', '50', '1460346017');
INSERT INTO `x_auth_rule` VALUES ('133', 'admin/Plug/plug_linktype_del', '删除操作', '1', '0', '0', '', '', '34', '4', '15', '1460346077');
INSERT INTO `x_auth_rule` VALUES ('134', 'admin/Plug/plug_linktype_runadd', '添加操作', '1', '0', '0', '', '', '34', '4', '20', '1460346115');
INSERT INTO `x_auth_rule` VALUES ('135', 'admin/Plug/plug_linktype_runedit', '编辑操作', '1', '0', '0', '', '', '34', '4', '30', '1460346171');
INSERT INTO `x_auth_rule` VALUES ('136', 'admin/Plug/plug_linktype_order', '排序操作', '1', '0', '0', '', '', '34', '4', '40', '1460346207');
INSERT INTO `x_auth_rule` VALUES ('137', 'admin/Plug/plug_sug_edit', '编辑显示', '1', '0', '0', '', '', '48', '2', '15', '1460346468');
INSERT INTO `x_auth_rule` VALUES ('139', 'admin/Plug/plug_ad_del', '删除操作', '1', '0', '0', '', '', '45', '4', '20', '1460346533');
INSERT INTO `x_auth_rule` VALUES ('140', 'admin/Plug/plug_ad_order', '排序操作', '1', '0', '0', '', '', '45', '4', '30', '1460346549');
INSERT INTO `x_auth_rule` VALUES ('141', 'admin/Plug/plug_ad_state', '状态操作', '1', '0', '0', '', '', '45', '4', '40', '1460346571');
INSERT INTO `x_auth_rule` VALUES ('142', 'admin/Plug/plug_ad_edit', '编辑显示', '1', '0', '0', '', '', '45', '4', '50', '1460346593');
INSERT INTO `x_auth_rule` VALUES ('143', 'admin/Plug/plug_ad_runedit', '编辑操作', '1', '0', '0', '', '', '45', '4', '60', '1460346610');
INSERT INTO `x_auth_rule` VALUES ('144', 'admin/Plug/plug_adtype_runadd', '添加操作', '1', '0', '0', '', '', '46', '4', '15', '1460346640');
INSERT INTO `x_auth_rule` VALUES ('145', 'admin/Plug/plug_adtype_edit', '编辑显示', '1', '0', '0', '', '', '46', '4', '20', '1460346659');
INSERT INTO `x_auth_rule` VALUES ('146', 'admin/Plug/plug_adtype_runedit', '编辑操作', '1', '0', '0', '', '', '46', '4', '30', '1460346680');
INSERT INTO `x_auth_rule` VALUES ('147', 'admin/Plug/plug_adtype_del', '删除操作', '1', '0', '0', '', '', '46', '4', '40', '1460346700');
INSERT INTO `x_auth_rule` VALUES ('148', 'admin/Plug/plug_adtype_order', '排序操作', '1', '0', '0', '', '', '46', '4', '50', '1460346717');
INSERT INTO `x_auth_rule` VALUES ('151', 'admin/Sys/sys', '设置显示', '1', '0', '0', '', '', '6', '4', '10', '1460367871');
INSERT INTO `x_auth_rule` VALUES ('152', 'admin/Sys/emailsys', '设置显示', '1', '0', '0', '', '', '19', '4', '10', '1460367909');
INSERT INTO `x_auth_rule` VALUES ('153', 'admin/Sys/activesys', '设置显示', '1', '0', '0', '', '', '57', '4', '10', '1460368054');
INSERT INTO `x_auth_rule` VALUES ('154', 'wechat/We/wesys', '设置显示', '1', '0', '0', '', '', '10', '4', '10', '1460368073');
INSERT INTO `x_auth_rule` VALUES ('155', 'admin/Sys/source_list', '来源列表', '1', '0', '0', '', '', '43', '3', '10', '1460368118');
INSERT INTO `x_auth_rule` VALUES ('156', 'admin/Admin/admin_list', '列表显示', '1', '0', '0', '', '', '16', '3', '10', '1460368235');
INSERT INTO `x_auth_rule` VALUES ('157', 'admin/Admin/admin_group_list', '列表显示', '1', '0', '0', '', '', '17', '3', '10', '1460368277');
INSERT INTO `x_auth_rule` VALUES ('158', 'admin/Sys/admin_rule_list', '菜单列表', '1', '1', '0', '', '', '18', '2', '10', '1460368308');
INSERT INTO `x_auth_rule` VALUES ('159', 'admin/Sys/import', '还原列表', '1', '0', '0', '', '', '4', '4', '10', '1460368413');
INSERT INTO `x_auth_rule` VALUES ('160', 'admin/Sys/database', '备份列表', '1', '0', '0', '', '', '5', '4', '10', '1460368442');
INSERT INTO `x_auth_rule` VALUES ('161', 'admin/Sys/excel_export', '导出显示', '1', '0', '0', '', '', '42', '4', '10', '1460368467');
INSERT INTO `x_auth_rule` VALUES ('162', 'admin/Sys/excel_import', '导入显示', '1', '0', '0', '', '', '41', '4', '10', '1460368482');
INSERT INTO `x_auth_rule` VALUES ('187', 'admin/Comment/comment_setting', '评论设置', '1', '1', '0', '', '', '185', '2', '20', '1463305710');
INSERT INTO `x_auth_rule` VALUES ('164', 'admin/Plug/plug_adtype_list', '列表显示', '1', '0', '0', '', '', '46', '4', '10', '1460368616');
INSERT INTO `x_auth_rule` VALUES ('165', 'admin/Plug/plug_ad_list', '列表显示', '1', '0', '0', '', '', '45', '4', '10', '1460368637');
INSERT INTO `x_auth_rule` VALUES ('166', 'admin/Plug/plug_linktype_list', '列表显示', '1', '0', '0', '', '', '34', '4', '10', '1460368656');
INSERT INTO `x_auth_rule` VALUES ('167', 'admin/Plug/plug_link_list', '列表显示', '1', '0', '0', '', '', '32', '4', '10', '1460368676');
INSERT INTO `x_auth_rule` VALUES ('168', 'wechat/We/menu_list', '列表显示', '1', '0', '0', '', '', '39', '3', '10', '1460368744');
INSERT INTO `x_auth_rule` VALUES ('169', 'admin/Member/member_group_list', '列表显示', '1', '0', '0', '', '', '38', '3', '10', '1460368780');
INSERT INTO `x_auth_rule` VALUES ('170', 'admin/Member/member_list', '列表显示', '1', '0', '0', '', '', '37', '3', '10', '1460368804');
INSERT INTO `x_auth_rule` VALUES ('171', 'admin/Menu/news_menu_add', '添加显示', '1', '0', '0', '', '', '14', '3', '10', '1460369022');
INSERT INTO `x_auth_rule` VALUES ('172', 'admin/Menu/news_menu_list', '列表显示', '1', '0', '0', '', '', '13', '3', '10', '1460369062');
INSERT INTO `x_auth_rule` VALUES ('173', 'admin/News/news_back', '列表显示', '1', '0', '0', '', '', '25', '3', '10', '1460369095');
INSERT INTO `x_auth_rule` VALUES ('174', 'admin/News/news_add', '添加显示', '1', '0', '0', '', '', '12', '3', '10', '1460369128');
INSERT INTO `x_auth_rule` VALUES ('175', 'admin/News/news_list', '列表显示', '1', '0', '0', '', '', '11', '3', '10', '1460369158');
INSERT INTO `x_auth_rule` VALUES ('176', 'admin/Admin/admin_group_add', '添加显示', '1', '0', '0', '', '', '17', '3', '15', '1460461365');
INSERT INTO `x_auth_rule` VALUES ('177', 'admin/Sys/admin_rule_copy', '复制显示', '1', '0', '0', '', '', '158', '3', '40', '1460461557');
INSERT INTO `x_auth_rule` VALUES ('178', 'admin/Admin/profile', '个人中心', '1', '1', '0', '', '', '15', '2', '90', '1461395663');
INSERT INTO `x_auth_rule` VALUES ('179', 'admin/Admin/profile', '信息显示', '1', '0', '0', '', '', '178', '3', '10', '1461395702');
INSERT INTO `x_auth_rule` VALUES ('180', 'admin/Admin/avatar', '头像编辑', '1', '0', '0', '', '', '178', '3', '10', '1461395790');
INSERT INTO `x_auth_rule` VALUES ('181', 'admin/Plug/plug_file_list', '本地文件管理', '1', '1', '0', '', '', '28', '2', '40', '1461810174');
INSERT INTO `x_auth_rule` VALUES ('182', 'admin/Plug/plug_file_list', '文件列表', '1', '1', '0', '', '', '181', '3', '10', '1461810218');
INSERT INTO `x_auth_rule` VALUES ('183', 'admin/Plug/plug_file_filter', '文件清理', '1', '1', '0', '', '', '181', '3', '20', '1461810273');
INSERT INTO `x_auth_rule` VALUES ('184', 'admin/Sys/oauthsys', '第三方登录', '1', '1', '0', '', '', '2', '3', '40', '1463045567');
INSERT INTO `x_auth_rule` VALUES ('185', 'admin/Comment', '评论管理', '1', '1', '0', 'fa-comment', '', '0', '1', '15', '1463305461');
INSERT INTO `x_auth_rule` VALUES ('186', 'admin/Comment/comment_list', '评论列表', '1', '1', '0', '', '', '185', '2', '10', '1463305496');
INSERT INTO `x_auth_rule` VALUES ('190', 'admin/Sys/urlsetsys', 'URL设置', '1', '1', '0', '', '', '2', '3', '15', '1464341076');
INSERT INTO `x_auth_rule` VALUES ('202', 'admin/Sys/storagesys', '七牛云存储', '1', '1', '0', '', '', '2', '3', '50', '1481536058');
INSERT INTO `x_auth_rule` VALUES ('203', 'admin/Sys/runstorage', '保存设置', '1', '0', '0', '', '', '202', '4', '50', '1481536129');
INSERT INTO `x_auth_rule` VALUES ('204', 'admin/Sys/storagesys', '七牛云存储', '1', '0', '0', '', '', '202', '4', '50', '1481536149');
INSERT INTO `x_auth_rule` VALUES ('206', 'admin/Model', '模型管理', '1', '1', '0', 'fa fa-list', '', '0', '1', '11', '1482139134');
INSERT INTO `x_auth_rule` VALUES ('207', 'admin/Model/model_list', '模型列表', '1', '1', '0', '', '', '206', '2', '10', '1482139166');
INSERT INTO `x_auth_rule` VALUES ('208', 'admin/Model/model_add', '增加模型', '1', '1', '0', '', '', '206', '2', '20', '1482139191');
INSERT INTO `x_auth_rule` VALUES ('209', 'admin/Model/model_runadd', '增加操作', '1', '0', '0', '', '', '208', '3', '10', '1482139219');
INSERT INTO `x_auth_rule` VALUES ('210', 'admin/Sys/langsys', '多语言设置', '1', '1', '0', '', '', '2', '3', '13', '1482229864');
INSERT INTO `x_auth_rule` VALUES ('211', 'admin/Sys/runlangsys', '多语言设置', '1', '0', '0', '', '', '210', '4', '50', '1482229896');
INSERT INTO `x_auth_rule` VALUES ('212', 'admin/Model', '测试模型管理', '1', '1', '0', 'fa fa-list', '', '28', '2', '35', '1482402595');
INSERT INTO `x_auth_rule` VALUES ('213', 'admin/Model/cmslist?id=1', '模型列表', '1', '1', '0', '', '', '212', '3', '10', '1482402646');
INSERT INTO `x_auth_rule` VALUES ('214', 'admin/Model/cmsedit', '编辑模型', '1', '0', '0', '', '', '213', '4', '10', '1482403110');
INSERT INTO `x_auth_rule` VALUES ('215', 'admin/Model/cmsadd?id=1', '增加测试模型', '1', '1', '0', '', '', '212', '3', '20', '1482403160');
INSERT INTO `x_auth_rule` VALUES ('216', 'admin/Model/model_edit', '编辑模型', '1', '0', '0', '', '', '207', '3', '20', '1482485417');
INSERT INTO `x_auth_rule` VALUES ('228', 'admin/Sys/logsys', '日志设置', '1', '1', '0', '', '', '2', '3', '12', '1482635360');
INSERT INTO `x_auth_rule` VALUES ('240', 'admin/Sys/runlogsys', '保存操作', '1', '0', '0', '', '', '228', '4', '20', '1482844844');
INSERT INTO `x_auth_rule` VALUES ('241', 'admin/Sys/langsys', '设置显示', '1', '0', '0', '', '', '210', '4', '10', '1482844882');
INSERT INTO `x_auth_rule` VALUES ('242', 'admin/Sys/urlsys', '设置显示', '1', '0', '0', '', '', '190', '4', '10', '1482844916');
INSERT INTO `x_auth_rule` VALUES ('243', 'admin/Sys/runurlsys', '保存操作', '1', '0', '0', '', '', '190', '4', '20', '1482844970');
INSERT INTO `x_auth_rule` VALUES ('244', 'admin/Sys/oauthsys', '设置显示', '1', '0', '0', '', '', '184', '4', '10', '1482845029');
INSERT INTO `x_auth_rule` VALUES ('245', 'admin/Sys/runoauthsys', '设置显示', '1', '0', '0', '', '', '184', '4', '20', '1482845048');
INSERT INTO `x_auth_rule` VALUES ('246', 'admin/Model/model_runedit', '编辑操作', '1', '0', '0', '', '', '207', '3', '20', '1482845641');
INSERT INTO `x_auth_rule` VALUES ('247', 'admin/Model/model_state', '状态操作', '1', '0', '0', '', '', '207', '3', '20', '1482845675');
INSERT INTO `x_auth_rule` VALUES ('248', 'admin/Model/model_copy', '模型复制', '1', '0', '0', '', '', '207', '3', '20', '1482845725');
INSERT INTO `x_auth_rule` VALUES ('249', 'admin/Model/model_del', '删除操作', '1', '0', '0', '', '', '207', '3', '20', '1482845749');
INSERT INTO `x_auth_rule` VALUES ('250', 'admin/Model/model_addmenu', '添加菜单', '1', '0', '0', '', '', '207', '3', '20', '1482845848');
INSERT INTO `x_auth_rule` VALUES ('251', 'admin/Model/model_add', '增加显示', '1', '0', '0', '', '', '208', '3', '10', '1482845873');
INSERT INTO `x_auth_rule` VALUES ('252', 'admin/Comment/comment_del', '删除操作', '1', '0', '0', '', '', '186', '3', '50', '1482846045');
INSERT INTO `x_auth_rule` VALUES ('253', 'admin/Comment/comment_alldel', '全部删除', '1', '0', '0', '', '', '186', '3', '50', '1482846076');
INSERT INTO `x_auth_rule` VALUES ('254', 'admin/Comment/comment_state', '状态操作', '1', '0', '0', '', '', '186', '3', '50', '1482846099');
INSERT INTO `x_auth_rule` VALUES ('255', 'admin/Comment/comment_setting', '设置显示', '1', '0', '0', '', '', '187', '3', '50', '1482846131');
INSERT INTO `x_auth_rule` VALUES ('256', 'admin/Comment/runcsys', '保存操作', '1', '0', '0', '', '', '187', '3', '50', '1482846152');
INSERT INTO `x_auth_rule` VALUES ('257', 'admin/Plug/plug_sug_reply', '留言回复', '1', '0', '0', '', '', '49', '3', '50', '1482846205');
INSERT INTO `x_auth_rule` VALUES ('258', 'admin/Plug/plug_sug_runreply', '回复操作', '1', '0', '0', '', '', '49', '3', '50', '1482846233');
INSERT INTO `x_auth_rule` VALUES ('259', 'admin/Plug/plug_sug_del', '删除操作', '1', '0', '0', '', '', '49', '3', '50', '1482846259');
INSERT INTO `x_auth_rule` VALUES ('260', 'admin/Plug/plug_sug_alldel', '全部删除', '1', '0', '0', '', '', '49', '3', '50', '1482846279');
INSERT INTO `x_auth_rule` VALUES ('261', 'admin/Model/cmsrunedit', '编辑操作', '1', '0', '0', '', '', '213', '4', '10', '1482846345');
INSERT INTO `x_auth_rule` VALUES ('262', 'admin/Model/cmsalldel', '全部删除', '1', '0', '0', '', '', '213', '4', '10', '1482846373');
INSERT INTO `x_auth_rule` VALUES ('263', 'admin/Model/cmsdel', '删除操作', '1', '0', '0', '', '', '213', '4', '10', '1482846402');
INSERT INTO `x_auth_rule` VALUES ('264', 'admin/Model/cmsstate', '状态操作', '1', '0', '0', '', '', '213', '4', '10', '1482846428');
INSERT INTO `x_auth_rule` VALUES ('265', 'admin/Model/cmsorder', '排序操作', '1', '0', '0', '', '', '213', '4', '10', '1482846448');
INSERT INTO `x_auth_rule` VALUES ('266', 'admin/Model', '常见问题', '1', '1', '0', 'fa-question-circle', '', '28', '2', '50', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('267', 'admin/Model/cmsadd?id=2', '增加常见问题', '1', '1', '0', '', '', '266', '3', '20', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('268', 'admin/cmsrunadd', '增加操作', '1', '0', '0', '', '', '267', '4', '10', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('269', 'admin/Model/cmslist?id=2', '常见问题列表', '1', '1', '0', '', '', '266', '3', '10', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('270', 'admin/Model/cmsdel', '删除操作', '1', '0', '0', '', '', '269', '4', '0', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('271', 'admin/Model/cmsstate', '状态操作', '1', '0', '0', '', '', '269', '4', '0', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('272', 'admin/Model/cmsorder', '排序操作', '1', '0', '0', '', '', '269', '4', '0', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('273', 'admin/Model/cmsalldel', '全部删除', '1', '0', '0', '', '', '269', '4', '0', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('274', 'admin/Model/cmsedit', '编辑显示', '1', '0', '0', '', '', '269', '4', '0', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('275', 'admin/Model/cmsrunedit', '编辑操作', '1', '0', '0', '', '', '269', '4', '0', '1482821140');
INSERT INTO `x_auth_rule` VALUES ('276', 'admin/WebLog', '操作日志', '1', '1', '0', 'fa-tasks', '', '0', '1', '19', '1483091169');
INSERT INTO `x_auth_rule` VALUES ('277', 'admin/WebLog/weblog_list', '操作日志列表', '1', '1', '0', '', '', '276', '2', '10', '1483091198');
INSERT INTO `x_auth_rule` VALUES ('278', 'admin/WebLog/weblog_setting', '操作日志设置', '1', '1', '0', '', '', '276', '2', '20', '1483091220');
INSERT INTO `x_auth_rule` VALUES ('279', 'admin/Sys/paysys', '设置显示', '1', '0', '0', '', '', '26', '4', '10', '1483325524');
INSERT INTO `x_auth_rule` VALUES ('280', 'admin/Sys/runpaysys', '设置操作', '1', '0', '0', '', '', '26', '4', '20', '1483325553');
INSERT INTO `x_auth_rule` VALUES ('281', 'admin/Sys/smssys', '短信设置', '1', '1', '0', '', '', '2', '3', '33', '1483327040');
INSERT INTO `x_auth_rule` VALUES ('282', 'admin/Sys/smssys', '设置显示', '1', '0', '0', '', '', '281', '4', '10', '1483327064');
INSERT INTO `x_auth_rule` VALUES ('283', 'admin/Sys/runsmssys', '设置操作', '1', '0', '0', '', '', '281', '4', '20', '1483327089');
INSERT INTO `x_auth_rule` VALUES ('294', 'wechat/We/reply_list', '自动回复', '1', '1', '0', '', '', '35', '2', '20', '1483616060');
INSERT INTO `x_auth_rule` VALUES ('295', 'wechat/We/mats_list', '素材管理', '1', '1', '0', '', '', '35', '2', '30', '1483617538');
INSERT INTO `x_auth_rule` VALUES ('296', 'wechat/We/menu_get', '同步菜单', '1', '0', '0', '', '', '39', '3', '80', '1483789025');
INSERT INTO `x_auth_rule` VALUES ('297', 'wechat/We/reply_list', '回复列表', '1', '0', '0', '', '', '294', '3', '10', '1483789065');
INSERT INTO `x_auth_rule` VALUES ('298', 'wechat/We/reply_edit', '回复编辑', '1', '0', '0', '', '', '294', '3', '20', '1483789096');
INSERT INTO `x_auth_rule` VALUES ('299', 'wechat/We/reply_runedit', '编辑操作', '1', '0', '0', '', '', '294', '3', '30', '1483789123');
INSERT INTO `x_auth_rule` VALUES ('300', 'wechat/We/reply_runadd', '添加操作', '1', '0', '0', '', '', '294', '3', '40', '1483789149');
INSERT INTO `x_auth_rule` VALUES ('301', 'wechat/We/reply_state', '状态操作', '1', '0', '0', '', '', '294', '3', '50', '1483789174');
INSERT INTO `x_auth_rule` VALUES ('302', 'wechat/We/reply_alldel', '全部删除', '1', '0', '0', '', '', '294', '3', '60', '1483789197');
INSERT INTO `x_auth_rule` VALUES ('303', 'wechat/We/reply_del', '删除操作', '1', '0', '0', '', '', '294', '3', '70', '1483789219');
INSERT INTO `x_auth_rule` VALUES ('304', 'wechat/We/mats_list', '素材列表', '1', '0', '0', '', '', '295', '3', '10', '1483789249');
INSERT INTO `x_auth_rule` VALUES ('305', 'wechat/We/mats_get', '同步素材', '1', '0', '0', '', '', '295', '3', '20', '1483789271');
INSERT INTO `x_auth_rule` VALUES ('306', 'wechat/We/mats_edit', '编辑素材', '1', '0', '0', '', '', '295', '3', '30', '1483789295');
INSERT INTO `x_auth_rule` VALUES ('307', 'wechat/We/mats_runedit', '编辑操作', '1', '0', '0', '', '', '295', '3', '40', '1483789317');
INSERT INTO `x_auth_rule` VALUES ('308', 'wechat/We/mats_add', '增加显示', '1', '0', '0', 'fa-plug', '', '295', '3', '40', '1483789367');
INSERT INTO `x_auth_rule` VALUES ('309', 'wechat/We/mats_runadd', '增加操作', '1', '0', '0', 'fa-plug', '', '295', '3', '50', '1483789393');
INSERT INTO `x_auth_rule` VALUES ('310', 'wechat/We/mats_del', '删除操作', '1', '0', '0', 'fa-plug', '', '295', '3', '60', '1483789418');
INSERT INTO `x_auth_rule` VALUES ('311', 'wechat/We/mats_alldel', '全选删除', '1', '0', '0', 'fa-plug', '', '295', '3', '70', '1483789443');
INSERT INTO `x_auth_rule` VALUES ('312', 'admin/Model', '订单管理', '1', '1', '0', '', '', '28', '2', '50', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('313', 'admin/Model/cmsadd?id=3', '增加订单支付', '1', '1', '0', '', '', '312', '3', '20', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('314', 'admin/cmsrunadd', '增加操作', '1', '0', '0', '', '', '313', '4', '10', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('315', 'admin/Model/cmslist?id=3', '订单支付列表', '1', '1', '0', '', '', '312', '3', '10', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('316', 'admin/Model/cmsdel', '删除操作', '1', '0', '0', '', '', '315', '4', '0', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('317', 'admin/Model/cmsstate', '状态操作', '1', '0', '0', '', '', '315', '4', '0', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('318', 'admin/Model/cmsorder', '排序操作', '1', '0', '0', '', '', '315', '4', '0', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('319', 'admin/Model/cmsalldel', '全部删除', '1', '0', '0', '', '', '315', '4', '0', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('320', 'admin/Model/cmsedit', '编辑显示', '1', '0', '0', '', '', '315', '4', '0', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('321', 'admin/Model/cmsrunedit', '编辑操作', '1', '0', '0', '', '', '315', '4', '0', '1483867059');
INSERT INTO `x_auth_rule` VALUES ('325', 'admin/Addons', '插件管理', '1', '1', '0', 'fa-plug', '', '0', '1', '50', '1487422836');
INSERT INTO `x_auth_rule` VALUES ('326', 'admin/Addons/addons_list', '插件列表', '1', '1', '0', '', '', '325', '2', '10', '1487422893');

-- ----------------------------
-- Table structure for x_comments
-- ----------------------------
DROP TABLE IF EXISTS `x_comments`;
CREATE TABLE `x_comments` (
  `c_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `t_name` varchar(100) NOT NULL COMMENT '评论内容所在表，不带表前缀',
  `t_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `uid` int(11) DEFAULT '0' COMMENT '发表评论的用户id',
  `to_uid` int(11) DEFAULT '0' COMMENT '被评论的用户id',
  `full_name` varchar(50) DEFAULT NULL COMMENT '评论者昵称',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `createtime` int(11) NOT NULL DEFAULT '0' COMMENT '评论时间',
  `c_content` text NOT NULL COMMENT '评论内容',
  `c_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '评论类型；1用户评论 0游客评论',
  `parentid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `path` varchar(500) DEFAULT NULL COMMENT '层次',
  `c_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核',
  PRIMARY KEY (`c_id`),
  KEY `comment_post_ID` (`t_id`),
  KEY `comment_approved_date_gmt` (`c_status`),
  KEY `comment_parent` (`parentid`),
  KEY `table_id_status` (`t_name`,`t_id`,`c_status`),
  KEY `createtime` (`createtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of x_comments
-- ----------------------------

-- ----------------------------
-- Table structure for x_diyflag
-- ----------------------------
DROP TABLE IF EXISTS `x_diyflag`;
CREATE TABLE `x_diyflag` (
  `diyflag_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `diyflag_value` char(2) NOT NULL COMMENT '值',
  `diyflag_name` char(10) NOT NULL COMMENT '名称',
  `diyflag_order` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`diyflag_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_diyflag
-- ----------------------------
INSERT INTO `x_diyflag` VALUES ('1', 'h', '头条', '10');
INSERT INTO `x_diyflag` VALUES ('2', 'c', '推荐', '20');
INSERT INTO `x_diyflag` VALUES ('3', 'f', '幻灯', '30');
INSERT INTO `x_diyflag` VALUES ('4', 'a', '特荐', '40');
INSERT INTO `x_diyflag` VALUES ('5', 's', '滚动', '50');
INSERT INTO `x_diyflag` VALUES ('6', 'p', '图片', '60');
INSERT INTO `x_diyflag` VALUES ('7', 'j', '跳转', '70');
INSERT INTO `x_diyflag` VALUES ('8', 'd', '原创', '80');
INSERT INTO `x_diyflag` VALUES ('9', 'cp', '产品', '90');

-- ----------------------------
-- Table structure for x_faq
-- ----------------------------
DROP TABLE IF EXISTS `x_faq`;
CREATE TABLE `x_faq` (
  `faq_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `faq_title` varchar(200) NOT NULL DEFAULT '未填写' COMMENT '标题',
  `faq_answer` text COMMENT '答复',
  `faq_cid` varchar(100) NOT NULL DEFAULT '未填写' COMMENT '前台栏目',
  `faq_order` int(11) DEFAULT '50' COMMENT '排序',
  PRIMARY KEY (`faq_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_faq
-- ----------------------------
INSERT INTO `x_faq` VALUES ('1', 'Question 1', 'Question 1：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('2', 'Question 2', 'Question 2：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('3', 'Question 3', 'Question 3：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('4', 'Question 4', 'Question 4：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('5', 'Question 5', 'Question 5：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('6', 'Question 6', 'Question 6：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('7', 'Question 7', 'Question 7：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('8', 'Question 8', 'Question 8：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('9', 'Question 9', 'Question 9：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('10', 'Question 10', 'Question 10：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('11', 'Question 11', 'Question 11：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('12', 'Question 12', 'Question 12：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');
INSERT INTO `x_faq` VALUES ('13', 'Question 13', 'Question13：Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '15', '50');

-- ----------------------------
-- Table structure for x_favorites
-- ----------------------------
DROP TABLE IF EXISTS `x_favorites`;
CREATE TABLE `x_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL COMMENT '用户 id',
  `t_name` varchar(50) DEFAULT NULL COMMENT '收藏实体以前所在表，不带前缀',
  `t_id` int(11) DEFAULT NULL COMMENT '收藏内容原来的主键id',
  `createtime` int(11) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of x_favorites
-- ----------------------------

-- ----------------------------
-- Table structure for x_hook
-- ----------------------------
DROP TABLE IF EXISTS `x_hook`;
CREATE TABLE `x_hook` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `addon` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子来自哪个插件',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子描述',
  `system` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否为系统钩子',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='钩子表';

-- ----------------------------
-- Records of x_hook
-- ----------------------------
INSERT INTO `x_hook` VALUES ('17', 'maintain', 'Maintain', '日常维护钩子', '0', '1487424935', '1487424935', '1');
INSERT INTO `x_hook` VALUES ('13', 'gitinfo', 'Info', 'git信息钩子', '0', '1487419743', '1487419743', '1');
INSERT INTO `x_hook` VALUES ('14', 'sysinfo', 'Info', '框架信息钩子', '0', '1487419743', '1487419743', '1');
INSERT INTO `x_hook` VALUES ('16', 'team', 'Team', '团队钩子', '0', '1487422600', '1487422600', '1');

-- ----------------------------
-- Table structure for x_hook_addon
-- ----------------------------
DROP TABLE IF EXISTS `x_hook_addon`;
CREATE TABLE `x_hook_addon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hook` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子id',
  `addon` varchar(32) NOT NULL DEFAULT '' COMMENT '插件标识',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='钩子-插件对应表';

-- ----------------------------
-- Records of x_hook_addon
-- ----------------------------
INSERT INTO `x_hook_addon` VALUES ('19', 'maintain', 'Maintain', '1487424935', '1487424935', '100', '1');
INSERT INTO `x_hook_addon` VALUES ('14', 'sysinfo', 'Info', '1487419743', '1487419743', '100', '1');
INSERT INTO `x_hook_addon` VALUES ('13', 'gitinfo', 'Info', '1487419743', '1487419743', '100', '1');
INSERT INTO `x_hook_addon` VALUES ('17', 'team', 'Team', '1487422600', '1487422600', '100', '1');
INSERT INTO `x_hook_addon` VALUES ('18', 'team', 'Team', '1487422724', '1487422724', '100', '1');

-- ----------------------------
-- Table structure for x_member_group
-- ----------------------------
DROP TABLE IF EXISTS `x_member_group`;
CREATE TABLE `x_member_group` (
  `member_group_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员组ID',
  `member_group_name` varchar(30) NOT NULL COMMENT '会员组名',
  `member_group_open` int(11) NOT NULL DEFAULT '0' COMMENT '会员组是否开放',
  `member_group_toplimit` int(11) NOT NULL DEFAULT '0' COMMENT '积分上限',
  `member_group_bomlimit` int(11) NOT NULL DEFAULT '0' COMMENT '积分下限',
  `member_group_order` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`member_group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_member_group
-- ----------------------------
INSERT INTO `x_member_group` VALUES ('1', '会员', '1', '11', '22', '50');

-- ----------------------------
-- Table structure for x_member_list
-- ----------------------------
DROP TABLE IF EXISTS `x_member_list`;
CREATE TABLE `x_member_list` (
  `member_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_list_username` varchar(60) NOT NULL COMMENT '登录用户名',
  `member_list_pwd` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `member_list_salt` char(10) NOT NULL,
  `member_list_groupid` tinyint(2) NOT NULL COMMENT '所属会员组',
  `member_list_nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '昵称',
  `member_list_province` int(6) NOT NULL COMMENT '城市',
  `member_list_city` int(6) NOT NULL COMMENT '市县',
  `member_list_town` int(6) NOT NULL COMMENT '乡镇',
  `member_list_sex` tinyint(2) NOT NULL DEFAULT '3' COMMENT '1=男  2=女 3=保密',
  `member_list_headpic` varchar(200) NOT NULL COMMENT '会员头像路径',
  `member_list_tel` varchar(20) NOT NULL COMMENT '手机',
  `member_list_email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `member_list_open` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `member_list_addtime` int(11) NOT NULL COMMENT '添加时间戳',
  `member_list_from` varchar(20) DEFAULT '',
  `user_url` varchar(100) DEFAULT '' COMMENT '个人网站',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `signature` varchar(255) DEFAULT '' COMMENT '签名',
  `last_login_ip` varchar(16) DEFAULT '',
  `last_login_time` int(11) unsigned DEFAULT NULL,
  `user_activation_key` varchar(100) DEFAULT '' COMMENT '激活验证',
  `user_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未激活 1激活',
  `score` int(11) unsigned DEFAULT '0' COMMENT '积分',
  `coin` int(11) unsigned DEFAULT '0' COMMENT '金币',
  PRIMARY KEY (`member_list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_member_list
-- ----------------------------
INSERT INTO `x_member_list` VALUES ('1', 'admin', '58ce64f0ccccfeef795f3cccdb8cae82', 'mANIviADaC', '1', 'admin', '0', '0', '0', '3', '', '', 'xiaomak@qq.com', '1', '1502245979', '', '', null, '', '0.0.0.0', '1502257062', '', '1', '0', '0');
INSERT INTO `x_member_list` VALUES ('2', 'xiaomak', '1f09b495e69be095ef5a6eed4cb97147', 'HqxSnifwLQ', '1', 'xiaomak', '0', '0', '0', '3', '', '', '867409182@qq.com', '1', '1502257479', '', '', null, '', '0.0.0.0', '1502257479', '', '1', '0', '0');

-- ----------------------------
-- Table structure for x_member_lvl
-- ----------------------------
DROP TABLE IF EXISTS `x_member_lvl`;
CREATE TABLE `x_member_lvl` (
  `member_lvl_id` tinyint(3) NOT NULL AUTO_INCREMENT COMMENT '等级ID',
  `member_lvl_name` varchar(20) NOT NULL COMMENT '等级名称',
  PRIMARY KEY (`member_lvl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_member_lvl
-- ----------------------------

-- ----------------------------
-- Table structure for x_menu
-- ----------------------------
DROP TABLE IF EXISTS `x_menu`;
CREATE TABLE `x_menu` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(36) NOT NULL,
  `menu_enname` varchar(50) NOT NULL COMMENT '英文标题',
  `menu_type` int(8) NOT NULL,
  `menu_modelid` int(3) NOT NULL DEFAULT '0' COMMENT '模型id',
  `parentid` int(3) NOT NULL COMMENT '父级id',
  `menu_listtpl` varchar(50) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `menu_newstpl` varchar(50) NOT NULL DEFAULT '' COMMENT '单文章页模板',
  `menu_address` varchar(70) NOT NULL,
  `menu_open` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否开启',
  `listorder` int(7) NOT NULL,
  `menu_img` varchar(100) DEFAULT '' COMMENT '单页缩略图',
  `menu_seo_title` varchar(36) NOT NULL,
  `menu_seo_key` varchar(200) NOT NULL,
  `menu_seo_des` varchar(200) NOT NULL,
  `menu_content` longtext NOT NULL,
  `menu_l` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_menu
-- ----------------------------
INSERT INTO `x_menu` VALUES ('1', '公司简介', '', '4', '0', '0', 'about', '', '', '1', '10', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4864g_3hbi3a1uhkw0584ea6206fdcc.jpg', '关于我们', '关于我们', '关于我们', '<p style=\"white-space: normal;\">&nbsp; 团队成立与于2014年,是一个专注于高端品牌网站建设的设计工作室。</p><p style=\"white-space: normal;\">团队骨干有着丰富的网页设计和网站开发水平，为客户提供更符合搜索引擎的网站研发服务，协助构建OA网络办公信息平台，定制网站与数据库开发，并提供WAP网站建设、微网站、微商城、微信裂变式分销，网站维护、网络推广等互联网一站式服务。我们将商业与技术完美结合起来，以使我们的客户可以在快速发展的信息科技领域中获得更有效的竞争力。</p><p style=\"white-space: normal;\">&nbsp;&nbsp;团队成立以来，先后为数十家企业提供网站建设及推广服务。我们一直秉承“只做有灵魂的设计”和“坚持原创”的核心价值观，以“为客户赢得客户”为己任，用我们的激情和智慧，勤奋与努力，帮助中小企业开展网站建设，打开互联网营销局面，深刻影响着魔酷阁的经营模式和营销思路我们坚信，中国的每一家企业都应该有一个赋有灵魂的网站，用来发布企业产品、发布企业资讯、开展网上调查、与客户进行在线交流、分析客户需求和了解市场发展等功能于一体的营销型网站。</p>', 'zh-cn');
INSERT INTO `x_menu` VALUES ('2', '服务项目', '', '3', '0', '0', 'list', 'news', '', '1', '20', '', '', '', '', '', 'zh-cn');
INSERT INTO `x_menu` VALUES ('3', '成功案例', '', '3', '0', '0', 'photo_list', 'news', '', '1', '45', '', '', '', '', '', 'zh-cn');
INSERT INTO `x_menu` VALUES ('4', '联系方式', '', '4', '0', '0', 'contact', '', '', '1', '55', '', '', '', '', '&lt;p&gt;联系方式&lt;/p&gt;', 'zh-cn');
INSERT INTO `x_menu` VALUES ('5', '新闻资讯', '', '3', '0', '0', 'list', 'news', '', '1', '30', '', '', '', '', '', 'zh-cn');
INSERT INTO `x_menu` VALUES ('6', '合作伙伴', '', '3', '0', '0', 'list', 'news', '', '0', '50', '', '', '', '', '', 'zh-cn');
INSERT INTO `x_menu` VALUES ('7', '首页', 'Home', '1', '0', '0', '', '', '', '1', '1', '', '', '', '', '', 'zh-cn');
INSERT INTO `x_menu` VALUES ('8', 'About us', '', '4', '0', '0', 'about', '', '', '1', '10', 'http://ohjmksy46.bkt.clouddn.com/image/iwm3zkpk_21n6xk2bzngg584ea48f41bc7.jpg', 'About us', 'About us', 'About us', '<p>Team was founded in 2014, is a focus on high-end brand website construction design studio.</p><p>The backbone of the team has a wealth of web design and web development level, to provide more in line with the search engine website development services for customers, to assist the construction of OA network information office platform, customized website and database development, and provide the WAP website, micro sites, micro mall, WeChat fission distribution, website maintenance, network promotion, Internet stop service. We will be the perfect combination of business and technology, so that our customers can be in the rapid development of the information technology in the field of more effective competition.</p><p>Since the establishment of the team, has dozens of enterprises to provide website construction and promotion services. We have been adhering to the \"only do the design with a soul\" and \"adhere to the original\" core values \"to win customers\" to customers for the mission, with our passion and wisdom, diligence and efforts to help small and medium-sized enterprises to carry out the construction site, open Internet marketing, deeply influence the business model and marketing ideas possessed cool Pavilion we believe that every company should have a Chinese are endowed with soul of the website, to release enterprise products, enterprise information, carry out online survey released, the marketing website of online communication and customer needs analysis and understanding of market development and other functions in one with customers.</p>', 'en-us');
INSERT INTO `x_menu` VALUES ('9', 'Services', '', '3', '0', '0', 'list', 'news', '', '1', '20', '', '', '', '', '', 'en-us');
INSERT INTO `x_menu` VALUES ('10', 'Cases', '', '3', '0', '0', 'photo_list', 'news', '', '1', '45', '', '', '', '', '', 'en-us');
INSERT INTO `x_menu` VALUES ('11', 'Contract us', '', '4', '0', '0', 'contact', '', '', '1', '55', '', '', '', '', '&lt;p&gt;联系方式&lt;/p&gt;', 'en-us');
INSERT INTO `x_menu` VALUES ('12', 'News', '', '3', '0', '0', 'list', 'news', '', '1', '30', '', '', '', '', '', 'en-us');
INSERT INTO `x_menu` VALUES ('13', 'Partner', '', '3', '0', '0', 'list', 'news', '', '0', '50', '', '', '', '', '', 'en-us');
INSERT INTO `x_menu` VALUES ('14', 'Home', 'Home', '1', '0', '0', '', '', '', '1', '1', '', '', '', '', '', 'en-us');
INSERT INTO `x_menu` VALUES ('15', '常见问题', 'FAQ', '3', '2', '0', 'faq_list', 'faq', '', '1', '30', '', '', '', '', '', 'zh-cn');

-- ----------------------------
-- Table structure for x_model
-- ----------------------------
DROP TABLE IF EXISTS `x_model`;
CREATE TABLE `x_model` (
  `model_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `model_title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `model_pk` char(30) NOT NULL DEFAULT '' COMMENT '主键字段',
  `model_cid` char(30) NOT NULL DEFAULT '' COMMENT '栏目字段',
  `model_order` char(30) NOT NULL DEFAULT '' COMMENT '默认排序字段',
  `model_sort` varchar(255) DEFAULT NULL COMMENT '表单字段排序',
  `model_fields` text NOT NULL COMMENT '字段列表',
  `model_list` varchar(255) DEFAULT NULL COMMENT '列表显示字段，为空显示全部',
  `model_edit` varchar(255) DEFAULT '' COMMENT '可编辑字段，为空则除主键外均可以编辑',
  `model_indexes` varchar(255) DEFAULT NULL COMMENT '索引字段',
  `search_list` varchar(255) DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `model_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `model_engine` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of x_model
-- ----------------------------
INSERT INTO `x_model` VALUES ('1', 'test', '测试模型', 'test_id', 'test_cid', 'test_order', 'test_order', '{\"m_text\":{\"name\":\"m_text\",\"title\":\"\\u6587\\u672c\\u5b57\\u6bb5\",\"type\":\"text\",\"data\":\"\",\"description\":\"\\u6587\\u672c\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"readonly\",\"default\":\"\"},\"m_map\":{\"name\":\"m_map\",\"title\":\"\\u5730\\u56fe\\u5b57\\u6bb5\",\"type\":\"baidu_map\",\"data\":\"\",\"description\":\"\\u5730\\u56fe\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"22,22\"},\"m_imagefile\":{\"name\":\"m_imagefile\",\"title\":\"\\u5355\\u56fe\\u7247\\u5b57\\u6bb5\",\"type\":\"imagefile\",\"data\":\"\",\"description\":\"\\u5355\\u56fe\\u7247\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"m_images\":{\"name\":\"m_images\",\"title\":\"\\u591a\\u56fe\\u7247\\u5b57\\u6bb5\",\"type\":\"images\",\"data\":\"\",\"description\":\"\\u591a\\u56fe\\u7247\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"m_selecttext\":{\"name\":\"m_selecttext\",\"title\":\"\\u9009\\u62e9\\u6587\\u672c\",\"type\":\"selecttext\",\"data\":\"auth_group|id|title|id\",\"description\":\"\\u9009\\u62e9\\u6587\\u672c\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"required\",\"default\":\"\"},\"m_cur\":{\"name\":\"m_cur\",\"title\":\"\\u8d27\\u5e01\\u5b57\\u6bb5\",\"type\":\"currency\",\"data\":\"\",\"description\":\"\\u8d27\\u5e01\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"unsigned\",\"default\":\"22\"},\"m_long\":{\"name\":\"m_long\",\"title\":\"\\u957f\\u6574\\u6570\\u5b57\\u6bb5\",\"type\":\"large_number\",\"data\":\"\",\"description\":\"\\u957f\\u6574\\u6570\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"0\"},\"m_int\":{\"name\":\"m_int\",\"title\":\"\\u6574\\u6570\\u5b57\\u6bb5\",\"type\":\"number\",\"data\":\"\",\"description\":\"\\u6574\\u6570\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"required\",\"default\":\"11\"},\"m_datatime\":{\"name\":\"m_datatime\",\"title\":\"\\u65e5\\u671f\\u65f6\\u95f4\\u5b57\\u6bb5\",\"type\":\"datetime\",\"data\":\"\",\"description\":\"\\u65e5\\u671f\\u65f6\\u95f4\\u5b57\\u6bb5\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"m_date\":{\"name\":\"m_date\",\"title\":\"\\u65e5\\u671f\\u5b57\\u6bb5\",\"type\":\"date\",\"data\":\"\",\"description\":\"\\u65e5\\u671f\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"m_selectnumber\":{\"name\":\"m_selectnumber\",\"title\":\"\\u9009\\u62e9\\u6570\\u5b57\\u5b57\\u6bb5\",\"type\":\"selectnumber\",\"data\":\"1:a,2:b,3:c\",\"description\":\"\\u9009\\u62e9\\u6570\\u5b57\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"readonly\",\"default\":\"\"},\"m_richtext\":{\"name\":\"m_richtext\",\"title\":\"\\u5bcc\\u6587\\u672c\\u5b57\\u6bb5\",\"type\":\"richtext\",\"data\":\"\",\"description\":\"\\u5bcc\\u6587\\u672c\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"m_bigtext\":{\"name\":\"m_bigtext\",\"title\":\"\\u6587\\u672c\\u57df\\u5b57\\u6bb5\",\"type\":\"bigtext\",\"data\":\"\",\"description\":\"\\u6587\\u672c\\u57df\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"m_switch\":{\"name\":\"m_switch\",\"title\":\"\\u5f00\\u5173\\u5b57\\u6bb5\",\"type\":\"switch\",\"data\":\"\",\"description\":\"\\u5f00\\u5173\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"0\"},\"m_check\":{\"name\":\"m_check\",\"title\":\"\\u591a\\u9009\\u6846\\u5b57\\u6bb5\",\"type\":\"checkbox\",\"data\":\"diyflag|diyflag_id|diyflag_name|diyflag_order\",\"description\":\"\\u591a\\u9009\\u6846\\u5b57\\u6bb5\\u8bf4\\u660e\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"}}', 'test_id,m_selecttext,m_date,m_switch,m_imagefile', '', '', '', '1482231462', '1482402443', '1', 'MyISAM');
INSERT INTO `x_model` VALUES ('2', 'faq', '常见问题', 'faq_id', 'faq_cid', 'faq_order', 'faq_order', '{\"faq_title\":{\"name\":\"faq_title\",\"title\":\"\\u6807\\u9898\",\"type\":\"text\",\"data\":\"\",\"description\":\"\\u6807\\u9898\",\"length\":\"\",\"rules\":\"required\",\"default\":\"\"},\"faq_answer\":{\"name\":\"faq_answer\",\"title\":\"\\u7b54\\u590d\",\"type\":\"bigtext\",\"data\":\"\",\"description\":\"\\u7b54\\u590d\",\"length\":\"\",\"rules\":\"required\",\"default\":\"\"}}', '', '', '', '', '1482821043', '1482821382', '1', 'MyISAM');
INSERT INTO `x_model` VALUES ('3', 'payment', '订单支付', 'payment_id', 'payment_cid', 'create_time', 'create_time', '{\"out_trade_no\":{\"name\":\"out_trade_no\",\"title\":\"\\u5546\\u54c1\\u8ba2\\u5355\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"100\",\"rules\":\"unique\",\"default\":\"\"},\"pay_trade_no\":{\"name\":\"pay_trade_no\",\"title\":\"\\u652f\\u4ed8\\u8ba2\\u5355\\u53f7\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"100\",\"rules\":\"unique\",\"default\":\"NULL\"},\"money\":{\"name\":\"money\",\"title\":\"\\u8ba2\\u5355\\u91d1\\u989d\",\"type\":\"currency\",\"data\":\"\",\"description\":\"\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"status\":{\"name\":\"status\",\"title\":\"\\u8ba2\\u5355\\u72b6\\u6001\",\"type\":\"number\",\"data\":\"\",\"description\":\"1:\\u5f85\\u652f\\u4ed82:\\u6d4b\\u8bd5\\u8ba2\\u53558:\\u6210\\u529f\\u652f\\u4ed80:\\u5220\\u9664\\u8ba2\\u5355\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"type\":{\"name\":\"type\",\"title\":\"\\u652f\\u4ed8\\u65b9\\u5f0f\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"50\",\"rules\":\"\",\"default\":\"\"},\"uid\":{\"name\":\"uid\",\"title\":\"\\u4ed8\\u6b3euid\",\"type\":\"number\",\"data\":\"\",\"description\":\"\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"create_time\":{\"name\":\"create_time\",\"title\":\"\\u8ba2\\u5355\\u521b\\u5efa\\u65f6\\u95f4\",\"type\":\"datetime\",\"data\":\"\",\"description\":\"\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"update_time\":{\"name\":\"update_time\",\"title\":\"\\u8ba2\\u5355\\u66f4\\u65b0\\u65f6\\u95f4\",\"type\":\"datetime\",\"data\":\"\",\"description\":\"\",\"length\":\"\",\"rules\":\"\",\"default\":\"\"},\"client_ip\":{\"name\":\"client_ip\",\"title\":\"\\u652f\\u4ed8ip\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"50\",\"rules\":\"\",\"default\":\"\"},\"product_name\":{\"name\":\"product_name\",\"title\":\"\\u5546\\u54c1\\u540d\\u79f0\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"200\",\"rules\":\"\",\"default\":\"\"},\"product_body\":{\"name\":\"product_body\",\"title\":\"\\u5546\\u54c1\\u63cf\\u8ff0\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"200\",\"rules\":\"\",\"default\":\"\"},\"product_url\":{\"name\":\"product_url\",\"title\":\"\\u5546\\u54c1\\u5730\\u5740\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"100\",\"rules\":\"\",\"default\":\"\"},\"extra_param\":{\"name\":\"extra_param\",\"title\":\"\\u7279\\u6b8a\\u6269\\u5c55\",\"type\":\"text\",\"data\":\"\",\"description\":\"\",\"length\":\"500\",\"rules\":\"\",\"default\":\"\"}}', 'out_trade_no,pay_trade_no,product_name,money,type,update_time,status', '', '', '', '1483620293', '1483620293', '1', 'MyISAM');

-- ----------------------------
-- Table structure for x_news
-- ----------------------------
DROP TABLE IF EXISTS `x_news`;
CREATE TABLE `x_news` (
  `n_id` int(36) NOT NULL AUTO_INCREMENT,
  `news_title` varchar(255) NOT NULL COMMENT '文章标题',
  `news_titleshort` varchar(100) DEFAULT NULL COMMENT '简短标题',
  `news_columnid` int(11) NOT NULL,
  `news_columnviceid` int(11) DEFAULT NULL COMMENT '副栏目ID',
  `news_key` varchar(100) DEFAULT NULL COMMENT '文章关键字',
  `news_tag` varchar(50) DEFAULT '' COMMENT '文章标签',
  `news_auto` varchar(20) NOT NULL COMMENT '作者',
  `news_source` varchar(20) NOT NULL DEFAULT '未知' COMMENT '来源',
  `news_content` longtext NOT NULL COMMENT '新闻内容',
  `news_scontent` varchar(200) NOT NULL DEFAULT '',
  `news_hits` int(11) NOT NULL DEFAULT '200' COMMENT '点击率',
  `news_like` int(11) unsigned DEFAULT '0' COMMENT '收藏数',
  `news_img` varchar(100) DEFAULT '' COMMENT '大图地址',
  `news_pic_type` tinyint(2) NOT NULL COMMENT '1=普通模式 2=腾讯模式',
  `news_pic_allurl` text COMMENT '多图路径',
  `news_pic_content` longtext COMMENT '多图对应文字说明',
  `news_time` int(11) NOT NULL,
  `listorder` int(11) unsigned DEFAULT '50',
  `news_modified` int(11) unsigned DEFAULT '0' COMMENT '修改时间',
  `news_flag` set('h','c','f','a','s','p','j','d','cp') NOT NULL DEFAULT '' COMMENT '文章属性',
  `news_zaddress` varchar(100) NOT NULL DEFAULT '' COMMENT '跳转地址',
  `news_cpprice` double NOT NULL DEFAULT '0' COMMENT '产品价格',
  `news_back` int(2) NOT NULL DEFAULT '0' COMMENT '是否为回收站',
  `news_open` varchar(2) DEFAULT '0' COMMENT '0代表审核不通过 1代表审核通过',
  `news_lvtype` tinyint(2) NOT NULL DEFAULT '0' COMMENT '旅游类型1=行程 2=攻略',
  `comment_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=可评论 0=不可评论',
  `comment_count` int(11) unsigned DEFAULT '0' COMMENT '评论数',
  `news_extra` text COMMENT '扩展字段，json',
  `news_l` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`n_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_news
-- ----------------------------
INSERT INTO `x_news` VALUES ('1', 'ACE后台管理系统', 'ACE后台管理系统', '3', '0', '', '', '1', '雨飞工作室', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">测试网址：<a href=\"http://www.rainfer.cn/ace/index.php?m=admin&c=index&a=index\" target=\"_blank\" title=\"http://www.rainfer.cn/ace/index.php?m=admin&c=index&a=index\" style=\"box-sizing: border-box; color: rgb(4, 136, 205); text-decoration: none;\">http://www.rainfer.cn/ace/index.php?m=admin&c=index&a=index</a></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">用户名：demo</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">密码：123456</p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">下载:<a href=\"http://git.oschina.net/rainfer/YFCMF\" target=\"_blank\" title=\"http://git.oschina.net/rainfer/YFCMF\" style=\"box-sizing: border-box; color: rgb(4, 136, 205); text-decoration: none;\">http://git.oschina.net/rainfer/YFCMF</a></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydy80_cgng0pgmswg584e7fd00b5e5.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydwog_2hu7u1cbg6io584e7fce50313.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydi0o_4f6h69in0vsw584e7fbb8e163.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydgh4_amfzhr162m0584e7fb9097b9.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyde5s_63tohbqbcpog584e7fb6c4381.jpg\" style=\"\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: \"Open Sans\", Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\"><br/></p>', 'ACE后台管理系统', '203', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4h9a8_2lusiuf7mocg584ea7c853c6e.jpg', '2', '/data/upload/2016-05-06/572c863a052a7.jpghttp://ohjmksy46.bkt.clouddn.com/image/iwm4hdww_1tt5u3ioc2jo584ea7ce3abe4.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4hcdc_5zqxgcnh8hkw584ea7ccc0949.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4hblk_2m18chvhum04584ea7cb53efc.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4ha20_41xswn520d0k584ea7c982448.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4h9a8_37gpgidez8is584ea7c86710b.jpg,', '', '1462535538', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('10', '设计师一日为师 终身为师', '设计师一日为师 终身为师', '5', '0', '设计师一日为师 终身为师', '', '1', '雨飞工作室', '<p style=\"white-space: normal;\">大家都有这样的感受，在未成为设计师之前，都对“设计师”职业的这三个字非常羡慕，都希望大家称我们为东莞设计师。当客户尊敬的称您为某某设计师时，我们也非常自豪而高兴。但是我希望大家明白，设计师不仅仅只是设计职业的称呼，因为他承担的角色还是设计中的师范作用，所以时刻要记得：设计师一日为师 终身为师。<br/>&nbsp;</p><p style=\"white-space: normal;\">那么到底设计师何以为师呢？为什么要去理解“师”的这个概念呢？其实我是换位思想，即站在客户的角度，充分考虑他为什么要找你做设计的理由？如果搞清楚理由就是找到了自己的设计之师。而自己换位思想，找不到这个师之理由的话，那么自然您还不算是设计师，那就在每天别人叫你设计师的时候，多多思考设计师何以为师？而其中设计师的师，也是需要我们每天去努力工作和学习的，不断的改善提高自己的设计水平和综合素质。让自己从设计员到设计师的蜕变中，对得起设计师可以为师。<br/>&nbsp;&nbsp;</p><p style=\"white-space: normal;\"><strong>要做好设计，先别做坏设计。</strong></p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">这句话是我考虑甚久得出的，虽然貌似很无聊，我却认为非常重要。创业初期的设计朋友，请时刻记得这句话，然后留点空白，让你自己去思考。因为很多人在接单子的时候，只想着是单子是利润，而忽略了这个设计本身造成的好坏。<br/>&nbsp;</p><p style=\"white-space: normal;\">我曾经目睹上海一家策略公司，温州的一个企业找他们做品牌推广项目，该公司派人分析客户企业背景和实际情况，若达不到自己要求，就放弃操作这个项目，即使客户付再多的项目费，也坚持宁愿放弃。我当时不明白，为什么给那么多钱也不做？后来我明白他们公司为什么一直那么成功，因为他们只做好设计，不做坏设计，那是他们保持长期发展的战略和原则。<br/>&nbsp;</p><p style=\"white-space: normal;\">所以在初期创业中，我也在选择客户上开始有了原则，尽量让好的设计找到自己。</p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\"><strong>突出就是优势。</strong></p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">一定要突出，作为设计师必须要有亮点。现在会鼠标会用软件的人都称自己是设计师，艺术系毕业和设计师人才越来越多，这个行业的竞争激烈也是这个时代的表现之一。大大小小的工作室和设计公司多如牛毛，甚至有人冷笑设计公司现在比WC还要多。这个时候设计师必须要做出自己的独特性，创业的设计师经营公司也要与其他要有差异性，突出就是优势，那非常重要。</p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\"><strong>设计没有好与坏，只有对与错。</strong></p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">以上我说的好设计和坏设计，自然是设计的前提。而设计有好和坏吗？我更希望大家用对与错来看待这个问题。作为设计师，他不是艺术家和商业师，首先应该是为业主解决实际问题，才是对的设计。不懂设计的人才会到处说这个设计好或者不好，为什么这样说？因为任何一样作品都有他的遗憾，哪怕是大师的五星级宾馆都是有遗憾的，所以不该用好不好来判定。出发点和目的性不同，自然设计的要求和本质也不同，违背了设计本意就失去意义，更何谈好坏？所以在对与错之间去思考设计，会更准确的为客户解决实际问题，找到设计的真谛！</p><p><br/></p>', '大家都有这样的感受，在未成为设计师之前，都对“设计师”职业的这三个字非常羡慕，都希望大家称我们为东莞', '216', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4bemw_4p1w4yzvxfcw584ea6b796e63.jpg', '1', '', '', '1462538523', '50', '0', 'p,d', '', '0', '0', '1', '0', '1', '2', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('2', '高级企业网站', '高级企业网站', '3', '0', '高级企业网站', '', '1', '雨飞工作室', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">高级企业网站</p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlynzc0_55aanzdwp08w584e81a4a563b.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlynyk8_1xshv0zxq6ro584e81a33e4c1.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlynx0o_4a08d6h5uoow584e81a189780.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlynupc_3sdacafv7o8w584e819e79b9b.jpg\" style=\"\"/></p><p><br/></p>', '高级企业网站', '203', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4f5o0_3p4cnfcwga68584ea76676d37.jpg', '2', '/data/upload/2016-05-06/572c8982020a4.jpghttp://ohjmksy46.bkt.clouddn.com/image/iwm4faao_53auzeeb8z8c584ea76ca39e4.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4f9iw_252erwau32xw584ea76b44ca9.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4f7zc_6inln0u3cj4s584ea769d1752.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4f77k_k41mlxegj8g584ea76811f3e.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4f5o0_4kqm510d9g8w584ea766930c9.jpg,', '', '1462536578', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('3', '志和第三方公司网站', '志和第三方公司网站', '3', '0', '志和第三方公司网站', '', '1', '雨飞工作室', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">志和第三方公司网站</p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwg8k21s_2ehcpk6ucntw5849395c4d320.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwg8hdlk_5i1aayr4us08584938dfb0c52.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwg8d7wo_6kxpx7xyptkw5849381dd37e6.jpg\" style=\"\"/></p><p><br/></p><p><br/></p>', '志和第三方公司网站', '205', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4dbb4_5or075nwo40s584ea710b6c37.jpg', '2', '/data/upload/2016-05-06/572c89f8c6383.jpghttp://ohjmksy46.bkt.clouddn.com/image/iwm4dee8_422efzz8fdog584ea7148261b.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4ddmg_3hxo056be2gw584ea71370697.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4dcuo_5jtzj2havh4w584ea712b25fd.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4dc2w_25ar0eq96yw0584ea71144ff8.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwm4dbb4_68ptyg9t8wco584ea710c8963.jpg,', '', '1462536696', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('4', '企业网站开发设计', '企业网站开发设计', '2', '0', '企业网站开发设计', '', '1', '雨飞工作室', '<p style=\"white-space: normal;\"><span style=\"line-height: 1.75em;\">-企业形象/产品网站设计开发</span><br/></p><p style=\"white-space: normal; line-height: 1.75em;\">-集团官方网站设计开发</p><p style=\"white-space: normal; line-height: 1.75em;\">-淘宝/天猫店铺视觉设计</p><p style=\"white-space: normal; line-height: 1.75em;\">-html5+css3</p><p style=\"white-space: normal; line-height: 1.75em;\">-各类型网站设计和制作</p>', '企业网站开发设计', '203', '1', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4aaig_hcedy3x46f4584ea6830f7b6.jpg', '1', '', '', '1462537144', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('5', '网站UI设计', '网站UI设计', '2', '0', '网站UI设计', '', '1', '雨飞工作室', '<p style=\"white-space: normal;\"><strong><span style=\"color: rgb(0, 176, 240);\">1. 用户研究</span></strong></p><p style=\"white-space: normal;\">用户调研是综合运用现场观察、访谈、问卷调查、焦点小组等方法，获得用户需求及产品使用偏好。使用户的实际需求成为产品设计的导向，使产品更符合用户的习惯、经验和期待。</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong>2. 交互设计</strong></span></p><p style=\"white-space: normal;\">产品的交互流程设计,根据可用性分析结果制定交互方式、操作与跳转流程、结构、布局、信息和其他元素。</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong>3. 界面设计</strong></span></p><p style=\"white-space: normal;\">提供移动设备UI设计、APP界面设计，高品质的网站设计。</p>', '网站UI设计', '200', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4a20w_5fwu72e5ltog584ea678aedfe.jpg', '1', '', '', '1462537217', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('6', 'ThinkPHP二次开发', 'ThinkPHP二次开发', '2', '0', 'ThinkPHP二次开发', '', '1', '雨飞工作室', '<p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">专注于ThinkPHP程序项目的二次开发，提供从架构设计、需求分析、设计策划、程序开发，到部署运维全程外包服务。公司拥有强大的技术研发实力、规范的开发流程、丰富的经验，可针对不同行业特点设计解决方案。</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong><span style=\"font-family: 微软雅黑, &#39;Microsoft YaHei&#39;;\">包含：</span></strong></span></p><p style=\"white-space: normal;\"><span style=\"font-family: 微软雅黑, &#39;Microsoft YaHei&#39;; font-size: 14px;\">更改使用thinkphp框架开发的程序;</span></p><p style=\"white-space: normal;\"><span style=\"font-family: 微软雅黑, &#39;Microsoft YaHei&#39;; font-size: 14px;\">使用thinkphp框架开发功能;</span></p><p style=\"white-space: normal;\"><span style=\"font-family: 微软雅黑, &#39;Microsoft YaHei&#39;; font-size: 14px;\">基于thinkphp框架的项目;</span></p><p style=\"white-space: normal;\"><span style=\"font-family: 微软雅黑, &#39;Microsoft YaHei&#39;; font-size: 14px;\">使用thinkphp去访网络中的网站;</span></p>', 'ThinkPHP二次开发', '201', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm49rzs_5r8l655x9r40584ea66bb8fc1.jpg', '1', '', '', '1462537270', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('7', 'YFCMF的二次开发', 'YFCMF的二次开发', '2', '0', 'YFCMF的二次开发', '', '1', '雨飞工作室', '<p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">YFCMF是一款基于PHP+MYSQL开发的中文内容管理框架。YFCMF提出灵活的应用机制，框架自身提供基础的管理功能，而开发者可以根据自身的需求以应用的形式进行扩展。每个应用都能独立的完成自己的任务，也可通过系统调用其他应用进行协同工作。在这种运行机制下，开发商场应用的用户无需关心开发SNS应用时如何工作的，但他们之间又可通过系统本身进行协调，大大的降低了开发成本和沟通成本。</p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(0, 176, 240);\"><strong>包含：</strong></span></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">基于YFcmf框架开发项目的程序修改</p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">完善YFcmf框架的功能</p><p style=\"white-space: normal;\"><span style=\"color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">增加YFcmf的功能模块</span></p><p style=\"white-space: normal;\"><span style=\"color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif;\"><span style=\"font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">使用YFcmf重写网站项目</span></span></p>', 'YFCMF的二次开发', '200', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm49ka0_3fshb6agdfac584ea6616e7f8.jpg', '1', '', '', '1462537316', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('8', 'ThinkPHP、YFCMF项目插件定制', '插件定制', '2', '0', '插件定制', '', '1', '雨飞工作室', '<p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif, Simsun;\">插件是用于实现简单的显示及数据处理的功能扩展。插件是可以开启关闭的，但不会影响原有系统的代码；</span></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif, Simsun;\">通过插件，很方便通过后台安装卸载来达到某种功能，之前WP的成功，很多原因是丰富的主题，功能众多的插件选择。</span></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(0, 176, 240);\"><strong><span style=\"font-family: &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif, Simsun;\">包含：</span></strong></span></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: &#39;Microsoft YaHei&#39;, Lato, &#39;Helvetica Neue&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif, Simsun;\">ThinkPHP项目的插件定制</span></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \" microsoft=\"\" helvetica=\"\" font-size:=\"\" line-height:=\"\" background-color:=\"\"><span style=\"color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Arial, Helvetica, sans-serif, Simsun;\">YFCMF项目的插件定制</span></p>', '插件定制', '204', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm49ck8_5ilcpr11gs08584ea657b1448.jpg', '1', '', '', '1462537365', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('9', 'YFCMF功能定制', 'YFCMF功能定制', '2', '0', 'YFCMF功能定制', '', '1', '雨飞工作室', '<p style=\"white-space: normal;\">针对不同的行业，不同的企业，利用ThinkCMF框架进行开发，根据客户提出的功能需求进行分析，进行设计并开发出专用的功能，用于解决特定的方案。</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong>包含：</strong></span></p><p style=\"white-space: normal;\">已有功能的改进</p><p style=\"white-space: normal;\">增加新的功能</p>', 'YFCMF功能定制', '211', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm491rc_3cfcm5icllyc584ea6496b7ea.jpg', '1', '', '', '1462537410', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '2', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('11', '品牌价值的核心与精髓是品牌设计的灵魂', '品牌价值的核心与精髓是品牌设计的灵魂', '5', '0', '品牌价值的核心与精髓是品牌设计的灵魂', '', '1', '雨飞工作室', '<p style=\"white-space: normal;\">在现代，甭管大的还是小的<strong>东莞设计公司</strong>，大都十分注重<strong>东莞品牌设计</strong>，但放眼看去，市场上的精品又有多少。精品寥寥无几的原因是什么呢？无非两点：1、在进行品牌设计之前，对于品牌的定位不明确；2、有模糊的品牌定位概念后，设计公司的品牌设计作品由公司人员的主观喜好作为判断。</p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">&nbsp; &nbsp; 设计本身必须有思想，有灵魂，有目的。产品是卖给谁的，他们的常规生活方式是什么？希望传达给他们一个什么样的信息？希望他们怎么看这个品牌？我们希望引导他们如何去做？我们如何贴近其真实的内心需求等等。这些问题，不是你喜欢与不喜欢的问题。</p><p style=\"white-space: normal;\">&nbsp;&nbsp;</p><p style=\"white-space: normal;\">&nbsp; &nbsp; 1、明确品牌定位：品牌设计的定位解决的是品牌是什么与不是什么的问题。这个是什么与不是什么，并不是指产品属性，而是指你的品牌代表了什么与不代表什么。</p><p style=\"white-space: normal;\">&nbsp;</p><p style=\"white-space: normal;\">&nbsp; &nbsp; &nbsp;2、突显品牌核心价值：品牌核心价值是品牌设计的精髓与核心，也是品牌的内在驱动力与凝聚力。在产品日渐同质化的趋势下，对消费者最重要的影响因素往往不再是产品实体，而是品牌核心价值所折射出的目标消费者所具有或是向往的生活方式和精神追求，这也是促使消费者保持品牌忠诚的核心力量。</p><p><br/></p>', '在现代，甭管大的还是小的东莞设计公司，大都十分注重东莞品牌设计，但放眼看去，市场上的精品又有多少。精', '212', '4', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4b1io_1jse1fw13mpw584ea6a631cc4.jpg', '1', '', '', '1462539100', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '10', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('12', '东莞品牌设计是冰山一角，却至关重要！', '东莞品牌设计是冰山一角，却至关重要！', '5', '0', '东莞品牌设计是冰山一角，却至关重要！', '', '1', '雨飞工作室', '<p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？<br/>&nbsp;</p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。</p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。</p>_ueditor_page_break_tag_<p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\"><strong>想想设计究竟有多重要！</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">2、回归原点，发掘项目或产品的本质所在!设计大师深泽直人的沙发设计原理告诉我们，抛开沙发表象的坐垫、靠背等等，其实本质上它只是一张凳子。设计者则要尽可能单纯的思考，根据所需进行相应的设计。所以我们的建议是凡事不要急于动手，不妨先静下心来，好好想想这个项目或者产品最为显著的特点是什么，它们的目标客户与消费群又是什么……</p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; text-align: center; background-color: rgb(255, 255, 255);\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\"><br/></p>_ueditor_page_break_tag_<p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\"><br/><strong>&nbsp;做什么样的设计？</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">3、简洁、清晰、概念是我们的设计原则！简洁、清晰是以最为简洁直观的方式，达成有效的视觉沟通和传播，拒绝一切不切实际的象征意义与所谓内涵。</p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">概念则是以巧妙独到的设计理念和应用，给人以意外惊喜，使人印象深刻从而有力提升企业形象及文化内涵。</p><p style=\"margin-top: 0px; margin-bottom: 0px; white-space: normal; padding: 0px; line-height: 25.2px; font-size: 14px; color: rgb(102, 102, 102); font-family: AppleGothic, Arial, &#39;Microsoft Yahei&#39;, Simsun; background-color: rgb(255, 255, 255);\">4、为客户做合适的设计！鲁迅先生说穿衣：“……人瘦不要穿黑衣裳，人胖不要穿白衣裳；脚长的女人一定要穿黑鞋子，脚短就一定要穿白鞋子；方格子的衣裳胖人不能穿，但比横格子的还好；横格子的胖人穿上，就把胖子更往两边裂着，更横宽了，胖子要穿竖条子的，竖的把人显得长，横的把人显的宽……”设计亦是如此，合适才好！合适就好！</p><p><br/></p>', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '346', '4', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4anmo_6v5ro7hhqykg584ea694dc9e9.jpg', '1', '', '', '1462539160', '50', '0', 'a,p', '', '0', '0', '1', '0', '1', '49', '{\"showdate\":1462464000}', 'zh-cn');
INSERT INTO `x_news` VALUES ('13', '东莞某五金厂', '东莞某五金厂', '6', '0', '东莞某五金厂', '', '1', '程小姐', '<p>感谢雨飞工作室按时保证质量的完成了我公司的网站建设,通过此次合作充分体现了雨飞工作室的项目团队在技术上对项目的把握程度,也为今后的合作奠定了基础.雨飞工作室是非常理想的合作伙伴。</p>', '感谢雨飞工作室按时保证质量的完成了我公司的网站建设,通过此次合作充分体现了雨飞工作室的项目团队在技术上对项目的把握程度,也为今后的合作奠定了基础.雨飞工作室是非常理想的合作伙伴。', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4lbw0_35jxhdo6c1k4584ea886655c2.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4lbw0_3o5ivzzn33s4584ea8867634e.jpg,', '', '1462579633', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('14', '志和第三方', '志和第三方', '6', '0', '志和第三方', '', '1', '孙先生', '<p>雨飞工作室是一支年轻的团队,充满朝气的团队,设计实力雄厚的团队,客户精神至上的团队。</p>', '雨飞工作室是一支年轻的团队,充满朝气的团队,设计实力雄厚的团队,客户精神至上的团队。', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4kyrs_tflmiecr5hw584ea8751a45d.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4kyrs_190vi332wps0584ea87528308.jpg,', '', '1462580217', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('15', '学吧网', '学吧网', '6', '0', '学吧网', '', '1', '彭先生', '<p>能顺应客户的需求变化而及时提供合适的解决方法，高效快捷，拥有优秀的服务团队。</p>', '能顺应客户的需求变化而及时提供合适的解决方法，高效快捷，拥有优秀的服务团队。', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4kkvs_1szlprr9ofa8584ea8633a02a.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4kkvs_2b1htrd6pw2s584ea8634a1fd.jpg,', '', '1462580295', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('16', '石龙E家', '石龙E家', '6', '0', '石龙E家', '', '1', '张先生', '<p>在整个项目中尽心尽责,项目团队负责人负责的开发任务均顺利如约完成,院里的领导也都非常满意,感谢雨飞工作室。</p>', '在整个项目中尽心尽责,项目团队负责人负责的开发任务均顺利如约完成,院里的领导也都非常满意,感谢雨飞工作室。', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4k4og_4fk4toirr2io584ea84e8e6ce.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4k4og_4ziykz4obusk584ea84ea03fa.jpg,', '', '1462580360', '33', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('17', '东莞某餐饮公司', '东莞某餐饮公司', '6', '0', '东莞某餐饮公司', '', '1', '谢先生', '<p>雨飞工作室是一支年轻、积极向上的团队，为我公司提供的各类网站服务真正做到了细致周到，让我们感觉很放心。</p>', '雨飞工作室是一支年轻、积极向上的团队，为我公司提供的各类网站服务真正做到了细致周到，让我们感觉很放心。', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4jle0_65nwndh36og8584ea835c5dc7.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4jle0_6pcvxqfazx0c584ea835d770b.jpg,', '', '1462580412', '11', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('18', '广州洁具公司', '广州洁具公司', '6', '0', '广州洁具公司', '', '1', '吴小姐', '<p>雨飞工作室是前期制作还是后期维护，都能做到尽心尽责，是我们满意的合作伙伴。</p>', '雨飞工作室是前期制作还是后期维护，都能做到尽心尽责，是我们满意的合作伙伴。', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4j7i0_375vw8qqbg2s584ea82366cc0.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4j7i0_3the3kt5h44k584ea8237ab84.jpg,', '', '1462580465', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('19', '食品公司网站', '食品公司网站', '6', '0', '食品公司网站', '', '1', '王先生', '<p>雨飞工作室是一只优秀的团队，他们有优良的技术和高品质的服务，在和我公司合作工程中，体现了他们制作大公司网站的实力。</p>', '雨飞工作室是一只优秀的团队，他们有优良的技术和高品质的服务，在和我公司合作工程中，体现了他们制作大公司网站的实力。', '201', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4irao_72rj0hcxk8co584ea80ee3684.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4is2g_48842mspe6o584ea80f03c64.jpg,', '', '1462580522', '45', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'zh-cn');
INSERT INTO `x_news` VALUES ('20', 'ACE admin management system', 'ACE admin', '10', '0', 'ACE admin management system', '', '1', 'Rainfer studio', '<p open=\"\" font-size:=\"\" margin-top:=\"\" margin-bottom:=\"\" white-space:=\"\" box-sizing:=\"\" background-color:=\"\" style=\"white-space: normal; color: rgb(114, 114, 114); line-height: 24px;\">test url：<a title=\"http://www.rainfer.cn/admin.php\" href=\"http://www.rainfer.cn/admin.php\" target=\"_blank\" style=\"color: rgb(4, 136, 205); text-decoration: none; box-sizing: border-box;\">http://www.rainfer.cn/admin.php</a></p><p open=\"\" font-size:=\"\" margin-top:=\"\" margin-bottom:=\"\" white-space:=\"\" box-sizing:=\"\" background-color:=\"\" style=\"white-space: normal; color: rgb(114, 114, 114); line-height: 24px;\">name：demo</p><p open=\"\" font-size:=\"\" margin-top:=\"\" margin-bottom:=\"\" white-space:=\"\" box-sizing:=\"\" background-color:=\"\" style=\"white-space: normal; color: rgb(114, 114, 114); line-height: 24px;\">password：123456</p><p open=\"\" font-size:=\"\" margin-top:=\"\" margin-bottom:=\"\" white-space:=\"\" box-sizing:=\"\" background-color:=\"\" style=\"white-space: normal; color: rgb(114, 114, 114); line-height: 24px;\">download:<a title=\"http://git.oschina.net/rainfer/YFCMF\" href=\"http://git.oschina.net/rainfer/YFCMF\" target=\"_blank\" style=\"color: rgb(4, 136, 205); text-decoration: none; box-sizing: border-box;\">http://git.oschina.net/rainfer/YFCMF</a></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyde5s_63tohbqbcpog584e7fb6c4381.jpg\" style=\"\" title=\"572c863a0b838.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydexk_2djdsc2ix1hc584e7fb74c5a6.jpg\" style=\"\" title=\"572c863a0db61.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydgh4_amfzhr162m0584e7fb9097b9.jpg\" style=\"\" title=\"572c863a052a7.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydh8w_3dovops8ga80584e7fba6c9fa.jpg\" style=\"\" title=\"572c863a071e7.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydi0o_4f6h69in0vsw584e7fbb8e163.jpg\" style=\"\" title=\"572c863a098f8.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlydjk8_2xllhe3hof6s584e7fbd5e42a.jpg\" style=\"\" title=\"572c863a03366.jpg\"/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114);\" open=\"\" font-size:=\"\" line-height:=\"\" white-space:=\"\" background-color:=\"\"><br/><a href=\"http://git.oschina.net/rainfer/YFCMF\" target=\"_blank\" title=\"http://git.oschina.net/rainfer/YFCMF\" style=\"box-sizing: border-box; color: rgb(4, 136, 205); text-decoration: none;\"></a><br/></p>', 'ACE admin management system', '205', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwlyj1v4_22lt905zjzdw584e80be42983.jpg', '2', '/data/upload/2016-05-06/572c863a052a7.jpghttp://ohjmksy46.bkt.clouddn.com/image/iwlye2uo_wt7otgvdm1c584e7fd61d49c.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlye1b4_2e74rpkmx8n4584e7fd44cf12.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlye0jc_1xrxaw5z8qn4584e7fd33e487.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlydyzs_3qudgk0d336s584e7fd1789ba.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlydy80_cgng0pgmswg584e7fd00b5e5.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlydwog_2hu7u1cbg6io584e7fce50313.jpg,', '', '1462535538', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('21', 'Advanced enterprise web site', 'Advanced enterprise web site', '10', '0', 'Advanced enterprise web site', '', '1', 'Rainfer studio', '<p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; color: rgb(114, 114, 114); font-family: &#39;Open Sans&#39;, Helvetica, Arial, sans-serif; font-size: 14px; line-height: 24px; white-space: normal; background-color: rgb(255, 255, 255);\">Advanced enterprise web site</p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyldyw_qqu8sx6dan4584e812b17dfa.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyld74_1a5euurx4274584e812a2931d.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlylcfc_4qv2dlmaenqc584e81299883e.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlylcfc_43c85e29paas584e812983849.jpg\" style=\"\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyl9c8_3j1aqwncyq80584e812571650.jpg\" style=\"\"/></p><p><br/></p>', 'Advanced enterprise web site', '203', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwlynupc_31ah27if3quc584e819e618e1.jpg', '2', '/data/upload/2016-05-06/572c8982020a4.jpghttp://ohjmksy46.bkt.clouddn.com/image/iwlyo0vk_qxqdghcwkv4584e81a6180b6.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlynzc0_55aanzdwp08w584e81a4a563b.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlynyk8_1xshv0zxq6ro584e81a33e4c1.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlynx0o_4a08d6h5uoow584e81a189780.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlynupc_3sdacafv7o8w584e819e79b9b.jpg,', '', '1462536578', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('22', 'ChiHe company website', 'ChiHe company website', '10', '0', 'ChiHe company website', '', '1', 'Rainfer studio', '<p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyr8m8_7cufq9eu0l8g584e823cec67d.jpg\" style=\"\" title=\"572c89f8c9e1c.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyr9e0_euvjiyxldts584e823d0d432.jpg\" style=\"\" title=\"572c89f8c86ab.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyra5s_3qy9h4i6hkys584e823e7875d.jpg\" style=\"\" title=\"572c89f8c6383.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyraxk_1rum1zyj5b1c584e823f393cf.jpg\" style=\"\" title=\"572c89f8c7323.jpg\"/></p><p><img src=\"http://ohjmksy46.bkt.clouddn.com/image/iwlyrbpc_2hun2r9p80o4584e82405033e.jpg\" style=\"\" title=\"572c89f8cb1a4.jpg\"/></p><p><br/></p>', 'ChiHe company website', '205', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwlyshdc_hz2qdpbeutw584e8276100b5.jpg', '2', '/data/upload/2016-05-06/572c89f8c6383.jpghttp://ohjmksy46.bkt.clouddn.com/image/iwlysjoo_5uzd5tjzktoo584e8279bc539.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlysiww_5h2whs3ltusk584e8278afeae.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlysi54_7eby9xxyh3k8584e8277edbb8.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlyshdc_45hcd16xgdog584e8276856e1.jpg,http://ohjmksy46.bkt.clouddn.com/image/iwlyshdc_10ato2d3edeo584e827620671.jpg,', '', '1462536696', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('23', 'Enterprise website development and design', 'Enterprise website development and design', '9', '0', 'Enterprise website development and design', '', '1', 'Rainfer studio', '<p>- enterprise image / product website design and development</p><p>- Group official website design and development</p><p>Taobao / Tmall store visual design</p><p>-html5+css3</p><p>- Web site design and production</p>', 'Enterprise website development and design', '203', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwly77xs_6iu4nitx6t8g584e7e96d19e9.jpg', '1', '', '', '1462537144', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('24', 'Website UI design', 'Website UI design', '9', '0', 'Website UI design', '', '1', 'Rainfer studio', '<p style=\"white-space: normal;\"><strong><span style=\"color: rgb(0, 176, 240);\">1 user studies</span></strong></p><p style=\"white-space: normal;\">User research is a comprehensive use of field observation, interviews, questionnaires, focus groups and other methods to obtain user needs and product usage preferences. The actual needs of the user to become a guide to product design, so that products more in line with the user&#39;s habits, experience and expectations.</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong>2 Interactive Design</strong></span></p><p style=\"white-space: normal;\">Product interaction process design, based on the analysis of the results of the availability of interactive mode, operation and jump process, structure, layout, information and other elements.</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong>3 interface design</strong></span></p><p style=\"white-space: normal;\">Provide mobile device UI design, APP interface design, high quality web design.</p>', 'Website UI design', '200', '1', 'http://ohjmksy46.bkt.clouddn.com/image/iwly5mu8_59wmqgg8cxwk584e7e4ca9838.jpg', '1', '', '', '1462537217', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('25', 'ThinkPHP two development', 'ThinkPHP two development', '9', '0', 'ThinkPHP two development', '', '1', 'Rainfer studio', '<p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \"Microsoft YaHei\", Lato, \"Helvetica Neue\", Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">Focus on the ThinkPHP program two development projects, to provide from the architecture design, needs analysis, design planning, program development, to the deployment of operation and maintenance of the whole outsourcing services. The company has strong technical research and development strength, standardized development process, rich experience, can design solutions for different industries.</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong><span style=\"font-family: 微软雅黑, \"Microsoft YaHei\";\">Contain：</span></strong></span></p><p style=\"white-space: normal;\"><span style=\"font-family: 微软雅黑, \"Microsoft YaHei\"; font-size: 14px;\"></span></p><p style=\"white-space: normal;\">Change the use of the ThinkPHP framework for the development of the program;</p><p style=\"white-space: normal;\">Use ThinkPHP framework development capabilities;</p><p style=\"white-space: normal;\">Project based on ThinkPHP framework;</p><p style=\"white-space: normal;\">Use ThinkPHP to visit the web site;</p>', 'ThinkPHP two development', '201', '1', 'http://ohjmksy46.bkt.clouddn.com/image/iwly33sg_274wp4ptqxog584e7dd646a37.jpg', '1', '', '', '1462537270', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('26', 'Two development of YFCMF', 'Two development of YFCMF', '9', '0', 'Two development of YFCMF', '', '1', 'Rainfer studio', '<p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \"Microsoft YaHei\", Lato, \"Helvetica Neue\", Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\">YFCMF is a PHP+MYSQL based development of the Chinese content management framework. YFCMF proposes a flexible application mechanism, the framework itself provides the basis of management functions, and developers can be based on their own needs in the form of application to expand. Each application can independently complete its own tasks, but also through the system to call other applications to work together. In this mechanism, the development of shopping application users how to work without concern for the development of SNS application, but they also can be coordinated by the system itself, greatly reducing the development cost and communication cost.</p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \"Microsoft YaHei\", Lato, \"Helvetica Neue\", Helvetica, Arial, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(0, 176, 240);\"><strong>Contain：</strong></span></p><p style=\"white-space: normal;\">Program modification based on YFCMF framework development project</p><p style=\"white-space: normal;\">Improve the function of YFCMF framework</p><p style=\"white-space: normal;\">Add YFCMF function module</p><p style=\"white-space: normal;\">Use YFCMF to rewrite the website project</p>', 'Two development of YFCMF', '200', '1', 'http://ohjmksy46.bkt.clouddn.com/image/iwly0vjk_1pvo3gniqf6s584e7d6e373c2.jpg', '1', '', '', '1462537316', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('27', 'ThinkPHP, YFCMF plug customization', 'plug customization', '9', '0', 'plug customization', '', '1', 'Rainfer studio', '<p style=\"white-space: normal;\">The plug-in is used to achieve a simple display and data processing functions. Plug-ins can be turned on and off, but will not affect the original system code;</p><p style=\"white-space: normal;\">Through the plug-in, it is convenient to install and uninstall through the background to achieve a certain function, before the success of WP, a lot of reasons are rich in the theme, a large number of plug-ins to choose.</p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \" microsoft=\"\" helvetica=\"\" font-size:=\"\" line-height:=\"\" background-color:=\"\"><span style=\"color: rgb(51, 51, 51); font-family: \" microsoft=\"\"></span><br/></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \" microsoft=\"\" helvetica=\"\" font-size:=\"\" line-height:=\"\" background-color:=\"\"><span style=\"color: rgb(0, 176, 240);\"><strong><span style=\"font-family: \" microsoft=\"\">Contain：</span></strong></span></p><p style=\"margin-top: 0px; margin-bottom: 10px; white-space: normal; color: rgb(85, 85, 85); font-family: \" microsoft=\"\" helvetica=\"\" font-size:=\"\" line-height:=\"\" background-color:=\"\"><span style=\"color: rgb(51, 51, 51); font-family: \" microsoft=\"\"></span></p><p style=\"white-space: normal;\">ThinkPHP project plug-in customization</p><p style=\"white-space: normal;\">YFCMF project plug-in customization</p>', 'ThinkPHP, YFCMF plug customization', '204', '1', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4tuzk_4pqkfvi4xcmc584eaa149782d.jpg', '1', '', '', '1462537365', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('28', 'YFCMF function customization', 'YFCMF function customization', '9', '0', 'YFCMF function customization', '', '1', 'Rainfer studio', '<p style=\"white-space: normal;\">For different industries, different enterprises, the use of YFCMF framework for development, according to the customer&#39;s functional requirements analysis, design and develop a dedicated function for the solution of specific programs.</p><p style=\"white-space: normal;\"><span style=\"color: rgb(0, 176, 240);\"><strong>Contain：</strong></span></p><p style=\"white-space: normal;\">Improvement of existing function</p><p style=\"white-space: normal;\">Add new features</p>', 'YFCMF function customization', '211', '1', 'http://ohjmksy46.bkt.clouddn.com/image/iwlx2tgo_dy8h0zscta0584e77390c73f.jpg', '1', '', '', '1462537410', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '2', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('29', 'A teacher for a day is a lifelong learning Designer', 'A teacher for a day is a lifelong learning Designer', '12', '0', 'A teacher for a day is a lifelong learning Designer', '', '1', 'Rainfer studio', '<p>We all have this feeling, before becoming a designer, all of the \"designer\" career of these three words are very envious, I hope you can call us as Dongguan designer. When the customer is respected as a designer, we are very proud and happy. But I hope you understand, designers not only design the occupation name, because he assumes the role of the teachers in the design or function, so remember the moment: a teacher for a day is a lifelong learning designer.</p><p>What is a designer? Why do you want to understand the concept of \"teacher\"? In fact, I was transposition thinking, that is, standing in the customer&#39;s point of view, to give full consideration to why he wants to find you to do the design of the reasons? If you find out the reason is to find your own design. While their transposition thought, can not find the reason for the division of words, so naturally you is not the designer, then call you when every designer in others, a lot of thinking how a designer? The designers of the division, but also the need for us to work hard every day and learning, and constantly improve their design level and comprehensive quality. Let oneself from designer to designer&#39;s transformation, the designer can afford a teacher.</p><p>To do the design, don&#39;t spoil the design.</p><p>This sentence is I think a long time to come out, although it seems very boring, I think it is very important. Start the design of the early friends, please always remember this sentence, and then leave a blank, let your own thinking. Because a lot of people in the list, only thinking is the list is a profit, but ignored the design itself caused by the bad.</p><p>I have witnessed a Shanghai strategy of the company, a company in Wenzhou for their brand promotion projects, the company sent to analyze customer business background and the actual situation, if not up to your requirements, give up the operation of the project, even if customers pay more fees, also insisted would give up. I did not understand, why give so much money do not do? I understand why their company has been so successful, because they only do the design, not bad design, that is their long-term development and maintain strategic principles.</p><p>So in the early days of entrepreneurship, I also choose customers to start with the principle, as far as possible to make good design to find their own.</p><p>Highlight is the advantage.</p><p>Must be highlighted, as a designer must have a bright spot. Now the mouse will use the software of the people have said that he is a designer, the Art Department of graduation and designers more and more talent, the industry&#39;s competitive is one of the manifestations of this era. Large and small studio design company and even some people sneer at innumerable, now more than WC design company. At this time the designer must make their own unique, entrepreneurial designers operating companies also want to have differences, and highlight the advantages, it is very important.</p><p>Design is not good or bad, only right and wrong.</p><p>Above I say good design and bad design, nature is the premise of the design. And the design has good and bad? I would like to use the right and wrong to look at this issue. As a designer, he is not an artist and a business division, first of all should be for the owners to solve practical problems, is the design. People who do not understand the design will say that the design is good or not, why do you say that? Because any of the works have his regret, even if it is a master of the five star hotel is a regret, so it is not good to determine. Starting point and purpose of different nature, the nature of the design requirements and the nature is different, contrary to the original intention of the design to lose significance, but also how to talk about good or bad? So in the right and wrong to think about design, will be more accurate for customers to solve practical problems, to find the true meaning of design!</p><p><br/></p>', 'We all have this feeling, before becoming a designer, all of the \"designer\" career of these three wo', '216', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm3i7pk_2bm4soh1lnwg584ea1654aa2d.jpg', '1', '', '', '1462538523', '50', '0', 'p,d', '', '0', '0', '1', '0', '1', '2', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('30', 'The core and essence of brand value is the soul of brand design', 'The core and essence of brand value is the soul of brand design', '12', '0', 'The core and essence of brand value is the soul of brand design', '', '1', 'Rainfer studio', '<p>In modern times, no matter big or small design company in Dongguan, most of Dongguan attaches great importance to brand design, but look, how many products on the market. What are the reasons for this? But two points: 1, before the brand design, brand positioning is not clear; 2, the concept of fuzzy brand positioning, brand design company by the company staff&#39;s subjective preferences as the judgment.</p><p>The design itself must have thought, soul, purpose. The product is sold to whom, what is their normal way of life? Want to convey to them what kind of information? What do you want them to look at the brand? We want to guide them how to do it? How we can close to the true inner need and so on. These problems, not you like and do not like the problem.</p><p>1, clear brand positioning: positioning of brand design is to solve the problem of what the brand is and what is not. What is this and what is not, does not mean the product attributes, but means that your brand represents what does not mean anything.</p><p>2, highlight the core value of the brand: brand core value is the core of brand design and core, but also the intrinsic driving force and cohesion of the brand. In the trend of increasing homogenization of products, the most important factors that affect consumers often is no longer the product entity, but the core value of the brand reflects the target consumers with or way of life and spiritual pursuit, which is to promote consumers to keep the core strength of brand loyalty.</p><p><br/></p>', 'In modern times, no matter big or small design company in Dongguan, most of Dongguan attaches great ', '212', '4', 'http://ohjmksy46.bkt.clouddn.com/image/iwm3gh7k_55qzhrmx3gw8584ea114a5cda.jpg', '1', '', '', '1462539100', '50', '0', 'c,p', '', '0', '0', '1', '0', '1', '10', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('31', 'Dongguan brand design is the tip of the iceberg, but it is essential!', 'Dongguan brand design is the tip of the iceberg, but it is essential!', '12', '0', 'Dongguan brand design is the tip of the iceberg, but it is essential!', '', '1', 'Rainfer studio', '<p>When the world entered the era of brand competition, when the brand has become a hot spot in the business world, brand design has become a popular word in the mouth. There are statistics that each investment enterprises in brand image design on the $1, the profit of $227 So attractive rate of return on investment, it is no wonder that business circles to scramble for the brand design. So, what is the brand design? Where does the charm come from?</p><p>1, design is the tip of the iceberg, but it is very important! If we understand the brand as an iceberg. The elements of brand or the cultural system, employee behavior, organizational structure, core technology, marketing etc. constitute the main body of this iceberg, though hidden in the water, is the most powerful brand development support and impetus.</p><p>But all of this must be recognized by the public through a series of complete and effective visual design and brand promotion.</p><p>Think how important it is!</p><p>2, return to the origin, essence of excavation project or product design principle is! Sofa design Fukazawa Naohito told us, put aside the seat cushion and the backrest sofa appearance and so on, but in fact, it is just a stool. The designer wants to think as much as possible, according to the corresponding design. So our proposal is not to rush things, may wish to calm down, think about this project or product is the most obvious characteristics of what their target customers and consumer groups and what......</p><p>What kind of design do?</p><p>3, simple, clear, the concept is our design principles! Simple, clear is the most concise and intuitive way, to achieve effective visual communication and communication, to reject all unrealistic symbolic meaning and the so-called connotation.</p><p>The concept is the ingenious original design idea and the application, gives the human by the accident pleasantly surprised, causes the human to be impressive thus powerfully promotes the enterprise image and the cultural connotation.</p><p>4, for the customer to do the right design! Mr. Lu Xun says he&#39;s dressed:\"...... Thin people don&#39;t wear black clothes, fat people don&#39;t wear white clothes; feet long women must wear black shoes, short legs would wear white shoes; the Plaid Dress fat people can not wear, but better than the cross grid; grid cross fat people wear, put more fat to both sides of the crack with more width, fat should wear vertical stripes, vertical to horizontal is long, the people wide......\" Design is also the case, the right is good! Just right!</p>', 'When the world entered the era of brand competition, when the brand has become a hot spot in the bus', '338', '4', 'http://ohjmksy46.bkt.clouddn.com/image/iwm3eqpk_3zlvefll60is584ea0c3802fc.jpg', '1', '', '', '1462539160', '50', '0', 'a,p', '', '0', '0', '1', '0', '1', '49', '{\"showdate\":1462464000}', 'en-us');
INSERT INTO `x_news` VALUES ('32', 'A hardware factory in Dongguan', 'A hardware factory in Dongguan', '13', '0', 'A hardware factory in Dongguan', '', '1', 'Ms. Cheng', '<p>Thanks to the rain fly on time to ensure the quality of the studio to complete the site construction company, through the cooperation fully reflects the extent of the project team on the rain fly studio project in technology, but also lay a foundation for future cooperation. Rain fly studio is very ideal partner.</p>', 'Thanks to the rain fly on time to ensure the quality of the studio to complete the site construction', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4qcg0_wzzkcazr15w584ea9701d74c.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm3cdu0_589rpl5vr0ws584ea055a80de.jpg,', '', '1462579633', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');
INSERT INTO `x_news` VALUES ('33', 'ChiHe company website', 'ChiHe company website', '13', '0', 'ChiHe company website', '', '1', 'Mr. Sun', '<p>Rainfer studio is a young team, full of vigor and vitality of the team, the design of the strength of the team, the spirit of customer first team.</p>', 'Rainfer studio is a young team, full of vigor and vitality of the team, the design of the strength o', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4qlpc_1bheweuwck9w584ea97c2a628.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm3amk8_5mv935witns4584ea003b5156.jpg,', '', '1462580217', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');
INSERT INTO `x_news` VALUES ('34', 'Learn net', 'Learn net', '13', '0', 'Learn net', '', '1', 'Mr. Peng', '<p>Be able to adapt to changes in customer needs and provide appropriate solutions in a timely manner, efficient and fast, with excellent service team.</p>', 'Be able to adapt to changes in customer needs and provide appropriate solutions in a timely manner, ', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4qu6w_1buq5730qrgg584ea9872ab70.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm386lk_3094jzd7gskk584e9f9160a10.jpg,', '', '1462580295', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');
INSERT INTO `x_news` VALUES ('35', 'Shilong E', 'Shilong E', '13', '0', 'Shilong E', '', '1', 'Mr. Zhang', '<p>All throughout the project development tasks project team responsible, responsible for the completion of the yard were successfully come, leaders are very satisfied, thank the rainfer studio.</p>', 'All throughout the project development tasks project team responsible, responsible for the completio', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4r3g8_46d6d4vzvhk4584ea99386382.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm35zw8_4oytwbkhpjeo584e9f2b96d2c.jpg,', '', '1462580360', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');
INSERT INTO `x_news` VALUES ('36', 'A catering company in Dongguan', 'A catering company in Dongguan', '13', '0', 'A catering company in Dongguan', '', '1', 'Mr. Xie', '<p>Rainfer studio is a young, positive team, for our company to provide various types of Web services really do a thorough and thoughtful, so we feel very at ease.</p>', 'Rainfer studio is a young, positive team, for our company to provide various types of Web services r', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4rcpk_263o39wi3n34584ea99f45b71.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm33q3s_2dfrp2likxxc584e9ec14c437.jpg,', '', '1462580412', '22', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');
INSERT INTO `x_news` VALUES ('37', 'Guangzhou sanitary ware company', 'Guangzhou sanitary ware company', '13', '0', 'Guangzhou sanitary ware company', '', '1', 'Ms. Wu', '<p>Rainfer studio is pre production or post maintenance, can do their duties, is the satisfaction of our partners.</p>', 'Rainfer studio is pre production or post maintenance, can do their duties, is the satisfaction of ou', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4rkfc_3uuzkenxzmgw584ea9a97bf31.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm31ers_4r2b9ncngdc0584e9e5598b1e.jpg,', '', '1462580465', '50', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');
INSERT INTO `x_news` VALUES ('38', 'Food company website', 'Food company website', '13', '0', 'Food company website', '', '1', 'Mr. Wang', '<p>Rainfer studio is an excellent team, they have excellent technology and high quality service, in cooperation with our company project, reflects the strength of their production of large company website.</p>', 'Rainfer studio is an excellent team, they have excellent technology and high quality service, in co', '200', '0', 'http://ohjmksy46.bkt.clouddn.com/image/iwm4rrdc_6t6deo2l0rs4584ea9b2dad96.jpg', '2', 'http://ohjmksy46.bkt.clouddn.com/image/iwm2whaw_5ru3c0ww26g4584e9d6fb9849.jpg,', '', '1462580522', '45', '0', 'p', '', '0', '0', '1', '0', '1', '0', '{\"showdate\":1462550400}', 'en-us');

-- ----------------------------
-- Table structure for x_oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `x_oauth_user`;
CREATE TABLE `x_oauth_user` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `oauth_from` varchar(20) NOT NULL COMMENT '用户来源key',
  `name` varchar(30) NOT NULL COMMENT '第三方昵称',
  `head_img` varchar(200) NOT NULL COMMENT '头像',
  `uid` int(20) NOT NULL COMMENT '关联的本站用户id',
  `create_time` datetime NOT NULL COMMENT '绑定时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `login_times` int(6) NOT NULL COMMENT '登录次数',
  `user_status` tinyint(2) NOT NULL DEFAULT '1',
  `access_token` varchar(512) NOT NULL,
  `expires_date` int(11) NOT NULL COMMENT 'access_token过期时间',
  `openid` varchar(40) NOT NULL COMMENT '第三方用户id',
  `unionid` varchar(40) DEFAULT '' COMMENT 'weixin wechat的unionid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='第三方用户表';

-- ----------------------------
-- Records of x_oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for x_options
-- ----------------------------
DROP TABLE IF EXISTS `x_options`;
CREATE TABLE `x_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  `option_l` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='全站配置表';

-- ----------------------------
-- Records of x_options
-- ----------------------------
INSERT INTO `x_options` VALUES ('1', 'email_options', '{\"email_open\":\"0\",\"email_rename\":\"\",\"email_name\":\"\",\"email_smtpname\":\"\",\"smtpsecure\":\"\",\"smtp_port\":\"\",\"email_emname\":\"\",\"email_pwd\":\"\"}', '1', 'zh-cn');
INSERT INTO `x_options` VALUES ('2', 'active_options', '{\"email_active\":\"0\",\"email_title\":\"YFCMF\\u8d26\\u53f7\\u6fc0\\u6d3b\\u901a\\u77e5\",\"email_tpl\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.rainfer.cn\\/\\\" style=\\\"white-space: normal;\\\">YFCMF<\\/a><br style=\\\"white-space: normal;\\\"\\/><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;<strong style=\\\"white-space: normal;\\\">---------------<\\/strong><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;<strong style=\\\"white-space: normal;\\\">\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;<strong style=\\\"white-space: normal;\\\">---------------<\\/strong><br style=\\\"white-space: normal;\\\"\\/><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"font-family: Arial; color: rgb(51, 51, 51); line-height: 18px; background-color: rgb(255, 255, 255);\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fYFCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;&nbsp;<a title=\\\"\\\" href=\\\"http:\\/#link#\\\" target=\\\"_self\\\" style=\\\"white-space: normal;\\\">http:\\/\\/#link#<\\/a><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br style=\\\"white-space: normal;\\\"\\/><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; YFCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1', 'zh-cn');
INSERT INTO `x_options` VALUES ('3', 'weixin_options', '{\"wesys_name\":\"\",\"wesys_id\":\"\",\"wesys_number\":\"\",\"wesys_appid\":\"\",\"wesys_appsecret\":\"\",\"wesys_type\":\"2\"}', '1', 'zh-cn');
INSERT INTO `x_options` VALUES ('4', 'email_options', '{\"email_open\":\"0\",\"email_rename\":\"\",\"email_name\":\"\",\"email_smtpname\":\"\",\"smtpsecure\":\"\",\"smtp_port\":\"\",\"email_emname\":\"\",\"email_pwd\":\"\"}', '1', 'en-us');
INSERT INTO `x_options` VALUES ('5', 'active_options', '{\"email_active\":\"0\",\"email_title\":\"YFCMF Account activation notification\",\"email_tpl\":\"<p>This email comes from&nbsp;<a href=\\\"http:\\/\\/www.rainfer.cn\\/\\\" style=\\\"white-space: normal;\\\">YFCMF<\\/a><br style=\\\"white-space: normal;\\\"\\/><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;<strong style=\\\"white-space: normal;\\\">---------------<\\/strong><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;<strong style=\\\"white-space: normal;\\\">Account activation description<\\/strong><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp;<strong style=\\\"white-space: normal;\\\">---------------<\\/strong><br style=\\\"white-space: normal;\\\"\\/><br style=\\\"white-space: normal;\\\"\\/>Dear&nbsp;<span style=\\\"font-family: Arial; color: rgb(51, 51, 51); line-height: 18px; background-color: rgb(255, 255, 255);\\\">#username#,<\\/span><\\/p><p>&nbsp;If you are a new user of YFCMF, or use this address when modifying your registration Email, we need to verify your address validity in order to avoid spam or address abuse.<\\/p><p>&nbsp;You only need to click the link below to activate your account:&nbsp; &nbsp;&nbsp;<\\/p><p><a title=\\\"\\\" href=\\\"http:\\/#link#\\\" target=\\\"_self\\\" style=\\\"white-space: normal;\\\">http:\\/\\/#link#<\\/a><br style=\\\"white-space: normal;\\\"\\/>&nbsp;(If it is not linked to the form, please paste the address manually into the browser address bar to access.)<\\/p><p>&nbsp;Thank you for your visit, I wish you a happy!&nbsp; &nbsp;&nbsp;<\\/p><p><br\\/><\\/p><p>Best regards!<\\/p><p><br style=\\\"white-space: normal;\\\"\\/>&nbsp; &nbsp; YFCMF management team<\\/p>\"}', '1', 'en-us');
INSERT INTO `x_options` VALUES ('6', 'weixin_options', '{\"wesys_name\":\"\",\"wesys_id\":\"\",\"wesys_number\":\"\",\"wesys_appid\":\"\",\"wesys_appsecret\":\"\",\"wesys_type\":\"2\"}', '1', 'en-us');
INSERT INTO `x_options` VALUES ('7', 'site_options', '            {\n            		\"site_name\":\"xrepair\",\n					\"site_host\":\"http://localhost/\",\n					\"site_tpl\":\"default\",\n					\"site_tpl_m\":\"default\",\n					\"site_icp\":\"\",\n					\"site_tongji\":\"\",\n					\"site_copyright\":\"\",\n					\"site_co_name\":\"\",\n					\"site_address\":\"\",\n					\"map_lat\":\"23.029759\",\n					\"map_lng\":\"113.752114\",\n					\"site_tel\":\"+86 769 8888 8888\",\n					\"site_admin_email\":\"xiaomak@qq.com\",\n					\"site_qq\":\"81818832\",\n					\"site_seo_title\":\"xrepair\",\n					\"site_seo_keywords\":\"XRepair\",\n					\"site_seo_description\":\"XRepair\",\n					\"site_logo\":\"http://ohjmksy46.bkt.clouddn.com/image/iw7sxvxs_6n9tgd6cbu4o58417156d5943.png\"\n        }\n		', '1', 'zh-cn');
INSERT INTO `x_options` VALUES ('8', 'site_options', '            {\n            		\"site_name\":\"xrepair\",\n					\"site_host\":\"http://localhost/\",\n					\"site_tpl\":\"default\",\n					\"site_tpl_m\":\"default\",\n					\"site_icp\":\"\",\n					\"site_tongji\":\"\",\n					\"site_copyright\":\"\",\n					\"site_co_name\":\"\",\n					\"site_address\":\"\",\n					\"map_lat\":\"23.029759\",\n					\"map_lng\":\"113.752114\",\n					\"site_tel\":\"+86 769 8888 8888\",\n					\"site_admin_email\":\"xiaomak@qq.com\",\n					\"site_qq\":\"81818832\",\n					\"site_seo_title\":\"xrepair\",\n					\"site_seo_keywords\":\"XRepair\",\n					\"site_seo_description\":\"XRepair\",\n					\"site_logo\":\"http://ohjmksy46.bkt.clouddn.com/image/iw7sxvxs_6n9tgd6cbu4o58417156d5943.png\"\n        }\n		', '1', 'en-us');

-- ----------------------------
-- Table structure for x_payment
-- ----------------------------
DROP TABLE IF EXISTS `x_payment`;
CREATE TABLE `x_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(100) DEFAULT '' COMMENT '商品订单',
  `pay_trade_no` varchar(100) DEFAULT NULL COMMENT '支付订单号',
  `money` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '订单金额',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '订单状态',
  `type` varchar(50) DEFAULT '' COMMENT '支付方式',
  `uid` int(11) DEFAULT NULL COMMENT '付款uid',
  `create_time` int(11) DEFAULT NULL COMMENT '排序',
  `update_time` int(10) unsigned DEFAULT NULL COMMENT '订单更新时间',
  `client_ip` varchar(50) DEFAULT '' COMMENT '支付ip',
  `product_name` varchar(200) DEFAULT '' COMMENT '商品名称',
  `product_body` varchar(200) DEFAULT '' COMMENT '商品描述',
  `product_url` varchar(100) DEFAULT '' COMMENT '商品地址',
  `extra_param` varchar(500) DEFAULT '' COMMENT '特殊扩展',
  `payment_cid` varchar(100) NOT NULL DEFAULT '未填写' COMMENT '前台栏目',
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `out_trade_no` (`out_trade_no`),
  UNIQUE KEY `pay_trade_no` (`pay_trade_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_payment
-- ----------------------------

-- ----------------------------
-- Table structure for x_plug_ad
-- ----------------------------
DROP TABLE IF EXISTS `x_plug_ad`;
CREATE TABLE `x_plug_ad` (
  `plug_ad_id` int(11) NOT NULL AUTO_INCREMENT,
  `plug_ad_name` varchar(50) NOT NULL DEFAULT '' COMMENT '广告名称',
  `plug_ad_adtypeid` tinyint(5) NOT NULL COMMENT '所属位置',
  `plug_ad_checkid` tinyint(2) NOT NULL COMMENT '1=图片 2=JS',
  `plug_ad_js` varchar(255) NOT NULL COMMENT 'JS代码',
  `plug_ad_pic` varchar(200) NOT NULL DEFAULT '' COMMENT '广告图片URL',
  `plug_ad_url` varchar(200) NOT NULL DEFAULT '' COMMENT '广告链接',
  `plug_ad_content` text COMMENT '广告文字内容',
  `plug_ad_addtime` int(11) NOT NULL COMMENT '添加时间',
  `plug_ad_order` int(11) NOT NULL COMMENT '排序',
  `plug_ad_open` tinyint(2) NOT NULL COMMENT '1=审核  0=未审核',
  `plug_ad_depid` int(5) NOT NULL COMMENT '广告投放单位或个人',
  `plug_ad_butt` int(5) NOT NULL COMMENT '广告内部对接人员（自己的员工）',
  `plug_ad_l` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`plug_ad_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_plug_ad
-- ----------------------------
INSERT INTO `x_plug_ad` VALUES ('1', '为什么选择我们？', '1', '1', '', 'http://ohjmksy46.bkt.clouddn.com/image/iw7upo8g_706ml271j1s858417cf6e11a9.jpg', '', '深厚的技术力量\r\n丰富的行业经验\r\n高效的作业流程\r\n完善的服务体系\r\n众多的成功案例', '1451356484', '50', '1', '0', '0', 'zh-cn');
INSERT INTO `x_plug_ad` VALUES ('2', '我们能帮您哪些？', '1', '1', '', 'http://ohjmksy46.bkt.clouddn.com/image/iw7uq7iw_17vba6gddvdw58417d0f2728b.jpg', '', '企业网站开发设计\r\n网站UI设计\r\nThinkPHP二次开发\r\nThinkCMF二次开发\r\nTP插件开发定制\r\nThinkCMF功能定制', '1462533829', '50', '1', '0', '0', 'zh-cn');
INSERT INTO `x_plug_ad` VALUES ('3', 'Why do you choose us?', '1', '1', '', 'http://ohjmksy46.bkt.clouddn.com/image/iw7upo8g_706ml271j1s858417cf6e11a9.jpg', '', 'Profound technical strength\nRich experience in the industry\nEfficient operation process\nPerfect service system\nA large number of successful cases', '1451356484', '50', '1', '0', '0', 'en-us');
INSERT INTO `x_plug_ad` VALUES ('4', 'What can we do for you?', '1', '1', '', 'http://ohjmksy46.bkt.clouddn.com/image/iw7uq7iw_17vba6gddvdw58417d0f2728b.jpg', '', 'Enterprise website development and design\nWebsite UI design\nThinkPHP two development\nYFCMF two development\nTP plug-in development\nYFCMF function customization', '1462533829', '50', '1', '0', '0', 'en-us');

-- ----------------------------
-- Table structure for x_plug_adtype
-- ----------------------------
DROP TABLE IF EXISTS `x_plug_adtype`;
CREATE TABLE `x_plug_adtype` (
  `plug_adtype_id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `plug_adtype_name` varchar(50) NOT NULL DEFAULT '' COMMENT '广告位名称',
  `plug_adtype_order` int(11) NOT NULL COMMENT '广告位排序',
  PRIMARY KEY (`plug_adtype_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_plug_adtype
-- ----------------------------
INSERT INTO `x_plug_adtype` VALUES ('1', '首页图片轮播', '50');

-- ----------------------------
-- Table structure for x_plug_files
-- ----------------------------
DROP TABLE IF EXISTS `x_plug_files`;
CREATE TABLE `x_plug_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uptime` int(10) unsigned NOT NULL DEFAULT '0',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `path` varchar(255) DEFAULT '' COMMENT '路径',
  PRIMARY KEY (`id`),
  KEY `uptime` (`uptime`),
  KEY `path` (`path`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_plug_files
-- ----------------------------

-- ----------------------------
-- Table structure for x_plug_link
-- ----------------------------
DROP TABLE IF EXISTS `x_plug_link`;
CREATE TABLE `x_plug_link` (
  `plug_link_id` int(5) NOT NULL AUTO_INCREMENT,
  `plug_link_name` varchar(50) NOT NULL COMMENT '链接名称',
  `plug_link_url` varchar(200) NOT NULL COMMENT '链接URL',
  `plug_link_target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '打开方式',
  `plug_link_typeid` tinyint(4) DEFAULT NULL COMMENT '所属栏目ID',
  `plug_link_qq` varchar(20) NOT NULL COMMENT '联系QQ',
  `plug_link_order` varchar(10) NOT NULL DEFAULT '50' COMMENT '排序',
  `plug_link_addtime` int(11) NOT NULL COMMENT '添加时间',
  `plug_link_open` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0禁用1启用',
  `plug_link_l` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`plug_link_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_plug_link
-- ----------------------------
INSERT INTO `x_plug_link` VALUES ('1', '雨飞工作室', 'http://www.rainfer.cn', '_blank', '1', 'eee', '50', '1460260482', '1', 'zh-cn');
INSERT INTO `x_plug_link` VALUES ('2', '雨飞工作室', 'http://www.rainfer.cn', '_blank', '2', '81818832', '50', '1460362536', '1', 'zh-cn');
INSERT INTO `x_plug_link` VALUES ('3', 'YFCMF', 'http://www.rainfer.cn', '_blank', '1', '', '50', '1461909470', '1', 'zh-cn');
INSERT INTO `x_plug_link` VALUES ('4', 'Rainfer studio', 'http://www.rainfer.cn', '_blank', '1', 'eee', '50', '1460260482', '1', 'en-us');
INSERT INTO `x_plug_link` VALUES ('5', 'Rainfer studio', 'http://www.rainfer.cn', '_blank', '2', '81818832', '50', '1460362536', '1', 'en-us');
INSERT INTO `x_plug_link` VALUES ('6', 'YFCMF', 'http://www.rainfer.cn', '_blank', '1', '', '50', '1461909470', '1', 'en-us');

-- ----------------------------
-- Table structure for x_plug_linktype
-- ----------------------------
DROP TABLE IF EXISTS `x_plug_linktype`;
CREATE TABLE `x_plug_linktype` (
  `plug_linktype_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `plug_linktype_name` varchar(30) NOT NULL COMMENT '所属栏目名称',
  `plug_linktype_order` varchar(10) NOT NULL COMMENT '排序',
  PRIMARY KEY (`plug_linktype_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_plug_linktype
-- ----------------------------
INSERT INTO `x_plug_linktype` VALUES ('1', '首页', '1');
INSERT INTO `x_plug_linktype` VALUES ('2', '新闻中心', '50');

-- ----------------------------
-- Table structure for x_plug_sug
-- ----------------------------
DROP TABLE IF EXISTS `x_plug_sug`;
CREATE TABLE `x_plug_sug` (
  `plug_sug_id` int(11) NOT NULL AUTO_INCREMENT,
  `plug_sug_name` varchar(200) NOT NULL DEFAULT '' COMMENT '留言人姓名',
  `plug_sug_email` varchar(50) NOT NULL DEFAULT '' COMMENT '留言邮箱',
  `plug_sug_addtime` int(11) NOT NULL COMMENT '留言时间',
  `plug_sug_open` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1=已回复 0=未回复',
  `plug_sug_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '留言者IP',
  `plug_sug_content` longtext NOT NULL COMMENT '留言内容',
  PRIMARY KEY (`plug_sug_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_plug_sug
-- ----------------------------

-- ----------------------------
-- Table structure for x_region
-- ----------------------------
DROP TABLE IF EXISTS `x_region`;
CREATE TABLE `x_region` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(120) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3726 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_region
-- ----------------------------
INSERT INTO `x_region` VALUES ('1', '0', '中国', '0');
INSERT INTO `x_region` VALUES ('2', '1', '北京', '1');
INSERT INTO `x_region` VALUES ('3', '1', '安徽', '1');
INSERT INTO `x_region` VALUES ('4', '1', '福建', '1');
INSERT INTO `x_region` VALUES ('5', '1', '甘肃', '1');
INSERT INTO `x_region` VALUES ('6', '1', '广东', '1');
INSERT INTO `x_region` VALUES ('7', '1', '广西', '1');
INSERT INTO `x_region` VALUES ('8', '1', '贵州', '1');
INSERT INTO `x_region` VALUES ('9', '1', '海南', '1');
INSERT INTO `x_region` VALUES ('10', '1', '河北', '1');
INSERT INTO `x_region` VALUES ('11', '1', '河南', '1');
INSERT INTO `x_region` VALUES ('12', '1', '黑龙江', '1');
INSERT INTO `x_region` VALUES ('13', '1', '湖北', '1');
INSERT INTO `x_region` VALUES ('14', '1', '湖南', '1');
INSERT INTO `x_region` VALUES ('15', '1', '吉林', '1');
INSERT INTO `x_region` VALUES ('16', '1', '江苏', '1');
INSERT INTO `x_region` VALUES ('17', '1', '江西', '1');
INSERT INTO `x_region` VALUES ('18', '1', '辽宁', '1');
INSERT INTO `x_region` VALUES ('19', '1', '内蒙古', '1');
INSERT INTO `x_region` VALUES ('20', '1', '宁夏', '1');
INSERT INTO `x_region` VALUES ('21', '1', '青海', '1');
INSERT INTO `x_region` VALUES ('22', '1', '山东', '1');
INSERT INTO `x_region` VALUES ('23', '1', '山西', '1');
INSERT INTO `x_region` VALUES ('24', '1', '陕西', '1');
INSERT INTO `x_region` VALUES ('25', '1', '上海', '1');
INSERT INTO `x_region` VALUES ('26', '1', '四川', '1');
INSERT INTO `x_region` VALUES ('27', '1', '天津', '1');
INSERT INTO `x_region` VALUES ('28', '1', '西藏', '1');
INSERT INTO `x_region` VALUES ('29', '1', '新疆', '1');
INSERT INTO `x_region` VALUES ('30', '1', '云南', '1');
INSERT INTO `x_region` VALUES ('31', '1', '浙江', '1');
INSERT INTO `x_region` VALUES ('32', '1', '重庆', '1');
INSERT INTO `x_region` VALUES ('33', '1', '香港', '1');
INSERT INTO `x_region` VALUES ('34', '1', '澳门', '1');
INSERT INTO `x_region` VALUES ('35', '1', '台湾', '1');
INSERT INTO `x_region` VALUES ('36', '3', '安庆', '2');
INSERT INTO `x_region` VALUES ('37', '3', '蚌埠', '2');
INSERT INTO `x_region` VALUES ('38', '3', '巢湖', '2');
INSERT INTO `x_region` VALUES ('39', '3', '池州', '2');
INSERT INTO `x_region` VALUES ('40', '3', '滁州', '2');
INSERT INTO `x_region` VALUES ('41', '3', '阜阳', '2');
INSERT INTO `x_region` VALUES ('42', '3', '淮北', '2');
INSERT INTO `x_region` VALUES ('43', '3', '淮南', '2');
INSERT INTO `x_region` VALUES ('44', '3', '黄山', '2');
INSERT INTO `x_region` VALUES ('45', '3', '六安', '2');
INSERT INTO `x_region` VALUES ('46', '3', '马鞍山', '2');
INSERT INTO `x_region` VALUES ('47', '3', '宿州', '2');
INSERT INTO `x_region` VALUES ('48', '3', '铜陵', '2');
INSERT INTO `x_region` VALUES ('49', '3', '芜湖', '2');
INSERT INTO `x_region` VALUES ('50', '3', '宣城', '2');
INSERT INTO `x_region` VALUES ('51', '3', '亳州', '2');
INSERT INTO `x_region` VALUES ('52', '2', '北京', '2');
INSERT INTO `x_region` VALUES ('53', '4', '福州', '2');
INSERT INTO `x_region` VALUES ('54', '4', '龙岩', '2');
INSERT INTO `x_region` VALUES ('55', '4', '南平', '2');
INSERT INTO `x_region` VALUES ('56', '4', '宁德', '2');
INSERT INTO `x_region` VALUES ('57', '4', '莆田', '2');
INSERT INTO `x_region` VALUES ('58', '4', '泉州', '2');
INSERT INTO `x_region` VALUES ('59', '4', '三明', '2');
INSERT INTO `x_region` VALUES ('60', '4', '厦门', '2');
INSERT INTO `x_region` VALUES ('61', '4', '漳州', '2');
INSERT INTO `x_region` VALUES ('62', '5', '兰州', '2');
INSERT INTO `x_region` VALUES ('63', '5', '白银', '2');
INSERT INTO `x_region` VALUES ('64', '5', '定西', '2');
INSERT INTO `x_region` VALUES ('65', '5', '甘南', '2');
INSERT INTO `x_region` VALUES ('66', '5', '嘉峪关', '2');
INSERT INTO `x_region` VALUES ('67', '5', '金昌', '2');
INSERT INTO `x_region` VALUES ('68', '5', '酒泉', '2');
INSERT INTO `x_region` VALUES ('69', '5', '临夏', '2');
INSERT INTO `x_region` VALUES ('70', '5', '陇南', '2');
INSERT INTO `x_region` VALUES ('71', '5', '平凉', '2');
INSERT INTO `x_region` VALUES ('72', '5', '庆阳', '2');
INSERT INTO `x_region` VALUES ('73', '5', '天水', '2');
INSERT INTO `x_region` VALUES ('74', '5', '武威', '2');
INSERT INTO `x_region` VALUES ('75', '5', '张掖', '2');
INSERT INTO `x_region` VALUES ('76', '6', '广州', '2');
INSERT INTO `x_region` VALUES ('77', '6', '深圳', '2');
INSERT INTO `x_region` VALUES ('78', '6', '潮州', '2');
INSERT INTO `x_region` VALUES ('79', '6', '东莞', '2');
INSERT INTO `x_region` VALUES ('80', '6', '佛山', '2');
INSERT INTO `x_region` VALUES ('81', '6', '河源', '2');
INSERT INTO `x_region` VALUES ('82', '6', '惠州', '2');
INSERT INTO `x_region` VALUES ('83', '6', '江门', '2');
INSERT INTO `x_region` VALUES ('84', '6', '揭阳', '2');
INSERT INTO `x_region` VALUES ('85', '6', '茂名', '2');
INSERT INTO `x_region` VALUES ('86', '6', '梅州', '2');
INSERT INTO `x_region` VALUES ('87', '6', '清远', '2');
INSERT INTO `x_region` VALUES ('88', '6', '汕头', '2');
INSERT INTO `x_region` VALUES ('89', '6', '汕尾', '2');
INSERT INTO `x_region` VALUES ('90', '6', '韶关', '2');
INSERT INTO `x_region` VALUES ('91', '6', '阳江', '2');
INSERT INTO `x_region` VALUES ('92', '6', '云浮', '2');
INSERT INTO `x_region` VALUES ('93', '6', '湛江', '2');
INSERT INTO `x_region` VALUES ('94', '6', '肇庆', '2');
INSERT INTO `x_region` VALUES ('95', '6', '中山', '2');
INSERT INTO `x_region` VALUES ('96', '6', '珠海', '2');
INSERT INTO `x_region` VALUES ('97', '7', '南宁', '2');
INSERT INTO `x_region` VALUES ('98', '7', '桂林', '2');
INSERT INTO `x_region` VALUES ('99', '7', '百色', '2');
INSERT INTO `x_region` VALUES ('100', '7', '北海', '2');
INSERT INTO `x_region` VALUES ('101', '7', '崇左', '2');
INSERT INTO `x_region` VALUES ('102', '7', '防城港', '2');
INSERT INTO `x_region` VALUES ('103', '7', '贵港', '2');
INSERT INTO `x_region` VALUES ('104', '7', '河池', '2');
INSERT INTO `x_region` VALUES ('105', '7', '贺州', '2');
INSERT INTO `x_region` VALUES ('106', '7', '来宾', '2');
INSERT INTO `x_region` VALUES ('107', '7', '柳州', '2');
INSERT INTO `x_region` VALUES ('108', '7', '钦州', '2');
INSERT INTO `x_region` VALUES ('109', '7', '梧州', '2');
INSERT INTO `x_region` VALUES ('110', '7', '玉林', '2');
INSERT INTO `x_region` VALUES ('111', '8', '贵阳', '2');
INSERT INTO `x_region` VALUES ('112', '8', '安顺', '2');
INSERT INTO `x_region` VALUES ('113', '8', '毕节', '2');
INSERT INTO `x_region` VALUES ('114', '8', '六盘水', '2');
INSERT INTO `x_region` VALUES ('115', '8', '黔东南', '2');
INSERT INTO `x_region` VALUES ('116', '8', '黔南', '2');
INSERT INTO `x_region` VALUES ('117', '8', '黔西南', '2');
INSERT INTO `x_region` VALUES ('118', '8', '铜仁', '2');
INSERT INTO `x_region` VALUES ('119', '8', '遵义', '2');
INSERT INTO `x_region` VALUES ('120', '9', '海口', '2');
INSERT INTO `x_region` VALUES ('121', '9', '三亚', '2');
INSERT INTO `x_region` VALUES ('122', '9', '白沙', '2');
INSERT INTO `x_region` VALUES ('123', '9', '保亭', '2');
INSERT INTO `x_region` VALUES ('124', '9', '昌江', '2');
INSERT INTO `x_region` VALUES ('125', '9', '澄迈县', '2');
INSERT INTO `x_region` VALUES ('126', '9', '定安县', '2');
INSERT INTO `x_region` VALUES ('127', '9', '东方', '2');
INSERT INTO `x_region` VALUES ('128', '9', '乐东', '2');
INSERT INTO `x_region` VALUES ('129', '9', '临高县', '2');
INSERT INTO `x_region` VALUES ('130', '9', '陵水', '2');
INSERT INTO `x_region` VALUES ('131', '9', '琼海', '2');
INSERT INTO `x_region` VALUES ('132', '9', '琼中', '2');
INSERT INTO `x_region` VALUES ('133', '9', '屯昌县', '2');
INSERT INTO `x_region` VALUES ('134', '9', '万宁', '2');
INSERT INTO `x_region` VALUES ('135', '9', '文昌', '2');
INSERT INTO `x_region` VALUES ('136', '9', '五指山', '2');
INSERT INTO `x_region` VALUES ('137', '9', '儋州', '2');
INSERT INTO `x_region` VALUES ('138', '10', '石家庄', '2');
INSERT INTO `x_region` VALUES ('139', '10', '保定', '2');
INSERT INTO `x_region` VALUES ('140', '10', '沧州', '2');
INSERT INTO `x_region` VALUES ('141', '10', '承德', '2');
INSERT INTO `x_region` VALUES ('142', '10', '邯郸', '2');
INSERT INTO `x_region` VALUES ('143', '10', '衡水', '2');
INSERT INTO `x_region` VALUES ('144', '10', '廊坊', '2');
INSERT INTO `x_region` VALUES ('145', '10', '秦皇岛', '2');
INSERT INTO `x_region` VALUES ('146', '10', '唐山', '2');
INSERT INTO `x_region` VALUES ('147', '10', '邢台', '2');
INSERT INTO `x_region` VALUES ('148', '10', '张家口', '2');
INSERT INTO `x_region` VALUES ('149', '11', '郑州', '2');
INSERT INTO `x_region` VALUES ('150', '11', '洛阳', '2');
INSERT INTO `x_region` VALUES ('151', '11', '开封', '2');
INSERT INTO `x_region` VALUES ('152', '11', '安阳', '2');
INSERT INTO `x_region` VALUES ('153', '11', '鹤壁', '2');
INSERT INTO `x_region` VALUES ('154', '11', '济源', '2');
INSERT INTO `x_region` VALUES ('155', '11', '焦作', '2');
INSERT INTO `x_region` VALUES ('156', '11', '南阳', '2');
INSERT INTO `x_region` VALUES ('157', '11', '平顶山', '2');
INSERT INTO `x_region` VALUES ('158', '11', '三门峡', '2');
INSERT INTO `x_region` VALUES ('159', '11', '商丘', '2');
INSERT INTO `x_region` VALUES ('160', '11', '新乡', '2');
INSERT INTO `x_region` VALUES ('161', '11', '信阳', '2');
INSERT INTO `x_region` VALUES ('162', '11', '许昌', '2');
INSERT INTO `x_region` VALUES ('163', '11', '周口', '2');
INSERT INTO `x_region` VALUES ('164', '11', '驻马店', '2');
INSERT INTO `x_region` VALUES ('165', '11', '漯河', '2');
INSERT INTO `x_region` VALUES ('166', '11', '濮阳', '2');
INSERT INTO `x_region` VALUES ('167', '12', '哈尔滨', '2');
INSERT INTO `x_region` VALUES ('168', '12', '大庆', '2');
INSERT INTO `x_region` VALUES ('169', '12', '大兴安岭', '2');
INSERT INTO `x_region` VALUES ('170', '12', '鹤岗', '2');
INSERT INTO `x_region` VALUES ('171', '12', '黑河', '2');
INSERT INTO `x_region` VALUES ('172', '12', '鸡西', '2');
INSERT INTO `x_region` VALUES ('173', '12', '佳木斯', '2');
INSERT INTO `x_region` VALUES ('174', '12', '牡丹江', '2');
INSERT INTO `x_region` VALUES ('175', '12', '七台河', '2');
INSERT INTO `x_region` VALUES ('176', '12', '齐齐哈尔', '2');
INSERT INTO `x_region` VALUES ('177', '12', '双鸭山', '2');
INSERT INTO `x_region` VALUES ('178', '12', '绥化', '2');
INSERT INTO `x_region` VALUES ('179', '12', '伊春', '2');
INSERT INTO `x_region` VALUES ('180', '13', '武汉', '2');
INSERT INTO `x_region` VALUES ('181', '13', '仙桃', '2');
INSERT INTO `x_region` VALUES ('182', '13', '鄂州', '2');
INSERT INTO `x_region` VALUES ('183', '13', '黄冈', '2');
INSERT INTO `x_region` VALUES ('184', '13', '黄石', '2');
INSERT INTO `x_region` VALUES ('185', '13', '荆门', '2');
INSERT INTO `x_region` VALUES ('186', '13', '荆州', '2');
INSERT INTO `x_region` VALUES ('187', '13', '潜江', '2');
INSERT INTO `x_region` VALUES ('188', '13', '神农架林区', '2');
INSERT INTO `x_region` VALUES ('189', '13', '十堰', '2');
INSERT INTO `x_region` VALUES ('190', '13', '随州', '2');
INSERT INTO `x_region` VALUES ('191', '13', '天门', '2');
INSERT INTO `x_region` VALUES ('192', '13', '咸宁', '2');
INSERT INTO `x_region` VALUES ('193', '13', '襄樊', '2');
INSERT INTO `x_region` VALUES ('194', '13', '孝感', '2');
INSERT INTO `x_region` VALUES ('195', '13', '宜昌', '2');
INSERT INTO `x_region` VALUES ('196', '13', '恩施', '2');
INSERT INTO `x_region` VALUES ('197', '14', '长沙', '2');
INSERT INTO `x_region` VALUES ('198', '14', '张家界', '2');
INSERT INTO `x_region` VALUES ('199', '14', '常德', '2');
INSERT INTO `x_region` VALUES ('200', '14', '郴州', '2');
INSERT INTO `x_region` VALUES ('201', '14', '衡阳', '2');
INSERT INTO `x_region` VALUES ('202', '14', '怀化', '2');
INSERT INTO `x_region` VALUES ('203', '14', '娄底', '2');
INSERT INTO `x_region` VALUES ('204', '14', '邵阳', '2');
INSERT INTO `x_region` VALUES ('205', '14', '湘潭', '2');
INSERT INTO `x_region` VALUES ('206', '14', '湘西', '2');
INSERT INTO `x_region` VALUES ('207', '14', '益阳', '2');
INSERT INTO `x_region` VALUES ('208', '14', '永州', '2');
INSERT INTO `x_region` VALUES ('209', '14', '岳阳', '2');
INSERT INTO `x_region` VALUES ('210', '14', '株洲', '2');
INSERT INTO `x_region` VALUES ('211', '15', '长春', '2');
INSERT INTO `x_region` VALUES ('212', '15', '吉林', '2');
INSERT INTO `x_region` VALUES ('213', '15', '白城', '2');
INSERT INTO `x_region` VALUES ('214', '15', '白山', '2');
INSERT INTO `x_region` VALUES ('215', '15', '辽源', '2');
INSERT INTO `x_region` VALUES ('216', '15', '四平', '2');
INSERT INTO `x_region` VALUES ('217', '15', '松原', '2');
INSERT INTO `x_region` VALUES ('218', '15', '通化', '2');
INSERT INTO `x_region` VALUES ('219', '15', '延边', '2');
INSERT INTO `x_region` VALUES ('220', '16', '南京', '2');
INSERT INTO `x_region` VALUES ('221', '16', '苏州', '2');
INSERT INTO `x_region` VALUES ('222', '16', '无锡', '2');
INSERT INTO `x_region` VALUES ('223', '16', '常州', '2');
INSERT INTO `x_region` VALUES ('224', '16', '淮安', '2');
INSERT INTO `x_region` VALUES ('225', '16', '连云港', '2');
INSERT INTO `x_region` VALUES ('226', '16', '南通', '2');
INSERT INTO `x_region` VALUES ('227', '16', '宿迁', '2');
INSERT INTO `x_region` VALUES ('228', '16', '泰州', '2');
INSERT INTO `x_region` VALUES ('229', '16', '徐州', '2');
INSERT INTO `x_region` VALUES ('230', '16', '盐城', '2');
INSERT INTO `x_region` VALUES ('231', '16', '扬州', '2');
INSERT INTO `x_region` VALUES ('232', '16', '镇江', '2');
INSERT INTO `x_region` VALUES ('233', '17', '南昌', '2');
INSERT INTO `x_region` VALUES ('234', '17', '抚州', '2');
INSERT INTO `x_region` VALUES ('235', '17', '赣州', '2');
INSERT INTO `x_region` VALUES ('236', '17', '吉安', '2');
INSERT INTO `x_region` VALUES ('237', '17', '景德镇', '2');
INSERT INTO `x_region` VALUES ('238', '17', '九江', '2');
INSERT INTO `x_region` VALUES ('239', '17', '萍乡', '2');
INSERT INTO `x_region` VALUES ('240', '17', '上饶', '2');
INSERT INTO `x_region` VALUES ('241', '17', '新余', '2');
INSERT INTO `x_region` VALUES ('242', '17', '宜春', '2');
INSERT INTO `x_region` VALUES ('243', '17', '鹰潭', '2');
INSERT INTO `x_region` VALUES ('244', '18', '沈阳', '2');
INSERT INTO `x_region` VALUES ('245', '18', '大连', '2');
INSERT INTO `x_region` VALUES ('246', '18', '鞍山', '2');
INSERT INTO `x_region` VALUES ('247', '18', '本溪', '2');
INSERT INTO `x_region` VALUES ('248', '18', '朝阳', '2');
INSERT INTO `x_region` VALUES ('249', '18', '丹东', '2');
INSERT INTO `x_region` VALUES ('250', '18', '抚顺', '2');
INSERT INTO `x_region` VALUES ('251', '18', '阜新', '2');
INSERT INTO `x_region` VALUES ('252', '18', '葫芦岛', '2');
INSERT INTO `x_region` VALUES ('253', '18', '锦州', '2');
INSERT INTO `x_region` VALUES ('254', '18', '辽阳', '2');
INSERT INTO `x_region` VALUES ('255', '18', '盘锦', '2');
INSERT INTO `x_region` VALUES ('256', '18', '铁岭', '2');
INSERT INTO `x_region` VALUES ('257', '18', '营口', '2');
INSERT INTO `x_region` VALUES ('258', '19', '呼和浩特', '2');
INSERT INTO `x_region` VALUES ('259', '19', '阿拉善盟', '2');
INSERT INTO `x_region` VALUES ('260', '19', '巴彦淖尔盟', '2');
INSERT INTO `x_region` VALUES ('261', '19', '包头', '2');
INSERT INTO `x_region` VALUES ('262', '19', '赤峰', '2');
INSERT INTO `x_region` VALUES ('263', '19', '鄂尔多斯', '2');
INSERT INTO `x_region` VALUES ('264', '19', '呼伦贝尔', '2');
INSERT INTO `x_region` VALUES ('265', '19', '通辽', '2');
INSERT INTO `x_region` VALUES ('266', '19', '乌海', '2');
INSERT INTO `x_region` VALUES ('267', '19', '乌兰察布市', '2');
INSERT INTO `x_region` VALUES ('268', '19', '锡林郭勒盟', '2');
INSERT INTO `x_region` VALUES ('269', '19', '兴安盟', '2');
INSERT INTO `x_region` VALUES ('270', '20', '银川', '2');
INSERT INTO `x_region` VALUES ('271', '20', '固原', '2');
INSERT INTO `x_region` VALUES ('272', '20', '石嘴山', '2');
INSERT INTO `x_region` VALUES ('273', '20', '吴忠', '2');
INSERT INTO `x_region` VALUES ('274', '20', '中卫', '2');
INSERT INTO `x_region` VALUES ('275', '21', '西宁', '2');
INSERT INTO `x_region` VALUES ('276', '21', '果洛', '2');
INSERT INTO `x_region` VALUES ('277', '21', '海北', '2');
INSERT INTO `x_region` VALUES ('278', '21', '海东', '2');
INSERT INTO `x_region` VALUES ('279', '21', '海南', '2');
INSERT INTO `x_region` VALUES ('280', '21', '海西', '2');
INSERT INTO `x_region` VALUES ('281', '21', '黄南', '2');
INSERT INTO `x_region` VALUES ('282', '21', '玉树', '2');
INSERT INTO `x_region` VALUES ('283', '22', '济南', '2');
INSERT INTO `x_region` VALUES ('284', '22', '青岛', '2');
INSERT INTO `x_region` VALUES ('285', '22', '滨州', '2');
INSERT INTO `x_region` VALUES ('286', '22', '德州', '2');
INSERT INTO `x_region` VALUES ('287', '22', '东营', '2');
INSERT INTO `x_region` VALUES ('288', '22', '菏泽', '2');
INSERT INTO `x_region` VALUES ('289', '22', '济宁', '2');
INSERT INTO `x_region` VALUES ('290', '22', '莱芜', '2');
INSERT INTO `x_region` VALUES ('291', '22', '聊城', '2');
INSERT INTO `x_region` VALUES ('292', '22', '临沂', '2');
INSERT INTO `x_region` VALUES ('293', '22', '日照', '2');
INSERT INTO `x_region` VALUES ('294', '22', '泰安', '2');
INSERT INTO `x_region` VALUES ('295', '22', '威海', '2');
INSERT INTO `x_region` VALUES ('296', '22', '潍坊', '2');
INSERT INTO `x_region` VALUES ('297', '22', '烟台', '2');
INSERT INTO `x_region` VALUES ('298', '22', '枣庄', '2');
INSERT INTO `x_region` VALUES ('299', '22', '淄博', '2');
INSERT INTO `x_region` VALUES ('300', '23', '太原', '2');
INSERT INTO `x_region` VALUES ('301', '23', '长治', '2');
INSERT INTO `x_region` VALUES ('302', '23', '大同', '2');
INSERT INTO `x_region` VALUES ('303', '23', '晋城', '2');
INSERT INTO `x_region` VALUES ('304', '23', '晋中', '2');
INSERT INTO `x_region` VALUES ('305', '23', '临汾', '2');
INSERT INTO `x_region` VALUES ('306', '23', '吕梁', '2');
INSERT INTO `x_region` VALUES ('307', '23', '朔州', '2');
INSERT INTO `x_region` VALUES ('308', '23', '忻州', '2');
INSERT INTO `x_region` VALUES ('309', '23', '阳泉', '2');
INSERT INTO `x_region` VALUES ('310', '23', '运城', '2');
INSERT INTO `x_region` VALUES ('311', '24', '西安', '2');
INSERT INTO `x_region` VALUES ('312', '24', '安康', '2');
INSERT INTO `x_region` VALUES ('313', '24', '宝鸡', '2');
INSERT INTO `x_region` VALUES ('314', '24', '汉中', '2');
INSERT INTO `x_region` VALUES ('315', '24', '商洛', '2');
INSERT INTO `x_region` VALUES ('316', '24', '铜川', '2');
INSERT INTO `x_region` VALUES ('317', '24', '渭南', '2');
INSERT INTO `x_region` VALUES ('318', '24', '咸阳', '2');
INSERT INTO `x_region` VALUES ('319', '24', '延安', '2');
INSERT INTO `x_region` VALUES ('320', '24', '榆林', '2');
INSERT INTO `x_region` VALUES ('321', '25', '上海', '2');
INSERT INTO `x_region` VALUES ('322', '26', '成都', '2');
INSERT INTO `x_region` VALUES ('323', '26', '绵阳', '2');
INSERT INTO `x_region` VALUES ('324', '26', '阿坝', '2');
INSERT INTO `x_region` VALUES ('325', '26', '巴中', '2');
INSERT INTO `x_region` VALUES ('326', '26', '达州', '2');
INSERT INTO `x_region` VALUES ('327', '26', '德阳', '2');
INSERT INTO `x_region` VALUES ('328', '26', '甘孜', '2');
INSERT INTO `x_region` VALUES ('329', '26', '广安', '2');
INSERT INTO `x_region` VALUES ('330', '26', '广元', '2');
INSERT INTO `x_region` VALUES ('331', '26', '乐山', '2');
INSERT INTO `x_region` VALUES ('332', '26', '凉山', '2');
INSERT INTO `x_region` VALUES ('333', '26', '眉山', '2');
INSERT INTO `x_region` VALUES ('334', '26', '南充', '2');
INSERT INTO `x_region` VALUES ('335', '26', '内江', '2');
INSERT INTO `x_region` VALUES ('336', '26', '攀枝花', '2');
INSERT INTO `x_region` VALUES ('337', '26', '遂宁', '2');
INSERT INTO `x_region` VALUES ('338', '26', '雅安', '2');
INSERT INTO `x_region` VALUES ('339', '26', '宜宾', '2');
INSERT INTO `x_region` VALUES ('340', '26', '资阳', '2');
INSERT INTO `x_region` VALUES ('341', '26', '自贡', '2');
INSERT INTO `x_region` VALUES ('342', '26', '泸州', '2');
INSERT INTO `x_region` VALUES ('343', '27', '天津', '2');
INSERT INTO `x_region` VALUES ('344', '28', '拉萨', '2');
INSERT INTO `x_region` VALUES ('345', '28', '阿里', '2');
INSERT INTO `x_region` VALUES ('346', '28', '昌都', '2');
INSERT INTO `x_region` VALUES ('347', '28', '林芝', '2');
INSERT INTO `x_region` VALUES ('348', '28', '那曲', '2');
INSERT INTO `x_region` VALUES ('349', '28', '日喀则', '2');
INSERT INTO `x_region` VALUES ('350', '28', '山南', '2');
INSERT INTO `x_region` VALUES ('351', '29', '乌鲁木齐', '2');
INSERT INTO `x_region` VALUES ('352', '29', '阿克苏', '2');
INSERT INTO `x_region` VALUES ('353', '29', '阿拉尔', '2');
INSERT INTO `x_region` VALUES ('354', '29', '巴音郭楞', '2');
INSERT INTO `x_region` VALUES ('355', '29', '博尔塔拉', '2');
INSERT INTO `x_region` VALUES ('356', '29', '昌吉', '2');
INSERT INTO `x_region` VALUES ('357', '29', '哈密', '2');
INSERT INTO `x_region` VALUES ('358', '29', '和田', '2');
INSERT INTO `x_region` VALUES ('359', '29', '喀什', '2');
INSERT INTO `x_region` VALUES ('360', '29', '克拉玛依', '2');
INSERT INTO `x_region` VALUES ('361', '29', '克孜勒苏', '2');
INSERT INTO `x_region` VALUES ('362', '29', '石河子', '2');
INSERT INTO `x_region` VALUES ('363', '29', '图木舒克', '2');
INSERT INTO `x_region` VALUES ('364', '29', '吐鲁番', '2');
INSERT INTO `x_region` VALUES ('365', '29', '五家渠', '2');
INSERT INTO `x_region` VALUES ('366', '29', '伊犁', '2');
INSERT INTO `x_region` VALUES ('367', '30', '昆明', '2');
INSERT INTO `x_region` VALUES ('368', '30', '怒江', '2');
INSERT INTO `x_region` VALUES ('369', '30', '普洱', '2');
INSERT INTO `x_region` VALUES ('370', '30', '丽江', '2');
INSERT INTO `x_region` VALUES ('371', '30', '保山', '2');
INSERT INTO `x_region` VALUES ('372', '30', '楚雄', '2');
INSERT INTO `x_region` VALUES ('373', '30', '大理', '2');
INSERT INTO `x_region` VALUES ('374', '30', '德宏', '2');
INSERT INTO `x_region` VALUES ('375', '30', '迪庆', '2');
INSERT INTO `x_region` VALUES ('376', '30', '红河', '2');
INSERT INTO `x_region` VALUES ('377', '30', '临沧', '2');
INSERT INTO `x_region` VALUES ('378', '30', '曲靖', '2');
INSERT INTO `x_region` VALUES ('379', '30', '文山', '2');
INSERT INTO `x_region` VALUES ('380', '30', '西双版纳', '2');
INSERT INTO `x_region` VALUES ('381', '30', '玉溪', '2');
INSERT INTO `x_region` VALUES ('382', '30', '昭通', '2');
INSERT INTO `x_region` VALUES ('383', '31', '杭州', '2');
INSERT INTO `x_region` VALUES ('384', '31', '湖州', '2');
INSERT INTO `x_region` VALUES ('385', '31', '嘉兴', '2');
INSERT INTO `x_region` VALUES ('386', '31', '金华', '2');
INSERT INTO `x_region` VALUES ('387', '31', '丽水', '2');
INSERT INTO `x_region` VALUES ('388', '31', '宁波', '2');
INSERT INTO `x_region` VALUES ('389', '31', '绍兴', '2');
INSERT INTO `x_region` VALUES ('390', '31', '台州', '2');
INSERT INTO `x_region` VALUES ('391', '31', '温州', '2');
INSERT INTO `x_region` VALUES ('392', '31', '舟山', '2');
INSERT INTO `x_region` VALUES ('393', '31', '衢州', '2');
INSERT INTO `x_region` VALUES ('394', '32', '重庆', '2');
INSERT INTO `x_region` VALUES ('395', '33', '香港', '2');
INSERT INTO `x_region` VALUES ('396', '34', '澳门', '2');
INSERT INTO `x_region` VALUES ('397', '35', '台湾', '2');
INSERT INTO `x_region` VALUES ('398', '36', '迎江区', '3');
INSERT INTO `x_region` VALUES ('399', '36', '大观区', '3');
INSERT INTO `x_region` VALUES ('400', '36', '宜秀区', '3');
INSERT INTO `x_region` VALUES ('401', '36', '桐城市', '3');
INSERT INTO `x_region` VALUES ('402', '36', '怀宁县', '3');
INSERT INTO `x_region` VALUES ('403', '36', '枞阳县', '3');
INSERT INTO `x_region` VALUES ('404', '36', '潜山县', '3');
INSERT INTO `x_region` VALUES ('405', '36', '太湖县', '3');
INSERT INTO `x_region` VALUES ('406', '36', '宿松县', '3');
INSERT INTO `x_region` VALUES ('407', '36', '望江县', '3');
INSERT INTO `x_region` VALUES ('408', '36', '岳西县', '3');
INSERT INTO `x_region` VALUES ('409', '37', '中市区', '3');
INSERT INTO `x_region` VALUES ('410', '37', '东市区', '3');
INSERT INTO `x_region` VALUES ('411', '37', '西市区', '3');
INSERT INTO `x_region` VALUES ('412', '37', '郊区', '3');
INSERT INTO `x_region` VALUES ('413', '37', '怀远县', '3');
INSERT INTO `x_region` VALUES ('414', '37', '五河县', '3');
INSERT INTO `x_region` VALUES ('415', '37', '固镇县', '3');
INSERT INTO `x_region` VALUES ('416', '38', '居巢区', '3');
INSERT INTO `x_region` VALUES ('417', '38', '庐江县', '3');
INSERT INTO `x_region` VALUES ('418', '38', '无为县', '3');
INSERT INTO `x_region` VALUES ('419', '38', '含山县', '3');
INSERT INTO `x_region` VALUES ('420', '38', '和县', '3');
INSERT INTO `x_region` VALUES ('421', '39', '贵池区', '3');
INSERT INTO `x_region` VALUES ('422', '39', '东至县', '3');
INSERT INTO `x_region` VALUES ('423', '39', '石台县', '3');
INSERT INTO `x_region` VALUES ('424', '39', '青阳县', '3');
INSERT INTO `x_region` VALUES ('425', '40', '琅琊区', '3');
INSERT INTO `x_region` VALUES ('426', '40', '南谯区', '3');
INSERT INTO `x_region` VALUES ('427', '40', '天长市', '3');
INSERT INTO `x_region` VALUES ('428', '40', '明光市', '3');
INSERT INTO `x_region` VALUES ('429', '40', '来安县', '3');
INSERT INTO `x_region` VALUES ('430', '40', '全椒县', '3');
INSERT INTO `x_region` VALUES ('431', '40', '定远县', '3');
INSERT INTO `x_region` VALUES ('432', '40', '凤阳县', '3');
INSERT INTO `x_region` VALUES ('433', '41', '蚌山区', '3');
INSERT INTO `x_region` VALUES ('434', '41', '龙子湖区', '3');
INSERT INTO `x_region` VALUES ('435', '41', '禹会区', '3');
INSERT INTO `x_region` VALUES ('436', '41', '淮上区', '3');
INSERT INTO `x_region` VALUES ('437', '41', '颍州区', '3');
INSERT INTO `x_region` VALUES ('438', '41', '颍东区', '3');
INSERT INTO `x_region` VALUES ('439', '41', '颍泉区', '3');
INSERT INTO `x_region` VALUES ('440', '41', '界首市', '3');
INSERT INTO `x_region` VALUES ('441', '41', '临泉县', '3');
INSERT INTO `x_region` VALUES ('442', '41', '太和县', '3');
INSERT INTO `x_region` VALUES ('443', '41', '阜南县', '3');
INSERT INTO `x_region` VALUES ('444', '41', '颖上县', '3');
INSERT INTO `x_region` VALUES ('445', '42', '相山区', '3');
INSERT INTO `x_region` VALUES ('446', '42', '杜集区', '3');
INSERT INTO `x_region` VALUES ('447', '42', '烈山区', '3');
INSERT INTO `x_region` VALUES ('448', '42', '濉溪县', '3');
INSERT INTO `x_region` VALUES ('449', '43', '田家庵区', '3');
INSERT INTO `x_region` VALUES ('450', '43', '大通区', '3');
INSERT INTO `x_region` VALUES ('451', '43', '谢家集区', '3');
INSERT INTO `x_region` VALUES ('452', '43', '八公山区', '3');
INSERT INTO `x_region` VALUES ('453', '43', '潘集区', '3');
INSERT INTO `x_region` VALUES ('454', '43', '凤台县', '3');
INSERT INTO `x_region` VALUES ('455', '44', '屯溪区', '3');
INSERT INTO `x_region` VALUES ('456', '44', '黄山区', '3');
INSERT INTO `x_region` VALUES ('457', '44', '徽州区', '3');
INSERT INTO `x_region` VALUES ('458', '44', '歙县', '3');
INSERT INTO `x_region` VALUES ('459', '44', '休宁县', '3');
INSERT INTO `x_region` VALUES ('460', '44', '黟县', '3');
INSERT INTO `x_region` VALUES ('461', '44', '祁门县', '3');
INSERT INTO `x_region` VALUES ('462', '45', '金安区', '3');
INSERT INTO `x_region` VALUES ('463', '45', '裕安区', '3');
INSERT INTO `x_region` VALUES ('464', '45', '寿县', '3');
INSERT INTO `x_region` VALUES ('465', '45', '霍邱县', '3');
INSERT INTO `x_region` VALUES ('466', '45', '舒城县', '3');
INSERT INTO `x_region` VALUES ('467', '45', '金寨县', '3');
INSERT INTO `x_region` VALUES ('468', '45', '霍山县', '3');
INSERT INTO `x_region` VALUES ('469', '46', '雨山区', '3');
INSERT INTO `x_region` VALUES ('470', '46', '花山区', '3');
INSERT INTO `x_region` VALUES ('471', '46', '金家庄区', '3');
INSERT INTO `x_region` VALUES ('472', '46', '当涂县', '3');
INSERT INTO `x_region` VALUES ('473', '47', '埇桥区', '3');
INSERT INTO `x_region` VALUES ('474', '47', '砀山县', '3');
INSERT INTO `x_region` VALUES ('475', '47', '萧县', '3');
INSERT INTO `x_region` VALUES ('476', '47', '灵璧县', '3');
INSERT INTO `x_region` VALUES ('477', '47', '泗县', '3');
INSERT INTO `x_region` VALUES ('478', '48', '铜官山区', '3');
INSERT INTO `x_region` VALUES ('479', '48', '狮子山区', '3');
INSERT INTO `x_region` VALUES ('480', '48', '郊区', '3');
INSERT INTO `x_region` VALUES ('481', '48', '铜陵县', '3');
INSERT INTO `x_region` VALUES ('482', '49', '镜湖区', '3');
INSERT INTO `x_region` VALUES ('483', '49', '弋江区', '3');
INSERT INTO `x_region` VALUES ('484', '49', '鸠江区', '3');
INSERT INTO `x_region` VALUES ('485', '49', '三山区', '3');
INSERT INTO `x_region` VALUES ('486', '49', '芜湖县', '3');
INSERT INTO `x_region` VALUES ('487', '49', '繁昌县', '3');
INSERT INTO `x_region` VALUES ('488', '49', '南陵县', '3');
INSERT INTO `x_region` VALUES ('489', '50', '宣州区', '3');
INSERT INTO `x_region` VALUES ('490', '50', '宁国市', '3');
INSERT INTO `x_region` VALUES ('491', '50', '郎溪县', '3');
INSERT INTO `x_region` VALUES ('492', '50', '广德县', '3');
INSERT INTO `x_region` VALUES ('493', '50', '泾县', '3');
INSERT INTO `x_region` VALUES ('494', '50', '绩溪县', '3');
INSERT INTO `x_region` VALUES ('495', '50', '旌德县', '3');
INSERT INTO `x_region` VALUES ('496', '51', '涡阳县', '3');
INSERT INTO `x_region` VALUES ('497', '51', '蒙城县', '3');
INSERT INTO `x_region` VALUES ('498', '51', '利辛县', '3');
INSERT INTO `x_region` VALUES ('499', '51', '谯城区', '3');
INSERT INTO `x_region` VALUES ('500', '52', '东城区', '3');
INSERT INTO `x_region` VALUES ('501', '52', '西城区', '3');
INSERT INTO `x_region` VALUES ('502', '52', '海淀区', '3');
INSERT INTO `x_region` VALUES ('503', '52', '朝阳区', '3');
INSERT INTO `x_region` VALUES ('504', '52', '崇文区', '3');
INSERT INTO `x_region` VALUES ('505', '52', '宣武区', '3');
INSERT INTO `x_region` VALUES ('506', '52', '丰台区', '3');
INSERT INTO `x_region` VALUES ('507', '52', '石景山区', '3');
INSERT INTO `x_region` VALUES ('508', '52', '房山区', '3');
INSERT INTO `x_region` VALUES ('509', '52', '门头沟区', '3');
INSERT INTO `x_region` VALUES ('510', '52', '通州区', '3');
INSERT INTO `x_region` VALUES ('511', '52', '顺义区', '3');
INSERT INTO `x_region` VALUES ('512', '52', '昌平区', '3');
INSERT INTO `x_region` VALUES ('513', '52', '怀柔区', '3');
INSERT INTO `x_region` VALUES ('514', '52', '平谷区', '3');
INSERT INTO `x_region` VALUES ('515', '52', '大兴区', '3');
INSERT INTO `x_region` VALUES ('516', '52', '密云县', '3');
INSERT INTO `x_region` VALUES ('517', '52', '延庆县', '3');
INSERT INTO `x_region` VALUES ('518', '53', '鼓楼区', '3');
INSERT INTO `x_region` VALUES ('519', '53', '台江区', '3');
INSERT INTO `x_region` VALUES ('520', '53', '仓山区', '3');
INSERT INTO `x_region` VALUES ('521', '53', '马尾区', '3');
INSERT INTO `x_region` VALUES ('522', '53', '晋安区', '3');
INSERT INTO `x_region` VALUES ('523', '53', '福清市', '3');
INSERT INTO `x_region` VALUES ('524', '53', '长乐市', '3');
INSERT INTO `x_region` VALUES ('525', '53', '闽侯县', '3');
INSERT INTO `x_region` VALUES ('526', '53', '连江县', '3');
INSERT INTO `x_region` VALUES ('527', '53', '罗源县', '3');
INSERT INTO `x_region` VALUES ('528', '53', '闽清县', '3');
INSERT INTO `x_region` VALUES ('529', '53', '永泰县', '3');
INSERT INTO `x_region` VALUES ('530', '53', '平潭县', '3');
INSERT INTO `x_region` VALUES ('531', '54', '新罗区', '3');
INSERT INTO `x_region` VALUES ('532', '54', '漳平市', '3');
INSERT INTO `x_region` VALUES ('533', '54', '长汀县', '3');
INSERT INTO `x_region` VALUES ('534', '54', '永定县', '3');
INSERT INTO `x_region` VALUES ('535', '54', '上杭县', '3');
INSERT INTO `x_region` VALUES ('536', '54', '武平县', '3');
INSERT INTO `x_region` VALUES ('537', '54', '连城县', '3');
INSERT INTO `x_region` VALUES ('538', '55', '延平区', '3');
INSERT INTO `x_region` VALUES ('539', '55', '邵武市', '3');
INSERT INTO `x_region` VALUES ('540', '55', '武夷山市', '3');
INSERT INTO `x_region` VALUES ('541', '55', '建瓯市', '3');
INSERT INTO `x_region` VALUES ('542', '55', '建阳市', '3');
INSERT INTO `x_region` VALUES ('543', '55', '顺昌县', '3');
INSERT INTO `x_region` VALUES ('544', '55', '浦城县', '3');
INSERT INTO `x_region` VALUES ('545', '55', '光泽县', '3');
INSERT INTO `x_region` VALUES ('546', '55', '松溪县', '3');
INSERT INTO `x_region` VALUES ('547', '55', '政和县', '3');
INSERT INTO `x_region` VALUES ('548', '56', '蕉城区', '3');
INSERT INTO `x_region` VALUES ('549', '56', '福安市', '3');
INSERT INTO `x_region` VALUES ('550', '56', '福鼎市', '3');
INSERT INTO `x_region` VALUES ('551', '56', '霞浦县', '3');
INSERT INTO `x_region` VALUES ('552', '56', '古田县', '3');
INSERT INTO `x_region` VALUES ('553', '56', '屏南县', '3');
INSERT INTO `x_region` VALUES ('554', '56', '寿宁县', '3');
INSERT INTO `x_region` VALUES ('555', '56', '周宁县', '3');
INSERT INTO `x_region` VALUES ('556', '56', '柘荣县', '3');
INSERT INTO `x_region` VALUES ('557', '57', '城厢区', '3');
INSERT INTO `x_region` VALUES ('558', '57', '涵江区', '3');
INSERT INTO `x_region` VALUES ('559', '57', '荔城区', '3');
INSERT INTO `x_region` VALUES ('560', '57', '秀屿区', '3');
INSERT INTO `x_region` VALUES ('561', '57', '仙游县', '3');
INSERT INTO `x_region` VALUES ('562', '58', '鲤城区', '3');
INSERT INTO `x_region` VALUES ('563', '58', '丰泽区', '3');
INSERT INTO `x_region` VALUES ('564', '58', '洛江区', '3');
INSERT INTO `x_region` VALUES ('565', '58', '清濛开发区', '3');
INSERT INTO `x_region` VALUES ('566', '58', '泉港区', '3');
INSERT INTO `x_region` VALUES ('567', '58', '石狮市', '3');
INSERT INTO `x_region` VALUES ('568', '58', '晋江市', '3');
INSERT INTO `x_region` VALUES ('569', '58', '南安市', '3');
INSERT INTO `x_region` VALUES ('570', '58', '惠安县', '3');
INSERT INTO `x_region` VALUES ('571', '58', '安溪县', '3');
INSERT INTO `x_region` VALUES ('572', '58', '永春县', '3');
INSERT INTO `x_region` VALUES ('573', '58', '德化县', '3');
INSERT INTO `x_region` VALUES ('574', '58', '金门县', '3');
INSERT INTO `x_region` VALUES ('575', '59', '梅列区', '3');
INSERT INTO `x_region` VALUES ('576', '59', '三元区', '3');
INSERT INTO `x_region` VALUES ('577', '59', '永安市', '3');
INSERT INTO `x_region` VALUES ('578', '59', '明溪县', '3');
INSERT INTO `x_region` VALUES ('579', '59', '清流县', '3');
INSERT INTO `x_region` VALUES ('580', '59', '宁化县', '3');
INSERT INTO `x_region` VALUES ('581', '59', '大田县', '3');
INSERT INTO `x_region` VALUES ('582', '59', '尤溪县', '3');
INSERT INTO `x_region` VALUES ('583', '59', '沙县', '3');
INSERT INTO `x_region` VALUES ('584', '59', '将乐县', '3');
INSERT INTO `x_region` VALUES ('585', '59', '泰宁县', '3');
INSERT INTO `x_region` VALUES ('586', '59', '建宁县', '3');
INSERT INTO `x_region` VALUES ('587', '60', '思明区', '3');
INSERT INTO `x_region` VALUES ('588', '60', '海沧区', '3');
INSERT INTO `x_region` VALUES ('589', '60', '湖里区', '3');
INSERT INTO `x_region` VALUES ('590', '60', '集美区', '3');
INSERT INTO `x_region` VALUES ('591', '60', '同安区', '3');
INSERT INTO `x_region` VALUES ('592', '60', '翔安区', '3');
INSERT INTO `x_region` VALUES ('593', '61', '芗城区', '3');
INSERT INTO `x_region` VALUES ('594', '61', '龙文区', '3');
INSERT INTO `x_region` VALUES ('595', '61', '龙海市', '3');
INSERT INTO `x_region` VALUES ('596', '61', '云霄县', '3');
INSERT INTO `x_region` VALUES ('597', '61', '漳浦县', '3');
INSERT INTO `x_region` VALUES ('598', '61', '诏安县', '3');
INSERT INTO `x_region` VALUES ('599', '61', '长泰县', '3');
INSERT INTO `x_region` VALUES ('600', '61', '东山县', '3');
INSERT INTO `x_region` VALUES ('601', '61', '南靖县', '3');
INSERT INTO `x_region` VALUES ('602', '61', '平和县', '3');
INSERT INTO `x_region` VALUES ('603', '61', '华安县', '3');
INSERT INTO `x_region` VALUES ('604', '62', '皋兰县', '3');
INSERT INTO `x_region` VALUES ('605', '62', '城关区', '3');
INSERT INTO `x_region` VALUES ('606', '62', '七里河区', '3');
INSERT INTO `x_region` VALUES ('607', '62', '西固区', '3');
INSERT INTO `x_region` VALUES ('608', '62', '安宁区', '3');
INSERT INTO `x_region` VALUES ('609', '62', '红古区', '3');
INSERT INTO `x_region` VALUES ('610', '62', '永登县', '3');
INSERT INTO `x_region` VALUES ('611', '62', '榆中县', '3');
INSERT INTO `x_region` VALUES ('612', '63', '白银区', '3');
INSERT INTO `x_region` VALUES ('613', '63', '平川区', '3');
INSERT INTO `x_region` VALUES ('614', '63', '会宁县', '3');
INSERT INTO `x_region` VALUES ('615', '63', '景泰县', '3');
INSERT INTO `x_region` VALUES ('616', '63', '靖远县', '3');
INSERT INTO `x_region` VALUES ('617', '64', '临洮县', '3');
INSERT INTO `x_region` VALUES ('618', '64', '陇西县', '3');
INSERT INTO `x_region` VALUES ('619', '64', '通渭县', '3');
INSERT INTO `x_region` VALUES ('620', '64', '渭源县', '3');
INSERT INTO `x_region` VALUES ('621', '64', '漳县', '3');
INSERT INTO `x_region` VALUES ('622', '64', '岷县', '3');
INSERT INTO `x_region` VALUES ('623', '64', '安定区', '3');
INSERT INTO `x_region` VALUES ('624', '64', '安定区', '3');
INSERT INTO `x_region` VALUES ('625', '65', '合作市', '3');
INSERT INTO `x_region` VALUES ('626', '65', '临潭县', '3');
INSERT INTO `x_region` VALUES ('627', '65', '卓尼县', '3');
INSERT INTO `x_region` VALUES ('628', '65', '舟曲县', '3');
INSERT INTO `x_region` VALUES ('629', '65', '迭部县', '3');
INSERT INTO `x_region` VALUES ('630', '65', '玛曲县', '3');
INSERT INTO `x_region` VALUES ('631', '65', '碌曲县', '3');
INSERT INTO `x_region` VALUES ('632', '65', '夏河县', '3');
INSERT INTO `x_region` VALUES ('633', '66', '嘉峪关市', '3');
INSERT INTO `x_region` VALUES ('634', '67', '金川区', '3');
INSERT INTO `x_region` VALUES ('635', '67', '永昌县', '3');
INSERT INTO `x_region` VALUES ('636', '68', '肃州区', '3');
INSERT INTO `x_region` VALUES ('637', '68', '玉门市', '3');
INSERT INTO `x_region` VALUES ('638', '68', '敦煌市', '3');
INSERT INTO `x_region` VALUES ('639', '68', '金塔县', '3');
INSERT INTO `x_region` VALUES ('640', '68', '瓜州县', '3');
INSERT INTO `x_region` VALUES ('641', '68', '肃北', '3');
INSERT INTO `x_region` VALUES ('642', '68', '阿克塞', '3');
INSERT INTO `x_region` VALUES ('643', '69', '临夏市', '3');
INSERT INTO `x_region` VALUES ('644', '69', '临夏县', '3');
INSERT INTO `x_region` VALUES ('645', '69', '康乐县', '3');
INSERT INTO `x_region` VALUES ('646', '69', '永靖县', '3');
INSERT INTO `x_region` VALUES ('647', '69', '广河县', '3');
INSERT INTO `x_region` VALUES ('648', '69', '和政县', '3');
INSERT INTO `x_region` VALUES ('649', '69', '东乡族自治县', '3');
INSERT INTO `x_region` VALUES ('650', '69', '积石山', '3');
INSERT INTO `x_region` VALUES ('651', '70', '成县', '3');
INSERT INTO `x_region` VALUES ('652', '70', '徽县', '3');
INSERT INTO `x_region` VALUES ('653', '70', '康县', '3');
INSERT INTO `x_region` VALUES ('654', '70', '礼县', '3');
INSERT INTO `x_region` VALUES ('655', '70', '两当县', '3');
INSERT INTO `x_region` VALUES ('656', '70', '文县', '3');
INSERT INTO `x_region` VALUES ('657', '70', '西和县', '3');
INSERT INTO `x_region` VALUES ('658', '70', '宕昌县', '3');
INSERT INTO `x_region` VALUES ('659', '70', '武都区', '3');
INSERT INTO `x_region` VALUES ('660', '71', '崇信县', '3');
INSERT INTO `x_region` VALUES ('661', '71', '华亭县', '3');
INSERT INTO `x_region` VALUES ('662', '71', '静宁县', '3');
INSERT INTO `x_region` VALUES ('663', '71', '灵台县', '3');
INSERT INTO `x_region` VALUES ('664', '71', '崆峒区', '3');
INSERT INTO `x_region` VALUES ('665', '71', '庄浪县', '3');
INSERT INTO `x_region` VALUES ('666', '71', '泾川县', '3');
INSERT INTO `x_region` VALUES ('667', '72', '合水县', '3');
INSERT INTO `x_region` VALUES ('668', '72', '华池县', '3');
INSERT INTO `x_region` VALUES ('669', '72', '环县', '3');
INSERT INTO `x_region` VALUES ('670', '72', '宁县', '3');
INSERT INTO `x_region` VALUES ('671', '72', '庆城县', '3');
INSERT INTO `x_region` VALUES ('672', '72', '西峰区', '3');
INSERT INTO `x_region` VALUES ('673', '72', '镇原县', '3');
INSERT INTO `x_region` VALUES ('674', '72', '正宁县', '3');
INSERT INTO `x_region` VALUES ('675', '73', '甘谷县', '3');
INSERT INTO `x_region` VALUES ('676', '73', '秦安县', '3');
INSERT INTO `x_region` VALUES ('677', '73', '清水县', '3');
INSERT INTO `x_region` VALUES ('678', '73', '秦州区', '3');
INSERT INTO `x_region` VALUES ('679', '73', '麦积区', '3');
INSERT INTO `x_region` VALUES ('680', '73', '武山县', '3');
INSERT INTO `x_region` VALUES ('681', '73', '张家川', '3');
INSERT INTO `x_region` VALUES ('682', '74', '古浪县', '3');
INSERT INTO `x_region` VALUES ('683', '74', '民勤县', '3');
INSERT INTO `x_region` VALUES ('684', '74', '天祝', '3');
INSERT INTO `x_region` VALUES ('685', '74', '凉州区', '3');
INSERT INTO `x_region` VALUES ('686', '75', '高台县', '3');
INSERT INTO `x_region` VALUES ('687', '75', '临泽县', '3');
INSERT INTO `x_region` VALUES ('688', '75', '民乐县', '3');
INSERT INTO `x_region` VALUES ('689', '75', '山丹县', '3');
INSERT INTO `x_region` VALUES ('690', '75', '肃南', '3');
INSERT INTO `x_region` VALUES ('691', '75', '甘州区', '3');
INSERT INTO `x_region` VALUES ('692', '76', '从化市', '3');
INSERT INTO `x_region` VALUES ('693', '76', '天河区', '3');
INSERT INTO `x_region` VALUES ('694', '76', '东山区', '3');
INSERT INTO `x_region` VALUES ('695', '76', '白云区', '3');
INSERT INTO `x_region` VALUES ('696', '76', '海珠区', '3');
INSERT INTO `x_region` VALUES ('697', '76', '荔湾区', '3');
INSERT INTO `x_region` VALUES ('698', '76', '越秀区', '3');
INSERT INTO `x_region` VALUES ('699', '76', '黄埔区', '3');
INSERT INTO `x_region` VALUES ('700', '76', '番禺区', '3');
INSERT INTO `x_region` VALUES ('701', '76', '花都区', '3');
INSERT INTO `x_region` VALUES ('702', '76', '增城区', '3');
INSERT INTO `x_region` VALUES ('703', '76', '从化区', '3');
INSERT INTO `x_region` VALUES ('704', '76', '市郊', '3');
INSERT INTO `x_region` VALUES ('705', '77', '福田区', '3');
INSERT INTO `x_region` VALUES ('706', '77', '罗湖区', '3');
INSERT INTO `x_region` VALUES ('707', '77', '南山区', '3');
INSERT INTO `x_region` VALUES ('708', '77', '宝安区', '3');
INSERT INTO `x_region` VALUES ('709', '77', '龙岗区', '3');
INSERT INTO `x_region` VALUES ('710', '77', '盐田区', '3');
INSERT INTO `x_region` VALUES ('711', '78', '湘桥区', '3');
INSERT INTO `x_region` VALUES ('712', '78', '潮安县', '3');
INSERT INTO `x_region` VALUES ('713', '78', '饶平县', '3');
INSERT INTO `x_region` VALUES ('714', '79', '南城区', '3');
INSERT INTO `x_region` VALUES ('715', '79', '东城区', '3');
INSERT INTO `x_region` VALUES ('716', '79', '万江区', '3');
INSERT INTO `x_region` VALUES ('717', '79', '莞城区', '3');
INSERT INTO `x_region` VALUES ('718', '79', '石龙镇', '3');
INSERT INTO `x_region` VALUES ('719', '79', '虎门镇', '3');
INSERT INTO `x_region` VALUES ('720', '79', '麻涌镇', '3');
INSERT INTO `x_region` VALUES ('721', '79', '道滘镇', '3');
INSERT INTO `x_region` VALUES ('722', '79', '石碣镇', '3');
INSERT INTO `x_region` VALUES ('723', '79', '沙田镇', '3');
INSERT INTO `x_region` VALUES ('724', '79', '望牛墩镇', '3');
INSERT INTO `x_region` VALUES ('725', '79', '洪梅镇', '3');
INSERT INTO `x_region` VALUES ('726', '79', '茶山镇', '3');
INSERT INTO `x_region` VALUES ('727', '79', '寮步镇', '3');
INSERT INTO `x_region` VALUES ('728', '79', '大岭山镇', '3');
INSERT INTO `x_region` VALUES ('729', '79', '大朗镇', '3');
INSERT INTO `x_region` VALUES ('730', '79', '黄江镇', '3');
INSERT INTO `x_region` VALUES ('731', '79', '樟木头', '3');
INSERT INTO `x_region` VALUES ('732', '79', '凤岗镇', '3');
INSERT INTO `x_region` VALUES ('733', '79', '塘厦镇', '3');
INSERT INTO `x_region` VALUES ('734', '79', '谢岗镇', '3');
INSERT INTO `x_region` VALUES ('735', '79', '厚街镇', '3');
INSERT INTO `x_region` VALUES ('736', '79', '清溪镇', '3');
INSERT INTO `x_region` VALUES ('737', '79', '常平镇', '3');
INSERT INTO `x_region` VALUES ('738', '79', '桥头镇', '3');
INSERT INTO `x_region` VALUES ('739', '79', '横沥镇', '3');
INSERT INTO `x_region` VALUES ('740', '79', '东坑镇', '3');
INSERT INTO `x_region` VALUES ('741', '79', '企石镇', '3');
INSERT INTO `x_region` VALUES ('742', '79', '石排镇', '3');
INSERT INTO `x_region` VALUES ('743', '79', '长安镇', '3');
INSERT INTO `x_region` VALUES ('744', '79', '中堂镇', '3');
INSERT INTO `x_region` VALUES ('745', '79', '高埗镇', '3');
INSERT INTO `x_region` VALUES ('746', '80', '禅城区', '3');
INSERT INTO `x_region` VALUES ('747', '80', '南海区', '3');
INSERT INTO `x_region` VALUES ('748', '80', '顺德区', '3');
INSERT INTO `x_region` VALUES ('749', '80', '三水区', '3');
INSERT INTO `x_region` VALUES ('750', '80', '高明区', '3');
INSERT INTO `x_region` VALUES ('751', '81', '东源县', '3');
INSERT INTO `x_region` VALUES ('752', '81', '和平县', '3');
INSERT INTO `x_region` VALUES ('753', '81', '源城区', '3');
INSERT INTO `x_region` VALUES ('754', '81', '连平县', '3');
INSERT INTO `x_region` VALUES ('755', '81', '龙川县', '3');
INSERT INTO `x_region` VALUES ('756', '81', '紫金县', '3');
INSERT INTO `x_region` VALUES ('757', '82', '惠阳区', '3');
INSERT INTO `x_region` VALUES ('758', '82', '惠城区', '3');
INSERT INTO `x_region` VALUES ('759', '82', '大亚湾', '3');
INSERT INTO `x_region` VALUES ('760', '82', '博罗县', '3');
INSERT INTO `x_region` VALUES ('761', '82', '惠东县', '3');
INSERT INTO `x_region` VALUES ('762', '82', '龙门县', '3');
INSERT INTO `x_region` VALUES ('763', '83', '江海区', '3');
INSERT INTO `x_region` VALUES ('764', '83', '蓬江区', '3');
INSERT INTO `x_region` VALUES ('765', '83', '新会区', '3');
INSERT INTO `x_region` VALUES ('766', '83', '台山市', '3');
INSERT INTO `x_region` VALUES ('767', '83', '开平市', '3');
INSERT INTO `x_region` VALUES ('768', '83', '鹤山市', '3');
INSERT INTO `x_region` VALUES ('769', '83', '恩平市', '3');
INSERT INTO `x_region` VALUES ('770', '84', '榕城区', '3');
INSERT INTO `x_region` VALUES ('771', '84', '普宁市', '3');
INSERT INTO `x_region` VALUES ('772', '84', '揭东县', '3');
INSERT INTO `x_region` VALUES ('773', '84', '揭西县', '3');
INSERT INTO `x_region` VALUES ('774', '84', '惠来县', '3');
INSERT INTO `x_region` VALUES ('775', '85', '茂南区', '3');
INSERT INTO `x_region` VALUES ('776', '85', '茂港区', '3');
INSERT INTO `x_region` VALUES ('777', '85', '高州市', '3');
INSERT INTO `x_region` VALUES ('778', '85', '化州市', '3');
INSERT INTO `x_region` VALUES ('779', '85', '信宜市', '3');
INSERT INTO `x_region` VALUES ('780', '85', '电白县', '3');
INSERT INTO `x_region` VALUES ('781', '86', '梅县', '3');
INSERT INTO `x_region` VALUES ('782', '86', '梅江区', '3');
INSERT INTO `x_region` VALUES ('783', '86', '兴宁市', '3');
INSERT INTO `x_region` VALUES ('784', '86', '大埔县', '3');
INSERT INTO `x_region` VALUES ('785', '86', '丰顺县', '3');
INSERT INTO `x_region` VALUES ('786', '86', '五华县', '3');
INSERT INTO `x_region` VALUES ('787', '86', '平远县', '3');
INSERT INTO `x_region` VALUES ('788', '86', '蕉岭县', '3');
INSERT INTO `x_region` VALUES ('789', '87', '清城区', '3');
INSERT INTO `x_region` VALUES ('790', '87', '英德市', '3');
INSERT INTO `x_region` VALUES ('791', '87', '连州市', '3');
INSERT INTO `x_region` VALUES ('792', '87', '佛冈县', '3');
INSERT INTO `x_region` VALUES ('793', '87', '阳山县', '3');
INSERT INTO `x_region` VALUES ('794', '87', '清新县', '3');
INSERT INTO `x_region` VALUES ('795', '87', '连山', '3');
INSERT INTO `x_region` VALUES ('796', '87', '连南', '3');
INSERT INTO `x_region` VALUES ('797', '88', '南澳县', '3');
INSERT INTO `x_region` VALUES ('798', '88', '潮阳区', '3');
INSERT INTO `x_region` VALUES ('799', '88', '澄海区', '3');
INSERT INTO `x_region` VALUES ('800', '88', '龙湖区', '3');
INSERT INTO `x_region` VALUES ('801', '88', '金平区', '3');
INSERT INTO `x_region` VALUES ('802', '88', '濠江区', '3');
INSERT INTO `x_region` VALUES ('803', '88', '潮南区', '3');
INSERT INTO `x_region` VALUES ('804', '89', '城区', '3');
INSERT INTO `x_region` VALUES ('805', '89', '陆丰市', '3');
INSERT INTO `x_region` VALUES ('806', '89', '海丰县', '3');
INSERT INTO `x_region` VALUES ('807', '89', '陆河县', '3');
INSERT INTO `x_region` VALUES ('808', '90', '曲江县', '3');
INSERT INTO `x_region` VALUES ('809', '90', '浈江区', '3');
INSERT INTO `x_region` VALUES ('810', '90', '武江区', '3');
INSERT INTO `x_region` VALUES ('811', '90', '曲江区', '3');
INSERT INTO `x_region` VALUES ('812', '90', '乐昌市', '3');
INSERT INTO `x_region` VALUES ('813', '90', '南雄市', '3');
INSERT INTO `x_region` VALUES ('814', '90', '始兴县', '3');
INSERT INTO `x_region` VALUES ('815', '90', '仁化县', '3');
INSERT INTO `x_region` VALUES ('816', '90', '翁源县', '3');
INSERT INTO `x_region` VALUES ('817', '90', '新丰县', '3');
INSERT INTO `x_region` VALUES ('818', '90', '乳源', '3');
INSERT INTO `x_region` VALUES ('819', '91', '江城区', '3');
INSERT INTO `x_region` VALUES ('820', '91', '阳春市', '3');
INSERT INTO `x_region` VALUES ('821', '91', '阳西县', '3');
INSERT INTO `x_region` VALUES ('822', '91', '阳东县', '3');
INSERT INTO `x_region` VALUES ('823', '92', '云城区', '3');
INSERT INTO `x_region` VALUES ('824', '92', '罗定市', '3');
INSERT INTO `x_region` VALUES ('825', '92', '新兴县', '3');
INSERT INTO `x_region` VALUES ('826', '92', '郁南县', '3');
INSERT INTO `x_region` VALUES ('827', '92', '云安县', '3');
INSERT INTO `x_region` VALUES ('828', '93', '赤坎区', '3');
INSERT INTO `x_region` VALUES ('829', '93', '霞山区', '3');
INSERT INTO `x_region` VALUES ('830', '93', '坡头区', '3');
INSERT INTO `x_region` VALUES ('831', '93', '麻章区', '3');
INSERT INTO `x_region` VALUES ('832', '93', '廉江市', '3');
INSERT INTO `x_region` VALUES ('833', '93', '雷州市', '3');
INSERT INTO `x_region` VALUES ('834', '93', '吴川市', '3');
INSERT INTO `x_region` VALUES ('835', '93', '遂溪县', '3');
INSERT INTO `x_region` VALUES ('836', '93', '徐闻县', '3');
INSERT INTO `x_region` VALUES ('837', '94', '肇庆市', '3');
INSERT INTO `x_region` VALUES ('838', '94', '高要市', '3');
INSERT INTO `x_region` VALUES ('839', '94', '四会市', '3');
INSERT INTO `x_region` VALUES ('840', '94', '广宁县', '3');
INSERT INTO `x_region` VALUES ('841', '94', '怀集县', '3');
INSERT INTO `x_region` VALUES ('842', '94', '封开县', '3');
INSERT INTO `x_region` VALUES ('843', '94', '德庆县', '3');
INSERT INTO `x_region` VALUES ('844', '95', '石岐街道', '3');
INSERT INTO `x_region` VALUES ('845', '95', '东区街道', '3');
INSERT INTO `x_region` VALUES ('846', '95', '西区街道', '3');
INSERT INTO `x_region` VALUES ('847', '95', '环城街道', '3');
INSERT INTO `x_region` VALUES ('848', '95', '中山港街道', '3');
INSERT INTO `x_region` VALUES ('849', '95', '五桂山街道', '3');
INSERT INTO `x_region` VALUES ('850', '96', '香洲区', '3');
INSERT INTO `x_region` VALUES ('851', '96', '斗门区', '3');
INSERT INTO `x_region` VALUES ('852', '96', '金湾区', '3');
INSERT INTO `x_region` VALUES ('853', '97', '邕宁区', '3');
INSERT INTO `x_region` VALUES ('854', '97', '青秀区', '3');
INSERT INTO `x_region` VALUES ('855', '97', '兴宁区', '3');
INSERT INTO `x_region` VALUES ('856', '97', '良庆区', '3');
INSERT INTO `x_region` VALUES ('857', '97', '西乡塘区', '3');
INSERT INTO `x_region` VALUES ('858', '97', '江南区', '3');
INSERT INTO `x_region` VALUES ('859', '97', '武鸣县', '3');
INSERT INTO `x_region` VALUES ('860', '97', '隆安县', '3');
INSERT INTO `x_region` VALUES ('861', '97', '马山县', '3');
INSERT INTO `x_region` VALUES ('862', '97', '上林县', '3');
INSERT INTO `x_region` VALUES ('863', '97', '宾阳县', '3');
INSERT INTO `x_region` VALUES ('864', '97', '横县', '3');
INSERT INTO `x_region` VALUES ('865', '98', '秀峰区', '3');
INSERT INTO `x_region` VALUES ('866', '98', '叠彩区', '3');
INSERT INTO `x_region` VALUES ('867', '98', '象山区', '3');
INSERT INTO `x_region` VALUES ('868', '98', '七星区', '3');
INSERT INTO `x_region` VALUES ('869', '98', '雁山区', '3');
INSERT INTO `x_region` VALUES ('870', '98', '阳朔县', '3');
INSERT INTO `x_region` VALUES ('871', '98', '临桂县', '3');
INSERT INTO `x_region` VALUES ('872', '98', '灵川县', '3');
INSERT INTO `x_region` VALUES ('873', '98', '全州县', '3');
INSERT INTO `x_region` VALUES ('874', '98', '平乐县', '3');
INSERT INTO `x_region` VALUES ('875', '98', '兴安县', '3');
INSERT INTO `x_region` VALUES ('876', '98', '灌阳县', '3');
INSERT INTO `x_region` VALUES ('877', '98', '荔浦县', '3');
INSERT INTO `x_region` VALUES ('878', '98', '资源县', '3');
INSERT INTO `x_region` VALUES ('879', '98', '永福县', '3');
INSERT INTO `x_region` VALUES ('880', '98', '龙胜', '3');
INSERT INTO `x_region` VALUES ('881', '98', '恭城', '3');
INSERT INTO `x_region` VALUES ('882', '99', '右江区', '3');
INSERT INTO `x_region` VALUES ('883', '99', '凌云县', '3');
INSERT INTO `x_region` VALUES ('884', '99', '平果县', '3');
INSERT INTO `x_region` VALUES ('885', '99', '西林县', '3');
INSERT INTO `x_region` VALUES ('886', '99', '乐业县', '3');
INSERT INTO `x_region` VALUES ('887', '99', '德保县', '3');
INSERT INTO `x_region` VALUES ('888', '99', '田林县', '3');
INSERT INTO `x_region` VALUES ('889', '99', '田阳县', '3');
INSERT INTO `x_region` VALUES ('890', '99', '靖西县', '3');
INSERT INTO `x_region` VALUES ('891', '99', '田东县', '3');
INSERT INTO `x_region` VALUES ('892', '99', '那坡县', '3');
INSERT INTO `x_region` VALUES ('893', '99', '隆林', '3');
INSERT INTO `x_region` VALUES ('894', '100', '海城区', '3');
INSERT INTO `x_region` VALUES ('895', '100', '银海区', '3');
INSERT INTO `x_region` VALUES ('896', '100', '铁山港区', '3');
INSERT INTO `x_region` VALUES ('897', '100', '合浦县', '3');
INSERT INTO `x_region` VALUES ('898', '101', '江州区', '3');
INSERT INTO `x_region` VALUES ('899', '101', '凭祥市', '3');
INSERT INTO `x_region` VALUES ('900', '101', '宁明县', '3');
INSERT INTO `x_region` VALUES ('901', '101', '扶绥县', '3');
INSERT INTO `x_region` VALUES ('902', '101', '龙州县', '3');
INSERT INTO `x_region` VALUES ('903', '101', '大新县', '3');
INSERT INTO `x_region` VALUES ('904', '101', '天等县', '3');
INSERT INTO `x_region` VALUES ('905', '102', '港口区', '3');
INSERT INTO `x_region` VALUES ('906', '102', '防城区', '3');
INSERT INTO `x_region` VALUES ('907', '102', '东兴市', '3');
INSERT INTO `x_region` VALUES ('908', '102', '上思县', '3');
INSERT INTO `x_region` VALUES ('909', '103', '港北区', '3');
INSERT INTO `x_region` VALUES ('910', '103', '港南区', '3');
INSERT INTO `x_region` VALUES ('911', '103', '覃塘区', '3');
INSERT INTO `x_region` VALUES ('912', '103', '桂平市', '3');
INSERT INTO `x_region` VALUES ('913', '103', '平南县', '3');
INSERT INTO `x_region` VALUES ('914', '104', '金城江区', '3');
INSERT INTO `x_region` VALUES ('915', '104', '宜州市', '3');
INSERT INTO `x_region` VALUES ('916', '104', '天峨县', '3');
INSERT INTO `x_region` VALUES ('917', '104', '凤山县', '3');
INSERT INTO `x_region` VALUES ('918', '104', '南丹县', '3');
INSERT INTO `x_region` VALUES ('919', '104', '东兰县', '3');
INSERT INTO `x_region` VALUES ('920', '104', '都安', '3');
INSERT INTO `x_region` VALUES ('921', '104', '罗城', '3');
INSERT INTO `x_region` VALUES ('922', '104', '巴马', '3');
INSERT INTO `x_region` VALUES ('923', '104', '环江', '3');
INSERT INTO `x_region` VALUES ('924', '104', '大化', '3');
INSERT INTO `x_region` VALUES ('925', '105', '八步区', '3');
INSERT INTO `x_region` VALUES ('926', '105', '钟山县', '3');
INSERT INTO `x_region` VALUES ('927', '105', '昭平县', '3');
INSERT INTO `x_region` VALUES ('928', '105', '富川', '3');
INSERT INTO `x_region` VALUES ('929', '106', '兴宾区', '3');
INSERT INTO `x_region` VALUES ('930', '106', '合山市', '3');
INSERT INTO `x_region` VALUES ('931', '106', '象州县', '3');
INSERT INTO `x_region` VALUES ('932', '106', '武宣县', '3');
INSERT INTO `x_region` VALUES ('933', '106', '忻城县', '3');
INSERT INTO `x_region` VALUES ('934', '106', '金秀', '3');
INSERT INTO `x_region` VALUES ('935', '107', '城中区', '3');
INSERT INTO `x_region` VALUES ('936', '107', '鱼峰区', '3');
INSERT INTO `x_region` VALUES ('937', '107', '柳北区', '3');
INSERT INTO `x_region` VALUES ('938', '107', '柳南区', '3');
INSERT INTO `x_region` VALUES ('939', '107', '柳江县', '3');
INSERT INTO `x_region` VALUES ('940', '107', '柳城县', '3');
INSERT INTO `x_region` VALUES ('941', '107', '鹿寨县', '3');
INSERT INTO `x_region` VALUES ('942', '107', '融安县', '3');
INSERT INTO `x_region` VALUES ('943', '107', '融水', '3');
INSERT INTO `x_region` VALUES ('944', '107', '三江', '3');
INSERT INTO `x_region` VALUES ('945', '108', '钦南区', '3');
INSERT INTO `x_region` VALUES ('946', '108', '钦北区', '3');
INSERT INTO `x_region` VALUES ('947', '108', '灵山县', '3');
INSERT INTO `x_region` VALUES ('948', '108', '浦北县', '3');
INSERT INTO `x_region` VALUES ('949', '109', '万秀区', '3');
INSERT INTO `x_region` VALUES ('950', '109', '蝶山区', '3');
INSERT INTO `x_region` VALUES ('951', '109', '长洲区', '3');
INSERT INTO `x_region` VALUES ('952', '109', '岑溪市', '3');
INSERT INTO `x_region` VALUES ('953', '109', '苍梧县', '3');
INSERT INTO `x_region` VALUES ('954', '109', '藤县', '3');
INSERT INTO `x_region` VALUES ('955', '109', '蒙山县', '3');
INSERT INTO `x_region` VALUES ('956', '110', '玉州区', '3');
INSERT INTO `x_region` VALUES ('957', '110', '北流市', '3');
INSERT INTO `x_region` VALUES ('958', '110', '容县', '3');
INSERT INTO `x_region` VALUES ('959', '110', '陆川县', '3');
INSERT INTO `x_region` VALUES ('960', '110', '博白县', '3');
INSERT INTO `x_region` VALUES ('961', '110', '兴业县', '3');
INSERT INTO `x_region` VALUES ('962', '111', '南明区', '3');
INSERT INTO `x_region` VALUES ('963', '111', '云岩区', '3');
INSERT INTO `x_region` VALUES ('964', '111', '花溪区', '3');
INSERT INTO `x_region` VALUES ('965', '111', '乌当区', '3');
INSERT INTO `x_region` VALUES ('966', '111', '白云区', '3');
INSERT INTO `x_region` VALUES ('967', '111', '小河区', '3');
INSERT INTO `x_region` VALUES ('968', '111', '金阳新区', '3');
INSERT INTO `x_region` VALUES ('969', '111', '新天园区', '3');
INSERT INTO `x_region` VALUES ('970', '111', '清镇市', '3');
INSERT INTO `x_region` VALUES ('971', '111', '开阳县', '3');
INSERT INTO `x_region` VALUES ('972', '111', '修文县', '3');
INSERT INTO `x_region` VALUES ('973', '111', '息烽县', '3');
INSERT INTO `x_region` VALUES ('974', '112', '西秀区', '3');
INSERT INTO `x_region` VALUES ('975', '112', '关岭', '3');
INSERT INTO `x_region` VALUES ('976', '112', '镇宁', '3');
INSERT INTO `x_region` VALUES ('977', '112', '紫云', '3');
INSERT INTO `x_region` VALUES ('978', '112', '平坝县', '3');
INSERT INTO `x_region` VALUES ('979', '112', '普定县', '3');
INSERT INTO `x_region` VALUES ('980', '113', '毕节市', '3');
INSERT INTO `x_region` VALUES ('981', '113', '大方县', '3');
INSERT INTO `x_region` VALUES ('982', '113', '黔西县', '3');
INSERT INTO `x_region` VALUES ('983', '113', '金沙县', '3');
INSERT INTO `x_region` VALUES ('984', '113', '织金县', '3');
INSERT INTO `x_region` VALUES ('985', '113', '纳雍县', '3');
INSERT INTO `x_region` VALUES ('986', '113', '赫章县', '3');
INSERT INTO `x_region` VALUES ('987', '113', '威宁', '3');
INSERT INTO `x_region` VALUES ('988', '114', '钟山区', '3');
INSERT INTO `x_region` VALUES ('989', '114', '六枝特区', '3');
INSERT INTO `x_region` VALUES ('990', '114', '水城县', '3');
INSERT INTO `x_region` VALUES ('991', '114', '盘县', '3');
INSERT INTO `x_region` VALUES ('992', '115', '凯里市', '3');
INSERT INTO `x_region` VALUES ('993', '115', '黄平县', '3');
INSERT INTO `x_region` VALUES ('994', '115', '施秉县', '3');
INSERT INTO `x_region` VALUES ('995', '115', '三穗县', '3');
INSERT INTO `x_region` VALUES ('996', '115', '镇远县', '3');
INSERT INTO `x_region` VALUES ('997', '115', '岑巩县', '3');
INSERT INTO `x_region` VALUES ('998', '115', '天柱县', '3');
INSERT INTO `x_region` VALUES ('999', '115', '锦屏县', '3');
INSERT INTO `x_region` VALUES ('1000', '115', '剑河县', '3');
INSERT INTO `x_region` VALUES ('1001', '115', '台江县', '3');
INSERT INTO `x_region` VALUES ('1002', '115', '黎平县', '3');
INSERT INTO `x_region` VALUES ('1003', '115', '榕江县', '3');
INSERT INTO `x_region` VALUES ('1004', '115', '从江县', '3');
INSERT INTO `x_region` VALUES ('1005', '115', '雷山县', '3');
INSERT INTO `x_region` VALUES ('1006', '115', '麻江县', '3');
INSERT INTO `x_region` VALUES ('1007', '115', '丹寨县', '3');
INSERT INTO `x_region` VALUES ('1008', '116', '都匀市', '3');
INSERT INTO `x_region` VALUES ('1009', '116', '福泉市', '3');
INSERT INTO `x_region` VALUES ('1010', '116', '荔波县', '3');
INSERT INTO `x_region` VALUES ('1011', '116', '贵定县', '3');
INSERT INTO `x_region` VALUES ('1012', '116', '瓮安县', '3');
INSERT INTO `x_region` VALUES ('1013', '116', '独山县', '3');
INSERT INTO `x_region` VALUES ('1014', '116', '平塘县', '3');
INSERT INTO `x_region` VALUES ('1015', '116', '罗甸县', '3');
INSERT INTO `x_region` VALUES ('1016', '116', '长顺县', '3');
INSERT INTO `x_region` VALUES ('1017', '116', '龙里县', '3');
INSERT INTO `x_region` VALUES ('1018', '116', '惠水县', '3');
INSERT INTO `x_region` VALUES ('1019', '116', '三都', '3');
INSERT INTO `x_region` VALUES ('1020', '117', '兴义市', '3');
INSERT INTO `x_region` VALUES ('1021', '117', '兴仁县', '3');
INSERT INTO `x_region` VALUES ('1022', '117', '普安县', '3');
INSERT INTO `x_region` VALUES ('1023', '117', '晴隆县', '3');
INSERT INTO `x_region` VALUES ('1024', '117', '贞丰县', '3');
INSERT INTO `x_region` VALUES ('1025', '117', '望谟县', '3');
INSERT INTO `x_region` VALUES ('1026', '117', '册亨县', '3');
INSERT INTO `x_region` VALUES ('1027', '117', '安龙县', '3');
INSERT INTO `x_region` VALUES ('1028', '118', '铜仁市', '3');
INSERT INTO `x_region` VALUES ('1029', '118', '江口县', '3');
INSERT INTO `x_region` VALUES ('1030', '118', '石阡县', '3');
INSERT INTO `x_region` VALUES ('1031', '118', '思南县', '3');
INSERT INTO `x_region` VALUES ('1032', '118', '德江县', '3');
INSERT INTO `x_region` VALUES ('1033', '118', '玉屏', '3');
INSERT INTO `x_region` VALUES ('1034', '118', '印江', '3');
INSERT INTO `x_region` VALUES ('1035', '118', '沿河', '3');
INSERT INTO `x_region` VALUES ('1036', '118', '松桃', '3');
INSERT INTO `x_region` VALUES ('1037', '118', '万山特区', '3');
INSERT INTO `x_region` VALUES ('1038', '119', '红花岗区', '3');
INSERT INTO `x_region` VALUES ('1039', '119', '务川县', '3');
INSERT INTO `x_region` VALUES ('1040', '119', '道真县', '3');
INSERT INTO `x_region` VALUES ('1041', '119', '汇川区', '3');
INSERT INTO `x_region` VALUES ('1042', '119', '赤水市', '3');
INSERT INTO `x_region` VALUES ('1043', '119', '仁怀市', '3');
INSERT INTO `x_region` VALUES ('1044', '119', '遵义县', '3');
INSERT INTO `x_region` VALUES ('1045', '119', '桐梓县', '3');
INSERT INTO `x_region` VALUES ('1046', '119', '绥阳县', '3');
INSERT INTO `x_region` VALUES ('1047', '119', '正安县', '3');
INSERT INTO `x_region` VALUES ('1048', '119', '凤冈县', '3');
INSERT INTO `x_region` VALUES ('1049', '119', '湄潭县', '3');
INSERT INTO `x_region` VALUES ('1050', '119', '余庆县', '3');
INSERT INTO `x_region` VALUES ('1051', '119', '习水县', '3');
INSERT INTO `x_region` VALUES ('1052', '119', '道真', '3');
INSERT INTO `x_region` VALUES ('1053', '119', '务川', '3');
INSERT INTO `x_region` VALUES ('1054', '120', '秀英区', '3');
INSERT INTO `x_region` VALUES ('1055', '120', '龙华区', '3');
INSERT INTO `x_region` VALUES ('1056', '120', '琼山区', '3');
INSERT INTO `x_region` VALUES ('1057', '120', '美兰区', '3');
INSERT INTO `x_region` VALUES ('1058', '137', '市区', '3');
INSERT INTO `x_region` VALUES ('1059', '137', '洋浦开发区', '3');
INSERT INTO `x_region` VALUES ('1060', '137', '那大镇', '3');
INSERT INTO `x_region` VALUES ('1061', '137', '王五镇', '3');
INSERT INTO `x_region` VALUES ('1062', '137', '雅星镇', '3');
INSERT INTO `x_region` VALUES ('1063', '137', '大成镇', '3');
INSERT INTO `x_region` VALUES ('1064', '137', '中和镇', '3');
INSERT INTO `x_region` VALUES ('1065', '137', '峨蔓镇', '3');
INSERT INTO `x_region` VALUES ('1066', '137', '南丰镇', '3');
INSERT INTO `x_region` VALUES ('1067', '137', '白马井镇', '3');
INSERT INTO `x_region` VALUES ('1068', '137', '兰洋镇', '3');
INSERT INTO `x_region` VALUES ('1069', '137', '和庆镇', '3');
INSERT INTO `x_region` VALUES ('1070', '137', '海头镇', '3');
INSERT INTO `x_region` VALUES ('1071', '137', '排浦镇', '3');
INSERT INTO `x_region` VALUES ('1072', '137', '东成镇', '3');
INSERT INTO `x_region` VALUES ('1073', '137', '光村镇', '3');
INSERT INTO `x_region` VALUES ('1074', '137', '木棠镇', '3');
INSERT INTO `x_region` VALUES ('1075', '137', '新州镇', '3');
INSERT INTO `x_region` VALUES ('1076', '137', '三都镇', '3');
INSERT INTO `x_region` VALUES ('1077', '137', '其他', '3');
INSERT INTO `x_region` VALUES ('1078', '138', '长安区', '3');
INSERT INTO `x_region` VALUES ('1079', '138', '桥东区', '3');
INSERT INTO `x_region` VALUES ('1080', '138', '桥西区', '3');
INSERT INTO `x_region` VALUES ('1081', '138', '新华区', '3');
INSERT INTO `x_region` VALUES ('1082', '138', '裕华区', '3');
INSERT INTO `x_region` VALUES ('1083', '138', '井陉矿区', '3');
INSERT INTO `x_region` VALUES ('1084', '138', '高新区', '3');
INSERT INTO `x_region` VALUES ('1085', '138', '辛集市', '3');
INSERT INTO `x_region` VALUES ('1086', '138', '藁城市', '3');
INSERT INTO `x_region` VALUES ('1087', '138', '晋州市', '3');
INSERT INTO `x_region` VALUES ('1088', '138', '新乐市', '3');
INSERT INTO `x_region` VALUES ('1089', '138', '鹿泉市', '3');
INSERT INTO `x_region` VALUES ('1090', '138', '井陉县', '3');
INSERT INTO `x_region` VALUES ('1091', '138', '正定县', '3');
INSERT INTO `x_region` VALUES ('1092', '138', '栾城县', '3');
INSERT INTO `x_region` VALUES ('1093', '138', '行唐县', '3');
INSERT INTO `x_region` VALUES ('1094', '138', '灵寿县', '3');
INSERT INTO `x_region` VALUES ('1095', '138', '高邑县', '3');
INSERT INTO `x_region` VALUES ('1096', '138', '深泽县', '3');
INSERT INTO `x_region` VALUES ('1097', '138', '赞皇县', '3');
INSERT INTO `x_region` VALUES ('1098', '138', '无极县', '3');
INSERT INTO `x_region` VALUES ('1099', '138', '平山县', '3');
INSERT INTO `x_region` VALUES ('1100', '138', '元氏县', '3');
INSERT INTO `x_region` VALUES ('1101', '138', '赵县', '3');
INSERT INTO `x_region` VALUES ('1102', '139', '新市区', '3');
INSERT INTO `x_region` VALUES ('1103', '139', '南市区', '3');
INSERT INTO `x_region` VALUES ('1104', '139', '北市区', '3');
INSERT INTO `x_region` VALUES ('1105', '139', '涿州市', '3');
INSERT INTO `x_region` VALUES ('1106', '139', '定州市', '3');
INSERT INTO `x_region` VALUES ('1107', '139', '安国市', '3');
INSERT INTO `x_region` VALUES ('1108', '139', '高碑店市', '3');
INSERT INTO `x_region` VALUES ('1109', '139', '满城县', '3');
INSERT INTO `x_region` VALUES ('1110', '139', '清苑县', '3');
INSERT INTO `x_region` VALUES ('1111', '139', '涞水县', '3');
INSERT INTO `x_region` VALUES ('1112', '139', '阜平县', '3');
INSERT INTO `x_region` VALUES ('1113', '139', '徐水县', '3');
INSERT INTO `x_region` VALUES ('1114', '139', '定兴县', '3');
INSERT INTO `x_region` VALUES ('1115', '139', '唐县', '3');
INSERT INTO `x_region` VALUES ('1116', '139', '高阳县', '3');
INSERT INTO `x_region` VALUES ('1117', '139', '容城县', '3');
INSERT INTO `x_region` VALUES ('1118', '139', '涞源县', '3');
INSERT INTO `x_region` VALUES ('1119', '139', '望都县', '3');
INSERT INTO `x_region` VALUES ('1120', '139', '安新县', '3');
INSERT INTO `x_region` VALUES ('1121', '139', '易县', '3');
INSERT INTO `x_region` VALUES ('1122', '139', '曲阳县', '3');
INSERT INTO `x_region` VALUES ('1123', '139', '蠡县', '3');
INSERT INTO `x_region` VALUES ('1124', '139', '顺平县', '3');
INSERT INTO `x_region` VALUES ('1125', '139', '博野县', '3');
INSERT INTO `x_region` VALUES ('1126', '139', '雄县', '3');
INSERT INTO `x_region` VALUES ('1127', '140', '运河区', '3');
INSERT INTO `x_region` VALUES ('1128', '140', '新华区', '3');
INSERT INTO `x_region` VALUES ('1129', '140', '泊头市', '3');
INSERT INTO `x_region` VALUES ('1130', '140', '任丘市', '3');
INSERT INTO `x_region` VALUES ('1131', '140', '黄骅市', '3');
INSERT INTO `x_region` VALUES ('1132', '140', '河间市', '3');
INSERT INTO `x_region` VALUES ('1133', '140', '沧县', '3');
INSERT INTO `x_region` VALUES ('1134', '140', '青县', '3');
INSERT INTO `x_region` VALUES ('1135', '140', '东光县', '3');
INSERT INTO `x_region` VALUES ('1136', '140', '海兴县', '3');
INSERT INTO `x_region` VALUES ('1137', '140', '盐山县', '3');
INSERT INTO `x_region` VALUES ('1138', '140', '肃宁县', '3');
INSERT INTO `x_region` VALUES ('1139', '140', '南皮县', '3');
INSERT INTO `x_region` VALUES ('1140', '140', '吴桥县', '3');
INSERT INTO `x_region` VALUES ('1141', '140', '献县', '3');
INSERT INTO `x_region` VALUES ('1142', '140', '孟村', '3');
INSERT INTO `x_region` VALUES ('1143', '141', '双桥区', '3');
INSERT INTO `x_region` VALUES ('1144', '141', '双滦区', '3');
INSERT INTO `x_region` VALUES ('1145', '141', '鹰手营子矿区', '3');
INSERT INTO `x_region` VALUES ('1146', '141', '承德县', '3');
INSERT INTO `x_region` VALUES ('1147', '141', '兴隆县', '3');
INSERT INTO `x_region` VALUES ('1148', '141', '平泉县', '3');
INSERT INTO `x_region` VALUES ('1149', '141', '滦平县', '3');
INSERT INTO `x_region` VALUES ('1150', '141', '隆化县', '3');
INSERT INTO `x_region` VALUES ('1151', '141', '丰宁', '3');
INSERT INTO `x_region` VALUES ('1152', '141', '宽城', '3');
INSERT INTO `x_region` VALUES ('1153', '141', '围场', '3');
INSERT INTO `x_region` VALUES ('1154', '142', '从台区', '3');
INSERT INTO `x_region` VALUES ('1155', '142', '复兴区', '3');
INSERT INTO `x_region` VALUES ('1156', '142', '邯山区', '3');
INSERT INTO `x_region` VALUES ('1157', '142', '峰峰矿区', '3');
INSERT INTO `x_region` VALUES ('1158', '142', '武安市', '3');
INSERT INTO `x_region` VALUES ('1159', '142', '邯郸县', '3');
INSERT INTO `x_region` VALUES ('1160', '142', '临漳县', '3');
INSERT INTO `x_region` VALUES ('1161', '142', '成安县', '3');
INSERT INTO `x_region` VALUES ('1162', '142', '大名县', '3');
INSERT INTO `x_region` VALUES ('1163', '142', '涉县', '3');
INSERT INTO `x_region` VALUES ('1164', '142', '磁县', '3');
INSERT INTO `x_region` VALUES ('1165', '142', '肥乡县', '3');
INSERT INTO `x_region` VALUES ('1166', '142', '永年县', '3');
INSERT INTO `x_region` VALUES ('1167', '142', '邱县', '3');
INSERT INTO `x_region` VALUES ('1168', '142', '鸡泽县', '3');
INSERT INTO `x_region` VALUES ('1169', '142', '广平县', '3');
INSERT INTO `x_region` VALUES ('1170', '142', '馆陶县', '3');
INSERT INTO `x_region` VALUES ('1171', '142', '魏县', '3');
INSERT INTO `x_region` VALUES ('1172', '142', '曲周县', '3');
INSERT INTO `x_region` VALUES ('1173', '143', '桃城区', '3');
INSERT INTO `x_region` VALUES ('1174', '143', '冀州市', '3');
INSERT INTO `x_region` VALUES ('1175', '143', '深州市', '3');
INSERT INTO `x_region` VALUES ('1176', '143', '枣强县', '3');
INSERT INTO `x_region` VALUES ('1177', '143', '武邑县', '3');
INSERT INTO `x_region` VALUES ('1178', '143', '武强县', '3');
INSERT INTO `x_region` VALUES ('1179', '143', '饶阳县', '3');
INSERT INTO `x_region` VALUES ('1180', '143', '安平县', '3');
INSERT INTO `x_region` VALUES ('1181', '143', '故城县', '3');
INSERT INTO `x_region` VALUES ('1182', '143', '景县', '3');
INSERT INTO `x_region` VALUES ('1183', '143', '阜城县', '3');
INSERT INTO `x_region` VALUES ('1184', '144', '安次区', '3');
INSERT INTO `x_region` VALUES ('1185', '144', '广阳区', '3');
INSERT INTO `x_region` VALUES ('1186', '144', '霸州市', '3');
INSERT INTO `x_region` VALUES ('1187', '144', '三河市', '3');
INSERT INTO `x_region` VALUES ('1188', '144', '固安县', '3');
INSERT INTO `x_region` VALUES ('1189', '144', '永清县', '3');
INSERT INTO `x_region` VALUES ('1190', '144', '香河县', '3');
INSERT INTO `x_region` VALUES ('1191', '144', '大城县', '3');
INSERT INTO `x_region` VALUES ('1192', '144', '文安县', '3');
INSERT INTO `x_region` VALUES ('1193', '144', '大厂', '3');
INSERT INTO `x_region` VALUES ('1194', '145', '海港区', '3');
INSERT INTO `x_region` VALUES ('1195', '145', '山海关区', '3');
INSERT INTO `x_region` VALUES ('1196', '145', '北戴河区', '3');
INSERT INTO `x_region` VALUES ('1197', '145', '昌黎县', '3');
INSERT INTO `x_region` VALUES ('1198', '145', '抚宁县', '3');
INSERT INTO `x_region` VALUES ('1199', '145', '卢龙县', '3');
INSERT INTO `x_region` VALUES ('1200', '145', '青龙', '3');
INSERT INTO `x_region` VALUES ('1201', '146', '路北区', '3');
INSERT INTO `x_region` VALUES ('1202', '146', '路南区', '3');
INSERT INTO `x_region` VALUES ('1203', '146', '古冶区', '3');
INSERT INTO `x_region` VALUES ('1204', '146', '开平区', '3');
INSERT INTO `x_region` VALUES ('1205', '146', '丰南区', '3');
INSERT INTO `x_region` VALUES ('1206', '146', '丰润区', '3');
INSERT INTO `x_region` VALUES ('1207', '146', '遵化市', '3');
INSERT INTO `x_region` VALUES ('1208', '146', '迁安市', '3');
INSERT INTO `x_region` VALUES ('1209', '146', '滦县', '3');
INSERT INTO `x_region` VALUES ('1210', '146', '滦南县', '3');
INSERT INTO `x_region` VALUES ('1211', '146', '乐亭县', '3');
INSERT INTO `x_region` VALUES ('1212', '146', '迁西县', '3');
INSERT INTO `x_region` VALUES ('1213', '146', '玉田县', '3');
INSERT INTO `x_region` VALUES ('1214', '146', '唐海县', '3');
INSERT INTO `x_region` VALUES ('1215', '147', '桥东区', '3');
INSERT INTO `x_region` VALUES ('1216', '147', '桥西区', '3');
INSERT INTO `x_region` VALUES ('1217', '147', '南宫市', '3');
INSERT INTO `x_region` VALUES ('1218', '147', '沙河市', '3');
INSERT INTO `x_region` VALUES ('1219', '147', '邢台县', '3');
INSERT INTO `x_region` VALUES ('1220', '147', '临城县', '3');
INSERT INTO `x_region` VALUES ('1221', '147', '内丘县', '3');
INSERT INTO `x_region` VALUES ('1222', '147', '柏乡县', '3');
INSERT INTO `x_region` VALUES ('1223', '147', '隆尧县', '3');
INSERT INTO `x_region` VALUES ('1224', '147', '任县', '3');
INSERT INTO `x_region` VALUES ('1225', '147', '南和县', '3');
INSERT INTO `x_region` VALUES ('1226', '147', '宁晋县', '3');
INSERT INTO `x_region` VALUES ('1227', '147', '巨鹿县', '3');
INSERT INTO `x_region` VALUES ('1228', '147', '新河县', '3');
INSERT INTO `x_region` VALUES ('1229', '147', '广宗县', '3');
INSERT INTO `x_region` VALUES ('1230', '147', '平乡县', '3');
INSERT INTO `x_region` VALUES ('1231', '147', '威县', '3');
INSERT INTO `x_region` VALUES ('1232', '147', '清河县', '3');
INSERT INTO `x_region` VALUES ('1233', '147', '临西县', '3');
INSERT INTO `x_region` VALUES ('1234', '148', '桥西区', '3');
INSERT INTO `x_region` VALUES ('1235', '148', '桥东区', '3');
INSERT INTO `x_region` VALUES ('1236', '148', '宣化区', '3');
INSERT INTO `x_region` VALUES ('1237', '148', '下花园区', '3');
INSERT INTO `x_region` VALUES ('1238', '148', '宣化县', '3');
INSERT INTO `x_region` VALUES ('1239', '148', '张北县', '3');
INSERT INTO `x_region` VALUES ('1240', '148', '康保县', '3');
INSERT INTO `x_region` VALUES ('1241', '148', '沽源县', '3');
INSERT INTO `x_region` VALUES ('1242', '148', '尚义县', '3');
INSERT INTO `x_region` VALUES ('1243', '148', '蔚县', '3');
INSERT INTO `x_region` VALUES ('1244', '148', '阳原县', '3');
INSERT INTO `x_region` VALUES ('1245', '148', '怀安县', '3');
INSERT INTO `x_region` VALUES ('1246', '148', '万全县', '3');
INSERT INTO `x_region` VALUES ('1247', '148', '怀来县', '3');
INSERT INTO `x_region` VALUES ('1248', '148', '涿鹿县', '3');
INSERT INTO `x_region` VALUES ('1249', '148', '赤城县', '3');
INSERT INTO `x_region` VALUES ('1250', '148', '崇礼县', '3');
INSERT INTO `x_region` VALUES ('1251', '149', '金水区', '3');
INSERT INTO `x_region` VALUES ('1252', '149', '邙山区', '3');
INSERT INTO `x_region` VALUES ('1253', '149', '二七区', '3');
INSERT INTO `x_region` VALUES ('1254', '149', '管城区', '3');
INSERT INTO `x_region` VALUES ('1255', '149', '中原区', '3');
INSERT INTO `x_region` VALUES ('1256', '149', '上街区', '3');
INSERT INTO `x_region` VALUES ('1257', '149', '惠济区', '3');
INSERT INTO `x_region` VALUES ('1258', '149', '郑东新区', '3');
INSERT INTO `x_region` VALUES ('1259', '149', '经济技术开发区', '3');
INSERT INTO `x_region` VALUES ('1260', '149', '高新开发区', '3');
INSERT INTO `x_region` VALUES ('1261', '149', '出口加工区', '3');
INSERT INTO `x_region` VALUES ('1262', '149', '巩义市', '3');
INSERT INTO `x_region` VALUES ('1263', '149', '荥阳市', '3');
INSERT INTO `x_region` VALUES ('1264', '149', '新密市', '3');
INSERT INTO `x_region` VALUES ('1265', '149', '新郑市', '3');
INSERT INTO `x_region` VALUES ('1266', '149', '登封市', '3');
INSERT INTO `x_region` VALUES ('1267', '149', '中牟县', '3');
INSERT INTO `x_region` VALUES ('1268', '150', '西工区', '3');
INSERT INTO `x_region` VALUES ('1269', '150', '老城区', '3');
INSERT INTO `x_region` VALUES ('1270', '150', '涧西区', '3');
INSERT INTO `x_region` VALUES ('1271', '150', '瀍河回族区', '3');
INSERT INTO `x_region` VALUES ('1272', '150', '洛龙区', '3');
INSERT INTO `x_region` VALUES ('1273', '150', '吉利区', '3');
INSERT INTO `x_region` VALUES ('1274', '150', '偃师市', '3');
INSERT INTO `x_region` VALUES ('1275', '150', '孟津县', '3');
INSERT INTO `x_region` VALUES ('1276', '150', '新安县', '3');
INSERT INTO `x_region` VALUES ('1277', '150', '栾川县', '3');
INSERT INTO `x_region` VALUES ('1278', '150', '嵩县', '3');
INSERT INTO `x_region` VALUES ('1279', '150', '汝阳县', '3');
INSERT INTO `x_region` VALUES ('1280', '150', '宜阳县', '3');
INSERT INTO `x_region` VALUES ('1281', '150', '洛宁县', '3');
INSERT INTO `x_region` VALUES ('1282', '150', '伊川县', '3');
INSERT INTO `x_region` VALUES ('1283', '151', '鼓楼区', '3');
INSERT INTO `x_region` VALUES ('1284', '151', '龙亭区', '3');
INSERT INTO `x_region` VALUES ('1285', '151', '顺河回族区', '3');
INSERT INTO `x_region` VALUES ('1286', '151', '金明区', '3');
INSERT INTO `x_region` VALUES ('1287', '151', '禹王台区', '3');
INSERT INTO `x_region` VALUES ('1288', '151', '杞县', '3');
INSERT INTO `x_region` VALUES ('1289', '151', '通许县', '3');
INSERT INTO `x_region` VALUES ('1290', '151', '尉氏县', '3');
INSERT INTO `x_region` VALUES ('1291', '151', '开封县', '3');
INSERT INTO `x_region` VALUES ('1292', '151', '兰考县', '3');
INSERT INTO `x_region` VALUES ('1293', '152', '北关区', '3');
INSERT INTO `x_region` VALUES ('1294', '152', '文峰区', '3');
INSERT INTO `x_region` VALUES ('1295', '152', '殷都区', '3');
INSERT INTO `x_region` VALUES ('1296', '152', '龙安区', '3');
INSERT INTO `x_region` VALUES ('1297', '152', '林州市', '3');
INSERT INTO `x_region` VALUES ('1298', '152', '安阳县', '3');
INSERT INTO `x_region` VALUES ('1299', '152', '汤阴县', '3');
INSERT INTO `x_region` VALUES ('1300', '152', '滑县', '3');
INSERT INTO `x_region` VALUES ('1301', '152', '内黄县', '3');
INSERT INTO `x_region` VALUES ('1302', '153', '淇滨区', '3');
INSERT INTO `x_region` VALUES ('1303', '153', '山城区', '3');
INSERT INTO `x_region` VALUES ('1304', '153', '鹤山区', '3');
INSERT INTO `x_region` VALUES ('1305', '153', '浚县', '3');
INSERT INTO `x_region` VALUES ('1306', '153', '淇县', '3');
INSERT INTO `x_region` VALUES ('1307', '154', '济源市', '3');
INSERT INTO `x_region` VALUES ('1308', '155', '解放区', '3');
INSERT INTO `x_region` VALUES ('1309', '155', '中站区', '3');
INSERT INTO `x_region` VALUES ('1310', '155', '马村区', '3');
INSERT INTO `x_region` VALUES ('1311', '155', '山阳区', '3');
INSERT INTO `x_region` VALUES ('1312', '155', '沁阳市', '3');
INSERT INTO `x_region` VALUES ('1313', '155', '孟州市', '3');
INSERT INTO `x_region` VALUES ('1314', '155', '修武县', '3');
INSERT INTO `x_region` VALUES ('1315', '155', '博爱县', '3');
INSERT INTO `x_region` VALUES ('1316', '155', '武陟县', '3');
INSERT INTO `x_region` VALUES ('1317', '155', '温县', '3');
INSERT INTO `x_region` VALUES ('1318', '156', '卧龙区', '3');
INSERT INTO `x_region` VALUES ('1319', '156', '宛城区', '3');
INSERT INTO `x_region` VALUES ('1320', '156', '邓州市', '3');
INSERT INTO `x_region` VALUES ('1321', '156', '南召县', '3');
INSERT INTO `x_region` VALUES ('1322', '156', '方城县', '3');
INSERT INTO `x_region` VALUES ('1323', '156', '西峡县', '3');
INSERT INTO `x_region` VALUES ('1324', '156', '镇平县', '3');
INSERT INTO `x_region` VALUES ('1325', '156', '内乡县', '3');
INSERT INTO `x_region` VALUES ('1326', '156', '淅川县', '3');
INSERT INTO `x_region` VALUES ('1327', '156', '社旗县', '3');
INSERT INTO `x_region` VALUES ('1328', '156', '唐河县', '3');
INSERT INTO `x_region` VALUES ('1329', '156', '新野县', '3');
INSERT INTO `x_region` VALUES ('1330', '156', '桐柏县', '3');
INSERT INTO `x_region` VALUES ('1331', '157', '新华区', '3');
INSERT INTO `x_region` VALUES ('1332', '157', '卫东区', '3');
INSERT INTO `x_region` VALUES ('1333', '157', '湛河区', '3');
INSERT INTO `x_region` VALUES ('1334', '157', '石龙区', '3');
INSERT INTO `x_region` VALUES ('1335', '157', '舞钢市', '3');
INSERT INTO `x_region` VALUES ('1336', '157', '汝州市', '3');
INSERT INTO `x_region` VALUES ('1337', '157', '宝丰县', '3');
INSERT INTO `x_region` VALUES ('1338', '157', '叶县', '3');
INSERT INTO `x_region` VALUES ('1339', '157', '鲁山县', '3');
INSERT INTO `x_region` VALUES ('1340', '157', '郏县', '3');
INSERT INTO `x_region` VALUES ('1341', '158', '湖滨区', '3');
INSERT INTO `x_region` VALUES ('1342', '158', '义马市', '3');
INSERT INTO `x_region` VALUES ('1343', '158', '灵宝市', '3');
INSERT INTO `x_region` VALUES ('1344', '158', '渑池县', '3');
INSERT INTO `x_region` VALUES ('1345', '158', '陕县', '3');
INSERT INTO `x_region` VALUES ('1346', '158', '卢氏县', '3');
INSERT INTO `x_region` VALUES ('1347', '159', '梁园区', '3');
INSERT INTO `x_region` VALUES ('1348', '159', '睢阳区', '3');
INSERT INTO `x_region` VALUES ('1349', '159', '永城市', '3');
INSERT INTO `x_region` VALUES ('1350', '159', '民权县', '3');
INSERT INTO `x_region` VALUES ('1351', '159', '睢县', '3');
INSERT INTO `x_region` VALUES ('1352', '159', '宁陵县', '3');
INSERT INTO `x_region` VALUES ('1353', '159', '虞城县', '3');
INSERT INTO `x_region` VALUES ('1354', '159', '柘城县', '3');
INSERT INTO `x_region` VALUES ('1355', '159', '夏邑县', '3');
INSERT INTO `x_region` VALUES ('1356', '160', '卫滨区', '3');
INSERT INTO `x_region` VALUES ('1357', '160', '红旗区', '3');
INSERT INTO `x_region` VALUES ('1358', '160', '凤泉区', '3');
INSERT INTO `x_region` VALUES ('1359', '160', '牧野区', '3');
INSERT INTO `x_region` VALUES ('1360', '160', '卫辉市', '3');
INSERT INTO `x_region` VALUES ('1361', '160', '辉县市', '3');
INSERT INTO `x_region` VALUES ('1362', '160', '新乡县', '3');
INSERT INTO `x_region` VALUES ('1363', '160', '获嘉县', '3');
INSERT INTO `x_region` VALUES ('1364', '160', '原阳县', '3');
INSERT INTO `x_region` VALUES ('1365', '160', '延津县', '3');
INSERT INTO `x_region` VALUES ('1366', '160', '封丘县', '3');
INSERT INTO `x_region` VALUES ('1367', '160', '长垣县', '3');
INSERT INTO `x_region` VALUES ('1368', '161', '浉河区', '3');
INSERT INTO `x_region` VALUES ('1369', '161', '平桥区', '3');
INSERT INTO `x_region` VALUES ('1370', '161', '罗山县', '3');
INSERT INTO `x_region` VALUES ('1371', '161', '光山县', '3');
INSERT INTO `x_region` VALUES ('1372', '161', '新县', '3');
INSERT INTO `x_region` VALUES ('1373', '161', '商城县', '3');
INSERT INTO `x_region` VALUES ('1374', '161', '固始县', '3');
INSERT INTO `x_region` VALUES ('1375', '161', '潢川县', '3');
INSERT INTO `x_region` VALUES ('1376', '161', '淮滨县', '3');
INSERT INTO `x_region` VALUES ('1377', '161', '息县', '3');
INSERT INTO `x_region` VALUES ('1378', '162', '魏都区', '3');
INSERT INTO `x_region` VALUES ('1379', '162', '禹州市', '3');
INSERT INTO `x_region` VALUES ('1380', '162', '长葛市', '3');
INSERT INTO `x_region` VALUES ('1381', '162', '许昌县', '3');
INSERT INTO `x_region` VALUES ('1382', '162', '鄢陵县', '3');
INSERT INTO `x_region` VALUES ('1383', '162', '襄城县', '3');
INSERT INTO `x_region` VALUES ('1384', '163', '川汇区', '3');
INSERT INTO `x_region` VALUES ('1385', '163', '项城市', '3');
INSERT INTO `x_region` VALUES ('1386', '163', '扶沟县', '3');
INSERT INTO `x_region` VALUES ('1387', '163', '西华县', '3');
INSERT INTO `x_region` VALUES ('1388', '163', '商水县', '3');
INSERT INTO `x_region` VALUES ('1389', '163', '沈丘县', '3');
INSERT INTO `x_region` VALUES ('1390', '163', '郸城县', '3');
INSERT INTO `x_region` VALUES ('1391', '163', '淮阳县', '3');
INSERT INTO `x_region` VALUES ('1392', '163', '太康县', '3');
INSERT INTO `x_region` VALUES ('1393', '163', '鹿邑县', '3');
INSERT INTO `x_region` VALUES ('1394', '164', '驿城区', '3');
INSERT INTO `x_region` VALUES ('1395', '164', '西平县', '3');
INSERT INTO `x_region` VALUES ('1396', '164', '上蔡县', '3');
INSERT INTO `x_region` VALUES ('1397', '164', '平舆县', '3');
INSERT INTO `x_region` VALUES ('1398', '164', '正阳县', '3');
INSERT INTO `x_region` VALUES ('1399', '164', '确山县', '3');
INSERT INTO `x_region` VALUES ('1400', '164', '泌阳县', '3');
INSERT INTO `x_region` VALUES ('1401', '164', '汝南县', '3');
INSERT INTO `x_region` VALUES ('1402', '164', '遂平县', '3');
INSERT INTO `x_region` VALUES ('1403', '164', '新蔡县', '3');
INSERT INTO `x_region` VALUES ('1404', '165', '郾城区', '3');
INSERT INTO `x_region` VALUES ('1405', '165', '源汇区', '3');
INSERT INTO `x_region` VALUES ('1406', '165', '召陵区', '3');
INSERT INTO `x_region` VALUES ('1407', '165', '舞阳县', '3');
INSERT INTO `x_region` VALUES ('1408', '165', '临颍县', '3');
INSERT INTO `x_region` VALUES ('1409', '166', '华龙区', '3');
INSERT INTO `x_region` VALUES ('1410', '166', '清丰县', '3');
INSERT INTO `x_region` VALUES ('1411', '166', '南乐县', '3');
INSERT INTO `x_region` VALUES ('1412', '166', '范县', '3');
INSERT INTO `x_region` VALUES ('1413', '166', '台前县', '3');
INSERT INTO `x_region` VALUES ('1414', '166', '濮阳县', '3');
INSERT INTO `x_region` VALUES ('1415', '167', '道里区', '3');
INSERT INTO `x_region` VALUES ('1416', '167', '南岗区', '3');
INSERT INTO `x_region` VALUES ('1417', '167', '动力区', '3');
INSERT INTO `x_region` VALUES ('1418', '167', '平房区', '3');
INSERT INTO `x_region` VALUES ('1419', '167', '香坊区', '3');
INSERT INTO `x_region` VALUES ('1420', '167', '太平区', '3');
INSERT INTO `x_region` VALUES ('1421', '167', '道外区', '3');
INSERT INTO `x_region` VALUES ('1422', '167', '阿城区', '3');
INSERT INTO `x_region` VALUES ('1423', '167', '呼兰区', '3');
INSERT INTO `x_region` VALUES ('1424', '167', '松北区', '3');
INSERT INTO `x_region` VALUES ('1425', '167', '尚志市', '3');
INSERT INTO `x_region` VALUES ('1426', '167', '双城市', '3');
INSERT INTO `x_region` VALUES ('1427', '167', '五常市', '3');
INSERT INTO `x_region` VALUES ('1428', '167', '方正县', '3');
INSERT INTO `x_region` VALUES ('1429', '167', '宾县', '3');
INSERT INTO `x_region` VALUES ('1430', '167', '依兰县', '3');
INSERT INTO `x_region` VALUES ('1431', '167', '巴彦县', '3');
INSERT INTO `x_region` VALUES ('1432', '167', '通河县', '3');
INSERT INTO `x_region` VALUES ('1433', '167', '木兰县', '3');
INSERT INTO `x_region` VALUES ('1434', '167', '延寿县', '3');
INSERT INTO `x_region` VALUES ('1435', '168', '萨尔图区', '3');
INSERT INTO `x_region` VALUES ('1436', '168', '红岗区', '3');
INSERT INTO `x_region` VALUES ('1437', '168', '龙凤区', '3');
INSERT INTO `x_region` VALUES ('1438', '168', '让胡路区', '3');
INSERT INTO `x_region` VALUES ('1439', '168', '大同区', '3');
INSERT INTO `x_region` VALUES ('1440', '168', '肇州县', '3');
INSERT INTO `x_region` VALUES ('1441', '168', '肇源县', '3');
INSERT INTO `x_region` VALUES ('1442', '168', '林甸县', '3');
INSERT INTO `x_region` VALUES ('1443', '168', '杜尔伯特', '3');
INSERT INTO `x_region` VALUES ('1444', '169', '呼玛县', '3');
INSERT INTO `x_region` VALUES ('1445', '169', '漠河县', '3');
INSERT INTO `x_region` VALUES ('1446', '169', '塔河县', '3');
INSERT INTO `x_region` VALUES ('1447', '170', '兴山区', '3');
INSERT INTO `x_region` VALUES ('1448', '170', '工农区', '3');
INSERT INTO `x_region` VALUES ('1449', '170', '南山区', '3');
INSERT INTO `x_region` VALUES ('1450', '170', '兴安区', '3');
INSERT INTO `x_region` VALUES ('1451', '170', '向阳区', '3');
INSERT INTO `x_region` VALUES ('1452', '170', '东山区', '3');
INSERT INTO `x_region` VALUES ('1453', '170', '萝北县', '3');
INSERT INTO `x_region` VALUES ('1454', '170', '绥滨县', '3');
INSERT INTO `x_region` VALUES ('1455', '171', '爱辉区', '3');
INSERT INTO `x_region` VALUES ('1456', '171', '五大连池市', '3');
INSERT INTO `x_region` VALUES ('1457', '171', '北安市', '3');
INSERT INTO `x_region` VALUES ('1458', '171', '嫩江县', '3');
INSERT INTO `x_region` VALUES ('1459', '171', '逊克县', '3');
INSERT INTO `x_region` VALUES ('1460', '171', '孙吴县', '3');
INSERT INTO `x_region` VALUES ('1461', '172', '鸡冠区', '3');
INSERT INTO `x_region` VALUES ('1462', '172', '恒山区', '3');
INSERT INTO `x_region` VALUES ('1463', '172', '城子河区', '3');
INSERT INTO `x_region` VALUES ('1464', '172', '滴道区', '3');
INSERT INTO `x_region` VALUES ('1465', '172', '梨树区', '3');
INSERT INTO `x_region` VALUES ('1466', '172', '虎林市', '3');
INSERT INTO `x_region` VALUES ('1467', '172', '密山市', '3');
INSERT INTO `x_region` VALUES ('1468', '172', '鸡东县', '3');
INSERT INTO `x_region` VALUES ('1469', '173', '前进区', '3');
INSERT INTO `x_region` VALUES ('1470', '173', '郊区', '3');
INSERT INTO `x_region` VALUES ('1471', '173', '向阳区', '3');
INSERT INTO `x_region` VALUES ('1472', '173', '东风区', '3');
INSERT INTO `x_region` VALUES ('1473', '173', '同江市', '3');
INSERT INTO `x_region` VALUES ('1474', '173', '富锦市', '3');
INSERT INTO `x_region` VALUES ('1475', '173', '桦南县', '3');
INSERT INTO `x_region` VALUES ('1476', '173', '桦川县', '3');
INSERT INTO `x_region` VALUES ('1477', '173', '汤原县', '3');
INSERT INTO `x_region` VALUES ('1478', '173', '抚远县', '3');
INSERT INTO `x_region` VALUES ('1479', '174', '爱民区', '3');
INSERT INTO `x_region` VALUES ('1480', '174', '东安区', '3');
INSERT INTO `x_region` VALUES ('1481', '174', '阳明区', '3');
INSERT INTO `x_region` VALUES ('1482', '174', '西安区', '3');
INSERT INTO `x_region` VALUES ('1483', '174', '绥芬河市', '3');
INSERT INTO `x_region` VALUES ('1484', '174', '海林市', '3');
INSERT INTO `x_region` VALUES ('1485', '174', '宁安市', '3');
INSERT INTO `x_region` VALUES ('1486', '174', '穆棱市', '3');
INSERT INTO `x_region` VALUES ('1487', '174', '东宁县', '3');
INSERT INTO `x_region` VALUES ('1488', '174', '林口县', '3');
INSERT INTO `x_region` VALUES ('1489', '175', '桃山区', '3');
INSERT INTO `x_region` VALUES ('1490', '175', '新兴区', '3');
INSERT INTO `x_region` VALUES ('1491', '175', '茄子河区', '3');
INSERT INTO `x_region` VALUES ('1492', '175', '勃利县', '3');
INSERT INTO `x_region` VALUES ('1493', '176', '龙沙区', '3');
INSERT INTO `x_region` VALUES ('1494', '176', '昂昂溪区', '3');
INSERT INTO `x_region` VALUES ('1495', '176', '铁峰区', '3');
INSERT INTO `x_region` VALUES ('1496', '176', '建华区', '3');
INSERT INTO `x_region` VALUES ('1497', '176', '富拉尔基区', '3');
INSERT INTO `x_region` VALUES ('1498', '176', '碾子山区', '3');
INSERT INTO `x_region` VALUES ('1499', '176', '梅里斯达斡尔区', '3');
INSERT INTO `x_region` VALUES ('1500', '176', '讷河市', '3');
INSERT INTO `x_region` VALUES ('1501', '176', '龙江县', '3');
INSERT INTO `x_region` VALUES ('1502', '176', '依安县', '3');
INSERT INTO `x_region` VALUES ('1503', '176', '泰来县', '3');
INSERT INTO `x_region` VALUES ('1504', '176', '甘南县', '3');
INSERT INTO `x_region` VALUES ('1505', '176', '富裕县', '3');
INSERT INTO `x_region` VALUES ('1506', '176', '克山县', '3');
INSERT INTO `x_region` VALUES ('1507', '176', '克东县', '3');
INSERT INTO `x_region` VALUES ('1508', '176', '拜泉县', '3');
INSERT INTO `x_region` VALUES ('1509', '177', '尖山区', '3');
INSERT INTO `x_region` VALUES ('1510', '177', '岭东区', '3');
INSERT INTO `x_region` VALUES ('1511', '177', '四方台区', '3');
INSERT INTO `x_region` VALUES ('1512', '177', '宝山区', '3');
INSERT INTO `x_region` VALUES ('1513', '177', '集贤县', '3');
INSERT INTO `x_region` VALUES ('1514', '177', '友谊县', '3');
INSERT INTO `x_region` VALUES ('1515', '177', '宝清县', '3');
INSERT INTO `x_region` VALUES ('1516', '177', '饶河县', '3');
INSERT INTO `x_region` VALUES ('1517', '178', '北林区', '3');
INSERT INTO `x_region` VALUES ('1518', '178', '安达市', '3');
INSERT INTO `x_region` VALUES ('1519', '178', '肇东市', '3');
INSERT INTO `x_region` VALUES ('1520', '178', '海伦市', '3');
INSERT INTO `x_region` VALUES ('1521', '178', '望奎县', '3');
INSERT INTO `x_region` VALUES ('1522', '178', '兰西县', '3');
INSERT INTO `x_region` VALUES ('1523', '178', '青冈县', '3');
INSERT INTO `x_region` VALUES ('1524', '178', '庆安县', '3');
INSERT INTO `x_region` VALUES ('1525', '178', '明水县', '3');
INSERT INTO `x_region` VALUES ('1526', '178', '绥棱县', '3');
INSERT INTO `x_region` VALUES ('1527', '179', '伊春区', '3');
INSERT INTO `x_region` VALUES ('1528', '179', '带岭区', '3');
INSERT INTO `x_region` VALUES ('1529', '179', '南岔区', '3');
INSERT INTO `x_region` VALUES ('1530', '179', '金山屯区', '3');
INSERT INTO `x_region` VALUES ('1531', '179', '西林区', '3');
INSERT INTO `x_region` VALUES ('1532', '179', '美溪区', '3');
INSERT INTO `x_region` VALUES ('1533', '179', '乌马河区', '3');
INSERT INTO `x_region` VALUES ('1534', '179', '翠峦区', '3');
INSERT INTO `x_region` VALUES ('1535', '179', '友好区', '3');
INSERT INTO `x_region` VALUES ('1536', '179', '上甘岭区', '3');
INSERT INTO `x_region` VALUES ('1537', '179', '五营区', '3');
INSERT INTO `x_region` VALUES ('1538', '179', '红星区', '3');
INSERT INTO `x_region` VALUES ('1539', '179', '新青区', '3');
INSERT INTO `x_region` VALUES ('1540', '179', '汤旺河区', '3');
INSERT INTO `x_region` VALUES ('1541', '179', '乌伊岭区', '3');
INSERT INTO `x_region` VALUES ('1542', '179', '铁力市', '3');
INSERT INTO `x_region` VALUES ('1543', '179', '嘉荫县', '3');
INSERT INTO `x_region` VALUES ('1544', '180', '江岸区', '3');
INSERT INTO `x_region` VALUES ('1545', '180', '武昌区', '3');
INSERT INTO `x_region` VALUES ('1546', '180', '江汉区', '3');
INSERT INTO `x_region` VALUES ('1547', '180', '硚口区', '3');
INSERT INTO `x_region` VALUES ('1548', '180', '汉阳区', '3');
INSERT INTO `x_region` VALUES ('1549', '180', '青山区', '3');
INSERT INTO `x_region` VALUES ('1550', '180', '洪山区', '3');
INSERT INTO `x_region` VALUES ('1551', '180', '东西湖区', '3');
INSERT INTO `x_region` VALUES ('1552', '180', '汉南区', '3');
INSERT INTO `x_region` VALUES ('1553', '180', '蔡甸区', '3');
INSERT INTO `x_region` VALUES ('1554', '180', '江夏区', '3');
INSERT INTO `x_region` VALUES ('1555', '180', '黄陂区', '3');
INSERT INTO `x_region` VALUES ('1556', '180', '新洲区', '3');
INSERT INTO `x_region` VALUES ('1557', '180', '经济开发区', '3');
INSERT INTO `x_region` VALUES ('1558', '181', '仙桃市', '3');
INSERT INTO `x_region` VALUES ('1559', '182', '鄂城区', '3');
INSERT INTO `x_region` VALUES ('1560', '182', '华容区', '3');
INSERT INTO `x_region` VALUES ('1561', '182', '梁子湖区', '3');
INSERT INTO `x_region` VALUES ('1562', '183', '黄州区', '3');
INSERT INTO `x_region` VALUES ('1563', '183', '麻城市', '3');
INSERT INTO `x_region` VALUES ('1564', '183', '武穴市', '3');
INSERT INTO `x_region` VALUES ('1565', '183', '团风县', '3');
INSERT INTO `x_region` VALUES ('1566', '183', '红安县', '3');
INSERT INTO `x_region` VALUES ('1567', '183', '罗田县', '3');
INSERT INTO `x_region` VALUES ('1568', '183', '英山县', '3');
INSERT INTO `x_region` VALUES ('1569', '183', '浠水县', '3');
INSERT INTO `x_region` VALUES ('1570', '183', '蕲春县', '3');
INSERT INTO `x_region` VALUES ('1571', '183', '黄梅县', '3');
INSERT INTO `x_region` VALUES ('1572', '184', '黄石港区', '3');
INSERT INTO `x_region` VALUES ('1573', '184', '西塞山区', '3');
INSERT INTO `x_region` VALUES ('1574', '184', '下陆区', '3');
INSERT INTO `x_region` VALUES ('1575', '184', '铁山区', '3');
INSERT INTO `x_region` VALUES ('1576', '184', '大冶市', '3');
INSERT INTO `x_region` VALUES ('1577', '184', '阳新县', '3');
INSERT INTO `x_region` VALUES ('1578', '185', '东宝区', '3');
INSERT INTO `x_region` VALUES ('1579', '185', '掇刀区', '3');
INSERT INTO `x_region` VALUES ('1580', '185', '钟祥市', '3');
INSERT INTO `x_region` VALUES ('1581', '185', '京山县', '3');
INSERT INTO `x_region` VALUES ('1582', '185', '沙洋县', '3');
INSERT INTO `x_region` VALUES ('1583', '186', '沙市区', '3');
INSERT INTO `x_region` VALUES ('1584', '186', '荆州区', '3');
INSERT INTO `x_region` VALUES ('1585', '186', '石首市', '3');
INSERT INTO `x_region` VALUES ('1586', '186', '洪湖市', '3');
INSERT INTO `x_region` VALUES ('1587', '186', '松滋市', '3');
INSERT INTO `x_region` VALUES ('1588', '186', '公安县', '3');
INSERT INTO `x_region` VALUES ('1589', '186', '监利县', '3');
INSERT INTO `x_region` VALUES ('1590', '186', '江陵县', '3');
INSERT INTO `x_region` VALUES ('1591', '187', '潜江市', '3');
INSERT INTO `x_region` VALUES ('1592', '188', '神农架林区', '3');
INSERT INTO `x_region` VALUES ('1593', '189', '张湾区', '3');
INSERT INTO `x_region` VALUES ('1594', '189', '茅箭区', '3');
INSERT INTO `x_region` VALUES ('1595', '189', '丹江口市', '3');
INSERT INTO `x_region` VALUES ('1596', '189', '郧县', '3');
INSERT INTO `x_region` VALUES ('1597', '189', '郧西县', '3');
INSERT INTO `x_region` VALUES ('1598', '189', '竹山县', '3');
INSERT INTO `x_region` VALUES ('1599', '189', '竹溪县', '3');
INSERT INTO `x_region` VALUES ('1600', '189', '房县', '3');
INSERT INTO `x_region` VALUES ('1601', '190', '曾都区', '3');
INSERT INTO `x_region` VALUES ('1602', '190', '广水市', '3');
INSERT INTO `x_region` VALUES ('1603', '191', '天门市', '3');
INSERT INTO `x_region` VALUES ('1604', '192', '咸安区', '3');
INSERT INTO `x_region` VALUES ('1605', '192', '赤壁市', '3');
INSERT INTO `x_region` VALUES ('1606', '192', '嘉鱼县', '3');
INSERT INTO `x_region` VALUES ('1607', '192', '通城县', '3');
INSERT INTO `x_region` VALUES ('1608', '192', '崇阳县', '3');
INSERT INTO `x_region` VALUES ('1609', '192', '通山县', '3');
INSERT INTO `x_region` VALUES ('1610', '193', '襄城区', '3');
INSERT INTO `x_region` VALUES ('1611', '193', '樊城区', '3');
INSERT INTO `x_region` VALUES ('1612', '193', '襄阳区', '3');
INSERT INTO `x_region` VALUES ('1613', '193', '老河口市', '3');
INSERT INTO `x_region` VALUES ('1614', '193', '枣阳市', '3');
INSERT INTO `x_region` VALUES ('1615', '193', '宜城市', '3');
INSERT INTO `x_region` VALUES ('1616', '193', '南漳县', '3');
INSERT INTO `x_region` VALUES ('1617', '193', '谷城县', '3');
INSERT INTO `x_region` VALUES ('1618', '193', '保康县', '3');
INSERT INTO `x_region` VALUES ('1619', '194', '孝南区', '3');
INSERT INTO `x_region` VALUES ('1620', '194', '应城市', '3');
INSERT INTO `x_region` VALUES ('1621', '194', '安陆市', '3');
INSERT INTO `x_region` VALUES ('1622', '194', '汉川市', '3');
INSERT INTO `x_region` VALUES ('1623', '194', '孝昌县', '3');
INSERT INTO `x_region` VALUES ('1624', '194', '大悟县', '3');
INSERT INTO `x_region` VALUES ('1625', '194', '云梦县', '3');
INSERT INTO `x_region` VALUES ('1626', '195', '长阳', '3');
INSERT INTO `x_region` VALUES ('1627', '195', '五峰', '3');
INSERT INTO `x_region` VALUES ('1628', '195', '西陵区', '3');
INSERT INTO `x_region` VALUES ('1629', '195', '伍家岗区', '3');
INSERT INTO `x_region` VALUES ('1630', '195', '点军区', '3');
INSERT INTO `x_region` VALUES ('1631', '195', '猇亭区', '3');
INSERT INTO `x_region` VALUES ('1632', '195', '夷陵区', '3');
INSERT INTO `x_region` VALUES ('1633', '195', '宜都市', '3');
INSERT INTO `x_region` VALUES ('1634', '195', '当阳市', '3');
INSERT INTO `x_region` VALUES ('1635', '195', '枝江市', '3');
INSERT INTO `x_region` VALUES ('1636', '195', '远安县', '3');
INSERT INTO `x_region` VALUES ('1637', '195', '兴山县', '3');
INSERT INTO `x_region` VALUES ('1638', '195', '秭归县', '3');
INSERT INTO `x_region` VALUES ('1639', '196', '恩施市', '3');
INSERT INTO `x_region` VALUES ('1640', '196', '利川市', '3');
INSERT INTO `x_region` VALUES ('1641', '196', '建始县', '3');
INSERT INTO `x_region` VALUES ('1642', '196', '巴东县', '3');
INSERT INTO `x_region` VALUES ('1643', '196', '宣恩县', '3');
INSERT INTO `x_region` VALUES ('1644', '196', '咸丰县', '3');
INSERT INTO `x_region` VALUES ('1645', '196', '来凤县', '3');
INSERT INTO `x_region` VALUES ('1646', '196', '鹤峰县', '3');
INSERT INTO `x_region` VALUES ('1647', '197', '岳麓区', '3');
INSERT INTO `x_region` VALUES ('1648', '197', '芙蓉区', '3');
INSERT INTO `x_region` VALUES ('1649', '197', '天心区', '3');
INSERT INTO `x_region` VALUES ('1650', '197', '开福区', '3');
INSERT INTO `x_region` VALUES ('1651', '197', '雨花区', '3');
INSERT INTO `x_region` VALUES ('1652', '197', '开发区', '3');
INSERT INTO `x_region` VALUES ('1653', '197', '浏阳市', '3');
INSERT INTO `x_region` VALUES ('1654', '197', '长沙县', '3');
INSERT INTO `x_region` VALUES ('1655', '197', '望城县', '3');
INSERT INTO `x_region` VALUES ('1656', '197', '宁乡县', '3');
INSERT INTO `x_region` VALUES ('1657', '198', '永定区', '3');
INSERT INTO `x_region` VALUES ('1658', '198', '武陵源区', '3');
INSERT INTO `x_region` VALUES ('1659', '198', '慈利县', '3');
INSERT INTO `x_region` VALUES ('1660', '198', '桑植县', '3');
INSERT INTO `x_region` VALUES ('1661', '199', '武陵区', '3');
INSERT INTO `x_region` VALUES ('1662', '199', '鼎城区', '3');
INSERT INTO `x_region` VALUES ('1663', '199', '津市市', '3');
INSERT INTO `x_region` VALUES ('1664', '199', '安乡县', '3');
INSERT INTO `x_region` VALUES ('1665', '199', '汉寿县', '3');
INSERT INTO `x_region` VALUES ('1666', '199', '澧县', '3');
INSERT INTO `x_region` VALUES ('1667', '199', '临澧县', '3');
INSERT INTO `x_region` VALUES ('1668', '199', '桃源县', '3');
INSERT INTO `x_region` VALUES ('1669', '199', '石门县', '3');
INSERT INTO `x_region` VALUES ('1670', '200', '北湖区', '3');
INSERT INTO `x_region` VALUES ('1671', '200', '苏仙区', '3');
INSERT INTO `x_region` VALUES ('1672', '200', '资兴市', '3');
INSERT INTO `x_region` VALUES ('1673', '200', '桂阳县', '3');
INSERT INTO `x_region` VALUES ('1674', '200', '宜章县', '3');
INSERT INTO `x_region` VALUES ('1675', '200', '永兴县', '3');
INSERT INTO `x_region` VALUES ('1676', '200', '嘉禾县', '3');
INSERT INTO `x_region` VALUES ('1677', '200', '临武县', '3');
INSERT INTO `x_region` VALUES ('1678', '200', '汝城县', '3');
INSERT INTO `x_region` VALUES ('1679', '200', '桂东县', '3');
INSERT INTO `x_region` VALUES ('1680', '200', '安仁县', '3');
INSERT INTO `x_region` VALUES ('1681', '201', '雁峰区', '3');
INSERT INTO `x_region` VALUES ('1682', '201', '珠晖区', '3');
INSERT INTO `x_region` VALUES ('1683', '201', '石鼓区', '3');
INSERT INTO `x_region` VALUES ('1684', '201', '蒸湘区', '3');
INSERT INTO `x_region` VALUES ('1685', '201', '南岳区', '3');
INSERT INTO `x_region` VALUES ('1686', '201', '耒阳市', '3');
INSERT INTO `x_region` VALUES ('1687', '201', '常宁市', '3');
INSERT INTO `x_region` VALUES ('1688', '201', '衡阳县', '3');
INSERT INTO `x_region` VALUES ('1689', '201', '衡南县', '3');
INSERT INTO `x_region` VALUES ('1690', '201', '衡山县', '3');
INSERT INTO `x_region` VALUES ('1691', '201', '衡东县', '3');
INSERT INTO `x_region` VALUES ('1692', '201', '祁东县', '3');
INSERT INTO `x_region` VALUES ('1693', '202', '鹤城区', '3');
INSERT INTO `x_region` VALUES ('1694', '202', '靖州', '3');
INSERT INTO `x_region` VALUES ('1695', '202', '麻阳', '3');
INSERT INTO `x_region` VALUES ('1696', '202', '通道', '3');
INSERT INTO `x_region` VALUES ('1697', '202', '新晃', '3');
INSERT INTO `x_region` VALUES ('1698', '202', '芷江', '3');
INSERT INTO `x_region` VALUES ('1699', '202', '沅陵县', '3');
INSERT INTO `x_region` VALUES ('1700', '202', '辰溪县', '3');
INSERT INTO `x_region` VALUES ('1701', '202', '溆浦县', '3');
INSERT INTO `x_region` VALUES ('1702', '202', '中方县', '3');
INSERT INTO `x_region` VALUES ('1703', '202', '会同县', '3');
INSERT INTO `x_region` VALUES ('1704', '202', '洪江市', '3');
INSERT INTO `x_region` VALUES ('1705', '203', '娄星区', '3');
INSERT INTO `x_region` VALUES ('1706', '203', '冷水江市', '3');
INSERT INTO `x_region` VALUES ('1707', '203', '涟源市', '3');
INSERT INTO `x_region` VALUES ('1708', '203', '双峰县', '3');
INSERT INTO `x_region` VALUES ('1709', '203', '新化县', '3');
INSERT INTO `x_region` VALUES ('1710', '204', '城步', '3');
INSERT INTO `x_region` VALUES ('1711', '204', '双清区', '3');
INSERT INTO `x_region` VALUES ('1712', '204', '大祥区', '3');
INSERT INTO `x_region` VALUES ('1713', '204', '北塔区', '3');
INSERT INTO `x_region` VALUES ('1714', '204', '武冈市', '3');
INSERT INTO `x_region` VALUES ('1715', '204', '邵东县', '3');
INSERT INTO `x_region` VALUES ('1716', '204', '新邵县', '3');
INSERT INTO `x_region` VALUES ('1717', '204', '邵阳县', '3');
INSERT INTO `x_region` VALUES ('1718', '204', '隆回县', '3');
INSERT INTO `x_region` VALUES ('1719', '204', '洞口县', '3');
INSERT INTO `x_region` VALUES ('1720', '204', '绥宁县', '3');
INSERT INTO `x_region` VALUES ('1721', '204', '新宁县', '3');
INSERT INTO `x_region` VALUES ('1722', '205', '岳塘区', '3');
INSERT INTO `x_region` VALUES ('1723', '205', '雨湖区', '3');
INSERT INTO `x_region` VALUES ('1724', '205', '湘乡市', '3');
INSERT INTO `x_region` VALUES ('1725', '205', '韶山市', '3');
INSERT INTO `x_region` VALUES ('1726', '205', '湘潭县', '3');
INSERT INTO `x_region` VALUES ('1727', '206', '吉首市', '3');
INSERT INTO `x_region` VALUES ('1728', '206', '泸溪县', '3');
INSERT INTO `x_region` VALUES ('1729', '206', '凤凰县', '3');
INSERT INTO `x_region` VALUES ('1730', '206', '花垣县', '3');
INSERT INTO `x_region` VALUES ('1731', '206', '保靖县', '3');
INSERT INTO `x_region` VALUES ('1732', '206', '古丈县', '3');
INSERT INTO `x_region` VALUES ('1733', '206', '永顺县', '3');
INSERT INTO `x_region` VALUES ('1734', '206', '龙山县', '3');
INSERT INTO `x_region` VALUES ('1735', '207', '赫山区', '3');
INSERT INTO `x_region` VALUES ('1736', '207', '资阳区', '3');
INSERT INTO `x_region` VALUES ('1737', '207', '沅江市', '3');
INSERT INTO `x_region` VALUES ('1738', '207', '南县', '3');
INSERT INTO `x_region` VALUES ('1739', '207', '桃江县', '3');
INSERT INTO `x_region` VALUES ('1740', '207', '安化县', '3');
INSERT INTO `x_region` VALUES ('1741', '208', '江华', '3');
INSERT INTO `x_region` VALUES ('1742', '208', '冷水滩区', '3');
INSERT INTO `x_region` VALUES ('1743', '208', '零陵区', '3');
INSERT INTO `x_region` VALUES ('1744', '208', '祁阳县', '3');
INSERT INTO `x_region` VALUES ('1745', '208', '东安县', '3');
INSERT INTO `x_region` VALUES ('1746', '208', '双牌县', '3');
INSERT INTO `x_region` VALUES ('1747', '208', '道县', '3');
INSERT INTO `x_region` VALUES ('1748', '208', '江永县', '3');
INSERT INTO `x_region` VALUES ('1749', '208', '宁远县', '3');
INSERT INTO `x_region` VALUES ('1750', '208', '蓝山县', '3');
INSERT INTO `x_region` VALUES ('1751', '208', '新田县', '3');
INSERT INTO `x_region` VALUES ('1752', '209', '岳阳楼区', '3');
INSERT INTO `x_region` VALUES ('1753', '209', '君山区', '3');
INSERT INTO `x_region` VALUES ('1754', '209', '云溪区', '3');
INSERT INTO `x_region` VALUES ('1755', '209', '汨罗市', '3');
INSERT INTO `x_region` VALUES ('1756', '209', '临湘市', '3');
INSERT INTO `x_region` VALUES ('1757', '209', '岳阳县', '3');
INSERT INTO `x_region` VALUES ('1758', '209', '华容县', '3');
INSERT INTO `x_region` VALUES ('1759', '209', '湘阴县', '3');
INSERT INTO `x_region` VALUES ('1760', '209', '平江县', '3');
INSERT INTO `x_region` VALUES ('1761', '210', '天元区', '3');
INSERT INTO `x_region` VALUES ('1762', '210', '荷塘区', '3');
INSERT INTO `x_region` VALUES ('1763', '210', '芦淞区', '3');
INSERT INTO `x_region` VALUES ('1764', '210', '石峰区', '3');
INSERT INTO `x_region` VALUES ('1765', '210', '醴陵市', '3');
INSERT INTO `x_region` VALUES ('1766', '210', '株洲县', '3');
INSERT INTO `x_region` VALUES ('1767', '210', '攸县', '3');
INSERT INTO `x_region` VALUES ('1768', '210', '茶陵县', '3');
INSERT INTO `x_region` VALUES ('1769', '210', '炎陵县', '3');
INSERT INTO `x_region` VALUES ('1770', '211', '朝阳区', '3');
INSERT INTO `x_region` VALUES ('1771', '211', '宽城区', '3');
INSERT INTO `x_region` VALUES ('1772', '211', '二道区', '3');
INSERT INTO `x_region` VALUES ('1773', '211', '南关区', '3');
INSERT INTO `x_region` VALUES ('1774', '211', '绿园区', '3');
INSERT INTO `x_region` VALUES ('1775', '211', '双阳区', '3');
INSERT INTO `x_region` VALUES ('1776', '211', '净月潭开发区', '3');
INSERT INTO `x_region` VALUES ('1777', '211', '高新技术开发区', '3');
INSERT INTO `x_region` VALUES ('1778', '211', '经济技术开发区', '3');
INSERT INTO `x_region` VALUES ('1779', '211', '汽车产业开发区', '3');
INSERT INTO `x_region` VALUES ('1780', '211', '德惠市', '3');
INSERT INTO `x_region` VALUES ('1781', '211', '九台市', '3');
INSERT INTO `x_region` VALUES ('1782', '211', '榆树市', '3');
INSERT INTO `x_region` VALUES ('1783', '211', '农安县', '3');
INSERT INTO `x_region` VALUES ('1784', '212', '船营区', '3');
INSERT INTO `x_region` VALUES ('1785', '212', '昌邑区', '3');
INSERT INTO `x_region` VALUES ('1786', '212', '龙潭区', '3');
INSERT INTO `x_region` VALUES ('1787', '212', '丰满区', '3');
INSERT INTO `x_region` VALUES ('1788', '212', '蛟河市', '3');
INSERT INTO `x_region` VALUES ('1789', '212', '桦甸市', '3');
INSERT INTO `x_region` VALUES ('1790', '212', '舒兰市', '3');
INSERT INTO `x_region` VALUES ('1791', '212', '磐石市', '3');
INSERT INTO `x_region` VALUES ('1792', '212', '永吉县', '3');
INSERT INTO `x_region` VALUES ('1793', '213', '洮北区', '3');
INSERT INTO `x_region` VALUES ('1794', '213', '洮南市', '3');
INSERT INTO `x_region` VALUES ('1795', '213', '大安市', '3');
INSERT INTO `x_region` VALUES ('1796', '213', '镇赉县', '3');
INSERT INTO `x_region` VALUES ('1797', '213', '通榆县', '3');
INSERT INTO `x_region` VALUES ('1798', '214', '江源区', '3');
INSERT INTO `x_region` VALUES ('1799', '214', '八道江区', '3');
INSERT INTO `x_region` VALUES ('1800', '214', '长白', '3');
INSERT INTO `x_region` VALUES ('1801', '214', '临江市', '3');
INSERT INTO `x_region` VALUES ('1802', '214', '抚松县', '3');
INSERT INTO `x_region` VALUES ('1803', '214', '靖宇县', '3');
INSERT INTO `x_region` VALUES ('1804', '215', '龙山区', '3');
INSERT INTO `x_region` VALUES ('1805', '215', '西安区', '3');
INSERT INTO `x_region` VALUES ('1806', '215', '东丰县', '3');
INSERT INTO `x_region` VALUES ('1807', '215', '东辽县', '3');
INSERT INTO `x_region` VALUES ('1808', '216', '铁西区', '3');
INSERT INTO `x_region` VALUES ('1809', '216', '铁东区', '3');
INSERT INTO `x_region` VALUES ('1810', '216', '伊通', '3');
INSERT INTO `x_region` VALUES ('1811', '216', '公主岭市', '3');
INSERT INTO `x_region` VALUES ('1812', '216', '双辽市', '3');
INSERT INTO `x_region` VALUES ('1813', '216', '梨树县', '3');
INSERT INTO `x_region` VALUES ('1814', '217', '前郭尔罗斯', '3');
INSERT INTO `x_region` VALUES ('1815', '217', '宁江区', '3');
INSERT INTO `x_region` VALUES ('1816', '217', '长岭县', '3');
INSERT INTO `x_region` VALUES ('1817', '217', '乾安县', '3');
INSERT INTO `x_region` VALUES ('1818', '217', '扶余县', '3');
INSERT INTO `x_region` VALUES ('1819', '218', '东昌区', '3');
INSERT INTO `x_region` VALUES ('1820', '218', '二道江区', '3');
INSERT INTO `x_region` VALUES ('1821', '218', '梅河口市', '3');
INSERT INTO `x_region` VALUES ('1822', '218', '集安市', '3');
INSERT INTO `x_region` VALUES ('1823', '218', '通化县', '3');
INSERT INTO `x_region` VALUES ('1824', '218', '辉南县', '3');
INSERT INTO `x_region` VALUES ('1825', '218', '柳河县', '3');
INSERT INTO `x_region` VALUES ('1826', '219', '延吉市', '3');
INSERT INTO `x_region` VALUES ('1827', '219', '图们市', '3');
INSERT INTO `x_region` VALUES ('1828', '219', '敦化市', '3');
INSERT INTO `x_region` VALUES ('1829', '219', '珲春市', '3');
INSERT INTO `x_region` VALUES ('1830', '219', '龙井市', '3');
INSERT INTO `x_region` VALUES ('1831', '219', '和龙市', '3');
INSERT INTO `x_region` VALUES ('1832', '219', '安图县', '3');
INSERT INTO `x_region` VALUES ('1833', '219', '汪清县', '3');
INSERT INTO `x_region` VALUES ('1834', '220', '玄武区', '3');
INSERT INTO `x_region` VALUES ('1835', '220', '鼓楼区', '3');
INSERT INTO `x_region` VALUES ('1836', '220', '白下区', '3');
INSERT INTO `x_region` VALUES ('1837', '220', '建邺区', '3');
INSERT INTO `x_region` VALUES ('1838', '220', '秦淮区', '3');
INSERT INTO `x_region` VALUES ('1839', '220', '雨花台区', '3');
INSERT INTO `x_region` VALUES ('1840', '220', '下关区', '3');
INSERT INTO `x_region` VALUES ('1841', '220', '栖霞区', '3');
INSERT INTO `x_region` VALUES ('1842', '220', '浦口区', '3');
INSERT INTO `x_region` VALUES ('1843', '220', '江宁区', '3');
INSERT INTO `x_region` VALUES ('1844', '220', '六合区', '3');
INSERT INTO `x_region` VALUES ('1845', '220', '溧水县', '3');
INSERT INTO `x_region` VALUES ('1846', '220', '高淳县', '3');
INSERT INTO `x_region` VALUES ('1847', '221', '沧浪区', '3');
INSERT INTO `x_region` VALUES ('1848', '221', '金阊区', '3');
INSERT INTO `x_region` VALUES ('1849', '221', '平江区', '3');
INSERT INTO `x_region` VALUES ('1850', '221', '虎丘区', '3');
INSERT INTO `x_region` VALUES ('1851', '221', '吴中区', '3');
INSERT INTO `x_region` VALUES ('1852', '221', '相城区', '3');
INSERT INTO `x_region` VALUES ('1853', '221', '园区', '3');
INSERT INTO `x_region` VALUES ('1854', '221', '新区', '3');
INSERT INTO `x_region` VALUES ('1855', '221', '常熟市', '3');
INSERT INTO `x_region` VALUES ('1856', '221', '张家港市', '3');
INSERT INTO `x_region` VALUES ('1857', '221', '玉山镇', '3');
INSERT INTO `x_region` VALUES ('1858', '221', '巴城镇', '3');
INSERT INTO `x_region` VALUES ('1859', '221', '周市镇', '3');
INSERT INTO `x_region` VALUES ('1860', '221', '陆家镇', '3');
INSERT INTO `x_region` VALUES ('1861', '221', '花桥镇', '3');
INSERT INTO `x_region` VALUES ('1862', '221', '淀山湖镇', '3');
INSERT INTO `x_region` VALUES ('1863', '221', '张浦镇', '3');
INSERT INTO `x_region` VALUES ('1864', '221', '周庄镇', '3');
INSERT INTO `x_region` VALUES ('1865', '221', '千灯镇', '3');
INSERT INTO `x_region` VALUES ('1866', '221', '锦溪镇', '3');
INSERT INTO `x_region` VALUES ('1867', '221', '开发区', '3');
INSERT INTO `x_region` VALUES ('1868', '221', '吴江市', '3');
INSERT INTO `x_region` VALUES ('1869', '221', '太仓市', '3');
INSERT INTO `x_region` VALUES ('1870', '222', '崇安区', '3');
INSERT INTO `x_region` VALUES ('1871', '222', '北塘区', '3');
INSERT INTO `x_region` VALUES ('1872', '222', '南长区', '3');
INSERT INTO `x_region` VALUES ('1873', '222', '锡山区', '3');
INSERT INTO `x_region` VALUES ('1874', '222', '惠山区', '3');
INSERT INTO `x_region` VALUES ('1875', '222', '滨湖区', '3');
INSERT INTO `x_region` VALUES ('1876', '222', '新区', '3');
INSERT INTO `x_region` VALUES ('1877', '222', '江阴市', '3');
INSERT INTO `x_region` VALUES ('1878', '222', '宜兴市', '3');
INSERT INTO `x_region` VALUES ('1879', '223', '天宁区', '3');
INSERT INTO `x_region` VALUES ('1880', '223', '钟楼区', '3');
INSERT INTO `x_region` VALUES ('1881', '223', '戚墅堰区', '3');
INSERT INTO `x_region` VALUES ('1882', '223', '郊区', '3');
INSERT INTO `x_region` VALUES ('1883', '223', '新北区', '3');
INSERT INTO `x_region` VALUES ('1884', '223', '武进区', '3');
INSERT INTO `x_region` VALUES ('1885', '223', '溧阳市', '3');
INSERT INTO `x_region` VALUES ('1886', '223', '金坛市', '3');
INSERT INTO `x_region` VALUES ('1887', '224', '清河区', '3');
INSERT INTO `x_region` VALUES ('1888', '224', '清浦区', '3');
INSERT INTO `x_region` VALUES ('1889', '224', '楚州区', '3');
INSERT INTO `x_region` VALUES ('1890', '224', '淮阴区', '3');
INSERT INTO `x_region` VALUES ('1891', '224', '涟水县', '3');
INSERT INTO `x_region` VALUES ('1892', '224', '洪泽县', '3');
INSERT INTO `x_region` VALUES ('1893', '224', '盱眙县', '3');
INSERT INTO `x_region` VALUES ('1894', '224', '金湖县', '3');
INSERT INTO `x_region` VALUES ('1895', '225', '新浦区', '3');
INSERT INTO `x_region` VALUES ('1896', '225', '连云区', '3');
INSERT INTO `x_region` VALUES ('1897', '225', '海州区', '3');
INSERT INTO `x_region` VALUES ('1898', '225', '赣榆县', '3');
INSERT INTO `x_region` VALUES ('1899', '225', '东海县', '3');
INSERT INTO `x_region` VALUES ('1900', '225', '灌云县', '3');
INSERT INTO `x_region` VALUES ('1901', '225', '灌南县', '3');
INSERT INTO `x_region` VALUES ('1902', '226', '崇川区', '3');
INSERT INTO `x_region` VALUES ('1903', '226', '港闸区', '3');
INSERT INTO `x_region` VALUES ('1904', '226', '经济开发区', '3');
INSERT INTO `x_region` VALUES ('1905', '226', '启东市', '3');
INSERT INTO `x_region` VALUES ('1906', '226', '如皋市', '3');
INSERT INTO `x_region` VALUES ('1907', '226', '通州市', '3');
INSERT INTO `x_region` VALUES ('1908', '226', '海门市', '3');
INSERT INTO `x_region` VALUES ('1909', '226', '海安县', '3');
INSERT INTO `x_region` VALUES ('1910', '226', '如东县', '3');
INSERT INTO `x_region` VALUES ('1911', '227', '宿城区', '3');
INSERT INTO `x_region` VALUES ('1912', '227', '宿豫区', '3');
INSERT INTO `x_region` VALUES ('1913', '227', '宿豫县', '3');
INSERT INTO `x_region` VALUES ('1914', '227', '沭阳县', '3');
INSERT INTO `x_region` VALUES ('1915', '227', '泗阳县', '3');
INSERT INTO `x_region` VALUES ('1916', '227', '泗洪县', '3');
INSERT INTO `x_region` VALUES ('1917', '228', '海陵区', '3');
INSERT INTO `x_region` VALUES ('1918', '228', '高港区', '3');
INSERT INTO `x_region` VALUES ('1919', '228', '兴化市', '3');
INSERT INTO `x_region` VALUES ('1920', '228', '靖江市', '3');
INSERT INTO `x_region` VALUES ('1921', '228', '泰兴市', '3');
INSERT INTO `x_region` VALUES ('1922', '228', '姜堰市', '3');
INSERT INTO `x_region` VALUES ('1923', '229', '云龙区', '3');
INSERT INTO `x_region` VALUES ('1924', '229', '鼓楼区', '3');
INSERT INTO `x_region` VALUES ('1925', '229', '九里区', '3');
INSERT INTO `x_region` VALUES ('1926', '229', '贾汪区', '3');
INSERT INTO `x_region` VALUES ('1927', '229', '泉山区', '3');
INSERT INTO `x_region` VALUES ('1928', '229', '新沂市', '3');
INSERT INTO `x_region` VALUES ('1929', '229', '邳州市', '3');
INSERT INTO `x_region` VALUES ('1930', '229', '丰县', '3');
INSERT INTO `x_region` VALUES ('1931', '229', '沛县', '3');
INSERT INTO `x_region` VALUES ('1932', '229', '铜山县', '3');
INSERT INTO `x_region` VALUES ('1933', '229', '睢宁县', '3');
INSERT INTO `x_region` VALUES ('1934', '230', '城区', '3');
INSERT INTO `x_region` VALUES ('1935', '230', '亭湖区', '3');
INSERT INTO `x_region` VALUES ('1936', '230', '盐都区', '3');
INSERT INTO `x_region` VALUES ('1937', '230', '盐都县', '3');
INSERT INTO `x_region` VALUES ('1938', '230', '东台市', '3');
INSERT INTO `x_region` VALUES ('1939', '230', '大丰市', '3');
INSERT INTO `x_region` VALUES ('1940', '230', '响水县', '3');
INSERT INTO `x_region` VALUES ('1941', '230', '滨海县', '3');
INSERT INTO `x_region` VALUES ('1942', '230', '阜宁县', '3');
INSERT INTO `x_region` VALUES ('1943', '230', '射阳县', '3');
INSERT INTO `x_region` VALUES ('1944', '230', '建湖县', '3');
INSERT INTO `x_region` VALUES ('1945', '231', '广陵区', '3');
INSERT INTO `x_region` VALUES ('1946', '231', '维扬区', '3');
INSERT INTO `x_region` VALUES ('1947', '231', '邗江区', '3');
INSERT INTO `x_region` VALUES ('1948', '231', '仪征市', '3');
INSERT INTO `x_region` VALUES ('1949', '231', '高邮市', '3');
INSERT INTO `x_region` VALUES ('1950', '231', '江都市', '3');
INSERT INTO `x_region` VALUES ('1951', '231', '宝应县', '3');
INSERT INTO `x_region` VALUES ('1952', '232', '京口区', '3');
INSERT INTO `x_region` VALUES ('1953', '232', '润州区', '3');
INSERT INTO `x_region` VALUES ('1954', '232', '丹徒区', '3');
INSERT INTO `x_region` VALUES ('1955', '232', '丹阳市', '3');
INSERT INTO `x_region` VALUES ('1956', '232', '扬中市', '3');
INSERT INTO `x_region` VALUES ('1957', '232', '句容市', '3');
INSERT INTO `x_region` VALUES ('1958', '233', '东湖区', '3');
INSERT INTO `x_region` VALUES ('1959', '233', '西湖区', '3');
INSERT INTO `x_region` VALUES ('1960', '233', '青云谱区', '3');
INSERT INTO `x_region` VALUES ('1961', '233', '湾里区', '3');
INSERT INTO `x_region` VALUES ('1962', '233', '青山湖区', '3');
INSERT INTO `x_region` VALUES ('1963', '233', '红谷滩新区', '3');
INSERT INTO `x_region` VALUES ('1964', '233', '昌北区', '3');
INSERT INTO `x_region` VALUES ('1965', '233', '高新区', '3');
INSERT INTO `x_region` VALUES ('1966', '233', '南昌县', '3');
INSERT INTO `x_region` VALUES ('1967', '233', '新建县', '3');
INSERT INTO `x_region` VALUES ('1968', '233', '安义县', '3');
INSERT INTO `x_region` VALUES ('1969', '233', '进贤县', '3');
INSERT INTO `x_region` VALUES ('1970', '234', '临川区', '3');
INSERT INTO `x_region` VALUES ('1971', '234', '南城县', '3');
INSERT INTO `x_region` VALUES ('1972', '234', '黎川县', '3');
INSERT INTO `x_region` VALUES ('1973', '234', '南丰县', '3');
INSERT INTO `x_region` VALUES ('1974', '234', '崇仁县', '3');
INSERT INTO `x_region` VALUES ('1975', '234', '乐安县', '3');
INSERT INTO `x_region` VALUES ('1976', '234', '宜黄县', '3');
INSERT INTO `x_region` VALUES ('1977', '234', '金溪县', '3');
INSERT INTO `x_region` VALUES ('1978', '234', '资溪县', '3');
INSERT INTO `x_region` VALUES ('1979', '234', '东乡县', '3');
INSERT INTO `x_region` VALUES ('1980', '234', '广昌县', '3');
INSERT INTO `x_region` VALUES ('1981', '235', '章贡区', '3');
INSERT INTO `x_region` VALUES ('1982', '235', '于都县', '3');
INSERT INTO `x_region` VALUES ('1983', '235', '瑞金市', '3');
INSERT INTO `x_region` VALUES ('1984', '235', '南康市', '3');
INSERT INTO `x_region` VALUES ('1985', '235', '赣县', '3');
INSERT INTO `x_region` VALUES ('1986', '235', '信丰县', '3');
INSERT INTO `x_region` VALUES ('1987', '235', '大余县', '3');
INSERT INTO `x_region` VALUES ('1988', '235', '上犹县', '3');
INSERT INTO `x_region` VALUES ('1989', '235', '崇义县', '3');
INSERT INTO `x_region` VALUES ('1990', '235', '安远县', '3');
INSERT INTO `x_region` VALUES ('1991', '235', '龙南县', '3');
INSERT INTO `x_region` VALUES ('1992', '235', '定南县', '3');
INSERT INTO `x_region` VALUES ('1993', '235', '全南县', '3');
INSERT INTO `x_region` VALUES ('1994', '235', '宁都县', '3');
INSERT INTO `x_region` VALUES ('1995', '235', '兴国县', '3');
INSERT INTO `x_region` VALUES ('1996', '235', '会昌县', '3');
INSERT INTO `x_region` VALUES ('1997', '235', '寻乌县', '3');
INSERT INTO `x_region` VALUES ('1998', '235', '石城县', '3');
INSERT INTO `x_region` VALUES ('1999', '236', '安福县', '3');
INSERT INTO `x_region` VALUES ('2000', '236', '吉州区', '3');
INSERT INTO `x_region` VALUES ('2001', '236', '青原区', '3');
INSERT INTO `x_region` VALUES ('2002', '236', '井冈山市', '3');
INSERT INTO `x_region` VALUES ('2003', '236', '吉安县', '3');
INSERT INTO `x_region` VALUES ('2004', '236', '吉水县', '3');
INSERT INTO `x_region` VALUES ('2005', '236', '峡江县', '3');
INSERT INTO `x_region` VALUES ('2006', '236', '新干县', '3');
INSERT INTO `x_region` VALUES ('2007', '236', '永丰县', '3');
INSERT INTO `x_region` VALUES ('2008', '236', '泰和县', '3');
INSERT INTO `x_region` VALUES ('2009', '236', '遂川县', '3');
INSERT INTO `x_region` VALUES ('2010', '236', '万安县', '3');
INSERT INTO `x_region` VALUES ('2011', '236', '永新县', '3');
INSERT INTO `x_region` VALUES ('2012', '237', '珠山区', '3');
INSERT INTO `x_region` VALUES ('2013', '237', '昌江区', '3');
INSERT INTO `x_region` VALUES ('2014', '237', '乐平市', '3');
INSERT INTO `x_region` VALUES ('2015', '237', '浮梁县', '3');
INSERT INTO `x_region` VALUES ('2016', '238', '浔阳区', '3');
INSERT INTO `x_region` VALUES ('2017', '238', '庐山区', '3');
INSERT INTO `x_region` VALUES ('2018', '238', '瑞昌市', '3');
INSERT INTO `x_region` VALUES ('2019', '238', '九江县', '3');
INSERT INTO `x_region` VALUES ('2020', '238', '武宁县', '3');
INSERT INTO `x_region` VALUES ('2021', '238', '修水县', '3');
INSERT INTO `x_region` VALUES ('2022', '238', '永修县', '3');
INSERT INTO `x_region` VALUES ('2023', '238', '德安县', '3');
INSERT INTO `x_region` VALUES ('2024', '238', '星子县', '3');
INSERT INTO `x_region` VALUES ('2025', '238', '都昌县', '3');
INSERT INTO `x_region` VALUES ('2026', '238', '湖口县', '3');
INSERT INTO `x_region` VALUES ('2027', '238', '彭泽县', '3');
INSERT INTO `x_region` VALUES ('2028', '239', '安源区', '3');
INSERT INTO `x_region` VALUES ('2029', '239', '湘东区', '3');
INSERT INTO `x_region` VALUES ('2030', '239', '莲花县', '3');
INSERT INTO `x_region` VALUES ('2031', '239', '芦溪县', '3');
INSERT INTO `x_region` VALUES ('2032', '239', '上栗县', '3');
INSERT INTO `x_region` VALUES ('2033', '240', '信州区', '3');
INSERT INTO `x_region` VALUES ('2034', '240', '德兴市', '3');
INSERT INTO `x_region` VALUES ('2035', '240', '上饶县', '3');
INSERT INTO `x_region` VALUES ('2036', '240', '广丰县', '3');
INSERT INTO `x_region` VALUES ('2037', '240', '玉山县', '3');
INSERT INTO `x_region` VALUES ('2038', '240', '铅山县', '3');
INSERT INTO `x_region` VALUES ('2039', '240', '横峰县', '3');
INSERT INTO `x_region` VALUES ('2040', '240', '弋阳县', '3');
INSERT INTO `x_region` VALUES ('2041', '240', '余干县', '3');
INSERT INTO `x_region` VALUES ('2042', '240', '波阳县', '3');
INSERT INTO `x_region` VALUES ('2043', '240', '万年县', '3');
INSERT INTO `x_region` VALUES ('2044', '240', '婺源县', '3');
INSERT INTO `x_region` VALUES ('2045', '241', '渝水区', '3');
INSERT INTO `x_region` VALUES ('2046', '241', '分宜县', '3');
INSERT INTO `x_region` VALUES ('2047', '242', '袁州区', '3');
INSERT INTO `x_region` VALUES ('2048', '242', '丰城市', '3');
INSERT INTO `x_region` VALUES ('2049', '242', '樟树市', '3');
INSERT INTO `x_region` VALUES ('2050', '242', '高安市', '3');
INSERT INTO `x_region` VALUES ('2051', '242', '奉新县', '3');
INSERT INTO `x_region` VALUES ('2052', '242', '万载县', '3');
INSERT INTO `x_region` VALUES ('2053', '242', '上高县', '3');
INSERT INTO `x_region` VALUES ('2054', '242', '宜丰县', '3');
INSERT INTO `x_region` VALUES ('2055', '242', '靖安县', '3');
INSERT INTO `x_region` VALUES ('2056', '242', '铜鼓县', '3');
INSERT INTO `x_region` VALUES ('2057', '243', '月湖区', '3');
INSERT INTO `x_region` VALUES ('2058', '243', '贵溪市', '3');
INSERT INTO `x_region` VALUES ('2059', '243', '余江县', '3');
INSERT INTO `x_region` VALUES ('2060', '244', '沈河区', '3');
INSERT INTO `x_region` VALUES ('2061', '244', '皇姑区', '3');
INSERT INTO `x_region` VALUES ('2062', '244', '和平区', '3');
INSERT INTO `x_region` VALUES ('2063', '244', '大东区', '3');
INSERT INTO `x_region` VALUES ('2064', '244', '铁西区', '3');
INSERT INTO `x_region` VALUES ('2065', '244', '苏家屯区', '3');
INSERT INTO `x_region` VALUES ('2066', '244', '东陵区', '3');
INSERT INTO `x_region` VALUES ('2067', '244', '沈北新区', '3');
INSERT INTO `x_region` VALUES ('2068', '244', '于洪区', '3');
INSERT INTO `x_region` VALUES ('2069', '244', '浑南新区', '3');
INSERT INTO `x_region` VALUES ('2070', '244', '新民市', '3');
INSERT INTO `x_region` VALUES ('2071', '244', '辽中县', '3');
INSERT INTO `x_region` VALUES ('2072', '244', '康平县', '3');
INSERT INTO `x_region` VALUES ('2073', '244', '法库县', '3');
INSERT INTO `x_region` VALUES ('2074', '245', '西岗区', '3');
INSERT INTO `x_region` VALUES ('2075', '245', '中山区', '3');
INSERT INTO `x_region` VALUES ('2076', '245', '沙河口区', '3');
INSERT INTO `x_region` VALUES ('2077', '245', '甘井子区', '3');
INSERT INTO `x_region` VALUES ('2078', '245', '旅顺口区', '3');
INSERT INTO `x_region` VALUES ('2079', '245', '金州区', '3');
INSERT INTO `x_region` VALUES ('2080', '245', '开发区', '3');
INSERT INTO `x_region` VALUES ('2081', '245', '瓦房店市', '3');
INSERT INTO `x_region` VALUES ('2082', '245', '普兰店市', '3');
INSERT INTO `x_region` VALUES ('2083', '245', '庄河市', '3');
INSERT INTO `x_region` VALUES ('2084', '245', '长海县', '3');
INSERT INTO `x_region` VALUES ('2085', '246', '铁东区', '3');
INSERT INTO `x_region` VALUES ('2086', '246', '铁西区', '3');
INSERT INTO `x_region` VALUES ('2087', '246', '立山区', '3');
INSERT INTO `x_region` VALUES ('2088', '246', '千山区', '3');
INSERT INTO `x_region` VALUES ('2089', '246', '岫岩', '3');
INSERT INTO `x_region` VALUES ('2090', '246', '海城市', '3');
INSERT INTO `x_region` VALUES ('2091', '246', '台安县', '3');
INSERT INTO `x_region` VALUES ('2092', '247', '本溪', '3');
INSERT INTO `x_region` VALUES ('2093', '247', '平山区', '3');
INSERT INTO `x_region` VALUES ('2094', '247', '明山区', '3');
INSERT INTO `x_region` VALUES ('2095', '247', '溪湖区', '3');
INSERT INTO `x_region` VALUES ('2096', '247', '南芬区', '3');
INSERT INTO `x_region` VALUES ('2097', '247', '桓仁', '3');
INSERT INTO `x_region` VALUES ('2098', '248', '双塔区', '3');
INSERT INTO `x_region` VALUES ('2099', '248', '龙城区', '3');
INSERT INTO `x_region` VALUES ('2100', '248', '喀喇沁左翼蒙古族自治县', '3');
INSERT INTO `x_region` VALUES ('2101', '248', '北票市', '3');
INSERT INTO `x_region` VALUES ('2102', '248', '凌源市', '3');
INSERT INTO `x_region` VALUES ('2103', '248', '朝阳县', '3');
INSERT INTO `x_region` VALUES ('2104', '248', '建平县', '3');
INSERT INTO `x_region` VALUES ('2105', '249', '振兴区', '3');
INSERT INTO `x_region` VALUES ('2106', '249', '元宝区', '3');
INSERT INTO `x_region` VALUES ('2107', '249', '振安区', '3');
INSERT INTO `x_region` VALUES ('2108', '249', '宽甸', '3');
INSERT INTO `x_region` VALUES ('2109', '249', '东港市', '3');
INSERT INTO `x_region` VALUES ('2110', '249', '凤城市', '3');
INSERT INTO `x_region` VALUES ('2111', '250', '顺城区', '3');
INSERT INTO `x_region` VALUES ('2112', '250', '新抚区', '3');
INSERT INTO `x_region` VALUES ('2113', '250', '东洲区', '3');
INSERT INTO `x_region` VALUES ('2114', '250', '望花区', '3');
INSERT INTO `x_region` VALUES ('2115', '250', '清原', '3');
INSERT INTO `x_region` VALUES ('2116', '250', '新宾', '3');
INSERT INTO `x_region` VALUES ('2117', '250', '抚顺县', '3');
INSERT INTO `x_region` VALUES ('2118', '251', '阜新', '3');
INSERT INTO `x_region` VALUES ('2119', '251', '海州区', '3');
INSERT INTO `x_region` VALUES ('2120', '251', '新邱区', '3');
INSERT INTO `x_region` VALUES ('2121', '251', '太平区', '3');
INSERT INTO `x_region` VALUES ('2122', '251', '清河门区', '3');
INSERT INTO `x_region` VALUES ('2123', '251', '细河区', '3');
INSERT INTO `x_region` VALUES ('2124', '251', '彰武县', '3');
INSERT INTO `x_region` VALUES ('2125', '252', '龙港区', '3');
INSERT INTO `x_region` VALUES ('2126', '252', '南票区', '3');
INSERT INTO `x_region` VALUES ('2127', '252', '连山区', '3');
INSERT INTO `x_region` VALUES ('2128', '252', '兴城市', '3');
INSERT INTO `x_region` VALUES ('2129', '252', '绥中县', '3');
INSERT INTO `x_region` VALUES ('2130', '252', '建昌县', '3');
INSERT INTO `x_region` VALUES ('2131', '253', '太和区', '3');
INSERT INTO `x_region` VALUES ('2132', '253', '古塔区', '3');
INSERT INTO `x_region` VALUES ('2133', '253', '凌河区', '3');
INSERT INTO `x_region` VALUES ('2134', '253', '凌海市', '3');
INSERT INTO `x_region` VALUES ('2135', '253', '北镇市', '3');
INSERT INTO `x_region` VALUES ('2136', '253', '黑山县', '3');
INSERT INTO `x_region` VALUES ('2137', '253', '义县', '3');
INSERT INTO `x_region` VALUES ('2138', '254', '白塔区', '3');
INSERT INTO `x_region` VALUES ('2139', '254', '文圣区', '3');
INSERT INTO `x_region` VALUES ('2140', '254', '宏伟区', '3');
INSERT INTO `x_region` VALUES ('2141', '254', '太子河区', '3');
INSERT INTO `x_region` VALUES ('2142', '254', '弓长岭区', '3');
INSERT INTO `x_region` VALUES ('2143', '254', '灯塔市', '3');
INSERT INTO `x_region` VALUES ('2144', '254', '辽阳县', '3');
INSERT INTO `x_region` VALUES ('2145', '255', '双台子区', '3');
INSERT INTO `x_region` VALUES ('2146', '255', '兴隆台区', '3');
INSERT INTO `x_region` VALUES ('2147', '255', '大洼县', '3');
INSERT INTO `x_region` VALUES ('2148', '255', '盘山县', '3');
INSERT INTO `x_region` VALUES ('2149', '256', '银州区', '3');
INSERT INTO `x_region` VALUES ('2150', '256', '清河区', '3');
INSERT INTO `x_region` VALUES ('2151', '256', '调兵山市', '3');
INSERT INTO `x_region` VALUES ('2152', '256', '开原市', '3');
INSERT INTO `x_region` VALUES ('2153', '256', '铁岭县', '3');
INSERT INTO `x_region` VALUES ('2154', '256', '西丰县', '3');
INSERT INTO `x_region` VALUES ('2155', '256', '昌图县', '3');
INSERT INTO `x_region` VALUES ('2156', '257', '站前区', '3');
INSERT INTO `x_region` VALUES ('2157', '257', '西市区', '3');
INSERT INTO `x_region` VALUES ('2158', '257', '鲅鱼圈区', '3');
INSERT INTO `x_region` VALUES ('2159', '257', '老边区', '3');
INSERT INTO `x_region` VALUES ('2160', '257', '盖州市', '3');
INSERT INTO `x_region` VALUES ('2161', '257', '大石桥市', '3');
INSERT INTO `x_region` VALUES ('2162', '258', '回民区', '3');
INSERT INTO `x_region` VALUES ('2163', '258', '玉泉区', '3');
INSERT INTO `x_region` VALUES ('2164', '258', '新城区', '3');
INSERT INTO `x_region` VALUES ('2165', '258', '赛罕区', '3');
INSERT INTO `x_region` VALUES ('2166', '258', '清水河县', '3');
INSERT INTO `x_region` VALUES ('2167', '258', '土默特左旗', '3');
INSERT INTO `x_region` VALUES ('2168', '258', '托克托县', '3');
INSERT INTO `x_region` VALUES ('2169', '258', '和林格尔县', '3');
INSERT INTO `x_region` VALUES ('2170', '258', '武川县', '3');
INSERT INTO `x_region` VALUES ('2171', '259', '阿拉善左旗', '3');
INSERT INTO `x_region` VALUES ('2172', '259', '阿拉善右旗', '3');
INSERT INTO `x_region` VALUES ('2173', '259', '额济纳旗', '3');
INSERT INTO `x_region` VALUES ('2174', '260', '临河区', '3');
INSERT INTO `x_region` VALUES ('2175', '260', '五原县', '3');
INSERT INTO `x_region` VALUES ('2176', '260', '磴口县', '3');
INSERT INTO `x_region` VALUES ('2177', '260', '乌拉特前旗', '3');
INSERT INTO `x_region` VALUES ('2178', '260', '乌拉特中旗', '3');
INSERT INTO `x_region` VALUES ('2179', '260', '乌拉特后旗', '3');
INSERT INTO `x_region` VALUES ('2180', '260', '杭锦后旗', '3');
INSERT INTO `x_region` VALUES ('2181', '261', '昆都仑区', '3');
INSERT INTO `x_region` VALUES ('2182', '261', '青山区', '3');
INSERT INTO `x_region` VALUES ('2183', '261', '东河区', '3');
INSERT INTO `x_region` VALUES ('2184', '261', '九原区', '3');
INSERT INTO `x_region` VALUES ('2185', '261', '石拐区', '3');
INSERT INTO `x_region` VALUES ('2186', '261', '白云矿区', '3');
INSERT INTO `x_region` VALUES ('2187', '261', '土默特右旗', '3');
INSERT INTO `x_region` VALUES ('2188', '261', '固阳县', '3');
INSERT INTO `x_region` VALUES ('2189', '261', '达尔罕茂明安联合旗', '3');
INSERT INTO `x_region` VALUES ('2190', '262', '红山区', '3');
INSERT INTO `x_region` VALUES ('2191', '262', '元宝山区', '3');
INSERT INTO `x_region` VALUES ('2192', '262', '松山区', '3');
INSERT INTO `x_region` VALUES ('2193', '262', '阿鲁科尔沁旗', '3');
INSERT INTO `x_region` VALUES ('2194', '262', '巴林左旗', '3');
INSERT INTO `x_region` VALUES ('2195', '262', '巴林右旗', '3');
INSERT INTO `x_region` VALUES ('2196', '262', '林西县', '3');
INSERT INTO `x_region` VALUES ('2197', '262', '克什克腾旗', '3');
INSERT INTO `x_region` VALUES ('2198', '262', '翁牛特旗', '3');
INSERT INTO `x_region` VALUES ('2199', '262', '喀喇沁旗', '3');
INSERT INTO `x_region` VALUES ('2200', '262', '宁城县', '3');
INSERT INTO `x_region` VALUES ('2201', '262', '敖汉旗', '3');
INSERT INTO `x_region` VALUES ('2202', '263', '东胜区', '3');
INSERT INTO `x_region` VALUES ('2203', '263', '达拉特旗', '3');
INSERT INTO `x_region` VALUES ('2204', '263', '准格尔旗', '3');
INSERT INTO `x_region` VALUES ('2205', '263', '鄂托克前旗', '3');
INSERT INTO `x_region` VALUES ('2206', '263', '鄂托克旗', '3');
INSERT INTO `x_region` VALUES ('2207', '263', '杭锦旗', '3');
INSERT INTO `x_region` VALUES ('2208', '263', '乌审旗', '3');
INSERT INTO `x_region` VALUES ('2209', '263', '伊金霍洛旗', '3');
INSERT INTO `x_region` VALUES ('2210', '264', '海拉尔区', '3');
INSERT INTO `x_region` VALUES ('2211', '264', '莫力达瓦', '3');
INSERT INTO `x_region` VALUES ('2212', '264', '满洲里市', '3');
INSERT INTO `x_region` VALUES ('2213', '264', '牙克石市', '3');
INSERT INTO `x_region` VALUES ('2214', '264', '扎兰屯市', '3');
INSERT INTO `x_region` VALUES ('2215', '264', '额尔古纳市', '3');
INSERT INTO `x_region` VALUES ('2216', '264', '根河市', '3');
INSERT INTO `x_region` VALUES ('2217', '264', '阿荣旗', '3');
INSERT INTO `x_region` VALUES ('2218', '264', '鄂伦春自治旗', '3');
INSERT INTO `x_region` VALUES ('2219', '264', '鄂温克族自治旗', '3');
INSERT INTO `x_region` VALUES ('2220', '264', '陈巴尔虎旗', '3');
INSERT INTO `x_region` VALUES ('2221', '264', '新巴尔虎左旗', '3');
INSERT INTO `x_region` VALUES ('2222', '264', '新巴尔虎右旗', '3');
INSERT INTO `x_region` VALUES ('2223', '265', '科尔沁区', '3');
INSERT INTO `x_region` VALUES ('2224', '265', '霍林郭勒市', '3');
INSERT INTO `x_region` VALUES ('2225', '265', '科尔沁左翼中旗', '3');
INSERT INTO `x_region` VALUES ('2226', '265', '科尔沁左翼后旗', '3');
INSERT INTO `x_region` VALUES ('2227', '265', '开鲁县', '3');
INSERT INTO `x_region` VALUES ('2228', '265', '库伦旗', '3');
INSERT INTO `x_region` VALUES ('2229', '265', '奈曼旗', '3');
INSERT INTO `x_region` VALUES ('2230', '265', '扎鲁特旗', '3');
INSERT INTO `x_region` VALUES ('2231', '266', '海勃湾区', '3');
INSERT INTO `x_region` VALUES ('2232', '266', '乌达区', '3');
INSERT INTO `x_region` VALUES ('2233', '266', '海南区', '3');
INSERT INTO `x_region` VALUES ('2234', '267', '化德县', '3');
INSERT INTO `x_region` VALUES ('2235', '267', '集宁区', '3');
INSERT INTO `x_region` VALUES ('2236', '267', '丰镇市', '3');
INSERT INTO `x_region` VALUES ('2237', '267', '卓资县', '3');
INSERT INTO `x_region` VALUES ('2238', '267', '商都县', '3');
INSERT INTO `x_region` VALUES ('2239', '267', '兴和县', '3');
INSERT INTO `x_region` VALUES ('2240', '267', '凉城县', '3');
INSERT INTO `x_region` VALUES ('2241', '267', '察哈尔右翼前旗', '3');
INSERT INTO `x_region` VALUES ('2242', '267', '察哈尔右翼中旗', '3');
INSERT INTO `x_region` VALUES ('2243', '267', '察哈尔右翼后旗', '3');
INSERT INTO `x_region` VALUES ('2244', '267', '四子王旗', '3');
INSERT INTO `x_region` VALUES ('2245', '268', '二连浩特市', '3');
INSERT INTO `x_region` VALUES ('2246', '268', '锡林浩特市', '3');
INSERT INTO `x_region` VALUES ('2247', '268', '阿巴嘎旗', '3');
INSERT INTO `x_region` VALUES ('2248', '268', '苏尼特左旗', '3');
INSERT INTO `x_region` VALUES ('2249', '268', '苏尼特右旗', '3');
INSERT INTO `x_region` VALUES ('2250', '268', '东乌珠穆沁旗', '3');
INSERT INTO `x_region` VALUES ('2251', '268', '西乌珠穆沁旗', '3');
INSERT INTO `x_region` VALUES ('2252', '268', '太仆寺旗', '3');
INSERT INTO `x_region` VALUES ('2253', '268', '镶黄旗', '3');
INSERT INTO `x_region` VALUES ('2254', '268', '正镶白旗', '3');
INSERT INTO `x_region` VALUES ('2255', '268', '正蓝旗', '3');
INSERT INTO `x_region` VALUES ('2256', '268', '多伦县', '3');
INSERT INTO `x_region` VALUES ('2257', '269', '乌兰浩特市', '3');
INSERT INTO `x_region` VALUES ('2258', '269', '阿尔山市', '3');
INSERT INTO `x_region` VALUES ('2259', '269', '科尔沁右翼前旗', '3');
INSERT INTO `x_region` VALUES ('2260', '269', '科尔沁右翼中旗', '3');
INSERT INTO `x_region` VALUES ('2261', '269', '扎赉特旗', '3');
INSERT INTO `x_region` VALUES ('2262', '269', '突泉县', '3');
INSERT INTO `x_region` VALUES ('2263', '270', '西夏区', '3');
INSERT INTO `x_region` VALUES ('2264', '270', '金凤区', '3');
INSERT INTO `x_region` VALUES ('2265', '270', '兴庆区', '3');
INSERT INTO `x_region` VALUES ('2266', '270', '灵武市', '3');
INSERT INTO `x_region` VALUES ('2267', '270', '永宁县', '3');
INSERT INTO `x_region` VALUES ('2268', '270', '贺兰县', '3');
INSERT INTO `x_region` VALUES ('2269', '271', '原州区', '3');
INSERT INTO `x_region` VALUES ('2270', '271', '海原县', '3');
INSERT INTO `x_region` VALUES ('2271', '271', '西吉县', '3');
INSERT INTO `x_region` VALUES ('2272', '271', '隆德县', '3');
INSERT INTO `x_region` VALUES ('2273', '271', '泾源县', '3');
INSERT INTO `x_region` VALUES ('2274', '271', '彭阳县', '3');
INSERT INTO `x_region` VALUES ('2275', '272', '惠农县', '3');
INSERT INTO `x_region` VALUES ('2276', '272', '大武口区', '3');
INSERT INTO `x_region` VALUES ('2277', '272', '惠农区', '3');
INSERT INTO `x_region` VALUES ('2278', '272', '陶乐县', '3');
INSERT INTO `x_region` VALUES ('2279', '272', '平罗县', '3');
INSERT INTO `x_region` VALUES ('2280', '273', '利通区', '3');
INSERT INTO `x_region` VALUES ('2281', '273', '中卫县', '3');
INSERT INTO `x_region` VALUES ('2282', '273', '青铜峡市', '3');
INSERT INTO `x_region` VALUES ('2283', '273', '中宁县', '3');
INSERT INTO `x_region` VALUES ('2284', '273', '盐池县', '3');
INSERT INTO `x_region` VALUES ('2285', '273', '同心县', '3');
INSERT INTO `x_region` VALUES ('2286', '274', '沙坡头区', '3');
INSERT INTO `x_region` VALUES ('2287', '274', '海原县', '3');
INSERT INTO `x_region` VALUES ('2288', '274', '中宁县', '3');
INSERT INTO `x_region` VALUES ('2289', '275', '城中区', '3');
INSERT INTO `x_region` VALUES ('2290', '275', '城东区', '3');
INSERT INTO `x_region` VALUES ('2291', '275', '城西区', '3');
INSERT INTO `x_region` VALUES ('2292', '275', '城北区', '3');
INSERT INTO `x_region` VALUES ('2293', '275', '湟中县', '3');
INSERT INTO `x_region` VALUES ('2294', '275', '湟源县', '3');
INSERT INTO `x_region` VALUES ('2295', '275', '大通', '3');
INSERT INTO `x_region` VALUES ('2296', '276', '玛沁县', '3');
INSERT INTO `x_region` VALUES ('2297', '276', '班玛县', '3');
INSERT INTO `x_region` VALUES ('2298', '276', '甘德县', '3');
INSERT INTO `x_region` VALUES ('2299', '276', '达日县', '3');
INSERT INTO `x_region` VALUES ('2300', '276', '久治县', '3');
INSERT INTO `x_region` VALUES ('2301', '276', '玛多县', '3');
INSERT INTO `x_region` VALUES ('2302', '277', '海晏县', '3');
INSERT INTO `x_region` VALUES ('2303', '277', '祁连县', '3');
INSERT INTO `x_region` VALUES ('2304', '277', '刚察县', '3');
INSERT INTO `x_region` VALUES ('2305', '277', '门源', '3');
INSERT INTO `x_region` VALUES ('2306', '278', '平安县', '3');
INSERT INTO `x_region` VALUES ('2307', '278', '乐都县', '3');
INSERT INTO `x_region` VALUES ('2308', '278', '民和', '3');
INSERT INTO `x_region` VALUES ('2309', '278', '互助', '3');
INSERT INTO `x_region` VALUES ('2310', '278', '化隆', '3');
INSERT INTO `x_region` VALUES ('2311', '278', '循化', '3');
INSERT INTO `x_region` VALUES ('2312', '279', '共和县', '3');
INSERT INTO `x_region` VALUES ('2313', '279', '同德县', '3');
INSERT INTO `x_region` VALUES ('2314', '279', '贵德县', '3');
INSERT INTO `x_region` VALUES ('2315', '279', '兴海县', '3');
INSERT INTO `x_region` VALUES ('2316', '279', '贵南县', '3');
INSERT INTO `x_region` VALUES ('2317', '280', '德令哈市', '3');
INSERT INTO `x_region` VALUES ('2318', '280', '格尔木市', '3');
INSERT INTO `x_region` VALUES ('2319', '280', '乌兰县', '3');
INSERT INTO `x_region` VALUES ('2320', '280', '都兰县', '3');
INSERT INTO `x_region` VALUES ('2321', '280', '天峻县', '3');
INSERT INTO `x_region` VALUES ('2322', '281', '同仁县', '3');
INSERT INTO `x_region` VALUES ('2323', '281', '尖扎县', '3');
INSERT INTO `x_region` VALUES ('2324', '281', '泽库县', '3');
INSERT INTO `x_region` VALUES ('2325', '281', '河南蒙古族自治县', '3');
INSERT INTO `x_region` VALUES ('2326', '282', '玉树县', '3');
INSERT INTO `x_region` VALUES ('2327', '282', '杂多县', '3');
INSERT INTO `x_region` VALUES ('2328', '282', '称多县', '3');
INSERT INTO `x_region` VALUES ('2329', '282', '治多县', '3');
INSERT INTO `x_region` VALUES ('2330', '282', '囊谦县', '3');
INSERT INTO `x_region` VALUES ('2331', '282', '曲麻莱县', '3');
INSERT INTO `x_region` VALUES ('2332', '283', '市中区', '3');
INSERT INTO `x_region` VALUES ('2333', '283', '历下区', '3');
INSERT INTO `x_region` VALUES ('2334', '283', '天桥区', '3');
INSERT INTO `x_region` VALUES ('2335', '283', '槐荫区', '3');
INSERT INTO `x_region` VALUES ('2336', '283', '历城区', '3');
INSERT INTO `x_region` VALUES ('2337', '283', '长清区', '3');
INSERT INTO `x_region` VALUES ('2338', '283', '章丘市', '3');
INSERT INTO `x_region` VALUES ('2339', '283', '平阴县', '3');
INSERT INTO `x_region` VALUES ('2340', '283', '济阳县', '3');
INSERT INTO `x_region` VALUES ('2341', '283', '商河县', '3');
INSERT INTO `x_region` VALUES ('2342', '284', '市南区', '3');
INSERT INTO `x_region` VALUES ('2343', '284', '市北区', '3');
INSERT INTO `x_region` VALUES ('2344', '284', '城阳区', '3');
INSERT INTO `x_region` VALUES ('2345', '284', '四方区', '3');
INSERT INTO `x_region` VALUES ('2346', '284', '李沧区', '3');
INSERT INTO `x_region` VALUES ('2347', '284', '黄岛区', '3');
INSERT INTO `x_region` VALUES ('2348', '284', '崂山区', '3');
INSERT INTO `x_region` VALUES ('2349', '284', '胶州市', '3');
INSERT INTO `x_region` VALUES ('2350', '284', '即墨市', '3');
INSERT INTO `x_region` VALUES ('2351', '284', '平度市', '3');
INSERT INTO `x_region` VALUES ('2352', '284', '胶南市', '3');
INSERT INTO `x_region` VALUES ('2353', '284', '莱西市', '3');
INSERT INTO `x_region` VALUES ('2354', '285', '滨城区', '3');
INSERT INTO `x_region` VALUES ('2355', '285', '惠民县', '3');
INSERT INTO `x_region` VALUES ('2356', '285', '阳信县', '3');
INSERT INTO `x_region` VALUES ('2357', '285', '无棣县', '3');
INSERT INTO `x_region` VALUES ('2358', '285', '沾化县', '3');
INSERT INTO `x_region` VALUES ('2359', '285', '博兴县', '3');
INSERT INTO `x_region` VALUES ('2360', '285', '邹平县', '3');
INSERT INTO `x_region` VALUES ('2361', '286', '德城区', '3');
INSERT INTO `x_region` VALUES ('2362', '286', '陵县', '3');
INSERT INTO `x_region` VALUES ('2363', '286', '乐陵市', '3');
INSERT INTO `x_region` VALUES ('2364', '286', '禹城市', '3');
INSERT INTO `x_region` VALUES ('2365', '286', '宁津县', '3');
INSERT INTO `x_region` VALUES ('2366', '286', '庆云县', '3');
INSERT INTO `x_region` VALUES ('2367', '286', '临邑县', '3');
INSERT INTO `x_region` VALUES ('2368', '286', '齐河县', '3');
INSERT INTO `x_region` VALUES ('2369', '286', '平原县', '3');
INSERT INTO `x_region` VALUES ('2370', '286', '夏津县', '3');
INSERT INTO `x_region` VALUES ('2371', '286', '武城县', '3');
INSERT INTO `x_region` VALUES ('2372', '287', '东营区', '3');
INSERT INTO `x_region` VALUES ('2373', '287', '河口区', '3');
INSERT INTO `x_region` VALUES ('2374', '287', '垦利县', '3');
INSERT INTO `x_region` VALUES ('2375', '287', '利津县', '3');
INSERT INTO `x_region` VALUES ('2376', '287', '广饶县', '3');
INSERT INTO `x_region` VALUES ('2377', '288', '牡丹区', '3');
INSERT INTO `x_region` VALUES ('2378', '288', '曹县', '3');
INSERT INTO `x_region` VALUES ('2379', '288', '单县', '3');
INSERT INTO `x_region` VALUES ('2380', '288', '成武县', '3');
INSERT INTO `x_region` VALUES ('2381', '288', '巨野县', '3');
INSERT INTO `x_region` VALUES ('2382', '288', '郓城县', '3');
INSERT INTO `x_region` VALUES ('2383', '288', '鄄城县', '3');
INSERT INTO `x_region` VALUES ('2384', '288', '定陶县', '3');
INSERT INTO `x_region` VALUES ('2385', '288', '东明县', '3');
INSERT INTO `x_region` VALUES ('2386', '289', '市中区', '3');
INSERT INTO `x_region` VALUES ('2387', '289', '任城区', '3');
INSERT INTO `x_region` VALUES ('2388', '289', '曲阜市', '3');
INSERT INTO `x_region` VALUES ('2389', '289', '兖州市', '3');
INSERT INTO `x_region` VALUES ('2390', '289', '邹城市', '3');
INSERT INTO `x_region` VALUES ('2391', '289', '微山县', '3');
INSERT INTO `x_region` VALUES ('2392', '289', '鱼台县', '3');
INSERT INTO `x_region` VALUES ('2393', '289', '金乡县', '3');
INSERT INTO `x_region` VALUES ('2394', '289', '嘉祥县', '3');
INSERT INTO `x_region` VALUES ('2395', '289', '汶上县', '3');
INSERT INTO `x_region` VALUES ('2396', '289', '泗水县', '3');
INSERT INTO `x_region` VALUES ('2397', '289', '梁山县', '3');
INSERT INTO `x_region` VALUES ('2398', '290', '莱城区', '3');
INSERT INTO `x_region` VALUES ('2399', '290', '钢城区', '3');
INSERT INTO `x_region` VALUES ('2400', '291', '东昌府区', '3');
INSERT INTO `x_region` VALUES ('2401', '291', '临清市', '3');
INSERT INTO `x_region` VALUES ('2402', '291', '阳谷县', '3');
INSERT INTO `x_region` VALUES ('2403', '291', '莘县', '3');
INSERT INTO `x_region` VALUES ('2404', '291', '茌平县', '3');
INSERT INTO `x_region` VALUES ('2405', '291', '东阿县', '3');
INSERT INTO `x_region` VALUES ('2406', '291', '冠县', '3');
INSERT INTO `x_region` VALUES ('2407', '291', '高唐县', '3');
INSERT INTO `x_region` VALUES ('2408', '292', '兰山区', '3');
INSERT INTO `x_region` VALUES ('2409', '292', '罗庄区', '3');
INSERT INTO `x_region` VALUES ('2410', '292', '河东区', '3');
INSERT INTO `x_region` VALUES ('2411', '292', '沂南县', '3');
INSERT INTO `x_region` VALUES ('2412', '292', '郯城县', '3');
INSERT INTO `x_region` VALUES ('2413', '292', '沂水县', '3');
INSERT INTO `x_region` VALUES ('2414', '292', '苍山县', '3');
INSERT INTO `x_region` VALUES ('2415', '292', '费县', '3');
INSERT INTO `x_region` VALUES ('2416', '292', '平邑县', '3');
INSERT INTO `x_region` VALUES ('2417', '292', '莒南县', '3');
INSERT INTO `x_region` VALUES ('2418', '292', '蒙阴县', '3');
INSERT INTO `x_region` VALUES ('2419', '292', '临沭县', '3');
INSERT INTO `x_region` VALUES ('2420', '293', '东港区', '3');
INSERT INTO `x_region` VALUES ('2421', '293', '岚山区', '3');
INSERT INTO `x_region` VALUES ('2422', '293', '五莲县', '3');
INSERT INTO `x_region` VALUES ('2423', '293', '莒县', '3');
INSERT INTO `x_region` VALUES ('2424', '294', '泰山区', '3');
INSERT INTO `x_region` VALUES ('2425', '294', '岱岳区', '3');
INSERT INTO `x_region` VALUES ('2426', '294', '新泰市', '3');
INSERT INTO `x_region` VALUES ('2427', '294', '肥城市', '3');
INSERT INTO `x_region` VALUES ('2428', '294', '宁阳县', '3');
INSERT INTO `x_region` VALUES ('2429', '294', '东平县', '3');
INSERT INTO `x_region` VALUES ('2430', '295', '荣成市', '3');
INSERT INTO `x_region` VALUES ('2431', '295', '乳山市', '3');
INSERT INTO `x_region` VALUES ('2432', '295', '环翠区', '3');
INSERT INTO `x_region` VALUES ('2433', '295', '文登市', '3');
INSERT INTO `x_region` VALUES ('2434', '296', '潍城区', '3');
INSERT INTO `x_region` VALUES ('2435', '296', '寒亭区', '3');
INSERT INTO `x_region` VALUES ('2436', '296', '坊子区', '3');
INSERT INTO `x_region` VALUES ('2437', '296', '奎文区', '3');
INSERT INTO `x_region` VALUES ('2438', '296', '青州市', '3');
INSERT INTO `x_region` VALUES ('2439', '296', '诸城市', '3');
INSERT INTO `x_region` VALUES ('2440', '296', '寿光市', '3');
INSERT INTO `x_region` VALUES ('2441', '296', '安丘市', '3');
INSERT INTO `x_region` VALUES ('2442', '296', '高密市', '3');
INSERT INTO `x_region` VALUES ('2443', '296', '昌邑市', '3');
INSERT INTO `x_region` VALUES ('2444', '296', '临朐县', '3');
INSERT INTO `x_region` VALUES ('2445', '296', '昌乐县', '3');
INSERT INTO `x_region` VALUES ('2446', '297', '芝罘区', '3');
INSERT INTO `x_region` VALUES ('2447', '297', '福山区', '3');
INSERT INTO `x_region` VALUES ('2448', '297', '牟平区', '3');
INSERT INTO `x_region` VALUES ('2449', '297', '莱山区', '3');
INSERT INTO `x_region` VALUES ('2450', '297', '开发区', '3');
INSERT INTO `x_region` VALUES ('2451', '297', '龙口市', '3');
INSERT INTO `x_region` VALUES ('2452', '297', '莱阳市', '3');
INSERT INTO `x_region` VALUES ('2453', '297', '莱州市', '3');
INSERT INTO `x_region` VALUES ('2454', '297', '蓬莱市', '3');
INSERT INTO `x_region` VALUES ('2455', '297', '招远市', '3');
INSERT INTO `x_region` VALUES ('2456', '297', '栖霞市', '3');
INSERT INTO `x_region` VALUES ('2457', '297', '海阳市', '3');
INSERT INTO `x_region` VALUES ('2458', '297', '长岛县', '3');
INSERT INTO `x_region` VALUES ('2459', '298', '市中区', '3');
INSERT INTO `x_region` VALUES ('2460', '298', '山亭区', '3');
INSERT INTO `x_region` VALUES ('2461', '298', '峄城区', '3');
INSERT INTO `x_region` VALUES ('2462', '298', '台儿庄区', '3');
INSERT INTO `x_region` VALUES ('2463', '298', '薛城区', '3');
INSERT INTO `x_region` VALUES ('2464', '298', '滕州市', '3');
INSERT INTO `x_region` VALUES ('2465', '299', '张店区', '3');
INSERT INTO `x_region` VALUES ('2466', '299', '临淄区', '3');
INSERT INTO `x_region` VALUES ('2467', '299', '淄川区', '3');
INSERT INTO `x_region` VALUES ('2468', '299', '博山区', '3');
INSERT INTO `x_region` VALUES ('2469', '299', '周村区', '3');
INSERT INTO `x_region` VALUES ('2470', '299', '桓台县', '3');
INSERT INTO `x_region` VALUES ('2471', '299', '高青县', '3');
INSERT INTO `x_region` VALUES ('2472', '299', '沂源县', '3');
INSERT INTO `x_region` VALUES ('2473', '300', '杏花岭区', '3');
INSERT INTO `x_region` VALUES ('2474', '300', '小店区', '3');
INSERT INTO `x_region` VALUES ('2475', '300', '迎泽区', '3');
INSERT INTO `x_region` VALUES ('2476', '300', '尖草坪区', '3');
INSERT INTO `x_region` VALUES ('2477', '300', '万柏林区', '3');
INSERT INTO `x_region` VALUES ('2478', '300', '晋源区', '3');
INSERT INTO `x_region` VALUES ('2479', '300', '高新开发区', '3');
INSERT INTO `x_region` VALUES ('2480', '300', '民营经济开发区', '3');
INSERT INTO `x_region` VALUES ('2481', '300', '经济技术开发区', '3');
INSERT INTO `x_region` VALUES ('2482', '300', '清徐县', '3');
INSERT INTO `x_region` VALUES ('2483', '300', '阳曲县', '3');
INSERT INTO `x_region` VALUES ('2484', '300', '娄烦县', '3');
INSERT INTO `x_region` VALUES ('2485', '300', '古交市', '3');
INSERT INTO `x_region` VALUES ('2486', '301', '城区', '3');
INSERT INTO `x_region` VALUES ('2487', '301', '郊区', '3');
INSERT INTO `x_region` VALUES ('2488', '301', '沁县', '3');
INSERT INTO `x_region` VALUES ('2489', '301', '潞城市', '3');
INSERT INTO `x_region` VALUES ('2490', '301', '长治县', '3');
INSERT INTO `x_region` VALUES ('2491', '301', '襄垣县', '3');
INSERT INTO `x_region` VALUES ('2492', '301', '屯留县', '3');
INSERT INTO `x_region` VALUES ('2493', '301', '平顺县', '3');
INSERT INTO `x_region` VALUES ('2494', '301', '黎城县', '3');
INSERT INTO `x_region` VALUES ('2495', '301', '壶关县', '3');
INSERT INTO `x_region` VALUES ('2496', '301', '长子县', '3');
INSERT INTO `x_region` VALUES ('2497', '301', '武乡县', '3');
INSERT INTO `x_region` VALUES ('2498', '301', '沁源县', '3');
INSERT INTO `x_region` VALUES ('2499', '302', '城区', '3');
INSERT INTO `x_region` VALUES ('2500', '302', '矿区', '3');
INSERT INTO `x_region` VALUES ('2501', '302', '南郊区', '3');
INSERT INTO `x_region` VALUES ('2502', '302', '新荣区', '3');
INSERT INTO `x_region` VALUES ('2503', '302', '阳高县', '3');
INSERT INTO `x_region` VALUES ('2504', '302', '天镇县', '3');
INSERT INTO `x_region` VALUES ('2505', '302', '广灵县', '3');
INSERT INTO `x_region` VALUES ('2506', '302', '灵丘县', '3');
INSERT INTO `x_region` VALUES ('2507', '302', '浑源县', '3');
INSERT INTO `x_region` VALUES ('2508', '302', '左云县', '3');
INSERT INTO `x_region` VALUES ('2509', '302', '大同县', '3');
INSERT INTO `x_region` VALUES ('2510', '303', '城区', '3');
INSERT INTO `x_region` VALUES ('2511', '303', '高平市', '3');
INSERT INTO `x_region` VALUES ('2512', '303', '沁水县', '3');
INSERT INTO `x_region` VALUES ('2513', '303', '阳城县', '3');
INSERT INTO `x_region` VALUES ('2514', '303', '陵川县', '3');
INSERT INTO `x_region` VALUES ('2515', '303', '泽州县', '3');
INSERT INTO `x_region` VALUES ('2516', '304', '榆次区', '3');
INSERT INTO `x_region` VALUES ('2517', '304', '介休市', '3');
INSERT INTO `x_region` VALUES ('2518', '304', '榆社县', '3');
INSERT INTO `x_region` VALUES ('2519', '304', '左权县', '3');
INSERT INTO `x_region` VALUES ('2520', '304', '和顺县', '3');
INSERT INTO `x_region` VALUES ('2521', '304', '昔阳县', '3');
INSERT INTO `x_region` VALUES ('2522', '304', '寿阳县', '3');
INSERT INTO `x_region` VALUES ('2523', '304', '太谷县', '3');
INSERT INTO `x_region` VALUES ('2524', '304', '祁县', '3');
INSERT INTO `x_region` VALUES ('2525', '304', '平遥县', '3');
INSERT INTO `x_region` VALUES ('2526', '304', '灵石县', '3');
INSERT INTO `x_region` VALUES ('2527', '305', '尧都区', '3');
INSERT INTO `x_region` VALUES ('2528', '305', '侯马市', '3');
INSERT INTO `x_region` VALUES ('2529', '305', '霍州市', '3');
INSERT INTO `x_region` VALUES ('2530', '305', '曲沃县', '3');
INSERT INTO `x_region` VALUES ('2531', '305', '翼城县', '3');
INSERT INTO `x_region` VALUES ('2532', '305', '襄汾县', '3');
INSERT INTO `x_region` VALUES ('2533', '305', '洪洞县', '3');
INSERT INTO `x_region` VALUES ('2534', '305', '吉县', '3');
INSERT INTO `x_region` VALUES ('2535', '305', '安泽县', '3');
INSERT INTO `x_region` VALUES ('2536', '305', '浮山县', '3');
INSERT INTO `x_region` VALUES ('2537', '305', '古县', '3');
INSERT INTO `x_region` VALUES ('2538', '305', '乡宁县', '3');
INSERT INTO `x_region` VALUES ('2539', '305', '大宁县', '3');
INSERT INTO `x_region` VALUES ('2540', '305', '隰县', '3');
INSERT INTO `x_region` VALUES ('2541', '305', '永和县', '3');
INSERT INTO `x_region` VALUES ('2542', '305', '蒲县', '3');
INSERT INTO `x_region` VALUES ('2543', '305', '汾西县', '3');
INSERT INTO `x_region` VALUES ('2544', '306', '离石市', '3');
INSERT INTO `x_region` VALUES ('2545', '306', '离石区', '3');
INSERT INTO `x_region` VALUES ('2546', '306', '孝义市', '3');
INSERT INTO `x_region` VALUES ('2547', '306', '汾阳市', '3');
INSERT INTO `x_region` VALUES ('2548', '306', '文水县', '3');
INSERT INTO `x_region` VALUES ('2549', '306', '交城县', '3');
INSERT INTO `x_region` VALUES ('2550', '306', '兴县', '3');
INSERT INTO `x_region` VALUES ('2551', '306', '临县', '3');
INSERT INTO `x_region` VALUES ('2552', '306', '柳林县', '3');
INSERT INTO `x_region` VALUES ('2553', '306', '石楼县', '3');
INSERT INTO `x_region` VALUES ('2554', '306', '岚县', '3');
INSERT INTO `x_region` VALUES ('2555', '306', '方山县', '3');
INSERT INTO `x_region` VALUES ('2556', '306', '中阳县', '3');
INSERT INTO `x_region` VALUES ('2557', '306', '交口县', '3');
INSERT INTO `x_region` VALUES ('2558', '307', '朔城区', '3');
INSERT INTO `x_region` VALUES ('2559', '307', '平鲁区', '3');
INSERT INTO `x_region` VALUES ('2560', '307', '山阴县', '3');
INSERT INTO `x_region` VALUES ('2561', '307', '应县', '3');
INSERT INTO `x_region` VALUES ('2562', '307', '右玉县', '3');
INSERT INTO `x_region` VALUES ('2563', '307', '怀仁县', '3');
INSERT INTO `x_region` VALUES ('2564', '308', '忻府区', '3');
INSERT INTO `x_region` VALUES ('2565', '308', '原平市', '3');
INSERT INTO `x_region` VALUES ('2566', '308', '定襄县', '3');
INSERT INTO `x_region` VALUES ('2567', '308', '五台县', '3');
INSERT INTO `x_region` VALUES ('2568', '308', '代县', '3');
INSERT INTO `x_region` VALUES ('2569', '308', '繁峙县', '3');
INSERT INTO `x_region` VALUES ('2570', '308', '宁武县', '3');
INSERT INTO `x_region` VALUES ('2571', '308', '静乐县', '3');
INSERT INTO `x_region` VALUES ('2572', '308', '神池县', '3');
INSERT INTO `x_region` VALUES ('2573', '308', '五寨县', '3');
INSERT INTO `x_region` VALUES ('2574', '308', '岢岚县', '3');
INSERT INTO `x_region` VALUES ('2575', '308', '河曲县', '3');
INSERT INTO `x_region` VALUES ('2576', '308', '保德县', '3');
INSERT INTO `x_region` VALUES ('2577', '308', '偏关县', '3');
INSERT INTO `x_region` VALUES ('2578', '309', '城区', '3');
INSERT INTO `x_region` VALUES ('2579', '309', '矿区', '3');
INSERT INTO `x_region` VALUES ('2580', '309', '郊区', '3');
INSERT INTO `x_region` VALUES ('2581', '309', '平定县', '3');
INSERT INTO `x_region` VALUES ('2582', '309', '盂县', '3');
INSERT INTO `x_region` VALUES ('2583', '310', '盐湖区', '3');
INSERT INTO `x_region` VALUES ('2584', '310', '永济市', '3');
INSERT INTO `x_region` VALUES ('2585', '310', '河津市', '3');
INSERT INTO `x_region` VALUES ('2586', '310', '临猗县', '3');
INSERT INTO `x_region` VALUES ('2587', '310', '万荣县', '3');
INSERT INTO `x_region` VALUES ('2588', '310', '闻喜县', '3');
INSERT INTO `x_region` VALUES ('2589', '310', '稷山县', '3');
INSERT INTO `x_region` VALUES ('2590', '310', '新绛县', '3');
INSERT INTO `x_region` VALUES ('2591', '310', '绛县', '3');
INSERT INTO `x_region` VALUES ('2592', '310', '垣曲县', '3');
INSERT INTO `x_region` VALUES ('2593', '310', '夏县', '3');
INSERT INTO `x_region` VALUES ('2594', '310', '平陆县', '3');
INSERT INTO `x_region` VALUES ('2595', '310', '芮城县', '3');
INSERT INTO `x_region` VALUES ('2596', '311', '莲湖区', '3');
INSERT INTO `x_region` VALUES ('2597', '311', '新城区', '3');
INSERT INTO `x_region` VALUES ('2598', '311', '碑林区', '3');
INSERT INTO `x_region` VALUES ('2599', '311', '雁塔区', '3');
INSERT INTO `x_region` VALUES ('2600', '311', '灞桥区', '3');
INSERT INTO `x_region` VALUES ('2601', '311', '未央区', '3');
INSERT INTO `x_region` VALUES ('2602', '311', '阎良区', '3');
INSERT INTO `x_region` VALUES ('2603', '311', '临潼区', '3');
INSERT INTO `x_region` VALUES ('2604', '311', '长安区', '3');
INSERT INTO `x_region` VALUES ('2605', '311', '蓝田县', '3');
INSERT INTO `x_region` VALUES ('2606', '311', '周至县', '3');
INSERT INTO `x_region` VALUES ('2607', '311', '户县', '3');
INSERT INTO `x_region` VALUES ('2608', '311', '高陵县', '3');
INSERT INTO `x_region` VALUES ('2609', '312', '汉滨区', '3');
INSERT INTO `x_region` VALUES ('2610', '312', '汉阴县', '3');
INSERT INTO `x_region` VALUES ('2611', '312', '石泉县', '3');
INSERT INTO `x_region` VALUES ('2612', '312', '宁陕县', '3');
INSERT INTO `x_region` VALUES ('2613', '312', '紫阳县', '3');
INSERT INTO `x_region` VALUES ('2614', '312', '岚皋县', '3');
INSERT INTO `x_region` VALUES ('2615', '312', '平利县', '3');
INSERT INTO `x_region` VALUES ('2616', '312', '镇坪县', '3');
INSERT INTO `x_region` VALUES ('2617', '312', '旬阳县', '3');
INSERT INTO `x_region` VALUES ('2618', '312', '白河县', '3');
INSERT INTO `x_region` VALUES ('2619', '313', '陈仓区', '3');
INSERT INTO `x_region` VALUES ('2620', '313', '渭滨区', '3');
INSERT INTO `x_region` VALUES ('2621', '313', '金台区', '3');
INSERT INTO `x_region` VALUES ('2622', '313', '凤翔县', '3');
INSERT INTO `x_region` VALUES ('2623', '313', '岐山县', '3');
INSERT INTO `x_region` VALUES ('2624', '313', '扶风县', '3');
INSERT INTO `x_region` VALUES ('2625', '313', '眉县', '3');
INSERT INTO `x_region` VALUES ('2626', '313', '陇县', '3');
INSERT INTO `x_region` VALUES ('2627', '313', '千阳县', '3');
INSERT INTO `x_region` VALUES ('2628', '313', '麟游县', '3');
INSERT INTO `x_region` VALUES ('2629', '313', '凤县', '3');
INSERT INTO `x_region` VALUES ('2630', '313', '太白县', '3');
INSERT INTO `x_region` VALUES ('2631', '314', '汉台区', '3');
INSERT INTO `x_region` VALUES ('2632', '314', '南郑县', '3');
INSERT INTO `x_region` VALUES ('2633', '314', '城固县', '3');
INSERT INTO `x_region` VALUES ('2634', '314', '洋县', '3');
INSERT INTO `x_region` VALUES ('2635', '314', '西乡县', '3');
INSERT INTO `x_region` VALUES ('2636', '314', '勉县', '3');
INSERT INTO `x_region` VALUES ('2637', '314', '宁强县', '3');
INSERT INTO `x_region` VALUES ('2638', '314', '略阳县', '3');
INSERT INTO `x_region` VALUES ('2639', '314', '镇巴县', '3');
INSERT INTO `x_region` VALUES ('2640', '314', '留坝县', '3');
INSERT INTO `x_region` VALUES ('2641', '314', '佛坪县', '3');
INSERT INTO `x_region` VALUES ('2642', '315', '商州区', '3');
INSERT INTO `x_region` VALUES ('2643', '315', '洛南县', '3');
INSERT INTO `x_region` VALUES ('2644', '315', '丹凤县', '3');
INSERT INTO `x_region` VALUES ('2645', '315', '商南县', '3');
INSERT INTO `x_region` VALUES ('2646', '315', '山阳县', '3');
INSERT INTO `x_region` VALUES ('2647', '315', '镇安县', '3');
INSERT INTO `x_region` VALUES ('2648', '315', '柞水县', '3');
INSERT INTO `x_region` VALUES ('2649', '316', '耀州区', '3');
INSERT INTO `x_region` VALUES ('2650', '316', '王益区', '3');
INSERT INTO `x_region` VALUES ('2651', '316', '印台区', '3');
INSERT INTO `x_region` VALUES ('2652', '316', '宜君县', '3');
INSERT INTO `x_region` VALUES ('2653', '317', '临渭区', '3');
INSERT INTO `x_region` VALUES ('2654', '317', '韩城市', '3');
INSERT INTO `x_region` VALUES ('2655', '317', '华阴市', '3');
INSERT INTO `x_region` VALUES ('2656', '317', '华县', '3');
INSERT INTO `x_region` VALUES ('2657', '317', '潼关县', '3');
INSERT INTO `x_region` VALUES ('2658', '317', '大荔县', '3');
INSERT INTO `x_region` VALUES ('2659', '317', '合阳县', '3');
INSERT INTO `x_region` VALUES ('2660', '317', '澄城县', '3');
INSERT INTO `x_region` VALUES ('2661', '317', '蒲城县', '3');
INSERT INTO `x_region` VALUES ('2662', '317', '白水县', '3');
INSERT INTO `x_region` VALUES ('2663', '317', '富平县', '3');
INSERT INTO `x_region` VALUES ('2664', '318', '秦都区', '3');
INSERT INTO `x_region` VALUES ('2665', '318', '渭城区', '3');
INSERT INTO `x_region` VALUES ('2666', '318', '杨陵区', '3');
INSERT INTO `x_region` VALUES ('2667', '318', '兴平市', '3');
INSERT INTO `x_region` VALUES ('2668', '318', '三原县', '3');
INSERT INTO `x_region` VALUES ('2669', '318', '泾阳县', '3');
INSERT INTO `x_region` VALUES ('2670', '318', '乾县', '3');
INSERT INTO `x_region` VALUES ('2671', '318', '礼泉县', '3');
INSERT INTO `x_region` VALUES ('2672', '318', '永寿县', '3');
INSERT INTO `x_region` VALUES ('2673', '318', '彬县', '3');
INSERT INTO `x_region` VALUES ('2674', '318', '长武县', '3');
INSERT INTO `x_region` VALUES ('2675', '318', '旬邑县', '3');
INSERT INTO `x_region` VALUES ('2676', '318', '淳化县', '3');
INSERT INTO `x_region` VALUES ('2677', '318', '武功县', '3');
INSERT INTO `x_region` VALUES ('2678', '319', '吴起县', '3');
INSERT INTO `x_region` VALUES ('2679', '319', '宝塔区', '3');
INSERT INTO `x_region` VALUES ('2680', '319', '延长县', '3');
INSERT INTO `x_region` VALUES ('2681', '319', '延川县', '3');
INSERT INTO `x_region` VALUES ('2682', '319', '子长县', '3');
INSERT INTO `x_region` VALUES ('2683', '319', '安塞县', '3');
INSERT INTO `x_region` VALUES ('2684', '319', '志丹县', '3');
INSERT INTO `x_region` VALUES ('2685', '319', '甘泉县', '3');
INSERT INTO `x_region` VALUES ('2686', '319', '富县', '3');
INSERT INTO `x_region` VALUES ('2687', '319', '洛川县', '3');
INSERT INTO `x_region` VALUES ('2688', '319', '宜川县', '3');
INSERT INTO `x_region` VALUES ('2689', '319', '黄龙县', '3');
INSERT INTO `x_region` VALUES ('2690', '319', '黄陵县', '3');
INSERT INTO `x_region` VALUES ('2691', '320', '榆阳区', '3');
INSERT INTO `x_region` VALUES ('2692', '320', '神木县', '3');
INSERT INTO `x_region` VALUES ('2693', '320', '府谷县', '3');
INSERT INTO `x_region` VALUES ('2694', '320', '横山县', '3');
INSERT INTO `x_region` VALUES ('2695', '320', '靖边县', '3');
INSERT INTO `x_region` VALUES ('2696', '320', '定边县', '3');
INSERT INTO `x_region` VALUES ('2697', '320', '绥德县', '3');
INSERT INTO `x_region` VALUES ('2698', '320', '米脂县', '3');
INSERT INTO `x_region` VALUES ('2699', '320', '佳县', '3');
INSERT INTO `x_region` VALUES ('2700', '320', '吴堡县', '3');
INSERT INTO `x_region` VALUES ('2701', '320', '清涧县', '3');
INSERT INTO `x_region` VALUES ('2702', '320', '子洲县', '3');
INSERT INTO `x_region` VALUES ('2703', '321', '长宁区', '3');
INSERT INTO `x_region` VALUES ('2704', '321', '闸北区', '3');
INSERT INTO `x_region` VALUES ('2705', '321', '闵行区', '3');
INSERT INTO `x_region` VALUES ('2706', '321', '徐汇区', '3');
INSERT INTO `x_region` VALUES ('2707', '321', '浦东新区', '3');
INSERT INTO `x_region` VALUES ('2708', '321', '杨浦区', '3');
INSERT INTO `x_region` VALUES ('2709', '321', '普陀区', '3');
INSERT INTO `x_region` VALUES ('2710', '321', '静安区', '3');
INSERT INTO `x_region` VALUES ('2711', '321', '卢湾区', '3');
INSERT INTO `x_region` VALUES ('2712', '321', '虹口区', '3');
INSERT INTO `x_region` VALUES ('2713', '321', '黄浦区', '3');
INSERT INTO `x_region` VALUES ('2714', '321', '南汇区', '3');
INSERT INTO `x_region` VALUES ('2715', '321', '松江区', '3');
INSERT INTO `x_region` VALUES ('2716', '321', '嘉定区', '3');
INSERT INTO `x_region` VALUES ('2717', '321', '宝山区', '3');
INSERT INTO `x_region` VALUES ('2718', '321', '青浦区', '3');
INSERT INTO `x_region` VALUES ('2719', '321', '金山区', '3');
INSERT INTO `x_region` VALUES ('2720', '321', '奉贤区', '3');
INSERT INTO `x_region` VALUES ('2721', '321', '崇明县', '3');
INSERT INTO `x_region` VALUES ('2722', '322', '青羊区', '3');
INSERT INTO `x_region` VALUES ('2723', '322', '锦江区', '3');
INSERT INTO `x_region` VALUES ('2724', '322', '金牛区', '3');
INSERT INTO `x_region` VALUES ('2725', '322', '武侯区', '3');
INSERT INTO `x_region` VALUES ('2726', '322', '成华区', '3');
INSERT INTO `x_region` VALUES ('2727', '322', '龙泉驿区', '3');
INSERT INTO `x_region` VALUES ('2728', '322', '青白江区', '3');
INSERT INTO `x_region` VALUES ('2729', '322', '新都区', '3');
INSERT INTO `x_region` VALUES ('2730', '322', '温江区', '3');
INSERT INTO `x_region` VALUES ('2731', '322', '高新区', '3');
INSERT INTO `x_region` VALUES ('2732', '322', '高新西区', '3');
INSERT INTO `x_region` VALUES ('2733', '322', '都江堰市', '3');
INSERT INTO `x_region` VALUES ('2734', '322', '彭州市', '3');
INSERT INTO `x_region` VALUES ('2735', '322', '邛崃市', '3');
INSERT INTO `x_region` VALUES ('2736', '322', '崇州市', '3');
INSERT INTO `x_region` VALUES ('2737', '322', '金堂县', '3');
INSERT INTO `x_region` VALUES ('2738', '322', '双流县', '3');
INSERT INTO `x_region` VALUES ('2739', '322', '郫县', '3');
INSERT INTO `x_region` VALUES ('2740', '322', '大邑县', '3');
INSERT INTO `x_region` VALUES ('2741', '322', '蒲江县', '3');
INSERT INTO `x_region` VALUES ('2742', '322', '新津县', '3');
INSERT INTO `x_region` VALUES ('2743', '322', '都江堰市', '3');
INSERT INTO `x_region` VALUES ('2744', '322', '彭州市', '3');
INSERT INTO `x_region` VALUES ('2745', '322', '邛崃市', '3');
INSERT INTO `x_region` VALUES ('2746', '322', '崇州市', '3');
INSERT INTO `x_region` VALUES ('2747', '322', '金堂县', '3');
INSERT INTO `x_region` VALUES ('2748', '322', '双流县', '3');
INSERT INTO `x_region` VALUES ('2749', '322', '郫县', '3');
INSERT INTO `x_region` VALUES ('2750', '322', '大邑县', '3');
INSERT INTO `x_region` VALUES ('2751', '322', '蒲江县', '3');
INSERT INTO `x_region` VALUES ('2752', '322', '新津县', '3');
INSERT INTO `x_region` VALUES ('2753', '323', '涪城区', '3');
INSERT INTO `x_region` VALUES ('2754', '323', '游仙区', '3');
INSERT INTO `x_region` VALUES ('2755', '323', '江油市', '3');
INSERT INTO `x_region` VALUES ('2756', '323', '盐亭县', '3');
INSERT INTO `x_region` VALUES ('2757', '323', '三台县', '3');
INSERT INTO `x_region` VALUES ('2758', '323', '平武县', '3');
INSERT INTO `x_region` VALUES ('2759', '323', '安县', '3');
INSERT INTO `x_region` VALUES ('2760', '323', '梓潼县', '3');
INSERT INTO `x_region` VALUES ('2761', '323', '北川县', '3');
INSERT INTO `x_region` VALUES ('2762', '324', '马尔康县', '3');
INSERT INTO `x_region` VALUES ('2763', '324', '汶川县', '3');
INSERT INTO `x_region` VALUES ('2764', '324', '理县', '3');
INSERT INTO `x_region` VALUES ('2765', '324', '茂县', '3');
INSERT INTO `x_region` VALUES ('2766', '324', '松潘县', '3');
INSERT INTO `x_region` VALUES ('2767', '324', '九寨沟县', '3');
INSERT INTO `x_region` VALUES ('2768', '324', '金川县', '3');
INSERT INTO `x_region` VALUES ('2769', '324', '小金县', '3');
INSERT INTO `x_region` VALUES ('2770', '324', '黑水县', '3');
INSERT INTO `x_region` VALUES ('2771', '324', '壤塘县', '3');
INSERT INTO `x_region` VALUES ('2772', '324', '阿坝县', '3');
INSERT INTO `x_region` VALUES ('2773', '324', '若尔盖县', '3');
INSERT INTO `x_region` VALUES ('2774', '324', '红原县', '3');
INSERT INTO `x_region` VALUES ('2775', '325', '巴州区', '3');
INSERT INTO `x_region` VALUES ('2776', '325', '通江县', '3');
INSERT INTO `x_region` VALUES ('2777', '325', '南江县', '3');
INSERT INTO `x_region` VALUES ('2778', '325', '平昌县', '3');
INSERT INTO `x_region` VALUES ('2779', '326', '通川区', '3');
INSERT INTO `x_region` VALUES ('2780', '326', '万源市', '3');
INSERT INTO `x_region` VALUES ('2781', '326', '达县', '3');
INSERT INTO `x_region` VALUES ('2782', '326', '宣汉县', '3');
INSERT INTO `x_region` VALUES ('2783', '326', '开江县', '3');
INSERT INTO `x_region` VALUES ('2784', '326', '大竹县', '3');
INSERT INTO `x_region` VALUES ('2785', '326', '渠县', '3');
INSERT INTO `x_region` VALUES ('2786', '327', '旌阳区', '3');
INSERT INTO `x_region` VALUES ('2787', '327', '广汉市', '3');
INSERT INTO `x_region` VALUES ('2788', '327', '什邡市', '3');
INSERT INTO `x_region` VALUES ('2789', '327', '绵竹市', '3');
INSERT INTO `x_region` VALUES ('2790', '327', '罗江县', '3');
INSERT INTO `x_region` VALUES ('2791', '327', '中江县', '3');
INSERT INTO `x_region` VALUES ('2792', '328', '康定县', '3');
INSERT INTO `x_region` VALUES ('2793', '328', '丹巴县', '3');
INSERT INTO `x_region` VALUES ('2794', '328', '泸定县', '3');
INSERT INTO `x_region` VALUES ('2795', '328', '炉霍县', '3');
INSERT INTO `x_region` VALUES ('2796', '328', '九龙县', '3');
INSERT INTO `x_region` VALUES ('2797', '328', '甘孜县', '3');
INSERT INTO `x_region` VALUES ('2798', '328', '雅江县', '3');
INSERT INTO `x_region` VALUES ('2799', '328', '新龙县', '3');
INSERT INTO `x_region` VALUES ('2800', '328', '道孚县', '3');
INSERT INTO `x_region` VALUES ('2801', '328', '白玉县', '3');
INSERT INTO `x_region` VALUES ('2802', '328', '理塘县', '3');
INSERT INTO `x_region` VALUES ('2803', '328', '德格县', '3');
INSERT INTO `x_region` VALUES ('2804', '328', '乡城县', '3');
INSERT INTO `x_region` VALUES ('2805', '328', '石渠县', '3');
INSERT INTO `x_region` VALUES ('2806', '328', '稻城县', '3');
INSERT INTO `x_region` VALUES ('2807', '328', '色达县', '3');
INSERT INTO `x_region` VALUES ('2808', '328', '巴塘县', '3');
INSERT INTO `x_region` VALUES ('2809', '328', '得荣县', '3');
INSERT INTO `x_region` VALUES ('2810', '329', '广安区', '3');
INSERT INTO `x_region` VALUES ('2811', '329', '华蓥市', '3');
INSERT INTO `x_region` VALUES ('2812', '329', '岳池县', '3');
INSERT INTO `x_region` VALUES ('2813', '329', '武胜县', '3');
INSERT INTO `x_region` VALUES ('2814', '329', '邻水县', '3');
INSERT INTO `x_region` VALUES ('2815', '330', '利州区', '3');
INSERT INTO `x_region` VALUES ('2816', '330', '元坝区', '3');
INSERT INTO `x_region` VALUES ('2817', '330', '朝天区', '3');
INSERT INTO `x_region` VALUES ('2818', '330', '旺苍县', '3');
INSERT INTO `x_region` VALUES ('2819', '330', '青川县', '3');
INSERT INTO `x_region` VALUES ('2820', '330', '剑阁县', '3');
INSERT INTO `x_region` VALUES ('2821', '330', '苍溪县', '3');
INSERT INTO `x_region` VALUES ('2822', '331', '峨眉山市', '3');
INSERT INTO `x_region` VALUES ('2823', '331', '乐山市', '3');
INSERT INTO `x_region` VALUES ('2824', '331', '犍为县', '3');
INSERT INTO `x_region` VALUES ('2825', '331', '井研县', '3');
INSERT INTO `x_region` VALUES ('2826', '331', '夹江县', '3');
INSERT INTO `x_region` VALUES ('2827', '331', '沐川县', '3');
INSERT INTO `x_region` VALUES ('2828', '331', '峨边', '3');
INSERT INTO `x_region` VALUES ('2829', '331', '马边', '3');
INSERT INTO `x_region` VALUES ('2830', '332', '西昌市', '3');
INSERT INTO `x_region` VALUES ('2831', '332', '盐源县', '3');
INSERT INTO `x_region` VALUES ('2832', '332', '德昌县', '3');
INSERT INTO `x_region` VALUES ('2833', '332', '会理县', '3');
INSERT INTO `x_region` VALUES ('2834', '332', '会东县', '3');
INSERT INTO `x_region` VALUES ('2835', '332', '宁南县', '3');
INSERT INTO `x_region` VALUES ('2836', '332', '普格县', '3');
INSERT INTO `x_region` VALUES ('2837', '332', '布拖县', '3');
INSERT INTO `x_region` VALUES ('2838', '332', '金阳县', '3');
INSERT INTO `x_region` VALUES ('2839', '332', '昭觉县', '3');
INSERT INTO `x_region` VALUES ('2840', '332', '喜德县', '3');
INSERT INTO `x_region` VALUES ('2841', '332', '冕宁县', '3');
INSERT INTO `x_region` VALUES ('2842', '332', '越西县', '3');
INSERT INTO `x_region` VALUES ('2843', '332', '甘洛县', '3');
INSERT INTO `x_region` VALUES ('2844', '332', '美姑县', '3');
INSERT INTO `x_region` VALUES ('2845', '332', '雷波县', '3');
INSERT INTO `x_region` VALUES ('2846', '332', '木里', '3');
INSERT INTO `x_region` VALUES ('2847', '333', '东坡区', '3');
INSERT INTO `x_region` VALUES ('2848', '333', '仁寿县', '3');
INSERT INTO `x_region` VALUES ('2849', '333', '彭山县', '3');
INSERT INTO `x_region` VALUES ('2850', '333', '洪雅县', '3');
INSERT INTO `x_region` VALUES ('2851', '333', '丹棱县', '3');
INSERT INTO `x_region` VALUES ('2852', '333', '青神县', '3');
INSERT INTO `x_region` VALUES ('2853', '334', '阆中市', '3');
INSERT INTO `x_region` VALUES ('2854', '334', '南部县', '3');
INSERT INTO `x_region` VALUES ('2855', '334', '营山县', '3');
INSERT INTO `x_region` VALUES ('2856', '334', '蓬安县', '3');
INSERT INTO `x_region` VALUES ('2857', '334', '仪陇县', '3');
INSERT INTO `x_region` VALUES ('2858', '334', '顺庆区', '3');
INSERT INTO `x_region` VALUES ('2859', '334', '高坪区', '3');
INSERT INTO `x_region` VALUES ('2860', '334', '嘉陵区', '3');
INSERT INTO `x_region` VALUES ('2861', '334', '西充县', '3');
INSERT INTO `x_region` VALUES ('2862', '335', '市中区', '3');
INSERT INTO `x_region` VALUES ('2863', '335', '东兴区', '3');
INSERT INTO `x_region` VALUES ('2864', '335', '威远县', '3');
INSERT INTO `x_region` VALUES ('2865', '335', '资中县', '3');
INSERT INTO `x_region` VALUES ('2866', '335', '隆昌县', '3');
INSERT INTO `x_region` VALUES ('2867', '336', '东  区', '3');
INSERT INTO `x_region` VALUES ('2868', '336', '西  区', '3');
INSERT INTO `x_region` VALUES ('2869', '336', '仁和区', '3');
INSERT INTO `x_region` VALUES ('2870', '336', '米易县', '3');
INSERT INTO `x_region` VALUES ('2871', '336', '盐边县', '3');
INSERT INTO `x_region` VALUES ('2872', '337', '船山区', '3');
INSERT INTO `x_region` VALUES ('2873', '337', '安居区', '3');
INSERT INTO `x_region` VALUES ('2874', '337', '蓬溪县', '3');
INSERT INTO `x_region` VALUES ('2875', '337', '射洪县', '3');
INSERT INTO `x_region` VALUES ('2876', '337', '大英县', '3');
INSERT INTO `x_region` VALUES ('2877', '338', '雨城区', '3');
INSERT INTO `x_region` VALUES ('2878', '338', '名山县', '3');
INSERT INTO `x_region` VALUES ('2879', '338', '荥经县', '3');
INSERT INTO `x_region` VALUES ('2880', '338', '汉源县', '3');
INSERT INTO `x_region` VALUES ('2881', '338', '石棉县', '3');
INSERT INTO `x_region` VALUES ('2882', '338', '天全县', '3');
INSERT INTO `x_region` VALUES ('2883', '338', '芦山县', '3');
INSERT INTO `x_region` VALUES ('2884', '338', '宝兴县', '3');
INSERT INTO `x_region` VALUES ('2885', '339', '翠屏区', '3');
INSERT INTO `x_region` VALUES ('2886', '339', '宜宾县', '3');
INSERT INTO `x_region` VALUES ('2887', '339', '南溪县', '3');
INSERT INTO `x_region` VALUES ('2888', '339', '江安县', '3');
INSERT INTO `x_region` VALUES ('2889', '339', '长宁县', '3');
INSERT INTO `x_region` VALUES ('2890', '339', '高县', '3');
INSERT INTO `x_region` VALUES ('2891', '339', '珙县', '3');
INSERT INTO `x_region` VALUES ('2892', '339', '筠连县', '3');
INSERT INTO `x_region` VALUES ('2893', '339', '兴文县', '3');
INSERT INTO `x_region` VALUES ('2894', '339', '屏山县', '3');
INSERT INTO `x_region` VALUES ('2895', '340', '雁江区', '3');
INSERT INTO `x_region` VALUES ('2896', '340', '简阳市', '3');
INSERT INTO `x_region` VALUES ('2897', '340', '安岳县', '3');
INSERT INTO `x_region` VALUES ('2898', '340', '乐至县', '3');
INSERT INTO `x_region` VALUES ('2899', '341', '大安区', '3');
INSERT INTO `x_region` VALUES ('2900', '341', '自流井区', '3');
INSERT INTO `x_region` VALUES ('2901', '341', '贡井区', '3');
INSERT INTO `x_region` VALUES ('2902', '341', '沿滩区', '3');
INSERT INTO `x_region` VALUES ('2903', '341', '荣县', '3');
INSERT INTO `x_region` VALUES ('2904', '341', '富顺县', '3');
INSERT INTO `x_region` VALUES ('2905', '342', '江阳区', '3');
INSERT INTO `x_region` VALUES ('2906', '342', '纳溪区', '3');
INSERT INTO `x_region` VALUES ('2907', '342', '龙马潭区', '3');
INSERT INTO `x_region` VALUES ('2908', '342', '泸县', '3');
INSERT INTO `x_region` VALUES ('2909', '342', '合江县', '3');
INSERT INTO `x_region` VALUES ('2910', '342', '叙永县', '3');
INSERT INTO `x_region` VALUES ('2911', '342', '古蔺县', '3');
INSERT INTO `x_region` VALUES ('2912', '343', '和平区', '3');
INSERT INTO `x_region` VALUES ('2913', '343', '河西区', '3');
INSERT INTO `x_region` VALUES ('2914', '343', '南开区', '3');
INSERT INTO `x_region` VALUES ('2915', '343', '河北区', '3');
INSERT INTO `x_region` VALUES ('2916', '343', '河东区', '3');
INSERT INTO `x_region` VALUES ('2917', '343', '红桥区', '3');
INSERT INTO `x_region` VALUES ('2918', '343', '东丽区', '3');
INSERT INTO `x_region` VALUES ('2919', '343', '津南区', '3');
INSERT INTO `x_region` VALUES ('2920', '343', '西青区', '3');
INSERT INTO `x_region` VALUES ('2921', '343', '北辰区', '3');
INSERT INTO `x_region` VALUES ('2922', '343', '塘沽区', '3');
INSERT INTO `x_region` VALUES ('2923', '343', '汉沽区', '3');
INSERT INTO `x_region` VALUES ('2924', '343', '大港区', '3');
INSERT INTO `x_region` VALUES ('2925', '343', '武清区', '3');
INSERT INTO `x_region` VALUES ('2926', '343', '宝坻区', '3');
INSERT INTO `x_region` VALUES ('2927', '343', '经济开发区', '3');
INSERT INTO `x_region` VALUES ('2928', '343', '宁河县', '3');
INSERT INTO `x_region` VALUES ('2929', '343', '静海县', '3');
INSERT INTO `x_region` VALUES ('2930', '343', '蓟县', '3');
INSERT INTO `x_region` VALUES ('2931', '344', '城关区', '3');
INSERT INTO `x_region` VALUES ('2932', '344', '林周县', '3');
INSERT INTO `x_region` VALUES ('2933', '344', '当雄县', '3');
INSERT INTO `x_region` VALUES ('2934', '344', '尼木县', '3');
INSERT INTO `x_region` VALUES ('2935', '344', '曲水县', '3');
INSERT INTO `x_region` VALUES ('2936', '344', '堆龙德庆县', '3');
INSERT INTO `x_region` VALUES ('2937', '344', '达孜县', '3');
INSERT INTO `x_region` VALUES ('2938', '344', '墨竹工卡县', '3');
INSERT INTO `x_region` VALUES ('2939', '345', '噶尔县', '3');
INSERT INTO `x_region` VALUES ('2940', '345', '普兰县', '3');
INSERT INTO `x_region` VALUES ('2941', '345', '札达县', '3');
INSERT INTO `x_region` VALUES ('2942', '345', '日土县', '3');
INSERT INTO `x_region` VALUES ('2943', '345', '革吉县', '3');
INSERT INTO `x_region` VALUES ('2944', '345', '改则县', '3');
INSERT INTO `x_region` VALUES ('2945', '345', '措勤县', '3');
INSERT INTO `x_region` VALUES ('2946', '346', '昌都县', '3');
INSERT INTO `x_region` VALUES ('2947', '346', '江达县', '3');
INSERT INTO `x_region` VALUES ('2948', '346', '贡觉县', '3');
INSERT INTO `x_region` VALUES ('2949', '346', '类乌齐县', '3');
INSERT INTO `x_region` VALUES ('2950', '346', '丁青县', '3');
INSERT INTO `x_region` VALUES ('2951', '346', '察雅县', '3');
INSERT INTO `x_region` VALUES ('2952', '346', '八宿县', '3');
INSERT INTO `x_region` VALUES ('2953', '346', '左贡县', '3');
INSERT INTO `x_region` VALUES ('2954', '346', '芒康县', '3');
INSERT INTO `x_region` VALUES ('2955', '346', '洛隆县', '3');
INSERT INTO `x_region` VALUES ('2956', '346', '边坝县', '3');
INSERT INTO `x_region` VALUES ('2957', '347', '林芝县', '3');
INSERT INTO `x_region` VALUES ('2958', '347', '工布江达县', '3');
INSERT INTO `x_region` VALUES ('2959', '347', '米林县', '3');
INSERT INTO `x_region` VALUES ('2960', '347', '墨脱县', '3');
INSERT INTO `x_region` VALUES ('2961', '347', '波密县', '3');
INSERT INTO `x_region` VALUES ('2962', '347', '察隅县', '3');
INSERT INTO `x_region` VALUES ('2963', '347', '朗县', '3');
INSERT INTO `x_region` VALUES ('2964', '348', '那曲县', '3');
INSERT INTO `x_region` VALUES ('2965', '348', '嘉黎县', '3');
INSERT INTO `x_region` VALUES ('2966', '348', '比如县', '3');
INSERT INTO `x_region` VALUES ('2967', '348', '聂荣县', '3');
INSERT INTO `x_region` VALUES ('2968', '348', '安多县', '3');
INSERT INTO `x_region` VALUES ('2969', '348', '申扎县', '3');
INSERT INTO `x_region` VALUES ('2970', '348', '索县', '3');
INSERT INTO `x_region` VALUES ('2971', '348', '班戈县', '3');
INSERT INTO `x_region` VALUES ('2972', '348', '巴青县', '3');
INSERT INTO `x_region` VALUES ('2973', '348', '尼玛县', '3');
INSERT INTO `x_region` VALUES ('2974', '349', '日喀则市', '3');
INSERT INTO `x_region` VALUES ('2975', '349', '南木林县', '3');
INSERT INTO `x_region` VALUES ('2976', '349', '江孜县', '3');
INSERT INTO `x_region` VALUES ('2977', '349', '定日县', '3');
INSERT INTO `x_region` VALUES ('2978', '349', '萨迦县', '3');
INSERT INTO `x_region` VALUES ('2979', '349', '拉孜县', '3');
INSERT INTO `x_region` VALUES ('2980', '349', '昂仁县', '3');
INSERT INTO `x_region` VALUES ('2981', '349', '谢通门县', '3');
INSERT INTO `x_region` VALUES ('2982', '349', '白朗县', '3');
INSERT INTO `x_region` VALUES ('2983', '349', '仁布县', '3');
INSERT INTO `x_region` VALUES ('2984', '349', '康马县', '3');
INSERT INTO `x_region` VALUES ('2985', '349', '定结县', '3');
INSERT INTO `x_region` VALUES ('2986', '349', '仲巴县', '3');
INSERT INTO `x_region` VALUES ('2987', '349', '亚东县', '3');
INSERT INTO `x_region` VALUES ('2988', '349', '吉隆县', '3');
INSERT INTO `x_region` VALUES ('2989', '349', '聂拉木县', '3');
INSERT INTO `x_region` VALUES ('2990', '349', '萨嘎县', '3');
INSERT INTO `x_region` VALUES ('2991', '349', '岗巴县', '3');
INSERT INTO `x_region` VALUES ('2992', '350', '乃东县', '3');
INSERT INTO `x_region` VALUES ('2993', '350', '扎囊县', '3');
INSERT INTO `x_region` VALUES ('2994', '350', '贡嘎县', '3');
INSERT INTO `x_region` VALUES ('2995', '350', '桑日县', '3');
INSERT INTO `x_region` VALUES ('2996', '350', '琼结县', '3');
INSERT INTO `x_region` VALUES ('2997', '350', '曲松县', '3');
INSERT INTO `x_region` VALUES ('2998', '350', '措美县', '3');
INSERT INTO `x_region` VALUES ('2999', '350', '洛扎县', '3');
INSERT INTO `x_region` VALUES ('3000', '350', '加查县', '3');
INSERT INTO `x_region` VALUES ('3001', '350', '隆子县', '3');
INSERT INTO `x_region` VALUES ('3002', '350', '错那县', '3');
INSERT INTO `x_region` VALUES ('3003', '350', '浪卡子县', '3');
INSERT INTO `x_region` VALUES ('3004', '351', '天山区', '3');
INSERT INTO `x_region` VALUES ('3005', '351', '沙依巴克区', '3');
INSERT INTO `x_region` VALUES ('3006', '351', '新市区', '3');
INSERT INTO `x_region` VALUES ('3007', '351', '水磨沟区', '3');
INSERT INTO `x_region` VALUES ('3008', '351', '头屯河区', '3');
INSERT INTO `x_region` VALUES ('3009', '351', '达坂城区', '3');
INSERT INTO `x_region` VALUES ('3010', '351', '米东区', '3');
INSERT INTO `x_region` VALUES ('3011', '351', '乌鲁木齐县', '3');
INSERT INTO `x_region` VALUES ('3012', '352', '阿克苏市', '3');
INSERT INTO `x_region` VALUES ('3013', '352', '温宿县', '3');
INSERT INTO `x_region` VALUES ('3014', '352', '库车县', '3');
INSERT INTO `x_region` VALUES ('3015', '352', '沙雅县', '3');
INSERT INTO `x_region` VALUES ('3016', '352', '新和县', '3');
INSERT INTO `x_region` VALUES ('3017', '352', '拜城县', '3');
INSERT INTO `x_region` VALUES ('3018', '352', '乌什县', '3');
INSERT INTO `x_region` VALUES ('3019', '352', '阿瓦提县', '3');
INSERT INTO `x_region` VALUES ('3020', '352', '柯坪县', '3');
INSERT INTO `x_region` VALUES ('3021', '353', '阿拉尔市', '3');
INSERT INTO `x_region` VALUES ('3022', '354', '库尔勒市', '3');
INSERT INTO `x_region` VALUES ('3023', '354', '轮台县', '3');
INSERT INTO `x_region` VALUES ('3024', '354', '尉犁县', '3');
INSERT INTO `x_region` VALUES ('3025', '354', '若羌县', '3');
INSERT INTO `x_region` VALUES ('3026', '354', '且末县', '3');
INSERT INTO `x_region` VALUES ('3027', '354', '焉耆', '3');
INSERT INTO `x_region` VALUES ('3028', '354', '和静县', '3');
INSERT INTO `x_region` VALUES ('3029', '354', '和硕县', '3');
INSERT INTO `x_region` VALUES ('3030', '354', '博湖县', '3');
INSERT INTO `x_region` VALUES ('3031', '355', '博乐市', '3');
INSERT INTO `x_region` VALUES ('3032', '355', '精河县', '3');
INSERT INTO `x_region` VALUES ('3033', '355', '温泉县', '3');
INSERT INTO `x_region` VALUES ('3034', '356', '呼图壁县', '3');
INSERT INTO `x_region` VALUES ('3035', '356', '米泉市', '3');
INSERT INTO `x_region` VALUES ('3036', '356', '昌吉市', '3');
INSERT INTO `x_region` VALUES ('3037', '356', '阜康市', '3');
INSERT INTO `x_region` VALUES ('3038', '356', '玛纳斯县', '3');
INSERT INTO `x_region` VALUES ('3039', '356', '奇台县', '3');
INSERT INTO `x_region` VALUES ('3040', '356', '吉木萨尔县', '3');
INSERT INTO `x_region` VALUES ('3041', '356', '木垒', '3');
INSERT INTO `x_region` VALUES ('3042', '357', '哈密市', '3');
INSERT INTO `x_region` VALUES ('3043', '357', '伊吾县', '3');
INSERT INTO `x_region` VALUES ('3044', '357', '巴里坤', '3');
INSERT INTO `x_region` VALUES ('3045', '358', '和田市', '3');
INSERT INTO `x_region` VALUES ('3046', '358', '和田县', '3');
INSERT INTO `x_region` VALUES ('3047', '358', '墨玉县', '3');
INSERT INTO `x_region` VALUES ('3048', '358', '皮山县', '3');
INSERT INTO `x_region` VALUES ('3049', '358', '洛浦县', '3');
INSERT INTO `x_region` VALUES ('3050', '358', '策勒县', '3');
INSERT INTO `x_region` VALUES ('3051', '358', '于田县', '3');
INSERT INTO `x_region` VALUES ('3052', '358', '民丰县', '3');
INSERT INTO `x_region` VALUES ('3053', '359', '喀什市', '3');
INSERT INTO `x_region` VALUES ('3054', '359', '疏附县', '3');
INSERT INTO `x_region` VALUES ('3055', '359', '疏勒县', '3');
INSERT INTO `x_region` VALUES ('3056', '359', '英吉沙县', '3');
INSERT INTO `x_region` VALUES ('3057', '359', '泽普县', '3');
INSERT INTO `x_region` VALUES ('3058', '359', '莎车县', '3');
INSERT INTO `x_region` VALUES ('3059', '359', '叶城县', '3');
INSERT INTO `x_region` VALUES ('3060', '359', '麦盖提县', '3');
INSERT INTO `x_region` VALUES ('3061', '359', '岳普湖县', '3');
INSERT INTO `x_region` VALUES ('3062', '359', '伽师县', '3');
INSERT INTO `x_region` VALUES ('3063', '359', '巴楚县', '3');
INSERT INTO `x_region` VALUES ('3064', '359', '塔什库尔干', '3');
INSERT INTO `x_region` VALUES ('3065', '360', '克拉玛依市', '3');
INSERT INTO `x_region` VALUES ('3066', '361', '阿图什市', '3');
INSERT INTO `x_region` VALUES ('3067', '361', '阿克陶县', '3');
INSERT INTO `x_region` VALUES ('3068', '361', '阿合奇县', '3');
INSERT INTO `x_region` VALUES ('3069', '361', '乌恰县', '3');
INSERT INTO `x_region` VALUES ('3070', '362', '石河子市', '3');
INSERT INTO `x_region` VALUES ('3071', '363', '图木舒克市', '3');
INSERT INTO `x_region` VALUES ('3072', '364', '吐鲁番市', '3');
INSERT INTO `x_region` VALUES ('3073', '364', '鄯善县', '3');
INSERT INTO `x_region` VALUES ('3074', '364', '托克逊县', '3');
INSERT INTO `x_region` VALUES ('3075', '365', '五家渠市', '3');
INSERT INTO `x_region` VALUES ('3076', '366', '阿勒泰市', '3');
INSERT INTO `x_region` VALUES ('3077', '366', '布克赛尔', '3');
INSERT INTO `x_region` VALUES ('3078', '366', '伊宁市', '3');
INSERT INTO `x_region` VALUES ('3079', '366', '布尔津县', '3');
INSERT INTO `x_region` VALUES ('3080', '366', '奎屯市', '3');
INSERT INTO `x_region` VALUES ('3081', '366', '乌苏市', '3');
INSERT INTO `x_region` VALUES ('3082', '366', '额敏县', '3');
INSERT INTO `x_region` VALUES ('3083', '366', '富蕴县', '3');
INSERT INTO `x_region` VALUES ('3084', '366', '伊宁县', '3');
INSERT INTO `x_region` VALUES ('3085', '366', '福海县', '3');
INSERT INTO `x_region` VALUES ('3086', '366', '霍城县', '3');
INSERT INTO `x_region` VALUES ('3087', '366', '沙湾县', '3');
INSERT INTO `x_region` VALUES ('3088', '366', '巩留县', '3');
INSERT INTO `x_region` VALUES ('3089', '366', '哈巴河县', '3');
INSERT INTO `x_region` VALUES ('3090', '366', '托里县', '3');
INSERT INTO `x_region` VALUES ('3091', '366', '青河县', '3');
INSERT INTO `x_region` VALUES ('3092', '366', '新源县', '3');
INSERT INTO `x_region` VALUES ('3093', '366', '裕民县', '3');
INSERT INTO `x_region` VALUES ('3094', '366', '和布克赛尔', '3');
INSERT INTO `x_region` VALUES ('3095', '366', '吉木乃县', '3');
INSERT INTO `x_region` VALUES ('3096', '366', '昭苏县', '3');
INSERT INTO `x_region` VALUES ('3097', '366', '特克斯县', '3');
INSERT INTO `x_region` VALUES ('3098', '366', '尼勒克县', '3');
INSERT INTO `x_region` VALUES ('3099', '366', '察布查尔', '3');
INSERT INTO `x_region` VALUES ('3100', '367', '盘龙区', '3');
INSERT INTO `x_region` VALUES ('3101', '367', '五华区', '3');
INSERT INTO `x_region` VALUES ('3102', '367', '官渡区', '3');
INSERT INTO `x_region` VALUES ('3103', '367', '西山区', '3');
INSERT INTO `x_region` VALUES ('3104', '367', '东川区', '3');
INSERT INTO `x_region` VALUES ('3105', '367', '安宁市', '3');
INSERT INTO `x_region` VALUES ('3106', '367', '呈贡县', '3');
INSERT INTO `x_region` VALUES ('3107', '367', '晋宁县', '3');
INSERT INTO `x_region` VALUES ('3108', '367', '富民县', '3');
INSERT INTO `x_region` VALUES ('3109', '367', '宜良县', '3');
INSERT INTO `x_region` VALUES ('3110', '367', '嵩明县', '3');
INSERT INTO `x_region` VALUES ('3111', '367', '石林县', '3');
INSERT INTO `x_region` VALUES ('3112', '367', '禄劝', '3');
INSERT INTO `x_region` VALUES ('3113', '367', '寻甸', '3');
INSERT INTO `x_region` VALUES ('3114', '368', '兰坪', '3');
INSERT INTO `x_region` VALUES ('3115', '368', '泸水县', '3');
INSERT INTO `x_region` VALUES ('3116', '368', '福贡县', '3');
INSERT INTO `x_region` VALUES ('3117', '368', '贡山', '3');
INSERT INTO `x_region` VALUES ('3118', '369', '宁洱', '3');
INSERT INTO `x_region` VALUES ('3119', '369', '思茅区', '3');
INSERT INTO `x_region` VALUES ('3120', '369', '墨江', '3');
INSERT INTO `x_region` VALUES ('3121', '369', '景东', '3');
INSERT INTO `x_region` VALUES ('3122', '369', '景谷', '3');
INSERT INTO `x_region` VALUES ('3123', '369', '镇沅', '3');
INSERT INTO `x_region` VALUES ('3124', '369', '江城', '3');
INSERT INTO `x_region` VALUES ('3125', '369', '孟连', '3');
INSERT INTO `x_region` VALUES ('3126', '369', '澜沧', '3');
INSERT INTO `x_region` VALUES ('3127', '369', '西盟', '3');
INSERT INTO `x_region` VALUES ('3128', '370', '古城区', '3');
INSERT INTO `x_region` VALUES ('3129', '370', '宁蒗', '3');
INSERT INTO `x_region` VALUES ('3130', '370', '玉龙', '3');
INSERT INTO `x_region` VALUES ('3131', '370', '永胜县', '3');
INSERT INTO `x_region` VALUES ('3132', '370', '华坪县', '3');
INSERT INTO `x_region` VALUES ('3133', '371', '隆阳区', '3');
INSERT INTO `x_region` VALUES ('3134', '371', '施甸县', '3');
INSERT INTO `x_region` VALUES ('3135', '371', '腾冲县', '3');
INSERT INTO `x_region` VALUES ('3136', '371', '龙陵县', '3');
INSERT INTO `x_region` VALUES ('3137', '371', '昌宁县', '3');
INSERT INTO `x_region` VALUES ('3138', '372', '楚雄市', '3');
INSERT INTO `x_region` VALUES ('3139', '372', '双柏县', '3');
INSERT INTO `x_region` VALUES ('3140', '372', '牟定县', '3');
INSERT INTO `x_region` VALUES ('3141', '372', '南华县', '3');
INSERT INTO `x_region` VALUES ('3142', '372', '姚安县', '3');
INSERT INTO `x_region` VALUES ('3143', '372', '大姚县', '3');
INSERT INTO `x_region` VALUES ('3144', '372', '永仁县', '3');
INSERT INTO `x_region` VALUES ('3145', '372', '元谋县', '3');
INSERT INTO `x_region` VALUES ('3146', '372', '武定县', '3');
INSERT INTO `x_region` VALUES ('3147', '372', '禄丰县', '3');
INSERT INTO `x_region` VALUES ('3148', '373', '大理市', '3');
INSERT INTO `x_region` VALUES ('3149', '373', '祥云县', '3');
INSERT INTO `x_region` VALUES ('3150', '373', '宾川县', '3');
INSERT INTO `x_region` VALUES ('3151', '373', '弥渡县', '3');
INSERT INTO `x_region` VALUES ('3152', '373', '永平县', '3');
INSERT INTO `x_region` VALUES ('3153', '373', '云龙县', '3');
INSERT INTO `x_region` VALUES ('3154', '373', '洱源县', '3');
INSERT INTO `x_region` VALUES ('3155', '373', '剑川县', '3');
INSERT INTO `x_region` VALUES ('3156', '373', '鹤庆县', '3');
INSERT INTO `x_region` VALUES ('3157', '373', '漾濞', '3');
INSERT INTO `x_region` VALUES ('3158', '373', '南涧', '3');
INSERT INTO `x_region` VALUES ('3159', '373', '巍山', '3');
INSERT INTO `x_region` VALUES ('3160', '374', '潞西市', '3');
INSERT INTO `x_region` VALUES ('3161', '374', '瑞丽市', '3');
INSERT INTO `x_region` VALUES ('3162', '374', '梁河县', '3');
INSERT INTO `x_region` VALUES ('3163', '374', '盈江县', '3');
INSERT INTO `x_region` VALUES ('3164', '374', '陇川县', '3');
INSERT INTO `x_region` VALUES ('3165', '375', '香格里拉县', '3');
INSERT INTO `x_region` VALUES ('3166', '375', '德钦县', '3');
INSERT INTO `x_region` VALUES ('3167', '375', '维西', '3');
INSERT INTO `x_region` VALUES ('3168', '376', '泸西县', '3');
INSERT INTO `x_region` VALUES ('3169', '376', '蒙自县', '3');
INSERT INTO `x_region` VALUES ('3170', '376', '个旧市', '3');
INSERT INTO `x_region` VALUES ('3171', '376', '开远市', '3');
INSERT INTO `x_region` VALUES ('3172', '376', '绿春县', '3');
INSERT INTO `x_region` VALUES ('3173', '376', '建水县', '3');
INSERT INTO `x_region` VALUES ('3174', '376', '石屏县', '3');
INSERT INTO `x_region` VALUES ('3175', '376', '弥勒县', '3');
INSERT INTO `x_region` VALUES ('3176', '376', '元阳县', '3');
INSERT INTO `x_region` VALUES ('3177', '376', '红河县', '3');
INSERT INTO `x_region` VALUES ('3178', '376', '金平', '3');
INSERT INTO `x_region` VALUES ('3179', '376', '河口', '3');
INSERT INTO `x_region` VALUES ('3180', '376', '屏边', '3');
INSERT INTO `x_region` VALUES ('3181', '377', '临翔区', '3');
INSERT INTO `x_region` VALUES ('3182', '377', '凤庆县', '3');
INSERT INTO `x_region` VALUES ('3183', '377', '云县', '3');
INSERT INTO `x_region` VALUES ('3184', '377', '永德县', '3');
INSERT INTO `x_region` VALUES ('3185', '377', '镇康县', '3');
INSERT INTO `x_region` VALUES ('3186', '377', '双江', '3');
INSERT INTO `x_region` VALUES ('3187', '377', '耿马', '3');
INSERT INTO `x_region` VALUES ('3188', '377', '沧源', '3');
INSERT INTO `x_region` VALUES ('3189', '378', '麒麟区', '3');
INSERT INTO `x_region` VALUES ('3190', '378', '宣威市', '3');
INSERT INTO `x_region` VALUES ('3191', '378', '马龙县', '3');
INSERT INTO `x_region` VALUES ('3192', '378', '陆良县', '3');
INSERT INTO `x_region` VALUES ('3193', '378', '师宗县', '3');
INSERT INTO `x_region` VALUES ('3194', '378', '罗平县', '3');
INSERT INTO `x_region` VALUES ('3195', '378', '富源县', '3');
INSERT INTO `x_region` VALUES ('3196', '378', '会泽县', '3');
INSERT INTO `x_region` VALUES ('3197', '378', '沾益县', '3');
INSERT INTO `x_region` VALUES ('3198', '379', '文山县', '3');
INSERT INTO `x_region` VALUES ('3199', '379', '砚山县', '3');
INSERT INTO `x_region` VALUES ('3200', '379', '西畴县', '3');
INSERT INTO `x_region` VALUES ('3201', '379', '麻栗坡县', '3');
INSERT INTO `x_region` VALUES ('3202', '379', '马关县', '3');
INSERT INTO `x_region` VALUES ('3203', '379', '丘北县', '3');
INSERT INTO `x_region` VALUES ('3204', '379', '广南县', '3');
INSERT INTO `x_region` VALUES ('3205', '379', '富宁县', '3');
INSERT INTO `x_region` VALUES ('3206', '380', '景洪市', '3');
INSERT INTO `x_region` VALUES ('3207', '380', '勐海县', '3');
INSERT INTO `x_region` VALUES ('3208', '380', '勐腊县', '3');
INSERT INTO `x_region` VALUES ('3209', '381', '红塔区', '3');
INSERT INTO `x_region` VALUES ('3210', '381', '江川县', '3');
INSERT INTO `x_region` VALUES ('3211', '381', '澄江县', '3');
INSERT INTO `x_region` VALUES ('3212', '381', '通海县', '3');
INSERT INTO `x_region` VALUES ('3213', '381', '华宁县', '3');
INSERT INTO `x_region` VALUES ('3214', '381', '易门县', '3');
INSERT INTO `x_region` VALUES ('3215', '381', '峨山', '3');
INSERT INTO `x_region` VALUES ('3216', '381', '新平', '3');
INSERT INTO `x_region` VALUES ('3217', '381', '元江', '3');
INSERT INTO `x_region` VALUES ('3218', '382', '昭阳区', '3');
INSERT INTO `x_region` VALUES ('3219', '382', '鲁甸县', '3');
INSERT INTO `x_region` VALUES ('3220', '382', '巧家县', '3');
INSERT INTO `x_region` VALUES ('3221', '382', '盐津县', '3');
INSERT INTO `x_region` VALUES ('3222', '382', '大关县', '3');
INSERT INTO `x_region` VALUES ('3223', '382', '永善县', '3');
INSERT INTO `x_region` VALUES ('3224', '382', '绥江县', '3');
INSERT INTO `x_region` VALUES ('3225', '382', '镇雄县', '3');
INSERT INTO `x_region` VALUES ('3226', '382', '彝良县', '3');
INSERT INTO `x_region` VALUES ('3227', '382', '威信县', '3');
INSERT INTO `x_region` VALUES ('3228', '382', '水富县', '3');
INSERT INTO `x_region` VALUES ('3229', '383', '西湖区', '3');
INSERT INTO `x_region` VALUES ('3230', '383', '上城区', '3');
INSERT INTO `x_region` VALUES ('3231', '383', '下城区', '3');
INSERT INTO `x_region` VALUES ('3232', '383', '拱墅区', '3');
INSERT INTO `x_region` VALUES ('3233', '383', '滨江区', '3');
INSERT INTO `x_region` VALUES ('3234', '383', '江干区', '3');
INSERT INTO `x_region` VALUES ('3235', '383', '萧山区', '3');
INSERT INTO `x_region` VALUES ('3236', '383', '余杭区', '3');
INSERT INTO `x_region` VALUES ('3237', '383', '市郊', '3');
INSERT INTO `x_region` VALUES ('3238', '383', '建德市', '3');
INSERT INTO `x_region` VALUES ('3239', '383', '富阳市', '3');
INSERT INTO `x_region` VALUES ('3240', '383', '临安市', '3');
INSERT INTO `x_region` VALUES ('3241', '383', '桐庐县', '3');
INSERT INTO `x_region` VALUES ('3242', '383', '淳安县', '3');
INSERT INTO `x_region` VALUES ('3243', '384', '吴兴区', '3');
INSERT INTO `x_region` VALUES ('3244', '384', '南浔区', '3');
INSERT INTO `x_region` VALUES ('3245', '384', '德清县', '3');
INSERT INTO `x_region` VALUES ('3246', '384', '长兴县', '3');
INSERT INTO `x_region` VALUES ('3247', '384', '安吉县', '3');
INSERT INTO `x_region` VALUES ('3248', '385', '南湖区', '3');
INSERT INTO `x_region` VALUES ('3249', '385', '秀洲区', '3');
INSERT INTO `x_region` VALUES ('3250', '385', '海宁市', '3');
INSERT INTO `x_region` VALUES ('3251', '385', '嘉善县', '3');
INSERT INTO `x_region` VALUES ('3252', '385', '平湖市', '3');
INSERT INTO `x_region` VALUES ('3253', '385', '桐乡市', '3');
INSERT INTO `x_region` VALUES ('3254', '385', '海盐县', '3');
INSERT INTO `x_region` VALUES ('3255', '386', '婺城区', '3');
INSERT INTO `x_region` VALUES ('3256', '386', '金东区', '3');
INSERT INTO `x_region` VALUES ('3257', '386', '兰溪市', '3');
INSERT INTO `x_region` VALUES ('3258', '386', '市区', '3');
INSERT INTO `x_region` VALUES ('3259', '386', '佛堂镇', '3');
INSERT INTO `x_region` VALUES ('3260', '386', '上溪镇', '3');
INSERT INTO `x_region` VALUES ('3261', '386', '义亭镇', '3');
INSERT INTO `x_region` VALUES ('3262', '386', '大陈镇', '3');
INSERT INTO `x_region` VALUES ('3263', '386', '苏溪镇', '3');
INSERT INTO `x_region` VALUES ('3264', '386', '赤岸镇', '3');
INSERT INTO `x_region` VALUES ('3265', '386', '东阳市', '3');
INSERT INTO `x_region` VALUES ('3266', '386', '永康市', '3');
INSERT INTO `x_region` VALUES ('3267', '386', '武义县', '3');
INSERT INTO `x_region` VALUES ('3268', '386', '浦江县', '3');
INSERT INTO `x_region` VALUES ('3269', '386', '磐安县', '3');
INSERT INTO `x_region` VALUES ('3270', '387', '莲都区', '3');
INSERT INTO `x_region` VALUES ('3271', '387', '龙泉市', '3');
INSERT INTO `x_region` VALUES ('3272', '387', '青田县', '3');
INSERT INTO `x_region` VALUES ('3273', '387', '缙云县', '3');
INSERT INTO `x_region` VALUES ('3274', '387', '遂昌县', '3');
INSERT INTO `x_region` VALUES ('3275', '387', '松阳县', '3');
INSERT INTO `x_region` VALUES ('3276', '387', '云和县', '3');
INSERT INTO `x_region` VALUES ('3277', '387', '庆元县', '3');
INSERT INTO `x_region` VALUES ('3278', '387', '景宁', '3');
INSERT INTO `x_region` VALUES ('3279', '388', '海曙区', '3');
INSERT INTO `x_region` VALUES ('3280', '388', '江东区', '3');
INSERT INTO `x_region` VALUES ('3281', '388', '江北区', '3');
INSERT INTO `x_region` VALUES ('3282', '388', '镇海区', '3');
INSERT INTO `x_region` VALUES ('3283', '388', '北仑区', '3');
INSERT INTO `x_region` VALUES ('3284', '388', '鄞州区', '3');
INSERT INTO `x_region` VALUES ('3285', '388', '余姚市', '3');
INSERT INTO `x_region` VALUES ('3286', '388', '慈溪市', '3');
INSERT INTO `x_region` VALUES ('3287', '388', '奉化市', '3');
INSERT INTO `x_region` VALUES ('3288', '388', '象山县', '3');
INSERT INTO `x_region` VALUES ('3289', '388', '宁海县', '3');
INSERT INTO `x_region` VALUES ('3290', '389', '越城区', '3');
INSERT INTO `x_region` VALUES ('3291', '389', '上虞市', '3');
INSERT INTO `x_region` VALUES ('3292', '389', '嵊州市', '3');
INSERT INTO `x_region` VALUES ('3293', '389', '绍兴县', '3');
INSERT INTO `x_region` VALUES ('3294', '389', '新昌县', '3');
INSERT INTO `x_region` VALUES ('3295', '389', '诸暨市', '3');
INSERT INTO `x_region` VALUES ('3296', '390', '椒江区', '3');
INSERT INTO `x_region` VALUES ('3297', '390', '黄岩区', '3');
INSERT INTO `x_region` VALUES ('3298', '390', '路桥区', '3');
INSERT INTO `x_region` VALUES ('3299', '390', '温岭市', '3');
INSERT INTO `x_region` VALUES ('3300', '390', '临海市', '3');
INSERT INTO `x_region` VALUES ('3301', '390', '玉环县', '3');
INSERT INTO `x_region` VALUES ('3302', '390', '三门县', '3');
INSERT INTO `x_region` VALUES ('3303', '390', '天台县', '3');
INSERT INTO `x_region` VALUES ('3304', '390', '仙居县', '3');
INSERT INTO `x_region` VALUES ('3305', '391', '鹿城区', '3');
INSERT INTO `x_region` VALUES ('3306', '391', '龙湾区', '3');
INSERT INTO `x_region` VALUES ('3307', '391', '瓯海区', '3');
INSERT INTO `x_region` VALUES ('3308', '391', '瑞安市', '3');
INSERT INTO `x_region` VALUES ('3309', '391', '乐清市', '3');
INSERT INTO `x_region` VALUES ('3310', '391', '洞头县', '3');
INSERT INTO `x_region` VALUES ('3311', '391', '永嘉县', '3');
INSERT INTO `x_region` VALUES ('3312', '391', '平阳县', '3');
INSERT INTO `x_region` VALUES ('3313', '391', '苍南县', '3');
INSERT INTO `x_region` VALUES ('3314', '391', '文成县', '3');
INSERT INTO `x_region` VALUES ('3315', '391', '泰顺县', '3');
INSERT INTO `x_region` VALUES ('3316', '392', '定海区', '3');
INSERT INTO `x_region` VALUES ('3317', '392', '普陀区', '3');
INSERT INTO `x_region` VALUES ('3318', '392', '岱山县', '3');
INSERT INTO `x_region` VALUES ('3319', '392', '嵊泗县', '3');
INSERT INTO `x_region` VALUES ('3320', '393', '衢州市', '3');
INSERT INTO `x_region` VALUES ('3321', '393', '江山市', '3');
INSERT INTO `x_region` VALUES ('3322', '393', '常山县', '3');
INSERT INTO `x_region` VALUES ('3323', '393', '开化县', '3');
INSERT INTO `x_region` VALUES ('3324', '393', '龙游县', '3');
INSERT INTO `x_region` VALUES ('3325', '394', '合川区', '3');
INSERT INTO `x_region` VALUES ('3326', '394', '江津区', '3');
INSERT INTO `x_region` VALUES ('3327', '394', '南川区', '3');
INSERT INTO `x_region` VALUES ('3328', '394', '永川区', '3');
INSERT INTO `x_region` VALUES ('3329', '394', '南岸区', '3');
INSERT INTO `x_region` VALUES ('3330', '394', '渝北区', '3');
INSERT INTO `x_region` VALUES ('3331', '394', '万盛区', '3');
INSERT INTO `x_region` VALUES ('3332', '394', '大渡口区', '3');
INSERT INTO `x_region` VALUES ('3333', '394', '万州区', '3');
INSERT INTO `x_region` VALUES ('3334', '394', '北碚区', '3');
INSERT INTO `x_region` VALUES ('3335', '394', '沙坪坝区', '3');
INSERT INTO `x_region` VALUES ('3336', '394', '巴南区', '3');
INSERT INTO `x_region` VALUES ('3337', '394', '涪陵区', '3');
INSERT INTO `x_region` VALUES ('3338', '394', '江北区', '3');
INSERT INTO `x_region` VALUES ('3339', '394', '九龙坡区', '3');
INSERT INTO `x_region` VALUES ('3340', '394', '渝中区', '3');
INSERT INTO `x_region` VALUES ('3341', '394', '黔江开发区', '3');
INSERT INTO `x_region` VALUES ('3342', '394', '长寿区', '3');
INSERT INTO `x_region` VALUES ('3343', '394', '双桥区', '3');
INSERT INTO `x_region` VALUES ('3344', '394', '綦江县', '3');
INSERT INTO `x_region` VALUES ('3345', '394', '潼南县', '3');
INSERT INTO `x_region` VALUES ('3346', '394', '铜梁县', '3');
INSERT INTO `x_region` VALUES ('3347', '394', '大足县', '3');
INSERT INTO `x_region` VALUES ('3348', '394', '荣昌县', '3');
INSERT INTO `x_region` VALUES ('3349', '394', '璧山县', '3');
INSERT INTO `x_region` VALUES ('3350', '394', '垫江县', '3');
INSERT INTO `x_region` VALUES ('3351', '394', '武隆县', '3');
INSERT INTO `x_region` VALUES ('3352', '394', '丰都县', '3');
INSERT INTO `x_region` VALUES ('3353', '394', '城口县', '3');
INSERT INTO `x_region` VALUES ('3354', '394', '梁平县', '3');
INSERT INTO `x_region` VALUES ('3355', '394', '开县', '3');
INSERT INTO `x_region` VALUES ('3356', '394', '巫溪县', '3');
INSERT INTO `x_region` VALUES ('3357', '394', '巫山县', '3');
INSERT INTO `x_region` VALUES ('3358', '394', '奉节县', '3');
INSERT INTO `x_region` VALUES ('3359', '394', '云阳县', '3');
INSERT INTO `x_region` VALUES ('3360', '394', '忠县', '3');
INSERT INTO `x_region` VALUES ('3361', '394', '石柱', '3');
INSERT INTO `x_region` VALUES ('3362', '394', '彭水', '3');
INSERT INTO `x_region` VALUES ('3363', '394', '酉阳', '3');
INSERT INTO `x_region` VALUES ('3364', '394', '秀山', '3');
INSERT INTO `x_region` VALUES ('3365', '395', '沙田区', '3');
INSERT INTO `x_region` VALUES ('3366', '395', '东区', '3');
INSERT INTO `x_region` VALUES ('3367', '395', '观塘区', '3');
INSERT INTO `x_region` VALUES ('3368', '395', '黄大仙区', '3');
INSERT INTO `x_region` VALUES ('3369', '395', '九龙城区', '3');
INSERT INTO `x_region` VALUES ('3370', '395', '屯门区', '3');
INSERT INTO `x_region` VALUES ('3371', '395', '葵青区', '3');
INSERT INTO `x_region` VALUES ('3372', '395', '元朗区', '3');
INSERT INTO `x_region` VALUES ('3373', '395', '深水埗区', '3');
INSERT INTO `x_region` VALUES ('3374', '395', '西贡区', '3');
INSERT INTO `x_region` VALUES ('3375', '395', '大埔区', '3');
INSERT INTO `x_region` VALUES ('3376', '395', '湾仔区', '3');
INSERT INTO `x_region` VALUES ('3377', '395', '油尖旺区', '3');
INSERT INTO `x_region` VALUES ('3378', '395', '北区', '3');
INSERT INTO `x_region` VALUES ('3379', '395', '南区', '3');
INSERT INTO `x_region` VALUES ('3380', '395', '荃湾区', '3');
INSERT INTO `x_region` VALUES ('3381', '395', '中西区', '3');
INSERT INTO `x_region` VALUES ('3382', '395', '离岛区', '3');
INSERT INTO `x_region` VALUES ('3383', '396', '澳门', '3');
INSERT INTO `x_region` VALUES ('3384', '397', '台北', '3');
INSERT INTO `x_region` VALUES ('3385', '397', '高雄', '3');
INSERT INTO `x_region` VALUES ('3386', '397', '基隆', '3');
INSERT INTO `x_region` VALUES ('3387', '397', '台中', '3');
INSERT INTO `x_region` VALUES ('3388', '397', '台南', '3');
INSERT INTO `x_region` VALUES ('3389', '397', '新竹', '3');
INSERT INTO `x_region` VALUES ('3390', '397', '嘉义', '3');
INSERT INTO `x_region` VALUES ('3391', '397', '宜兰县', '3');
INSERT INTO `x_region` VALUES ('3392', '397', '桃园县', '3');
INSERT INTO `x_region` VALUES ('3393', '397', '苗栗县', '3');
INSERT INTO `x_region` VALUES ('3394', '397', '彰化县', '3');
INSERT INTO `x_region` VALUES ('3395', '397', '南投县', '3');
INSERT INTO `x_region` VALUES ('3396', '397', '云林县', '3');
INSERT INTO `x_region` VALUES ('3397', '397', '屏东县', '3');
INSERT INTO `x_region` VALUES ('3398', '397', '台东县', '3');
INSERT INTO `x_region` VALUES ('3399', '397', '花莲县', '3');
INSERT INTO `x_region` VALUES ('3400', '397', '澎湖县', '3');
INSERT INTO `x_region` VALUES ('3401', '3', '合肥', '2');
INSERT INTO `x_region` VALUES ('3402', '3401', '庐阳区', '3');
INSERT INTO `x_region` VALUES ('3403', '3401', '瑶海区', '3');
INSERT INTO `x_region` VALUES ('3404', '3401', '蜀山区', '3');
INSERT INTO `x_region` VALUES ('3405', '3401', '包河区', '3');
INSERT INTO `x_region` VALUES ('3406', '3401', '长丰县', '3');
INSERT INTO `x_region` VALUES ('3407', '3401', '肥东县', '3');
INSERT INTO `x_region` VALUES ('3408', '3401', '肥西县', '3');
INSERT INTO `x_region` VALUES ('3409', '0', '国外', '0');

-- ----------------------------
-- Table structure for x_route
-- ----------------------------
DROP TABLE IF EXISTS `x_route`;
CREATE TABLE `x_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `listorder` int(5) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='url路由表';

-- ----------------------------
-- Records of x_route
-- ----------------------------
INSERT INTO `x_route` VALUES ('1', 'home/Listn/index?id=1', 'about', '0', '1');
INSERT INTO `x_route` VALUES ('2', 'home/Listn/index?id=8', 'about_en', '0', '1');
INSERT INTO `x_route` VALUES ('3', 'home/Listn/index?id=4', 'contacts', '0', '1');
INSERT INTO `x_route` VALUES ('4', 'home/Listn/index?id=11', 'contacts_en', '0', '1');
INSERT INTO `x_route` VALUES ('5', 'home/Listn/index', 'list/:id', '0', '1');
INSERT INTO `x_route` VALUES ('6', 'home/News/index', 'news/:id', '0', '1');
INSERT INTO `x_route` VALUES ('7', 'home/Index/index', '/', '0', '1');

-- ----------------------------
-- Table structure for x_source
-- ----------------------------
DROP TABLE IF EXISTS `x_source`;
CREATE TABLE `x_source` (
  `source_id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `source_name` varchar(30) NOT NULL,
  `source_order` int(11) NOT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_source
-- ----------------------------
INSERT INTO `x_source` VALUES ('1', '雨飞工作室', '2');
INSERT INTO `x_source` VALUES ('2', 'ThinkPHP', '10');
INSERT INTO `x_source` VALUES ('3', 'Rainfer studio', '1');

-- ----------------------------
-- Table structure for x_test
-- ----------------------------
DROP TABLE IF EXISTS `x_test`;
CREATE TABLE `x_test` (
  `test_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `test_order` int(3) unsigned DEFAULT '50' COMMENT '默认排序字段',
  `test_cid` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '前台栏目id',
  `m_text` varchar(200) DEFAULT '' COMMENT '文本字段',
  `m_map_lng` double NOT NULL DEFAULT '22' COMMENT '地图字段',
  `m_map_lat` double NOT NULL DEFAULT '22' COMMENT '地图字段',
  `m_imagefile` varchar(200) DEFAULT '' COMMENT '单图片字段',
  `m_images` text COMMENT '多图片字段',
  `m_selecttext` varchar(200) NOT NULL DEFAULT '未填写' COMMENT '选择文本',
  `m_cur` bigint(20) unsigned DEFAULT '22' COMMENT '货币字段',
  `m_long` bigint(20) DEFAULT NULL COMMENT '长整数字段',
  `m_int` int(11) NOT NULL DEFAULT '1' COMMENT '整数字段',
  `m_datatime` int(10) unsigned DEFAULT NULL COMMENT '日期时间字段',
  `m_date` int(10) unsigned DEFAULT NULL COMMENT '日期字段',
  `m_selectnumber` int(11) DEFAULT NULL COMMENT '选择数字字段',
  `m_richtext` text COMMENT '富文本字段',
  `m_bigtext` text COMMENT '文本域字段',
  `m_switch` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '开关字段',
  `m_check` varchar(200) DEFAULT '' COMMENT '多选框字段',
  PRIMARY KEY (`test_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_test
-- ----------------------------
INSERT INTO `x_test` VALUES ('2', '45', '1', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486483200', '1', '<p>当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\n \n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。</p>', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '1', '1,2,5,6');
INSERT INTO `x_test` VALUES ('3', '11', '2', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '0', '1,2,5,6');
INSERT INTO `x_test` VALUES ('4', '22', '3', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '1', '1,2,5,6');
INSERT INTO `x_test` VALUES ('5', '33', '4', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '0', '1,2,5,6');
INSERT INTO `x_test` VALUES ('6', '44', '5', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '1', '1,2,5,6');
INSERT INTO `x_test` VALUES ('7', '50', '6', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '0', '1,2,5,6');
INSERT INTO `x_test` VALUES ('10', '47', '7', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '0', '1,2,5,6');
INSERT INTO `x_test` VALUES ('12', '50', '8', '文本测试数据文本测试数据文本测试数据文本测试数据文本测试数据', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', 'http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg,http://ohjmksy46.bkt.clouddn.com/image/iw7u817c_3ljeuzemth44584179bf73a10.jpg', '1', '22', '9999999999999', '8888888', '1486563521', '1486563521', '1', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。有人统计说企业每投在品牌形象设计上1美元，所获得的收益是227美元。如此诱人的投资回报率，无怪乎企业界对品牌设计趋之若鹜。那么，品牌设计究竟是什么？其魅力来自何处？\r\n \r\n1、设计是冰山一角，却至关重要！如果我们把品牌理解成一座冰山。品牌或企业所属的文化制度、员工行为、组织结构、核心技术、营销方式等要素是构成这座冰山的主体，尽管隐于水下，却是品牌发展最强有力的支撑与原动力。\r\n但这一切都必须通过一系列完整有效的视觉设计与品牌推广来被大众所认知。', '当世界进入品牌竞争的时代，当品牌成为中华大地上商界的热点时，品牌设计也成为人们常挂在嘴边的时髦词汇。', '0', '1,2,5,6');
INSERT INTO `x_test` VALUES ('13', '50', '2', '', '22', '22', 'http://ohjmksy46.bkt.clouddn.com/image/ix66veqg_5sgky011nh0c58612b67ba135.png', 'http://ohjmksy46.bkt.clouddn.com/image/ix66vilc_6cgtqvbo9cg858612b6ccbef1.png,http://ohjmksy46.bkt.clouddn.com/image/ix66vilc_63fw80lz0dgk58612b6cc41f1.png,', '1', '22', '0', '11', '1482762857', '1482681600', '1', '', '', '0', '');

-- ----------------------------
-- Table structure for x_web_log
-- ----------------------------
DROP TABLE IF EXISTS `x_web_log`;
CREATE TABLE `x_web_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `uid` smallint(5) unsigned NOT NULL COMMENT '用户id',
  `ip` char(15) NOT NULL COMMENT '访客ip',
  `location` varchar(255) NOT NULL COMMENT '访客地址',
  `os` varchar(255) NOT NULL COMMENT '操作系统',
  `browser` varchar(255) NOT NULL COMMENT '浏览器',
  `url` varchar(255) NOT NULL COMMENT 'url',
  `module` char(6) NOT NULL COMMENT '模块',
  `controller` varchar(255) NOT NULL COMMENT '控制器',
  `action` varchar(255) NOT NULL DEFAULT '' COMMENT '操作方法',
  `method` varchar(10) NOT NULL DEFAULT 'GET' COMMENT '请求类型',
  `data` text NOT NULL COMMENT '请求的param数据，serialize后的',
  `otime` int(10) unsigned NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `ip` (`ip`),
  KEY `otime` (`otime`),
  KEY `module` (`module`),
  KEY `controller` (`controller`),
  KEY `method` (`method`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='网站日志';

-- ----------------------------
-- Records of x_web_log
-- ----------------------------
INSERT INTO `x_web_log` VALUES ('1', '0', '0.0.0.0', '保留地址 保留地址  ', 'Windows 10', 'Chrome(61.0.3141.7)', '/XRepair/BackEnd/admin/login/runlogin.html', 'admin', 'Login', 'runlogin', 'Ajax', 's:12:\"保密数据\";', '1502245995');
INSERT INTO `x_web_log` VALUES ('2', '0', '0.0.0.0', '保留地址 保留地址  ', 'Windows 10', 'Chrome(61.0.3141.7)', '/XRepair/BackEnd/home/register/runregister.html', 'home', 'Register', 'runregister', 'Ajax', 's:12:\"保密数据\";', '1502257428');
INSERT INTO `x_web_log` VALUES ('3', '0', '0.0.0.0', '保留地址 保留地址  ', 'Windows 10', 'Chrome(61.0.3141.7)', '/XRepair/BackEnd/home/register/runregister.html', 'home', 'Register', 'runregister', 'Ajax', 's:12:\"保密数据\";', '1502257447');
INSERT INTO `x_web_log` VALUES ('4', '0', '0.0.0.0', '保留地址 保留地址  ', 'Windows 10', 'Chrome(61.0.3141.7)', '/XRepair/BackEnd/home/register/runregister.html', 'home', 'Register', 'runregister', 'Ajax', 's:12:\"保密数据\";', '1502257456');
INSERT INTO `x_web_log` VALUES ('5', '0', '0.0.0.0', '保留地址 保留地址  ', 'Windows 10', 'Chrome(61.0.3141.7)', '/XRepair/BackEnd/home/register/runregister.html', 'home', 'Register', 'runregister', 'Ajax', 's:12:\"保密数据\";', '1502257479');

-- ----------------------------
-- Table structure for x_we_mats
-- ----------------------------
DROP TABLE IF EXISTS `x_we_mats`;
CREATE TABLE `x_we_mats` (
  `mats_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mats_name` varchar(100) NOT NULL DEFAULT '' COMMENT '素材名',
  `mats_type` varchar(10) NOT NULL DEFAULT 'image' COMMENT '素材类型',
  `url_lc` varchar(255) DEFAULT '' COMMENT '素材本地url',
  `news_content` text COMMENT '图文返回或设置内容',
  `news_index` tinyint(2) DEFAULT '0' COMMENT '多图文索引从0开始',
  `video_content` text COMMENT '视频返回或设置内容',
  `media_id` varchar(100) NOT NULL DEFAULT '' COMMENT '素材id',
  `url` varchar(255) DEFAULT '' COMMENT '素材url',
  `create_time` int(11) NOT NULL COMMENT '上传时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`mats_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_we_mats
-- ----------------------------
INSERT INTO `x_we_mats` VALUES ('1', 'girl.jpg', 'image', '', '', '0', null, 'KdpdmrH0vQi-14__8hxsuNGesZG3wQgnf9zajn4nw9w', 'http://mmbiz.qpic.cn/mmbiz/gLO17UPS6FS2xsypf378iaNhWacZ1G1UplZYWEYfwvuU6Ont96b1roYsCNFwaRrSaKTPCUdBK9DgEHicsKwWCBRQ/0', '1483622035', '1483622035');
INSERT INTO `x_we_mats` VALUES ('2', 'boy.jpg', 'image', '', '', '0', null, 'KdpdmrH0vQi-14__8hxsuOhetEVshLk7MTCoTIrUjeE', 'http://mmbiz.qpic.cn/mmbiz_jpg/bBGqHGSmX13NZvOgT9cdygib8icSngXfAvVmbvUg530cgoVHLAvAibp7ETfNNfoJpFIujnDTUA928rUulaC3icPm2w/0?wx_fmt=jpeg', '1483618551', '1483618551');
INSERT INTO `x_we_mats` VALUES ('3', '标题', 'video', '', '', '0', null, 'KdpdmrH0vQi-14__8hxsuD_SIO-sM4B8jsiNHByhtDA', '', '1483621917', '1483621917');
INSERT INTO `x_we_mats` VALUES ('4', 'a.mp3', 'voice', '', '', '0', null, 'KdpdmrH0vQi-14__8hxsuJhtMm36AWCjujVrnOQy-Kk', '', '1483619629', '1483619629');
INSERT INTO `x_we_mats` VALUES ('5', '图文', 'news', '', '{\"title\":\"\\u56fe\\u6587\",\"author\":\"rainfer\",\"digest\":\"\\u5355\\u56fe\\u6587\\u6d88\\u606f\\u624d\\u6709\\u6458\\u8981\",\"content\":\"<p><img src=\\\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz_jpg\\/bBGqHGSmX13NZvOgT9cdygib8icSngXfAvVmbvUg530cgoVHLAvAibp7ETfNNfoJpFIujnDTUA928rUulaC3icPm2w\\/0?wx_fmt=jpeg\\\" alt=\\\"0?wx_fmt=jpeg\\\"\\/><\\/p><p>\\u56fe\\u6587\\u6d88\\u606f\\u7684\\u5177\\u4f53\\u5185\\u5bb9\\uff0c\\u652f\\u6301HTML\\u6807\\u7b7e<\\/p><p><img src=\\\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz\\/gLO17UPS6FS2xsypf378iaNhWacZ1G1UplZYWEYfwvuU6Ont96b1roYsCNFwaRrSaKTPCUdBK9DgEHicsKwWCBRQ\\/0\\\" alt=\\\"0\\\"\\/><\\/p>\",\"content_source_url\":\"http:\\/\\/www.rainfer.cn\",\"thumb_media_id\":\"KdpdmrH0vQi-14__8hxsuNGesZG3wQgnf9zajn4nw9w\",\"show_cover_pic\":0,\"url\":\"http:\\/\\/mp.weixin.qq.com\\/s?__biz=MzIzMzM4NDg0MQ==&mid=100000007&idx=1&sn=9cb9083207911fc248bea6096d332a2e&chksm=68873fe15ff0b6f7904c35344049ed50e28fddab949318a81b8c806681b6fb2b90e25bae4fa5#rd\",\"thumb_url\":\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz_jpg\\/bBGqHGSmX13NZvOgT9cdygib8icSngXfAvibLwibW4jwgOaedmdejP2vvug6ZLcZsGIV8rmiaRHwMhibpFWkE0fLU1qA\\/0?wx_fmt=jpeg\"}', '0', null, 'KdpdmrH0vQi-14__8hxsuMAdAzRcc0BgrPlVD_jrsmw', '', '1483622501', '1483711027');
INSERT INTO `x_we_mats` VALUES ('6', 'test', 'image', '', null, '0', null, 'KdpdmrH0vQi-14__8hxsuEE5FPTRd6TL_mb_-oZHJ_M', 'http://mmbiz.qpic.cn/mmbiz_jpg/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtjoKHVib0W5XicyjEqibb0NmLvX18LG6wLxwDc1TpaQx54c6RH6ty4yXfQ/0?wx_fmt=jpeg', '1483776570', '1483776570');
INSERT INTO `x_we_mats` VALUES ('7', '测试声音', 'voice', '', null, '0', null, 'KdpdmrH0vQi-14__8hxsuOfyREwfA3efqZ32Sfck70s', '', '1483776641', '1483776641');
INSERT INTO `x_we_mats` VALUES ('8', '测试视频', 'video', '', null, '0', '{\"title\":\"\\u89c6\\u9891\\u6807\\u9898\",\"introduction\":\"\\u89c6\\u9891\\u63cf\\u8ff0\"}', 'KdpdmrH0vQi-14__8hxsuHOJUm63PtG7qRJxTwzbkmk', '', '1483776792', '1483776792');
INSERT INTO `x_we_mats` VALUES ('9', '测试缩略图', 'thumb', '', null, '0', null, 'KdpdmrH0vQi-14__8hxsuNnDHsNXliG-ck9AEumsssw', '', '1483776876', '1483776876');
INSERT INTO `x_we_mats` VALUES ('10', '图文1', 'news', '', '{\"title\":\"\\u56fe\\u65871\",\"thumb_media_id\":\"KdpdmrH0vQi-14__8hxsuPcF4KagNmpPbDxkYsgKtxA\",\"author\":\"\\u56fe\\u65871\",\"digest\":\"\\u56fe\\u65871\",\"show_cover_pic\":\"1\",\"content_source_url\":\"http:\\/\\/www.rainfer.cn\",\"content\":\"<p>asdfsdf<\\/p><p><img src=\\\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz_jpg\\/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtUjU6ich2ciaRayUqJV06jl2OKFDxDzJ3APXw7E7pbR27DkZWibRz54seQ\\/0\\\" title=\\\"5870a3b014020.jpg\\\" alt=\\\"5870a3b014020.jpg\\\"\\/><\\/p><p><img src=\\\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz\\/gLO17UPS6FS2xsypf378iaNhWacZ1G1UplZYWEYfwvuU6Ont96b1roYsCNFwaRrSaKTPCUdBK9DgEHicsKwWCBRQ\\/0\\\" style=\\\"\\\"\\/><\\/p><p><br\\/><\\/p>\"}', '0', null, 'KdpdmrH0vQi-14__8hxsuJVMs7ryz_4oPHpWz43-ZcQ', '', '1483776950', '1483776950');
INSERT INTO `x_we_mats` VALUES ('11', 'test2', 'image', '', null, '0', null, 'KdpdmrH0vQi-14__8hxsuJT5egvgUxI4nQaKlJ1VwdY', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtmX2EsuiaVkWTBj4MfNiabvTsOZatPDe3hrXIEG0gz1xlT1oalTJkhFAw/0?wx_fmt=png', '1483782052', '1483782052');

-- ----------------------------
-- Table structure for x_we_menu
-- ----------------------------
DROP TABLE IF EXISTS `x_we_menu`;
CREATE TABLE `x_we_menu` (
  `we_menu_id` tinyint(11) NOT NULL AUTO_INCREMENT,
  `we_menu_name` varchar(20) NOT NULL COMMENT '菜单名称',
  `we_menu_leftid` int(11) NOT NULL COMMENT '菜单上级ID',
  `we_menu_type` tinyint(2) NOT NULL COMMENT '菜单类型',
  `we_menu_typeval` varchar(200) NOT NULL COMMENT '菜单类型值',
  `we_menu_open` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否显示',
  `we_menu_order` int(11) NOT NULL DEFAULT '50' COMMENT '排序',
  `we_menu_l` varchar(10) NOT NULL DEFAULT 'zh-cn',
  PRIMARY KEY (`we_menu_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_we_menu
-- ----------------------------
INSERT INTO `x_we_menu` VALUES ('1', '菜单1', '0', '1', '', '1', '0', 'zh-cn');
INSERT INTO `x_we_menu` VALUES ('2', '公司简介', '1', '2', 'http://www.thinkphp.cn/', '1', '50', 'zh-cn');
INSERT INTO `x_we_menu` VALUES ('4', '菜单二', '0', '1', '', '1', '50', 'zh-cn');
INSERT INTO `x_we_menu` VALUES ('5', '菜单三', '0', '1', '', '1', '50', 'zh-cn');
INSERT INTO `x_we_menu` VALUES ('6', '二级菜单', '4', '1', '', '1', '50', 'zh-cn');
INSERT INTO `x_we_menu` VALUES ('7', '三级菜单', '5', '1', '', '1', '50', 'zh-cn');
INSERT INTO `x_we_menu` VALUES ('8', '联系我们', '1', '1', '', '1', '50', 'zh-cn');

-- ----------------------------
-- Table structure for x_we_pic
-- ----------------------------
DROP TABLE IF EXISTS `x_we_pic`;
CREATE TABLE `x_we_pic` (
  `pic_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `url` varchar(255) DEFAULT '' COMMENT '素材url',
  `mtime` int(11) NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`pic_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_we_pic
-- ----------------------------
INSERT INTO `x_we_pic` VALUES ('1', 'http://mmbiz.qpic.cn/mmbiz/gLO17UPS6FS2xsypf378iaNhWacZ1G1UplZYWEYfwvuU6Ont96b1roYsCNFwaRrSaKTPCUdBK9DgEHicsKwWCBRQ/0', '1483622035');
INSERT INTO `x_we_pic` VALUES ('2', 'http://mmbiz.qpic.cn/mmbiz_jpg/bBGqHGSmX13NZvOgT9cdygib8icSngXfAvVmbvUg530cgoVHLAvAibp7ETfNNfoJpFIujnDTUA928rUulaC3icPm2w/0?wx_fmt=jpeg', '1483618551');
INSERT INTO `x_we_pic` VALUES ('7', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUD0Ff9n81k9c0ZhA99xrMlVeLyhqEVlQ1I7zVBibrnzaPt4IAJqLL3pA/0', '1483704413');
INSERT INTO `x_we_pic` VALUES ('6', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUt2zBAsDGdCqwaFD9wGdJjaLPFLcDiahMSeE97ZYicia5WFDO6p0O0CpOA/0', '1483703469');
INSERT INTO `x_we_pic` VALUES ('8', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUD0Ff9n81k9c0ZhA99xrMlVeLyhqEVlQ1I7zVBibrnzaPt4IAJqLL3pA/0', '1483705963');
INSERT INTO `x_we_pic` VALUES ('9', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUA2XSgrhrEfdiaXrxkbSKMQaH1icL4Pu4Ap8hPcP6jIdJuElkvbp5EibKg/0', '1483706148');
INSERT INTO `x_we_pic` VALUES ('10', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUsByB9AGojicSRZ7nxR0cxib4NmOvqt2Pbw2X6K2OzhwpaRIiacic34gyNA/0', '1483707520');
INSERT INTO `x_we_pic` VALUES ('11', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fU9reIEv9ZPf1C0VBmUr3tEI5uohK3ljwaiarzo4S7HR9OicY0sVVKMKqQ/0', '1483707548');
INSERT INTO `x_we_pic` VALUES ('12', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUA2XSgrhrEfdiaXrxkbSKMQaH1icL4Pu4Ap8hPcP6jIdJuElkvbp5EibKg/0', '1483707618');
INSERT INTO `x_we_pic` VALUES ('13', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUA2XSgrhrEfdiaXrxkbSKMQaH1icL4Pu4Ap8hPcP6jIdJuElkvbp5EibKg/0', '1483707927');
INSERT INTO `x_we_pic` VALUES ('14', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fUD0Ff9n81k9c0ZhA99xrMlVeLyhqEVlQ1I7zVBibrnzaPt4IAJqLL3pA/0', '1483708083');
INSERT INTO `x_we_pic` VALUES ('15', 'http://mmbiz.qpic.cn/mmbiz_jpg/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fU2o4hwr63JMdRqSdoiapTEHWuz9TqibY0c7hvonRjdK5ZkegcEpsiaZTtA/0', '1483708730');
INSERT INTO `x_we_pic` VALUES ('16', 'http://mmbiz.qpic.cn/mmbiz_jpg/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtjoKHVib0W5XicyjEqibb0NmLvX18LG6wLxwDc1TpaQx54c6RH6ty4yXfQ/0?wx_fmt=jpeg', '1483776570');
INSERT INTO `x_we_pic` VALUES ('17', 'http://mmbiz.qpic.cn/mmbiz_jpg/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtUjU6ich2ciaRayUqJV06jl2OKFDxDzJ3APXw7E7pbR27DkZWibRz54seQ/0', '1483776945');
INSERT INTO `x_we_pic` VALUES ('18', 'http://mmbiz.qpic.cn/mmbiz_png/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtmX2EsuiaVkWTBj4MfNiabvTsOZatPDe3hrXIEG0gz1xlT1oalTJkhFAw/0?wx_fmt=png', '1483782052');

-- ----------------------------
-- Table structure for x_we_reply
-- ----------------------------
DROP TABLE IF EXISTS `x_we_reply`;
CREATE TABLE `x_we_reply` (
  `we_reply_id` int(11) NOT NULL AUTO_INCREMENT,
  `we_reply_key` varchar(255) NOT NULL COMMENT '关键字',
  `we_reply_type` varchar(20) NOT NULL,
  `we_replytext_content` varchar(255) NOT NULL COMMENT '回复内容',
  `we_reply_addtime` int(11) NOT NULL COMMENT '添加时间',
  `we_reply_open` tinyint(1) NOT NULL DEFAULT '0',
  `we_replynews` text NOT NULL,
  `we_replyimage_mediaid` varchar(200) NOT NULL,
  `we_replyvoice_mediaid` varchar(200) NOT NULL,
  PRIMARY KEY (`we_reply_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of x_we_reply
-- ----------------------------
INSERT INTO `x_we_reply` VALUES ('1', 'yfcmf', 'text', '轻量级企业网站管理系统 运行环境:PHP5.4+, MySQL5.0', '1466497576', '1', '', '', '');
INSERT INTO `x_we_reply` VALUES ('2', 'kk', 'news', '', '1483711089', '1', '{\"title\":\"tttt\",\"description\":\"aaaaa\",\"url\":\"http:\\/\\/www.rainfer.cn\",\"image\":\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz_jpg\\/bBGqHGSmX10eyug9GJeVX5A8wuzcia8fU2o4hwr63JMdRqSdoiapTEHWuz9TqibY0c7hvonRjdK5ZkegcEpsiaZTtA\\/0\"}', '', '');
INSERT INTO `x_we_reply` VALUES ('3', 'ff', 'image', '', '1483712501', '1', '', 'KdpdmrH0vQi-14__8hxsuMAdAzRcc0BgrPlVD_jrsmw', '');
INSERT INTO `x_we_reply` VALUES ('4', 'girl', 'image', '', '1483712585', '1', '', 'KdpdmrH0vQi-14__8hxsuNGesZG3wQgnf9zajn4nw9w', '');
INSERT INTO `x_we_reply` VALUES ('5', 'tw', 'news', '', '1483776982', '1', '{\"title\":\"asdf\",\"description\":\"asdf\",\"url\":\"http:\\/\\/www.rainfer.cn\",\"image\":\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz_jpg\\/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtjoKHVib0W5XicyjEqibb0NmLvX18LG6wLxwDc1TpaQx54c6RH6ty4yXfQ\\/0?wx_fmt=jpeg\"}', '', '');
INSERT INTO `x_we_reply` VALUES ('10', 'subscribe', 'news', '', '1483783147', '1', '{\"title\":\"\\u6b22\\u8fce\\u60a8\\u7684\\u5173\\u6ce8!\",\"description\":\"\\u6b22\\u8fce\\u60a8\\u7684\\u5173\\u6ce8!\",\"url\":\"http:\\/\\/www.rainfer.cn\",\"image\":\"http:\\/\\/mmbiz.qpic.cn\\/mmbiz_png\\/bBGqHGSmX10B1cCLzD5Vg16ZSlSyOQJtmX2EsuiaVkWTBj4MfNiabvTsOZatPDe3hrXIEG0gz1xlT1oalTJkhFAw\\/0?wx_fmt=png\"}', '', '');
INSERT INTO `x_we_reply` VALUES ('12', '下载地址', 'text', 'https://git.oschina.net/rainfer/YFCMF', '1483784536', '1', '', '', '');
