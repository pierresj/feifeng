-- 新建招聘表 --
DROP TABLE IF EXISTS `gc_recruit`;
CREATE TABLE `gc_recruit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` varchar(50) NOT NULL DEFAULT '0',
  `province` varchar(10) NOT NULL DEFAULT '0',
  `city` varchar(20) NOT NULL DEFAULT '0',
  `district` varchar(50) NOT NULL DEFAULT '0',
  `addr` varchar(200) NOT NULL DEFAULT '0',
  `wage` varchar(50) NOT NULL DEFAULT '0',
  `company` varchar(200) NOT NULL DEFAULT '0',
  `company_summary` text NOT NULL,
  `position_summary` text NOT NULL,
  `tel` varchar(30) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `update_time` int(10) NOT NULL,
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 插入user_id字段 --
ALTER TABLE `gc_recruit`
  ADD COLUMN `user_id`  int(10) NOT NULL AFTER `id`;
ALTER TABLE `gc_recruit`
  ADD COLUMN `status`  tinyint(1) UNSIGNED NOT NULL DEFAULT 0 AFTER `update_time`;

-- 设计师表增加字段
ALTER TABLE `gc_designer`
  ADD COLUMN `user_id`  int(10) UNSIGNED NOT NULL AFTER `id`;

-- 劳务队表增加字段
ALTER TABLE `gc_team`
  ADD COLUMN `user_id`  int(10) UNSIGNED NOT NULL AFTER `id`;
ALTER TABLE `gc_team`
  ADD COLUMN `is_delete`  tinyint(1) UNSIGNED NULL AFTER `status`;
ALTER TABLE `gc_team`
  MODIFY COLUMN `is_delete`  tinyint(1) UNSIGNED NULL DEFAULT 0 AFTER `status`;

-- 产品表增加字段
ALTER TABLE `gc_product`
  ADD COLUMN `user_id`  int(10) UNSIGNED NOT NULL AFTER `id`;
ALTER TABLE `gc_product`
  ADD COLUMN `status`  tinyint(1) UNSIGNED NOT NULL AFTER `delete_time`;
ALTER TABLE `gc_product`
  ADD COLUMN `quantifier`  varchar(10) NOT NULL DEFAULT 0 COMMENT '量词' AFTER `product_price`;


-- 用户表增加字段
ALTER TABLE `gc_user`
  ADD COLUMN `openid`  varchar(100) NOT NULL AFTER `id`;
ALTER TABLE `gc_user`
  ADD COLUMN `nicknamme`  varchar(50) NOT NULL AFTER `openid`;
ALTER TABLE `gc_user`
  ADD COLUMN `head_img`  varchar(200) NOT NULL AFTER `nicknamme`;

-- 权限表更新
INSERT INTO `gong_cheng`.`gc_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES ('224', 'file', '0', 'recruit', '招聘管理', 'fa fa-circle-o', '', '', '1', '1559873905', '1559874087', '0', 'normal');
INSERT INTO `gong_cheng`.`gc_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES ('225', 'file', '224', 'recruit/index', '查看', 'fa fa-circle-o', '', '', '0', '1559873905', '1559873905', '0', 'normal');
INSERT INTO `gong_cheng`.`gc_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES ('226', 'file', '224', 'recruit/add', '添加', 'fa fa-circle-o', '', '', '0', '1559873905', '1559873905', '0', 'normal');
INSERT INTO `gong_cheng`.`gc_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES ('227', 'file', '224', 'recruit/edit', '编辑', 'fa fa-circle-o', '', '', '0', '1559873905', '1559873905', '0', 'normal');
INSERT INTO `gong_cheng`.`gc_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES ('228', 'file', '224', 'recruit/del', '删除', 'fa fa-circle-o', '', '', '0', '1559873905', '1559873905', '0', 'normal');
INSERT INTO `gong_cheng`.`gc_auth_rule` (`id`, `type`, `pid`, `name`, `title`, `icon`, `condition`, `remark`, `ismenu`, `createtime`, `updatetime`, `weigh`, `status`) VALUES ('229', 'file', '224', 'recruit/multi', '批量更新', 'fa fa-circle-o', '', '', '0', '1559873905', '1559873905', '0', 'normal');

