/*
 Navicat MySQL Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 106.14.125.136:3306
 Source Schema         : account_mange

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 25/11/2019 14:31:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for coupon_card
-- ----------------------------
DROP TABLE IF EXISTS `coupon_card`;
CREATE TABLE `coupon_card`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` float(10, 2) NULL DEFAULT NULL,
  `percentage` float(10, 2) NULL DEFAULT NULL COMMENT '提成',
  `start_time` datetime(0) NULL DEFAULT NULL,
  `end_time` datetime(0) NULL DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_card
-- ----------------------------
INSERT INTO `coupon_card` VALUES (2, '收费项目1、2优惠卡', 100.00, 0.10, '2019-11-10 16:00:00', '2020-11-10 16:00:00', '介绍1');
INSERT INTO `coupon_card` VALUES (3, '收费项目1、2、3优惠卡', 100.00, 0.10, '2019-11-10 16:00:00', '2020-11-10 16:00:00', '介绍1');
INSERT INTO `coupon_card` VALUES (4, '收费项目5、6优惠卡', 100.00, 0.10, '2019-11-10 16:00:00', '2020-11-10 16:00:00', '介绍1');

-- ----------------------------
-- Table structure for coupon_card_detail
-- ----------------------------
DROP TABLE IF EXISTS `coupon_card_detail`;
CREATE TABLE `coupon_card_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` int(11) NULL DEFAULT NULL,
  `project_id` int(11) NULL DEFAULT NULL,
  `times` int(11) NULL DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `coupon_card_detail_ibfk_1`(`card_id`) USING BTREE,
  INDEX `coupon_card_detail_ibfk_2`(`project_id`) USING BTREE,
  CONSTRAINT `coupon_card_detail_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `coupon_card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `coupon_card_detail_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon_card_detail
-- ----------------------------
INSERT INTO `coupon_card_detail` VALUES (3, 2, 2, 20, '1、2优惠卡 绑定项目1');
INSERT INTO `coupon_card_detail` VALUES (4, 2, 3, 30, '1、2优惠卡 绑定项目2');
INSERT INTO `coupon_card_detail` VALUES (5, 3, 2, 20, '1、2、3优惠卡 绑定项目1');
INSERT INTO `coupon_card_detail` VALUES (6, 3, 3, 30, '1、2、3优惠卡 绑定项目2');
INSERT INTO `coupon_card_detail` VALUES (7, 3, 4, 40, '1、2、3优惠卡 绑定项目3');
INSERT INTO `coupon_card_detail` VALUES (8, 4, 6, 60, '5、6优惠卡 绑定项目5');
INSERT INTO `coupon_card_detail` VALUES (9, 4, 7, 70, '5、6优惠卡 绑定项目6');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` int(1) NULL DEFAULT NULL COMMENT '1：男，2：女',
  `registe_time` datetime(0) NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `weixin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `balance` float(10, 2) NOT NULL COMMENT '余额',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态：1可用、0不可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, 'cus_1', 2, '2019-11-10 11:08:13', '1234', 'wex', 0.00, 1);
INSERT INTO `customer` VALUES (2, 'cus_2', 2, '2019-11-10 12:34:04', '222', 'wex', 0.00, 1);
INSERT INTO `customer` VALUES (3, 'cus_3', 2, '2019-11-10 12:34:15', '333', 'wex', 0.00, 1);
INSERT INTO `customer` VALUES (4, 'cus_4', 2, '2019-11-10 12:34:21', '444', 'wex', 0.00, 1);
INSERT INTO `customer` VALUES (5, 'cus_5', 1, '2019-11-10 12:34:28', '555', 'wex', 0.00, 1);

-- ----------------------------
-- Table structure for customer_card
-- ----------------------------
DROP TABLE IF EXISTS `customer_card`;
CREATE TABLE `customer_card`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NULL DEFAULT NULL,
  `card_id` int(11) NULL DEFAULT NULL,
  `opening_time` datetime(0) NULL DEFAULT NULL,
  `dead_time` datetime(0) NULL DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `card_id`(`card_id`) USING BTREE,
  CONSTRAINT `customer_card_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `customer_card_ibfk_2` FOREIGN KEY (`card_id`) REFERENCES `coupon_card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_card
-- ----------------------------
INSERT INTO `customer_card` VALUES (5, 1, 3, '2019-11-10 16:00:00', '2020-01-10 16:00:00', 'cus_1 用80元余额办1、2、3优惠卡');
INSERT INTO `customer_card` VALUES (6, 1, 4, '2019-11-10 16:00:00', '2020-01-10 16:00:00', 'cus_1 用80元办1、2、3优惠卡');
INSERT INTO `customer_card` VALUES (7, 2, 4, '2019-11-10 16:00:00', '2020-11-10 16:00:00', 'cus_2 80元办卡');
INSERT INTO `customer_card` VALUES (8, 2, 3, '2019-11-10 16:00:00', '2020-11-10 16:00:00', 'cus_2 80元办卡');

-- ----------------------------
-- Table structure for customer_card_project
-- ----------------------------
DROP TABLE IF EXISTS `customer_card_project`;
CREATE TABLE `customer_card_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_card_id` int(11) NULL DEFAULT NULL,
  `project_id` int(11) NULL DEFAULT NULL,
  `residual_times` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_card_project_ibfk_1`(`customer_card_id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  CONSTRAINT `customer_card_project_ibfk_1` FOREIGN KEY (`customer_card_id`) REFERENCES `customer_card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `customer_card_project_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_card_project
-- ----------------------------
INSERT INTO `customer_card_project` VALUES (9, 5, 2, 19);
INSERT INTO `customer_card_project` VALUES (10, 5, 3, 30);
INSERT INTO `customer_card_project` VALUES (11, 5, 4, 40);
INSERT INTO `customer_card_project` VALUES (12, 6, 6, 60);
INSERT INTO `customer_card_project` VALUES (13, 6, 7, 70);
INSERT INTO `customer_card_project` VALUES (14, 7, 6, 59);
INSERT INTO `customer_card_project` VALUES (15, 7, 7, 70);
INSERT INTO `customer_card_project` VALUES (16, 8, 2, 20);
INSERT INTO `customer_card_project` VALUES (17, 8, 3, 30);
INSERT INTO `customer_card_project` VALUES (18, 8, 4, 40);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `permission` VALUES (8, 'salary_add', '设置员工薪水');
INSERT INTO `permission` VALUES (9, 'salary_edit', '修改员工薪水');
INSERT INTO `permission` VALUES (10, 'salary_del', '删除员工薪水');
INSERT INTO `permission` VALUES (11, 'consum_edit', '修改消费记录');
INSERT INTO `permission` VALUES (12, 'consum_del', '删除消费记录');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` float(10, 2) NULL DEFAULT NULL,
  `percentage` float(3, 2) NULL DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (2, '收费项目1', 20.00, 0.10, '这是介绍');
INSERT INTO `project` VALUES (3, '收费项目2', 20.00, 0.20, '这是介绍2');
INSERT INTO `project` VALUES (4, '收费项目3', 20.00, 0.30, '这是介绍3');
INSERT INTO `project` VALUES (5, '收费项目4', 20.00, 0.40, '这是介绍4');
INSERT INTO `project` VALUES (6, '收费项目5', 20.00, 0.50, '这是介绍5');
INSERT INTO `project` VALUES (7, '收费项目6', 20.00, 0.60, '这是介绍6');
INSERT INTO `project` VALUES (8, '收费项目7', 20.00, 0.70, '这是介绍7');

-- ----------------------------
-- Table structure for record_business
-- ----------------------------
DROP TABLE IF EXISTS `record_business`;
CREATE TABLE `record_business`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `customer_id` int(255) NULL DEFAULT NULL,
  `type` int(1) NULL DEFAULT NULL COMMENT '1:办卡、2：完成收费项目',
  `thing_id` int(11) NULL DEFAULT NULL COMMENT '卡或者项目的id',
  `date` datetime(0) NULL DEFAULT NULL COMMENT '啥时候做的',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  CONSTRAINT `record_business_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `record_business_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_business
-- ----------------------------
INSERT INTO `record_business` VALUES (1, 5, 2, 1, 4, '2019-11-11 04:45:44');
INSERT INTO `record_business` VALUES (2, 5, 2, 1, 3, '2019-11-11 04:47:58');
INSERT INTO `record_business` VALUES (4, 6, 1, 2, 3, '2019-11-11 05:10:55');
INSERT INTO `record_business` VALUES (5, 7, 1, 2, 2, '2019-11-11 05:12:00');
INSERT INTO `record_business` VALUES (8, 6, 1, 2, 4, '2019-11-11 05:36:05');
INSERT INTO `record_business` VALUES (10, 6, 4, 1, 2, '2019-11-13 10:01:56');
INSERT INTO `record_business` VALUES (11, 6, 1, 1, 3, '2019-11-13 10:10:06');

-- ----------------------------
-- Table structure for records_consumption
-- ----------------------------
DROP TABLE IF EXISTS `records_consumption`;
CREATE TABLE `records_consumption`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `consum_type` int(11) NULL DEFAULT NULL COMMENT '消费类型 1：收费项目、2.办卡、3.充值余额、4.给卡增加次数',
  `price` float(10, 2) NULL DEFAULT NULL,
  `pay_type` int(11) NULL DEFAULT NULL COMMENT '1：从卡里扣除，2：从余额扣除，3.支付',
  `pay_time` datetime(0) NULL DEFAULT NULL,
  `is_record` tinyint(1) NULL DEFAULT NULL COMMENT '是否被营业额所统计 0：没有、1:统计了',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `records_consumption_ibfk_1`(`customer_id`) USING BTREE,
  INDEX `records_consumption_ibfk_3`(`consum_type`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `records_consumption_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `records_consumption_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Table structure for records_turnover
-- ----------------------------
DROP TABLE IF EXISTS `records_turnover`;
CREATE TABLE `records_turnover`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime(0) NULL DEFAULT NULL COMMENT '某一天（以天为单位）',
  `money_income` float(10, 2) NULL DEFAULT NULL COMMENT '收入的钱：payType=3',
  `money_outcome` float(10, 2) NULL DEFAULT NULL COMMENT '给客户退的钱（退余额和退卡）payType=0',
  `card_reduce` float(10, 2) NULL DEFAULT NULL COMMENT '通过卡消费的钱数 payType=1',
  `balance_reduce` float(10, 2) NULL DEFAULT NULL COMMENT '通过余额消费 payType=2',
  `sum_income` float(10, 2) NULL DEFAULT NULL COMMENT '总的收入 money_income-money_outcome',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of records_turnover
-- ----------------------------
INSERT INTO `records_turnover` VALUES (1, '2019-11-09 16:00:00', 330.00, 20.00, 40.00, 80.00, 310.00);
INSERT INTO `records_turnover` VALUES (2, '2019-11-10 16:00:00', 470.00, 0.00, 40.00, 0.00, 470.00);
INSERT INTO `records_turnover` VALUES (6, '2019-11-12 16:00:00', 220.00, 20.00, 0.00, 0.00, 200.00);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
  `role_id` int(11) NULL DEFAULT NULL,
  `permission_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_permission_ibfk_1`(`role_id`) USING BTREE,
  INDEX `role_permission_ibfk_2`(`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id（员工类型）',
  `pro_sum` float(10, 2) NULL DEFAULT NULL COMMENT '任何方式支付前提下的完成收费项目的价值',
  `card_sum` float(10, 2) NULL DEFAULT NULL COMMENT '任何方式支付前提下的完成办卡的价值',
  `make_money_income` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '招揽的用钱支付的营业额',
  `base_salary` float(10, 2) NULL DEFAULT NULL COMMENT '底薪',
  `other_bonus` float(10, 2) NULL DEFAULT NULL COMMENT '其他奖金',
  `deduct_salary` float(10, 2) NULL DEFAULT NULL COMMENT '扣除的钱',
  `sum_salary` float(10, 2) NULL DEFAULT NULL COMMENT '总的工资',
  `settle_date` datetime(0) NULL DEFAULT NULL COMMENT '结算日期',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (7, 5, 50.00, 160.00, '210.0', 2000.00, 200.00, 100.00, 2310.00, '2019-11-13 09:49:14', '扣除100 奖金200');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` int(1) NULL DEFAULT NULL COMMENT '1：男，2：女',
  `entry_time` datetime(0) NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(255) NULL DEFAULT NULL COMMENT '1：在职，2：休假，3：离职',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'test01', 1, NULL, '', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);
INSERT INTO `user` VALUES (2, 'test02', 1, NULL, '', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);
INSERT INTO `user` VALUES (3, 'test03', 2, NULL, '', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);
INSERT INTO `user` VALUES (4, 'test04', 2, NULL, '', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);
INSERT INTO `user` VALUES (5, 'staff_1', 1, '2019-11-11 04:43:45', '13325456805', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);
INSERT INTO `user` VALUES (6, 'staff_2', 2, '2019-11-11 04:43:56', '13325456805', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);
INSERT INTO `user` VALUES (7, 'staff_3', 1, '2019-11-11 04:44:02', '13325456805', '098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6098f6bcd4621d373cade4e832627b4f6', 1);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);
INSERT INTO `user_role` VALUES (4, 4, 4);
INSERT INTO `user_role` VALUES (5, 5, 4);
INSERT INTO `user_role` VALUES (6, 6, 4);
INSERT INTO `user_role` VALUES (7, 7, 4);

SET FOREIGN_KEY_CHECKS = 1;
