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

