/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : account_mange

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 28/07/2020 19:09:27
*/
CREATE DATABASE account_mange;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for coupon_card
-- ----------------------------
DROP TABLE IF EXISTS `coupon_card`;
CREATE TABLE `coupon_card`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` float(10, 2) DEFAULT NULL,
  `percentage` float(10, 2) DEFAULT NULL COMMENT '提成',
  `start_time` datetime(0) DEFAULT NULL,
  `end_time` datetime(0) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_card
-- ----------------------------
INSERT INTO `coupon_card` VALUES (36, '收费项目1、5优惠卡', 200.00, 0.10, '2015-11-10 00:00:00', '2020-12-10 15:01:37', 1, '哈哈哈');
INSERT INTO `coupon_card` VALUES (42, '收费项目2、4优惠卡', 200.00, 0.30, '2017-11-10 00:00:00', '2021-11-10 00:00:00', 1, '哈哈哈');
INSERT INTO `coupon_card` VALUES (51, '收费项目2、4优惠卡', 200.00, 0.10, '2019-11-10 00:00:00', '2021-11-10 00:00:00', 1, '哈哈哈');
INSERT INTO `coupon_card` VALUES (52, '收费项目2、4优惠卡', 200.00, 0.10, '2018-11-10 00:00:00', '2021-11-10 00:00:00', 1, '哈哈哈');
INSERT INTO `coupon_card` VALUES (53, '收费项目3、6优惠卡', 200.00, 0.20, '2018-11-10 00:00:00', '2020-11-10 00:00:00', 1, '哈哈哈哈哈');
INSERT INTO `coupon_card` VALUES (56, '收费项目3、6优惠卡', 200.00, 0.10, '2018-11-10 00:00:00', '2020-11-10 00:00:00', 1, '哈哈哈');

-- ----------------------------
-- Table structure for coupon_card_detail
-- ----------------------------
DROP TABLE IF EXISTS `coupon_card_detail`;
CREATE TABLE `coupon_card_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `times` int(11) DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `coupon_card_detail_ibfk_1`(`card_id`) USING BTREE,
  INDEX `coupon_card_detail_ibfk_2`(`project_id`) USING BTREE,
  CONSTRAINT `coupon_card_detail_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `coupon_card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `coupon_card_detail_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 168 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_card_detail
-- ----------------------------
INSERT INTO `coupon_card_detail` VALUES (148, 53, 5, 10, '');
INSERT INTO `coupon_card_detail` VALUES (155, 36, 3, 10, '');
INSERT INTO `coupon_card_detail` VALUES (160, 51, 4, 20, '');
INSERT INTO `coupon_card_detail` VALUES (161, 51, 5, 10, '');
INSERT INTO `coupon_card_detail` VALUES (164, 42, 4, 20, NULL);
INSERT INTO `coupon_card_detail` VALUES (167, 52, 4, 10, NULL);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` int(1) DEFAULT NULL COMMENT '1：男，2：女',
  `registe_time` datetime(0) DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `weixin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `balance` float(10, 2) NOT NULL COMMENT '余额',
  `status` int(1) DEFAULT NULL COMMENT '状态：1可用、0不可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, 'cus_1', 2, '2019-11-10 11:08:13', '1234', 'wex', 5904.00, 0);
INSERT INTO `customer` VALUES (2, 'cus_2', 2, '2019-11-10 12:34:04', '222', 'wex', 430.00, 1);
INSERT INTO `customer` VALUES (3, 'cus_3', 2, '2019-11-10 12:34:15', '333', 'wex', 0.00, 1);
INSERT INTO `customer` VALUES (4, 'cus_4', 2, '2019-11-10 12:34:21', '444', 'wex', 0.00, 1);
INSERT INTO `customer` VALUES (5, 'cus_5', 1, '2019-11-10 12:34:28', '555', 'wex', 200.00, 1);
INSERT INTO `customer` VALUES (6, '123', 2, '2019-11-25 08:52:43', '12312312312', '123', 199.00, 1);
INSERT INTO `customer` VALUES (7, '23', 1, '2019-11-25 12:28:56', '12312312312', '123', 100.00, 1);
INSERT INTO `customer` VALUES (8, '121234134', 1, '2019-11-26 09:09:23', '12312312312', '123413241', 0.00, 1);
INSERT INTO `customer` VALUES (9, '阿三', 2, '2019-11-26 13:08:32', '12312312312', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (10, '123', 2, '2019-11-26 13:11:50', '12312312312', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (11, '阿三', 1, '2019-11-26 13:18:46', '12312312312', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (12, '123', 4, '2019-11-26 13:34:15', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (13, 'asdf', 1, '2019-11-26 13:39:01', '12312312312', 'asdf', 0.00, 1);
INSERT INTO `customer` VALUES (14, '阿三', 1, '2019-12-02 12:10:56', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (15, '123', 1, '2019-12-02 12:13:08', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (16, '123', 1, '2019-12-02 12:15:58', '12312312312', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (17, '123', 2, '2019-12-02 12:30:08', '66666666666', '123', 0.00, 0);
INSERT INTO `customer` VALUES (18, '123', 1, '2019-12-02 12:30:42', '66666666666', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (19, '123', 1, '2019-12-02 12:34:09', '12312312312', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (20, '123', 1, '2019-12-02 12:35:05', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (21, '123', 1, '2019-12-02 12:36:53', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (22, '123', 1, '2019-12-02 12:37:36', '66666666666', '123123', 0.00, 1);
INSERT INTO `customer` VALUES (23, '123', 1, '2019-12-02 13:07:58', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (24, '123', 1, '2019-12-03 09:51:42', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (25, '456', 2, '2019-12-06 12:21:45', '12345678901', '123', 0.00, 1);
INSERT INTO `customer` VALUES (26, '阿三', 1, '2019-12-07 01:13:26', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (27, '123', 1, '2019-12-07 09:28:29', '12312312312', '123', 0.00, 1);
INSERT INTO `customer` VALUES (28, '憨憨', 2, '2019-12-08 05:34:17', '12345346344', '憨憨哈哈', 0.00, 1);
INSERT INTO `customer` VALUES (29, '憨憨', 2, '2019-12-08 05:42:37', '21432543335', '你', 0.00, 1);

-- ----------------------------
-- Table structure for customer_card
-- ----------------------------
DROP TABLE IF EXISTS `customer_card`;
CREATE TABLE `customer_card`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `card_id` int(11) DEFAULT NULL,
  `opening_time` datetime(0) DEFAULT NULL,
  `dead_time` datetime(0) DEFAULT NULL,
  `price` float(10, 2) DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `card_id`(`card_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `customer_card_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `customer_card_ibfk_2` FOREIGN KEY (`card_id`) REFERENCES `coupon_card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `customer_card_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_card
-- ----------------------------
INSERT INTO `customer_card` VALUES (25, 8, 36, '2019-12-12 03:16:51', '2020-12-10 15:01:37', 100.00, NULL, 5);
INSERT INTO `customer_card` VALUES (31, 2, 51, '2019-12-15 18:50:03', '2021-11-10 00:00:00', 100.00, NULL, 4);
INSERT INTO `customer_card` VALUES (32, 2, 42, '2019-12-15 18:50:15', '2021-11-10 00:00:00', 222.00, NULL, 12);
INSERT INTO `customer_card` VALUES (33, 5, 42, '2019-12-16 05:52:54', '2021-11-10 00:00:00', 100.00, NULL, 4);
INSERT INTO `customer_card` VALUES (35, 1, 42, '2019-12-16 12:39:55', '2021-11-10 00:00:00', 1111.00, NULL, 8);
INSERT INTO `customer_card` VALUES (38, 1, 56, '2019-12-17 14:11:02', '2020-11-10 00:00:00', 100.00, NULL, 8);

-- ----------------------------
-- Table structure for customer_card_project
-- ----------------------------
DROP TABLE IF EXISTS `customer_card_project`;
CREATE TABLE `customer_card_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_card_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `residual_times` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_card_project_ibfk_1`(`customer_card_id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  CONSTRAINT `customer_card_project_ibfk_1` FOREIGN KEY (`customer_card_id`) REFERENCES `customer_card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `customer_card_project_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_card_project
-- ----------------------------
INSERT INTO `customer_card_project` VALUES (42, 31, 4, 18);
INSERT INTO `customer_card_project` VALUES (43, 31, 5, 10);
INSERT INTO `customer_card_project` VALUES (44, 32, 4, 20);
INSERT INTO `customer_card_project` VALUES (45, 33, 4, 19);
INSERT INTO `customer_card_project` VALUES (48, 35, 4, 15);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'card_edit', '修改优惠卡');
INSERT INTO `permission` VALUES (2, 'card_add', '增加优惠卡');
INSERT INTO `permission` VALUES (3, 'card_del', '删除优惠卡');
INSERT INTO `permission` VALUES (4, 'customer_freeze', '冻结客户');
INSERT INTO `permission` VALUES (5, 'pro_add', '增加收费项目');
INSERT INTO `permission` VALUES (6, 'pro_edit', '修改收费项目');
INSERT INTO `permission` VALUES (7, 'pro_del', '删除收费项目');
INSERT INTO `permission` VALUES (8, 'salary_set', '设置薪水结算日期');
INSERT INTO `permission` VALUES (9, 'salary_edit', '修改员工薪水');
INSERT INTO `permission` VALUES (10, 'salary_del', '删除员工薪水');
INSERT INTO `permission` VALUES (11, 'consum_edit', '修改消费记录');
INSERT INTO `permission` VALUES (12, 'consum_del', '删除消费记录');
INSERT INTO `permission` VALUES (13, 'job_del', '删除员工手工项目');
INSERT INTO `permission` VALUES (14, 'card_freeze', '冻结优惠卡');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` float(10, 2) DEFAULT NULL,
  `percentage` float(3, 2) DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (3, '收费项目2', 20.00, 0.20, '0', '这是介绍2');
INSERT INTO `project` VALUES (4, '收费项目3', 20.00, 0.30, '1', '这是介绍3');
INSERT INTO `project` VALUES (5, '收费项目4', 20.00, 0.40, '1', '这是介绍4');
INSERT INTO `project` VALUES (6, '收费项目5', 20.00, 0.50, '1', '这是介绍5');
INSERT INTO `project` VALUES (7, '收费项目6', 20.00, 0.60, '1', '这是介绍6');

-- ----------------------------
-- Table structure for record_business
-- ----------------------------
DROP TABLE IF EXISTS `record_business`;
CREATE TABLE `record_business`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `customer_id` int(255) DEFAULT NULL,
  `type` int(1) DEFAULT NULL COMMENT '1:办卡、2：完成收费项目',
  `thing_id` int(11) DEFAULT NULL COMMENT '卡或者项目的id',
  `date` datetime(0) DEFAULT NULL COMMENT '啥时候做的',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  CONSTRAINT `record_business_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `record_business_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 419 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_business
-- ----------------------------
INSERT INTO `record_business` VALUES (369, 4, 2, 1, 51, '2019-12-15 18:50:03');
INSERT INTO `record_business` VALUES (370, 12, 2, 1, 42, '2019-12-15 18:50:15');
INSERT INTO `record_business` VALUES (371, 8, 2, 2, 4, '2019-12-15 18:50:24');
INSERT INTO `record_business` VALUES (372, 8, 2, 2, 6, '2019-12-15 18:50:28');
INSERT INTO `record_business` VALUES (373, 4, 5, 1, 42, '2019-12-16 05:52:54');
INSERT INTO `record_business` VALUES (374, 8, 4, 2, 3, '2019-12-16 05:53:42');
INSERT INTO `record_business` VALUES (375, 8, 5, 2, 4, '2019-12-16 05:54:23');
INSERT INTO `record_business` VALUES (376, 8, 1, 2, 3, '2019-12-16 10:25:29');
INSERT INTO `record_business` VALUES (377, 4, NULL, 2, 5, '2019-12-16 11:31:24');
INSERT INTO `record_business` VALUES (378, 8, NULL, 2, 3, '2019-12-16 11:40:24');
INSERT INTO `record_business` VALUES (379, 8, NULL, 2, 3, '2019-12-16 11:42:52');
INSERT INTO `record_business` VALUES (380, 8, 1, 2, 3, '2019-12-16 11:45:45');
INSERT INTO `record_business` VALUES (381, 4, NULL, 2, 5, '2019-12-16 11:49:44');
INSERT INTO `record_business` VALUES (382, 8, 1, 1, 51, '2019-12-16 11:57:43');
INSERT INTO `record_business` VALUES (383, 8, NULL, 2, 4, '2019-12-16 12:00:23');
INSERT INTO `record_business` VALUES (384, 8, NULL, 2, 3, '2019-12-16 12:01:47');
INSERT INTO `record_business` VALUES (385, 8, NULL, 2, 3, '2019-12-16 12:03:24');
INSERT INTO `record_business` VALUES (386, 8, NULL, 2, 3, '2019-12-16 12:08:08');
INSERT INTO `record_business` VALUES (387, 8, NULL, 2, 3, '2019-12-16 12:09:00');
INSERT INTO `record_business` VALUES (388, 4, NULL, 2, 4, '2019-12-16 12:09:05');
INSERT INTO `record_business` VALUES (389, 4, NULL, 2, 4, '2019-12-16 12:09:27');
INSERT INTO `record_business` VALUES (390, 8, NULL, 2, 4, '2019-12-16 12:10:43');
INSERT INTO `record_business` VALUES (391, 8, NULL, 2, 3, '2019-12-16 12:12:06');
INSERT INTO `record_business` VALUES (392, 8, NULL, 2, 3, '2019-12-16 12:13:05');
INSERT INTO `record_business` VALUES (393, 8, NULL, 2, 3, '2019-12-16 12:16:38');
INSERT INTO `record_business` VALUES (394, 8, NULL, 2, 3, '2019-12-16 12:16:48');
INSERT INTO `record_business` VALUES (395, 8, NULL, 2, 3, '2019-12-16 12:21:49');
INSERT INTO `record_business` VALUES (396, 4, NULL, 2, 4, '2019-12-16 12:33:59');
INSERT INTO `record_business` VALUES (397, 8, NULL, 2, 4, '2019-12-16 12:35:35');
INSERT INTO `record_business` VALUES (398, 4, NULL, 2, 4, '2019-12-16 12:36:05');
INSERT INTO `record_business` VALUES (399, 8, NULL, 2, 3, '2019-12-16 12:36:34');
INSERT INTO `record_business` VALUES (400, 4, NULL, 2, 4, '2019-12-16 12:39:27');
INSERT INTO `record_business` VALUES (401, 8, 1, 1, 42, '2019-12-16 12:39:55');
INSERT INTO `record_business` VALUES (402, 8, 1, 2, 4, '2019-12-16 12:40:03');
INSERT INTO `record_business` VALUES (403, 8, 1, 2, 4, '2019-12-16 12:40:04');
INSERT INTO `record_business` VALUES (404, 8, 1, 2, 4, '2019-12-16 12:40:05');
INSERT INTO `record_business` VALUES (405, 8, 1, 2, 4, '2019-12-16 12:40:07');
INSERT INTO `record_business` VALUES (406, 8, 1, 2, 4, '2019-12-16 12:40:08');
INSERT INTO `record_business` VALUES (407, 8, NULL, 2, 4, '2019-12-16 12:43:05');
INSERT INTO `record_business` VALUES (408, 8, 1, 2, 4, '2019-12-16 12:43:21');
INSERT INTO `record_business` VALUES (409, 8, NULL, 2, 4, '2019-12-16 12:46:04');
INSERT INTO `record_business` VALUES (410, 8, 1, 1, 42, '2019-12-16 12:46:15');
INSERT INTO `record_business` VALUES (411, 8, 1, 1, 42, '2019-12-16 12:46:26');
INSERT INTO `record_business` VALUES (412, 4, 1, 2, 4, '2019-12-16 12:47:10');
INSERT INTO `record_business` VALUES (413, 8, NULL, 2, 7, '2019-12-16 12:51:21');
INSERT INTO `record_business` VALUES (414, 8, 1, 2, 4, '2019-12-16 12:51:54');
INSERT INTO `record_business` VALUES (415, 8, 1, 1, 56, '2019-12-17 14:11:02');
INSERT INTO `record_business` VALUES (416, 8, 1, 2, 4, '2020-01-03 02:27:42');
INSERT INTO `record_business` VALUES (417, 4, NULL, 2, 3, '2020-01-03 02:28:08');
INSERT INTO `record_business` VALUES (418, 8, 1, 2, 4, '2020-01-03 02:41:23');

-- ----------------------------
-- Table structure for records_consumption
-- ----------------------------
DROP TABLE IF EXISTS `records_consumption`;
CREATE TABLE `records_consumption`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `consum_type` int(11) DEFAULT NULL COMMENT '消费类型 1：收费项目、2.办卡、3.充值余额、4.给卡增加次数',
  `price` float(10, 2) DEFAULT NULL,
  `pay_type` int(11) DEFAULT NULL COMMENT '1：从卡里扣除，2：从余额扣除，3.支付',
  `pay_time` datetime(0) DEFAULT NULL,
  `is_record` tinyint(1) DEFAULT NULL COMMENT '是否被营业额所统计 0：没有、1:统计了',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `records_consumption_ibfk_1`(`customer_id`) USING BTREE,
  INDEX `records_consumption_ibfk_3`(`consum_type`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `records_consumption_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `records_consumption_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 625 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of records_consumption
-- ----------------------------
INSERT INTO `records_consumption` VALUES (1, 1, 4, 2, 80.00, 3, '2019-11-10 11:43:10', 1, 'cus_1 80元办卡');
INSERT INTO `records_consumption` VALUES (2, 1, 4, 3, 100.00, 3, '2019-11-10 11:53:43', 1, '4号员工给客户充值余额');
INSERT INTO `records_consumption` VALUES (3, 1, 4, 2, 80.00, 2, '2019-11-10 11:58:39', 1, 'cus_1 用80元余额办1、2、3优惠卡');
INSERT INTO `records_consumption` VALUES (4, 1, 4, 5, 10.00, 0, '2019-11-10 12:02:25', 1, '4号员工给客户退余额10元');
INSERT INTO `records_consumption` VALUES (5, 1, 4, 1, 20.00, 1, '2019-11-10 12:10:17', 1, '客户使用1、2优惠卡的项目1 减少1次');
INSERT INTO `records_consumption` VALUES (6, 1, 4, 4, 50.00, 3, '2019-11-10 12:14:39', 1, '客户使用现金给1、2优惠卡的项目1 充值10次');
INSERT INTO `records_consumption` VALUES (7, 1, 4, 6, 0.00, 1, '2019-11-10 12:20:19', 1, '员工4号 删除客户1的1、2优惠卡');
INSERT INTO `records_consumption` VALUES (9, 1, 4, 1, 20.00, 3, '2019-11-10 12:33:08', 1, '客户使用现金结算4号项目');
INSERT INTO `records_consumption` VALUES (10, 1, 4, 2, 80.00, 3, '2019-11-10 12:37:20', 1, 'cus_1 用80元办1、2、3优惠卡');
INSERT INTO `records_consumption` VALUES (11, 1, 4, 5, 10.00, 0, '2019-11-10 15:42:32', 1, '4号员工给客户退余额10元');
INSERT INTO `records_consumption` VALUES (12, 1, 4, 1, 20.00, 1, '2019-11-10 15:59:21', 1, '客户使用1、2、3优惠卡的项目1 减少1次');
INSERT INTO `records_consumption` VALUES (13, 1, 4, 1, 20.00, 3, '2019-11-10 16:25:58', 1, '客户使用现金结算4号项目');
INSERT INTO `records_consumption` VALUES (14, 2, 5, 2, 80.00, 3, '2019-11-11 04:45:44', 1, 'cus_2 80元办卡');
INSERT INTO `records_consumption` VALUES (15, 2, 5, 2, 80.00, 3, '2019-11-11 04:47:58', 1, 'cus_2 80元办卡');
INSERT INTO `records_consumption` VALUES (16, 4, 6, 2, 90.00, 3, '2019-11-11 04:50:05', 1, 'cus_4 90元办卡');
INSERT INTO `records_consumption` VALUES (17, 1, 6, 1, 20.00, 1, '2019-11-11 05:10:55', 1, '客户优惠卡 减少1次');
INSERT INTO `records_consumption` VALUES (18, 1, 7, 1, 20.00, 1, '2019-11-11 05:12:00', 1, '客户优惠卡 减少1次');
INSERT INTO `records_consumption` VALUES (19, 4, 6, 2, 90.00, 3, '2019-11-11 05:23:05', 1, 'cus_3 90元办卡');
INSERT INTO `records_consumption` VALUES (20, 4, 6, 2, 90.00, 3, '2019-11-11 05:25:08', 1, 'cus_3 90元办卡');
INSERT INTO `records_consumption` VALUES (22, 1, 1, 6, 0.00, 1, '2019-11-11 05:31:50', 1, 'staff_1 删除客户优惠卡');
INSERT INTO `records_consumption` VALUES (23, 4, 5, 6, 0.00, 1, '2019-11-11 05:33:31', 1, 'staff_1 删除客户优惠卡');
INSERT INTO `records_consumption` VALUES (24, 4, 5, 6, 0.00, 1, '2019-11-11 05:34:48', 1, 'staff_1 删除客户优惠卡');
INSERT INTO `records_consumption` VALUES (25, 1, 6, 1, 20.00, 3, '2019-11-11 05:36:05', 1, 'staff2 客户使用现金结算4号项目');
INSERT INTO `records_consumption` VALUES (27, 3, 5, 1, 50.00, 3, '2019-11-13 09:19:43', 1, 'staff_1 50');
INSERT INTO `records_consumption` VALUES (28, 4, 6, 2, 90.00, 3, '2019-11-13 10:01:56', 1, 'cus_3 90元办卡');
INSERT INTO `records_consumption` VALUES (29, 1, 6, 2, 80.00, 3, '2019-11-13 10:10:06', 1, 'cus_1 80元办卡');
INSERT INTO `records_consumption` VALUES (30, NULL, 4, 6, 20.00, 0, '2019-11-13 10:12:14', 1, '员工4号 删除客户1的1、2优惠卡');
INSERT INTO `records_consumption` VALUES (31, 1, 4, 3, 10.00, 3, '2019-11-26 04:31:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (32, 1, 4, 3, 10.00, 3, '2019-11-26 08:41:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (33, 1, 4, 3, 10.00, 3, '2019-11-26 09:07:40', 1, NULL);
INSERT INTO `records_consumption` VALUES (34, 1, 4, 3, 10.00, 3, '2019-11-26 09:07:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (35, 1, 4, 3, 10.00, 3, '2019-11-26 09:08:15', 1, NULL);
INSERT INTO `records_consumption` VALUES (36, 1, 4, 3, 10.00, 3, '2019-11-26 09:12:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (37, 1, 1, 3, 100.00, 3, '2019-11-26 09:15:12', 1, NULL);
INSERT INTO `records_consumption` VALUES (38, 1, 1, 3, 100.00, 3, '2019-11-26 09:15:40', 1, NULL);
INSERT INTO `records_consumption` VALUES (39, 1, 1, 3, 100.00, 3, '2019-11-26 09:16:09', 1, NULL);
INSERT INTO `records_consumption` VALUES (40, 1, 1, 3, 100.00, 3, '2019-11-26 09:16:10', 1, NULL);
INSERT INTO `records_consumption` VALUES (41, 1, 1, 3, 100.00, 3, '2019-11-26 09:17:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (42, 1, 1, 3, 100.00, 3, '2019-11-26 09:18:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (43, 1, 1, 3, 100.00, 3, '2019-11-26 09:18:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (44, 1, 1, 3, 100.00, 3, '2019-11-26 09:19:00', 1, NULL);
INSERT INTO `records_consumption` VALUES (45, 1, 1, 3, 100.00, 3, '2019-11-26 09:19:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (46, 1, 1, 3, 100.00, 3, '2019-11-26 09:20:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (47, 5, 1, 3, 100.00, 3, '2019-11-26 09:28:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (48, 1, 1, 3, 100.00, 3, '2019-11-26 12:19:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (49, 2, 1, 3, 10.00, 3, '2019-11-26 12:42:37', 1, '啊打发');
INSERT INTO `records_consumption` VALUES (50, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:07', 1, '123123123');
INSERT INTO `records_consumption` VALUES (51, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:11', 1, '123123123');
INSERT INTO `records_consumption` VALUES (52, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:14', 1, '123123123');
INSERT INTO `records_consumption` VALUES (53, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:22', 1, '123123123');
INSERT INTO `records_consumption` VALUES (54, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:22', 1, '123123123');
INSERT INTO `records_consumption` VALUES (55, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:22', 1, '123123123');
INSERT INTO `records_consumption` VALUES (56, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:22', 1, '123123123');
INSERT INTO `records_consumption` VALUES (57, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:23', 1, '123123123');
INSERT INTO `records_consumption` VALUES (58, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:23', 1, '123123123');
INSERT INTO `records_consumption` VALUES (59, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:23', 1, '123123123');
INSERT INTO `records_consumption` VALUES (60, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:23', 1, '123123123');
INSERT INTO `records_consumption` VALUES (61, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:23', 1, '123123123');
INSERT INTO `records_consumption` VALUES (62, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:23', 1, '123123123');
INSERT INTO `records_consumption` VALUES (63, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:24', 1, '123123123');
INSERT INTO `records_consumption` VALUES (64, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:24', 1, '123123123');
INSERT INTO `records_consumption` VALUES (65, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:24', 1, '123123123');
INSERT INTO `records_consumption` VALUES (66, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:24', 1, '123123123');
INSERT INTO `records_consumption` VALUES (67, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:24', 1, '123123123');
INSERT INTO `records_consumption` VALUES (68, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:30', 1, '123123123');
INSERT INTO `records_consumption` VALUES (69, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:30', 1, '123123123');
INSERT INTO `records_consumption` VALUES (70, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:30', 1, '123123123');
INSERT INTO `records_consumption` VALUES (71, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:31', 1, '123123123');
INSERT INTO `records_consumption` VALUES (72, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:31', 1, '123123123');
INSERT INTO `records_consumption` VALUES (73, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:31', 1, '123123123');
INSERT INTO `records_consumption` VALUES (74, 2, 1, 3, 10.00, 3, '2019-11-26 12:56:31', 1, '123123123');
INSERT INTO `records_consumption` VALUES (75, 2, 1, 2, 100.00, 3, '2019-11-26 12:57:09', 1, '123');
INSERT INTO `records_consumption` VALUES (76, 2, 1, 2, 100.00, 3, '2019-11-26 12:57:16', 1, '123');
INSERT INTO `records_consumption` VALUES (77, 2, 1, 2, 12.00, 3, '2019-11-26 13:02:52', 1, '12');
INSERT INTO `records_consumption` VALUES (78, 2, 1, 4, 12.00, 3, '2019-11-26 13:02:59', 1, '12');
INSERT INTO `records_consumption` VALUES (79, 2, 1, 1, 12.00, 3, '2019-11-26 13:03:41', 1, '123');
INSERT INTO `records_consumption` VALUES (80, 2, 1, 2, 23.00, 3, '2019-11-26 13:10:13', 1, '234');
INSERT INTO `records_consumption` VALUES (81, 6, 1, 3, 100.00, 3, '2019-11-26 13:25:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (82, 2, 1, 3, 100.00, 3, '2019-12-02 12:43:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (83, 2, 1, 3, 100.00, 3, '2019-12-02 12:44:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (84, 2, 1, 3, 100.00, 3, '2019-12-02 12:44:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (85, 2, 1, 3, 100.00, 3, '2019-12-02 12:44:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (86, 2, 1, 3, 100.00, 3, '2019-12-02 12:44:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (87, 2, 1, 3, 100.00, 3, '2019-12-02 12:45:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (89, 2, 1, 3, 100.00, 3, '2019-12-02 12:46:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (91, 2, 1, 3, 100.00, 3, '2019-12-02 12:49:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (92, 2, 1, 3, 123.00, 3, '2019-12-02 12:50:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (93, 2, 1, 3, 123.00, 3, '2019-12-02 12:51:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (94, 2, 1, 2, 123.00, 3, '2019-12-02 12:55:12', 1, '');
INSERT INTO `records_consumption` VALUES (95, 2, 1, 3, 100.00, 3, '2019-12-02 12:59:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (96, 2, 1, 3, 123.00, 3, '2019-12-02 12:59:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (97, 2, 1, 2, 12.00, 3, '2019-12-02 13:00:04', 1, '');
INSERT INTO `records_consumption` VALUES (100, 2, 1, 1, 12.00, 3, '2019-12-02 13:07:40', 1, '123');
INSERT INTO `records_consumption` VALUES (102, NULL, 1, 1, 1.00, 3, '2019-12-02 13:20:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (103, NULL, 1, 1, 123.00, 3, '2019-12-02 13:23:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (104, NULL, 1, 1, 123.00, 3, '2019-12-02 13:23:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (105, 1, 4, 5, 1000.00, 0, '2019-12-02 18:16:31', 1, '4号员工给客户退余额10元');
INSERT INTO `records_consumption` VALUES (106, 1, 1, 3, 100.00, 3, '2019-12-03 09:53:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (107, NULL, 1, 1, 123.00, 3, '2019-12-03 10:09:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (108, 1, 1, 3, 100.00, 3, '2019-12-03 10:11:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (109, 1, 1, 3, 100.00, 3, '2019-12-03 10:11:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (110, 1, 1, 2, 123.00, 1, '2019-12-03 10:16:20', 1, '');
INSERT INTO `records_consumption` VALUES (111, 1, 1, 2, 10.00, 1, '2019-12-03 10:29:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (112, 1, 1, 2, 10.00, 1, '2019-12-03 10:59:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (113, 1, 1, 2, 123.00, 2, '2019-12-03 11:13:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (114, 1, 1, 2, 123.00, 2, '2019-12-03 11:15:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (115, 1, 1, 3, 100.00, 3, '2019-12-03 11:16:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (116, 1, 1, 2, 123.00, 2, '2019-12-03 13:08:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (117, 2, 1, 2, 123.00, 1, '2019-12-03 13:15:14', 1, '');
INSERT INTO `records_consumption` VALUES (118, 2, 1, 3, 12.00, 1, '2019-12-04 00:54:33', 1, '');
INSERT INTO `records_consumption` VALUES (119, 2, 1, 2, 12.00, 1, '2019-12-04 00:54:54', 1, '');
INSERT INTO `records_consumption` VALUES (120, NULL, 1, 1, 1.00, 3, '2019-12-04 01:10:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (121, NULL, 1, 1, 1.00, 3, '2019-12-04 01:15:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (122, 1, 1, 1, 1.00, 3, '2019-12-04 01:24:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (123, 1, 1, 1, 12.00, 3, '2019-12-04 01:25:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (124, 2, 1, 1, 12.00, 2, '2019-12-04 01:51:15', 1, '');
INSERT INTO `records_consumption` VALUES (125, 2, 1, 1, 12.00, 2, '2019-12-04 01:51:53', 1, '');
INSERT INTO `records_consumption` VALUES (126, 3, 4, 2, 100.00, 3, '2019-12-05 10:10:40', 1, 'cus_1 80元办卡');
INSERT INTO `records_consumption` VALUES (127, 1, 4, 2, 80.00, 3, '2019-12-05 10:19:20', 1, 'cus_1 80元办卡');
INSERT INTO `records_consumption` VALUES (128, 1, 1, 1, 12.00, 2, '2019-12-07 01:14:09', 1, '');
INSERT INTO `records_consumption` VALUES (129, NULL, 1, 1, 20.00, 3, '2019-12-07 01:20:09', 1, NULL);
INSERT INTO `records_consumption` VALUES (130, NULL, 1, 1, 12.00, 3, '2019-12-07 01:25:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (131, NULL, 1, 1, 123.00, 3, '2019-12-07 01:27:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (132, 1, 1, 1, 12.00, 3, '2019-12-07 01:29:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (133, 2, 1, 4, 10.00, 3, '2019-12-07 07:11:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (134, 2, 1, 4, 10.00, 3, '2019-12-07 07:12:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (135, 2, 1, 4, 10.00, 3, '2019-12-07 07:12:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (136, 2, 1, 4, 10.00, 3, '2019-12-07 07:13:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (137, 2, 1, 1, 20.00, 1, '2019-12-07 07:13:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (138, 2, 1, 1, 20.00, 1, '2019-12-07 07:13:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (139, 2, 1, 1, 20.00, 1, '2019-12-07 07:14:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (140, 2, 1, 4, 10.00, 3, '2019-12-07 07:16:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (141, 2, 1, 4, 10.00, 3, '2019-12-07 07:31:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (142, 2, 1, 4, 10.00, 3, '2019-12-07 07:32:11', 1, NULL);
INSERT INTO `records_consumption` VALUES (143, 2, 1, 4, 10.00, 3, '2019-12-07 07:34:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (144, 2, 1, 1, 20.00, 1, '2019-12-07 07:34:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (145, 2, 1, 1, 20.00, 1, '2019-12-07 07:37:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (146, 2, 1, 1, 20.00, 1, '2019-12-07 07:43:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (147, 2, 1, 1, 20.00, 1, '2019-12-07 07:43:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (148, 2, 1, 1, 20.00, 1, '2019-12-07 07:43:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (149, 2, 1, 1, 20.00, 1, '2019-12-07 07:43:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (150, 2, 1, 4, 10.00, 1, '2019-12-07 07:46:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (151, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (152, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (153, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (154, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (155, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (156, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (157, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (158, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (159, 1, 4, 4, 10.00, 1, '2019-12-07 08:27:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (160, 1, 6, 4, 10.00, 1, '2019-12-07 08:28:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (161, 1, 5, 4, 10.00, 1, '2019-12-07 08:28:40', 1, NULL);
INSERT INTO `records_consumption` VALUES (162, 1, 5, 4, 10.00, 1, '2019-12-07 08:28:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (163, 1, 5, 4, 10.00, 1, '2019-12-07 08:28:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (164, 1, 5, 1, 20.00, 1, '2019-12-07 08:29:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (165, 1, 5, 4, 10.00, 1, '2019-12-07 08:31:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (166, 1, 5, 4, 10.00, 1, '2019-12-07 08:31:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (167, 1, 5, 4, 10.00, 1, '2019-12-07 08:31:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (168, 1, 5, 4, 10.00, 1, '2019-12-07 08:31:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (169, 1, 5, 4, 10.00, 1, '2019-12-07 08:31:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (170, 1, 5, 1, 20.00, 1, '2019-12-07 08:31:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (171, 1, 5, 4, 10.00, 1, '2019-12-07 08:31:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (172, 1, 5, 1, 20.00, 1, '2019-12-07 08:31:57', 1, NULL);
INSERT INTO `records_consumption` VALUES (173, 1, 5, 1, 20.00, 1, '2019-12-07 08:31:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (174, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (175, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (176, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (177, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (178, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (179, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (180, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (181, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (182, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (183, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (184, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (185, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (186, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (187, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (188, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (189, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (190, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (191, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (192, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (193, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (194, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (195, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (196, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (197, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:40', 1, NULL);
INSERT INTO `records_consumption` VALUES (198, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (199, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:48', 1, NULL);
INSERT INTO `records_consumption` VALUES (200, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (201, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (202, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (203, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (204, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:54', 1, NULL);
INSERT INTO `records_consumption` VALUES (205, 1, 5, 1, 20.00, 1, '2019-12-07 08:32:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (206, 1, 5, 1, 20.00, 1, '2019-12-07 08:33:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (207, 1, 5, 4, 10.00, 1, '2019-12-07 08:33:10', 1, NULL);
INSERT INTO `records_consumption` VALUES (208, 1, 5, 1, 20.00, 1, '2019-12-07 08:34:12', 1, NULL);
INSERT INTO `records_consumption` VALUES (209, 1, 5, 1, 20.00, 1, '2019-12-07 08:34:14', 1, NULL);
INSERT INTO `records_consumption` VALUES (210, 1, 5, 1, 20.00, 1, '2019-12-07 08:34:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (211, 1, 5, 4, 10.00, 1, '2019-12-07 08:34:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (212, 1, 5, 1, 20.00, 1, '2019-12-07 08:34:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (213, 1, 5, 4, 10.00, 1, '2019-12-07 08:34:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (214, 1, 5, 4, 10.00, 1, '2019-12-07 08:34:28', 1, NULL);
INSERT INTO `records_consumption` VALUES (215, 1, 5, 4, 10.00, 1, '2019-12-07 08:34:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (216, 1, 5, 4, 10.00, 1, '2019-12-07 08:34:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (217, 1, 5, 4, 10.00, 1, '2019-12-07 08:34:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (218, 1, 5, 4, 10.00, 1, '2019-12-07 08:38:38', 1, NULL);
INSERT INTO `records_consumption` VALUES (219, 1, 5, 4, 10.00, 1, '2019-12-07 08:40:14', 1, NULL);
INSERT INTO `records_consumption` VALUES (220, 1, 4, 4, 10.00, 1, '2019-12-07 08:43:07', 1, NULL);
INSERT INTO `records_consumption` VALUES (221, 1, 4, 4, 10.00, 1, '2019-12-07 08:43:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (222, 1, 4, 4, 10.00, 1, '2019-12-07 08:43:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (223, 1, 4, 4, 10.00, 1, '2019-12-07 08:45:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (224, 1, 4, 4, 10.00, 1, '2019-12-07 08:56:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (225, 1, 1, 2, 12.00, 3, '2019-12-07 09:03:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (226, 1, 4, 3, 100.00, 3, '2019-12-07 09:10:00', 1, NULL);
INSERT INTO `records_consumption` VALUES (227, 1, 4, 2, 12.00, 2, '2019-12-07 09:17:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (228, 1, 4, 4, 10.00, 1, '2019-12-07 09:22:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (229, 1, 4, 4, 10.00, 1, '2019-12-07 09:22:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (230, 1, 4, 4, 10.00, 1, '2019-12-07 09:22:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (231, 1, 4, 4, 10.00, 1, '2019-12-07 09:22:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (232, 1, 4, 1, 12.00, 3, '2019-12-07 09:23:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (233, NULL, 4, 1, 123.00, 3, '2019-12-07 09:26:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (234, 1, 4, 2, 123.00, 3, '2019-12-07 09:51:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (235, NULL, 4, 1, 12.00, 3, '2019-12-07 09:53:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (236, 1, 5, 1, 12.00, 2, '2019-12-07 09:53:48', 1, '');
INSERT INTO `records_consumption` VALUES (237, 1, 4, 1, 12.00, 3, '2019-12-07 09:54:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (238, 1, 4, 4, 10.00, 1, '2019-12-07 09:54:14', 1, NULL);
INSERT INTO `records_consumption` VALUES (239, 1, 4, 2, 123.00, 2, '2019-12-07 10:47:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (240, 1, 8, 2, 12.00, 3, '2019-12-07 10:47:43', 1, NULL);
INSERT INTO `records_consumption` VALUES (241, 4, 6, 2, 12.00, 3, '2019-12-07 10:48:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (242, 1, 6, 2, 12.00, 3, '2019-12-07 10:48:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (243, 1, 5, 2, 123.00, 3, '2019-12-07 10:48:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (244, 4, 7, 2, 12.00, 3, '2019-12-07 10:49:01', 1, NULL);
INSERT INTO `records_consumption` VALUES (245, 1, 5, 4, 10.00, 1, '2019-12-07 10:50:48', 1, NULL);
INSERT INTO `records_consumption` VALUES (246, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (247, 1, 5, 4, 10.00, 1, '2019-12-07 10:50:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (248, 1, 5, 4, 10.00, 1, '2019-12-07 10:50:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (249, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (250, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (251, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (252, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:57', 1, NULL);
INSERT INTO `records_consumption` VALUES (253, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:57', 1, NULL);
INSERT INTO `records_consumption` VALUES (254, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (255, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (256, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (257, 1, 5, 1, 20.00, 1, '2019-12-07 10:50:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (258, 1, 5, 1, 20.00, 1, '2019-12-07 10:51:00', 1, NULL);
INSERT INTO `records_consumption` VALUES (259, 1, 5, 1, 20.00, 1, '2019-12-07 10:51:00', 1, NULL);
INSERT INTO `records_consumption` VALUES (260, 1, 5, 1, 20.00, 1, '2019-12-07 10:51:01', 1, NULL);
INSERT INTO `records_consumption` VALUES (261, 1, 5, 4, 10.00, 1, '2019-12-07 10:51:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (262, 1, 6, 1, 20.00, 1, '2019-12-07 10:51:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (263, 1, 6, 4, 10.00, 1, '2019-12-07 10:51:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (264, 1, 6, 4, 10.00, 1, '2019-12-07 10:51:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (265, NULL, 12, 1, 122.00, 3, '2019-12-07 11:11:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (266, 1, 12, 1, 20.00, 1, '2019-12-07 11:13:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (267, 1, 12, 1, 20.00, 1, '2019-12-07 11:13:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (268, 1, 12, 1, 20.00, 1, '2019-12-07 11:14:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (269, 1, 12, 1, 20.00, 1, '2019-12-07 11:14:06', 1, NULL);
INSERT INTO `records_consumption` VALUES (270, 1, 4, 1, 12.00, 3, '2019-12-07 11:15:48', 1, NULL);
INSERT INTO `records_consumption` VALUES (271, 1, 12, 4, 10.00, 1, '2019-12-07 11:18:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (272, 1, 12, 4, 10.00, 1, '2019-12-07 11:18:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (273, 1, 12, 4, 10.00, 1, '2019-12-07 11:18:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (274, 1, 12, 4, 10.00, 1, '2019-12-07 11:18:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (275, 1, 12, 4, 10.00, 1, '2019-12-07 11:18:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (276, 1, 12, 4, 10.00, 1, '2019-12-07 11:18:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (277, 1, 12, 1, 20.00, 1, '2019-12-07 11:19:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (278, 1, 12, 1, 20.00, 1, '2019-12-07 11:19:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (279, 1, 12, 1, 20.00, 1, '2019-12-07 11:19:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (280, 1, 12, 1, 20.00, 1, '2019-12-07 11:19:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (281, 1, 12, 1, 20.00, 1, '2019-12-07 11:19:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (282, 1, 12, 1, 20.00, 1, '2019-12-07 11:19:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (283, 1, 7, 1, 20.00, 1, '2019-12-07 11:25:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (284, 1, 7, 1, 20.00, 1, '2019-12-07 11:25:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (285, 1, 7, 1, 20.00, 1, '2019-12-07 11:25:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (286, 1, 7, 1, 20.00, 1, '2019-12-07 11:25:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (287, 1, 7, 1, 20.00, 1, '2019-12-07 11:25:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (288, 1, 7, 1, 20.00, 1, '2019-12-07 11:25:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (289, 1, 7, 4, 10.00, 1, '2019-12-07 11:36:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (290, 1, 7, 4, 10.00, 1, '2019-12-07 11:36:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (291, 1, 7, 4, 10.00, 1, '2019-12-07 11:36:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (292, 1, 7, 4, 10.00, 1, '2019-12-07 11:36:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (293, 1, 7, 4, 10.00, 1, '2019-12-07 11:36:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (294, 1, 7, 4, 10.00, 1, '2019-12-07 11:36:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (295, 1, 6, 4, 10.00, 1, '2019-12-07 11:40:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (296, NULL, 5, 1, 111.00, 3, '2019-12-07 12:31:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (297, 1, 5, 1, 1.00, 2, '2019-12-07 12:40:09', 1, '');
INSERT INTO `records_consumption` VALUES (298, NULL, 4, 1, 123.00, 3, '2019-12-07 13:16:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (299, 1, 4, 4, 20.00, 1, '2019-12-07 13:17:15', 1, NULL);
INSERT INTO `records_consumption` VALUES (300, 1, 4, 4, 20.00, 1, '2019-12-07 13:17:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (301, 1, 4, 3, 100.00, 3, '2019-12-07 13:19:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (302, 1, 4, 3, 100.00, 3, '2019-12-07 13:19:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (303, 1, 5, 1, 12.00, 3, '2019-12-07 13:27:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (304, 1, 6, 1, 12.00, 3, '2019-12-07 13:28:07', 1, NULL);
INSERT INTO `records_consumption` VALUES (305, 1, 6, 4, 20.00, 1, '2019-12-07 13:28:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (306, 6, 8, 3, 99.00, 3, '2019-12-07 13:47:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (307, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (308, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (309, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (310, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (311, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (312, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (313, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (314, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (315, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (316, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (317, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (318, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (319, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (320, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (321, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (322, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (323, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (324, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (325, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (326, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (327, 1, 4, 4, 20.00, 1, '2019-12-11 11:31:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (328, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (329, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (330, 1, 4, 1, 20.00, 1, '2019-12-11 11:31:53', 1, NULL);
INSERT INTO `records_consumption` VALUES (331, 8, 5, 2, 100.00, 3, '2019-12-12 03:16:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (332, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (333, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (334, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (335, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (336, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (337, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (338, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (339, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (340, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:17', 1, NULL);
INSERT INTO `records_consumption` VALUES (341, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (342, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (343, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (344, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (345, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (346, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (347, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (348, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (349, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (350, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (351, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (352, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (353, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (354, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (355, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (356, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (357, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (358, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (359, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (360, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (361, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (362, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (363, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (364, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (365, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (366, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (367, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (368, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (369, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (370, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (371, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (372, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (373, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (374, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (375, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (376, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (377, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (378, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (379, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (380, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (381, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (382, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (383, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (384, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (385, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (386, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (387, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (388, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (389, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (390, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (391, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (392, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (393, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (394, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (395, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (396, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (397, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (398, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (399, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (400, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (401, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (402, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (403, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (404, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (405, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (406, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (407, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (408, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (409, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (410, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (411, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (412, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (413, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (414, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (415, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (416, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (417, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (418, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (419, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (420, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (421, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (422, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (423, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (424, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (425, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (426, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (427, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (428, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (429, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (430, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (431, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (432, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (433, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (434, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (435, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (436, 1, 6, 1, 20.00, 1, '2019-12-12 03:17:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (437, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (438, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (439, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (440, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (441, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (442, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (443, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (444, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (445, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (446, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (447, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (448, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (449, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (450, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (451, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (452, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (453, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (454, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (455, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (456, 1, 6, 4, 20.00, 1, '2019-12-12 03:17:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (457, 2, 5, 1, 12.00, 3, '2019-12-12 06:42:07', 1, NULL);
INSERT INTO `records_consumption` VALUES (458, 1, 8, 1, 12.00, 3, '2019-12-12 06:59:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (459, 1, 6, 1, 12.00, 3, '2019-12-12 07:03:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (460, 1, 5, 3, 10000.00, 3, '2019-12-12 07:27:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (461, 1, 5, 2, 10000.00, 3, '2019-12-12 07:39:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (462, 1, 6, 4, 800.00, 1, '2019-12-12 07:42:38', 1, NULL);
INSERT INTO `records_consumption` VALUES (463, 1, 5, 4, 600.00, 1, '2019-12-12 07:45:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (464, 1, 5, 4, 1200.00, 1, '2019-12-12 07:45:50', 1, NULL);
INSERT INTO `records_consumption` VALUES (465, 1, 5, 4, 2400.00, 1, '2019-12-12 07:45:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (466, 1, 5, 4, 4620.00, 1, '2019-12-12 07:46:45', 1, NULL);
INSERT INTO `records_consumption` VALUES (467, 1, 6, 4, 20.00, 1, '2019-12-12 07:48:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (468, 1, 6, 4, 0.00, 1, '2019-12-12 07:48:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (469, 1, 6, 4, 20.00, 1, '2019-12-12 07:48:43', 1, NULL);
INSERT INTO `records_consumption` VALUES (470, 1, 6, 4, 0.00, 1, '2019-12-12 07:48:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (471, 1, 6, 4, 20.00, 1, '2019-12-12 07:48:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (472, 1, 6, 4, 0.00, 1, '2019-12-12 07:48:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (473, 1, 6, 4, 20.00, 1, '2019-12-12 07:48:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (474, 1, 6, 4, 20.00, 1, '2019-12-12 07:49:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (475, 1, 5, 4, 0.00, 1, '2019-12-12 07:50:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (476, 1, 6, 4, 20.00, 1, '2019-12-12 07:52:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (477, 1, 6, 4, 200.00, 1, '2019-12-12 07:52:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (478, 1, 6, 4, 20.00, 1, '2019-12-12 07:52:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (479, 1, 6, 4, 20.00, 1, '2019-12-12 07:52:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (480, 1, 6, 4, 200.00, 1, '2019-12-12 07:52:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (481, 1, 6, 4, 200.00, 1, '2019-12-12 07:53:01', 1, NULL);
INSERT INTO `records_consumption` VALUES (482, 1, 5, 4, 20.00, 1, '2019-12-12 07:55:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (483, 1, 5, 4, 20.00, 1, '2019-12-12 07:55:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (484, 1, 5, 4, 200.00, 1, '2019-12-12 07:55:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (485, 1, 5, 1, 20.00, 1, '2019-12-12 07:55:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (486, 1, 5, 1, 20.00, 1, '2019-12-12 07:55:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (487, 1, 5, 4, 200.00, 1, '2019-12-12 07:55:38', 1, NULL);
INSERT INTO `records_consumption` VALUES (488, 1, 5, 1, 20.00, 1, '2019-12-12 07:55:40', 1, NULL);
INSERT INTO `records_consumption` VALUES (489, 1, 5, 4, 200.00, 1, '2019-12-12 07:55:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (490, NULL, 6, 1, 12.00, 3, '2019-12-12 08:07:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (491, NULL, 7, 1, 20.00, 3, '2019-12-12 08:07:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (492, NULL, 5, 1, 123.00, 3, '2019-12-12 08:07:57', 1, NULL);
INSERT INTO `records_consumption` VALUES (493, NULL, 5, 1, 12.00, 3, '2019-12-12 08:08:15', 1, NULL);
INSERT INTO `records_consumption` VALUES (494, NULL, 6, 1, 12.00, 3, '2019-12-12 08:18:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (495, NULL, 6, 1, 12.00, 3, '2019-12-12 08:19:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (496, NULL, 5, 1, 12.00, 3, '2019-12-12 08:22:09', 1, NULL);
INSERT INTO `records_consumption` VALUES (497, 1, 6, 1, 40.00, 1, '2019-12-12 08:37:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (498, 1, 6, 1, 20.00, 1, '2019-12-12 08:37:12', 1, NULL);
INSERT INTO `records_consumption` VALUES (499, 1, 6, 4, 40.00, 1, '2019-12-12 08:37:18', 1, NULL);
INSERT INTO `records_consumption` VALUES (500, 1, 6, 1, 200.00, 1, '2019-12-12 08:39:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (501, 1, 6, 1, 220.00, 1, '2019-12-12 08:40:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (502, 1, 6, 1, 100.00, 1, '2019-12-12 08:40:10', 1, NULL);
INSERT INTO `records_consumption` VALUES (503, 1, 6, 1, 60.00, 1, '2019-12-12 08:40:22', 1, NULL);
INSERT INTO `records_consumption` VALUES (504, 1, 5, 4, 0.00, 2, '2019-12-12 08:45:31', 1, NULL);
INSERT INTO `records_consumption` VALUES (505, 1, 5, 4, 0.00, 2, '2019-12-12 08:45:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (506, 1, 5, 4, 0.00, 2, '2019-12-12 08:46:28', 1, NULL);
INSERT INTO `records_consumption` VALUES (507, 1, 5, 4, 0.00, 2, '2019-12-12 08:46:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (508, 1, 5, 4, 0.00, 2, '2019-12-12 08:46:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (509, 1, 5, 4, 0.00, 2, '2019-12-12 08:46:37', 1, NULL);
INSERT INTO `records_consumption` VALUES (510, 1, 8, 4, 0.00, 2, '2019-12-12 11:57:28', 1, NULL);
INSERT INTO `records_consumption` VALUES (511, 1, 8, 4, 0.00, 2, '2019-12-12 11:57:32', 1, NULL);
INSERT INTO `records_consumption` VALUES (512, 1, 7, 4, 40.00, 2, '2019-12-12 12:02:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (513, 1, 7, 4, 40.00, 2, '2019-12-12 12:02:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (514, 1, 7, 1, 140.00, 1, '2019-12-12 12:02:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (515, 1, 7, 4, 200.00, 2, '2019-12-12 12:02:10', 1, NULL);
INSERT INTO `records_consumption` VALUES (516, 1, 7, 1, 120.00, 1, '2019-12-12 12:02:13', 1, NULL);
INSERT INTO `records_consumption` VALUES (517, 1, 7, 4, 80.00, 2, '2019-12-12 12:02:16', 1, NULL);
INSERT INTO `records_consumption` VALUES (518, 1, 8, 4, 20.00, 2, '2019-12-12 12:07:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (519, 1, 8, 4, 20.00, 2, '2019-12-12 12:07:25', 1, NULL);
INSERT INTO `records_consumption` VALUES (520, 1, 8, 4, 1000.00, 2, '2019-12-12 12:07:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (521, 1, 8, 1, 140.00, 1, '2019-12-12 12:07:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (522, 1, 8, 4, 200.00, 2, '2019-12-12 12:07:33', 1, NULL);
INSERT INTO `records_consumption` VALUES (523, 1, 8, 4, 20.00, 2, '2019-12-12 12:07:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (524, 1, 8, 4, 120.00, 2, '2019-12-12 12:07:40', 1, NULL);
INSERT INTO `records_consumption` VALUES (525, 1, 8, 4, 60.00, 2, '2019-12-12 12:07:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (526, 1, 8, 1, 100.00, 1, '2019-12-12 12:07:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (527, 1, 8, 4, 600.00, 2, '2019-12-12 12:07:48', 1, NULL);
INSERT INTO `records_consumption` VALUES (528, 1, 6, 1, 1280.00, 1, '2019-12-12 12:09:48', 1, NULL);
INSERT INTO `records_consumption` VALUES (529, 1, 6, 1, 180.00, 1, '2019-12-12 12:09:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (530, 1, 6, 4, 0.00, 2, '2019-12-12 12:09:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (531, 1, 6, 2, 123.00, 3, '2019-12-12 12:32:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (532, 3, 8, 4, 0.00, 2, '2019-12-12 12:58:19', 1, NULL);
INSERT INTO `records_consumption` VALUES (533, 3, 8, 4, 0.00, 2, '2019-12-12 12:58:20', 1, NULL);
INSERT INTO `records_consumption` VALUES (534, 1, 6, 4, 40.00, 2, '2019-12-12 12:59:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (537, 3, 8, 4, 0.00, 2, '2019-12-12 13:01:39', 1, NULL);
INSERT INTO `records_consumption` VALUES (538, 3, 8, 4, 0.00, 2, '2019-12-12 13:01:41', 1, NULL);
INSERT INTO `records_consumption` VALUES (539, 1, 8, 4, 20.00, 2, '2019-12-12 13:02:11', 1, NULL);
INSERT INTO `records_consumption` VALUES (540, 1, 7, 4, 100.00, 2, '2019-12-12 13:05:07', 1, NULL);
INSERT INTO `records_consumption` VALUES (541, 1, 7, 4, 80.00, 2, '2019-12-12 13:05:10', 1, NULL);
INSERT INTO `records_consumption` VALUES (542, 3, 8, 4, 0.00, 2, '2019-12-12 13:05:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (543, 3, 8, 4, 0.00, 2, '2019-12-12 13:05:28', 1, NULL);
INSERT INTO `records_consumption` VALUES (544, 3, 8, 1, 20.00, 1, '2019-12-12 13:05:29', 1, NULL);
INSERT INTO `records_consumption` VALUES (545, 1, 8, 4, 40.00, 2, '2019-12-12 13:16:51', 1, NULL);
INSERT INTO `records_consumption` VALUES (546, 3, 8, 1, 80.00, 1, '2019-12-12 13:16:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (547, 1, 8, 3, 10.00, 3, '2019-12-13 02:36:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (548, 1, 7, 1, 7.00, 3, '2019-12-13 02:37:30', 1, NULL);
INSERT INTO `records_consumption` VALUES (549, 1, 7, 4, 22.00, 2, '2019-12-13 02:45:56', 1, NULL);
INSERT INTO `records_consumption` VALUES (550, 1, 8, 1, 8.00, 3, '2019-12-13 03:02:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (551, 4, 4, 1, 20.00, 3, '2019-12-13 03:05:15', 1, '现金结算4号项目');
INSERT INTO `records_consumption` VALUES (553, 1, 7, 1, 7.00, 2, '2019-12-13 03:16:55', 1, '1212');
INSERT INTO `records_consumption` VALUES (554, 1, 7, 1, 7.00, 3, '2019-12-13 03:17:13', 1, '');
INSERT INTO `records_consumption` VALUES (555, 1, 8, 1, 20.00, 3, '2019-12-13 03:21:11', 1, '');
INSERT INTO `records_consumption` VALUES (556, 1, 7, 1, 20.00, 3, '2019-12-13 03:21:18', 1, '');
INSERT INTO `records_consumption` VALUES (557, 1, 7, 1, 20.00, 3, '2019-12-13 03:28:29', 1, '');
INSERT INTO `records_consumption` VALUES (569, 1, 8, 2, 100.00, 2, '2019-12-15 12:57:12', 1, NULL);
INSERT INTO `records_consumption` VALUES (570, 1, 8, 2, 10000.00, 3, '2019-12-15 16:19:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (571, 2, 4, 2, 100.00, 3, '2019-12-15 18:50:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (572, 2, 12, 2, 222.00, 2, '2019-12-15 18:50:15', 1, NULL);
INSERT INTO `records_consumption` VALUES (573, 2, 8, 1, 20.00, 1, '2019-12-15 18:50:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (574, 2, 8, 1, 20.00, 1, '2019-12-15 18:50:28', 1, NULL);
INSERT INTO `records_consumption` VALUES (575, 5, 4, 2, 100.00, 3, '2019-12-16 05:52:54', 1, NULL);
INSERT INTO `records_consumption` VALUES (576, 4, 8, 1, 20.00, 3, '2019-12-16 05:53:42', 1, '');
INSERT INTO `records_consumption` VALUES (577, 5, 8, 1, 20.00, 1, '2019-12-16 05:54:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (578, 5, 8, 3, 100.00, 3, '2019-12-16 05:55:36', 1, NULL);
INSERT INTO `records_consumption` VALUES (579, 7, 8, 3, 100.00, 3, '2019-12-16 05:55:46', 1, NULL);
INSERT INTO `records_consumption` VALUES (580, 1, 8, 1, 12.00, 3, '2019-12-16 10:25:29', 1, '');
INSERT INTO `records_consumption` VALUES (581, NULL, 4, 1, 20.00, 3, '2019-12-16 11:31:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (582, NULL, 8, 1, 20.00, 3, '2019-12-16 11:40:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (583, NULL, 8, 1, 20.00, 3, '2019-12-16 11:42:52', 1, NULL);
INSERT INTO `records_consumption` VALUES (584, 1, 8, 1, 20.00, 3, '2019-12-16 11:45:45', 1, '');
INSERT INTO `records_consumption` VALUES (585, NULL, 4, 1, 20.00, 3, '2019-12-16 11:49:44', 1, NULL);
INSERT INTO `records_consumption` VALUES (586, 1, 8, 2, 12.00, 2, '2019-12-16 11:57:43', 1, NULL);
INSERT INTO `records_consumption` VALUES (587, NULL, 8, 1, 20.00, 3, '2019-12-16 12:00:23', 1, NULL);
INSERT INTO `records_consumption` VALUES (588, NULL, 8, 1, 20.00, 3, '2019-12-16 12:01:47', 1, NULL);
INSERT INTO `records_consumption` VALUES (589, NULL, 8, 1, 20.00, 3, '2019-12-16 12:03:24', 1, NULL);
INSERT INTO `records_consumption` VALUES (590, NULL, 8, 1, 20.00, 3, '2019-12-16 12:08:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (591, NULL, 8, 1, 20.00, 3, '2019-12-16 12:09:00', 1, NULL);
INSERT INTO `records_consumption` VALUES (592, NULL, 4, 1, 20.00, 3, '2019-12-16 12:09:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (593, NULL, 4, 1, 20.00, 3, '2019-12-16 12:09:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (594, NULL, 8, 1, 20.00, 3, '2019-12-16 12:10:43', 1, NULL);
INSERT INTO `records_consumption` VALUES (595, NULL, 8, 1, 20.00, 3, '2019-12-16 12:12:06', 1, NULL);
INSERT INTO `records_consumption` VALUES (596, NULL, 8, 1, 20.00, 3, '2019-12-16 12:13:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (597, NULL, 8, 1, 20.00, 3, '2019-12-16 12:16:38', 1, NULL);
INSERT INTO `records_consumption` VALUES (598, NULL, 8, 1, 20.00, 3, '2019-12-16 12:16:48', 1, NULL);
INSERT INTO `records_consumption` VALUES (599, NULL, 8, 1, 20.00, 3, '2019-12-16 12:21:49', 1, NULL);
INSERT INTO `records_consumption` VALUES (600, NULL, 4, 1, 20.00, 3, '2019-12-16 12:33:59', 1, NULL);
INSERT INTO `records_consumption` VALUES (601, NULL, 8, 1, 20.00, 3, '2019-12-16 12:35:35', 1, NULL);
INSERT INTO `records_consumption` VALUES (602, NULL, 4, 1, 20.00, 3, '2019-12-16 12:36:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (603, NULL, 8, 1, 20.00, 3, '2019-12-16 12:36:34', 1, NULL);
INSERT INTO `records_consumption` VALUES (604, NULL, 4, 1, 20.00, 3, '2019-12-16 12:39:27', 1, NULL);
INSERT INTO `records_consumption` VALUES (605, 1, 8, 2, 1111.00, 2, '2019-12-16 12:39:55', 1, NULL);
INSERT INTO `records_consumption` VALUES (606, 1, 8, 1, 20.00, 1, '2019-12-16 12:40:03', 1, NULL);
INSERT INTO `records_consumption` VALUES (607, 1, 8, 1, 20.00, 1, '2019-12-16 12:40:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (608, 1, 8, 1, 20.00, 1, '2019-12-16 12:40:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (609, 1, 8, 1, 20.00, 1, '2019-12-16 12:40:07', 1, NULL);
INSERT INTO `records_consumption` VALUES (610, 1, 8, 1, 20.00, 1, '2019-12-16 12:40:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (611, 1, 8, 4, 20.00, 2, '2019-12-16 12:42:09', 1, NULL);
INSERT INTO `records_consumption` VALUES (612, NULL, 8, 1, 20.00, 3, '2019-12-16 12:43:05', 1, NULL);
INSERT INTO `records_consumption` VALUES (613, 1, 8, 1, 20.00, 3, '2019-12-16 12:43:21', 1, '');
INSERT INTO `records_consumption` VALUES (614, NULL, 8, 1, 20.00, 3, '2019-12-16 12:46:04', 1, NULL);
INSERT INTO `records_consumption` VALUES (615, 1, 8, 2, 34.00, 2, '2019-12-16 12:46:15', 1, NULL);
INSERT INTO `records_consumption` VALUES (616, 1, 8, 2, 12.00, 3, '2019-12-16 12:46:26', 1, NULL);
INSERT INTO `records_consumption` VALUES (617, 1, 4, 1, 20.00, 2, '2019-12-16 12:47:10', 1, '');
INSERT INTO `records_consumption` VALUES (618, NULL, 8, 1, 20.00, 3, '2019-12-16 12:51:21', 1, NULL);
INSERT INTO `records_consumption` VALUES (619, 1, 8, 1, 20.00, 1, '2019-12-16 12:51:54', 1, NULL);
INSERT INTO `records_consumption` VALUES (620, 1, 8, 4, 200.00, 2, '2019-12-16 12:51:58', 1, NULL);
INSERT INTO `records_consumption` VALUES (621, 1, 8, 2, 100.00, 3, '2019-12-17 14:11:02', 1, NULL);
INSERT INTO `records_consumption` VALUES (622, 1, 8, 1, 20.00, 1, '2020-01-03 02:27:42', 1, NULL);
INSERT INTO `records_consumption` VALUES (623, NULL, 4, 1, 20.00, 3, '2020-01-03 02:28:08', 1, NULL);
INSERT INTO `records_consumption` VALUES (624, 1, 8, 1, 20.00, 3, '2020-01-03 02:41:23', 1, '');

-- ----------------------------
-- Table structure for records_turnover
-- ----------------------------
DROP TABLE IF EXISTS `records_turnover`;
CREATE TABLE `records_turnover`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime(0) DEFAULT NULL COMMENT '某一天（以天为单位）',
  `money_income` float(10, 2) DEFAULT NULL COMMENT '收入的钱：payType=3',
  `money_outcome` float(10, 2) DEFAULT NULL COMMENT '给客户退的钱（退余额和退卡）payType=0',
  `card_reduce` float(10, 2) DEFAULT NULL COMMENT '通过卡消费的钱数 payType=1',
  `balance_reduce` float(10, 2) DEFAULT NULL COMMENT '通过余额消费 payType=2',
  `sum_income` float(10, 2) DEFAULT NULL COMMENT '总的收入 money_income-money_outcome',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of records_turnover
-- ----------------------------
INSERT INTO `records_turnover` VALUES (1, '2019-11-09 16:00:00', 330.00, 20.00, 40.00, 80.00, 310.00);
INSERT INTO `records_turnover` VALUES (2, '2019-11-10 16:00:00', 470.00, 0.00, 40.00, 0.00, 470.00);
INSERT INTO `records_turnover` VALUES (6, '2019-11-12 16:00:00', 220.00, 20.00, 0.00, 0.00, 200.00);
INSERT INTO `records_turnover` VALUES (7, '2019-11-26 00:00:00', 1620.00, 0.00, 0.00, 0.00, 1620.00);
INSERT INTO `records_turnover` VALUES (8, '2019-12-01 16:00:00', 1663.00, 0.00, 0.00, 0.00, 1663.00);
INSERT INTO `records_turnover` VALUES (9, '2019-12-02 16:00:00', 523.00, 1000.00, 266.00, 369.00, -477.00);
INSERT INTO `records_turnover` VALUES (10, '2019-11-25 16:00:00', 259.00, 0.00, 0.00, 0.00, 259.00);
INSERT INTO `records_turnover` VALUES (11, '2019-12-03 16:00:00', 15.00, 0.00, 24.00, 24.00, 15.00);
INSERT INTO `records_turnover` VALUES (12, '2019-12-04 16:00:00', 180.00, 0.00, 0.00, 0.00, 180.00);
INSERT INTO `records_turnover` VALUES (13, '2019-12-07 00:00:00', 1392.00, 0.00, 2050.00, 159.00, 1392.00);
INSERT INTO `records_turnover` VALUES (14, '2019-12-06 16:00:00', 111.00, 0.00, 190.00, 1.00, 111.00);
INSERT INTO `records_turnover` VALUES (15, '2019-12-11 00:00:00', 0.00, 0.00, 480.00, 0.00, 0.00);
INSERT INTO `records_turnover` VALUES (16, '2019-12-12 00:00:00', 10382.00, 0.00, 13260.00, 620.00, 10362.00);
INSERT INTO `records_turnover` VALUES (17, '2019-12-11 16:00:00', 10080.00, 0.00, 3060.00, 2060.00, 10080.00);
INSERT INTO `records_turnover` VALUES (18, '2019-12-13 00:00:00', 112.00, 0.00, 0.00, 29.00, 12.00);
INSERT INTO `records_turnover` VALUES (19, '2019-12-15 00:00:00', 10000.00, 0.00, 0.00, 100.00, 10000.00);
INSERT INTO `records_turnover` VALUES (20, '2019-12-15 16:00:00', 100.00, 0.00, 40.00, 222.00, 100.00);
INSERT INTO `records_turnover` VALUES (21, '2019-12-16 00:00:00', 884.00, 0.00, 140.00, 1397.00, 884.00);
INSERT INTO `records_turnover` VALUES (22, '2019-12-16 16:00:00', 100.00, 0.00, 0.00, 0.00, 100.00);
INSERT INTO `records_turnover` VALUES (23, '2020-01-03 00:00:00', 40.00, 0.00, 20.00, 0.00, 40.00);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'root', '超级管理员');
INSERT INTO `role` VALUES (2, 'boss', '老板');
INSERT INTO `role` VALUES (3, 'manger', '店长');
INSERT INTO `role` VALUES (4, 'staff', '员工');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `permission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_permission_ibfk_1`(`role_id`) USING BTREE,
  INDEX `role_permission_ibfk_2`(`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (14, 3, 1);
INSERT INTO `role_permission` VALUES (15, 3, 2);
INSERT INTO `role_permission` VALUES (16, 3, 3);
INSERT INTO `role_permission` VALUES (17, 3, 4);
INSERT INTO `role_permission` VALUES (18, 3, 5);
INSERT INTO `role_permission` VALUES (19, 3, 6);
INSERT INTO `role_permission` VALUES (20, 3, 7);
INSERT INTO `role_permission` VALUES (34, 2, 1);
INSERT INTO `role_permission` VALUES (35, 2, 2);
INSERT INTO `role_permission` VALUES (36, 2, 3);
INSERT INTO `role_permission` VALUES (37, 2, 4);
INSERT INTO `role_permission` VALUES (38, 2, 5);
INSERT INTO `role_permission` VALUES (39, 2, 6);
INSERT INTO `role_permission` VALUES (40, 2, 7);
INSERT INTO `role_permission` VALUES (41, 2, 8);
INSERT INTO `role_permission` VALUES (42, 2, 9);
INSERT INTO `role_permission` VALUES (43, 2, 10);
INSERT INTO `role_permission` VALUES (44, 2, 11);
INSERT INTO `role_permission` VALUES (45, 2, 12);
INSERT INTO `role_permission` VALUES (46, 2, 13);
INSERT INTO `role_permission` VALUES (47, 2, 14);

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id（员工类型）',
  `pro_sum` float(10, 2) DEFAULT NULL COMMENT '任何方式支付前提下的完成收费项目的价值',
  `card_sum` float(10, 2) DEFAULT NULL COMMENT '任何方式支付前提下的完成办卡的价值',
  `make_money_income` float(10, 2) DEFAULT NULL COMMENT '招揽的用钱支付的营业额',
  `pro_add` float(10, 2) DEFAULT NULL COMMENT '做项目提成',
  `base_salary` float(10, 2) DEFAULT NULL COMMENT '底薪',
  `sum_salary` float(10, 2) DEFAULT NULL COMMENT '总的工资',
  `settle_date` datetime(0) DEFAULT NULL COMMENT '结算日期',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 314 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (69, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 11321.00, '2019-12-04 14:12:02', '修改时间：2019-12-11 15:38:34	修改原因：增加	工资改变：增加100.0元\n修改时间：2019-12-11 15:38:58	修改原因：.。。	工资改变：增加100.0元\n修改时间：2019-12-11 15:56:40	修改原因：。。。。	工资改变：增加100.0元\n');
INSERT INTO `salary` VALUES (70, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 14:13:00', NULL);
INSERT INTO `salary` VALUES (71, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 14:13:00', NULL);
INSERT INTO `salary` VALUES (73, 7, 20.00, 0.00, 0.00, 2.00, 6000.00, 6002.00, '2019-12-04 14:13:01', NULL);
INSERT INTO `salary` VALUES (76, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 14:14:00', NULL);
INSERT INTO `salary` VALUES (77, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 14:14:01', NULL);
INSERT INTO `salary` VALUES (78, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 14:14:01', NULL);
INSERT INTO `salary` VALUES (79, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 14:14:01', NULL);
INSERT INTO `salary` VALUES (80, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 14:15:00', NULL);
INSERT INTO `salary` VALUES (81, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 14:15:00', NULL);
INSERT INTO `salary` VALUES (82, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 14:15:00', NULL);
INSERT INTO `salary` VALUES (83, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 14:15:01', NULL);
INSERT INTO `salary` VALUES (84, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 14:15:01', NULL);
INSERT INTO `salary` VALUES (85, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:33:07', NULL);
INSERT INTO `salary` VALUES (86, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:33:07', NULL);
INSERT INTO `salary` VALUES (87, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:33:07', NULL);
INSERT INTO `salary` VALUES (88, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:33:07', NULL);
INSERT INTO `salary` VALUES (89, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:33:08', NULL);
INSERT INTO `salary` VALUES (90, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:34:01', NULL);
INSERT INTO `salary` VALUES (91, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:34:01', NULL);
INSERT INTO `salary` VALUES (92, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:34:01', NULL);
INSERT INTO `salary` VALUES (93, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:34:01', NULL);
INSERT INTO `salary` VALUES (94, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:34:01', NULL);
INSERT INTO `salary` VALUES (95, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:35:01', NULL);
INSERT INTO `salary` VALUES (96, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:35:01', NULL);
INSERT INTO `salary` VALUES (97, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:35:01', NULL);
INSERT INTO `salary` VALUES (98, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:35:02', NULL);
INSERT INTO `salary` VALUES (99, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:35:02', NULL);
INSERT INTO `salary` VALUES (100, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:36:01', NULL);
INSERT INTO `salary` VALUES (101, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:36:01', NULL);
INSERT INTO `salary` VALUES (102, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:36:01', NULL);
INSERT INTO `salary` VALUES (103, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:36:01', NULL);
INSERT INTO `salary` VALUES (104, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:36:02', NULL);
INSERT INTO `salary` VALUES (105, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:37:01', NULL);
INSERT INTO `salary` VALUES (106, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:37:01', NULL);
INSERT INTO `salary` VALUES (107, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:37:01', NULL);
INSERT INTO `salary` VALUES (108, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:37:01', NULL);
INSERT INTO `salary` VALUES (109, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:37:01', NULL);
INSERT INTO `salary` VALUES (110, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:38:00', NULL);
INSERT INTO `salary` VALUES (111, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:38:01', NULL);
INSERT INTO `salary` VALUES (112, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:38:01', NULL);
INSERT INTO `salary` VALUES (113, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:38:01', NULL);
INSERT INTO `salary` VALUES (114, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:38:01', NULL);
INSERT INTO `salary` VALUES (115, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:39:01', NULL);
INSERT INTO `salary` VALUES (116, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:39:01', NULL);
INSERT INTO `salary` VALUES (117, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:39:01', NULL);
INSERT INTO `salary` VALUES (118, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:39:01', NULL);
INSERT INTO `salary` VALUES (119, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:39:01', NULL);
INSERT INTO `salary` VALUES (120, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:40:00', NULL);
INSERT INTO `salary` VALUES (121, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:40:01', NULL);
INSERT INTO `salary` VALUES (122, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:40:01', NULL);
INSERT INTO `salary` VALUES (123, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:40:01', NULL);
INSERT INTO `salary` VALUES (124, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:40:01', NULL);
INSERT INTO `salary` VALUES (125, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:41:01', NULL);
INSERT INTO `salary` VALUES (126, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:41:01', NULL);
INSERT INTO `salary` VALUES (127, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:41:01', NULL);
INSERT INTO `salary` VALUES (128, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:41:01', NULL);
INSERT INTO `salary` VALUES (129, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:41:01', NULL);
INSERT INTO `salary` VALUES (130, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:42:00', NULL);
INSERT INTO `salary` VALUES (131, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:42:01', NULL);
INSERT INTO `salary` VALUES (132, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:42:01', NULL);
INSERT INTO `salary` VALUES (133, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:42:01', NULL);
INSERT INTO `salary` VALUES (134, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:42:01', NULL);
INSERT INTO `salary` VALUES (135, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:43:00', NULL);
INSERT INTO `salary` VALUES (136, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:43:01', NULL);
INSERT INTO `salary` VALUES (137, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:43:01', NULL);
INSERT INTO `salary` VALUES (138, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:43:01', NULL);
INSERT INTO `salary` VALUES (139, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:43:01', NULL);
INSERT INTO `salary` VALUES (140, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:44:00', NULL);
INSERT INTO `salary` VALUES (141, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:44:01', NULL);
INSERT INTO `salary` VALUES (142, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:44:01', NULL);
INSERT INTO `salary` VALUES (143, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:44:01', NULL);
INSERT INTO `salary` VALUES (144, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:44:01', NULL);
INSERT INTO `salary` VALUES (145, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:45:00', NULL);
INSERT INTO `salary` VALUES (146, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:45:01', NULL);
INSERT INTO `salary` VALUES (147, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:45:01', NULL);
INSERT INTO `salary` VALUES (148, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:45:01', NULL);
INSERT INTO `salary` VALUES (149, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:45:01', NULL);
INSERT INTO `salary` VALUES (150, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:46:00', NULL);
INSERT INTO `salary` VALUES (151, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:46:01', NULL);
INSERT INTO `salary` VALUES (152, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:46:01', NULL);
INSERT INTO `salary` VALUES (153, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:46:01', NULL);
INSERT INTO `salary` VALUES (154, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:46:01', NULL);
INSERT INTO `salary` VALUES (155, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:47:01', NULL);
INSERT INTO `salary` VALUES (156, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:47:01', NULL);
INSERT INTO `salary` VALUES (157, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:47:01', NULL);
INSERT INTO `salary` VALUES (158, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:47:01', NULL);
INSERT INTO `salary` VALUES (159, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:47:02', NULL);
INSERT INTO `salary` VALUES (160, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:48:00', NULL);
INSERT INTO `salary` VALUES (161, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:48:01', NULL);
INSERT INTO `salary` VALUES (162, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:48:01', NULL);
INSERT INTO `salary` VALUES (163, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:48:01', NULL);
INSERT INTO `salary` VALUES (164, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:48:01', NULL);
INSERT INTO `salary` VALUES (165, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:49:00', NULL);
INSERT INTO `salary` VALUES (166, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:49:01', NULL);
INSERT INTO `salary` VALUES (167, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:49:01', NULL);
INSERT INTO `salary` VALUES (168, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:49:01', NULL);
INSERT INTO `salary` VALUES (169, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:49:01', NULL);
INSERT INTO `salary` VALUES (170, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:50:01', NULL);
INSERT INTO `salary` VALUES (171, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:50:01', NULL);
INSERT INTO `salary` VALUES (172, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:50:01', NULL);
INSERT INTO `salary` VALUES (173, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:50:01', NULL);
INSERT INTO `salary` VALUES (174, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:50:01', NULL);
INSERT INTO `salary` VALUES (175, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:51:00', NULL);
INSERT INTO `salary` VALUES (176, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:51:01', NULL);
INSERT INTO `salary` VALUES (177, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:51:01', NULL);
INSERT INTO `salary` VALUES (178, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:51:01', NULL);
INSERT INTO `salary` VALUES (179, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:51:01', NULL);
INSERT INTO `salary` VALUES (180, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:52:00', NULL);
INSERT INTO `salary` VALUES (181, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:52:01', NULL);
INSERT INTO `salary` VALUES (182, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:52:01', NULL);
INSERT INTO `salary` VALUES (183, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:52:01', NULL);
INSERT INTO `salary` VALUES (184, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:52:01', NULL);
INSERT INTO `salary` VALUES (185, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:53:00', NULL);
INSERT INTO `salary` VALUES (186, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:53:01', NULL);
INSERT INTO `salary` VALUES (187, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:53:01', NULL);
INSERT INTO `salary` VALUES (188, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:53:01', NULL);
INSERT INTO `salary` VALUES (189, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:53:02', NULL);
INSERT INTO `salary` VALUES (190, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:54:00', NULL);
INSERT INTO `salary` VALUES (191, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:54:01', NULL);
INSERT INTO `salary` VALUES (192, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:54:01', NULL);
INSERT INTO `salary` VALUES (193, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:54:01', NULL);
INSERT INTO `salary` VALUES (194, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:54:01', NULL);
INSERT INTO `salary` VALUES (195, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:55:00', NULL);
INSERT INTO `salary` VALUES (198, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6000.00, '2019-12-04 15:55:01', NULL);
INSERT INTO `salary` VALUES (199, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:55:01', NULL);
INSERT INTO `salary` VALUES (200, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:56:00', NULL);
INSERT INTO `salary` VALUES (201, 5, 50.00, 160.00, 210.00, 0.00, 5000.00, 5210.00, '2019-12-04 15:56:01', NULL);
INSERT INTO `salary` VALUES (202, 6, 40.00, 440.00, 460.00, 10.00, 5000.00, 5470.00, '2019-12-04 15:56:01', NULL);
INSERT INTO `salary` VALUES (204, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2019-12-04 15:56:01', NULL);
INSERT INTO `salary` VALUES (205, 4, 80.00, 240.00, 410.00, 0.00, 4000.00, 4410.00, '2019-12-04 15:57:01', NULL);
INSERT INTO `salary` VALUES (213, 7, 20.00, 0.00, 0.00, 0.00, 6000.00, 6002.00, '2019-12-04 15:58:01', '修改时间：2019-12-13 12:24:01	修改原因：2恶气呃	工资改变：增加1.0元<br/>修改时间：2019-12-13 17:48:38	修改原因：2	工资改变：增加1.0元<br/>');
INSERT INTO `salary` VALUES (214, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 10041.00, '2019-12-04 15:58:01', '修改时间：2019-12-13 12:47:54	修改原因：大师傅	工资改变：增加21.0元<br/>修改时间：2019-12-13 12:48:03	修改原因：大师傅	工资改变：增加21.0元<br/>');
INSERT INTO `salary` VALUES (220, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:40:01', NULL);
INSERT INTO `salary` VALUES (221, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:40:02', NULL);
INSERT INTO `salary` VALUES (222, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:40:03', NULL);
INSERT INTO `salary` VALUES (223, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:40:06', NULL);
INSERT INTO `salary` VALUES (224, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:41:01', NULL);
INSERT INTO `salary` VALUES (225, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:41:02', NULL);
INSERT INTO `salary` VALUES (226, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:41:03', NULL);
INSERT INTO `salary` VALUES (227, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:41:05', NULL);
INSERT INTO `salary` VALUES (228, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:42:01', NULL);
INSERT INTO `salary` VALUES (229, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:42:02', NULL);
INSERT INTO `salary` VALUES (230, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:42:03', NULL);
INSERT INTO `salary` VALUES (231, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:42:06', NULL);
INSERT INTO `salary` VALUES (232, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:43:01', NULL);
INSERT INTO `salary` VALUES (233, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:43:02', NULL);
INSERT INTO `salary` VALUES (234, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:43:03', NULL);
INSERT INTO `salary` VALUES (235, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:43:05', NULL);
INSERT INTO `salary` VALUES (236, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:44:01', NULL);
INSERT INTO `salary` VALUES (237, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:44:02', NULL);
INSERT INTO `salary` VALUES (238, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:44:03', NULL);
INSERT INTO `salary` VALUES (239, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:44:06', NULL);
INSERT INTO `salary` VALUES (240, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:45:02', NULL);
INSERT INTO `salary` VALUES (241, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:45:04', NULL);
INSERT INTO `salary` VALUES (242, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:45:05', NULL);
INSERT INTO `salary` VALUES (243, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:45:08', NULL);
INSERT INTO `salary` VALUES (244, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:46:04', NULL);
INSERT INTO `salary` VALUES (245, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:46:08', NULL);
INSERT INTO `salary` VALUES (246, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:46:10', NULL);
INSERT INTO `salary` VALUES (247, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:46:20', NULL);
INSERT INTO `salary` VALUES (248, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:47:01', NULL);
INSERT INTO `salary` VALUES (249, 4, 554.00, 438.00, 977.00, 126.00, 111.00, 1214.00, '2019-12-15 18:47:02', NULL);
INSERT INTO `salary` VALUES (250, 12, 322.00, 0.00, 122.00, 52.00, 9999.00, 10173.00, '2019-12-15 18:47:03', NULL);
INSERT INTO `salary` VALUES (251, 5, 1435.00, 10223.00, 20505.00, 308.00, 1.00, 20814.00, '2019-12-15 18:47:05', NULL);
INSERT INTO `salary` VALUES (252, 8, 380.00, 10112.00, 10161.00, 80.00, 9999.00, 20240.00, '2019-12-15 18:48:01', NULL);
INSERT INTO `salary` VALUES (253, 4, 554.00, 438.00, 977.00, 0.00, 111.00, 1088.00, '2019-12-15 18:48:01', NULL);
INSERT INTO `salary` VALUES (254, 12, 322.00, 0.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:48:01', NULL);
INSERT INTO `salary` VALUES (255, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:48:02', NULL);
INSERT INTO `salary` VALUES (256, 8, 380.00, 10112.00, 10161.00, 0.00, 9999.00, 20160.00, '2019-12-15 18:49:00', NULL);
INSERT INTO `salary` VALUES (257, 4, 554.00, 438.00, 977.00, 0.00, 111.00, 1088.00, '2019-12-15 18:49:00', NULL);
INSERT INTO `salary` VALUES (258, 12, 322.00, 0.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:49:01', NULL);
INSERT INTO `salary` VALUES (259, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:49:01', NULL);
INSERT INTO `salary` VALUES (260, 8, 380.00, 10112.00, 10161.00, 0.00, 9999.00, 20160.00, '2019-12-15 18:50:00', NULL);
INSERT INTO `salary` VALUES (261, 4, 554.00, 438.00, 977.00, 0.00, 111.00, 1088.00, '2019-12-15 18:50:00', NULL);
INSERT INTO `salary` VALUES (262, 12, 322.00, 0.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:50:01', NULL);
INSERT INTO `salary` VALUES (263, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:50:01', NULL);
INSERT INTO `salary` VALUES (264, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:51:00', NULL);
INSERT INTO `salary` VALUES (265, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:51:00', NULL);
INSERT INTO `salary` VALUES (266, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:51:01', NULL);
INSERT INTO `salary` VALUES (267, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:51:01', NULL);
INSERT INTO `salary` VALUES (268, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:52:00', NULL);
INSERT INTO `salary` VALUES (269, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:52:00', NULL);
INSERT INTO `salary` VALUES (270, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:52:01', NULL);
INSERT INTO `salary` VALUES (271, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:52:01', NULL);
INSERT INTO `salary` VALUES (272, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:53:00', NULL);
INSERT INTO `salary` VALUES (273, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:53:01', NULL);
INSERT INTO `salary` VALUES (274, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:53:01', NULL);
INSERT INTO `salary` VALUES (275, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:53:01', NULL);
INSERT INTO `salary` VALUES (276, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:54:00', NULL);
INSERT INTO `salary` VALUES (277, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:54:00', NULL);
INSERT INTO `salary` VALUES (278, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:54:01', NULL);
INSERT INTO `salary` VALUES (279, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:54:01', NULL);
INSERT INTO `salary` VALUES (280, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:55:16', NULL);
INSERT INTO `salary` VALUES (281, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:55:16', NULL);
INSERT INTO `salary` VALUES (282, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:55:16', NULL);
INSERT INTO `salary` VALUES (283, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:55:16', NULL);
INSERT INTO `salary` VALUES (284, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:58:00', NULL);
INSERT INTO `salary` VALUES (285, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:58:01', NULL);
INSERT INTO `salary` VALUES (286, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:58:01', NULL);
INSERT INTO `salary` VALUES (287, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:58:01', NULL);
INSERT INTO `salary` VALUES (288, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 18:59:00', NULL);
INSERT INTO `salary` VALUES (289, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 18:59:00', NULL);
INSERT INTO `salary` VALUES (290, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 18:59:01', NULL);
INSERT INTO `salary` VALUES (291, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 18:59:01', NULL);
INSERT INTO `salary` VALUES (292, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20172.00, '2019-12-15 19:00:00', NULL);
INSERT INTO `salary` VALUES (293, 4, 554.00, 538.00, 1077.00, 0.00, 111.00, 1188.00, '2019-12-15 19:00:01', NULL);
INSERT INTO `salary` VALUES (294, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 19:00:01', NULL);
INSERT INTO `salary` VALUES (295, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 19:00:01', NULL);
INSERT INTO `salary` VALUES (296, 8, 420.00, 10112.00, 10161.00, 12.00, 9999.00, 20072.00, '2019-12-15 19:05:00', '修改时间：2020-01-03 02:42:12	修改原因：111	工资改变：减少-100.0元<br/>');
INSERT INTO `salary` VALUES (298, 12, 322.00, 222.00, 122.00, 0.00, 9999.00, 10121.00, '2019-12-15 19:05:00', NULL);
INSERT INTO `salary` VALUES (299, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 20506.00, '2019-12-15 19:05:00', NULL);
INSERT INTO `salary` VALUES (303, 5, 1435.00, 10223.00, 20505.00, 0.00, 1.00, 19406.00, '2019-12-15 19:06:00', '修改时间：2019-12-17 10:22:30	修改原因：1111	工资改变：减少-1100.0元<br/>');
INSERT INTO `salary` VALUES (304, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2020-02-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (305, 4, 0.00, 0.00, 0.00, 0.00, 111.00, 111.00, '2020-02-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (306, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '2020-02-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (307, 12, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2020-02-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (308, 53, 0.00, 0.00, 0.00, 0.00, 2222.00, 2222.00, '2020-02-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (309, 8, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2020-03-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (310, 4, 0.00, 0.00, 0.00, 0.00, 111.00, 111.00, '2020-03-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (311, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '2020-03-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (312, 12, 0.00, 0.00, 0.00, 0.00, 9999.00, 9999.00, '2020-03-12 00:00:00', NULL);
INSERT INTO `salary` VALUES (313, 53, 0.00, 0.00, 0.00, 0.00, 2222.00, 2222.00, '2020-03-12 00:00:00', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` int(1) DEFAULT NULL COMMENT '1：男，2：女',
  `entry_time` datetime(0) DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `base_salary` float(10, 2) DEFAULT NULL COMMENT '底薪',
  `status` int(255) DEFAULT NULL COMMENT '0：不可用、1可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'boss', 1, NULL, '99999', '21232f297a57a5a743894a0e4a801fc321232f297a57a5a743894a0e4a801fc321232f297a57a5a743894a0e4a801fc3', 0.00, 1);
INSERT INTO `user` VALUES (4, 'test04', 1, NULL, '11', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 111.00, 1);
INSERT INTO `user` VALUES (5, '12', 1, '2019-11-11 04:43:45', '12345678911', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1.00, 0);
INSERT INTO `user` VALUES (6, 'ggz', 1, '2019-11-11 04:43:56', '12365498720', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 0.00, 0);
INSERT INTO `user` VALUES (7, 'staff_3', 1, '2019-11-11 04:44:02', '13325456805', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 60000.00, 0);
INSERT INTO `user` VALUES (8, 'yzx', 1, '2019-12-04 14:07:30', '13325456805', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 9999.00, 1);
INSERT INTO `user` VALUES (12, 'ggz', 1, '2019-12-05 05:25:52', '17332904531', '23ded9fb6c93a88c58b52e6404bfd1aa23ded9fb6c93a88c58b52e6404bfd1aa23ded9fb6c93a88c58b52e6404bfd1aa', 9999.00, 1);
INSERT INTO `user` VALUES (46, '测试4号', 1, '2019-12-13 04:54:15', '11111111111', '202cb962ac59075b964b07152d234b70202cb962ac59075b964b07152d234b70202cb962ac59075b964b07152d234b70', 1000.00, 0);
INSERT INTO `user` VALUES (47, '测试5号', 1, '2019-12-13 04:54:24', '12345678910', '432f45b44c432414d2f97df0e5743818432f45b44c432414d2f97df0e5743818432f45b44c432414d2f97df0e5743818', 1000.00, 1);
INSERT INTO `user` VALUES (49, '123', 1, '2019-12-16 10:36:41', '12111111111', 'c20ad4d76fe97759aa27a0c99bff6710c20ad4d76fe97759aa27a0c99bff6710c20ad4d76fe97759aa27a0c99bff6710', 11111.00, 1);
INSERT INTO `user` VALUES (50, '666', 1, '2019-12-16 10:37:27', '11111111111', '68ce199ec2c5517597ce0a4d89620f5568ce199ec2c5517597ce0a4d89620f5568ce199ec2c5517597ce0a4d89620f55', 123.00, 1);
INSERT INTO `user` VALUES (51, '456', 1, '2019-12-16 10:38:10', '11111111111', 'e10adc3949ba59abbe56e057f20f883ee10adc3949ba59abbe56e057f20f883ee10adc3949ba59abbe56e057f20f883e', 123.00, 1);
INSERT INTO `user` VALUES (52, 'admin', 1, '2019-12-16 15:32:33', '11111111111', '21232f297a57a5a743894a0e4a801fc321232f297a57a5a743894a0e4a801fc321232f297a57a5a743894a0e4a801fc3', 0.00, 1);
INSERT INTO `user` VALUES (53, 'staff', 1, '2019-12-17 10:59:03', '11111111111', '21232f297a57a5a743894a0e4a801fc321232f297a57a5a743894a0e4a801fc321232f297a57a5a743894a0e4a801fc3', 2222.00, 1);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 209 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (9, 8, 2);
INSERT INTO `user_role` VALUES (155, 4, 4);
INSERT INTO `user_role` VALUES (184, 6, 4);
INSERT INTO `user_role` VALUES (190, 47, 1);
INSERT INTO `user_role` VALUES (194, 7, 2);
INSERT INTO `user_role` VALUES (197, 46, 3);
INSERT INTO `user_role` VALUES (199, 50, 1);
INSERT INTO `user_role` VALUES (200, 51, 1);
INSERT INTO `user_role` VALUES (201, 52, 1);
INSERT INTO `user_role` VALUES (204, 5, 4);
INSERT INTO `user_role` VALUES (205, 1, 2);
INSERT INTO `user_role` VALUES (206, 12, 3);
INSERT INTO `user_role` VALUES (207, 49, 1);
INSERT INTO `user_role` VALUES (208, 53, 4);

SET FOREIGN_KEY_CHECKS = 1;
