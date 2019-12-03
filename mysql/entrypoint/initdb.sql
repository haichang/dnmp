CREATE DATABASE IF NOT EXISTS `admin` ;
GRANT ALL ON `admin`.* TO 'tobuser'@'%' ;

CREATE DATABASE IF NOT EXISTS `ts_statistics_sample` ;
GRANT ALL ON `ts_statistics_sample`.* TO 'tobuser'@'%' ;

CREATE DATABASE IF NOT EXISTS `ts_db_log` ;
GRANT ALL ON `ts_db_log`.* TO 'tobuser'@'%' ;

FLUSH PRIVILEGES ;

USE `admin`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `admin_user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `admin_user_phone` char(11) NOT NULL COMMENT '手机号',
  `admin_user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '姓名',
  `admin_user_email` varchar(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `admin_user_fullname` varchar(48) NOT NULL DEFAULT '' COMMENT '企业微信授权登录用户的名称',
  `admin_user_avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '企业微信授权登录用户的头像',
  `admin_user_position` varchar(32) NOT NULL DEFAULT '' COMMENT '企业微信授权登录用户的职位',
  `admin_user_auth_key` varchar(64) NOT NULL DEFAULT '',
  `admin_user_password_hash` varchar(64) NOT NULL DEFAULT '',
  `admin_user_password_reset_token` varchar(64) NOT NULL DEFAULT '',
  `admin_user_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0-正常 1-停用',
  `admin_user_create_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  `admin_user_update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `admin_user_create_by` varchar(16) NOT NULL DEFAULT '' COMMENT '创建人',
  `admin_user_update_by` varchar(16) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`admin_user_id`),
  UNIQUE KEY `admin_user_name_UNIQUE` (`admin_user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='管理后台用户表';

-- ----------------------------
-- Table structure for admin_privilege
-- ----------------------------
DROP TABLE IF EXISTS `admin_privilege`;
CREATE TABLE `admin_privilege` (
  `admin_privilege_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `admin_privilege_admin_resource_id` int(11) NOT NULL DEFAULT '0' COMMENT '资源id',
  `admin_privilege_admin_role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色id',
  `admin_privilege_type` varchar(16) NOT NULL DEFAULT '' COMMENT '权限类型 all-全部 access-访问 manage-管理',
  `admin_privilege_create_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  `admin_privilege_update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `admin_privilege_create_by` varchar(16) NOT NULL DEFAULT '' COMMENT '创建人',
  `admin_privilege_update_by` varchar(16) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`admin_privilege_id`),
  KEY `admin_privilege_resouce_idx` (`admin_privilege_admin_resource_id`),
  KEY `admin_privilege_role_idx` (`admin_privilege_admin_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6079 DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

-- ----------------------------
-- Table structure for admin_resource
-- ----------------------------
DROP TABLE IF EXISTS `admin_resource`;
CREATE TABLE `admin_resource` (
  `admin_resource_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '资源id',
  `admin_resource_parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '资源父id',
  `admin_resource_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '资源类型 0-菜单 1-功能',
  `admin_resource_target` varchar(200) NOT NULL DEFAULT '' COMMENT '语义化索引',
  `admin_resource_data` varchar(1024) NOT NULL DEFAULT '' COMMENT '资源data，json格式',
  `admin_resource_create_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  `admin_resource_update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `admin_resource_create_by` varchar(16) NOT NULL DEFAULT '' COMMENT '创建人',
  `admin_resource_update_by` varchar(16) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`admin_resource_id`),
  KEY `admin_resource_idx1` (`admin_resource_parent_id`),
  KEY `admin_resource_idx2` (`admin_resource_target`(191))
) ENGINE=InnoDB AUTO_INCREMENT=784 DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `admin_role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `admin_role_parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父角色id',
  `admin_role_name` varchar(16) NOT NULL DEFAULT '' COMMENT '角色名称',
  `admin_role_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '角色描述',
  `admin_role_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0-正常 1-停用',
  `admin_role_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型 0-成员角色member 1-群组角色group',
  `admin_role_create_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  `admin_role_update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `admin_role_create_by` varchar(16) NOT NULL DEFAULT '' COMMENT '创建人',
  `admin_role_update_by` varchar(16) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`admin_role_id`),
  UNIQUE KEY `admin_role_name_UNIQUE` (`admin_role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COMMENT='后台角色表';

-- ----------------------------
-- Table structure for admin_role_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_user`;
CREATE TABLE `admin_role_user` (
  `admin_role_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_role_user_admin_role_id` int(11) NOT NULL COMMENT '角色id',
  `admin_role_user_admin_user_id` int(11) NOT NULL COMMENT '用户id',
  `admin_role_use_create_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `admin_role_use_update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `admin_role_use_create_by` varchar(16) NOT NULL DEFAULT '',
  `admin_role_use_update_by` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`admin_role_user_id`),
  KEY `admin_role_user_idx1_idx` (`admin_role_user_admin_role_id`),
  KEY `admin_role_user_idx2_idx` (`admin_role_user_admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COMMENT='角色用户关联表';

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `attachment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `attachment_relation_attachment_id` int(11) NOT NULL,
  `attachment_name` varchar(64) NOT NULL DEFAULT '' COMMENT '附件名称',
  `attachment_sha` varchar(100) NOT NULL DEFAULT '' COMMENT '签名，附件签名',
  `attachment_url` varchar(512) NOT NULL DEFAULT '' COMMENT '访问URL',
  `attachment_path` varchar(255) NOT NULL DEFAULT '' COMMENT '云存储路径',
  `attachment_create_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '创建时间',
  `attachment_update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新',
  `attachment_quality` int(11) NOT NULL DEFAULT '0' COMMENT '附件图片质量',
  PRIMARY KEY (`attachment_id`),
  KEY `fk_attachment_individual_attachment1_idx` (`attachment_relation_attachment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用于管理系统的上传附件的表';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES (1, '17712345678', '超级管理员', 'report@techsight.cn', '', '', '', '', '$2y$13$zlAFDCO0oXtHrsgZ5IaIUO5xhkVQspEB0sh.gKBpKYUxO05aGFIRC', '', 0, '1000-01-01 00:00:00', '2019-04-17 16:36:06', '', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
