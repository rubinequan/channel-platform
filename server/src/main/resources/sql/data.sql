/*
 V0.7.0 完整脚本，由于本次升级大量重构，不提供升级脚本，请备份重要数据后升级
 Author: Nifury
 Date: 19/06/2020
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
CREATE TABLE IF NOT EXISTS `cms_article`  (
  `id` int(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `type` tinyint(1) NULL DEFAULT 1 COMMENT '文章类型[1:普通文章,5:帮助中心]',
  `title` varchar(128) NOT NULL COMMENT '标题',
  `summary` varchar(1024) NULL DEFAULT NULL COMMENT '文章摘要',
  `tags` varchar(255) NULL DEFAULT NULL COMMENT '文章标签',
  `content` longtext NULL COMMENT '内容',
  `category` varchar(25) NULL DEFAULT NULL COMMENT '分类',
  `sub_category` varchar(25) NULL DEFAULT NULL COMMENT '二级目录',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `open_count` int(11) NULL DEFAULT 0 COMMENT '点击次数',
  `start_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '生效时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '失效时间',
  `target_link` varchar(255) NULL DEFAULT NULL COMMENT '指向外链',
  `image` varchar(255) NULL DEFAULT NULL COMMENT '文章首图',
  UNIQUE INDEX `idx_title`(`title`)
) ENGINE = InnoDB AUTO_INCREMENT = 337 DEFAULT CHARACTER SET = utf8mb4 COMMENT = 'CMS文章中心' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_captcha`  (
  `uuid` char(36) NOT NULL PRIMARY KEY COMMENT 'uuid',
  `code` varchar(6) NOT NULL COMMENT '验证码',
  `expire_time` datetime(0) NULL DEFAULT NULL COMMENT '过期时间'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COMMENT = '系统验证码' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_config`  (
  `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `param_key` varchar(50) NULL DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) NULL DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
  UNIQUE INDEX `param_key`(`param_key`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'CLOUD_STORAGE_CONFIG_KEY', '{\"type\":3,\"qiniuDomain\":\"\",\"qiniuPrefix\":\"\",\"qiniuAccessKey\":\"\",\"qiniuSecretKey\":\"\",\"qiniuBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunPrefix\":\"\",\"aliyunEndPoint\":\"\",\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudAppId\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qcloudBucketName\":\"\",\"qcloudRegion\":\"ap-guangzhou\"}', 0, '云存储配置信息');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_log`  (
  `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(50) NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) NULL DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) NULL DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NULL DEFAULT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) NULL DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB AUTO_INCREMENT = 324 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_menu`  (
  `menu_id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序'
) ENGINE = InnoDB AUTO_INCREMENT = 123 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, NULL, 0, 'el-icon-s-tools', 5);
INSERT INTO `sys_menu` VALUES (2, 1, '管理员列表', 'sys/user', NULL, 1, 'admin', 1);
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', 'sys/role', NULL, 1, 'role', 2);
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', 'sys/menu', NULL, 1, 'menu', 3);
INSERT INTO `sys_menu` VALUES (6, 0, '频道管理', NULL, NULL, 0, 'el-icon-s-promotion', 1);
INSERT INTO `sys_menu` VALUES (7, 0, '内容管理', '', '', 0, 'el-icon-document-copy', 2);
INSERT INTO `sys_menu` VALUES (9, 0, '日志报表', '', '', 0, 'el-icon-s-order', 4);
INSERT INTO `sys_menu` VALUES (15, 2, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (16, 2, '新增', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (17, 2, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (18, 2, '删除', NULL, 'sys:user:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (19, 3, '查看', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (20, 3, '新增', NULL, 'sys:role:save,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (21, 3, '修改', NULL, 'sys:role:update,sys:menu:list', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (22, 3, '删除', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (23, 4, '查看', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (24, 4, '新增', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (25, 4, '修改', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (26, 4, '删除', NULL, 'sys:menu:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (27, 1, '参数管理', 'sys/config', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', 1, 'config', 6);
INSERT INTO `sys_menu` VALUES (29, 9, '系统日志', 'sys/log', 'sys:log:list', 1, 'log', 7);
INSERT INTO `sys_menu` VALUES (30, 1, '文件上传', 'oss/oss', 'sys:oss:all', 1, 'oss', 6);
INSERT INTO `sys_menu` VALUES (32, 6, '公众号菜单', 'wx/wx-menu', '', 1, 'log', 0);
INSERT INTO `sys_menu` VALUES (33, 6, '素材管理', 'wx/wx-assets', '', 1, '', 0);
INSERT INTO `sys_menu` VALUES (41, 7, '文章管理', 'wx/article', NULL, 1, 'config', 6);
INSERT INTO `sys_menu` VALUES (42, 41, '查看', NULL, 'wx:article:list,wx:article:info', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (43, 41, '新增', NULL, 'wx:article:save', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (44, 41, '修改', NULL, 'wx:article:update', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (45, 41, '删除', NULL, 'wx:article:delete', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (66, 6, '自动回复规则', 'wx/msg-reply-rule', NULL, 1, 'config', 6);
INSERT INTO `sys_menu` VALUES (67, 66, '查看', NULL, 'wx:msgreplyrule:list,wx:msgreplyrule:info', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (68, 66, '新增', NULL, 'wx:msgreplyrule:save', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (69, 66, '修改', NULL, 'wx:msgreplyrule:update', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (70, 66, '删除', NULL, 'wx:msgreplyrule:delete', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (72, 71, '查看', NULL, 'wx:msgtemplate:list,wx:msgtemplate:info', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (73, 71, '新增', NULL, 'wx:msgtemplate:save', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (74, 71, '修改', NULL, 'wx:msgtemplate:update', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (75, 71, '删除', NULL, 'wx:msgtemplate:delete', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (84, 81, '列表', NULL, 'wx:templatemsglog:list', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (85, 81, '删除', NULL, 'wx:templatemsglog:delete', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (99, 32, '更新公众号菜单', '', 'wx:menu:save', 2, '', 0);
INSERT INTO `sys_menu` VALUES (100, 33, '查看', '', 'wx:wxassets:list', 2, '', 0);
INSERT INTO `sys_menu` VALUES (101, 33, '新增修改', '', 'wx:wxassets:save', 2, '', 0);
INSERT INTO `sys_menu` VALUES (108, 6, '粉丝管理', 'wx/wx-user', NULL, 1, 'config', 6);
INSERT INTO `sys_menu` VALUES (109, 108, '查看', NULL, 'wx:wxuser:list,wx:wxuser:info', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (110, 108, '删除', NULL, 'wx:wxuser:delete', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (111, 108, '同步', '', 'wx:wxuser:save', 2, '', 6);
INSERT INTO `sys_menu` VALUES (112, 33, '删除', '', 'wx:wxassets:delete', 2, '', 0);
INSERT INTO `sys_menu` VALUES (113, 6, '公众号消息', 'wx/wx-msg', NULL, 1, '', 6);
INSERT INTO `sys_menu` VALUES (114, 113, '查看', NULL, 'wx:wxmsg:list,wx:wxmsg:info', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (115, 113, '新增', NULL, 'wx:wxmsg:save', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (117, 113, '删除', NULL, 'wx:wxmsg:delete', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (118, 6, '公众号账号', 'wx/wx-account', NULL, 1, 'config', 6);
INSERT INTO `sys_menu` VALUES (119, 118, '查看', NULL, 'wx:wxaccount:list,wx:wxaccount:info', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (120, 118, '新增', NULL, 'wx:wxaccount:save', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (121, 118, '修改', NULL, 'wx:wxaccount:update', 2, NULL, 6);
INSERT INTO `sys_menu` VALUES (122, 118, '删除', NULL, 'wx:wxaccount:delete', 2, NULL, 6);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_oss`  (
  `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `url` varchar(200) NULL DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '文件上传' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_role`  (
  `role_id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `role_name` varchar(100) NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) NULL DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间'
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_role_menu`  (
  `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID'
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_user`  (
  `user_id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(100) NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  UNIQUE INDEX `username`(`username`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'cdac762d0ba79875489f6a8b430fa8b5dfe0cdd81da38b80f02f33328af7fd4a', 'YzcmCZNvbXocrsz9dm8e', 'niefy@qq.com', '16666666666', 1, 1, '2016-11-11 11:11:11');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_user_role`  (
  `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID'
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_user_token`  (
  `user_id` bigint(20) NOT NULL PRIMARY KEY,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime(0) NULL DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  UNIQUE INDEX `token`(`token`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COMMENT = '系统用户Token' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wx_account
-- ----------------------------
CREATE TABLE IF NOT EXISTS `wx_account`  (
  `appid` char(36) NOT NULL PRIMARY KEY COMMENT 'appid',
  `imurl` varchar(1024) NOT NULL COMMENT 'imurl',
  `name` varchar(50) NOT NULL COMMENT '公众号名称',
  `type` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '账号类型',
  `verified` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '认证状态',
  `secret` char(36) NOT NULL COMMENT 'appsecret',
  `token` varchar(36) NULL DEFAULT NULL COMMENT 'token',
  `aes_key` varchar(43) NULL DEFAULT NULL COMMENT 'aesKey'
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COMMENT = '公众号账号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wx_msg
-- ----------------------------
CREATE TABLE IF NOT EXISTS `wx_msg`  (
  `id` bigint(20) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  `appid` char(36) NOT NULL COMMENT 'appid',
  `openid` varchar(36) NOT NULL COMMENT '用户ID',
  `in_out` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '消息方向',
  `msg_type` char(25) NULL DEFAULT NULL COMMENT '消息类型',
  `detail` json NULL COMMENT '消息详情',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  INDEX `idx_appid`(`appid`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wx_msg_reply_rule
-- ----------------------------
DROP TABLE IF EXISTS `wx_msg_reply_rule`;
CREATE TABLE IF NOT EXISTS `wx_msg_reply_rule`  (
  `rule_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `appid` char(36) NULL DEFAULT '' COMMENT 'appid',
  `rule_name` varchar(20) NOT NULL COMMENT '规则名称',
  `match_value` varchar(200) NOT NULL COMMENT '匹配的关键词、事件等',
  `exact_match` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否精确匹配',
  `reply_type` varchar(20) NOT NULL DEFAULT '1' COMMENT '回复消息类型',
  `reply_content` varchar(1024) NOT NULL COMMENT '回复消息内容',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '规则是否有效',
  `desc` varchar(255) NULL DEFAULT NULL COMMENT '备注说明',
  `effect_time_start` time(0) NULL DEFAULT '00:00:00' COMMENT '生效起始时间',
  `effect_time_end` time(0) NULL DEFAULT '23:59:59' COMMENT '生效结束时间',
  `priority` int(3) UNSIGNED NULL DEFAULT 0 COMMENT '规则优先级',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  INDEX `idx_reply_appid`(`appid`)
) ENGINE = InnoDB AUTO_INCREMENT = 36 DEFAULT CHARACTER SET = utf8mb4 COMMENT = '自动回复规则' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wx_msg_reply_rule
-- ----------------------------
INSERT INTO `wx_msg_reply_rule` VALUES (1, '', '关注公众号', 'subscribe', 0, 'text', '你好，欢迎关注！', 1, '关注回复', '00:00:00', '23:59:59', 0, '2020-05-20 15:15:00');
INSERT INTO `wx_msg_reply_rule` VALUES (2, '', '默认回复', 'default_reply', 1, 'text', '您好，感谢您对我们的关注和支持！如果您有问题，请仔细阅读我们的文档（http://docs.wildfirechat.cn)，或者在github上给我们提Issue（https://github.com/wildfirechat），或者在论坛（http://docs.wildfirechat.cn）发帖提问。如果有商务问题，请加我们好友（ID：wildfirechat 或 wfchat）', 1, '没有匹配到回复时的默认回复', '00:00:00', '23:59:59', 0, '2020-05-20 15:15:00');


-- ----------------------------
-- Table structure for wx_user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `wx_user`  (
  `openid` varchar(50) NOT NULL PRIMARY KEY COMMENT 'openid',
  `appid` char(36) NOT NULL COMMENT 'appid',
  `phone` char(11) NULL DEFAULT NULL COMMENT '手机号',
  `nickname` varchar(50) NULL DEFAULT NULL COMMENT '昵称',
  `sex` tinyint(4) NULL DEFAULT NULL COMMENT '性别(0-未知、1-男、2-女)',
  `city` varchar(20) NULL DEFAULT NULL COMMENT '城市',
  `province` varchar(20) NULL DEFAULT NULL COMMENT '省份',
  `headimgurl` varchar(255) NULL DEFAULT NULL COMMENT '头像',
  `subscribe_time` datetime(0) NULL DEFAULT NULL COMMENT '订阅时间',
  `subscribe` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '是否关注',
  `unionid` varchar(50) NULL DEFAULT NULL COMMENT 'unionid',
  `remark` varchar(255) NULL DEFAULT NULL COMMENT '备注',
  `tagid_list` json NULL COMMENT '标签ID列表',
  `subscribe_scene` varchar(50) NULL DEFAULT NULL COMMENT '关注场景',
  `qr_scene_str` varchar(64) NULL DEFAULT NULL COMMENT '扫码场景值',
  INDEX `idx_unionid`(`unionid`),
  INDEX `idx_user_appid`(`appid`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COMMENT = '用户表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
