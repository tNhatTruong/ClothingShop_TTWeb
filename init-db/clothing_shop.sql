/*
 Navicat Premium Dump SQL

 Source Server         : clothing
 Source Server Type    : MariaDB
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : clothing_shop

 Target Server Type    : MariaDB
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 27/01/2026 01:02:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NULL DEFAULT 0,
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_address_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_address_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------
INSERT INTO `addresses` VALUES (1, 2, '45 Nguyễn Văn Cừ', 'TP. Hồ Chí Minh', 'Quận 5', 1, '2025-12-16 00:40:16');
INSERT INTO `addresses` VALUES (2, 6, '89 Phan Chu Trinh', 'Đà Nẵng', 'Quận Hải Châu', 1, '2025-12-16 00:40:16');
INSERT INTO `addresses` VALUES (3, 4, '210 Võ Thị Sáu', 'TP. Hồ Chí Minh', 'Quận 3', 1, '2025-12-16 00:40:16');
INSERT INTO `addresses` VALUES (4, 10, '332 Hùng Vương', 'Hải Phòng', 'Quận Lê Chân', 1, '2025-12-16 00:40:16');
INSERT INTO `addresses` VALUES (5, 5, '67 Nguyễn Trãi', 'Hà Nội', 'Quận Thanh Xuân', 1, '2025-12-16 00:40:16');
INSERT INTO `addresses` VALUES (6, 1, '252 Tỉnh lộ 10', 'TP. Hồ Chí Minh', 'Quận Bình Tân', 1, '2025-12-16 00:40:16');
INSERT INTO `addresses` VALUES (7, 15, 'Linh Tây, Thủ Đức, TP. Hồ Chí Minh', 'TP.Hồ Chí Minh - Ngoại thành', 'Huyện Bình Chánh', 1, '2026-01-27 00:11:40');

-- ----------------------------
-- Table structure for cartitem
-- ----------------------------
DROP TABLE IF EXISTS `cartitem`;
CREATE TABLE `cartitem`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cart_variant`(`variant_id`) USING BTREE,
  INDEX `fk_cart_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_variant` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cartitem
-- ----------------------------
INSERT INTO `cartitem` VALUES (1, 1, 1, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (2, 2, 1, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (3, 3, 1, 3, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (4, 4, 2, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (5, 5, 2, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (6, 6, 2, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (7, 7, 3, 4, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (8, 8, 3, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (9, 9, 3, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (10, 10, 4, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (11, 1, 4, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (12, 2, 4, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (13, 3, 5, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (14, 4, 5, 3, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (15, 5, 5, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (16, 6, 6, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (17, 7, 6, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (18, 8, 6, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (19, 9, 7, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (20, 10, 7, 3, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (21, 1, 7, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (22, 2, 8, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (23, 3, 8, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (24, 4, 8, 4, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (25, 5, 9, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (26, 6, 9, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (27, 7, 9, 3, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (28, 8, 10, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (29, 9, 10, 2, '2025-12-16 00:40:16', '2025-12-16 00:40:16');
INSERT INTO `cartitem` VALUES (30, 10, 10, 1, '2025-12-16 00:40:16', '2025-12-16 00:40:16');

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `send_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_contact_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_contact_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contacts
-- ----------------------------
INSERT INTO `contacts` VALUES (1, 6, 'Vo Xuan An', 'Funny6@gmail.com', 'Tôi muốn hỏi về chính sách đổi trả sản phẩm.', '2025-12-16 00:40:16');
INSERT INTO `contacts` VALUES (2, 2, 'Tran Linh Xuan', 'lXu2k1@gmail.com', 'Shop phản hồi giúp mình tình trạng đơn hàng với ạ.', '2025-12-16 00:40:16');
INSERT INTO `contacts` VALUES (3, 4, 'Dao Cam Anh', 'CAnh311@gmail.com', 'Mình cần hỗ trợ đổi mật khẩu tài khoản.', '2025-12-16 00:40:16');
INSERT INTO `contacts` VALUES (4, 5, 'Linh Cam Tu', 'Hoacamtu11@gmail.com', 'Tôi muốn hỏi về kích thước sản phẩm.', '2025-12-16 00:40:16');
INSERT INTO `contacts` VALUES (5, 10, 'Phan Hai Long', 'solong356@gmail.com', 'Cho mình xin thông tin bảo hành của sản phẩm.', '2025-12-16 00:40:16');
INSERT INTO `contacts` VALUES (6, 7, 'Tran Ngoc Linh', 'Linhbeauty544@gmail.com', 'Website đang bị lỗi hiển thị giao diện.', '2025-12-16 00:40:16');

-- ----------------------------
-- Table structure for delivery
-- ----------------------------
DROP TABLE IF EXISTS `delivery`;
CREATE TABLE `delivery`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_delivery_order`(`order_id`) USING BTREE,
  CONSTRAINT `fk_delivery_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of delivery
-- ----------------------------
INSERT INTO `delivery` VALUES (1, 1, 'DEL2024122801', '2024-12-28 12:10:00');
INSERT INTO `delivery` VALUES (2, 2, 'DEL2024072502', '2024-07-25 11:20:00');
INSERT INTO `delivery` VALUES (3, 3, 'DEL2024032903', '2024-03-29 13:45:00');
INSERT INTO `delivery` VALUES (4, 4, 'DEL2025070704', '2025-07-07 09:50:00');
INSERT INTO `delivery` VALUES (5, 5, 'DEL2025082105', '2025-08-21 14:10:00');
INSERT INTO `delivery` VALUES (6, 6, 'DEL2024121406', '2024-12-14 09:05:00');
INSERT INTO `delivery` VALUES (7, 7, 'DEL2024091407', '2024-09-14 17:10:00');
INSERT INTO `delivery` VALUES (8, 8, 'DEL2025100108', '2025-10-01 12:30:00');
INSERT INTO `delivery` VALUES (9, 9, 'DEL2025091909', '2025-09-19 18:00:00');
INSERT INTO `delivery` VALUES (10, 10, 'DEL2024120510', '2024-12-05 13:05:00');
INSERT INTO `delivery` VALUES (11, 11, 'DEL2025011411', '2025-01-14 15:00:00');
INSERT INTO `delivery` VALUES (12, 12, 'DEL2025020312', '2025-02-03 19:10:00');
INSERT INTO `delivery` VALUES (13, 13, 'DEL2024031413', '2024-03-14 09:40:00');
INSERT INTO `delivery` VALUES (14, 14, 'DEL2025011114', '2025-01-11 14:05:00');
INSERT INTO `delivery` VALUES (15, 15, 'DEL2025062015', '2025-06-20 17:20:00');

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `product_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 291 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES (1, 'Ảnh Áo Khoác Nam', '/images/product_item_nam/1/1.1/aokhoac_nam.png', '2026-01-06 01:38:17', 1);
INSERT INTO `images` VALUES (2, 'Ảnh Người Khoác Nam', '/images/product_item_nam/1/1.1/trangphuc_nam.png', '2026-01-06 01:38:13', 1);
INSERT INTO `images` VALUES (3, 'Ảnh Áo Khoác Nam 2', '/images/product_item_nam/1/1.2/aokhoac_nam.png', '2026-01-06 01:38:05', 1);
INSERT INTO `images` VALUES (4, 'Ảnh Người Khoác Nam 2', '/images/product_item_nam/1/1.2/trangphuc_nam.png', '2026-01-06 01:38:00', 1);
INSERT INTO `images` VALUES (5, 'Ảnh Áo Khoác Nam 3', '/images/product_item_nam/1/1.3/aokhoac_nam.png', '2026-01-06 01:37:56', 1);
INSERT INTO `images` VALUES (6, 'Ảnh Người Khoác Nam 3', '/images/product_item_nam/1/1.3/trangphuc_nam.png', '2026-01-06 01:37:47', 1);
INSERT INTO `images` VALUES (7, 'Ảnh Áo Khoác Nam 4', '/images/product_item_nam/1/1.4/aokhoac_nam.png', '2026-01-06 01:37:43', 1);
INSERT INTO `images` VALUES (8, 'Ảnh Người Khoác Nam 4', '/images/product_item_nam/1/1.4/trangphuc_nam.png', '2026-01-06 01:37:39', 1);
INSERT INTO `images` VALUES (9, 'Ảnh Áo Khoác Nam 5', '/images/product_item_nam/1/1.5/aokhoac_nam.png', '2026-01-06 01:37:35', 1);
INSERT INTO `images` VALUES (10, 'Ảnh Người Khoác Nam 5', '/images/product_item_nam/1/1.5/trangphuc_nam.png', '2026-01-06 01:37:30', 1);
INSERT INTO `images` VALUES (11, 'Ảnh Áo Khoác Nam 6', '/images/product_item_nam/1/1.6/aokhoac_nam.png', '2026-01-06 01:37:23', 1);
INSERT INTO `images` VALUES (12, 'Ảnh Người Khoác Nam 6', '/images/product_item_nam/1/1.6/trangphuc_nam.png', '2026-01-06 01:37:18', 1);
INSERT INTO `images` VALUES (13, 'Ảnh Áo Khoác Nam 7', '/images/product_item_nam/1/1.7/aokhoac_nam.png', '2026-01-06 01:37:07', 1);
INSERT INTO `images` VALUES (14, 'Ảnh Người Khoác Nam 7', '/images/product_item_nam/1/1.7/trangphuc_nam.png', '2026-01-06 01:37:01', 1);
INSERT INTO `images` VALUES (15, 'Ảnh Áo Khoác Nam 8', '/images/product_item_nam/1/1.8/aokhoac_nam.png', '2026-01-06 01:36:53', 1);
INSERT INTO `images` VALUES (16, 'Ảnh Người Khoác Nam 8', '/images/product_item_nam/1/1.8/trangphuc_nam.png', '2026-01-06 01:36:48', 1);
INSERT INTO `images` VALUES (17, 'Ảnh Áo Khoác Nam 9', '/images/product_item_nam/1/1.9/aokhoac_nam.png', '2026-01-06 01:36:43', 1);
INSERT INTO `images` VALUES (18, 'Ảnh Người Khoác Nam 9', '/images/product_item_nam/1/1.9/trangphuc_nam.png', '2026-01-06 01:36:38', 1);
INSERT INTO `images` VALUES (19, 'Ảnh Áo Khoác Nam 10', '/images/product_item_nam/1/1.10/aokhoac_nam.png', '2026-01-06 01:36:33', 1);
INSERT INTO `images` VALUES (20, 'Ảnh Người Khoác Nam 10', '/images/product_item_nam/1/1.10/trangphuc_nam.png', '2026-01-06 01:36:26', 1);
INSERT INTO `images` VALUES (21, 'Ảnh Áo Thun Nam', '/images/product_item_nam/2/2.1/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (22, 'Ảnh Người Thun Nam', '/images/product_item_nam/2/2.1/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (23, 'Ảnh Áo Thun Nam 2', '/images/product_item_nam/2/2.2/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (24, 'Ảnh Người Thun Nam 2', '/images/product_item_nam/2/2.2/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (25, 'Ảnh Áo Thun Nam 3', '/images/product_item_nam/2/2.3/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (26, 'Ảnh Người Thun Nam 3', '/images/product_item_nam/2/2.3/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (27, 'Ảnh Áo Thun Nam 4', '/images/product_item_nam/2/2.4/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (28, 'Ảnh Người Thun Nam 4', '/images/product_item_nam/2/2.4/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (29, 'Ảnh Áo Thun Nam 5', '/images/product_item_nam/2/2.5/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (30, 'Ảnh Người Thun Nam 5', '/images/product_item_nam/2/2.5/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (31, 'Ảnh Áo Thun Nam 6', '/images/product_item_nam/2/2.6/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (32, 'Ảnh Người Thun Nam 6', '/images/product_item_nam/2/2.6/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (33, 'Ảnh Áo Thun Nam 7', '/images/product_item_nam/2/2.7/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (34, 'Ảnh Người Thun Nam 7', '/images/product_item_nam/2/2.7/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (35, 'Ảnh Áo Thun Nam 8', '/images/product_item_nam/2/2.8/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (36, 'Ảnh Người Thun Nam 8', '/images/product_item_nam/2/2.8/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (37, 'Ảnh Áo Thun Nam 9', '/images/product_item_nam/2/2.9/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (38, 'Ảnh Người Thun Nam 9', '/images/product_item_nam/2/2.9/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (39, 'Ảnh Áo Thun Nam 10', '/images/product_item_nam/2/2.10/aothun_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (40, 'Ảnh Người Thun Nam 10', '/images/product_item_nam/2/2.10/trangphuc_nam.png', '2026-01-06 01:24:02', 2);
INSERT INTO `images` VALUES (41, 'Ảnh Áo Polo Nam', '/images/product_item_nam/3/3.1/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (42, 'Ảnh Người Polo Nam', '/images/product_item_nam/3/3.1/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (43, 'Ảnh Áo Polo Nam 2', '/images/product_item_nam/3/3.2/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (44, 'Ảnh Người Polo Nam 2', '/images/product_item_nam/3/3.2/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (45, 'Ảnh Áo Polo Nam 3', '/images/product_item_nam/3/3.3/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (46, 'Ảnh Người Polo Nam 3', '/images/product_item_nam/3/3.3/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (47, 'Ảnh Áo Polo Nam 4', '/images/product_item_nam/3/3.4/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (48, 'Ảnh Người Polo Nam 4', '/images/product_item_nam/3/3.4/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (49, 'Ảnh Áo Polo Nam 5', '/images/product_item_nam/3/3.5/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (50, 'Ảnh Người Polo Nam 5', '/images/product_item_nam/3/3.5/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (51, 'Ảnh Áo Polo Nam 6', '/images/product_item_nam/3/3.6/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (52, 'Ảnh Người Polo Nam 6', '/images/product_item_nam/3/3.6/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (53, 'Ảnh Áo Polo Nam 7', '/images/product_item_nam/3/3.7/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (54, 'Ảnh Người Polo Nam 7', '/images/product_item_nam/3/3.7/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (55, 'Ảnh Áo Polo Nam 8', '/images/product_item_nam/3/3.8/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (56, 'Ảnh Người Polo Nam 8', '/images/product_item_nam/3/3.8/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (57, 'Ảnh Áo Polo Nam 9', '/images/product_item_nam/3/3.9/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (58, 'Ảnh Người Polo Nam 9', '/images/product_item_nam/3/3.9/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (59, 'Ảnh Áo Polo Nam 10', '/images/product_item_nam/3/3.10/aopolo_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (60, 'Ảnh Người Polo Nam 10', '/images/product_item_nam/3/3.10/trangphuc_nam.png', '2026-01-06 01:24:02', 3);
INSERT INTO `images` VALUES (61, 'Ảnh Sơ Mi Nam', '/images/product_item_nam/4/4.1/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (62, 'Ảnh Người Sơ Mi Nam', '/images/product_item_nam/4/4.1/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (63, 'Ảnh Sơ Mi Nam 2', '/images/product_item_nam/4/4.2/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (64, 'Ảnh Người Sơ Mi Nam 2', '/images/product_item_nam/4/4.2/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (65, 'Ảnh Sơ Mi Nam 3', '/images/product_item_nam/4/4.3/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (66, 'Ảnh Người Sơ Mi Nam 3', '/images/product_item_nam/4/4.3/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (67, 'Ảnh Sơ Mi Nam 4', '/images/product_item_nam/4/4.4/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (68, 'Ảnh Người Sơ Mi Nam 4', '/images/product_item_nam/4/4.4/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (69, 'Ảnh Sơ Mi Nam 5', '/images/product_item_nam/4/4.5/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (70, 'Ảnh Người Sơ Mi Nam 5', '/images/product_item_nam/4/4.5/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (71, 'Ảnh Sơ Mi Nam 6', '/images/product_item_nam/4/4.6/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (72, 'Ảnh Người Sơ Mi Nam 6', '/images/product_item_nam/4/4.6/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (73, 'Ảnh Sơ Mi Nam 7', '/images/product_item_nam/4/4.7/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (74, 'Ảnh Người Sơ Mi Nam 7', '/images/product_item_nam/4/4.7/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (75, 'Ảnh Sơ Mi Nam 8', '/images/product_item_nam/4/4.8/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (76, 'Ảnh Người Sơ Mi Nam 8', '/images/product_item_nam/4/4.8/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (77, 'Ảnh Sơ Mi Nam 9', '/images/product_item_nam/4/4.9/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (78, 'Ảnh Người Sơ Mi Nam 9', '/images/product_item_nam/4/4.9/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (79, 'Ảnh Sơ Mi Nam 10', '/images/product_item_nam/4/4.10/aosomi_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (80, 'Ảnh Người Sơ Mi Nam 10', '/images/product_item_nam/4/4.10/trangphuc_nam.png', '2026-01-06 01:24:02', 4);
INSERT INTO `images` VALUES (81, 'Ảnh Quần Short Nam', '/images/product_item_nam/5/5.1/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (82, 'Ảnh Người Quần Short Nam', '/images/product_item_nam/5/5.1/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (83, 'Ảnh Quần Short Nam 2', '/images/product_item_nam/5/5.2/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (84, 'Ảnh Người Quần Short Nam 2', '/images/product_item_nam/5/5.2/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (85, 'Ảnh Quần Short Nam 3', '/images/product_item_nam/5/5.3/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (86, 'Ảnh Người Quần Short Nam 3', '/images/product_item_nam/5/5.3/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (87, 'Ảnh Quần Short Nam 4', '/images/product_item_nam/5/5.4/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (88, 'Ảnh Người Quần Short Nam 4', '/images/product_item_nam/5/5.4/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (89, 'Ảnh Quần Short Nam 5', '/images/product_item_nam/5/5.5/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (90, 'Ảnh Người Quần Short Nam 5', '/images/product_item_nam/5/5.5/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (91, 'Ảnh Quần Short Nam 6', '/images/product_item_nam/5/5.6/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (92, 'Ảnh Người Quần Short Nam 6', '/images/product_item_nam/5/5.6/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (93, 'Ảnh Quần Short Nam 7', '/images/product_item_nam/5/5.7/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (94, 'Ảnh Người Quần Short Nam 7', '/images/product_item_nam/5/5.7/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (95, 'Ảnh Quần Short Nam 8', '/images/product_item_nam/5/5.8/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (96, 'Ảnh Người Quần Short Nam 8', '/images/product_item_nam/5/5.8/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (97, 'Ảnh Quần Short Nam 9', '/images/product_item_nam/5/5.9/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (98, 'Ảnh Người Quần Short Nam 9', '/images/product_item_nam/5/5.9/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (99, 'Ảnh Quần Short Nam 10', '/images/product_item_nam/5/5.10/quanngan_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (100, 'Ảnh Người Quần Short Nam 10', '/images/product_item_nam/5/5.10/trangphuc_nam.png', '2026-01-06 01:24:02', 5);
INSERT INTO `images` VALUES (101, 'Ảnh Quần Dài Nam', '/images/product_item_nam/6/6.1/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (102, 'Ảnh Người Quần Dài Nam', '/images/product_item_nam/6/6.1/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (103, 'Ảnh Quần Dài Nam 2', '/images/product_item_nam/6/6.2/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (104, 'Ảnh Người Quần Dài Nam 2', '/images/product_item_nam/6/6.2/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (105, 'Ảnh Quần Dài Nam 3', '/images/product_item_nam/6/6.3/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (106, 'Ảnh Người Quần Dài Nam 3', '/images/product_item_nam/6/6.3/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (107, 'Ảnh Quần Dài Nam 4', '/images/product_item_nam/6/6.4/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (108, 'Ảnh Người Quần Dài Nam 4', '/images/product_item_nam/6/6.4/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (109, 'Ảnh Quần Dài Nam 5', '/images/product_item_nam/6/6.5/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (110, 'Ảnh Người Quần Dài Nam 5', '/images/product_item_nam/6/6.5/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (111, 'Ảnh Quần Dài Nam 6', '/images/product_item_nam/6/6.6/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (112, 'Ảnh Người Quần Dài Nam 6', '/images/product_item_nam/6/6.6/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (113, 'Ảnh Quần Dài Nam 7', '/images/product_item_nam/6/6.7/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (114, 'Ảnh Người Quần Dài Nam 7', '/images/product_item_nam/6/6.7/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (115, 'Ảnh Quần Dài Nam 8', '/images/product_item_nam/6/6.8/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (116, 'Ảnh Người Quần Dài Nam 8', '/images/product_item_nam/6/6.8/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (117, 'Ảnh Quần Dài Nam 9', '/images/product_item_nam/6/6.9/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (118, 'Ảnh Người Quần Dài Nam 9', '/images/product_item_nam/6/6.9/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (119, 'Ảnh Quần Dài Nam 10', '/images/product_item_nam/6/6.10/quandai_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (120, 'Ảnh Người Quần Dài Nam 10', '/images/product_item_nam/6/6.10/trangphuc_nam.png', '2026-01-06 01:24:02', 6);
INSERT INTO `images` VALUES (121, 'Ảnh Quần Jean Nam', '/images/product_item_nam/7/7.1/quanjeans_nam.png', '2025-12-16 00:40:16', 7);
INSERT INTO `images` VALUES (122, 'Ảnh Người Quần Jean Nam', '/images/product_item_nam/7/7.1/trangphuc_nam.png.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (123, 'Ảnh Quần Jean Nam 2', '/images/product_item_nam/7/7.2/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (124, 'Ảnh Người Quần Jean Nam 2', '/images/product_item_nam/7/7.2/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (125, 'Ảnh Quần Jean Nam 3', '/images/product_item_nam/7/7.3/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (126, 'Ảnh Người Quần Jean Nam 3', '/images/product_item_nam/7/7.3/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (127, 'Ảnh Quần Jean Nam 4', '/images/product_item_nam/7/7.4/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (128, 'Ảnh Người Quần Jean Nam 4', '/images/product_item_nam/7/7.4/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (129, 'Ảnh Quần Jean Nam 5', '/images/product_item_nam/7/7.5/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (130, 'Ảnh Người Quần Jean Nam 5', '/images/product_item_nam/7/7.5/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (131, 'Ảnh Quần Jean Nam 6', '/images/product_item_nam/7/7.6/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (132, 'Ảnh Người Quần Jean Nam 6', '/images/product_item_nam/7/7.6/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (133, 'Ảnh Quần Jean Nam 7', '/images/product_item_nam/7/7.7/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (134, 'Ảnh Người Quần Jean Nam 7', '/images/product_item_nam/7/7.7/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (135, 'Ảnh Quần Jean Nam 8', '/images/product_item_nam/7/7.8/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (136, 'Ảnh Người Quần Jean Nam 8', '/images/product_item_nam/7/7.8/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (137, 'Ảnh Quần Jean Nam 9', '/images/product_item_nam/7/7.9/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (138, 'Ảnh Người Quần Jean Nam 9', '/images/product_item_nam/7/7.9/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (139, 'Ảnh Quần Jean Nam 10', '/images/product_item_nam/7/7.10/quanjeans_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (140, 'Ảnh Người Quần Jean Nam 10', '/images/product_item_nam/7/7.10/trangphuc_nam.png', '2026-01-06 01:24:02', 7);
INSERT INTO `images` VALUES (141, 'Ảnh Áo Khoác Nữ', '/images/product_item_women/1/1-1/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (142, 'Ảnh Người Áo Khoác Nữ', '/images/product_item_women/1/1-1/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (143, 'Ảnh Áo Khoác Nữ 2', '/images/product_item_women/1/1-2/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (144, 'Ảnh Người Áo Khoác Nữ 2', '/images/product_item_women/1/1-2/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (145, 'Ảnh Áo Khoác Nữ 3', '/images/product_item_women/1/1-3/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (146, 'Ảnh Người Áo Khoác Nữ 3', '/images/product_item_women/1/1-3/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (147, 'Ảnh Áo Khoác Nữ 4', '/images/product_item_women/1/1-4/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (148, 'Ảnh Người Áo Khoác Nữ 4', '/images/product_item_women/1/1-4/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (149, 'Ảnh Áo Khoác Nữ 5', '/images/product_item_women/1/1-5/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (150, 'Ảnh Người Áo Khoác Nữ 5', '/images/product_item_women/1/1-5/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (151, 'Ảnh Áo Khoác Nữ 6', '/images/product_item_women/1/1-6/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (152, 'Ảnh Người Áo Khoác Nữ 6', '/images/product_item_women/1/1-6/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (153, 'Ảnh Áo Khoác Nữ 7', '/images/product_item_women/1/1-7/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (154, 'Ảnh Người Áo Khoác Nữ 7', '/images/product_item_women/1/1-7/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (155, 'Ảnh Áo Khoác Nữ 8', '/images/product_item_women/1/1-8/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (156, 'Ảnh Người Áo Khoác Nữ 8', '/images/product_item_women/1/1-8/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (157, 'Ảnh Áo Khoác Nữ 9', '/images/product_item_women/1/1-9/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (158, 'Ảnh Người Áo Khoác Nữ 9', '/images/product_item_women/1/1-9/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (159, 'Ảnh Áo Khoác Nữ 10', '/images/product_item_women/1/1-10/trangphuc.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (160, 'Ảnh Người Áo Khoác Nữ 10', '/images/product_item_women/1/1-10/aokhoacnu.png', '2025-12-16 00:40:16', 8);
INSERT INTO `images` VALUES (161, 'Ảnh Áo Thun Nữ', '/images/product_item_women/2/2-1/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (162, 'Ảnh Người Áo Thun Nữ', '/images/product_item_women/2/2-1/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (163, 'Ảnh Áo Thun Nữ 2', '/images/product_item_women/2/2-2/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (164, 'Ảnh Người Áo Thun Nữ 2', '/images/product_item_women/2/2-2/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (165, 'Ảnh Áo Thun Nữ 3', '/images/product_item_women/2/2-3/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (166, 'Ảnh Người Áo Thun Nữ 3', '/images/product_item_women/2/2-3/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (167, 'Ảnh Áo Thun Nữ 4', '/images/product_item_women/2/2-4/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (168, 'Ảnh Người Áo Thun Nữ 4', '/images/product_item_women/2/2-4/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (169, 'Ảnh Áo Thun Nữ 5', '/images/product_item_women/2/2-5/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (170, 'Ảnh Người Áo Thun Nữ 5', '/images/product_item_women/2/2-5/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (171, 'Ảnh Áo Thun Nữ 6', '/images/product_item_women/2/2-6/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (172, 'Ảnh Người Áo Thun Nữ 6', '/images/product_item_women/2/2-6/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (173, 'Ảnh Áo Thun Nữ 7', '/images/product_item_women/2/2-7/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (174, 'Ảnh Người Áo Thun Nữ 7', '/images/product_item_women/2/2-7/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (175, 'Ảnh Áo Thun Nữ 8', '/images/product_item_women/2/2-8/trangphuc.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (176, 'Ảnh Người Áo Thun Nữ 8', '/images/product_item_women/2/2-8/aothunnu.png', '2025-12-16 00:40:16', 9);
INSERT INTO `images` VALUES (177, 'Ảnh Áo Polo Nữ', '/images/product_item_women/3/3-1/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (178, 'Ảnh Người Áo Polo Nữ', '/images/product_item_women/3/3-1/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (179, 'Ảnh Áo Polo Nữ 2', '/images/product_item_women/3/3-2/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (180, 'Ảnh Người Áo Polo Nữ 2', '/images/product_item_women/3/3-2/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (181, 'Ảnh Áo Polo Nữ 3', '/images/product_item_women/3/3-3/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (182, 'Ảnh Người Áo Polo Nữ 3', '/images/product_item_women/3/3-3/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (183, 'Ảnh Áo Polo Nữ 4', '/images/product_item_women/3/3-4/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (184, 'Ảnh Người Áo Polo Nữ 4', '/images/product_item_women/3/3-4/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (185, 'Ảnh Áo Polo Nữ 5', '/images/product_item_women/3/3-5/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (186, 'Ảnh Người Áo Polo Nữ 5', '/images/product_item_women/3/3-5/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (187, 'Ảnh Áo Polo Nữ 6', '/images/product_item_women/3/3-6/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (188, 'Ảnh Người Áo Polo Nữ 6', '/images/product_item_women/3/3-6/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (189, 'Ảnh Áo Polo Nữ 7', '/images/product_item_women/3/3-7/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (190, 'Ảnh Người Áo Polo Nữ 7', '/images/product_item_women/3/3-7/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (191, 'Ảnh Áo Polo Nữ 8', '/images/product_item_women/3/3-8/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (192, 'Ảnh Người Áo Polo Nữ 8', '/images/product_item_women/3/3-8/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (193, 'Ảnh Áo Polo Nữ 9', '/images/product_item_women/3/3-9/trangphuc.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (194, 'Ảnh Người Áo Polo Nữ 9', '/images/product_item_women/3/3-9/aopolonu.png', '2025-12-16 00:40:16', 10);
INSERT INTO `images` VALUES (195, 'Ảnh Áo Sơmi Nữ ', '/images/product_item_women/4/4-1/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (196, 'Ảnh Người Áo Sơmi Nữ', '/images/product_item_women/4/4-1/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (197, 'Ảnh Áo Sơmi Nữ 2', '/images/product_item_women/4/4-2/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (198, 'Ảnh Người Áo Sơmi Nữ 2', '/images/product_item_women/4/4-2/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (199, 'Ảnh Áo Sơmi Nữ 3', '/images/product_item_women/4/4-3/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (200, 'Ảnh Người Áo Sơmi Nữ 3', '/images/product_item_women/4/4-3/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (201, 'Ảnh Áo Sơmi Nữ 4', '/images/product_item_women/4/4-4/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (202, 'Ảnh Người Áo Sơmi Nữ 4', '/images/product_item_women/4/4-4/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (203, 'Ảnh Áo Sơmi Nữ 5', '/images/product_item_women/4/4-5/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (204, 'Ảnh Người Áo Sơmi Nữ 5', '/images/product_item_women/4/4-5/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (205, 'Ảnh Áo Sơmi Nữ 6', '/images/product_item_women/4/4-6/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (206, 'Ảnh Người Áo Sơmi Nữ 6', '/images/product_item_women/4/4-6/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (207, 'Ảnh Áo Sơmi Nữ 7', '/images/product_item_women/4/4-7/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (208, 'Ảnh Người Áo Sơmi Nữ 7', '/images/product_item_women/4/4-7/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (209, 'Ảnh Áo Sơmi Nữ 8', '/images/product_item_women/4/4-8/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (210, 'Ảnh Người Áo Sơmi Nữ 8', '/images/product_item_women/4/4-8/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (211, 'Ảnh Áo Sơmi Nữ 9', '/images/product_item_women/4/4-9/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (212, 'Ảnh Người Áo Sơmi Nữ 9', '/images/product_item_women/4/4-9/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (213, 'Ảnh Áo Sơmi Nữ 10', '/images/product_item_women/4/4-10/trangphuc.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (214, 'Ảnh Người Áo Sơmi Nữ 10', '/images/product_item_women/4/4-10/aosominu.png', '2025-12-16 00:40:16', 11);
INSERT INTO `images` VALUES (215, 'Ảnh Váy Nữ ', '/images/product_item_women/5/5-1/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (216, 'Ảnh Người Váy Nữ', '/images/product_item_women/5/5-1/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (217, 'Ảnh Váy Nữ 2', '/images/product_item_women/5/5-2/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (218, 'Ảnh Người Váy Nữ 2', '/images/product_item_women/5/5-2/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (219, 'Ảnh Váy Nữ 3', '/images/product_item_women/5/5-3/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (220, 'Ảnh Người Váy Nữ 3', '/images/product_item_women/5/5-3/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (221, 'Ảnh Váy Nữ 4', '/images/product_item_women/5/5-4/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (222, 'Ảnh Người Váy Nữ 4', '/images/product_item_women/5/5-4/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (223, 'Ảnh Váy Nữ 5', '/images/product_item_women/5/5-5/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (224, 'Ảnh Người Váy Nữ 5', '/images/product_item_women/5/5-5/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (225, 'Ảnh Váy Nữ 6', '/images/product_item_women/5/5-6/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (226, 'Ảnh Người Váy Nữ 6', '/images/product_item_women/5/5-6/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (227, 'Ảnh Váy Nữ 7', '/images/product_item_women/5/5-7/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (228, 'Ảnh Người Váy Nữ 7', '/images/product_item_women/5/5-7/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (229, 'Ảnh Váy Nữ 8', '/images/product_item_women/5/5-8/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (230, 'Ảnh Người Váy Nữ 8', '/images/product_item_women/5/5-8/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (231, 'Ảnh Váy Nữ 9', '/images/product_item_women/5/5-9/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (232, 'Ảnh Người Váy Nữ 9', '/images/product_item_women/5/5-9/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (233, 'Ảnh Váy Nữ 10', '/images/product_item_women/5/5-10/trangphuc.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (234, 'Ảnh Người Váy Nữ 10', '/images/product_item_women/5/5-10/vaynu.png', '2025-12-16 00:40:16', 12);
INSERT INTO `images` VALUES (235, 'Ảnh Đầm Nữ', '/images/product_item_women/6/6-1/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (236, 'Ảnh Người Đầm Nữ', '/images/product_item_women/6/6-1/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (237, 'Ảnh Đầm Nữ 2', '/images/product_item_women/6/6-2/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (238, 'Ảnh Người Đầm Nữ 2', '/images/product_item_women/6/6-2/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (239, 'Ảnh Đầm Nữ 3', '/images/product_item_women/6/6-3/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (240, 'Ảnh Người Đầm Nữ 3', '/images/product_item_women/6/6-3/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (241, 'Ảnh Đầm Nữ 4', '/images/product_item_women/6/6-4/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (242, 'Ảnh Người Đầm Nữ 4', '/images/product_item_women/6/6-4/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (243, 'Ảnh Đầm Nữ 5', '/images/product_item_women/6/6-5/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (244, 'Ảnh Người Đầm Nữ 5', '/images/product_item_women/6/6-5/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (245, 'Ảnh Đầm Nữ 6', '/images/product_item_women/6/6-6/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (246, 'Ảnh Người Đầm Nữ 6', '/images/product_item_women/6/6-6/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (247, 'Ảnh Đầm Nữ 7', '/images/product_item_women/6/6-7/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (248, 'Ảnh Người Đầm Nữ 7', '/images/product_item_women/6/6-7/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (249, 'Ảnh Đầm Nữ 8', '/images/product_item_women/6/6-8/trangphuc.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (250, 'Ảnh Người Đầm Nữ 8', '/images/product_item_women/6/6-8/damnu.png', '2025-12-16 00:40:16', 13);
INSERT INTO `images` VALUES (251, 'Ảnh Quần Short Nữ', '/images/product_item_women/7/7-1/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (252, 'Ảnh Người Quần Short Nữ', '/images/product_item_nu/7/7-1/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (253, 'Ảnh Quần Short Nữ 2', '/images/product_item_women/7/7-2/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (254, 'Ảnh Người Quần Short Nữ 2', '/images/product_item_women/7/7-2/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (255, 'Ảnh Quần Short Nữ 3', '/images/product_item_women/7/7-3/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (256, 'Ảnh Người Quần Short Nữ 3', '/images/product_item_women/7/7-3/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (257, 'Ảnh Quần Short Nữ 4', '/images/product_item_women/7/7-4/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (258, 'Ảnh Người Quần Short Nữ 4', '/images/product_item_women/7/7-4/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (259, 'Ảnh Quần Short Nữ 5', '/images/product_item_women/7/7-5/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (260, 'Ảnh Người Quần Short Nữ 5', '/images/product_item_women/7/7-5/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (261, 'Ảnh Quần Short Nữ 6', '/images/product_item_women/7/7-6/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (262, 'Ảnh Người Quần Short Nữ 6', '/images/product_item_women/7/7-6/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (263, 'Ảnh Quần Short Nữ 7', '/images/product_item_women/7/7-7/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (264, 'Ảnh Người Quần Short Nữ 7', '/images/product_item_women/7/7-7/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (265, 'Ảnh Quần Short Nữ 8', '/images/product_item_women/7/7-8/trangphuc.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (266, 'Ảnh Người Quần Short Nữ 8', '/images/product_item_women/7/7-8/quanshortnu.png', '2025-12-16 00:40:16', 14);
INSERT INTO `images` VALUES (267, 'Ảnh Quần Dài Nữ', '/images/product_item_women/8/8-1/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (268, 'Ảnh Người Quần Dài Nữ', '/images/product_item_nu/8/8-1/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (269, 'Ảnh Quần Dài Nữ 2', '/images/product_item_women/8/8-2/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (270, 'Ảnh Người Quần Dài Nữ 2', '/images/product_item_women/8/8-2/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (271, 'Ảnh Quần Dài Nữ 3', '/images/product_item_women/8/8-3/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (272, 'Ảnh Người Quần Dài Nữ 3', '/images/product_item_women/8/8-3/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (273, 'Ảnh Quần Dài Nữ 4', '/images/product_item_women/8/8-4/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (274, 'Ảnh Người Quần Dài Nữ 4', '/images/product_item_women/8/8-4/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (275, 'Ảnh Quần Dài Nữ 5', '/images/product_item_women/8/8-5/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (276, 'Ảnh Người Quần Dài Nữ 5', '/images/product_item_women/8/8-5/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (277, 'Ảnh Quần Dài Nữ 6', '/images/product_item_women/8/8-6/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (278, 'Ảnh Người Quần Dài Nữ 6', '/images/product_item_women/8/8-6/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (279, 'Ảnh Quần Dài Nữ 7', '/images/product_item_women/8/8-7/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (280, 'Ảnh Người Quần Dài Nữ 7', '/images/product_item_women/8/8-7/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (281, 'Ảnh Quần Dài Nữ 8', '/images/product_item_women/8/8-8/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (282, 'Ảnh Người Quần Dài Nữ 8', '/images/product_item_women/8/8-8/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (283, 'Ảnh Quần Dài Nữ 9', '/images/product_item_women/8/8-9/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (284, 'Ảnh Người Quần Dài Nữ 9', '/images/product_item_women/8/8-9/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (285, 'Ảnh Quần Dài Nữ 10', '/images/product_item_women/8/8-10/trangphuc.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (286, 'Ảnh Người Quần Dài Nữ 10', '/images/product_item_women/8/8-10/quandainu.png', '2025-12-16 00:40:16', 15);
INSERT INTO `images` VALUES (287, 'Áo Khoác Bomber Couple', '/images/product_item_couple/1/bomber.png', '2026-01-26 23:39:22', 16);
INSERT INTO `images` VALUES (288, 'Áo Thun Đôi Trái Tim', '/images/product_item_couple/2/heart_tee.png', '2026-01-26 23:39:22', 17);
INSERT INTO `images` VALUES (289, 'Pijama Đôi Lụa', '/images/product_item_couple/3/pijama.png', '2026-01-26 23:39:22', 18);
INSERT INTO `images` VALUES (290, 'Áo Hoodie Đôi Basic', '/images/product_item_couple/1/hoodie.png', '2026-01-26 23:39:22', 19);

-- ----------------------------
-- Table structure for orderdetails
-- ----------------------------
DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_orderdetail_order`(`order_id`) USING BTREE,
  INDEX `fk_orderdetail_variant`(`variant_id`) USING BTREE,
  CONSTRAINT `fk_orderdetail_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_orderdetail_variant` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetails
-- ----------------------------
INSERT INTO `orderdetails` VALUES (1, 1, 1, 1, 320000.00);
INSERT INTO `orderdetails` VALUES (2, 2, 3, 2, 275000.00);
INSERT INTO `orderdetails` VALUES (3, 3, 5, 1, 270000.00);
INSERT INTO `orderdetails` VALUES (4, 4, 2, 2, 230000.00);
INSERT INTO `orderdetails` VALUES (5, 5, 4, 3, 240000.00);
INSERT INTO `orderdetails` VALUES (6, 6, 7, 2, 270000.00);
INSERT INTO `orderdetails` VALUES (7, 7, 1, 1, 290000.00);
INSERT INTO `orderdetails` VALUES (8, 8, 6, 3, 210000.00);
INSERT INTO `orderdetails` VALUES (9, 8, 2, 1, 330000.00);
INSERT INTO `orderdetails` VALUES (10, 9, 8, 1, 170000.00);
INSERT INTO `orderdetails` VALUES (11, 10, 1, 2, 455000.00);
INSERT INTO `orderdetails` VALUES (12, 11, 3, 1, 270000.00);
INSERT INTO `orderdetails` VALUES (13, 12, 4, 1, 380000.00);
INSERT INTO `orderdetails` VALUES (14, 13, 5, 2, 210000.00);
INSERT INTO `orderdetails` VALUES (15, 14, 7, 3, 270000.00);
INSERT INTO `orderdetails` VALUES (16, 15, 6, 2, 365000.00);
INSERT INTO `orderdetails` VALUES (17, 16, 2, 1, 320000.00);
INSERT INTO `orderdetails` VALUES (18, 17, 8, 2, 230000.00);
INSERT INTO `orderdetails` VALUES (19, 18, 1, 1, 160000.00);
INSERT INTO `orderdetails` VALUES (20, 19, 3, 3, 240000.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `shipping_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shipping_phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shipping_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PENDING',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NOT NULL,
  `fee_delivery` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `total_price` decimal(10, 2) NOT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_order_user`(`user_id`) USING BTREE,
  INDEX `fk_order_address`(`address_id`) USING BTREE,
  CONSTRAINT `fk_order_address` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 6, 'Đang vận chuyển', NULL, 350000.00, 0.00, 350000.00, '2024-12-28 10:15:00');
INSERT INTO `orders` VALUES (2, 2, 1, 'Chờ vận chuyển', NULL, 587000.00, 3000.00, 590000.00, '2024-07-25 09:00:00');
INSERT INTO `orders` VALUES (3, 2, 1, 'Đang vận chuyển', NULL, 300000.00, 0.00, 300000.00, '2024-03-29 11:40:00');
INSERT INTO `orders` VALUES (4, 5, 5, 'Đã huỷ', 'Khách hủy', 497000.00, 3000.00, 500000.00, '2025-07-07 10:12:00');
INSERT INTO `orders` VALUES (5, 5, 5, 'Chờ vận chuyển', NULL, 760000.00, 0.00, 760000.00, '2025-08-21 13:30:00');
INSERT INTO `orders` VALUES (6, 6, 2, 'Chờ vận chuyển', NULL, 577000.00, 3000.00, 580000.00, '2024-12-14 07:55:00');
INSERT INTO `orders` VALUES (7, 6, 2, 'Đã huỷ', 'Khách hủy', 310000.00, 0.00, 310000.00, '2024-09-14 16:30:00');
INSERT INTO `orders` VALUES (8, 7, 1, 'Chờ vận chuyển', NULL, 650000.00, 0.00, 650000.00, '2025-12-16 00:40:16');
INSERT INTO `orders` VALUES (9, 7, 1, 'Đã huỷ', 'Không nhận máy', 200000.00, 0.00, 200000.00, '2025-09-19 17:40:00');
INSERT INTO `orders` VALUES (10, 8, 6, 'Đang vận chuyển', NULL, 940000.00, 0.00, 940000.00, '2025-12-16 00:40:16');
INSERT INTO `orders` VALUES (11, 2, 1, 'Đã huỷ', 'Không nhận máy', 287000.00, 3000.00, 290000.00, '2025-01-14 14:00:00');
INSERT INTO `orders` VALUES (12, 8, 6, 'Đã Giao', NULL, 400000.00, 0.00, 400000.00, '2025-02-03 18:45:00');
INSERT INTO `orders` VALUES (13, 8, 6, 'Đã huỷ', 'Khách hủy', 450000.00, 0.00, 450000.00, '2025-02-28 09:22:00');
INSERT INTO `orders` VALUES (14, 9, 8, 'Đang vận chuyển', NULL, 850000.00, 0.00, 850000.00, '2025-12-16 00:40:16');
INSERT INTO `orders` VALUES (15, 10, 4, 'Đã Giao', NULL, 730000.00, 30000.00, 760000.00, '2025-06-20 16:30:00');
INSERT INTO `orders` VALUES (16, 1, 6, 'Đã Giao', NULL, 337000.00, 3000.00, 340000.00, '2025-03-12 08:20:00');
INSERT INTO `orders` VALUES (17, 5, 5, 'Đang vận chuyển', NULL, 487000.00, 3000.00, 490000.00, '2025-12-16 00:40:16');
INSERT INTO `orders` VALUES (18, 8, 6, 'Đang vận chuyển', NULL, 187000.00, 3000.00, 190000.00, '2025-04-05 15:00:00');
INSERT INTO `orders` VALUES (19, 7, 1, 'Đã Giao', NULL, 750000.00, 0.00, 750000.00, '2025-12-16 00:40:16');

-- ----------------------------
-- Table structure for parentcategories
-- ----------------------------
DROP TABLE IF EXISTS `parentcategories`;
CREATE TABLE `parentcategories`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of parentcategories
-- ----------------------------
INSERT INTO `parentcategories` VALUES (1, 'Nam', '2025-12-08 02:34:47');
INSERT INTO `parentcategories` VALUES (2, 'Nữ', '2025-12-08 02:34:47');
INSERT INTO `parentcategories` VALUES (3, 'Đồ Đôi', '2025-12-08 02:34:47');

-- ----------------------------
-- Table structure for payments
-- ----------------------------
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_payment_order`(`order_id`) USING BTREE,
  CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payments
-- ----------------------------
INSERT INTO `payments` VALUES (1, 1, 320000.00, 'Thanh toán khi giao hàng', 'Đang xử lý', '2024-12-28 11:00:00');
INSERT INTO `payments` VALUES (2, 2, 553000.00, 'Ví điện tử Momo', 'Thành công', '2024-07-25 09:30:00');
INSERT INTO `payments` VALUES (3, 3, 270000.00, 'Thanh toán khi giao hàng', 'Đang xử lý', '2024-03-29 12:10:00');
INSERT INTO `payments` VALUES (4, 4, 463000.00, 'Thanh toán khi giao hàng', 'Đang xử lý', '2025-07-07 10:20:00');
INSERT INTO `payments` VALUES (5, 5, 720000.00, 'Thẻ Visa', 'Thành công', '2025-08-21 14:00:00');
INSERT INTO `payments` VALUES (6, 6, 543000.00, 'Ví điện tử Momo', 'Thành công', '2024-12-14 08:10:00');
INSERT INTO `payments` VALUES (7, 7, 290000.00, 'Chuyển khoản ngân hàng', 'Đang xử lý', '2024-09-14 17:00:00');
INSERT INTO `payments` VALUES (8, 8, 630000.00, 'Thanh toán khi giao hàng', 'Đang xử lý', '2025-10-01 10:15:00');
INSERT INTO `payments` VALUES (9, 9, 170000.00, 'Thanh toán khi giao hàng', 'Đang xử lý', '2025-09-19 18:00:00');
INSERT INTO `payments` VALUES (10, 10, 910000.00, 'Thanh toán khi giao hàng', 'Thành công', '2024-12-05 12:10:00');
INSERT INTO `payments` VALUES (11, 11, 273000.00, 'Chuyển khoản ngân hàng', 'Thành công', '2025-01-14 14:20:00');
INSERT INTO `payments` VALUES (12, 12, 380000.00, 'Thẻ Visa', 'Thành công', '2025-02-03 19:00:00');
INSERT INTO `payments` VALUES (13, 13, 420000.00, 'Chuyển khoản ngân hàng', 'Thành công', '2024-12-28 13:10:00');
INSERT INTO `payments` VALUES (14, 14, 810000.00, 'Ví điện tử Momo', 'Thành công', '2025-01-11 14:00:00');
INSERT INTO `payments` VALUES (15, 15, 760000.00, 'Chuyển khoản ngân hàng', 'Thành công', '2025-06-20 17:00:00');
INSERT INTO `payments` VALUES (16, 16, 323000.00, 'Chuyển khoản ngân hàng', 'Thành công', '2025-01-19 14:30:00');
INSERT INTO `payments` VALUES (17, 17, 463000.00, 'Thẻ Visa', 'Đang xử lý', '2024-10-27 12:50:00');
INSERT INTO `payments` VALUES (18, 18, 163000.00, 'Ví điện tử Momo', 'Đang xử lý', '2024-09-14 17:10:00');
INSERT INTO `payments` VALUES (19, 19, 720000.00, 'Thanh toán khi giao hàng', 'Thành công', '2025-01-07 11:00:00');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) NULL DEFAULT NULL,
  `category_sub_id` int(11) NOT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `average_rating` decimal(3, 2) NULL DEFAULT 0.00,
  `short_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `detail_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_product_subcategory`(`category_sub_id`) USING BTREE,
  INDEX `fk_product_image`(`image_id`) USING BTREE,
  CONSTRAINT `fk_product_image` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_subcategory` FOREIGN KEY (`category_sub_id`) REFERENCES `subcategories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 1, 1, 'Áo khoác gió nam', 4.70, 'Áo khoác gió nhẹ', 'Chất liệu chống nước nhẹ, thích hợp đi làm và đi chơi.', 350000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (2, 21, 2, 'Áo thun nam basic', 4.60, 'Áo thun cotton', 'Vải cotton 100%, thoáng mát, form regular.', 160000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (3, 41, 3, 'Áo polo nam basic', 4.70, 'Polo cổ bẻ', 'Vải cá sấu cao cấp, thoáng khí.', 220000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (4, 61, 4, 'Sơ mi nam tay dài', 4.70, 'Sơ mi công sở', 'Chất liệu cotton mềm, ít nhăn.', 260000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (5, 81, 5, 'Quần short kaki nam', 4.50, 'Short kaki thoải mái', 'Dày dặn, đứng form, dễ phối đồ.', 190000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (6, 101, 6, 'Quần tây nam công sở', 4.70, 'Quần tây lịch sự', 'Vải mềm, đứng form, sang trọng.', 290000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (7, 121, 7, 'Jean slimfit nam', 4.70, 'Quần jean co giãn', 'Vải jean cao cấp, co giãn 4 chiều.', 300000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (8, 141, 8, 'Áo khoác gió nữ', 4.70, 'Chống gió tốt', 'Vải dù mỏng nhẹ, chống nước nhẹ.', 340000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (9, 161, 9, 'Áo thun nữ basic', 4.60, 'Áo thun cotton', 'Co giãn tốt, mỏng nhẹ.', 150000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (10, 177, 10, 'Áo polo nữ cổ bẻ', 4.70, 'Lịch sự, thanh lịch', 'Vải cá sấu mềm, thoát khí tốt.', 210000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (11, 195, 11, 'Sơ mi trắng nữ', 4.70, 'Sơ mi công sở', 'Vải lụa mềm, mát.', 240000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (12, 215, 12, 'Váy xòe hoa', 4.70, 'Nữ tính', 'Voan hoa nhẹ nhàng.', 260000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (13, 235, 13, 'Đầm body nữ', 4.80, 'Tôn dáng', 'Vải thun cao cấp, co giãn tốt.', 290000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (14, 251, 14, 'Quần short nữ jean', 4.60, 'Năng động', 'Jean co giãn nhẹ.', 180000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (15, 267, 15, 'Quần tây nữ công sở', 4.70, 'Thanh lịch', 'Vải tây cao cấp.', 270000.00, '2025-12-16 00:40:16', '2025-12-16 00:43:22');
INSERT INTO `products` VALUES (16, 287, 16, 'Áo Khoác Bomber Couple', 4.80, 'Phong cách đường phố', 'Áo khoác bomber chất liệu kaki 2 lớp, phù hợp cho các cặp đôi năng động.', 450000.00, '2026-01-26 23:39:22', '2026-01-26 23:39:22');
INSERT INTO `products` VALUES (17, 288, 17, 'Áo Thun Đôi In Tim', 4.50, 'Ngọt ngào lãng mạn', 'Áo thun cotton 100% in hình trái tim minimal, vải mát mịn.', 180000.00, '2026-01-26 23:39:22', '2026-01-26 23:39:22');
INSERT INTO `products` VALUES (18, 289, 18, 'Set Pijama Lụa Satin', 4.90, 'Sang trọng mặc nhà', 'Đồ bộ ngủ lụa satin cao cấp, mềm mại, thoáng mát cho giấc ngủ ngon.', 320000.00, '2026-01-26 23:39:22', '2026-01-26 23:39:22');
INSERT INTO `products` VALUES (19, 290, 16, 'Áo Hoodie Couple Basic', 4.70, 'Ấm áp mùa đông', 'Hoodie nỉ bông dày dặn, form rộng unisex dễ mặc.', 290000.00, '2026-01-26 23:39:22', '2026-01-26 23:39:22');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_review_product`(`product_id`) USING BTREE,
  INDEX `fk_review_variant`(`variant_id`) USING BTREE,
  INDEX `fk_review_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_review_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_variant` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, NULL, 1, 3, 5, 'Sản phẩm tốt, giao hàng nhanh', '2025-01-10 14:22:10');
INSERT INTO `review` VALUES (2, NULL, 2, 5, 3, 'Chất lượng tạm ổn, đóng gói chưa đẹp', '2025-01-12 09:11:45');
INSERT INTO `review` VALUES (3, NULL, 3, 7, 5, 'Rất hài lòng, sẽ mua lại', '2025-01-15 18:33:20');
INSERT INTO `review` VALUES (4, NULL, 1, 4, 3, 'Không giống mô tả, màu hơi lệch', '2025-01-17 12:05:55');
INSERT INTO `review` VALUES (5, NULL, 4, 1, 4, 'Giá tốt, chất lượng ổn trong tầm giá', '2025-01-20 20:14:03');
INSERT INTO `review` VALUES (6, NULL, 2, 6, 2, 'Sản phẩm lỗi, phải đổi trả', '2025-01-21 10:45:37');
INSERT INTO `review` VALUES (7, NULL, 5, 2, 4, 'Vải mềm, mặc thoải mái, sẽ ủng hộ tiếp', '2025-01-22 16:20:11');
INSERT INTO `review` VALUES (8, NULL, 3, 8, 4, 'Mặc ổn nhưng size hơi nhỏ hơn so với mô tả', '2025-01-23 08:55:49');
INSERT INTO `review` VALUES (9, NULL, 6, 4, 5, 'Đóng gói cẩn thận, chất lượng vượt mong đợi', '2025-01-24 19:40:28');
INSERT INTO `review` VALUES (10, NULL, 1, 9, 2, 'Giao chậm, sản phẩm không như kỳ vọng', '2025-01-25 11:13:57');

-- ----------------------------
-- Table structure for reviewimages
-- ----------------------------
DROP TABLE IF EXISTS `reviewimages`;
CREATE TABLE `reviewimages`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `review_id` int(11) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_reviewimage_review`(`review_id`) USING BTREE,
  CONSTRAINT `fk_reviewimage_review` FOREIGN KEY (`review_id`) REFERENCES `review` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviewimages
-- ----------------------------
INSERT INTO `reviewimages` VALUES (1, 1, '/images/category-banner/category/man/ao-so-mi-nam.png');
INSERT INTO `reviewimages` VALUES (2, 3, '/images/category-banner/category/man/quan-jean-nam.png');
INSERT INTO `reviewimages` VALUES (3, 4, '/images/category-banner/category/man/ao-thun-nam.png');
INSERT INTO `reviewimages` VALUES (4, 6, '/images/category-banner/category/woman/ao-khoac-nu.png');
INSERT INTO `reviewimages` VALUES (5, 7, '/images/category-banner/category/man/quan-tay-nam.png');

-- ----------------------------
-- Table structure for subcategories
-- ----------------------------
DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE `subcategories`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_parent_id` int(11) NOT NULL,
  `sub_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_subcategory_parent`(`category_parent_id`) USING BTREE,
  CONSTRAINT `fk_subcategory_parent` FOREIGN KEY (`category_parent_id`) REFERENCES `parentcategories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subcategories
-- ----------------------------
INSERT INTO `subcategories` VALUES (1, 1, 'Áo Khoác Nam', '2025-12-24 23:27:53', '/images/category-banner/category/man/ao-khoac-nam.png', 'Phong cách & ấm áp');
INSERT INTO `subcategories` VALUES (2, 1, 'Áo Thun', '2025-12-24 23:27:53', '/images/category-banner/category/man/ao-thun-nam.png', 'Thoải mái & năng động');
INSERT INTO `subcategories` VALUES (3, 1, 'Áo Polo', '2025-12-24 23:27:53', '/images/category-banner/category/man/ao-polo-nam.png', 'Lịch sự & thanh lịch');
INSERT INTO `subcategories` VALUES (4, 1, 'Áo Sơ Mi', '2025-12-24 23:27:53', '/images/category-banner/category/man/ao-so-mi-nam.png', 'Chuyên nghiệp & sang trọng');
INSERT INTO `subcategories` VALUES (5, 1, 'Quần ngắn', '2025-12-24 23:27:53', '/images/category-banner/category/man/quan-short-nam.png', 'Mát mẻ & thoải mái');
INSERT INTO `subcategories` VALUES (6, 1, 'Quần dài', '2025-12-24 23:27:53', '/images/category-banner/category/man/quan-dai-nam.png', 'Lịch lãm & trẻ trung');
INSERT INTO `subcategories` VALUES (7, 1, 'Quần Jean', '2025-12-24 23:27:53', '/images/category-banner/category/man/quan-jean-nam.png', 'Bền bỉ & thời trang');
INSERT INTO `subcategories` VALUES (8, 2, 'Áo Khoác', '2025-12-24 23:27:53', '/images/category-banner/category/woman/ao-khoac-nu.png', 'Sang trọng & ấm áp');
INSERT INTO `subcategories` VALUES (9, 2, 'Áo Thun', '2025-12-24 23:27:53', '/images/category-banner/category/woman/ao-thun-nu.png', 'Năng động & trẻ trung');
INSERT INTO `subcategories` VALUES (10, 2, 'Áo Polo', '2025-12-24 23:27:53', '/images/category-banner/category/woman/ao-polo-nu.png', 'Năng động & thanh lịch');
INSERT INTO `subcategories` VALUES (11, 2, 'Áo Sơ Mi', '2025-12-24 23:27:53', '/images/category-banner/category/woman/ao-so-mi-nu.png', 'Thanh lịch & nữ tính');
INSERT INTO `subcategories` VALUES (12, 2, 'Váy', '2025-12-24 23:27:53', '/images/category-banner/category/woman/vay-nu.png', 'Duyên dáng & quyến rũ');
INSERT INTO `subcategories` VALUES (13, 2, 'Đầm', '2025-12-24 23:27:53', '/images/category-banner/category/woman/dam-nu.png', 'Sang trọng & lộng lẫy');
INSERT INTO `subcategories` VALUES (14, 2, 'Quần ngắn', '2025-12-24 23:27:53', '/images/category-banner/category/woman/quan-short-nu.png', 'Thoải mái & năng động');
INSERT INTO `subcategories` VALUES (15, 2, 'Quần dài', '2025-12-24 23:27:53', '/images/category-banner/category/woman/quan-dai-nu.png', 'Thanh lịch & hiện đại');
INSERT INTO `subcategories` VALUES (16, 3, 'Áo khoác đôi', '2025-12-24 23:27:53', '/images/category-banner/category/couple/ao-khoac-doi.png', 'Ấm áp & lãng mạn');
INSERT INTO `subcategories` VALUES (17, 3, 'Áo thun đôi', '2025-12-24 23:27:53', '/images/category-banner/category/couple/ao-thun-doi.png', 'Tình yêu & gắn kết');
INSERT INTO `subcategories` VALUES (18, 3, 'Đồ bộ đôi', '2025-12-24 23:27:53', '/images/category-banner/category/couple/do-bo-doi.png', 'Hoàn hảo & hài hòa');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'ACTIVE',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'CUSTOMER',
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `verification_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 0 COMMENT '0: Chưa kích hoạt, 1: Đã kích hoạt',
  `google_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Nguyễn Văn Anh', 'qutoan23@gmail.com', 'Admin1234', '091456661', 'Hoạt Động', 'Admin', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (2, 'Trần Linh Xuân', 'lXu2k1@gmail.com', '12345678', '0903015502', 'Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (3, 'Đào Cẩm Anh', 'CAnh311@gmail.com', '12345678', '0901112893', 'Không Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (4, 'Đặng Tuấn Anh', 'Admin2@styleera.com', 'Admin1234', '0780220304', 'Hoạt Động', 'Admin', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (5, 'Linh Cẩm Tú', 'Hoacamtu11@gmail.com', '12345678', '0362019185', 'Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (6, 'Võ Xuân An', 'Funny6@gmail.com', '12345678', '0971523316', 'Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (7, 'Trần Ngọc Linh', 'Linhbeauty544@gmail.com', '12345678', '0970000007', 'Không Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (8, 'Nguyễn An Khánh', 'aKhanh123@gmail.com', '12345678', '0220000008', 'Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (9, 'Lê Xuân Kiên', 'kien91@gmail.com', '12345678', '0800000009', 'Không Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (10, 'Phan Hai Long', 'solong356@gmail.com', '12345678', '0776055510', 'Hoạt Động', 'User', '2025-12-16 00:40:16', NULL, 1, NULL);
INSERT INTO `users` VALUES (13, 'Trần Nhật Trường', 'tkun2k@gmail.com', '$2a$12$iO2CAYtpHi0OMrPacIjEs.TH6C8znaPmIYAzCErUfZgFLFWE8T2Bu', '0949844246', 'Hoạt Động', 'User', '2026-01-05 14:09:25', NULL, 1, NULL);
INSERT INTO `users` VALUES (14, 'Trần Nhật Trường', 'trannhattruong257@gmail.com', NULL, NULL, 'Hoạt Động', 'User', '2026-01-05 23:29:46', NULL, 1, '113854648859296000907');
INSERT INTO `users` VALUES (15, 'Trần Nhật Trường', '22130306@st.hcmuaf.edu.vn', '$2a$12$nj3Ex458lmZqmEnq2Iqoye9TkwVAT9h1yvM/t9u9c7knbnCykFPG2', '0949844246', 'Hoạt Động', 'User', '2026-01-21 03:24:05', NULL, 1, '111049883126427327377');

-- ----------------------------
-- Table structure for variants
-- ----------------------------
DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `size` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_variant_product`(`product_id`) USING BTREE,
  CONSTRAINT `fk_variant_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of variants
-- ----------------------------
INSERT INTO `variants` VALUES (1, 1, 'M', 'Đen', 30);
INSERT INTO `variants` VALUES (2, 1, 'L', 'Đen', 25);
INSERT INTO `variants` VALUES (3, 1, 'XL', 'Trắng', 20);
INSERT INTO `variants` VALUES (4, 2, 'S', 'Trắng', 15);
INSERT INTO `variants` VALUES (5, 2, 'M', 'Đen', 35);
INSERT INTO `variants` VALUES (6, 2, 'L', 'Xanh', 28);
INSERT INTO `variants` VALUES (7, 3, 'M', 'Đen', 40);
INSERT INTO `variants` VALUES (8, 3, 'L', 'Đỏ', 22);
INSERT INTO `variants` VALUES (9, 3, 'XL', 'Trắng', 18);
INSERT INTO `variants` VALUES (10, 4, 'S', 'Xanh', 12);
INSERT INTO `variants` VALUES (11, 4, 'M', 'Trắng', 27);
INSERT INTO `variants` VALUES (12, 4, 'L', 'Đen', 33);
INSERT INTO `variants` VALUES (13, 5, 'M', 'Đen', 44);
INSERT INTO `variants` VALUES (14, 5, 'L', 'Trắng', 21);
INSERT INTO `variants` VALUES (15, 5, 'XL', 'Xanh', 19);
INSERT INTO `variants` VALUES (16, 6, 'S', 'Đỏ', 14);
INSERT INTO `variants` VALUES (17, 6, 'M', 'Đen', 31);
INSERT INTO `variants` VALUES (18, 6, 'L', 'Trắng', 29);
INSERT INTO `variants` VALUES (19, 7, 'M', 'Đen', 37);
INSERT INTO `variants` VALUES (20, 7, 'L', 'Xanh', 25);
INSERT INTO `variants` VALUES (21, 7, 'XL', 'Trắng', 16);
INSERT INTO `variants` VALUES (22, 8, 'S', 'Đen', 11);
INSERT INTO `variants` VALUES (23, 8, 'M', 'Trắng', 34);
INSERT INTO `variants` VALUES (24, 8, 'L', 'Đỏ', 22);
INSERT INTO `variants` VALUES (25, 9, 'M', 'Xanh', 36);
INSERT INTO `variants` VALUES (26, 9, 'L', 'Đen', 24);
INSERT INTO `variants` VALUES (27, 9, 'XL', 'Trắng', 17);
INSERT INTO `variants` VALUES (28, 10, 'S', 'Đen', 13);
INSERT INTO `variants` VALUES (29, 10, 'M', 'Xanh', 29);
INSERT INTO `variants` VALUES (30, 10, 'L', 'Trắng', 26);
INSERT INTO `variants` VALUES (31, 11, 'M', 'Đen', 42);
INSERT INTO `variants` VALUES (32, 11, 'L', 'Đỏ', 0);
INSERT INTO `variants` VALUES (33, 12, 'S', 'Trắng', 18);
INSERT INTO `variants` VALUES (34, 12, 'M', 'Xanh', 33);
INSERT INTO `variants` VALUES (35, 12, 'XL', 'Đen', 20);
INSERT INTO `variants` VALUES (36, 13, 'L', 'Đen', 31);
INSERT INTO `variants` VALUES (37, 13, 'XL', 'Trắng', 14);
INSERT INTO `variants` VALUES (38, 14, 'M', 'Đen', 39);
INSERT INTO `variants` VALUES (39, 14, 'L', 'Xanh', 22);
INSERT INTO `variants` VALUES (40, 15, 'S', 'Trắng', 15);
INSERT INTO `variants` VALUES (41, 15, 'M', 'Đỏ', 27);
INSERT INTO `variants` VALUES (42, 15, 'L', 'Đen', 32);
INSERT INTO `variants` VALUES (43, 16, 'M', 'Đen', 20);
INSERT INTO `variants` VALUES (44, 16, 'L', 'Đen', 15);
INSERT INTO `variants` VALUES (45, 16, 'XL', 'Đen', 10);
INSERT INTO `variants` VALUES (46, 16, 'M', 'Xanh Rêu', 20);
INSERT INTO `variants` VALUES (47, 16, 'L', 'Xanh Rêu', 15);
INSERT INTO `variants` VALUES (48, 17, 'S', 'Trắng', 30);
INSERT INTO `variants` VALUES (49, 17, 'M', 'Trắng', 40);
INSERT INTO `variants` VALUES (50, 17, 'L', 'Trắng', 35);
INSERT INTO `variants` VALUES (51, 17, 'S', 'Hồng', 25);
INSERT INTO `variants` VALUES (52, 17, 'M', 'Hồng', 25);
INSERT INTO `variants` VALUES (53, 18, 'M', 'Đỏ', 15);
INSERT INTO `variants` VALUES (54, 18, 'L', 'Đỏ', 15);
INSERT INTO `variants` VALUES (55, 18, 'M', 'Xanh Than', 20);
INSERT INTO `variants` VALUES (56, 18, 'L', 'Xanh Than', 20);
INSERT INTO `variants` VALUES (57, 19, 'L', 'Xám', 30);
INSERT INTO `variants` VALUES (58, 19, 'XL', 'Xám', 25);
INSERT INTO `variants` VALUES (59, 19, 'L', 'Be', 30);
INSERT INTO `variants` VALUES (60, 19, 'XL', 'Be', 20);

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8mb4;
UPDATE products SET
short_description = 'Áo polo nam chất liệu cá sấu cotton interlock cao cấp, bề mặt mềm mịn, thấm hút tốt; thiết kế cổ bẻ, tay ngắn chuẩn form tạo vẻ ngoài lịch sự và sang trọng.',
detail_description = 'Áo polo nam mang phong cách tối giản, thanh lịch, phù hợp cho cả đi làm và đi chơi.\n\nTHÔNG TIN SẢN PHẨM\nForm áo Regular Fit vừa vặn, không quá ôm sát, mang lại sự thoải mái tối đa. Cổ áo dệt gân chắc chắn, giữ form tốt sau nhiều lần giặt. Logo thêu tỉ mỉ trước ngực tạo điểm nhấn tinh tế.\n\nCHẤT LIỆU SỬ DỤNG\nChất liệu cá sấu cotton interlock 100% tự nhiên. Sợi vải được xử lý chống co rút, chống nhăn, có khả năng kháng khuẩn và thấm hút mồ hôi vượt trội, giúp cơ thể luôn thoáng mát trong mọi thời tiết.'
WHERE id = 1;

UPDATE products SET
short_description = 'Áo thun T-shirt in họa tiết nổi bật, 100% cotton thoáng mát, form rộng rãi, thoải mái.',
detail_description = 'Thiết kế trẻ trung, năng động với họa tiết in sắc nét, không bong tróc. Phù hợp diện hàng ngày hoặc dạo phố.\n\nTHÔNG TIN SẢN PHẨM\nForm dáng Oversize rộng rãi, thoải mái vận động. Cổ tròn bo viền cẩn thận, không bị bai nhão. Đường may tỉ mỉ, chắc chắn.\n\nCHẤT LIỆU SỬ DỤNG\n100% Cotton tự nhiên mềm mịn, an toàn cho da nhạy cảm. Khả năng co giãn 4 chiều và thấm hút mồ hôi cực tốt, không gây bí bách khi mặc.'
WHERE id = 2;

UPDATE products SET
short_description = 'Quần Jeans nam dáng Slim Fit, chất bò denim co giãn nhẹ, màu xanh wash thời trang.',
detail_description = 'Chiếc quần Jeans quốc dân dễ dàng phối với mọi loại áo, từ T-shirt năng động đến sơ mi lịch lãm.\n\nTHÔNG TIN SẢN PHẨM\nDáng quần Slim Fit ôm vừa phải, tôn dáng nhưng không gò bó. Ống quần may viền chắc chắn, túi xéo tiện lợi rộng rãi. Khóa kéo đồng chống gỉ sét trơn tru.\n\nCHẤT LIỆU SỬ DỤNG\nVải Denim pha Spandex mang lại độ co giãn tuyệt vời. Công nghệ wash màu hiện đại giúp quần giữ được màu xanh tự nhiên, không phai màu sau khi giặt.'
WHERE id = 3;

UPDATE products SET
short_description = 'Áo sơ mi nam tay dài, form Slim Fit ôm body, chất liệu lụa nến cao cấp chống nhăn.',
detail_description = 'Biểu tượng của sự trưởng thành và quyến rũ. Áo sơ mi tay dài giúp phái mạnh luôn tự tin và nổi bật trong các buổi tiệc hay nơi công sở.\n\nTHÔNG TIN SẢN PHẨM\nForm Slim Fit ôm khéo léo đường nét cơ thể. Cổ bẻ cứng cáp với lớp lót đệm tinh tế. Cúc áo đính kèm viền ngọc trai sang trọng, tay áo măng sét dễ dàng điều chỉnh.\n\nCHẤT LIỆU SỬ DỤNG\nLụa nến nhập khẩu cao cấp, bề mặt trơn nhẵn, bóng nhẹ, cực kỳ mềm mại trên da. Đặc biệt chống nhăn tự nhiên, tiết kiệm thời gian ủi đồ.'
WHERE id = 4;

UPDATE products SET
short_description = 'Áo khoác gió nam nữ 2 lớp chống nước, cản gió cực tốt. Tiện lợi cho thời tiết giao mùa.',
detail_description = 'Người bạn đồng hành lý tưởng trên những chuyến đi xa. Gọn nhẹ, dễ dàng gấp gọn mang theo mọi lúc mọi nơi.\n\nTHÔNG TIN SẢN PHẨM\nThiết kế tay dài có mũ trùm đầu tiện lợi. Bo chun tay áo và gấu áo giúp cản gió tối đa. Hệ thống túi zip an toàn 2 bên hông và túi trong ngực áo để giữ đồ cá nhân.\n\nCHẤT LIỆU SỬ DỤNG\nLớp ngoài là Polyester công nghệ Nano chống thấm nước, chống xước. Lớp trong lót lưới dệt kim thoáng khí, ngăn cảm giác hầm bí khi mặc liên tục.'
WHERE id = 5;

UPDATE products SET
short_description = 'Quần âu nam dáng đứng Hàn Quốc, vải tuyết mưa lên form cực chuẩn, không xù lông.',
detail_description = 'Mảnh ghép hoàn hảo cho một diện mạo quý ông lịch lãm. Kết hợp cùng sơ mi hoặc áo polo để có ngay một bộ trang phục chuẩn mực.\n\nTHÔNG TIN SẢN PHẨM\nDáng quần Regular Fit suông đứng, tạo cảm giác kéo dài chân. Xếp ly tỉ mỉ trước quần giữ nếp phẳng phiu. Đai quần lót cao su chống tuột áo khi sơ vin.\n\nCHẤT LIỆU SỬ DỤNG\nVải tuyết mưa (Vitex) nhập khẩu, có độ rũ tự nhiên, lên form đứng dáng. Chất vải không nhăn, không bám bụi và hoàn toàn không xù lông sau thời gian dài sử dụng.'
WHERE id = 6;

UPDATE products SET
short_description = 'Áo len nam cổ lọ dáng suông, dệt kim vặn thừng dày dặn, ấm áp cho mùa thu đông.',
detail_description = 'Mang âm hưởng phong cách Vintage cổ điển. Áo len cổ lọ không chỉ giữ ấm mà còn là điểm nhấn thời trang đầy tinh tế cho những ngày se lạnh.\n\nTHÔNG TIN SẢN PHẨM\nCổ lọ gập đôi ấm áp, thiết kế dệt hoa văn vặn thừng (Cable Knit) truyền thống. Form suông vừa người, dễ dàng phối layer cùng áo măng tô hoặc áo khoác da bên ngoài.\n\nCHẤT LIỆU SỬ DỤNG\nSợi len lông cừu pha Acrylic siêu nhẹ, siêu ấm. Bề mặt len mềm xốp, không gây ngứa hay châm chích da. Xử lý chống co rút và không bị dão form sau khi giặt.'
WHERE id = 7;

UPDATE products SET
short_description = 'Quần short Kaki nam trên gối, trẻ trung năng động, chất kaki thun co giãn thoải mái.',
detail_description = 'Giải nhiệt mùa hè với chiếc quần short Kaki đa năng, lựa chọn số 1 cho các hoạt động dã ngoại, thể thao hay dạo phố cuối tuần.\n\nTHÔNG TIN SẢN PHẨM\nĐộ dài quần vừa vặn trên đầu gối, ống quần rộng rãi thoải mái. Túi xéo hai bên sâu rộng, túi mổ phía sau cài cúc thanh lịch. Thiết kế cạp quần vừa vặn, chuẩn số đo.\n\nCHẤT LIỆU SỬ DỤNG\nKaki thun pha Spandex độ co giãn 4 chiều linh hoạt. Vải đã qua xử lý enzyme giúp bề mặt mềm mại, không thô cứng và cực kỳ bền màu dưới ánh nắng gắt.'
WHERE id = 8;

UPDATE products SET
short_description = 'Bộ thể thao nam thu đông, áo hoodie và quần jogger nỉ bông, phong cách đường phố.',
detail_description = 'Set đồ hoàn hảo cho phong cách Streetwear bụi bặm nhưng vẫn đề cao sự thoải mái, ứng dụng linh hoạt từ phòng tập đến phố thị.\n\nTHÔNG TIN SẢN PHẨM\nBộ gồm áo Hoodie có mũ trùm rộng, túi chéo trước bụng và quần Jogger bo gấu chun. Đường cắt may 3D ôm theo hình dáng cơ thể nhưng không bó sát.\n\nCHẤT LIỆU SỬ DỤNG\nNỉ da cá lót bông dày dặn, giữ nhiệt siêu đỉnh. Lớp bông bên trong được chải kỹ, không rụng lông, không dính vào áo trong. Chất vải đứng form, chống bai nhão hiệu quả.'
WHERE id = 9;

UPDATE products SET
short_description = 'Áo thun Baby Tee nữ dáng ôm, in chữ ngực tinh tế, hack dáng siêu đỉnh cho hội chị em.',
detail_description = 'Chiếc áo "nhỏ nhưng có võ", bảo bối hack dáng không thể thiếu trong tủ đồ của các cô gái yêu thích vẻ đẹp ngọt ngào, quyến rũ.\n\nTHÔNG TIN SẢN PHẨM\nForm dáng Baby Tee đặc trưng ôm sát cơ thể, chiều dài lửng vừa chạm rốn giúp khoe khéo vòng eo. Cổ viền nhỏ tôn xương quai xanh, hình in mini trước ngực sắc nét.\n\nCHẤT LIỆU SỬ DỤNG\nCotton Borip Thái dệt gân nổi, co giãn 4 chiều cực mạnh ôm trọn đường cong. Vải mịn, thấm hút siêu tốt, giữ form hoàn hảo không bị giãn hay chảy xệ.'
WHERE id = 10;

UPDATE products SET
short_description = 'Chân váy chữ A dáng ngắn xếp ly, eo cao tôn dáng, phong cách nữ sinh năng động.',
detail_description = 'Sức hút khó cưỡng từ phong cách Preppy trong trẻo. Chân váy xếp ly giúp nàng "ăn gian" chiều cao đáng kể và luôn bừng sáng sự tươi trẻ.\n\nTHÔNG TIN SẢN PHẨM\nThiết kế lưng cao gen bụng dưới, đường xếp ly bản to dập ly vĩnh viễn không mất nếp. Đặc biệt có quần bảo hộ mỏng nhẹ bên trong, tự tin vận động 100% không lo hớ hênh.\n\nCHẤT LIỆU SỬ DỤNG\nVải tuýt xi mềm mại nhưng giữ được độ đứng form của ly váy. Vải dệt láng mịn, chống nhăn cực tốt, chỉ cần giũ nhẹ sau khi giặt là có thể mặc ngay.'
WHERE id = 11;

UPDATE products SET
short_description = 'Đầm body quyến rũ, chất nhung sang trọng dự tiệc dạ hội.',
detail_description = 'Nữ hoàng của những buổi tiệc tùng. Thiết kế táo bạo nhưng sang trọng giúp nàng phô diễn trọn vẹn những đường cong quyến rũ nhất của cơ thể.\n\nTHÔNG TIN SẢN PHẨM\nForm đầm ôm sát cơ thể (Bodycon), cổ chữ V xẻ sâu tinh tế và có đệm mút ngực định hình sẵn. Tôn lên vòng 3 với đường cắt may chuẩn xác. Kiểu dáng dài qua đầu gối thanh lịch, có đường xẻ tà một bên tôn chân dài.\n\nCHẤT LIỆU SỬ DỤNG\nVải Nhung Velvet Pháp cao cấp, óng ánh nhẹ khi bắt sáng. Chất liệu nhung có độ dày vừa phải, co giãn tốt, không chùng giúp siết mỡ thừa mà còn giữ form cực kỳ chuẩn xác.'
WHERE id = 12;

UPDATE products SET
short_description = 'Quần short jean nữ cạp cao, rách gấu tua rua cực cá tính.',
detail_description = 'Đại diện cho sự trẻ trung, phá cách và gợi cảm. Quần short jean cạp cao là vũ khí bí mật giúp các nàng "hack" dáng chân dài miên man.\n\nTHÔNG TIN SẢN PHẨM\nThiết kế quần cạp cao qua rốn giúp che bụng hoàn hảo. Phần ống quần được đánh rách xước và tua rua phần gấu cá tính. Form dáng A-line chữ A nhẹ giúp tạo cảm giác eo nhỏ và đùi thon hơn.\n\nCHẤT LIỆU SỬ DỤNG\nVải Jean Cotton tinh khiết không co giãn, giữ form tuyệt đối sau hàng ngàn lần giặt. Nhuộm bằng công nghệ chàm tự nhiên (Indigo) thân thiện với môi trường và bền màu lâu phai.'
WHERE id = 13;

UPDATE products SET
short_description = 'Quần tây ống loe nữ, hack dáng dài miên man cực thời thượng.',
detail_description = 'Sự trở lại của xu hướng thập niên 90 với nét chấm phá hiện đại. Quần tây ống loe sẽ giúp bạn có một diện mạo đầy quyền lực và thời thượng chốn văn phòng.\n\nTHÔNG TIN SẢN PHẨM\nCạp quần bản to ôm trọn vòng eo, phần đùi ôm nhẹ và xòe loe nhẹ dần từ đầu gối xuống mắt cá chân. Điểm nhấn là đường xếp ly nổi thẳng tắp kéo dài từ trên xuống dưới, tạo hiệu ứng thị giác cho đôi chân dài vô tận.\n\nCHẤT LIỆU SỬ DỤNG\nVải Tuyết Mưa dệt thoi nhập khẩu Hàn Quốc. Mảnh vải cực kỳ dày dặn, rủ xuống đẹp mắt nhưng lại không gây nóng bức. Không bị xước chỉ hay bám lông dính bụi.'
WHERE id = 14;

UPDATE products SET
short_description = 'Áo khoác bomber bóng chày đôi cho tình yêu thêm năng động.',
detail_description = 'Mang đậm phong cách High-school Mỹ. Áo bomber đôi giúp bạn và người ấy "đánh dấu chủ quyền" một cách đầy cá tính và thể thao khi sánh bước cùng nhau.\n\nTHÔNG TIN SẢN PHẨM\nÁo có thiết kế cổ chui, phối màu tay áo và thân áo tương phản độc đáo. Có logo thêu nổi tỉ mỉ trước ngực. Nút bấm kim loại chắc chắn, túi xéo hai bên hông rộng rãi để tay cực "cool".\n\nCHẤT LIỆU SỬ DỤNG\nThân áo làm từ vải Nỉ đanh, tay áo phối chất liệu Da PU tổng hợp siêu xịn, chống thấm nước và chống gió. Cổ và tay áo được dệt thun gân sọc dày dặn không bai nhão.'
WHERE id = 15;

UPDATE products SET
short_description = 'Áo thun cặp đôi in họa tiết trái tim, đơn giản mà lãng mạn.',
detail_description = 'Thông điệp tình yêu không cần nói thành lời. Cùng diện chiếc áo đôi nhỏ xinh này trong những chuyến du lịch để ghi lại những khoảnh khắc tuyệt vời nhất nhé.\n\nTHÔNG TIN SẢN PHẨM\nThiết kế unisex phù hợp cho cả nam và nữ. Form áo rộng vừa phải. Họa tiết hình trái tim và dòng typography ý nghĩa được in lỗi kỹ thuật số sắc nét, tinh xảo ở giữa ngực.\n\nCHẤT LIỆU SỬ DỤNG\n100% Cotton chải kỹ (Combed Cotton), đã loại bỏ các sợi ngắn thô cứng. Bề mặt siêu láng mịn, mát tay. Công nghệ in chuyển nhiệt giúp hình in mềm mịn, không bao giờ bong tróc.'
WHERE id = 16;

UPDATE products SET
short_description = 'Set pijama ngủ lụa satin cho cặp đôi, tận hưởng sự thoải mái.',
detail_description = 'Gia vị ngọt ngào cho tình yêu thêm thăng hoa mỗi đêm. Set đồ ngủ đôi cao cấp mang đến cảm giác thư giãn tuyệt đối cho giấc ngủ của cả hai người.\n\nTHÔNG TIN SẢN PHẨM\nBao gồm áo sơ mi tay dài cổ bẻ chữ V phối đường viền viền màu nổi bật và quần dài suông. Cạp quần làm từ dây chun lụa mềm mại, không gây hằn đỏ da. Có túi nhỏ may trước ngực tinh tế.\n\nCHẤT LIỆU SỬ DỤNG\nLụa Satin Silk tơ tằm nhân tạo thượng hạng. Vải có độ bóng nhẹ trượt mướt lướt trên làn da. Khả năng điều hòa nhiệt độ: Mát mẻ vào mùa hè và giữ ấm cơ thể trong phòng điều hòa lạnh.'
WHERE id = 17;

UPDATE products SET
short_description = 'Áo hoodie đôi dáng rộng, có mũ trùm ấm áp cho mùa đông.',
detail_description = 'Cái ôm ấm áp nhất vào những ngày gió lùa. Hoodie đôi nỉ bông chính là món đồ minh chứng cho tình yêu bền chặt, để cả hai thoải mái chui gọn vào chung một chiếc áo nếu thích!\n\nTHÔNG TIN SẢN PHẨM\nThiết kế dáng Oversize form rộng thùng thình chuẩn phong cách Hàn Quốc. Có túi bụng Kangaroo "thần thánh" to bản phía trước và phần mũ trùm rộng có dây rút đôi. Bo gấu và bo tay ôm nhẹ.\n\nCHẤT LIỆU SỬ DỤNG\nChất liệu Nỉ lót bông (Fleece) cực kỳ dày dặn dệt từ sợi tổng hợp CVC. Lớp bông cào bên trong mềm như nhung, giữ nhiệt xuất sắc, chống xù lông mặt ngoài và giặt máy không lo hỏng form.'
WHERE id = 18;

UPDATE products SET
short_description = 'Áo măng tô nam nữ unisex dáng dài, phong cách thanh lịch châu Âu.',
detail_description = 'Biểu tượng của sự quyền lực và thanh lịch. Áo măng tô dáng dài giúp nâng tầm phong cách ngay lập tức, biến mọi set đồ bình thường trở nên sang trọng như trên tạp chí.\n\nTHÔNG TIN SẢN PHẨM\nThiết kế dáng dài qua đầu gối, cổ bẻ bản to sang trọng. Có kèm đai thắt eo giúp tạo dáng linh hoạt. Hàng cúc đính đôi (Double-breasted) cổ điển với hai túi nắp vuông vức bên hông.\n\nCHẤT LIỆU SỬ DỤNG\nVải Dạ Tweed cao cấp pha len lông cừu, đứng form cứng cáp nhưng không quá nặng nề. Lớp lót lụa nhân tạo bên trong trơn láng giúp dễ dàng mặc chồng lên nhiều lớp áo mà không bị cộm.'
WHERE id = 19;

SET NAMES utf8mb4;

UPDATE products SET 
  short_description = 'Áo polo nam chất liệu cá sấu cotton interlock cao cấp, bề mặt mềm mịn, thấm hút tốt; thiết kế cổ bẻ, tay ngắn chuẩn form tạo vẻ ngoài lịch sự và sang trọng.',
  detail_description = 'Áo polo nam mang phong cách tối giản, thanh lịch, phù hợp cho cả đi làm và đi chơi. Đây là mẫu áo luôn nằm trong top best-seller nhờ khả năng dễ phối đồ, sự thoải mái và cực kỳ nịnh dáng. Mẫu áo này hứa hẹn sẽ mang đến cho phái mạnh một vẻ ngoài lịch lãm nhưng không kém phần trẻ trung.

**THÔNG TIN SẢN PHẨM**
- Form áo Regular Fit vừa vặn, không quá ôm sát, mang lại sự thoải mái tối đa khi vận động.
- Cổ áo dệt gân chắc chắn, phối nút cài tinh tế, giữ form tốt sau nhiều lần giặt.
- Logo thương hiệu được thêu tỉ mỉ trước ngực tạo điểm nhấn sang trọng.
- Đường may viền cẩn thận, không có chỉ thừa, đảm bảo độ bền bỉ theo thời gian.

**CHẤT LIỆU SỬ DỤNG**
- Vải cá sấu cotton interlock 100% tự nhiên cao cấp, mềm mịn thân thiện với làn da.
- Sợi vải đã qua xử lý công nghệ cao giúp chống co rút và chống nhăn hiệu quả.
- Khả năng kháng khuẩn và thấm hút mồ hôi vượt trội, giúp cơ thể luôn thoáng mát.

**HƯỚNG DẪN BẢO QUẢN**
- Ưu tiên giặt tay hoặc giặt máy ở chế độ nhẹ nhàng (nhiệt độ nước dưới 30 độ C).
- Không sử dụng hóa chất tẩy rửa mạnh.
- Lộn trái áo khi phơi ở nơi thoáng mát, tránh ánh nắng trực tiếp để màu sắc bền lâu.' 
WHERE id = 1;

UPDATE products SET 
  short_description = 'Áo thun T-shirt in họa tiết nổi bật, 100% cotton thoáng mát, form rộng rãi, thoải mái.',
  detail_description = 'Thiết kế trẻ trung, năng động với họa tiết in sắc nét, áo thun T-shirt là item không thể thiếu trong tủ đồ của những chàng trai và cô gái hiện đại. Sự kết hợp hoàn hảo giữa kiểu dáng thoải mái và chất liệu cao cấp mang lại trải nghiệm tuyệt vời cho người mặc trong những buổi dạo phố, đi học hay đi chơi.

**THÔNG TIN SẢN PHẨM**
- Form dáng Oversize rộng rãi, thoải mái vận động, phù hợp với mọi vóc dáng.
- Cổ tròn bo viền cẩn thận, không bị bai nhão hay mất form sau thời gian dài sử dụng.
- Hình in họa tiết ứng dụng công nghệ kỹ thuật số hiện đại, sắc nét và không bong tróc.
- Đường may hai kim chắc chắn ở gấu áo và tay áo.

**CHẤT LIỆU SỬ DỤNG**
- 100% Cotton tự nhiên mềm mịn, an toàn và thân thiện ngay cả với làn da nhạy cảm.
- Độ co giãn 4 chiều vừa phải, giữ nguyên được phom dáng ban đầu.
- Khả năng thấm hút mồ hôi cực tốt, không gây cảm giác hầm bí khi mặc vào mùa hè.

**HƯỚNG DẪN BẢO QUẢN**
- Nên giặt mặt trái của áo để bảo vệ hình in một cách tốt nhất.
- Không ủi (ủi) trực tiếp lên khu vực có hình in.
- Giặt với nước ở nhiệt độ thường và tránh sấy khô ở nhiệt độ cao.' 
WHERE id = 2;

UPDATE products SET 
  short_description = 'Quần Jeans nam dáng Slim Fit, chất bò denim co giãn nhẹ, màu xanh wash thời trang.',
  detail_description = 'Được mệnh danh là chiếc quần Jeans quốc dân, siêu phẩm này dễ dàng phối hợp với mọi loại áo từ T-shirt năng động đến sơ mi lịch lãm. Thiết kế hiện đại kết hợp cùng tông màu xanh wash thời thượng giúp phái mạnh khẳng định gu thẩm mỹ đầy cuốn hút và nam tính.

**THÔNG TIN SẢN PHẨM**
- Dáng quần Slim Fit ôm vừa phải dọc theo chiều dài chân, tôn dáng nhưng không gò bó.
- Ống quần may viền chắc chắn, túi xéo hai bên tiện lợi, sâu rộng để thoải mái đựng ví, điện thoại.
- Khóa kéo đồng cao cấp chống gỉ sét, trơn tru và bền bỉ.
- Nút cài bằng hợp kim dập nổi logo thương hiệu vô cùng tinh tế.

**CHẤT LIỆU SỬ DỤNG**
- Vải Denim cao cấp pha Spandex mang lại độ co giãn tuyệt vời cho các hoạt động thường ngày.
- Vải dệt mật độ cao giúp chống sờn rách hiệu quả.
- Công nghệ wash màu hiện đại giúp quần giữ được màu xanh tự nhiên, không phai ra các trang phục khác khi giặt.

**HƯỚNG DẪN BẢO QUẢN**
- Khuyến khích giặt ít lại (khoảng sau 3-4 lần mặc) để giữ trọn vẹn màu sắc và phom dáng.
- Giặt bằng nước lạnh và hạn chế sử dụng máy sấy nhiệt độ cao.
- Có thể thêm một chút muối vào lần giặt đầu tiên để khóa màu quần Jeans.' 
WHERE id = 3;

UPDATE products SET 
  short_description = 'Áo sơ mi nam tay dài, form Slim Fit ôm body, chất liệu lụa nến cao cấp chống nhăn.',
  detail_description = 'Biểu tượng của sự trưởng thành và quyến rũ. Chiếc áo sơ mi tay dài với thiết kế cắt may hoàn hảo này là bảo bối giúp phái mạnh luôn tự tin, nổi bật trong các buổi gặp gỡ đối tác, đi tiệc hay môi trường công sở đòi hỏi sự chỉn chu.

**THÔNG TIN SẢN PHẨM**
- Form Slim Fit ôm khéo léo đường nét cơ thể, làm nổi bật bờ vai rộng và phần ngực.
- Cổ bẻ cứng cáp với lớp lót đệm tinh tế, giữ được form ngay cả khi tháo cà vạt.
- Cúc áo đính kèm viền ngọc trai sang trọng, được may đính cực kỳ chắc chắn.
- Tay áo măng sét (cuff) dễ dàng điều chỉnh độ rộng hoặc gập lên tạo phong cách phóng khoáng.

**CHẤT LIỆU SỬ DỤNG**
- Sử dụng lụa nến nhập khẩu cao cấp, bề mặt trơn nhẵn, bóng nhẹ, cực kỳ mềm mại trên da.
- Chất liệu có đặc tính chống nhăn tự nhiên, giúp người mặc luôn giữ được phong thái phẳng phiu.
- Có độ rủ tự nhiên, tạo cảm giác cực kỳ sang trọng và đắt tiền.

**HƯỚNG DẪN BẢO QUẢN**
- Treo áo bằng móc gỗ bản to để giữ phom vai.
- Cài hết cúc áo (kể cả cúc cổ và cúc tay) khi giặt máy hoặc tốt nhất nên giặt khô.
- Ủi áo ở nhiệt độ thấp hoặc sử dụng bàn ủi hơi nước để tránh làm bóng vải.' 
WHERE id = 4;

UPDATE products SET 
  short_description = 'Áo khoác gió nam nữ 2 lớp chống nước, cản gió cực tốt. Tiện lợi cho thời tiết giao mùa.',
  detail_description = 'Người bạn đồng hành lý tưởng trên những chuyến đi xa hay những ngày thời tiết giao mùa thất thường. Chiếc áo khoác gió với thiết kế hiện đại, mỏng nhẹ có thể dễ dàng gấp gọn mang theo mọi lúc mọi nơi mà vẫn đáp ứng đủ tiêu chí bảo vệ cơ thể khỏi mưa, nắng, gió.

**THÔNG TIN SẢN PHẨM**
- Thiết kế áo tay dài có mũ trùm đầu rộng rãi, tích hợp dây rút tiện lợi điều chỉnh độ khít.
- Bo chun đàn hồi ở tay áo và gấu áo giúp cản gió tối đa luồn vào cơ thể.
- Hệ thống túi zip an toàn 2 bên hông và 1 túi ẩn phía trong ngực áo để giữ tài sản cá nhân, điện thoại.
- Dây khóa kéo nhựa dẻo trơn tru có lớp chắn chống ngấm nước qua rãnh khóa.

**CHẤT LIỆU SỬ DỤNG**
- Lớp ngoài làm từ Polyester ứng dụng công nghệ Nano chống thấm nước, chống xước và ngăn tia UV.
- Lớp lót lưới dệt kim bên trong mỏng nhẹ, tăng cường khả năng thoáng khí.
- Chất liệu nhanh khô, hoàn toàn không gây cảm giác hầm bí hay dính dấp khi cơ thể ra mồ hôi.

**HƯỚNG DẪN BẢO QUẢN**
- Khóa kéo lại toàn bộ và lộn trái trước khi cho vào máy giặt.
- Giặt ở chế độ thường với nước mát.
- Không ủi bằng bàn ủi nhiệt trực tiếp vì có thể làm hỏng lớp màng chống thấm Nano.' 
WHERE id = 5;

UPDATE products SET 
  short_description = 'Quần âu nam dáng đứng Hàn Quốc, vải tuyết mưa lên form cực chuẩn, không xù lông.',
  detail_description = 'Mảnh ghép hoàn hảo cho một diện mạo quý ông lịch lãm mang đậm phong cách Hàn Quốc. Kết hợp chiếc quần âu này cùng áo sơ mi, áo polo hay áo thun trơn đều mang đến một outfit chuẩn mực, thu hút mọi ánh nhìn tại nơi làm việc hoặc những sự kiện quan trọng.

**THÔNG TIN SẢN PHẨM**
- Dáng quần Regular Fit suông đứng, che khuyết điểm chân và tạo hiệu ứng thị giác giúp đôi chân trông thon dài hơn.
- Xếp ly tỉ mỉ bằng nhiệt độ cao ở mặt trước quần, giữ được nếp phẳng phiu vĩnh viễn.
- Đai quần được lót một lớp cao su siêu mảnh bên trong, tác dụng ma sát chống tuột áo khi bạn sơ vin.
- Các chi tiết con đỉa quần, túi sau mổ khuy đều được hoàn thiện không tì vết.

**CHẤT LIỆU SỬ DỤNG**
- Vải tuyết mưa (Vitex) nhập khẩu cao cấp, có độ rũ tự nhiên tuyệt đẹp, giúp quần luôn lên form đứng dáng.
- Chất vải có đặc tính không nhăn, không bám bụi, rất tiện lợi cho những người bận rộn.
- Hoàn toàn không xù lông hay phai màu sau thời gian dài sử dụng.

**HƯỚNG DẪN BẢO QUẢN**
- Có thể giặt máy bình thường nhưng nên tránh vắt quá mạnh.
- Phơi quần lên móc kẹp chuyên dụng bằng cách kẹp vào cạp quần để quần luôn thẳng.
- Chỉ nên ủi qua bằng bàn là hơi nước nếu cần thiết.' 
WHERE id = 6;

UPDATE products SET 
  short_description = 'Áo len nam cổ lọ dáng suông, dệt kim vặn thừng dày dặn, ấm áp cho mùa thu đông.',
  detail_description = 'Mang âm hưởng phong cách Vintage cổ điển pha lẫn vẻ đẹp hiện đại. Chiếc áo len cổ lọ nam không chỉ là "tấm khiên" giữ ấm tuyệt vời mà còn là điểm nhấn thời trang đầy tinh tế. Phái mạnh có thể dễ dàng biến tấu nhiều phong cách từ lãng mạn đến nam tính khi diện thiết kế này.

**THÔNG TIN SẢN PHẨM**
- Cổ lọ thiết kế gập đôi vô cùng ấm áp, bảo vệ vùng cổ trong những ngày nhiệt độ xuống thấp.
- Bề mặt dệt hoa văn vặn thừng (Cable Knit) truyền thống, tinh xảo đến từng mũi kim.
- Form dáng suông vừa người, dễ dàng phối layer cùng áo sơ mi bên trong hoặc áo măng tô, áo khoác da bên ngoài.
- Bo gấu tay và gấu áo chắc chắn, bo sát vào cổ tay ngăn gió lùa.

**CHẤT LIỆU SỬ DỤNG**
- Sợi len pha Acrylic siêu nhẹ, siêu ấm nhưng không gây cảm giác nặng nề.
- Bề mặt len mềm xốp, đặc biệt không gây ngứa hay châm chích trực tiếp lên da.
- Áo đã được xử lý qua quy trình ép nhiệt chống co rút, không lo dão phom sau khi giặt.

**HƯỚNG DẪN BẢO QUẢN**
- Khuyến nghị giặt tay hoặc bỏ vào túi lưới khi giặt máy để sợi len không bị cọ xát.
- Trải ngang áo trên giá phơi thay vì treo móc để áo không bị giãn theo chiều dọc do sức nặng của nước.
- Không sử dụng máy sấy nhiệt độ cao.' 
WHERE id = 7;

UPDATE products SET 
  short_description = 'Quần short Kaki nam trên gối, trẻ trung năng động, chất kaki thun co giãn thoải mái.',
  detail_description = 'Giải nhiệt mùa hè cùng chiếc quần short Kaki đa năng cực kỳ trẻ trung. Đây là sự lựa chọn số 1 cho các hoạt động dã ngoại, chơi thể thao, du lịch biển hay đơn giản là những buổi dạo phố cuối tuần cùng bạn bè, mang đến cho bạn cảm giác tự do không gò bó.

**THÔNG TIN SẢN PHẨM**
- Độ dài quần được tinh chỉnh vừa vặn nằm trên đầu gối, tạo vẻ ngoài khỏe khoắn, năng động.
- Ống quần có độ rộng vừa phải, không bó sát đùi gây khó chịu khi ngồi hay di chuyển.
- Túi xéo hai bên hông khoét sâu rộng rãi đựng điện thoại an toàn, túi mổ phía sau cài cúc thanh lịch.
- Đường chỉ may kép dọc theo thân quần đảm bảo độ bền bỉ kể cả khi vận động mạnh.

**CHẤT LIỆU SỬ DỤNG**
- Kaki thun pha sợi Spandex với độ co giãn 4 chiều cực kỳ linh hoạt.
- Vải Kaki đã qua công đoạn xử lý enzyme sinh học giúp làm mềm bề mặt, không bị thô cứng.
- Chất vải giữ phom cực tốt, có độ bền màu cao, chịu được ánh nắng gắt mà không phai sờn.

**HƯỚNG DẪN BẢO QUẢN**
- Có thể giặt chung với quần áo màu sáng nếu đã qua lần giặt đầu tiên.
- Tránh sử dụng thuốc tẩy trực tiếp lên vải để giữ màu Kaki luôn tươi mới.
- Khuyến khích phơi trong bóng râm, tránh ánh nắng chiếu trực tiếp quá gắt.' 
WHERE id = 8;

UPDATE products SET 
  short_description = 'Bộ thể thao nam thu đông, áo hoodie và quần jogger nỉ bông, phong cách đường phố.',
  detail_description = 'Set đồ hoàn hảo khắc họa chân thực phong cách Streetwear bụi bặm nhưng vẫn đề cao sự thoải mái tuyệt đối. Bộ thể thao Thu Đông này có tính ứng dụng cực kỳ linh hoạt, bạn có thể tự tin diện chúng từ phòng tập gym ra đến đường phố mà vẫn luôn nổi bật và phong cách.

**THÔNG TIN SẢN PHẨM**
- Bộ quần áo gồm 2 món: Áo Hoodie và Quần Jogger cùng tone màu.
- Áo Hoodie thiết kế mũ trùm rộng lót hai lớp dày dặn, có dây rút và túi chéo to bản trước bụng.
- Quần Jogger bo gấu chun đàn hồi, cạp thun co giãn kết hợp dây rút ẩn bên trong dễ điều chỉnh.
- Form dáng rộng rãi theo cấu trúc cắt may 3D ôm nhẹ theo hình dáng cơ thể nhưng hoàn toàn không gò bó.

**CHẤT LIỆU SỬ DỤNG**
- Vải nỉ da cá cao cấp có lót bông dày dặn bên trong, giữ nhiệt siêu đỉnh trong những ngày rét đậm.
- Lớp bông nỉ được chải kỹ qua công nghệ hiện đại: không rụng lông, không dính bụi bông vào áo thun mặc bên trong.
- Bề mặt ngoài đanh mịn, kháng gió tốt, không bai nhão và chống xù lông hoàn hảo sau hàng loạt lần giặt.

**HƯỚNG DẪN BẢO QUẢN**
- Lộn trái toàn bộ áo và quần khi giặt máy.
- Không sấy ở nhiệt độ quá cao để lớp bông lót không bị xơ cứng.
- Khuyến khích gấp gọn cất tủ thay vì treo lên móc thời gian dài.' 
WHERE id = 9;

UPDATE products SET 
  short_description = 'Áo thun Baby Tee nữ dáng ôm, in chữ ngực tinh tế, hack dáng siêu đỉnh cho hội chị em.',
  detail_description = 'Chiếc áo "nhỏ nhưng có võ", bảo bối hack dáng không thể thiếu trong tủ đồ của các cô gái yêu thích vẻ đẹp năng động, ngọt ngào và pha chút quyến rũ. Thiết kế Baby Tee lấy cảm hứng từ thời trang Y2K đang trở thành xu hướng oanh tạc làng thời trang hiện tại.

**THÔNG TIN SẢN PHẨM**
- Form dáng Baby Tee đặc trưng ôm khít vào cơ thể, chiều dài lửng vừa chạm rốn giúp khoe khéo vòng eo thon.
- Phần vai và tay áo ôm vừa phải, không làm bắp tay bị to, tạo cảm giác thân trên nhỏ nhắn hơn.
- Cổ áo viền nhỏ tỉ mỉ, tôn lên đường nét thanh tú của xương quai xanh.
- Điểm nhấn chữ typography in mini ép nhiệt trước ngực sắc nét, tinh giản nhưng hiện đại.

**CHẤT LIỆU SỬ DỤNG**
- Dòng vải Cotton Borip Thái dệt gân nổi, co giãn 4 chiều cực mạnh, ôm trọn mọi đường cong một cách mượt mà.
- Chất vải mềm, mát lạnh khi chạm vào da, khả năng thấm hút mồ hôi siêu tốt cho ngày dài năng động.
- Giữ form hoàn hảo, có độ đàn hồi trở lại tuyệt vời, cam kết không dão hay chảy xệ sau nhiều lần giặt.

**HƯỚNG DẪN BẢO QUẢN**
- Khuyến nghị giặt tay nhẹ nhàng để giữ form áo ôm sát lâu nhất.
- Không nên kéo giãn áo quá mức khi phơi, nên vắt nhẹ nước trước khi treo.
- Hạn chế sử dụng nước xả vải làm mềm sợi vì có thể làm mất đi độ đàn hồi của vải borip.' 
WHERE id = 10;

UPDATE products SET 
  short_description = 'Chân váy chữ A dáng ngắn xếp ly, eo cao tôn dáng, phong cách nữ sinh năng động.',
  detail_description = 'Sức hút khó cưỡng đến từ phong cách Preppy trong trẻo, mang hơi hướng thời trang học đường. Chân váy chữ A xếp ly ngắn là tuyệt chiêu giúp các nàng "ăn gian" chiều cao đáng kể, đồng thời mang lại diện mạo luôn bừng sáng sự tươi trẻ, dễ thương và tràn đầy năng lượng.

**THÔNG TIN SẢN PHẨM**
- Thiết kế cạp váy lưng cao giúp ôm gọn và gen phần mỡ bụng dưới cực hiệu quả.
- Đường xếp ly bản to dập nhiệt vĩnh viễn, xếp nếp xòe nhẹ tự nhiên khi di chuyển, không bị mất nếp sau khi giặt.
- Chiều dài váy qua mông giúp kéo dài đôi chân một cách ấn tượng.
- Đặc biệt trang bị quần bảo hộ mỏng nhẹ, mềm mại liền bên trong váy, giúp bạn tự tin vận động 100% không lo hớ hênh.

**CHẤT LIỆU SỬ DỤNG**
- Vải tuýt xi (Tuytsi) Hàn Quốc mềm mại nhưng lại sở hữu độ cứng cáp nhất định giúp váy luôn đứng form chữ A.
- Bề mặt vải dệt láng mịn, chống nhăn cực tốt, không bắt bụi.
- Chất vải lên màu chuẩn xác, không bị loang lổ và rất dễ dàng trong việc làm sạch.

**HƯỚNG DẪN BẢO QUẢN**
- Nên sử dụng móc treo có kẹp hai bên để treo cạp váy, giúp các nếp ly luôn thẳng đứng.
- Không vò mạnh tay trực tiếp vào các đường dập ly khi giặt.
- Nếu cần ủi, nên ủi ở mặt trái và đi dọc theo các đường nếp gấp ly có sẵn.' 
WHERE id = 11;

UPDATE products SET 
  short_description = 'Đầm body quyến rũ, chất nhung sang trọng dự tiệc dạ hội.',
  detail_description = 'Khẳng định đẳng cấp "Nữ hoàng" của mọi buổi dạ tiệc với thiết kế cực kỳ sang trọng này. Chiếc đầm mang nét táo bạo pha trộn sự kiêu sa, giúp phái đẹp phô diễn trọn vẹn những đường cong quyến rũ nhất của cơ thể, thu hút ánh nhìn ngưỡng mộ của những người xung quanh.

**THÔNG TIN SẢN PHẨM**
- Form đầm ôm sát cơ thể (Bodycon), áp dụng nghệ thuật cắt may tạo hình giúp định hình vòng eo con kiến.
- Cổ chữ V xẻ sâu tinh tế, vừa đủ tôn vòng một mà không hề phản cảm. Bên trong có đệm mút ngực định hình sẵn tiện lợi.
- Tôn lên vòng 3 quyến rũ với phần chiết eo sắc sảo.
- Kiểu dáng dài qua đầu gối thanh lịch, kèm đường xẻ tà một bên đùi cao hút mắt giúp việc di chuyển trở nên uyển chuyển.

**CHẤT LIỆU SỬ DỤNG**
- Vải Nhung Velvet nhập khẩu từ Pháp thuộc dòng cao cấp nhất, óng ánh sắc nét khi bắt gặp ánh sáng đèn tiệc.
- Bề mặt nhung êm ái, trượt nhẹ trên da. Độ dày vừa phải giúp siết mỡ thừa cực tốt nhưng vẫn giữ được độ thoáng khí.
- Vải co giãn 4 chiều linh hoạt, không bị chùng hay nhão, ôm sát theo mọi cử động của người mặc.

**HƯỚNG DẪN BẢO QUẢN**
- Chỉ nên giặt khô (Dry Clean) để lớp nhung giữ được độ óng ả và mượt mà nguyên bản.
- Tránh tiếp xúc với nhiệt độ cao (ủi nóng, nước sôi) làm cháy sém bề mặt lông nhung.
- Dùng cây lăn bụi hoặc bàn chải mềm chuyên dụng để lấy đi bụi bẩn bám trên nhung.' 
WHERE id = 12;

UPDATE products SET 
  short_description = 'Quần short jean nữ cạp cao, rách gấu tua rua cực cá tính.',
  detail_description = 'Đại diện tiêu biểu cho tinh thần trẻ trung, phá cách và gợi cảm trong thời trang mùa hè. Chiếc quần short jean cạp cao luôn là "vũ khí bí mật" không thể thiếu trong balo du lịch, giúp các nàng khoe khéo vòng eo nhỏ gọn và "hack" dáng chân dài miên man.

**THÔNG TIN SẢN PHẨM**
- Thiết kế cạp quần cạp cao (High-waist) vượt trên rốn, giúp che chắn mỡ bụng hoàn hảo.
- Form dáng A-line (chữ A nhẹ) mở rộng về phía gấu quần, tạo ảo giác đùi thon gọn hơn rất nhiều.
- Ống quần được đánh rách xước thủ công và tua rua phần gấu bất quy tắc vô cùng bụi bặm, cá tính.
- Khóa kéo mượt mà, cúc gài mạ hợp kim cao cấp không rỉ sét.

**CHẤT LIỆU SỬ DỤNG**
- Vải Jean Cotton tinh khiết 100% không co giãn, giữ form dáng tuyệt đối vững chắc sau hàng ngàn lần giặt.
- Sợi jean đanh và dày dặn nhưng bề mặt xử lý mềm, không gây cọ xát tổn thương da.
- Nhuộm bằng công nghệ chàm tự nhiên (Indigo) thân thiện với môi trường, cho ra màu xanh jean kinh điển bền bỉ lâu phai.

**HƯỚNG DẪN BẢO QUẢN**
- Giặt mặt trái và phơi trong bóng râm để phần rách tua rua không bị xổ chỉ quá mức.
- Không sử dụng bàn chải chà mạnh lên mặt vải.
- Ít giặt lại (chỉ giặt khi thực sự cần) để jean giữ được độ cứng cáp đặc trưng.' 
WHERE id = 13;

UPDATE products SET 
  short_description = 'Quần tây ống loe nữ, hack dáng dài miên man cực thời thượng.',
  detail_description = 'Đánh dấu sự trở lại ngoạn mục của xu hướng thập niên 90 với những nét chấm phá vô cùng hiện đại. Quần tây ống loe mang đến cho người phụ nữ đương thời một diện mạo đầy quyền lực, chuyên nghiệp và thời thượng, dù là chốn văn phòng hay tại những sự kiện trang trọng.

**THÔNG TIN SẢN PHẨM**
- Cạp quần bản to cạp cao ôm trọn vòng eo, phần đùi thiết kế ôm nhẹ tôn vòng 3.
- Cấu trúc xòe loe nhẹ dần từ vị trí đầu gối xuống đến gót chân với tỷ lệ vàng, giúp kéo dài đôi chân triệt để.
- Điểm nhấn đắt giá là đường xếp ly 3D nổi bật, chạy thẳng tắp dọc ống quần tạo hiệu ứng thị giác thon gọn tuyệt vời.
- Thiết kế túi mổ ẩn thanh lịch ở hai bên, tôn vinh nét tối giản tinh tế.

**CHẤT LIỆU SỬ DỤNG**
- Sử dụng vải Tuyết Mưa dệt thoi nhập khẩu Hàn Quốc cao cấp, đáp ứng tiêu chuẩn khắt khe về may mặc.
- Mảnh vải vô cùng dày dặn, rủ xuống tự nhiên theo trọng lực, không làm lộ khuyết điểm đôi chân.
- Khả năng chống nhăn xuất sắc, kháng bụi bẩn, không gây tĩnh điện bám dính lông vào mùa đông.

**HƯỚNG DẪN BẢO QUẢN**
- Có thể giặt máy ở chế độ bình thường. Phơi quần bằng kẹp móc thẳng đứng.
- Khi ủi, chú ý đè nhẹ bàn là theo dọc đường gân xếp ly để quần luôn giữ được vẻ sắc sảo sắc nét.
- Tránh móc phải các vật nhọn để vải không bị xước sợi.' 
WHERE id = 14;

UPDATE products SET 
  short_description = 'Áo khoác bomber bóng chày đôi cho tình yêu thêm năng động.',
  detail_description = 'Mang đậm hơi thở của phong cách High-school Mỹ, năng động và tràn đầy nhiệt huyết. Mẫu áo khoác bomber bóng chày Varsity là item hoàn hảo để các cặp đôi "đánh dấu chủ quyền" một cách đầy cá tính, nổi bật khi sánh bước cùng nhau trên đường phố.

**THÔNG TIN SẢN PHẨM**
- Thiết kế bomber không cổ cổ điển, phối màu tản sắc tương phản độc đáo giữa phần tay áo và thân áo.
- Logo chữ cái bản to được thêu xù nổi 3D tỉ mỉ trước ngực mang lại cảm giác cao cấp.
- Nút bấm kim loại dập nổi chắc chắn, thao tác cởi/đóng cực kỳ dễ dàng.
- Hai túi xéo bên hông rộng rãi đính viền da, thoải mái để tay giữ ấm cực "cool" ngầu.

**CHẤT LIỆU SỬ DỤNG**
- Phần thân áo được làm từ vải Nỉ Đanh (Heavyweight Fleece) dày dặn, cản gió tuyệt đối và đứng form.
- Phần tay áo ghép nối linh hoạt từ chất liệu Da PU tổng hợp siêu xịn, chống thấm nước, dễ lau chùi.
- Cổ áo, gấu tay và gấu áo dệt thun gân sọc dày, độ đàn hồi cực cao, ôm sát chắn gió và tuyệt đối không bai nhão.

**HƯỚNG DẪN BẢO QUẢN**
- Không giặt tay áo da bằng máy giặt để tránh nứt nẻ lớp da PU. Nên dùng khăn ẩm lau sạch tay áo.
- Treo bằng móc để giữ form vai thẳng, không gập nhỏ nén chặt trong tủ thời gian dài.
- Tuyệt đối không để phần tay da tiếp xúc trực tiếp với nhiệt độ cao của máy sấy hay bàn ủi.' 
WHERE id = 15;

UPDATE products SET 
  short_description = 'Áo thun cặp đôi in họa tiết trái tim, đơn giản mà lãng mạn.',
  detail_description = 'Một thông điệp tình yêu tinh tế không cần nói thành lời. Cùng nửa kia diện chiếc áo đôi nhỏ xinh này trong những chuyến du lịch, buổi hẹn hò cà phê cuối tuần để lưu lại những khoảnh khắc tuyệt vời và ngọt ngào nhất. Sự đơn giản tạo nên sự trường tồn cùng thời gian.

**THÔNG TIN SẢN PHẨM**
- Thiết kế kiểu dáng Unisex tiêu chuẩn, kích thước đa dạng phù hợp cho phom dáng của cả nam và nữ.
- Form áo suông rộng vừa phải, thoải mái che mọi khuyết điểm mà vẫn tôn dáng.
- Họa tiết hình trái tim và dòng typography mang ý nghĩa yêu thương được bố trí hài hòa ở chính giữa ngực.
- Công nghệ in kỹ thuật số tiên tiến giúp hình ảnh hiện lên sắc nét, tinh xảo đến từng pixel.

**CHẤT LIỆU SỬ DỤNG**
- Vải 100% Cotton chải kỹ (Combed Cotton) loại 1, trải qua quá trình xử lý lược bỏ hoàn toàn các sợi vải ngắn, thô ráp.
- Bề mặt áo mang lại trải nghiệm siêu láng mịn, mát mẻ trượt nhẹ trên da.
- Hình in chuyển nhiệt ép ở nhiệt độ cao, đảm bảo cực kỳ mềm mịn, liền khối với vải, không bao giờ bong tróc hay rạn nứt.

**HƯỚNG DẪN BẢO QUẢN**
- Giặt chung với quần áo sáng màu, không dùng chất tẩy có Clo.
- Lộn trái áo trước khi giặt và khi phơi để bảo vệ hình in tránh tiếp xúc với ma sát bề mặt máy giặt.
- Ủi áo từ mặt trái ở nhiệt độ thấp đối với khu vực có hình in ép nhiệt.' 
WHERE id = 16;

UPDATE products SET 
  short_description = 'Set pijama ngủ lụa satin cho cặp đôi, tận hưởng sự thoải mái.',
  detail_description = 'Một gia vị đầy ngọt ngào giúp tình yêu thêm thăng hoa mỗi đêm. Set đồ ngủ Pijama đôi cao cấp được thiết kế nhằm nâng niu những phút giây nghỉ ngơi tại nhà, mang đến cảm giác thư giãn tuyệt đối cho giấc ngủ vàng ngọc của cả hai người sau ngày dài mệt mỏi.

**THÔNG TIN SẢN PHẨM**
- Set đồ bao gồm: 1 áo sơ mi tay dài và 1 quần dài suông.
- Áo thiết kế cổ bẻ chữ V lãng mạn, phối đường viền ống (piping) khác màu cực kỳ nổi bật và thanh lịch. Có túi ngực nhỏ tinh tế.
- Quần dáng suông rộng, cạp quần sử dụng dải chun bọc lụa 100% mềm mại, hoàn toàn không gây hằn đỏ da bụng.
- Các đường may nối bên trong được vắt sổ viền kín, không gây cọ xát với cơ thể.

**CHẤT LIỆU SỬ DỤNG**
- Sử dụng Lụa Satin Silk tơ tằm nhân tạo thượng hạng, dệt với mật độ cao tạo bề mặt óng ả.
- Vải có độ bóng ngọc trai tinh tế, khi mặc trượt mướt lướt trên làn da vô cùng thích thú.
- Khả năng điều hòa nhiệt độ thông minh: Mang lại cảm giác mát mẻ thoáng đãng vào mùa hè, nhưng lại giữ ấm cơ thể rất tốt trong phòng điều hòa lạnh.

**HƯỚNG DẪN BẢO QUẢN**
- Đặc biệt khuyến cáo giặt bằng tay hoặc giặt máy ở chế độ "Delicate/Lụa" trong túi giặt lưới.
- Sử dụng xà phòng tắm hoặc dầu gội pha loãng để giặt, giúp lụa bền hơn thay vì dùng bột giặt mạnh.
- Phơi trong bóng mát nhiều gió, lụa satin rất mau khô. Tránh ánh nắng gắt làm xơ giòn sợi tơ.' 
WHERE id = 17;

UPDATE products SET 
  short_description = 'Áo hoodie đôi dáng rộng, có mũ trùm ấm áp cho mùa đông.',
  detail_description = 'Như một cái ôm ấm áp nhất bảo vệ bạn vào những ngày gió lùa. Hoodie đôi nỉ bông chính là món đồ minh chứng cho sự đồng điệu và tình yêu bền chặt, thiết kế "oversize" rộng rãi để cả hai thoải mái chui rúc vào chung một chiếc áo nếu thích! Sự gắn kết hoàn hảo cho mùa đông.

**THÔNG TIN SẢN PHẨM**
- Thiết kế kiểu dáng Oversize form rộng thùng thình, vai trễ phóng khoáng chuẩn phong cách thần tượng Hàn Quốc.
- Mũ trùm đầu cực rộng, bọc hai lớp vải dày, kèm dây rút dệt đôi chắc chắn.
- Túi bụng Kangaroo "thần thánh" to bản phía trước bụng, thoải mái cất giữ đôi tay lạnh cóng.
- Phần bo gấu áo và bo cổ tay được may ôm nhẹ vừa phải, ngăn triệt để gió lạnh lùa vào.

**CHẤT LIỆU SỬ DỤNG**
- Được tạo thành từ chất liệu Nỉ lót bông (Fleece Heavyweight) dệt từ sợi tổng hợp CVC cực kỳ dày dặn.
- Lớp bông cào bên trong trải qua công nghệ làm xốp, mang lại độ mềm êm như nhung, giữ nhiệt độ cơ thể xuất sắc.
- Bề mặt ngoài xử lý chống bám bụi, kháng tia UV nhẹ, chống xù lông tuyệt đối dù giặt máy với cường độ cao.

**HƯỚNG DẪN BẢO QUẢN**
- Lộn trái áo trước khi cho vào máy giặt để bảo vệ bề mặt ngoài luôn nhẵn mịn.
- Khuyến nghị sử dụng nước xả vải ở lần giặt cuối để lớp lông cừu bên trong luôn tơi xốp, mềm mại.
- Khi phơi nên trải ngang áo hoặc vắt ngang móc để tránh sức nặng của nước làm dão áo.' 
WHERE id = 18;

UPDATE products SET 
  short_description = 'Áo măng tô nam nữ unisex dáng dài, phong cách thanh lịch châu Âu.',
  detail_description = 'Biểu tượng tối thượng của sự quyền lực, thanh lịch và trường tồn với thời gian. Áo măng tô dáng dài Trench Coat là thiết kế mang âm hưởng Châu Âu cổ điển, sở hữu sức mạnh nâng tầm phong cách ngay lập tức, biến mọi set đồ bình thường trở nên đẳng cấp và sang trọng như trên trang bìa tạp chí.

**THÔNG TIN SẢN PHẨM**
- Thiết kế dáng dài quyền lực (chiều dài qua đầu gối), che chắn cơ thể tuyệt vời trước thời tiết khắc nghiệt.
- Cổ áo bẻ bản to sang trọng, vuông vức nam tính nhưng vẫn mềm mại cho nữ.
- Có kèm đai thắt eo với khóa nhựa dẻo cùng màu, giúp biến tấu tạo dáng chiết eo linh hoạt.
- Hàng cúc đính đôi (Double-breasted) giả sừng cổ điển, cùng hai nắp túi vuông bản lớn dọc bên hông tạo sự cân đối thị giác.

**CHẤT LIỆU SỬ DỤNG**
- Áo may từ loại vải Dạ Tweed cao cấp pha trộn sợi len lông cừu, tạo nên bề mặt xốp nhẹ, lên form đứng dáng cứng cáp nhưng không hề gây cảm giác nặng vai.
- Cấu trúc vải chắn gió tốt, cách nhiệt hoàn hảo giữ ấm trong cả những ngày đại hàn.
- Lớp lót (lining) bên trong làm từ lụa Viscose nhân tạo trơn láng, mang lại cảm giác trượt mát và giúp dễ dàng mặc chồng lên nhiều lớp áo len dày mà không bị cộm cọ xát.

**HƯỚNG DẪN BẢO QUẢN**
- Ưu tiên dịch vụ giặt khô (Dry Cleaning) chuyên nghiệp để áo giữ trọn form dáng chuẩn nhất từ nhà sản xuất.
- Khi không sử dụng, nên bọc áo bằng túi bảo quản và treo tủ bằng móc áo bản rộng (móc suit).
- Dùng cây lăn bụi định kỳ để giữ bề mặt dạ luôn sạch sẽ, tránh dùng bàn chải lông cứng chà xát.' 
WHERE id = 19;

