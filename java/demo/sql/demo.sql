/*
Navicat MySQL Data Transfer

Source Server         : greatsec_test_demo
Source Server Version : 50544
Source Host           : 192.168.3.37:3306
Source Database       : demo

Target Server Type    : MYSQL
Target Server Version : 50544
File Encoding         : 65001

Date: 2016-07-01 09:59:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `category_id` bigint(20) NOT NULL COMMENT '栏目编号',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `color` varchar(50) DEFAULT NULL COMMENT '标题颜色（red：红色；green：绿色；blue：蓝色；yellow：黄色；orange：橙色）',
  `image` varchar(255) DEFAULT NULL COMMENT '文章图片',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述、摘要',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限，过期后将权重设置为：0',
  `hits` int(11) DEFAULT '0' COMMENT '点击数',
  `posid` varchar(10) DEFAULT NULL COMMENT '推荐位，多选（1：首页焦点图；2：栏目页文章推荐；）',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `cms_article_create_by` (`create_by`),
  KEY `cms_article_title` (`title`),
  KEY `cms_article_keywords` (`keywords`),
  KEY `cms_article_del_flag` (`del_flag`),
  KEY `cms_article_weight` (`weight`),
  KEY `cms_article_update_date` (`update_date`),
  KEY `cms_article_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of cms_article
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article_data
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_data`;
CREATE TABLE `cms_article_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `content` text COMMENT '文章内容',
  `copyfrom` varchar(255) DEFAULT NULL COMMENT '文章来源',
  `relation` varchar(255) DEFAULT NULL COMMENT '相关文章',
  `allow_comment` char(1) DEFAULT NULL COMMENT '是否允许评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章详表';

-- ----------------------------
-- Records of cms_article_data
-- ----------------------------

-- ----------------------------
-- Table structure for cms_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `site_id` bigint(20) DEFAULT '1' COMMENT '站点编号',
  `office_id` bigint(20) DEFAULT NULL COMMENT '归属机构',
  `parent_id` bigint(20) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(255) NOT NULL COMMENT '所有父级编号',
  `module` varchar(20) DEFAULT NULL COMMENT '栏目模块（article：文章；picture：图片；download：下载；link：链接；special：专题）',
  `name` varchar(100) NOT NULL COMMENT '栏目名称',
  `image` varchar(255) DEFAULT NULL COMMENT '栏目图片',
  `href` varchar(255) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标（ _blank、_self、_parent、_top）',
  `description` varchar(255) DEFAULT NULL COMMENT '描述，填写有助于搜索引擎优化',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字，填写有助于搜索引擎优化',
  `sort` int(11) DEFAULT '30' COMMENT '排序（升序）',
  `in_menu` char(1) DEFAULT '1' COMMENT '是否在导航中显示（1：显示；0：不显示）',
  `in_list` char(1) DEFAULT '1' COMMENT '是否在分类页中显示列表（1：显示；0：不显示）',
  `show_modes` char(1) DEFAULT '0' COMMENT '展现方式（0:有子栏目显示栏目列表，无子栏目显示内容列表;1：首栏目内容列表；2：栏目第一条内容）',
  `allow_comment` char(1) DEFAULT NULL COMMENT '是否允许评论',
  `is_audit` char(1) DEFAULT NULL COMMENT '是否需要审核',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `cms_category_parent_id` (`parent_id`),
  KEY `cms_category_parent_ids` (`parent_ids`),
  KEY `cms_category_module` (`module`),
  KEY `cms_category_name` (`name`),
  KEY `cms_category_sort` (`sort`),
  KEY `cms_category_del_flag` (`del_flag`),
  KEY `cms_category_office_id` (`office_id`),
  KEY `cms_category_site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
-- Records of cms_category
-- ----------------------------
INSERT INTO `cms_category` VALUES ('1', '0', '1', '0', '0,', null, '顶级栏目', null, null, null, null, null, '0', '1', '1', '0', '0', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('2', '1', '3', '1', '0,1,', 'article', '组织机构', null, null, null, null, null, '10', '1', '1', '0', '0', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('3', '1', '3', '2', '0,1,2,', 'article', '网站简介', null, null, null, null, null, '30', '1', '1', '0', '0', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('4', '1', '3', '2', '0,1,2,', 'article', '内部机构', null, null, null, null, null, '40', '1', '1', '0', '0', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('5', '1', '3', '2', '0,1,2,', 'article', '地方机构', null, null, null, null, null, '50', '1', '1', '0', '0', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('24', '1', '6', '1', '0,1,', null, '百度一下', null, 'http://www.baidu.com', '_blank', null, null, '90', '1', '1', '0', '1', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('25', '1', '6', '1', '0,1,', null, '全文检索', null, '/search', null, null, null, '90', '0', '1', '0', '1', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('26', '2', '6', '1', '0,1,', 'article', '测试栏目', null, null, null, null, null, '90', '1', '1', '0', '1', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('27', '1', '6', '1', '0,1,', null, '公共留言', null, '/guestbook', null, null, null, '90', '1', '1', '0', '1', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_category` VALUES ('28', '1', '1', '1', '0,1,', 'article', '新闻', '', '', '', '', '', '30', '0', '1', '0', '0', '0', '1', '2014-02-24 14:05:11', '1', '2014-02-24 14:08:00', null, '0');

-- ----------------------------
-- Table structure for cms_comment
-- ----------------------------
DROP TABLE IF EXISTS `cms_comment`;
CREATE TABLE `cms_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `category_id` bigint(20) NOT NULL COMMENT '栏目编号',
  `content_id` bigint(20) NOT NULL COMMENT '栏目内容的编号（Article.id、Photo.id、Download.id）',
  `title` varchar(255) DEFAULT NULL COMMENT '栏目内容的标题（Article.title、Photo.title、Download.title）',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `name` varchar(100) DEFAULT NULL COMMENT '评论姓名',
  `ip` varchar(100) DEFAULT NULL COMMENT '评论IP',
  `create_date` datetime NOT NULL COMMENT '评论时间',
  `audit_user_id` bigint(20) DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `cms_comment_category_id` (`category_id`),
  KEY `cms_comment_content_id` (`content_id`),
  KEY `cms_comment_status` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of cms_comment
-- ----------------------------

-- ----------------------------
-- Table structure for cms_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `cms_guestbook`;
CREATE TABLE `cms_guestbook` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) NOT NULL COMMENT '留言分类（1咨询、2建议、3投诉、4其它）',
  `content` varchar(255) NOT NULL COMMENT '留言内容',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `phone` varchar(100) NOT NULL COMMENT '电话',
  `workunit` varchar(100) NOT NULL COMMENT '单位',
  `ip` varchar(100) NOT NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '留言时间',
  `re_user_id` bigint(20) DEFAULT NULL COMMENT '回复人',
  `re_date` datetime DEFAULT NULL COMMENT '回复时间',
  `re_content` varchar(100) DEFAULT NULL COMMENT '回复内容',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `cms_guestbook_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='留言板';

-- ----------------------------
-- Records of cms_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for cms_link
-- ----------------------------
DROP TABLE IF EXISTS `cms_link`;
CREATE TABLE `cms_link` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `category_id` bigint(20) NOT NULL COMMENT '栏目编号',
  `title` varchar(255) NOT NULL COMMENT '链接名称',
  `color` varchar(50) DEFAULT NULL COMMENT '标题颜色（red：红色；green：绿色；blue：蓝色；yellow：黄色；orange：橙色）',
  `image` varchar(255) DEFAULT NULL COMMENT '链接图片，如果上传了图片，则显示为图片链接',
  `href` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限，过期后将权重设置为：0',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `cms_link_category_id` (`category_id`),
  KEY `cms_link_title` (`title`),
  KEY `cms_link_del_flag` (`del_flag`),
  KEY `cms_link_weight` (`weight`),
  KEY `cms_link_create_by` (`create_by`),
  KEY `cms_link_update_date` (`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='友情链接';

-- ----------------------------
-- Records of cms_link
-- ----------------------------
INSERT INTO `cms_link` VALUES ('1', '19', 'JeeSite', null, null, 'http://thinkgem.github.com/jeesite', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('2', '19', 'ThinkGem', null, null, 'http://thinkgem.iteye.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('3', '19', '百度一下', null, null, 'http://www.baidu.com', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('4', '19', '谷歌搜索', null, null, 'http://www.google.com', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('5', '20', '新浪网', null, null, 'http://www.sina.com.cn', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('6', '20', '腾讯网', null, null, 'http://www.qq.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('7', '21', '淘宝网', null, null, 'http://www.taobao.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('8', '21', '新华网', null, null, 'http://www.xinhuanet.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('9', '22', '赶集网', null, null, 'http://www.ganji.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('10', '22', '58同城', null, null, 'http://www.58.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('11', '23', '视频大全', null, null, 'http://v.360.cn/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `cms_link` VALUES ('12', '23', '凤凰网', null, null, 'http://www.ifeng.com/', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');

-- ----------------------------
-- Table structure for cms_site
-- ----------------------------
DROP TABLE IF EXISTS `cms_site`;
CREATE TABLE `cms_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '站点名称',
  `title` varchar(100) NOT NULL COMMENT '站点标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述，填写有助于搜索引擎优化',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字，填写有助于搜索引擎优化',
  `theme` varchar(255) DEFAULT 'default' COMMENT '主题',
  `copyright` text COMMENT '版权信息',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `cms_site_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='站点表';

-- ----------------------------
-- Records of cms_site
-- ----------------------------
INSERT INTO `cms_site` VALUES ('1', '江苏摩比斯视频管理系统', '江苏摩比斯视频管理系统', '', '', 'basic', '<p>\r\n	<span style=\"color:#ff0000;\">江苏摩比斯视频管理系统</span></p>', '1', '2013-05-27 08:00:00', '2', '2014-02-24 14:15:50', null, '0');
INSERT INTO `cms_site` VALUES ('2', '子站点测试', 'JeeSite Subsite', 'JeeSite subsite', 'JeeSite subsite', 'basic', 'Copyright &copy; 2012-2013 <a href=\'http://thinkgem.iteye.com\' target=\'_blank\'>ThinkGem</a> - Powered By <a href=\'https://github.com/thinkgem/jeesite\' target=\'_blank\'>JeeSite</a> V1.0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(20) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(255) NOT NULL COMMENT '所有父级编号',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) NOT NULL COMMENT '区域名称',
  `type` char(1) DEFAULT NULL COMMENT '区域类型（1：国家；2：省份、直辖市；3：地市；4：区县）',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_parent_ids` (`parent_ids`),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of sys_area
-- ----------------------------
INSERT INTO `sys_area` VALUES ('1', '0', '0,', '100000', '中国', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_area` VALUES ('15', '1', '0,1,', '', '北方片区', '2', '1', '2013-11-15 09:14:03', '1', '2013-11-15 09:14:03', '', '1');
INSERT INTO `sys_area` VALUES ('17', '1', '0,1,', '', '南方片区', '2', '1', '2013-11-15 09:14:19', '1', '2013-11-15 09:14:19', '', '1');
INSERT INTO `sys_area` VALUES ('25', '15', '0,1,15,', '', '北京', '3', '35', '2014-01-10 09:47:06', '35', '2014-01-10 09:47:06', '', '1');
INSERT INTO `sys_area` VALUES ('27', '15', '0,1,15,', '', '东北', '3', '35', '2014-01-10 09:47:15', '35', '2014-01-10 09:47:15', '', '1');
INSERT INTO `sys_area` VALUES ('29', '15', '0,1,15,', '', '山东', '3', '35', '2014-01-10 09:47:26', '35', '2014-01-10 09:47:26', '', '1');
INSERT INTO `sys_area` VALUES ('31', '17', '0,1,17,', '', '上海', '3', '35', '2014-01-10 09:47:36', '35', '2014-01-10 09:47:36', '', '1');
INSERT INTO `sys_area` VALUES ('33', '17', '0,1,17,', '', '浙江', '3', '35', '2014-01-10 09:47:44', '35', '2014-01-10 09:47:44', '', '1');
INSERT INTO `sys_area` VALUES ('35', '17', '0,1,17,', '', '福建', '3', '35', '2014-01-10 09:47:53', '35', '2014-01-10 09:47:53', '', '1');
INSERT INTO `sys_area` VALUES ('37', '17', '0,1,17,', '', '南京', '3', '35', '2014-01-10 09:48:06', '35', '2014-01-10 09:48:06', '', '1');
INSERT INTO `sys_area` VALUES ('39', '17', '0,1,17,', '', '武汉', '3', '35', '2014-01-10 09:48:14', '35', '2014-01-10 09:48:14', '', '1');
INSERT INTO `sys_area` VALUES ('41', '15', '0,1,15,', '', '北京', '4', '35', '2014-01-16 15:34:12', '35', '2014-01-16 15:34:12', '', '1');
INSERT INTO `sys_area` VALUES ('43', '15', '0,1,15,', '', '吉林', '4', '35', '2014-01-16 15:36:16', '35', '2014-01-16 15:36:16', '', '1');
INSERT INTO `sys_area` VALUES ('44', '27', '0,1,15,27,', '11111', '黑龙江', '3', '1', '2014-02-20 16:01:34', '1', '2014-02-20 16:01:34', '', '1');
INSERT INTO `sys_area` VALUES ('45', '1', '0,1,', '', '江苏', '3', '1', '2014-02-21 14:14:43', '1', '2014-02-21 14:14:43', '', '0');
INSERT INTO `sys_area` VALUES ('46', '45', '0,1,45,', '', '盐城', '4', '1', '2014-02-21 14:17:08', '1', '2014-02-21 14:17:08', '', '0');

-- ----------------------------
-- Table structure for sys_code
-- ----------------------------
DROP TABLE IF EXISTS `sys_code`;
CREATE TABLE `sys_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `type` varchar(32) DEFAULT NULL,
  `prefixes_before` varchar(32) DEFAULT NULL,
  `increment_part` varchar(32) DEFAULT NULL,
  `prefixes_after` varchar(32) DEFAULT NULL,
  `number` bigint(20) DEFAULT NULL,
  `create_by` bigint(20) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` bigint(20) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_code
-- ----------------------------
INSERT INTO `sys_code` VALUES ('1', 'order', 'MGN-YYYY-', '00000', '', '41', '1', '2013-12-04 10:36:49', '85', '2014-01-14 09:52:57', 'asdasd', '0');
INSERT INTO `sys_code` VALUES ('2', 'invoice', 'sdfasdf-', '0000', null, '1', '1', '2013-12-05 09:10:04', '1', '2013-12-05 09:10:08', 'sd', '0');
INSERT INTO `sys_code` VALUES ('3', 'sample', 'YYYY-S-', '00000', null, '32', '1', '2013-12-10 15:01:35', '91', '2014-01-14 10:32:47', null, '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '正常', '0', 'del_flag', '删除标记', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('2', '删除', '1', 'del_flag', '删除标记', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('3', '显示', '1', 'show_hide', '显示/隐藏', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('4', '隐藏', '0', 'show_hide', '显示/隐藏', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('5', '是', '1', 'yes_no', '是/否', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('6', '否', '0', 'yes_no', '是/否', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('17', '国家', '1', 'sys_area_type', '区域类型', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('18', '区域', '2', 'sys_area_type', '区域类型', '20', '1', '2013-05-27 08:00:00', '35', '2014-01-10 09:27:07', null, '1');
INSERT INTO `sys_dict` VALUES ('19', '省份', '3', 'sys_area_type', '区域类型', '30', '1', '2013-05-27 08:00:00', '35', '2014-01-10 09:27:16', null, '1');
INSERT INTO `sys_dict` VALUES ('20', '地市', '4', 'sys_area_type', '区域类型', '40', '1', '2013-05-27 08:00:00', '35', '2014-01-10 09:27:22', null, '1');
INSERT INTO `sys_dict` VALUES ('21', '公司', '1', 'sys_office_type', '机构类型', '60', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('22', '部门', '2', 'sys_office_type', '机构类型', '70', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('23', '一级', '1', 'sys_office_grade', '机构等级', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('24', '二级', '2', 'sys_office_grade', '机构等级', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('25', '三级', '3', 'sys_office_grade', '机构等级', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('26', '四级', '4', 'sys_office_grade', '机构等级', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('27', '所有数据', '1', 'sys_data_scope', '数据范围', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('28', '所在公司及以下数据', '2', 'sys_data_scope', '数据范围', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('29', '所在公司数据', '3', 'sys_data_scope', '数据范围', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('30', '所在部门及以下数据', '4', 'sys_data_scope', '数据范围', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('31', '所在部门数据', '5', 'sys_data_scope', '数据范围', '50', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('32', '仅本人数据', '6', 'sys_data_scope', '数据范围', '90', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('33', '按明细设置', '7', 'sys_data_scope', '数据范围', '100', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('34', '系统管理', '1', 'sys_user_type', '用户类型', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('35', '公司领导', '2', 'sys_user_type', '用户类型', '20', '1', '2013-05-27 08:00:00', '1', '2013-11-15 09:54:12', null, '0');
INSERT INTO `sys_dict` VALUES ('36', '普通用户', '3', 'sys_user_type', '用户类型', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('37', '基础主题', 'basic', 'cms_theme', '站点主题', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('38', '蓝色主题', 'blue', 'cms_theme', '站点主题', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('39', '红色主题', 'red', 'cms_theme', '站点主题', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('40', '文章模型', 'article', 'cms_module', '栏目模型', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('41', '图片模型', 'picture', 'cms_module', '栏目模型', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('42', '下载模型', 'download', 'cms_module', '栏目模型', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('43', '链接模型', 'link', 'cms_module', '栏目模型', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('44', '专题模型', 'special', 'cms_module', '栏目模型', '50', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('45', '默认展现方式', '0', 'cms_show_modes', '展现方式', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('46', '首栏目内容列表', '1', 'cms_show_modes', '展现方式', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('47', '栏目第一条内容', '2', 'cms_show_modes', '展现方式', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('48', '发布', '0', 'cms_del_flag', '内容状态', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('49', '删除', '1', 'cms_del_flag', '内容状态', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('50', '审核', '2', 'cms_del_flag', '内容状态', '15', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('51', '首页焦点图', '1', 'cms_posid', '推荐位', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('52', '栏目页文章推荐', '2', 'cms_posid', '推荐位', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('53', '咨询', '1', 'cms_guestbook', '留言板分类', '10', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('54', '建议', '2', 'cms_guestbook', '留言板分类', '20', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('55', '投诉', '3', 'cms_guestbook', '留言板分类', '30', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('56', '其它', '4', 'cms_guestbook', '留言板分类', '40', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('62', '接入日志', '1', 'sys_log_type', '日志类型', '30', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('63', '异常日志', '2', 'sys_log_type', '日志类型', '40', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型（1：接入日志；2：异常日志）',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', '2', '2', '2014-05-13 16:52:43', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1', '/video/video/list', 'GET', '', 'java.lang.NullPointerException');
INSERT INTO `sys_log` VALUES ('3', '2', '2', '2014-05-13 16:52:44', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1', '/video/video/list', 'GET', '', 'java.lang.NullPointerException');
INSERT INTO `sys_log` VALUES ('5', '2', '2', '2014-05-13 16:52:45', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1', '/video/video/list', 'GET', '', 'java.lang.NullPointerException');
INSERT INTO `sys_log` VALUES ('7', '1', '2', '2014-05-13 17:03:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1', '/video/video/save', 'POST', 'id=1&videoCategory.id=44&no=1&name=030&path=/movie/030.wmv&remarks=&videoCategory.name=发动机构造&type=1', '');
INSERT INTO `sys_log` VALUES ('9', '1', '2', '2014-05-13 17:04:09', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1', '/video/video/save', 'POST', 'id=1&videoCategory.id=44&no=1&name=ENG模块视频&path=/movie/ENG模块视频.mp4&remarks=&videoCategory.name=发动机构造&type=1', '');
INSERT INTO `sys_log` VALUES ('11', '1', '2', '2014-05-13 17:30:18', '192.168.12.117', 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko', '/vms/video/video/save', 'POST', 'id=1&videoCategory.id=44&no=1&name=ENG模块视频&path=/ENG模块视频.mp4&remarks=&videoCategory.name=发动机构造&type=1', '');
INSERT INTO `sys_log` VALUES ('13', '1', '2', '2014-05-13 17:41:19', '192.168.12.117', 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko', '/vms/video/video/save', 'POST', 'id=1&videoCategory.id=44&no=1&name=test&path=/test.wmv&remarks=&videoCategory.name=发动机构造&type=1', '');
INSERT INTO `sys_log` VALUES ('15', '1', '2', '2014-05-18 14:25:30', '192.168.12.182', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; QQDownload 718; .NET CLR 2.0.50727; .NET4.0C; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0E; TheWorld)', '/vms/video/category/save', 'POST', 'id=&no=7&parent.id=39&name=test&remarks=&parent.name=Front Chassis', '');
INSERT INTO `sys_log` VALUES ('17', '1', '2', '2014-05-18 14:27:43', '192.168.12.182', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; QQDownload 718; .NET CLR 2.0.50727; .NET4.0C; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0E; TheWorld)', '/vms/video/player/save', 'POST', 'id=1&videoCategory.id=97&no=1&name=1号机&remarks=&ip=192.168.12.182', '');
INSERT INTO `sys_log` VALUES ('19', '2', '2', '2014-06-20 16:29:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1', '/f/view--.html', 'GET', '', 'org.springframework.dao.InvalidDataAccessApiUsageException: The given id must not be null!; nested exception is java.lang.IllegalArgumentException: The given id must not be null!');
INSERT INTO `sys_log` VALUES ('21', '1', '1', '2016-07-01 09:40:24', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/user/save', 'POST', 'confirmNewPassword=&no=&office.id=2&roleIdList=1&_roleIdList=on&mobile=&newPassword=&oldLoginName=super&company.id=1&phone=&office.name=事业部&loginName=super&name=super&id=1&company.name=江苏华大网安科技有限公司&userType=1&email=&remarks=系统内置管理员', '');
INSERT INTO `sys_log` VALUES ('22', '1', '1', '2016-07-01 09:40:36', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/user/delete', 'GET', 'id=3', '');
INSERT INTO `sys_log` VALUES ('23', '1', '1', '2016-07-01 09:41:02', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/menu/delete', 'GET', 'id=218', '');
INSERT INTO `sys_log` VALUES ('24', '1', '1', '2016-07-01 09:41:06', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/menu/delete', 'GET', 'id=219', '');
INSERT INTO `sys_log` VALUES ('25', '1', '1', '2016-07-01 09:41:12', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/menu/delete', 'GET', 'id=224', '');
INSERT INTO `sys_log` VALUES ('26', '1', '1', '2016-07-01 09:41:36', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/menu/delete', 'GET', 'id=217', '');
INSERT INTO `sys_log` VALUES ('27', '1', '1', '2016-07-01 09:41:38', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/menu/delete', 'GET', 'id=216', '');
INSERT INTO `sys_log` VALUES ('28', '1', '1', '2016-07-01 09:41:58', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/menu/delete', 'GET', 'id=227', '');
INSERT INTO `sys_log` VALUES ('29', '1', '1', '2016-07-01 09:43:32', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/role/save', 'POST', 'officeIds=&office.id=2&office.name=事业部&oldName=系统管理员&name=系统管理员&id=1&dataScope=1&menuIds=1,27,28,29,30,31,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,32,33,34,35,36...', '');
INSERT INTO `sys_log` VALUES ('30', '1', '1', '2016-07-01 09:43:57', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/dict/delete', 'GET', 'id=194', '');
INSERT INTO `sys_log` VALUES ('31', '1', '1', '2016-07-01 09:44:14', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/dict/delete', 'GET', 'id=190', '');
INSERT INTO `sys_log` VALUES ('32', '1', '1', '2016-07-01 09:44:17', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/dict/delete', 'GET', 'id=191', '');
INSERT INTO `sys_log` VALUES ('33', '1', '1', '2016-07-01 09:44:28', '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', '/sys/dict/delete', 'GET', 'id=199', '');

-- ----------------------------
-- Table structure for sys_mdict
-- ----------------------------
DROP TABLE IF EXISTS `sys_mdict`;
CREATE TABLE `sys_mdict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(20) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(255) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `sort` int(11) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`),
  KEY `sys_mdict_parent_ids` (`parent_ids`),
  KEY `sys_mdict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of sys_mdict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(20) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(255) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '菜单名称',
  `href` varchar(255) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标（mainFrame、 _blank、_self、_parent、_top）',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `is_show` char(1) NOT NULL COMMENT '是否在菜单中显示（1：显示；0：不显示）',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_parent_ids` (`parent_ids`),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '0,', '顶级菜单', null, null, null, '0', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('2', '1', '0,1,', '系统设置', null, null, null, '900', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('3', '2', '0,1,2,', '系统设置', null, null, null, '980', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('4', '3', '0,1,2,3,', '菜单管理', '/sys/menu/', '', 'menu-management', '30', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-31 08:43:28', null, '0');
INSERT INTO `sys_menu` VALUES ('5', '4', '0,1,2,3,4,', '查看', null, null, null, '30', '0', 'sys:menu:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('6', '4', '0,1,2,3,4,', '修改', null, null, null, '30', '0', 'sys:menu:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('7', '3', '0,1,2,3,', '角色管理', '/sys/role/', '', 'role-management', '50', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-31 08:43:39', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '7', '0,1,2,3,7,', '查看', null, null, null, '30', '0', 'sys:role:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '7', '0,1,2,3,7,', '修改', null, null, null, '30', '0', 'sys:role:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('10', '3', '0,1,2,3,', '字典管理', '/sys/dict/', '', 'dictionary-management', '60', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-31 08:43:54', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '10', '0,1,2,3,10,', '查看', null, null, null, '30', '0', 'sys:dict:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '10', '0,1,2,3,10,', '修改', null, null, null, '30', '0', 'sys:dict:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '2', '0,1,2,', '机构用户', null, null, null, '970', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '13', '0,1,2,13,', '区域管理', '/sys/area/', '', 'regional-management', '50', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-31 08:43:12', null, '0');
INSERT INTO `sys_menu` VALUES ('15', '14', '0,1,2,13,14,', '查看', null, null, null, '30', '0', 'sys:area:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('16', '14', '0,1,2,13,14,', '修改', null, null, null, '30', '0', 'sys:area:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('17', '13', '0,1,2,13,', '机构管理', '/sys/office/', '', 'institution-management', '40', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-31 08:43:01', null, '0');
INSERT INTO `sys_menu` VALUES ('18', '17', '0,1,2,13,17,', '查看', null, null, null, '30', '0', 'sys:office:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('19', '17', '0,1,2,13,17,', '修改', null, null, null, '30', '0', 'sys:office:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '13', '0,1,2,13,', '用户管理', '/sys/user/', '', 'user-management', '30', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-31 08:42:47', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '20', '0,1,2,13,20,', '查看', null, null, null, '30', '0', 'sys:user:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '20', '0,1,2,13,20,', '修改', '', '', '', '30', '0', 'sys:user:edit', '1', '2013-05-27 08:00:00', '1', '2013-11-20 14:52:23', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '0,1,', '主页', '', '', 'schedule', '1', '1', '', '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:27:28', null, '0');
INSERT INTO `sys_menu` VALUES ('28', '27', '0,1,27,', '我的面板', '', '', '', '1', '1', '', '1', '2013-05-27 08:00:00', '1', '2014-02-21 14:21:23', null, '0');
INSERT INTO `sys_menu` VALUES ('29', '28', '0,1,27,28,', '个人信息', '/sys/user/info', '', 'personal-information', '1', '1', '', '1', '2013-05-27 08:00:00', '1', '2014-02-21 14:21:32', null, '0');
INSERT INTO `sys_menu` VALUES ('30', '28', '0,1,27,28,', '修改密码', '/sys/user/modifyPwd', '', 'password', '1', '1', '', '1', '2013-05-27 08:00:00', '1', '2014-02-21 14:21:38', null, '0');
INSERT INTO `sys_menu` VALUES ('31', '1', '0,1,', '内容管理', '', '', '', '500', '0', '', '1', '2013-05-27 08:00:00', '1', '2014-02-24 16:10:30', null, '0');
INSERT INTO `sys_menu` VALUES ('32', '31', '0,1,31,', '栏目设置', null, null, null, '990', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('33', '32', '0,1,31,32,', '栏目管理', '/cms/category/', null, 'align-justify', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('34', '33', '0,1,31,32,33,', '查看', null, null, null, '30', '0', 'cms:category:view', '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('35', '33', '0,1,31,32,33,', '修改', null, null, null, '30', '0', 'cms:category:edit', '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('36', '32', '0,1,31,32,', '站点设置', '/cms/site/', null, 'certificate', '40', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('37', '36', '0,1,31,32,36,', '查看', null, null, null, '30', '0', 'cms:site:view', '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('38', '36', '0,1,31,32,36,', '修改', null, null, null, '30', '0', 'cms:site:edit', '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('39', '32', '0,1,31,32,', '切换站点', '/cms/site/select', null, 'retweet', '50', '1', 'cms:site:select', '1', '2013-05-27 08:00:00', '1', '2013-12-30 17:39:58', null, '0');
INSERT INTO `sys_menu` VALUES ('40', '31', '0,1,31,', '内容管理', null, null, null, '500', '1', 'cms:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('41', '40', '0,1,31,40,', '内容发布', '/cms/', null, 'briefcase', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('42', '41', '0,1,31,40,41,', '文章模型', '/cms/article/', null, 'file', '40', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('43', '42', '0,1,31,40,41,42,', '查看', null, null, null, '30', '0', 'cms:article:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('44', '42', '0,1,31,40,41,42,', '修改', null, null, null, '30', '0', 'cms:article:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('45', '42', '0,1,31,40,41,42,', '审核', null, null, null, '30', '0', 'cms:article:audit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('46', '41', '0,1,31,40,41,', '链接模型', '/cms/link/', null, 'random', '60', '0', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('47', '46', '0,1,31,40,41,46,', '查看', null, null, null, '30', '0', 'cms:link:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('48', '46', '0,1,31,40,41,46,', '修改', null, null, null, '30', '0', 'cms:link:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('49', '46', '0,1,31,40,41,46,', '审核', null, null, null, '30', '0', 'cms:link:audit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('50', '40', '0,1,31,40,', '评论管理', '/cms/comment/?status=2', null, 'comment', '40', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('51', '50', '0,1,31,40,50,', '查看', null, null, null, '30', '0', 'cms:comment:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('52', '50', '0,1,31,40,50,', '审核', null, null, null, '30', '0', 'cms:comment:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('53', '40', '0,1,31,40,', '公共留言', '/cms/guestbook/?status=2', null, 'glass', '80', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('54', '53', '0,1,31,40,53,', '查看', null, null, null, '30', '0', 'cms:guestbook:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('55', '53', '0,1,31,40,53,', '审核', null, null, null, '30', '0', 'cms:guestbook:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('56', '40', '0,1,31,40,', '文件管理', '/../static/ckfinder/ckfinder.html', null, 'folder-open', '90', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('57', '56', '0,1,31,40,56,', '查看', null, null, null, '30', '0', 'cms:ckfinder:view', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('58', '56', '0,1,31,40,56,', '上传', null, null, null, '30', '0', 'cms:ckfinder:upload', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('59', '56', '0,1,31,40,56,', '修改', null, null, null, '30', '0', 'cms:ckfinder:edit', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('60', '31', '0,1,31,', '统计分析', null, null, null, '600', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('61', '60', '0,1,31,60,', '信息量统计', '/cms/stats/article', null, 'tasks', '30', '1', 'cms:stats:article', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('67', '2', '0,1,2,', '日志查询', null, null, null, '985', '1', null, '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_menu` VALUES ('68', '67', '0,1,2,67,', '日志查询', '/sys/log', '', 'query-log', '30', '1', 'sys:log:view', '1', '2013-06-03 08:00:00', '1', '2013-12-30 17:39:59', null, '0');

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(20) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(255) NOT NULL COMMENT '所有父级编号',
  `area_id` bigint(20) NOT NULL COMMENT '归属区域',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) NOT NULL COMMENT '机构名称',
  `type` char(1) NOT NULL COMMENT '机构类型（1：公司；2：部门；3：小组）',
  `grade` char(1) NOT NULL COMMENT '机构等级（1：一级；2：二级；3：三级；4：四级）',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) DEFAULT NULL COMMENT '传真',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_parent_ids` (`parent_ids`),
  KEY `sys_office_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_office
-- ----------------------------
INSERT INTO `sys_office` VALUES ('1', '0', '0,', '2', '', '江苏华大网安科技有限公司', '1', '1', null, null, null, null, null, null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_office` VALUES ('2', '1', '0,1,', '46', '', '事业部', '2', '1', '', '', '', '', '', '', '1', '2014-02-21 14:15:25', '1', '2014-02-21 14:17:18', '', '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `office_id` bigint(20) DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `enname` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) DEFAULT NULL COMMENT '数据范围（0：所有数据；1：所在公司及以下数据；2：所在公司数据；3：所在部门及以下数据；4：所在部门数据；8：仅本人数据；9：按明细设置）',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '2', '系统管理员', 'admin', '系统管理员', '1', '1', '2013-05-27 08:00:00', '1', '2014-02-21 14:19:33', null, '0');
INSERT INTO `sys_role` VALUES ('32', '2', '普通用户', null, null, '1', '1', '2014-02-21 15:05:32', '1', '2014-02-21 15:05:49', null, '0');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色编号',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1');
INSERT INTO `sys_role_menu` VALUES ('1', '2');
INSERT INTO `sys_role_menu` VALUES ('1', '3');
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('1', '5');
INSERT INTO `sys_role_menu` VALUES ('1', '6');
INSERT INTO `sys_role_menu` VALUES ('1', '7');
INSERT INTO `sys_role_menu` VALUES ('1', '8');
INSERT INTO `sys_role_menu` VALUES ('1', '9');
INSERT INTO `sys_role_menu` VALUES ('1', '10');
INSERT INTO `sys_role_menu` VALUES ('1', '11');
INSERT INTO `sys_role_menu` VALUES ('1', '12');
INSERT INTO `sys_role_menu` VALUES ('1', '13');
INSERT INTO `sys_role_menu` VALUES ('1', '14');
INSERT INTO `sys_role_menu` VALUES ('1', '15');
INSERT INTO `sys_role_menu` VALUES ('1', '16');
INSERT INTO `sys_role_menu` VALUES ('1', '17');
INSERT INTO `sys_role_menu` VALUES ('1', '18');
INSERT INTO `sys_role_menu` VALUES ('1', '19');
INSERT INTO `sys_role_menu` VALUES ('1', '20');
INSERT INTO `sys_role_menu` VALUES ('1', '21');
INSERT INTO `sys_role_menu` VALUES ('1', '22');
INSERT INTO `sys_role_menu` VALUES ('1', '27');
INSERT INTO `sys_role_menu` VALUES ('1', '28');
INSERT INTO `sys_role_menu` VALUES ('1', '29');
INSERT INTO `sys_role_menu` VALUES ('1', '30');
INSERT INTO `sys_role_menu` VALUES ('1', '31');
INSERT INTO `sys_role_menu` VALUES ('1', '32');
INSERT INTO `sys_role_menu` VALUES ('1', '33');
INSERT INTO `sys_role_menu` VALUES ('1', '34');
INSERT INTO `sys_role_menu` VALUES ('1', '35');
INSERT INTO `sys_role_menu` VALUES ('1', '36');
INSERT INTO `sys_role_menu` VALUES ('1', '37');
INSERT INTO `sys_role_menu` VALUES ('1', '38');
INSERT INTO `sys_role_menu` VALUES ('1', '39');
INSERT INTO `sys_role_menu` VALUES ('1', '40');
INSERT INTO `sys_role_menu` VALUES ('1', '41');
INSERT INTO `sys_role_menu` VALUES ('1', '42');
INSERT INTO `sys_role_menu` VALUES ('1', '43');
INSERT INTO `sys_role_menu` VALUES ('1', '44');
INSERT INTO `sys_role_menu` VALUES ('1', '45');
INSERT INTO `sys_role_menu` VALUES ('1', '46');
INSERT INTO `sys_role_menu` VALUES ('1', '47');
INSERT INTO `sys_role_menu` VALUES ('1', '48');
INSERT INTO `sys_role_menu` VALUES ('1', '49');
INSERT INTO `sys_role_menu` VALUES ('1', '50');
INSERT INTO `sys_role_menu` VALUES ('1', '51');
INSERT INTO `sys_role_menu` VALUES ('1', '52');
INSERT INTO `sys_role_menu` VALUES ('1', '53');
INSERT INTO `sys_role_menu` VALUES ('1', '54');
INSERT INTO `sys_role_menu` VALUES ('1', '55');
INSERT INTO `sys_role_menu` VALUES ('1', '56');
INSERT INTO `sys_role_menu` VALUES ('1', '57');
INSERT INTO `sys_role_menu` VALUES ('1', '58');
INSERT INTO `sys_role_menu` VALUES ('1', '59');
INSERT INTO `sys_role_menu` VALUES ('1', '60');
INSERT INTO `sys_role_menu` VALUES ('1', '61');
INSERT INTO `sys_role_menu` VALUES ('1', '67');
INSERT INTO `sys_role_menu` VALUES ('1', '68');
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '27');
INSERT INTO `sys_role_menu` VALUES ('2', '28');
INSERT INTO `sys_role_menu` VALUES ('2', '29');
INSERT INTO `sys_role_menu` VALUES ('2', '30');
INSERT INTO `sys_role_menu` VALUES ('2', '69');
INSERT INTO `sys_role_menu` VALUES ('2', '77');
INSERT INTO `sys_role_menu` VALUES ('2', '79');
INSERT INTO `sys_role_menu` VALUES ('2', '83');
INSERT INTO `sys_role_menu` VALUES ('2', '85');
INSERT INTO `sys_role_menu` VALUES ('2', '89');
INSERT INTO `sys_role_menu` VALUES ('2', '91');
INSERT INTO `sys_role_menu` VALUES ('2', '93');
INSERT INTO `sys_role_menu` VALUES ('2', '95');
INSERT INTO `sys_role_menu` VALUES ('2', '97');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '117');
INSERT INTO `sys_role_menu` VALUES ('2', '119');
INSERT INTO `sys_role_menu` VALUES ('2', '129');
INSERT INTO `sys_role_menu` VALUES ('2', '131');
INSERT INTO `sys_role_menu` VALUES ('2', '165');
INSERT INTO `sys_role_menu` VALUES ('2', '167');
INSERT INTO `sys_role_menu` VALUES ('2', '169');
INSERT INTO `sys_role_menu` VALUES ('2', '171');
INSERT INTO `sys_role_menu` VALUES ('2', '175');
INSERT INTO `sys_role_menu` VALUES ('2', '177');
INSERT INTO `sys_role_menu` VALUES ('3', '1');
INSERT INTO `sys_role_menu` VALUES ('3', '27');
INSERT INTO `sys_role_menu` VALUES ('3', '28');
INSERT INTO `sys_role_menu` VALUES ('3', '29');
INSERT INTO `sys_role_menu` VALUES ('3', '30');
INSERT INTO `sys_role_menu` VALUES ('3', '77');
INSERT INTO `sys_role_menu` VALUES ('3', '79');
INSERT INTO `sys_role_menu` VALUES ('3', '85');
INSERT INTO `sys_role_menu` VALUES ('3', '89');
INSERT INTO `sys_role_menu` VALUES ('3', '91');
INSERT INTO `sys_role_menu` VALUES ('3', '93');
INSERT INTO `sys_role_menu` VALUES ('3', '119');
INSERT INTO `sys_role_menu` VALUES ('3', '129');
INSERT INTO `sys_role_menu` VALUES ('3', '133');
INSERT INTO `sys_role_menu` VALUES ('3', '173');
INSERT INTO `sys_role_menu` VALUES ('3', '175');
INSERT INTO `sys_role_menu` VALUES ('3', '177');
INSERT INTO `sys_role_menu` VALUES ('3', '191');
INSERT INTO `sys_role_menu` VALUES ('4', '1');
INSERT INTO `sys_role_menu` VALUES ('4', '27');
INSERT INTO `sys_role_menu` VALUES ('4', '28');
INSERT INTO `sys_role_menu` VALUES ('4', '29');
INSERT INTO `sys_role_menu` VALUES ('4', '30');
INSERT INTO `sys_role_menu` VALUES ('4', '69');
INSERT INTO `sys_role_menu` VALUES ('4', '77');
INSERT INTO `sys_role_menu` VALUES ('4', '79');
INSERT INTO `sys_role_menu` VALUES ('4', '85');
INSERT INTO `sys_role_menu` VALUES ('4', '89');
INSERT INTO `sys_role_menu` VALUES ('4', '91');
INSERT INTO `sys_role_menu` VALUES ('4', '93');
INSERT INTO `sys_role_menu` VALUES ('4', '97');
INSERT INTO `sys_role_menu` VALUES ('4', '99');
INSERT INTO `sys_role_menu` VALUES ('4', '101');
INSERT INTO `sys_role_menu` VALUES ('4', '103');
INSERT INTO `sys_role_menu` VALUES ('4', '105');
INSERT INTO `sys_role_menu` VALUES ('4', '119');
INSERT INTO `sys_role_menu` VALUES ('4', '129');
INSERT INTO `sys_role_menu` VALUES ('4', '131');
INSERT INTO `sys_role_menu` VALUES ('4', '133');
INSERT INTO `sys_role_menu` VALUES ('4', '137');
INSERT INTO `sys_role_menu` VALUES ('4', '139');
INSERT INTO `sys_role_menu` VALUES ('4', '143');
INSERT INTO `sys_role_menu` VALUES ('4', '147');
INSERT INTO `sys_role_menu` VALUES ('4', '161');
INSERT INTO `sys_role_menu` VALUES ('4', '163');
INSERT INTO `sys_role_menu` VALUES ('4', '165');
INSERT INTO `sys_role_menu` VALUES ('4', '167');
INSERT INTO `sys_role_menu` VALUES ('4', '169');
INSERT INTO `sys_role_menu` VALUES ('4', '171');
INSERT INTO `sys_role_menu` VALUES ('4', '173');
INSERT INTO `sys_role_menu` VALUES ('4', '175');
INSERT INTO `sys_role_menu` VALUES ('4', '177');
INSERT INTO `sys_role_menu` VALUES ('4', '189');
INSERT INTO `sys_role_menu` VALUES ('4', '203');
INSERT INTO `sys_role_menu` VALUES ('4', '205');
INSERT INTO `sys_role_menu` VALUES ('4', '207');
INSERT INTO `sys_role_menu` VALUES ('5', '1');
INSERT INTO `sys_role_menu` VALUES ('5', '27');
INSERT INTO `sys_role_menu` VALUES ('5', '28');
INSERT INTO `sys_role_menu` VALUES ('5', '29');
INSERT INTO `sys_role_menu` VALUES ('5', '30');
INSERT INTO `sys_role_menu` VALUES ('5', '69');
INSERT INTO `sys_role_menu` VALUES ('5', '77');
INSERT INTO `sys_role_menu` VALUES ('5', '79');
INSERT INTO `sys_role_menu` VALUES ('5', '85');
INSERT INTO `sys_role_menu` VALUES ('5', '89');
INSERT INTO `sys_role_menu` VALUES ('5', '91');
INSERT INTO `sys_role_menu` VALUES ('5', '93');
INSERT INTO `sys_role_menu` VALUES ('5', '97');
INSERT INTO `sys_role_menu` VALUES ('5', '119');
INSERT INTO `sys_role_menu` VALUES ('5', '129');
INSERT INTO `sys_role_menu` VALUES ('5', '131');
INSERT INTO `sys_role_menu` VALUES ('5', '133');
INSERT INTO `sys_role_menu` VALUES ('5', '161');
INSERT INTO `sys_role_menu` VALUES ('5', '165');
INSERT INTO `sys_role_menu` VALUES ('5', '167');
INSERT INTO `sys_role_menu` VALUES ('5', '169');
INSERT INTO `sys_role_menu` VALUES ('5', '171');
INSERT INTO `sys_role_menu` VALUES ('5', '173');
INSERT INTO `sys_role_menu` VALUES ('5', '175');
INSERT INTO `sys_role_menu` VALUES ('5', '177');
INSERT INTO `sys_role_menu` VALUES ('5', '187');
INSERT INTO `sys_role_menu` VALUES ('6', '1');
INSERT INTO `sys_role_menu` VALUES ('6', '27');
INSERT INTO `sys_role_menu` VALUES ('6', '28');
INSERT INTO `sys_role_menu` VALUES ('6', '29');
INSERT INTO `sys_role_menu` VALUES ('6', '30');
INSERT INTO `sys_role_menu` VALUES ('6', '69');
INSERT INTO `sys_role_menu` VALUES ('6', '77');
INSERT INTO `sys_role_menu` VALUES ('6', '79');
INSERT INTO `sys_role_menu` VALUES ('6', '85');
INSERT INTO `sys_role_menu` VALUES ('6', '89');
INSERT INTO `sys_role_menu` VALUES ('6', '97');
INSERT INTO `sys_role_menu` VALUES ('6', '99');
INSERT INTO `sys_role_menu` VALUES ('6', '101');
INSERT INTO `sys_role_menu` VALUES ('6', '103');
INSERT INTO `sys_role_menu` VALUES ('6', '105');
INSERT INTO `sys_role_menu` VALUES ('6', '119');
INSERT INTO `sys_role_menu` VALUES ('6', '129');
INSERT INTO `sys_role_menu` VALUES ('6', '131');
INSERT INTO `sys_role_menu` VALUES ('6', '137');
INSERT INTO `sys_role_menu` VALUES ('6', '139');
INSERT INTO `sys_role_menu` VALUES ('6', '143');
INSERT INTO `sys_role_menu` VALUES ('6', '147');
INSERT INTO `sys_role_menu` VALUES ('6', '161');
INSERT INTO `sys_role_menu` VALUES ('6', '163');
INSERT INTO `sys_role_menu` VALUES ('6', '165');
INSERT INTO `sys_role_menu` VALUES ('6', '167');
INSERT INTO `sys_role_menu` VALUES ('6', '169');
INSERT INTO `sys_role_menu` VALUES ('6', '171');
INSERT INTO `sys_role_menu` VALUES ('6', '175');
INSERT INTO `sys_role_menu` VALUES ('6', '177');
INSERT INTO `sys_role_menu` VALUES ('6', '203');
INSERT INTO `sys_role_menu` VALUES ('6', '205');
INSERT INTO `sys_role_menu` VALUES ('6', '207');
INSERT INTO `sys_role_menu` VALUES ('6', '213');
INSERT INTO `sys_role_menu` VALUES ('6', '215');
INSERT INTO `sys_role_menu` VALUES ('7', '1');
INSERT INTO `sys_role_menu` VALUES ('7', '2');
INSERT INTO `sys_role_menu` VALUES ('7', '3');
INSERT INTO `sys_role_menu` VALUES ('7', '4');
INSERT INTO `sys_role_menu` VALUES ('7', '5');
INSERT INTO `sys_role_menu` VALUES ('7', '6');
INSERT INTO `sys_role_menu` VALUES ('7', '7');
INSERT INTO `sys_role_menu` VALUES ('7', '8');
INSERT INTO `sys_role_menu` VALUES ('7', '9');
INSERT INTO `sys_role_menu` VALUES ('7', '10');
INSERT INTO `sys_role_menu` VALUES ('7', '11');
INSERT INTO `sys_role_menu` VALUES ('7', '12');
INSERT INTO `sys_role_menu` VALUES ('7', '13');
INSERT INTO `sys_role_menu` VALUES ('7', '14');
INSERT INTO `sys_role_menu` VALUES ('7', '15');
INSERT INTO `sys_role_menu` VALUES ('7', '16');
INSERT INTO `sys_role_menu` VALUES ('7', '17');
INSERT INTO `sys_role_menu` VALUES ('7', '18');
INSERT INTO `sys_role_menu` VALUES ('7', '19');
INSERT INTO `sys_role_menu` VALUES ('7', '20');
INSERT INTO `sys_role_menu` VALUES ('7', '21');
INSERT INTO `sys_role_menu` VALUES ('7', '22');
INSERT INTO `sys_role_menu` VALUES ('7', '23');
INSERT INTO `sys_role_menu` VALUES ('7', '24');
INSERT INTO `sys_role_menu` VALUES ('7', '25');
INSERT INTO `sys_role_menu` VALUES ('7', '26');
INSERT INTO `sys_role_menu` VALUES ('7', '27');
INSERT INTO `sys_role_menu` VALUES ('7', '28');
INSERT INTO `sys_role_menu` VALUES ('7', '29');
INSERT INTO `sys_role_menu` VALUES ('7', '30');
INSERT INTO `sys_role_menu` VALUES ('7', '31');
INSERT INTO `sys_role_menu` VALUES ('7', '32');
INSERT INTO `sys_role_menu` VALUES ('7', '33');
INSERT INTO `sys_role_menu` VALUES ('7', '34');
INSERT INTO `sys_role_menu` VALUES ('7', '35');
INSERT INTO `sys_role_menu` VALUES ('7', '36');
INSERT INTO `sys_role_menu` VALUES ('7', '37');
INSERT INTO `sys_role_menu` VALUES ('7', '38');
INSERT INTO `sys_role_menu` VALUES ('7', '39');
INSERT INTO `sys_role_menu` VALUES ('7', '40');
INSERT INTO `sys_role_menu` VALUES ('7', '41');
INSERT INTO `sys_role_menu` VALUES ('7', '42');
INSERT INTO `sys_role_menu` VALUES ('7', '43');
INSERT INTO `sys_role_menu` VALUES ('7', '44');
INSERT INTO `sys_role_menu` VALUES ('7', '45');
INSERT INTO `sys_role_menu` VALUES ('7', '46');
INSERT INTO `sys_role_menu` VALUES ('7', '47');
INSERT INTO `sys_role_menu` VALUES ('7', '48');
INSERT INTO `sys_role_menu` VALUES ('7', '49');
INSERT INTO `sys_role_menu` VALUES ('7', '50');
INSERT INTO `sys_role_menu` VALUES ('7', '51');
INSERT INTO `sys_role_menu` VALUES ('7', '52');
INSERT INTO `sys_role_menu` VALUES ('7', '53');
INSERT INTO `sys_role_menu` VALUES ('7', '54');
INSERT INTO `sys_role_menu` VALUES ('7', '55');
INSERT INTO `sys_role_menu` VALUES ('7', '56');
INSERT INTO `sys_role_menu` VALUES ('7', '57');
INSERT INTO `sys_role_menu` VALUES ('7', '58');
INSERT INTO `sys_role_menu` VALUES ('7', '59');
INSERT INTO `sys_role_menu` VALUES ('7', '60');
INSERT INTO `sys_role_menu` VALUES ('7', '61');
INSERT INTO `sys_role_menu` VALUES ('7', '62');
INSERT INTO `sys_role_menu` VALUES ('7', '63');
INSERT INTO `sys_role_menu` VALUES ('7', '64');
INSERT INTO `sys_role_menu` VALUES ('7', '65');
INSERT INTO `sys_role_menu` VALUES ('7', '66');
INSERT INTO `sys_role_menu` VALUES ('7', '67');
INSERT INTO `sys_role_menu` VALUES ('7', '68');
INSERT INTO `sys_role_menu` VALUES ('8', '1');
INSERT INTO `sys_role_menu` VALUES ('8', '27');
INSERT INTO `sys_role_menu` VALUES ('8', '28');
INSERT INTO `sys_role_menu` VALUES ('8', '29');
INSERT INTO `sys_role_menu` VALUES ('8', '30');
INSERT INTO `sys_role_menu` VALUES ('8', '77');
INSERT INTO `sys_role_menu` VALUES ('8', '79');
INSERT INTO `sys_role_menu` VALUES ('8', '85');
INSERT INTO `sys_role_menu` VALUES ('8', '89');
INSERT INTO `sys_role_menu` VALUES ('8', '91');
INSERT INTO `sys_role_menu` VALUES ('8', '93');
INSERT INTO `sys_role_menu` VALUES ('8', '119');
INSERT INTO `sys_role_menu` VALUES ('8', '133');
INSERT INTO `sys_role_menu` VALUES ('8', '173');
INSERT INTO `sys_role_menu` VALUES ('8', '175');
INSERT INTO `sys_role_menu` VALUES ('8', '177');
INSERT INTO `sys_role_menu` VALUES ('8', '195');
INSERT INTO `sys_role_menu` VALUES ('9', '1');
INSERT INTO `sys_role_menu` VALUES ('9', '27');
INSERT INTO `sys_role_menu` VALUES ('9', '28');
INSERT INTO `sys_role_menu` VALUES ('9', '29');
INSERT INTO `sys_role_menu` VALUES ('9', '30');
INSERT INTO `sys_role_menu` VALUES ('9', '77');
INSERT INTO `sys_role_menu` VALUES ('9', '79');
INSERT INTO `sys_role_menu` VALUES ('9', '85');
INSERT INTO `sys_role_menu` VALUES ('9', '89');
INSERT INTO `sys_role_menu` VALUES ('9', '91');
INSERT INTO `sys_role_menu` VALUES ('9', '93');
INSERT INTO `sys_role_menu` VALUES ('9', '119');
INSERT INTO `sys_role_menu` VALUES ('9', '133');
INSERT INTO `sys_role_menu` VALUES ('9', '173');
INSERT INTO `sys_role_menu` VALUES ('9', '197');
INSERT INTO `sys_role_menu` VALUES ('11', '1');
INSERT INTO `sys_role_menu` VALUES ('11', '27');
INSERT INTO `sys_role_menu` VALUES ('11', '28');
INSERT INTO `sys_role_menu` VALUES ('11', '29');
INSERT INTO `sys_role_menu` VALUES ('11', '30');
INSERT INTO `sys_role_menu` VALUES ('11', '77');
INSERT INTO `sys_role_menu` VALUES ('11', '79');
INSERT INTO `sys_role_menu` VALUES ('11', '85');
INSERT INTO `sys_role_menu` VALUES ('11', '89');
INSERT INTO `sys_role_menu` VALUES ('11', '91');
INSERT INTO `sys_role_menu` VALUES ('11', '93');
INSERT INTO `sys_role_menu` VALUES ('11', '119');
INSERT INTO `sys_role_menu` VALUES ('11', '133');
INSERT INTO `sys_role_menu` VALUES ('11', '173');
INSERT INTO `sys_role_menu` VALUES ('11', '175');
INSERT INTO `sys_role_menu` VALUES ('11', '177');
INSERT INTO `sys_role_menu` VALUES ('11', '199');
INSERT INTO `sys_role_menu` VALUES ('13', '1');
INSERT INTO `sys_role_menu` VALUES ('13', '27');
INSERT INTO `sys_role_menu` VALUES ('13', '28');
INSERT INTO `sys_role_menu` VALUES ('13', '29');
INSERT INTO `sys_role_menu` VALUES ('13', '30');
INSERT INTO `sys_role_menu` VALUES ('13', '77');
INSERT INTO `sys_role_menu` VALUES ('13', '79');
INSERT INTO `sys_role_menu` VALUES ('13', '85');
INSERT INTO `sys_role_menu` VALUES ('13', '89');
INSERT INTO `sys_role_menu` VALUES ('13', '91');
INSERT INTO `sys_role_menu` VALUES ('13', '93');
INSERT INTO `sys_role_menu` VALUES ('13', '119');
INSERT INTO `sys_role_menu` VALUES ('13', '133');
INSERT INTO `sys_role_menu` VALUES ('13', '173');
INSERT INTO `sys_role_menu` VALUES ('13', '175');
INSERT INTO `sys_role_menu` VALUES ('13', '177');
INSERT INTO `sys_role_menu` VALUES ('13', '201');
INSERT INTO `sys_role_menu` VALUES ('15', '1');
INSERT INTO `sys_role_menu` VALUES ('15', '27');
INSERT INTO `sys_role_menu` VALUES ('15', '28');
INSERT INTO `sys_role_menu` VALUES ('15', '29');
INSERT INTO `sys_role_menu` VALUES ('15', '30');
INSERT INTO `sys_role_menu` VALUES ('15', '83');
INSERT INTO `sys_role_menu` VALUES ('15', '107');
INSERT INTO `sys_role_menu` VALUES ('15', '109');
INSERT INTO `sys_role_menu` VALUES ('15', '111');
INSERT INTO `sys_role_menu` VALUES ('15', '113');
INSERT INTO `sys_role_menu` VALUES ('15', '117');
INSERT INTO `sys_role_menu` VALUES ('15', '119');
INSERT INTO `sys_role_menu` VALUES ('15', '123');
INSERT INTO `sys_role_menu` VALUES ('15', '125');
INSERT INTO `sys_role_menu` VALUES ('15', '175');
INSERT INTO `sys_role_menu` VALUES ('15', '177');
INSERT INTO `sys_role_menu` VALUES ('15', '181');
INSERT INTO `sys_role_menu` VALUES ('15', '183');
INSERT INTO `sys_role_menu` VALUES ('15', '185');
INSERT INTO `sys_role_menu` VALUES ('17', '1');
INSERT INTO `sys_role_menu` VALUES ('17', '2');
INSERT INTO `sys_role_menu` VALUES ('17', '3');
INSERT INTO `sys_role_menu` VALUES ('17', '4');
INSERT INTO `sys_role_menu` VALUES ('17', '5');
INSERT INTO `sys_role_menu` VALUES ('17', '6');
INSERT INTO `sys_role_menu` VALUES ('17', '7');
INSERT INTO `sys_role_menu` VALUES ('17', '8');
INSERT INTO `sys_role_menu` VALUES ('17', '9');
INSERT INTO `sys_role_menu` VALUES ('17', '10');
INSERT INTO `sys_role_menu` VALUES ('17', '11');
INSERT INTO `sys_role_menu` VALUES ('17', '12');
INSERT INTO `sys_role_menu` VALUES ('17', '13');
INSERT INTO `sys_role_menu` VALUES ('17', '14');
INSERT INTO `sys_role_menu` VALUES ('17', '15');
INSERT INTO `sys_role_menu` VALUES ('17', '16');
INSERT INTO `sys_role_menu` VALUES ('17', '17');
INSERT INTO `sys_role_menu` VALUES ('17', '18');
INSERT INTO `sys_role_menu` VALUES ('17', '19');
INSERT INTO `sys_role_menu` VALUES ('17', '20');
INSERT INTO `sys_role_menu` VALUES ('17', '21');
INSERT INTO `sys_role_menu` VALUES ('17', '22');
INSERT INTO `sys_role_menu` VALUES ('17', '27');
INSERT INTO `sys_role_menu` VALUES ('17', '28');
INSERT INTO `sys_role_menu` VALUES ('17', '29');
INSERT INTO `sys_role_menu` VALUES ('17', '30');
INSERT INTO `sys_role_menu` VALUES ('17', '31');
INSERT INTO `sys_role_menu` VALUES ('17', '32');
INSERT INTO `sys_role_menu` VALUES ('17', '33');
INSERT INTO `sys_role_menu` VALUES ('17', '34');
INSERT INTO `sys_role_menu` VALUES ('17', '35');
INSERT INTO `sys_role_menu` VALUES ('17', '36');
INSERT INTO `sys_role_menu` VALUES ('17', '37');
INSERT INTO `sys_role_menu` VALUES ('17', '38');
INSERT INTO `sys_role_menu` VALUES ('17', '39');
INSERT INTO `sys_role_menu` VALUES ('17', '40');
INSERT INTO `sys_role_menu` VALUES ('17', '41');
INSERT INTO `sys_role_menu` VALUES ('17', '42');
INSERT INTO `sys_role_menu` VALUES ('17', '43');
INSERT INTO `sys_role_menu` VALUES ('17', '44');
INSERT INTO `sys_role_menu` VALUES ('17', '45');
INSERT INTO `sys_role_menu` VALUES ('17', '46');
INSERT INTO `sys_role_menu` VALUES ('17', '47');
INSERT INTO `sys_role_menu` VALUES ('17', '48');
INSERT INTO `sys_role_menu` VALUES ('17', '49');
INSERT INTO `sys_role_menu` VALUES ('17', '50');
INSERT INTO `sys_role_menu` VALUES ('17', '51');
INSERT INTO `sys_role_menu` VALUES ('17', '52');
INSERT INTO `sys_role_menu` VALUES ('17', '53');
INSERT INTO `sys_role_menu` VALUES ('17', '54');
INSERT INTO `sys_role_menu` VALUES ('17', '55');
INSERT INTO `sys_role_menu` VALUES ('17', '56');
INSERT INTO `sys_role_menu` VALUES ('17', '57');
INSERT INTO `sys_role_menu` VALUES ('17', '58');
INSERT INTO `sys_role_menu` VALUES ('17', '59');
INSERT INTO `sys_role_menu` VALUES ('17', '60');
INSERT INTO `sys_role_menu` VALUES ('17', '61');
INSERT INTO `sys_role_menu` VALUES ('17', '62');
INSERT INTO `sys_role_menu` VALUES ('17', '63');
INSERT INTO `sys_role_menu` VALUES ('17', '64');
INSERT INTO `sys_role_menu` VALUES ('17', '65');
INSERT INTO `sys_role_menu` VALUES ('17', '66');
INSERT INTO `sys_role_menu` VALUES ('17', '67');
INSERT INTO `sys_role_menu` VALUES ('17', '68');
INSERT INTO `sys_role_menu` VALUES ('17', '69');
INSERT INTO `sys_role_menu` VALUES ('17', '77');
INSERT INTO `sys_role_menu` VALUES ('17', '79');
INSERT INTO `sys_role_menu` VALUES ('17', '83');
INSERT INTO `sys_role_menu` VALUES ('17', '85');
INSERT INTO `sys_role_menu` VALUES ('17', '89');
INSERT INTO `sys_role_menu` VALUES ('17', '91');
INSERT INTO `sys_role_menu` VALUES ('17', '93');
INSERT INTO `sys_role_menu` VALUES ('17', '97');
INSERT INTO `sys_role_menu` VALUES ('17', '99');
INSERT INTO `sys_role_menu` VALUES ('17', '101');
INSERT INTO `sys_role_menu` VALUES ('17', '103');
INSERT INTO `sys_role_menu` VALUES ('17', '105');
INSERT INTO `sys_role_menu` VALUES ('17', '107');
INSERT INTO `sys_role_menu` VALUES ('17', '109');
INSERT INTO `sys_role_menu` VALUES ('17', '111');
INSERT INTO `sys_role_menu` VALUES ('17', '113');
INSERT INTO `sys_role_menu` VALUES ('17', '115');
INSERT INTO `sys_role_menu` VALUES ('17', '117');
INSERT INTO `sys_role_menu` VALUES ('17', '119');
INSERT INTO `sys_role_menu` VALUES ('17', '121');
INSERT INTO `sys_role_menu` VALUES ('17', '123');
INSERT INTO `sys_role_menu` VALUES ('17', '125');
INSERT INTO `sys_role_menu` VALUES ('17', '129');
INSERT INTO `sys_role_menu` VALUES ('17', '131');
INSERT INTO `sys_role_menu` VALUES ('17', '133');
INSERT INTO `sys_role_menu` VALUES ('17', '137');
INSERT INTO `sys_role_menu` VALUES ('17', '139');
INSERT INTO `sys_role_menu` VALUES ('17', '143');
INSERT INTO `sys_role_menu` VALUES ('17', '147');
INSERT INTO `sys_role_menu` VALUES ('17', '161');
INSERT INTO `sys_role_menu` VALUES ('17', '163');
INSERT INTO `sys_role_menu` VALUES ('17', '165');
INSERT INTO `sys_role_menu` VALUES ('17', '167');
INSERT INTO `sys_role_menu` VALUES ('17', '169');
INSERT INTO `sys_role_menu` VALUES ('17', '171');
INSERT INTO `sys_role_menu` VALUES ('17', '173');
INSERT INTO `sys_role_menu` VALUES ('17', '175');
INSERT INTO `sys_role_menu` VALUES ('17', '177');
INSERT INTO `sys_role_menu` VALUES ('17', '181');
INSERT INTO `sys_role_menu` VALUES ('17', '183');
INSERT INTO `sys_role_menu` VALUES ('17', '185');
INSERT INTO `sys_role_menu` VALUES ('17', '187');
INSERT INTO `sys_role_menu` VALUES ('17', '189');
INSERT INTO `sys_role_menu` VALUES ('17', '191');
INSERT INTO `sys_role_menu` VALUES ('17', '193');
INSERT INTO `sys_role_menu` VALUES ('17', '195');
INSERT INTO `sys_role_menu` VALUES ('17', '197');
INSERT INTO `sys_role_menu` VALUES ('17', '199');
INSERT INTO `sys_role_menu` VALUES ('17', '201');
INSERT INTO `sys_role_menu` VALUES ('17', '203');
INSERT INTO `sys_role_menu` VALUES ('19', '1');
INSERT INTO `sys_role_menu` VALUES ('19', '27');
INSERT INTO `sys_role_menu` VALUES ('19', '28');
INSERT INTO `sys_role_menu` VALUES ('19', '29');
INSERT INTO `sys_role_menu` VALUES ('19', '30');
INSERT INTO `sys_role_menu` VALUES ('19', '77');
INSERT INTO `sys_role_menu` VALUES ('19', '91');
INSERT INTO `sys_role_menu` VALUES ('19', '93');
INSERT INTO `sys_role_menu` VALUES ('19', '119');
INSERT INTO `sys_role_menu` VALUES ('19', '133');
INSERT INTO `sys_role_menu` VALUES ('19', '173');
INSERT INTO `sys_role_menu` VALUES ('19', '175');
INSERT INTO `sys_role_menu` VALUES ('19', '177');
INSERT INTO `sys_role_menu` VALUES ('19', '193');
INSERT INTO `sys_role_menu` VALUES ('19', '203');
INSERT INTO `sys_role_menu` VALUES ('19', '205');
INSERT INTO `sys_role_menu` VALUES ('29', '1');
INSERT INTO `sys_role_menu` VALUES ('29', '27');
INSERT INTO `sys_role_menu` VALUES ('29', '28');
INSERT INTO `sys_role_menu` VALUES ('29', '29');
INSERT INTO `sys_role_menu` VALUES ('29', '30');
INSERT INTO `sys_role_menu` VALUES ('29', '69');
INSERT INTO `sys_role_menu` VALUES ('29', '77');
INSERT INTO `sys_role_menu` VALUES ('29', '79');
INSERT INTO `sys_role_menu` VALUES ('29', '85');
INSERT INTO `sys_role_menu` VALUES ('29', '89');
INSERT INTO `sys_role_menu` VALUES ('29', '91');
INSERT INTO `sys_role_menu` VALUES ('29', '93');
INSERT INTO `sys_role_menu` VALUES ('29', '97');
INSERT INTO `sys_role_menu` VALUES ('29', '99');
INSERT INTO `sys_role_menu` VALUES ('29', '101');
INSERT INTO `sys_role_menu` VALUES ('29', '103');
INSERT INTO `sys_role_menu` VALUES ('29', '105');
INSERT INTO `sys_role_menu` VALUES ('29', '119');
INSERT INTO `sys_role_menu` VALUES ('29', '129');
INSERT INTO `sys_role_menu` VALUES ('29', '131');
INSERT INTO `sys_role_menu` VALUES ('29', '133');
INSERT INTO `sys_role_menu` VALUES ('29', '137');
INSERT INTO `sys_role_menu` VALUES ('29', '139');
INSERT INTO `sys_role_menu` VALUES ('29', '143');
INSERT INTO `sys_role_menu` VALUES ('29', '147');
INSERT INTO `sys_role_menu` VALUES ('29', '161');
INSERT INTO `sys_role_menu` VALUES ('29', '163');
INSERT INTO `sys_role_menu` VALUES ('29', '165');
INSERT INTO `sys_role_menu` VALUES ('29', '167');
INSERT INTO `sys_role_menu` VALUES ('29', '169');
INSERT INTO `sys_role_menu` VALUES ('29', '171');
INSERT INTO `sys_role_menu` VALUES ('29', '173');
INSERT INTO `sys_role_menu` VALUES ('29', '175');
INSERT INTO `sys_role_menu` VALUES ('29', '177');
INSERT INTO `sys_role_menu` VALUES ('29', '187');
INSERT INTO `sys_role_menu` VALUES ('29', '189');
INSERT INTO `sys_role_menu` VALUES ('29', '191');
INSERT INTO `sys_role_menu` VALUES ('29', '193');
INSERT INTO `sys_role_menu` VALUES ('29', '195');
INSERT INTO `sys_role_menu` VALUES ('29', '197');
INSERT INTO `sys_role_menu` VALUES ('29', '199');
INSERT INTO `sys_role_menu` VALUES ('29', '201');
INSERT INTO `sys_role_menu` VALUES ('29', '203');
INSERT INTO `sys_role_menu` VALUES ('29', '205');
INSERT INTO `sys_role_menu` VALUES ('31', '1');
INSERT INTO `sys_role_menu` VALUES ('31', '27');
INSERT INTO `sys_role_menu` VALUES ('31', '28');
INSERT INTO `sys_role_menu` VALUES ('31', '29');
INSERT INTO `sys_role_menu` VALUES ('31', '30');
INSERT INTO `sys_role_menu` VALUES ('31', '77');
INSERT INTO `sys_role_menu` VALUES ('31', '79');
INSERT INTO `sys_role_menu` VALUES ('31', '83');
INSERT INTO `sys_role_menu` VALUES ('31', '85');
INSERT INTO `sys_role_menu` VALUES ('31', '89');
INSERT INTO `sys_role_menu` VALUES ('31', '107');
INSERT INTO `sys_role_menu` VALUES ('31', '109');
INSERT INTO `sys_role_menu` VALUES ('31', '111');
INSERT INTO `sys_role_menu` VALUES ('31', '113');
INSERT INTO `sys_role_menu` VALUES ('31', '117');
INSERT INTO `sys_role_menu` VALUES ('31', '119');
INSERT INTO `sys_role_menu` VALUES ('31', '123');
INSERT INTO `sys_role_menu` VALUES ('31', '125');
INSERT INTO `sys_role_menu` VALUES ('31', '129');
INSERT INTO `sys_role_menu` VALUES ('31', '175');
INSERT INTO `sys_role_menu` VALUES ('31', '177');
INSERT INTO `sys_role_menu` VALUES ('31', '181');
INSERT INTO `sys_role_menu` VALUES ('31', '183');
INSERT INTO `sys_role_menu` VALUES ('31', '185');
INSERT INTO `sys_role_menu` VALUES ('31', '209');
INSERT INTO `sys_role_menu` VALUES ('31', '211');
INSERT INTO `sys_role_menu` VALUES ('32', '1');
INSERT INTO `sys_role_menu` VALUES ('32', '27');
INSERT INTO `sys_role_menu` VALUES ('32', '28');
INSERT INTO `sys_role_menu` VALUES ('32', '29');
INSERT INTO `sys_role_menu` VALUES ('32', '30');
INSERT INTO `sys_role_menu` VALUES ('32', '216');
INSERT INTO `sys_role_menu` VALUES ('32', '217');
INSERT INTO `sys_role_menu` VALUES ('32', '218');
INSERT INTO `sys_role_menu` VALUES ('32', '219');
INSERT INTO `sys_role_menu` VALUES ('32', '221');
INSERT INTO `sys_role_menu` VALUES ('32', '222');
INSERT INTO `sys_role_menu` VALUES ('32', '224');
INSERT INTO `sys_role_menu` VALUES ('32', '225');

-- ----------------------------
-- Table structure for sys_role_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_office`;
CREATE TABLE `sys_role_office` (
  `role_id` bigint(20) NOT NULL COMMENT '角色编号',
  `office_id` bigint(20) NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-机构';

-- ----------------------------
-- Records of sys_role_office
-- ----------------------------
INSERT INTO `sys_role_office` VALUES ('2', '4');
INSERT INTO `sys_role_office` VALUES ('2', '29');
INSERT INTO `sys_role_office` VALUES ('2', '31');
INSERT INTO `sys_role_office` VALUES ('7', '7');
INSERT INTO `sys_role_office` VALUES ('7', '8');
INSERT INTO `sys_role_office` VALUES ('7', '9');
INSERT INTO `sys_role_office` VALUES ('7', '10');
INSERT INTO `sys_role_office` VALUES ('7', '11');
INSERT INTO `sys_role_office` VALUES ('7', '12');
INSERT INTO `sys_role_office` VALUES ('7', '13');
INSERT INTO `sys_role_office` VALUES ('7', '14');
INSERT INTO `sys_role_office` VALUES ('7', '15');
INSERT INTO `sys_role_office` VALUES ('7', '16');
INSERT INTO `sys_role_office` VALUES ('7', '17');
INSERT INTO `sys_role_office` VALUES ('7', '18');
INSERT INTO `sys_role_office` VALUES ('7', '19');
INSERT INTO `sys_role_office` VALUES ('7', '20');
INSERT INTO `sys_role_office` VALUES ('7', '21');
INSERT INTO `sys_role_office` VALUES ('7', '22');
INSERT INTO `sys_role_office` VALUES ('7', '23');
INSERT INTO `sys_role_office` VALUES ('7', '24');
INSERT INTO `sys_role_office` VALUES ('7', '25');
INSERT INTO `sys_role_office` VALUES ('7', '26');
INSERT INTO `sys_role_office` VALUES ('17', '2');
INSERT INTO `sys_role_office` VALUES ('17', '4');
INSERT INTO `sys_role_office` VALUES ('17', '5');
INSERT INTO `sys_role_office` VALUES ('17', '27');
INSERT INTO `sys_role_office` VALUES ('17', '29');
INSERT INTO `sys_role_office` VALUES ('17', '31');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `company_id` bigint(20) NOT NULL COMMENT '归属公司',
  `office_id` bigint(20) NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `no` varchar(100) DEFAULT NULL COMMENT '工号',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `user_type` char(1) DEFAULT NULL COMMENT '用户类型',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', '2', 'super', '6dacb34d917a502118bd0717bc849a37e9a00b61553d242f3fd820ae', '', 'super', '', '', '', '1', '0:0:0:0:0:0:0:1', '2016-07-01 09:58:11', '1', '2013-05-27 08:00:00', '1', '2016-07-01 09:40:24', '系统内置管理员', '0');
INSERT INTO `sys_user` VALUES ('2', '1', '2', 'admin', 'f717d0905ddc5ec8fc06b25cbba6dc84be7a3bcd8b71490887979542', '', '系统管理员', '', '', '', '1', '0:0:0:0:0:0:0:1', '2014-06-20 16:41:16', '1', '2013-11-21 09:55:52', '1', '2014-02-25 17:01:18', '', '0');
INSERT INTO `sys_user` VALUES ('3', '1', '2', 'mobis', '627f0ef7133f134ffee05870777ec11f36159fc65515490cd264485a', '', 'mobis', '', '', '', '3', '0:0:0:0:0:0:0:1', '2014-02-24 16:11:23', '1', '2014-02-21 15:06:38', '1', '2014-02-25 17:01:39', '', '1');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户编号',
  `role_id` bigint(20) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '1');
INSERT INTO `sys_user_role` VALUES ('3', '32');
INSERT INTO `sys_user_role` VALUES ('4', '3');
INSERT INTO `sys_user_role` VALUES ('5', '4');
INSERT INTO `sys_user_role` VALUES ('6', '5');
INSERT INTO `sys_user_role` VALUES ('7', '2');
INSERT INTO `sys_user_role` VALUES ('7', '7');
INSERT INTO `sys_user_role` VALUES ('8', '2');
INSERT INTO `sys_user_role` VALUES ('9', '1');
INSERT INTO `sys_user_role` VALUES ('10', '2');
INSERT INTO `sys_user_role` VALUES ('11', '3');
INSERT INTO `sys_user_role` VALUES ('12', '4');
INSERT INTO `sys_user_role` VALUES ('13', '5');
INSERT INTO `sys_user_role` VALUES ('14', '6');
INSERT INTO `sys_user_role` VALUES ('15', '1');
INSERT INTO `sys_user_role` VALUES ('17', '15');
INSERT INTO `sys_user_role` VALUES ('19', '11');
INSERT INTO `sys_user_role` VALUES ('21', '13');
INSERT INTO `sys_user_role` VALUES ('23', '8');
INSERT INTO `sys_user_role` VALUES ('25', '9');
INSERT INTO `sys_user_role` VALUES ('27', '3');
INSERT INTO `sys_user_role` VALUES ('33', '6');
INSERT INTO `sys_user_role` VALUES ('35', '1');
INSERT INTO `sys_user_role` VALUES ('37', '17');
INSERT INTO `sys_user_role` VALUES ('39', '2');
INSERT INTO `sys_user_role` VALUES ('41', '6');
INSERT INTO `sys_user_role` VALUES ('43', '6');
INSERT INTO `sys_user_role` VALUES ('45', '6');
INSERT INTO `sys_user_role` VALUES ('47', '6');
INSERT INTO `sys_user_role` VALUES ('49', '6');
INSERT INTO `sys_user_role` VALUES ('51', '5');
INSERT INTO `sys_user_role` VALUES ('53', '6');
INSERT INTO `sys_user_role` VALUES ('55', '6');
INSERT INTO `sys_user_role` VALUES ('57', '6');
INSERT INTO `sys_user_role` VALUES ('59', '6');
INSERT INTO `sys_user_role` VALUES ('61', '6');
INSERT INTO `sys_user_role` VALUES ('63', '6');
INSERT INTO `sys_user_role` VALUES ('65', '5');
INSERT INTO `sys_user_role` VALUES ('67', '6');
INSERT INTO `sys_user_role` VALUES ('69', '6');
INSERT INTO `sys_user_role` VALUES ('71', '6');
INSERT INTO `sys_user_role` VALUES ('73', '6');
INSERT INTO `sys_user_role` VALUES ('75', '6');
INSERT INTO `sys_user_role` VALUES ('77', '6');
INSERT INTO `sys_user_role` VALUES ('79', '6');
INSERT INTO `sys_user_role` VALUES ('81', '6');
INSERT INTO `sys_user_role` VALUES ('83', '6');
INSERT INTO `sys_user_role` VALUES ('85', '6');
INSERT INTO `sys_user_role` VALUES ('87', '6');
INSERT INTO `sys_user_role` VALUES ('89', '6');
INSERT INTO `sys_user_role` VALUES ('91', '4');
INSERT INTO `sys_user_role` VALUES ('95', '3');
INSERT INTO `sys_user_role` VALUES ('95', '19');
INSERT INTO `sys_user_role` VALUES ('97', '3');
INSERT INTO `sys_user_role` VALUES ('99', '3');
INSERT INTO `sys_user_role` VALUES ('101', '3');
INSERT INTO `sys_user_role` VALUES ('101', '19');
INSERT INTO `sys_user_role` VALUES ('103', '3');
INSERT INTO `sys_user_role` VALUES ('105', '3');
INSERT INTO `sys_user_role` VALUES ('109', '8');
INSERT INTO `sys_user_role` VALUES ('109', '9');
INSERT INTO `sys_user_role` VALUES ('109', '11');
INSERT INTO `sys_user_role` VALUES ('111', '8');
INSERT INTO `sys_user_role` VALUES ('111', '11');
INSERT INTO `sys_user_role` VALUES ('111', '13');
INSERT INTO `sys_user_role` VALUES ('113', '8');
INSERT INTO `sys_user_role` VALUES ('113', '11');
INSERT INTO `sys_user_role` VALUES ('115', '8');
INSERT INTO `sys_user_role` VALUES ('115', '11');
INSERT INTO `sys_user_role` VALUES ('117', '8');
INSERT INTO `sys_user_role` VALUES ('123', '2');
INSERT INTO `sys_user_role` VALUES ('123', '9');
INSERT INTO `sys_user_role` VALUES ('123', '13');
INSERT INTO `sys_user_role` VALUES ('125', '15');
INSERT INTO `sys_user_role` VALUES ('125', '31');
INSERT INTO `sys_user_role` VALUES ('127', '15');
INSERT INTO `sys_user_role` VALUES ('127', '31');
INSERT INTO `sys_user_role` VALUES ('129', '31');
INSERT INTO `sys_user_role` VALUES ('131', '15');
INSERT INTO `sys_user_role` VALUES ('131', '31');
