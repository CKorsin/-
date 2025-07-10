/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : cityai

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 10/07/2025 17:26:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '帖子分类',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '信息标题',
  `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系方式',
  `price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '价格/薪资信息',
  `salary` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '薪资范围',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `view_count` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_posts_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (22, '44444444', 1, 'house', '2025-07-09 17:20:35', '标题', '联系方式', '价格', '', NULL, '/uploads/f58405ce-b3a0-47a5-8552-247c8a2faa2a.jpg', NULL, 6);
INSERT INTO `posts` VALUES (24, '1111', 1, 'house', '2025-07-09 17:23:58', '标题', '联系方式', '价格', '', NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (26, '详细内容', 1, 'business', '2025-07-09 18:49:00', '标题', '45588888', '', '', NULL, NULL, NULL, 1);
INSERT INTO `posts` VALUES (27, '详细内容', 1, 'business', '2025-07-09 18:49:37', '标题', '45588888', '价格', '', NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (28, '详细内容', 1, 'business', '2025-07-09 18:52:00', '标题', '45588888', '', '', NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (29, '47777', 1, 'business', '2025-07-09 19:03:45', '标题', '45588888', '价格', '', NULL, NULL, 'd地址', 0);
INSERT INTO `posts` VALUES (30, '11111', 1, 'business', '2025-07-09 19:40:51', '超级大的标题', '10086', '', NULL, NULL, NULL, '呼吸街道666号', 0);
INSERT INTO `posts` VALUES (31, '222', 1, 'secondhand', '2025-07-09 19:46:02', 'test', '2222', '84', NULL, NULL, NULL, '2222', 0);
INSERT INTO `posts` VALUES (38, '332同学放假两个月，出租寝室，独立卫浴，四人寝', 5, 'house', '2025-07-10 02:39:38', '虎溪校区竹五332出租', 'test', '666', NULL, NULL, NULL, '', 8);
INSERT INTO `posts` VALUES (39, '你爱我我爱你~你是冰城甜蜜蜜~', 3, 'business', '2025-07-10 02:42:45', '蜜雪冰城', '10086', '', '', NULL, NULL, '重庆市沙坪坝区虎溪街道大学城南路55号', 4);
INSERT INTO `posts` VALUES (40, '1223333', 1, 'house', '2025-07-10 09:32:57', '虎溪校区竹五332出租', 'test', '666', '', NULL, '/photo/1.jpg', '', 4);
INSERT INTO `posts` VALUES (41, '7777', 1, 'job', '2025-07-10 10:38:31', '标题', '45588888', '', '4545454', NULL, NULL, '', 0);
INSERT INTO `posts` VALUES (42, '66666', 1, 'job', '2025-07-10 10:38:45', '标题', '45588888', '', '77575', NULL, NULL, '', 0);
INSERT INTO `posts` VALUES (43, '4444', 1, 'house', '2025-07-10 10:39:08', '120岁男大在线交友', '10086', '444', '', NULL, NULL, '', 5);
INSERT INTO `posts` VALUES (44, '666', 1, 'secondhand', '2025-07-10 10:57:38', '蜜雪冰城甜蜜蜜！', '45588888', '666', NULL, NULL, NULL, NULL, 1);
INSERT INTO `posts` VALUES (45, '11111111', 1, 'education', '2025-07-10 11:06:28', '求家教', '10086', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (46, 'test', 1, 'house', '2025-07-10 11:06:46', 'test', 'test', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `posts` VALUES (47, 'test', 1, 'job', '2025-07-10 11:06:53', 'test', 'test', NULL, 'test', NULL, NULL, '', 4);
INSERT INTO `posts` VALUES (48, 'test', 1, 'secondhand', '2025-07-10 11:07:01', 'test', 'test', 'test', NULL, NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (49, 'test', 1, 'business', '2025-07-10 11:07:35', 'test', 'test', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (50, 'test', 1, 'house', '2025-07-10 11:07:50', 'test', 'test', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (51, 'test', 3, 'house', '2025-07-10 11:30:01', 'test', 'test', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `posts` VALUES (52, 'teest', 7, 'house', '2025-07-10 11:45:42', 'test', 'test', 'test', '', NULL, '/photo/3.jpg', '', 0);
INSERT INTO `posts` VALUES (53, '123', 7, 'job', '2025-07-10 12:04:42', 'test', 'test', '', 'test', NULL, '/photo/2.jpg', '', 0);
INSERT INTO `posts` VALUES (54, 'test', 7, 'education', '2025-07-10 12:05:33', 'test', 'test', 'test', '', NULL, NULL, '', 0);
INSERT INTO `posts` VALUES (55, 'test', 7, 'business', '2025-07-10 12:05:41', 'test', 'test', '', '', NULL, '/photo/2.jpg', 'test', 0);
INSERT INTO `posts` VALUES (56, 'test', 7, 'education', '2025-07-10 12:05:51', 'test', 'test', 'test', '', NULL, '/photo/50a7b679-600a-4636-bdb3-252514c1842c.png', '', 0);
INSERT INTO `posts` VALUES (57, 'test', 7, 'house', '2025-07-10 12:06:01', 'test', 'test', 'test', '', NULL, '/photo/afef9382-5624-4be1-b840-42149c5fdfff.jpg', '', 0);
INSERT INTO `posts` VALUES (58, 'test', 7, 'job', '2025-07-10 12:06:11', 'test', 'test', '', 'test', NULL, '/photo/363bd089-a10e-41ed-bd87-c2c8be55e1ec.jpg', '', 2);
INSERT INTO `posts` VALUES (59, 'test', 7, 'secondhand', '2025-07-10 12:06:21', 'test', 'test', 'test', '', NULL, '/photo/adffaa52-d47a-44f0-88ab-f5ca2a753fe2.jpg', '', 0);
INSERT INTO `posts` VALUES (60, '123', 1, 'house', '2025-07-10 12:26:27', 'test', 'test', 'test', '', NULL, '/photo/10714a3c-f2cd-42d1-8fd4-2c001dc83fb1.jpg', '', 0);
INSERT INTO `posts` VALUES (61, 'test', 7, 'secondhand', '2025-07-10 12:41:40', 'test', 'test', 'test', '', NULL, '/photo/650ed2aa-73fd-437d-9588-9a5f175c55d7.jpg', '', 0);
INSERT INTO `posts` VALUES (62, '222', 7, 'house', '2025-07-10 12:53:37', 'test', 'test', 'test', '', NULL, '/photo/7027286c-1cab-49c2-b09f-3408c76ad0a4.jpg', '', 2);
INSERT INTO `posts` VALUES (63, '666', 7, 'secondhand', '2025-07-10 13:25:53', '666', '666', '666', '', NULL, '/photo/e0457848-610b-4741-b9db-6b958204d3e5.png', '', 5);
INSERT INTO `posts` VALUES (64, '售 房\r\n因本人已在外地购房生活，现将X2楼3室2厅的一套房子出售，面积125㎡，卷帘门\r\n汽车库约23㎡。双阳台，精装修，全地板，三房朝南，L型厅。已安装防盗和卫生间隔\r\n断，空调、彩电、冰箱、真皮沙发，全套家具齐全，拎包即住。产证齐全，水、电都\r\n通，位于白蒲镇中心地段，生活便利，且与XX小学仅一墙之隔，价格优惠。', 7, 'house', '2025-07-10 14:06:15', '精装房出售', '130********', '1388888', '', NULL, '/photo/fe6bc80b-bc4d-41db-87a6-3b2425b7c0c2.webp', '', 5);
INSERT INTO `posts` VALUES (65, '123', 1, 'job', '2025-07-10 16:48:53', 'test', '88888888', '', '6666-8888', NULL, '/photo/7186cf96-71ef-4caf-97e7-f1682f78b414.webp', '', 4);
INSERT INTO `posts` VALUES (66, '6666666', 1, 'job', '2025-07-10 16:51:18', 'test', '88888888', '', '6666-8888', NULL, NULL, '', 3);
INSERT INTO `posts` VALUES (69, '出售精装房', 5, 'house', '2025-07-10 17:21:33', '精装房出售', '45588888', '1280000', '', NULL, '/photo/a4067b2e-5cd5-4fd8-8c74-d741be85e5e5.webp', '', 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'user1', '123');
INSERT INTO `users` VALUES (3, 'user2', '123');
INSERT INTO `users` VALUES (5, 'admin', '123456');
INSERT INTO `users` VALUES (7, 'user3', '123');

SET FOREIGN_KEY_CHECKS = 1;
