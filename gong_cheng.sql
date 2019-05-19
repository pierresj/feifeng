/*
 Navicat Premium Data Transfer

 Source Server         : Work
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : gong_cheng

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 23/09/2018 16:57:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gc_admin
-- ----------------------------
DROP TABLE IF EXISTS `gc_admin`;
CREATE TABLE `gc_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_admin
-- ----------------------------
INSERT INTO `gc_admin` VALUES (1, 'admin', 'Admin', 'a4429bcc086e996bf7e7316639252c92', 'c9ae59', '/assets/img/avatar.png', 'admin@admin.com', 0, 1536671514, 1492186163, 1536671514, '6a7fe47e-1cd0-4f0e-8d9e-5a1473bfde50', 'normal');
INSERT INTO `gc_admin` VALUES (2, 'admin2', 'admin2', '9a28ce07ce875fbd14172a9ca5357d3c', '2dHDmj', '/assets/img/avatar.png', 'admin2@fastadmin.net', 0, 1505450906, 1492186163, 1505450906, 'df45fdd5-26f4-45ca-83b3-47e4491a315a', 'normal');
INSERT INTO `gc_admin` VALUES (3, 'admin3', 'admin3', '1c11f945dfcd808a130a8c2a8753fe62', 'WOKJEn', '/assets/img/avatar.png', 'admin3@fastadmin.net', 0, 1501980868, 1492186201, 1501982377, '', 'normal');
INSERT INTO `gc_admin` VALUES (4, 'admin22', 'admin22', '1c1a0aa0c3c56a8c1a908aab94519648', 'Aybcn5', '/assets/img/avatar.png', 'admin22@fastadmin.net', 0, 0, 1492186240, 1492186240, '', 'normal');
INSERT INTO `gc_admin` VALUES (5, 'admin32', 'admin32', 'ade94d5d7a7033afa7d84ac3066d0a02', 'FvYK0u', '/assets/img/avatar.png', 'admin32@fastadmin.net', 0, 0, 1492186263, 1492186263, '', 'normal');

-- ----------------------------
-- Table structure for gc_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `gc_admin_log`;
CREATE TABLE `gc_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_admin_log
-- ----------------------------
INSERT INTO `gc_admin_log` VALUES (1, 1, 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"a41c7c4a7271967d2d54277e701fbf8a\",\"username\":\"admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144493);
INSERT INTO `gc_admin_log` VALUES (2, 1, 'admin', '/admin/addon/install', '插件管理 安装', '{\"name\":\"database\",\"faversion\":\"1.0.0.20180806_beta\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144510);
INSERT INTO `gc_admin_log` VALUES (3, 1, 'admin', '/admin/addon/install', '插件管理 安装', '{\"name\":\"command\",\"faversion\":\"1.0.0.20180806_beta\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144511);
INSERT INTO `gc_admin_log` VALUES (4, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144512);
INSERT INTO `gc_admin_log` VALUES (5, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144512);
INSERT INTO `gc_admin_log` VALUES (6, 1, 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"categorytype\":\"{\\\"default\\\":\\\"Default\\\",\\\"page\\\":\\\"Page\\\",\\\"article\\\":\\\"Article\\\",\\\"test\\\":\\\"Test\\\"}\",\"configgroup\":\"{\\\"basic\\\":\\\"Basic\\\",\\\"email\\\":\\\"Email\\\",\\\"dictionary\\\":\\\"Dictionary\\\",\\\"user\\\":\\\"User\\\"}\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144630);
INSERT INTO `gc_admin_log` VALUES (7, 1, 'admin', '/admin/addon/install', '插件管理 安装', '{\"name\":\"alisms\",\"force\":\"0\",\"uid\":\"0\",\"token\":\"\",\"version\":\"1.0.2\",\"faversion\":\"1.0.0.20180806_beta\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144662);
INSERT INTO `gc_admin_log` VALUES (8, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144662);
INSERT INTO `gc_admin_log` VALUES (9, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536144880);
INSERT INTO `gc_admin_log` VALUES (10, 1, 'admin', '/admin/auth/rule/multi/ids/3', '', '{\"action\":\"\",\"ids\":\"3\",\"params\":\"ismenu=0\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145095);
INSERT INTO `gc_admin_log` VALUES (11, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145095);
INSERT INTO `gc_admin_log` VALUES (12, 1, 'admin', '/admin/auth/rule/multi/ids/73', '', '{\"action\":\"\",\"ids\":\"73\",\"params\":\"ismenu=0\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145111);
INSERT INTO `gc_admin_log` VALUES (13, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145111);
INSERT INTO `gc_admin_log` VALUES (14, 1, 'admin', '/admin/auth/rule/multi/ids/79', '', '{\"action\":\"\",\"ids\":\"79\",\"params\":\"ismenu=0\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145113);
INSERT INTO `gc_admin_log` VALUES (15, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145113);
INSERT INTO `gc_admin_log` VALUES (16, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145133);
INSERT INTO `gc_admin_log` VALUES (17, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145142);
INSERT INTO `gc_admin_log` VALUES (18, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145146);
INSERT INTO `gc_admin_log` VALUES (19, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145148);
INSERT INTO `gc_admin_log` VALUES (20, 1, 'admin', '/admin/general/config/check', '', '{\"row\":{\"name\":\"contact_phone\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145281);
INSERT INTO `gc_admin_log` VALUES (21, 1, 'admin', '/admin/general.config/add', '常规管理 系统配置 添加', '{\"row\":{\"type\":\"text\",\"group\":\"basic\",\"name\":\"contact_phone\",\"title\":\"\\u8054\\u7cfb\\u7535\\u8bdd\",\"value\":\"\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"\",\"rule\":\"\",\"extend\":\"\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145290);
INSERT INTO `gc_admin_log` VALUES (22, 1, 'admin', '/admin/general/config/check', '', '{\"row\":{\"name\":\"reference_img\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145378);
INSERT INTO `gc_admin_log` VALUES (23, 1, 'admin', '/admin/general.config/add', '常规管理 系统配置 添加', '{\"row\":{\"type\":\"image\",\"group\":\"basic\",\"name\":\"reference_img\",\"title\":\"\\u53c2\\u8003\\u62a5\\u4ef7\\u56fe\\u7247\",\"value\":\"\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"\",\"rule\":\"\",\"extend\":\"\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536145381);
INSERT INTO `gc_admin_log` VALUES (24, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536146022);
INSERT INTO `gc_admin_log` VALUES (25, 1, 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"ded4e6c2f620acd2c4670523a75b7264\",\"username\":\"admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239556);
INSERT INTO `gc_admin_log` VALUES (26, 1, 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"categorytype\":\"{\\\"default\\\":\\\"Default\\\",\\\"page\\\":\\\"Page\\\",\\\"article\\\":\\\"Article\\\",\\\"test\\\":\\\"Test\\\"}\",\"configgroup\":\"{\\\"basic\\\":\\\"Basic\\\",\\\"email\\\":\\\"Email\\\",\\\"dictionary\\\":\\\"Dictionary\\\",\\\"user\\\":\\\"User\\\",\\\"weapp\\\":\\\"\\u5c0f\\u7a0b\\u5e8f\\u76f8\\u5173\\\"}\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239696);
INSERT INTO `gc_admin_log` VALUES (27, 1, 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"categorytype\":\"{\\\"default\\\":\\\"Default\\\",\\\"page\\\":\\\"Page\\\",\\\"article\\\":\\\"Article\\\",\\\"test\\\":\\\"Test\\\"}\",\"configgroup\":\"{\\\"basic\\\":\\\"Basic\\\",\\\"email\\\":\\\"Email\\\",\\\"dictionary\\\":\\\"Dictionary\\\",\\\"weapp\\\":\\\"\\u5c0f\\u7a0b\\u5e8f\\u76f8\\u5173\\\"}\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239714);
INSERT INTO `gc_admin_log` VALUES (28, 1, 'admin', '/admin/general/config/check', '', '{\"row\":{\"name\":\"banner\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239789);
INSERT INTO `gc_admin_log` VALUES (29, 1, 'admin', '/admin/general.config/add', '常规管理 系统配置 添加', '{\"row\":{\"type\":\"image\",\"group\":\"weapp\",\"name\":\"banner\",\"title\":\"\\u9996\\u9875banner\\u56fe\",\"value\":\"\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"\",\"rule\":\"\",\"extend\":\"\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239798);
INSERT INTO `gc_admin_log` VALUES (30, 1, 'admin', '/admin/general/config/check', '', '{\"row\":{\"name\":\"small_banner_01\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239825);
INSERT INTO `gc_admin_log` VALUES (31, 1, 'admin', '/admin/general.config/add', '常规管理 系统配置 添加', '{\"row\":{\"type\":\"image\",\"group\":\"weapp\",\"name\":\"small_banner_01\",\"title\":\"\\u9996\\u9875banner\\u4e0b\\u65b9\\u5c0f\\u56fe(\\u5de6)\",\"value\":\"\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"\",\"rule\":\"\",\"extend\":\"\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239827);
INSERT INTO `gc_admin_log` VALUES (32, 1, 'admin', '/admin/general/config/check', '', '{\"row\":{\"name\":\"small_banner_02\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239830);
INSERT INTO `gc_admin_log` VALUES (33, 1, 'admin', '/admin/general.config/add', '常规管理 系统配置 添加', '{\"row\":{\"type\":\"image\",\"group\":\"weapp\",\"name\":\"small_banner_02\",\"title\":\"\\u9996\\u9875banner\\u4e0b\\u65b9\\u5c0f\\u56fe(\\u4e2d)\",\"value\":\"\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"\",\"rule\":\"\",\"extend\":\"\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239836);
INSERT INTO `gc_admin_log` VALUES (34, 1, 'admin', '/admin/general/config/check', '', '{\"row\":{\"name\":\"small_banner_03\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239838);
INSERT INTO `gc_admin_log` VALUES (35, 1, 'admin', '/admin/general.config/add', '常规管理 系统配置 添加', '{\"row\":{\"type\":\"image\",\"group\":\"weapp\",\"name\":\"small_banner_03\",\"title\":\"\\u9996\\u9875banner\\u4e0b\\u65b9\\u5c0f\\u56fe(\\u53f3)\",\"value\":\"\",\"content\":\"value1|title1\\r\\nvalue2|title2\",\"tip\":\"\",\"rule\":\"\",\"extend\":\"\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239843);
INSERT INTO `gc_admin_log` VALUES (36, 1, 'admin', '/admin/ajax/upload', '', '{\"name\":\"banner.jpg\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239869);
INSERT INTO `gc_admin_log` VALUES (37, 1, 'admin', '/admin/ajax/upload', '', '{\"name\":\"small_banner_01.png\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239887);
INSERT INTO `gc_admin_log` VALUES (38, 1, 'admin', '/admin/ajax/upload', '', '{\"name\":\"small_banner_02.png\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239890);
INSERT INTO `gc_admin_log` VALUES (39, 1, 'admin', '/admin/ajax/upload', '', '{\"name\":\"small_banner_03.png\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239893);
INSERT INTO `gc_admin_log` VALUES (40, 1, 'admin', '/admin/ajax/upload', '', '{\"name\":\"timg.jpg\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239911);
INSERT INTO `gc_admin_log` VALUES (41, 1, 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"contact_phone\":\"13000000000\",\"can_kao_bao_jia\":\"\\/uploads\\/20180906\\/169b98d4dea58d10f7e3c1dbbb0c42be.jpg\",\"banner\":\"\\/uploads\\/20180906\\/6e5bb31f91f25d461a47d3c6d71c65be.jpg\",\"small_banner_01\":\"\\/uploads\\/20180906\\/6b1a49da7c95fe39cb7b29b1310158fe.png\",\"small_banner_02\":\"\\/uploads\\/20180906\\/fe7c92b38729e1fc07ab250616718983.png\",\"small_banner_03\":\"\\/uploads\\/20180906\\/2dcd03b6b52d5c77cc878babf22fb8cc.png\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536239915);
INSERT INTO `gc_admin_log` VALUES (42, 1, 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"57d0aa0df268f0ebffe17b1ca978fea9\",\"username\":\"admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248485);
INSERT INTO `gc_admin_log` VALUES (43, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248493);
INSERT INTO `gc_admin_log` VALUES (44, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248523);
INSERT INTO `gc_admin_log` VALUES (45, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"menu\":\"1\",\"table\":\"gc_experience\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248559);
INSERT INTO `gc_admin_log` VALUES (46, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"menu\":\"1\",\"table\":\"gc_experience\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248566);
INSERT INTO `gc_admin_log` VALUES (47, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248566);
INSERT INTO `gc_admin_log` VALUES (48, 1, 'admin', '/admin/command/execute/ids/1', '在线命令管理 运行', '{\"ids\":\"1\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248646);
INSERT INTO `gc_admin_log` VALUES (49, 1, 'admin', '/admin/command/del/ids/1', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"1\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248658);
INSERT INTO `gc_admin_log` VALUES (50, 1, 'admin', '/admin/command/del/ids/2', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"2\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248660);
INSERT INTO `gc_admin_log` VALUES (51, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248687);
INSERT INTO `gc_admin_log` VALUES (52, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248692);
INSERT INTO `gc_admin_log` VALUES (53, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"menu\":\"1\",\"table\":\"gc_experience\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248696);
INSERT INTO `gc_admin_log` VALUES (54, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"menu\":\"1\",\"table\":\"gc_experience\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248698);
INSERT INTO `gc_admin_log` VALUES (55, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248698);
INSERT INTO `gc_admin_log` VALUES (56, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"crud\",\"isrelation\":\"0\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"menu\":\"1\",\"table\":\"gc_experience\",\"controller\":\"\",\"model\":\"\",\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248722);
INSERT INTO `gc_admin_log` VALUES (57, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248722);
INSERT INTO `gc_admin_log` VALUES (58, 1, 'admin', '/admin/command/execute/ids/3', '在线命令管理 运行', '{\"ids\":\"3\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248791);
INSERT INTO `gc_admin_log` VALUES (59, 1, 'admin', '/admin/command/execute/ids/3', '在线命令管理 运行', '{\"ids\":\"3\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248841);
INSERT INTO `gc_admin_log` VALUES (60, 1, 'admin', '/admin/command/del/ids/5', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"5\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248845);
INSERT INTO `gc_admin_log` VALUES (61, 1, 'admin', '/admin/command/del/ids/4', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"4\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248847);
INSERT INTO `gc_admin_log` VALUES (62, 1, 'admin', '/admin/command/del/ids/3', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"3\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248849);
INSERT INTO `gc_admin_log` VALUES (63, 1, 'admin', '/admin/auth/rule/add?dialog=1', '权限管理 菜单规则 添加', '{\"dialog\":\"1\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"Experience\",\"title\":\"\\u7ecf\\u9a8c\\u7c7b\\u578b\\u7ba1\\u7406\",\"icon\":\"fa fa-circle-o\",\"weigh\":\"0\",\"condition\":\"\",\"remark\":\"\",\"status\":\"normal\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248941);
INSERT INTO `gc_admin_log` VALUES (64, 1, 'admin', '/admin/auth/rule/add?dialog=1', '权限管理 菜单规则 添加', '{\"dialog\":\"1\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"experience\",\"title\":\"\\u7ecf\\u9a8c\\u7c7b\\u578b\\u7ba1\\u7406\",\"icon\":\"fa fa-circle-o\",\"weigh\":\"0\",\"condition\":\"\",\"remark\":\"\",\"status\":\"normal\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248947);
INSERT INTO `gc_admin_log` VALUES (65, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536248948);
INSERT INTO `gc_admin_log` VALUES (66, 1, 'admin', '/admin/experience/add?dialog=1', '', '{\"dialog\":\"1\",\"row\":{\"experience\":\"\\u7ecf\\u9a8c\\u7c7b\\u578b\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249263);
INSERT INTO `gc_admin_log` VALUES (67, 1, 'admin', '/admin/experience/add?dialog=1', '', '{\"dialog\":\"1\",\"row\":{\"experience\":\"\\u7ecf\\u9a8c\\u7c7b\\u578b1\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249267);
INSERT INTO `gc_admin_log` VALUES (68, 1, 'admin', '/admin/experience/add?dialog=1', '', '{\"dialog\":\"1\",\"row\":{\"experience\":\"\\u7ecf\\u9a8c\\u7c7b\\u578b2\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249272);
INSERT INTO `gc_admin_log` VALUES (69, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249363);
INSERT INTO `gc_admin_log` VALUES (70, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249379);
INSERT INTO `gc_admin_log` VALUES (71, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249385);
INSERT INTO `gc_admin_log` VALUES (72, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249390);
INSERT INTO `gc_admin_log` VALUES (73, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_team\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249439);
INSERT INTO `gc_admin_log` VALUES (74, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249455);
INSERT INTO `gc_admin_log` VALUES (75, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249455);
INSERT INTO `gc_admin_log` VALUES (76, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249455);
INSERT INTO `gc_admin_log` VALUES (77, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249455);
INSERT INTO `gc_admin_log` VALUES (78, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249459);
INSERT INTO `gc_admin_log` VALUES (79, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249459);
INSERT INTO `gc_admin_log` VALUES (80, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"1\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"1\",\"menu\":\"1\",\"table\":\"gc_team\",\"controller\":\"\",\"model\":\"\",\"fields\":[\"leader_name\",\"phone\",\"member_num\",\"experience_id\",\"member_num_with_card\",\"is_insurance\",\"experience_desc\",\"avatar\",\"id_card_img\",\"province\",\"city\",\"district\"],\"relation\":{\"2\":{\"relation\":\"gc_experience\",\"relationmode\":\"belongsto\",\"relationforeignkey\":\"experience_id\",\"relationprimarykey\":\"id\",\"relationfields\":[\"id\",\"experience\"]}},\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249525);
INSERT INTO `gc_admin_log` VALUES (81, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"crud\",\"isrelation\":\"1\",\"local\":\"0\",\"delete\":\"0\",\"force\":\"1\",\"menu\":\"1\",\"table\":\"gc_team\",\"controller\":\"\",\"model\":\"\",\"fields\":[\"leader_name\",\"phone\",\"member_num\",\"experience_id\",\"member_num_with_card\",\"is_insurance\",\"experience_desc\",\"avatar\",\"id_card_img\",\"province\",\"city\",\"district\"],\"relation\":{\"2\":{\"relation\":\"gc_experience\",\"relationmode\":\"belongsto\",\"relationforeignkey\":\"experience_id\",\"relationprimarykey\":\"id\",\"relationfields\":[\"id\",\"experience\"]}},\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249531);
INSERT INTO `gc_admin_log` VALUES (82, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249531);
INSERT INTO `gc_admin_log` VALUES (83, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249866);
INSERT INTO `gc_admin_log` VALUES (84, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249872);
INSERT INTO `gc_admin_log` VALUES (85, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249876);
INSERT INTO `gc_admin_log` VALUES (86, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249879);
INSERT INTO `gc_admin_log` VALUES (87, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249882);
INSERT INTO `gc_admin_log` VALUES (88, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249889);
INSERT INTO `gc_admin_log` VALUES (89, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249892);
INSERT INTO `gc_admin_log` VALUES (90, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"1\",\"controllerfile_text\":\"\",\"controllerfile\":\"Team.php,Experience.php\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249899);
INSERT INTO `gc_admin_log` VALUES (91, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"1\",\"controllerfile_text\":\"\",\"controllerfile\":\"Team.php,Experience.php\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249904);
INSERT INTO `gc_admin_log` VALUES (92, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536249904);
INSERT INTO `gc_admin_log` VALUES (93, 1, 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"5e3116882eb11f4dc95ff609bb5f6e61\",\"username\":\"admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250577);
INSERT INTO `gc_admin_log` VALUES (94, 1, 'admin', '/admin/auth/rule/del/ids/98', '权限管理 菜单规则 删除', '{\"action\":\"del\",\"ids\":\"98\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250599);
INSERT INTO `gc_admin_log` VALUES (95, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250599);
INSERT INTO `gc_admin_log` VALUES (96, 1, 'admin', '/admin/command/del/ids/6', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"6\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250632);
INSERT INTO `gc_admin_log` VALUES (97, 1, 'admin', '/admin/command/del/ids/7', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"7\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250634);
INSERT INTO `gc_admin_log` VALUES (98, 1, 'admin', '/admin/command/del/ids/8', '在线命令管理 删除', '{\"action\":\"del\",\"ids\":\"8\",\"params\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250635);
INSERT INTO `gc_admin_log` VALUES (99, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250637);
INSERT INTO `gc_admin_log` VALUES (100, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin_log\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250648);
INSERT INTO `gc_admin_log` VALUES (101, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin_log\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250648);
INSERT INTO `gc_admin_log` VALUES (102, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin_log\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250648);
INSERT INTO `gc_admin_log` VALUES (103, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin_log\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250648);
INSERT INTO `gc_admin_log` VALUES (104, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250652);
INSERT INTO `gc_admin_log` VALUES (105, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250652);
INSERT INTO `gc_admin_log` VALUES (106, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_team\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250673);
INSERT INTO `gc_admin_log` VALUES (107, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250676);
INSERT INTO `gc_admin_log` VALUES (108, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250676);
INSERT INTO `gc_admin_log` VALUES (109, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250676);
INSERT INTO `gc_admin_log` VALUES (110, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250676);
INSERT INTO `gc_admin_log` VALUES (111, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250682);
INSERT INTO `gc_admin_log` VALUES (112, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_experience\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250682);
INSERT INTO `gc_admin_log` VALUES (113, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"1\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"0\",\"menu\":\"0\",\"table\":\"gc_team\",\"controller\":\"\",\"model\":\"\",\"fields\":[\"leader_name\",\"phone\",\"member_num\",\"experience_id\",\"member_num_with_card\",\"is_insurance\",\"experience_desc\",\"avatar\",\"id_card_image\",\"province\",\"city\",\"district\",\"create_time\",\"update_time\"],\"relation\":{\"3\":{\"relation\":\"gc_experience\",\"relationmode\":\"belongsto\",\"relationforeignkey\":\"experience_id\",\"relationprimarykey\":\"id\",\"relationfields\":[\"id\",\"experience\"]}},\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"abbcc\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250752);
INSERT INTO `gc_admin_log` VALUES (114, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"crud\",\"isrelation\":\"1\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"1\",\"menu\":\"0\",\"table\":\"gc_team\",\"controller\":\"\",\"model\":\"\",\"fields\":[\"leader_name\",\"phone\",\"member_num\",\"experience_id\",\"member_num_with_card\",\"is_insurance\",\"experience_desc\",\"avatar\",\"id_card_image\",\"province\",\"city\",\"district\",\"create_time\",\"update_time\"],\"relation\":{\"3\":{\"relation\":\"gc_experience\",\"relationmode\":\"belongsto\",\"relationforeignkey\":\"experience_id\",\"relationprimarykey\":\"id\",\"relationfields\":[\"id\",\"experience\"]}},\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"abbcc\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250758);
INSERT INTO `gc_admin_log` VALUES (115, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"crud\",\"isrelation\":\"1\",\"local\":\"1\",\"delete\":\"0\",\"force\":\"1\",\"menu\":\"0\",\"table\":\"gc_team\",\"controller\":\"\",\"model\":\"\",\"fields\":[\"leader_name\",\"phone\",\"member_num\",\"experience_id\",\"member_num_with_card\",\"is_insurance\",\"experience_desc\",\"avatar\",\"id_card_image\",\"province\",\"city\",\"district\",\"create_time\",\"update_time\"],\"relation\":{\"3\":{\"relation\":\"gc_experience\",\"relationmode\":\"belongsto\",\"relationforeignkey\":\"experience_id\",\"relationprimarykey\":\"id\",\"relationfields\":[\"id\",\"experience\"]}},\"setcheckboxsuffix\":\"\",\"enumradiosuffix\":\"\",\"imagefield\":\"\",\"filefield\":\"\",\"intdatesuffix\":\"\",\"switchsuffix\":\"\",\"citysuffix\":\"abbcc\",\"selectpagesuffix\":\"\",\"selectpagessuffix\":\"\",\"ignorefields\":\"\",\"sortfield\":\"\",\"editorsuffix\":\"\",\"headingfilterfield\":\"\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250828);
INSERT INTO `gc_admin_log` VALUES (116, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250828);
INSERT INTO `gc_admin_log` VALUES (117, 1, 'admin', '/admin/command/get_field_list', '', '{\"table\":\"gc_admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250838);
INSERT INTO `gc_admin_log` VALUES (118, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"1\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250849);
INSERT INTO `gc_admin_log` VALUES (119, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250852);
INSERT INTO `gc_admin_log` VALUES (120, 1, 'admin', '/admin/command/get_controller_list', '', '{\"q_word\":[\"\"],\"pageNumber\":\"2\",\"pageSize\":\"10\",\"andOr\":\"AND\",\"orderBy\":[[\"name\",\"ASC\"]],\"searchTable\":\"tbl\",\"showField\":\"name\",\"keyField\":\"id\",\"searchField\":[\"name\"],\"name\":\"\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250853);
INSERT INTO `gc_admin_log` VALUES (121, 1, 'admin', '/admin/command/command/action/command', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"Team.php\",\"action\":\"command\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250856);
INSERT INTO `gc_admin_log` VALUES (122, 1, 'admin', '/admin/command/command/action/execute', '', '{\"commandtype\":\"menu\",\"allcontroller\":\"0\",\"delete\":\"0\",\"force\":\"0\",\"controllerfile_text\":\"\",\"controllerfile\":\"Team.php\",\"action\":\"execute\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250857);
INSERT INTO `gc_admin_log` VALUES (123, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536250857);
INSERT INTO `gc_admin_log` VALUES (124, 1, 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"7d19b49a4559c39c4dc026e39444077d\",\"username\":\"admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536327130);
INSERT INTO `gc_admin_log` VALUES (125, 1, 'admin', '/admin/index/login?url=%2Fadmin', '登录', '{\"url\":\"\\/admin\",\"__token__\":\"9d389bb3a6f5fcf8829ffb3544b984df\",\"username\":\"admin\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1536671514);
INSERT INTO `gc_admin_log` VALUES (126, 1, 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"categorytype\":\"{\\\"default\\\":\\\"Default\\\",\\\"page\\\":\\\"Page\\\",\\\"article\\\":\\\"Article\\\",\\\"test\\\":\\\"Test\\\"}\",\"configgroup\":\"{\\\"basic\\\":\\\"Basic\\\",\\\"email\\\":\\\"Email\\\",\\\"dictionary\\\":\\\"Dictionary\\\",\\\"weapp\\\":\\\"\\u5c0f\\u7a0b\\u5e8f\\u76f8\\u5173\\\"}\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1537683988);
INSERT INTO `gc_admin_log` VALUES (127, 1, 'admin', '/admin/addon/install', '插件管理 安装', '{\"name\":\"alisms\",\"force\":\"0\",\"uid\":\"0\",\"token\":\"\",\"version\":\"1.0.2\",\"faversion\":\"1.0.0.20180806_beta\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1537691936);
INSERT INTO `gc_admin_log` VALUES (128, 1, 'admin', '/admin/index/index', '', '{\"action\":\"refreshmenu\"}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1537691936);
INSERT INTO `gc_admin_log` VALUES (129, 1, 'admin', '/admin/general.config/edit', '常规管理 系统配置 编辑', '{\"row\":{\"name\":\"FastAdmin\",\"beian\":\"\",\"cdnurl\":\"\",\"version\":\"1.0.1\",\"timezone\":\"Asia\\/Shanghai\",\"forbiddenip\":\"\",\"languages\":\"{\\\"backend\\\":\\\"zh-cn\\\",\\\"frontend\\\":\\\"zh-cn\\\"}\",\"fixedpage\":\"dashboard\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1537691971);
INSERT INTO `gc_admin_log` VALUES (130, 1, 'admin', '/admin/addon/config?name=alisms&dialog=1', '插件管理 配置', '{\"name\":\"alisms\",\"dialog\":\"1\",\"row\":{\"key\":\"your key\",\"secret\":\"your secret\",\"sign\":\"your sign\",\"template\":\"{\\\"register\\\":\\\"SMS_114000000\\\",\\\"join\\\":\\\"SMS_114000000\\\"}\"}}', '192.168.56.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', 1537692019);

-- ----------------------------
-- Table structure for gc_attachment
-- ----------------------------
DROP TABLE IF EXISTS `gc_attachment`;
CREATE TABLE `gc_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建日期',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `uploadtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_attachment
-- ----------------------------
INSERT INTO `gc_attachment` VALUES (1, 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 21859, 'image/png', '', 1499681848, 1499681848, 1499681848, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `gc_attachment` VALUES (2, 1, 0, '/uploads/20180906/6e5bb31f91f25d461a47d3c6d71c65be.jpg', '750', '300', 'jpg', 0, 178355, 'image/jpeg', '', 1536239869, 1536239869, 1536239869, 'local', '5d524e6758073427308a6410d86bc8e31d6c34a7');
INSERT INTO `gc_attachment` VALUES (3, 1, 0, '/uploads/20180906/6b1a49da7c95fe39cb7b29b1310158fe.png', '225', '178', 'png', 0, 16927, 'image/png', '', 1536239887, 1536239887, 1536239887, 'local', '74af4024e6e8f390cde25872e12c45a179389dc0');
INSERT INTO `gc_attachment` VALUES (4, 1, 0, '/uploads/20180906/fe7c92b38729e1fc07ab250616718983.png', '225', '178', 'png', 0, 9617, 'image/png', '', 1536239890, 1536239890, 1536239890, 'local', '5800996f73609728c37d8a3990714472795ae702');
INSERT INTO `gc_attachment` VALUES (5, 1, 0, '/uploads/20180906/2dcd03b6b52d5c77cc878babf22fb8cc.png', '225', '178', 'png', 0, 12500, 'image/png', '', 1536239893, 1536239893, 1536239893, 'local', '3a8eb9b9d4f4b2d5b25647d01ae855654138bced');
INSERT INTO `gc_attachment` VALUES (6, 1, 0, '/uploads/20180906/169b98d4dea58d10f7e3c1dbbb0c42be.jpg', '1024', '687', 'jpg', 0, 131143, 'image/jpeg', '', 1536239911, 1536239911, 1536239911, 'local', 'bbd8d970b9364df6f365ade08fd11e0acff90ee2');
INSERT INTO `gc_attachment` VALUES (7, 0, 0, '/uploads/20180923/ed40b41d05a3020271be545a607d6d78.gif', '22', '22', 'gif', 0, 2793, 'image/gif', '', 1537671195, 1537671195, 1537671195, 'local', '5830d72546907c962b6c9003fa923798a67b0406');
INSERT INTO `gc_attachment` VALUES (8, 0, 0, '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '22', '22', 'gif', 0, 2689, 'image/gif', '', 1537671381, 1537671381, 1537671381, 'local', '87db440c06299666a8a1f407a6008c5bf6d70817');
INSERT INTO `gc_attachment` VALUES (9, 0, 0, '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '22', '22', 'gif', 0, 2689, 'image/gif', '', 1537671442, 1537671442, 1537671442, 'local', '87db440c06299666a8a1f407a6008c5bf6d70817');
INSERT INTO `gc_attachment` VALUES (10, 0, 0, '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '22', '22', 'gif', 0, 2689, 'image/gif', '', 1537671465, 1537671465, 1537671465, 'local', '87db440c06299666a8a1f407a6008c5bf6d70817');
INSERT INTO `gc_attachment` VALUES (11, 0, 0, '/uploads/20180923/485a20018f6fd278510c2953697ba65c.gif', '22', '22', 'gif', 0, 1793, 'image/gif', '', 1537671484, 1537671484, 1537671484, 'local', 'a0f216d0aaaeec369109e4b581eacd4e83e5ccb6');
INSERT INTO `gc_attachment` VALUES (12, 0, 0, '/uploads/20180923/7873504cf41c6bf81dc385e7a63e06c2.gif', '22', '22', 'gif', 0, 9823, 'image/gif', '', 1537671494, 1537671494, 1537671494, 'local', 'dcad257d86505e921618f7d85b60bf6ac2ce319d');
INSERT INTO `gc_attachment` VALUES (13, 0, 0, '/uploads/20180923/3d4ee858ebba0e46a7850e13185b7c9b.gif', '22', '22', 'gif', 0, 6721, 'image/gif', '', 1537671524, 1537671524, 1537671524, 'local', '54db2506b93b76c58174177245dcc6ef3fd0591f');
INSERT INTO `gc_attachment` VALUES (14, 0, 0, '/uploads/20180923/7873504cf41c6bf81dc385e7a63e06c2.gif', '22', '22', 'gif', 0, 9823, 'image/gif', '', 1537671543, 1537671543, 1537671543, 'local', 'dcad257d86505e921618f7d85b60bf6ac2ce319d');
INSERT INTO `gc_attachment` VALUES (15, 0, 0, '/uploads/20180923/611117291370fea2ceac62c29e3895bd.gif', '22', '22', 'gif', 0, 2797, 'image/gif', '', 1537671568, 1537671568, 1537671568, 'local', '04fe5b26b7e2c980d12ad7157a4ce908c2a74f14');
INSERT INTO `gc_attachment` VALUES (16, 0, 0, '/uploads/20180923/3d4ee858ebba0e46a7850e13185b7c9b.gif', '22', '22', 'gif', 0, 6721, 'image/gif', '', 1537671624, 1537671624, 1537671624, 'local', '54db2506b93b76c58174177245dcc6ef3fd0591f');
INSERT INTO `gc_attachment` VALUES (17, 0, 0, '/uploads/20180923/0b7ff8f1bbb91be880ef190767774c78.gif', '22', '22', 'gif', 0, 2555, 'image/gif', '', 1537671633, 1537671633, 1537671633, 'local', '886222551781040325cfd3307fbfba2a1d434a9e');
INSERT INTO `gc_attachment` VALUES (18, 0, 0, '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '22', '22', 'gif', 0, 2689, 'image/gif', '', 1537673967, 1537673967, 1537673967, 'local', '87db440c06299666a8a1f407a6008c5bf6d70817');
INSERT INTO `gc_attachment` VALUES (19, 0, 0, '/uploads/20180923/3880bad4694b3ef38e2e58be68b875ef.gif', '22', '22', 'gif', 0, 3398, 'image/gif', '', 1537673971, 1537673971, 1537673971, 'local', 'ad4e2ea1864a85f5729a1347c2f8c49fdb3b2def');
INSERT INTO `gc_attachment` VALUES (20, 0, 0, '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '22', '22', 'gif', 0, 2689, 'image/gif', '', 1537674181, 1537674181, 1537674181, 'local', '87db440c06299666a8a1f407a6008c5bf6d70817');
INSERT INTO `gc_attachment` VALUES (21, 0, 0, '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '22', '22', 'gif', 0, 2689, 'image/gif', '', 1537674184, 1537674184, 1537674184, 'local', '87db440c06299666a8a1f407a6008c5bf6d70817');

-- ----------------------------
-- Table structure for gc_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `gc_auth_group`;
CREATE TABLE `gc_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则ID',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_auth_group
-- ----------------------------
INSERT INTO `gc_auth_group` VALUES (1, 0, 'Admin group', '*', 1490883540, 149088354, 'normal');
INSERT INTO `gc_auth_group` VALUES (2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1490883540, 1505465692, 'normal');
INSERT INTO `gc_auth_group` VALUES (3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1490883540, 1502205322, 'normal');
INSERT INTO `gc_auth_group` VALUES (4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1490883540, 1502205350, 'normal');
INSERT INTO `gc_auth_group` VALUES (5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1490883540, 1502205344, 'normal');

-- ----------------------------
-- Table structure for gc_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `gc_auth_group_access`;
CREATE TABLE `gc_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限分组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_auth_group_access
-- ----------------------------
INSERT INTO `gc_auth_group_access` VALUES (1, 1);
INSERT INTO `gc_auth_group_access` VALUES (2, 2);
INSERT INTO `gc_auth_group_access` VALUES (3, 3);
INSERT INTO `gc_auth_group_access` VALUES (4, 5);
INSERT INTO `gc_auth_group_access` VALUES (5, 5);

-- ----------------------------
-- Table structure for gc_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `gc_auth_rule`;
CREATE TABLE `gc_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '节点表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_auth_rule
-- ----------------------------
INSERT INTO `gc_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', 'Dashboard tips', 1, 1497429920, 1497429920, 143, 'normal');
INSERT INTO `gc_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', 1, 1497429920, 1497430169, 137, 'normal');
INSERT INTO `gc_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-list', '', 'Category tips', 0, 1497429920, 1536145095, 119, 'normal');
INSERT INTO `gc_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', 'Addon tips', 1, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', 1, 1497429920, 1497430092, 99, 'normal');
INSERT INTO `gc_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', 'Config tips', 1, 1497429920, 1497430683, 60, 'normal');
INSERT INTO `gc_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', 'Attachment tips', 1, 1497429920, 1497430699, 53, 'normal');
INSERT INTO `gc_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', 1, 1497429920, 1497429920, 34, 'normal');
INSERT INTO `gc_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', 'Admin tips', 1, 1497429920, 1497430320, 118, 'normal');
INSERT INTO `gc_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', 'Admin log tips', 1, 1497429920, 1497430307, 113, 'normal');
INSERT INTO `gc_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', 'Group tips', 1, 1497429920, 1497429920, 109, 'normal');
INSERT INTO `gc_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', 'Rule tips', 1, 1497429920, 1497430581, 104, 'normal');
INSERT INTO `gc_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 136, 'normal');
INSERT INTO `gc_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 135, 'normal');
INSERT INTO `gc_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 133, 'normal');
INSERT INTO `gc_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 134, 'normal');
INSERT INTO `gc_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 132, 'normal');
INSERT INTO `gc_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 52, 'normal');
INSERT INTO `gc_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 51, 'normal');
INSERT INTO `gc_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 50, 'normal');
INSERT INTO `gc_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 49, 'normal');
INSERT INTO `gc_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 48, 'normal');
INSERT INTO `gc_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', 'Attachment tips', 0, 1497429920, 1497429920, 59, 'normal');
INSERT INTO `gc_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 58, 'normal');
INSERT INTO `gc_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 57, 'normal');
INSERT INTO `gc_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 56, 'normal');
INSERT INTO `gc_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 55, 'normal');
INSERT INTO `gc_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 54, 'normal');
INSERT INTO `gc_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 33, 'normal');
INSERT INTO `gc_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 32, 'normal');
INSERT INTO `gc_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 31, 'normal');
INSERT INTO `gc_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 30, 'normal');
INSERT INTO `gc_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 29, 'normal');
INSERT INTO `gc_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 28, 'normal');
INSERT INTO `gc_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', 'Category tips', 0, 1497429920, 1497429920, 142, 'normal');
INSERT INTO `gc_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 141, 'normal');
INSERT INTO `gc_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 140, 'normal');
INSERT INTO `gc_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 139, 'normal');
INSERT INTO `gc_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 138, 'normal');
INSERT INTO `gc_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', 'Admin tips', 0, 1497429920, 1497429920, 117, 'normal');
INSERT INTO `gc_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 116, 'normal');
INSERT INTO `gc_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 115, 'normal');
INSERT INTO `gc_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 114, 'normal');
INSERT INTO `gc_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', 'Admin log tips', 0, 1497429920, 1497429920, 112, 'normal');
INSERT INTO `gc_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 111, 'normal');
INSERT INTO `gc_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 110, 'normal');
INSERT INTO `gc_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', 'Group tips', 0, 1497429920, 1497429920, 108, 'normal');
INSERT INTO `gc_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 107, 'normal');
INSERT INTO `gc_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 106, 'normal');
INSERT INTO `gc_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 105, 'normal');
INSERT INTO `gc_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', 'Rule tips', 0, 1497429920, 1497429920, 103, 'normal');
INSERT INTO `gc_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 102, 'normal');
INSERT INTO `gc_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 101, 'normal');
INSERT INTO `gc_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 100, 'normal');
INSERT INTO `gc_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', 'Addon tips', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (59, 'file', 4, 'addon/local', 'Local install', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (61, 'file', 4, 'addon/install', 'Install', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (62, 'file', 4, 'addon/uninstall', 'Uninstall', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-list', '', '', 1, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', 1, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', 0, 1516374729, 1536145111, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', 0, 1516374729, 1536145112, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (85, 'file', 2, 'general/database', '数据库管理', 'fa fa-database', '', '可在线进行一些简单的数据库表优化或修复,查看表结构和数据。也可以进行SQL语句的操作', 1, 1536144510, 1536144510, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (86, 'file', 85, 'general/database/index', '查看', 'fa fa-circle-o', '', '', 0, 1536144510, 1536144510, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (87, 'file', 85, 'general/database/query', '查询', 'fa fa-circle-o', '', '', 0, 1536144510, 1536144510, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (88, 'file', 85, 'general/database/backup', '备份', 'fa fa-circle-o', '', '', 0, 1536144510, 1536144510, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (89, 'file', 85, 'general/database/restore', '恢复', 'fa fa-circle-o', '', '', 0, 1536144510, 1536144510, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (90, 'file', 0, 'command', '在线命令管理', 'fa fa-terminal', '', '', 1, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (91, 'file', 90, 'command/index', '查看', 'fa fa-circle-o', '', '', 0, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (92, 'file', 90, 'command/add', '添加', 'fa fa-circle-o', '', '', 0, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (93, 'file', 90, 'command/detail', '详情', 'fa fa-circle-o', '', '', 0, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (94, 'file', 90, 'command/execute', '运行', 'fa fa-circle-o', '', '', 0, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (95, 'file', 90, 'command/del', '删除', 'fa fa-circle-o', '', '', 0, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (96, 'file', 90, 'command/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1536144511, 1536144511, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (97, 'file', 0, 'experience', '经验类型管理', 'fa fa-circle-o', '', '', 1, 1536248947, 1536248947, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (104, 'file', 97, 'experience/index', '查看', 'fa fa-circle-o', '', '', 0, 1536249904, 1536249904, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (105, 'file', 97, 'experience/add', '添加', 'fa fa-circle-o', '', '', 0, 1536249904, 1536249904, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (106, 'file', 97, 'experience/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1536249904, 1536249904, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (107, 'file', 97, 'experience/del', '删除', 'fa fa-circle-o', '', '', 0, 1536249904, 1536249904, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (108, 'file', 97, 'experience/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1536249904, 1536249904, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (109, 'file', 0, 'team', '劳务队', 'fa fa-circle-o', '', '', 1, 1536250857, 1536250857, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (110, 'file', 109, 'team/index', '查看', 'fa fa-circle-o', '', '', 0, 1536250857, 1536250857, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (111, 'file', 109, 'team/add', '添加', 'fa fa-circle-o', '', '', 0, 1536250857, 1536250857, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (112, 'file', 109, 'team/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1536250857, 1536250857, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (113, 'file', 109, 'team/del', '删除', 'fa fa-circle-o', '', '', 0, 1536250857, 1536250857, 0, 'normal');
INSERT INTO `gc_auth_rule` VALUES (114, 'file', 109, 'team/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1536250857, 1536250857, 0, 'normal');

-- ----------------------------
-- Table structure for gc_category
-- ----------------------------
DROP TABLE IF EXISTS `gc_category`;
CREATE TABLE `gc_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_category
-- ----------------------------
INSERT INTO `gc_category` VALUES (1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1495262190, 1495262190, 1, 'normal');
INSERT INTO `gc_category` VALUES (2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1495262244, 1495262244, 2, 'normal');
INSERT INTO `gc_category` VALUES (3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1495262288, 1495262288, 3, 'normal');
INSERT INTO `gc_category` VALUES (4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1495262317, 1495262317, 4, 'normal');
INSERT INTO `gc_category` VALUES (5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1495262336, 1499681850, 5, 'normal');
INSERT INTO `gc_category` VALUES (6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1495262357, 1495262357, 6, 'normal');
INSERT INTO `gc_category` VALUES (7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1495262391, 1495262391, 7, 'normal');
INSERT INTO `gc_category` VALUES (8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1495262424, 1495262424, 8, 'normal');
INSERT INTO `gc_category` VALUES (9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1495262456, 1495262456, 9, 'normal');
INSERT INTO `gc_category` VALUES (10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1495262487, 1495262487, 10, 'normal');
INSERT INTO `gc_category` VALUES (11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1495262515, 1495262515, 11, 'normal');
INSERT INTO `gc_category` VALUES (12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1497015727, 1497015727, 12, 'normal');
INSERT INTO `gc_category` VALUES (13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1497015738, 1497015738, 13, 'normal');

-- ----------------------------
-- Table structure for gc_command
-- ----------------------------
DROP TABLE IF EXISTS `gc_command`;
CREATE TABLE `gc_command`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型',
  `params` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数',
  `command` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '命令',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '返回结果',
  `executetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '执行时间',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` enum('successed','failured') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'failured' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线命令表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_command
-- ----------------------------
INSERT INTO `gc_command` VALUES (9, 'crud', '[\"--force=1\",\"--table=gc_team\",\"--fields=leader_name,phone,member_num,experience_id,member_num_with_card,is_insurance,experience_desc,avatar,id_card_image,province,city,district,create_time,update_time\",\"--citysuffix=abbcc\",\"--relation=gc_experience\",\"--relationmode=belongsto\",\"--relationforeignkey=experience_id\",\"--relationprimarykey=id\",\"--relationfields=id,experience\"]', 'php think crud --force=1 --table=gc_team --fields=leader_name,phone,member_num,experience_id,member_num_with_card,is_insurance,experience_desc,avatar,id_card_image,province,city,district,create_time,update_time --citysuffix=abbcc --relation=gc_experience --relationmode=belongsto --relationforeignkey=experience_id --relationprimarykey=id --relationfields=id,experience', 'Build Successed', 1536250828, 1536250828, 1536250828, 'successed');
INSERT INTO `gc_command` VALUES (10, 'menu', '[\"--controller=Team\"]', 'php think menu --controller=Team', 'Build Successed!', 1536250857, 1536250857, 1536250857, 'successed');

-- ----------------------------
-- Table structure for gc_config
-- ----------------------------
DROP TABLE IF EXISTS `gc_config`;
CREATE TABLE `gc_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_config
-- ----------------------------
INSERT INTO `gc_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', 'FastAdmin', '', 'required', '');
INSERT INTO `gc_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15054802号-4', 'string', '', '', '', '');
INSERT INTO `gc_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果静态资源使用第三方云储存请配置该值', 'string', '', '', '', '');
INSERT INTO `gc_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.1', '', 'required', '');
INSERT INTO `gc_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', '');
INSERT INTO `gc_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '');
INSERT INTO `gc_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '');
INSERT INTO `gc_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'dashboard', '', 'required', '');
INSERT INTO `gc_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '');
INSERT INTO `gc_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"weapp\":\"小程序相关\"}', '', '', '');
INSERT INTO `gc_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '[\"Please select\",\"SMTP\",\"Mail\"]', '', '');
INSERT INTO `gc_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', '');
INSERT INTO `gc_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', '');
INSERT INTO `gc_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', '');
INSERT INTO `gc_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码）', 'string', 'password', '', '', '');
INSERT INTO `gc_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '[\"None\",\"TLS\",\"SSL\"]', '', '');
INSERT INTO `gc_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '');
INSERT INTO `gc_config` VALUES (18, 'contact_phone', 'weapp', '联系电话', '', 'string', '13000000000', '', '', '');
INSERT INTO `gc_config` VALUES (19, 'can_kao_bao_jia', 'weapp', '参考报价图片', '', 'image', '/uploads/20180906/169b98d4dea58d10f7e3c1dbbb0c42be.jpg', '', '', '');
INSERT INTO `gc_config` VALUES (20, 'banner', 'weapp', '首页banner图', '', 'image', '/uploads/20180906/6e5bb31f91f25d461a47d3c6d71c65be.jpg', '', '', '');
INSERT INTO `gc_config` VALUES (21, 'small_banner_01', 'weapp', '首页banner下方小图(左)', '', 'image', '/uploads/20180906/6b1a49da7c95fe39cb7b29b1310158fe.png', '', '', '');
INSERT INTO `gc_config` VALUES (22, 'small_banner_02', 'weapp', '首页banner下方小图(中)', '', 'image', '/uploads/20180906/fe7c92b38729e1fc07ab250616718983.png', '', '', '');
INSERT INTO `gc_config` VALUES (23, 'small_banner_03', 'weapp', '首页banner下方小图(右)', '', 'image', '/uploads/20180906/2dcd03b6b52d5c77cc878babf22fb8cc.png', '', '', '');

-- ----------------------------
-- Table structure for gc_ems
-- ----------------------------
DROP TABLE IF EXISTS `gc_ems`;
CREATE TABLE `gc_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮箱验证码表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for gc_experience
-- ----------------------------
DROP TABLE IF EXISTS `gc_experience`;
CREATE TABLE `gc_experience`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `experience` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gc_experience
-- ----------------------------
INSERT INTO `gc_experience` VALUES (1, '经验类型', 1536249263, 1536249263, NULL);
INSERT INTO `gc_experience` VALUES (2, '经验类型1', 1536249267, 1536249267, NULL);
INSERT INTO `gc_experience` VALUES (3, '经验类型2', 1536249272, 1536249272, NULL);

-- ----------------------------
-- Table structure for gc_sms
-- ----------------------------
DROP TABLE IF EXISTS `gc_sms`;
CREATE TABLE `gc_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `createtime` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信验证码表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for gc_team
-- ----------------------------
DROP TABLE IF EXISTS `gc_team`;
CREATE TABLE `gc_team`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `leader_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '队长姓名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `member_num` int(11) NULL DEFAULT NULL COMMENT '团队人数',
  `experience_id` int(11) NULL DEFAULT NULL COMMENT '经验类型',
  `member_num_with_card` int(11) NULL DEFAULT NULL COMMENT '带证人数',
  `is_insurance` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '保险',
  `experience_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '经验描述',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `id_card_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `province` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '市',
  `district` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `gc_team_phone_uindex`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '劳务队' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gc_team
-- ----------------------------
INSERT INTO `gc_team` VALUES (1, 'gfasd', '13100010775', 12, 3, 5, '0', 'fasd fsdfsasfasdf', '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '/uploads/20180923/a06a2e3ed6da3796fbb731367d039a0a.gif', '北京市', '北京市', '东城区', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for gc_test
-- ----------------------------
DROP TABLE IF EXISTS `gc_test`;
CREATE TABLE `gc_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省市',
  `price` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '价格',
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime(0) NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time(0) NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '刷新时间(int)',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NOT NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '测试表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_test
-- ----------------------------
INSERT INTO `gc_test` VALUES (1, 0, 12, '12,13', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '描述', '广西壮族自治区/百色市/平果县', 0.00, 0, '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1499682285, 1499682526, 1499682526, 0, 1, 'normal', '1');

-- ----------------------------
-- Table structure for gc_user
-- ----------------------------
DROP TABLE IF EXISTS `gc_user`;
CREATE TABLE `gc_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '组别ID',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码盐',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `successions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '连续登录天数',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上次登录时间',
  `logintime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `joinip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '加入时间',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `token` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证',
  `company_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `project_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `project_type` int(11) NULL DEFAULT NULL,
  `start_time` date NULL DEFAULT NULL,
  `end_time` date NULL DEFAULT NULL,
  `can_contact_start_time` time(0) NULL DEFAULT NULL,
  `can_contact_end_time` time(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `mobile`(`mobile`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_user
-- ----------------------------
INSERT INTO `gc_user` VALUES (1, 1, 'admin', 'c13f62012fd6a8fdf06b3452a94430e5', 'rpR6Bv', '13888888888', 1, 1, 1516170492, 1516171614, '127.0.0.1', 0, '127.0.0.1', 1491461418, 0, 1516171614, '', 'normal', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `gc_user` VALUES (2, 0, '郭福平', 'f0ddc90c34befaacd730f39182bf1a41', 'jb1Ire', '13100010775', 2, 2, 1537609134, 1537687119, '192.168.56.1', 0, '192.168.56.1', 1537604479, 1537604479, 1537687119, '', 'normal', '', '123456', '123456', 3, '2018-09-22', '2018-09-25', '16:20:00', '16:20:00');

-- ----------------------------
-- Table structure for gc_user_group
-- ----------------------------
DROP TABLE IF EXISTS `gc_user_group`;
CREATE TABLE `gc_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '权限节点',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员组表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_user_group
-- ----------------------------
INSERT INTO `gc_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1515386468, 1516168298, 'normal');

-- ----------------------------
-- Table structure for gc_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `gc_user_rule`;
CREATE TABLE `gc_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员规则表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_user_rule
-- ----------------------------
INSERT INTO `gc_user_rule` VALUES (1, 0, 'index', '前台', '', 1, 1516168079, 1516168079, 1, 'normal');
INSERT INTO `gc_user_rule` VALUES (2, 0, 'api', 'API接口', '', 1, 1516168062, 1516168062, 2, 'normal');
INSERT INTO `gc_user_rule` VALUES (3, 1, 'user', '会员模块', '', 1, 1515386221, 1516168103, 12, 'normal');
INSERT INTO `gc_user_rule` VALUES (4, 2, 'user', '会员模块', '', 1, 1515386221, 1516168092, 11, 'normal');
INSERT INTO `gc_user_rule` VALUES (5, 3, 'index/user/login', '登录', '', 0, 1515386247, 1515386247, 5, 'normal');
INSERT INTO `gc_user_rule` VALUES (6, 3, 'index/user/register', '注册', '', 0, 1515386262, 1516015236, 7, 'normal');
INSERT INTO `gc_user_rule` VALUES (7, 3, 'index/user/index', '会员中心', '', 0, 1516015012, 1516015012, 9, 'normal');
INSERT INTO `gc_user_rule` VALUES (8, 3, 'index/user/profile', '个人资料', '', 0, 1516015012, 1516015012, 4, 'normal');
INSERT INTO `gc_user_rule` VALUES (9, 4, 'api/user/login', '登录', '', 0, 1515386247, 1515386247, 6, 'normal');
INSERT INTO `gc_user_rule` VALUES (10, 4, 'api/user/register', '注册', '', 0, 1515386262, 1516015236, 8, 'normal');
INSERT INTO `gc_user_rule` VALUES (11, 4, 'api/user/index', '会员中心', '', 0, 1516015012, 1516015012, 10, 'normal');
INSERT INTO `gc_user_rule` VALUES (12, 4, 'api/user/profile', '个人资料', '', 0, 1516015012, 1516015012, 3, 'normal');

-- ----------------------------
-- Table structure for gc_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `gc_user_score_log`;
CREATE TABLE `gc_user_score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员积分变动表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for gc_user_token
-- ----------------------------
DROP TABLE IF EXISTS `gc_user_token`;
CREATE TABLE `gc_user_token`  (
  `token` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `expiretime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员Token表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_user_token
-- ----------------------------
INSERT INTO `gc_user_token` VALUES ('27efd8d3ac229623ef8f1a21887adb4716b44c54', 2, 1537606993, 1540198993);
INSERT INTO `gc_user_token` VALUES ('2d282210e1970d71aa5bcfe9290922a54fac453f', 2, 1537607159, 1540199159);
INSERT INTO `gc_user_token` VALUES ('54067103d1a6e111fdbc53d5aea900862279bf60', 2, 1537604479, 1540196479);
INSERT INTO `gc_user_token` VALUES ('6303960dbf3921044a4d01d4ce004bf44d785ad8', 2, 1537607920, 1540199920);
INSERT INTO `gc_user_token` VALUES ('63ed80c48967b97b4ed4888a22e6c1b6ad2c3495', 2, 1537687119, 1540279119);
INSERT INTO `gc_user_token` VALUES ('831c23349b6258e090c5dce81ec0dc6c04933e8e', 2, 1537609134, 1540201134);
INSERT INTO `gc_user_token` VALUES ('ade758e2094f344f410704f1ab892e57fe4397ed', 2, 1537607086, 1540199086);
INSERT INTO `gc_user_token` VALUES ('d500f868e4487c875f96cd58592e52d966519741', 2, 1537607027, 1540199027);
INSERT INTO `gc_user_token` VALUES ('d90338b775ac51c4517fe74c740376300f73f940', 2, 1537606886, 1540198886);

-- ----------------------------
-- Table structure for gc_version
-- ----------------------------
DROP TABLE IF EXISTS `gc_version`;
CREATE TABLE `gc_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` int(10) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '版本表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gc_version
-- ----------------------------
INSERT INTO `gc_version` VALUES (1, '1.1.1,2', '1.2.1', '20M', '更新内容', 'https://www.fastadmin.net/download.html', 1, 1520425318, 0, 0, 'normal');

SET FOREIGN_KEY_CHECKS = 1;
