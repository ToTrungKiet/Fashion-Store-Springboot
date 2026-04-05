-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th3 19, 2026 lúc 03:58 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `fashion-store`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `address` text DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `items` text DEFAULT NULL,
  `payment` bit(1) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `transaction_ref` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `address`, `amount`, `created_at`, `items`, `payment`, `payment_method`, `status`, `updated_at`, `user_id`, `transaction_ref`) VALUES
(2, '{\"firstName\":\"Kiệt\",\"lastName\":\"Tô Trung\",\"email\":\"kevindkid@gmail.com\",\"address\":\"71 Tân Lập 1\",\"ward\":\"Phường Hiệp Phú\",\"district\":\"Quận 9\",\"city\":\"Hồ Chí Minh\",\"phone\":\"0981959702\"}', 190000, '2026-03-08 15:06:19.453184', '[{\"id\":9,\"name\":\"Áo sơ mi bé trai cotton tay ngắn\",\"description\":\"Áo sơ mi cotton dành cho bé trai, tay ngắn, thoáng mát và dễ phối đồ cho sinh hoạt hằng ngày.\",\"price\":160000,\"category\":\"Trẻ em\",\"subCategory\":\"Áo\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871004/efd2xbrnh25vvkpdcwn9.png\"],\"createdAt\":\"2026-03-07T15:10:05.389222\",\"updatedAt\":\"2026-03-07T15:10:05.389222\",\"size\":\"M\",\"quantity\":1}]', b'0', 'cod', 'Đang đóng gói', '2026-03-12 15:21:48.358213', 7, NULL),
(3, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:44:22.476604', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:44:22.484202', 10, '3'),
(4, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:44:24.102923', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:44:24.109923', 10, '4'),
(5, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:44:26.715423', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:44:26.723422', 10, '5'),
(6, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:44:26.883018', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:44:26.888017', 10, '6'),
(7, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:44:27.038762', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:44:27.044764', 10, '7'),
(8, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:44:27.176743', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:44:27.182929', 10, '8'),
(9, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:45:31.028104', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:45:31.036615', 10, '9'),
(10, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:45:42.560424', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:45:42.566424', 10, '10'),
(11, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:51:30.208803', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:51:30.271320', 10, '11'),
(12, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:54:30.029770', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:54:30.070769', 10, '12'),
(13, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:54:31.231151', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:54:31.239152', 10, '13'),
(14, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 19:55:05.250839', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 19:55:05.291838', 10, '14'),
(15, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:08:21.907502', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:08:21.967016', 10, '15'),
(16, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:08:45.842776', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:08:45.849776', 10, '16'),
(17, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:13:20.119923', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:13:20.156556', 10, '17'),
(18, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:16:36.429391', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:16:36.473398', 10, '18'),
(19, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:17:03.071655', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:17:03.079174', 10, '19'),
(20, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:21:13.077505', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:21:13.133960', 10, '20'),
(21, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:23:27.101855', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:23:27.110420', 10, '21'),
(22, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:27:05.488835', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-14 20:27:05.536107', 10, '22'),
(23, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 220000, '2026-03-14 20:37:35.995040', '[{\"id\":17,\"name\":\"Quần palazzo nữ họa tiết kèm thắt lưng\",\"description\":\"Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.\",\"price\":190000,\"category\":\"Nữ\",\"subCategory\":\"Quần\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png\"],\"createdAt\":\"2026-03-07T15:19:18.780419\",\"updatedAt\":\"2026-03-07T15:19:18.780419\",\"size\":\"XL\",\"quantity\":1}]', b'1', 'vnpay', 'Đơn hàng đã đặt', '2026-03-14 20:38:15.944790', 10, '23'),
(24, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 210000, '2026-03-14 22:21:25.653458', '[{\"id\":20,\"name\":\"Áo thun bé trai cổ tròn cotton không tay\",\"description\":\"Áo thun cotton không tay dành cho bé trai, thiết kế cổ tròn, phong cách thể thao, phù hợp mặc mùa hè và hoạt động ngoài trời.\",\"price\":180000,\"category\":\"Trẻ em\",\"subCategory\":\"Áo\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871767/oi4j1t19nw6m6k6gongt.png\"],\"createdAt\":\"2026-03-07T15:22:48.611654\",\"updatedAt\":\"2026-03-07T15:22:48.611654\",\"size\":\"M\",\"quantity\":1}]', b'1', 'vnpay', 'Đang đóng gói', '2026-03-14 22:34:32.828461', 10, '24'),
(25, '{\"firstName\":\"0562_Bùi\",\"lastName\":\"Đạt\",\"email\":\"tandat21012004@gmail.com\",\"address\":\"15B Lê Thánh Tôn\",\"ward\":\"phuong 2\",\"district\":\"Quan 1\",\"city\":\"TP. Hồ Chí Minh\",\"phone\":\"0969507080\"}', 250000, '2026-03-15 08:08:38.640020', '[{\"id\":24,\"name\":\"Áo khoác denim nữ khóa cài dáng relaxed\",\"description\":\"Áo khoác denim nữ thiết kế dáng relaxed, chất liệu jean mềm, khóa cài phía trước, phù hợp phối đồ casual hằng ngày.\",\"price\":220000,\"category\":\"Nữ\",\"subCategory\":\"Áo khoác\",\"bestseller\":false,\"sizes\":[\"S\",\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872050/zngrha1soxuxyiew9zvr.png\"],\"createdAt\":\"2026-03-07T15:27:30.92207\",\"updatedAt\":\"2026-03-07T15:27:30.92207\",\"size\":\"XL\",\"quantity\":1}]', b'1', 'vnpay', 'Đã gửi hàng', '2026-03-15 08:10:21.122160', 10, '25'),
(26, '{\"firstName\":\"Nguyễn Hữu\",\"lastName\":\"Gia Lâm\",\"email\":\"lamnguyenhuugia@gmail.com\",\"address\":\"199 Hoang Huu Nam\",\"ward\":\"Phường Long Thạnh Mỹ\",\"district\":\"Thành phố Thủ Đức\",\"city\":\"Thành phố Hồ Chí Minh\",\"phone\":\"0327621734\"}', 230000, '2026-03-19 21:30:25.000000', '[{\"id\":5,\"name\":\"Áo thun bé gái cổ tròn cotton\",\"description\":\"Áo thun cotton mềm mại dành cho bé gái, thiết kế cổ tròn, tay ngắn, form thoải mái, phù hợp mặc hằng ngày và các hoạt động vui chơi.\",\"price\":100000,\"category\":\"Trẻ em\",\"subCategory\":\"Áo\",\"bestseller\":true,\"sizes\":[\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772867306/h0tokl0svftvrb6wuba3.png\"],\"inventory\":{\"M__Trắng\":81,\"L__Trắng\":47,\"M__Đen\":2,\"XL__Trắng\":110,\"L__Đen\":14,\"M__Xám\":25,\"XL__Xám\":73,\"XL__Đen\":101,\"L__Xám\":96},\"createdAt\":\"2026-03-07T14:08:26\",\"updatedAt\":\"2026-03-18T14:03:08\",\"size\":\"M\",\"color\":\"Đen\",\"quantity\":2}]', b'1', 'vnpay', 'Đã giao thành công', '2026-03-19 21:31:41.000000', 11, '26'),
(27, '{\"firstName\":\"Nguyễn Hữu\",\"lastName\":\"Gia Lâm\",\"email\":\"lamnguyenhuugia@gmail.com\",\"address\":\"199 Hoang Huu Nam\",\"ward\":\"Phường Long Thạnh Mỹ\",\"district\":\"Thành phố Thủ Đức\",\"city\":\"Thành phố Hồ Chí Minh\",\"phone\":\"0327621734\"}', 230000, '2026-03-19 21:32:51.000000', '[{\"id\":5,\"name\":\"Áo thun bé gái cổ tròn cotton\",\"description\":\"Áo thun cotton mềm mại dành cho bé gái, thiết kế cổ tròn, tay ngắn, form thoải mái, phù hợp mặc hằng ngày và các hoạt động vui chơi.\",\"price\":100000,\"category\":\"Trẻ em\",\"subCategory\":\"Áo\",\"bestseller\":true,\"sizes\":[\"M\",\"L\",\"XL\"],\"image\":[\"https://res.cloudinary.com/ddjmyyryf/image/upload/v1772867306/h0tokl0svftvrb6wuba3.png\"],\"inventory\":{\"M__Trắng\":81,\"L__Trắng\":47,\"M__Đen\":0,\"XL__Trắng\":110,\"L__Đen\":14,\"M__Xám\":25,\"XL__Xám\":73,\"XL__Đen\":101,\"L__Xám\":96},\"createdAt\":\"2026-03-07T14:08:26\",\"updatedAt\":\"2026-03-18T14:03:08\",\"size\":\"M\",\"color\":\"Trắng\",\"quantity\":2}]', b'0', 'vnpay', 'Chờ thanh toán', '2026-03-19 21:32:51.000000', 11, '27');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
  `bestseller` bit(1) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `sub_category` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `bestseller`, `category`, `created_at`, `description`, `name`, `price`, `sub_category`, `updated_at`) VALUES
(5, b'1', 'Trẻ em', '2026-03-07 14:08:26.000000', 'Áo thun cotton mềm mại dành cho bé gái, thiết kế cổ tròn, tay ngắn, form thoải mái, phù hợp mặc hằng ngày và các hoạt động vui chơi.', 'Áo thun bé gái cổ tròn cotton', 100000, 'Áo', '2026-03-18 14:03:08.000000'),
(6, b'0', 'Nam', '2026-03-07 15:08:00.000000', 'Quần dài nam dáng tapered hiện đại, thiết kế ống gọn, có túi hộp tiện dụng hai bên, phù hợp phong cách casual và streetwear.', 'Quần dài nam dáng tapered túi hộp', 110000, 'Quần', '2026-03-18 14:03:32.000000'),
(7, b'0', 'Nam', '2026-03-07 15:08:53.976221', 'Áo thun nam chất liệu cotton, cổ tròn, thiết kế tay raglan phối màu, mang lại cảm giác thoải mái và phong cách trẻ trung.', 'Áo thun nam cổ tròn tay raglan', 120000, 'Áo', '2026-03-07 15:08:53.976221'),
(8, b'0', 'Nữ', '2026-03-07 15:09:38.966345', 'Áo nữ chất liệu cotton nhẹ, cổ tròn, tay ngắn, form suông đơn giản, phù hợp mặc đi làm hoặc đi chơi hằng ngày.', 'Áo sơ mi nữ cotton tay ngắn', 130000, 'Áo', '2026-03-07 15:09:38.966345'),
(9, b'0', 'Trẻ em', '2026-03-07 15:10:05.389222', 'Áo sơ mi cotton dành cho bé trai, tay ngắn, thoáng mát và dễ phối đồ cho sinh hoạt hằng ngày.', 'Áo sơ mi bé trai cotton tay ngắn', 160000, 'Áo', '2026-03-07 15:10:05.389222'),
(10, b'0', 'Nữ', '2026-03-07 15:13:29.196040', 'Áo nữ thiết kế trễ vai thời trang, họa tiết hoa nổi bật, tay ngắn phồng nhẹ, phù hợp mặc đi chơi hoặc du lịch.', 'Áo nữ trễ vai họa tiết hoa', 160000, 'Áo', '2026-03-07 15:13:29.196040'),
(11, b'0', 'Nam', '2026-03-07 15:14:15.084227', 'Áo thun nam cổ tròn, chất liệu cotton mềm mại, thiết kế trơn basic, dễ mặc và dễ phối với nhiều phong cách khác nhau.', 'Áo thun nam cổ tròn cotton trơn', 150000, 'Áo', '2026-03-07 15:14:15.084227'),
(12, b'0', 'Nam', '2026-03-07 15:15:23.823530', 'Quần dài nam dáng tapered, thiết kế lưng thun kèm dây rút, form gọn gàng, mang lại sự thoải mái và phong cách năng động.', 'Quần dài nam dáng tapered lưng thun', 240000, 'Quần', '2026-03-07 15:15:23.823530'),
(13, b'0', 'Trẻ em', '2026-03-07 15:16:00.821902', 'Áo dành cho bé gái chất liệu cotton mềm mại, thiết kế cổ tròn, tay ngắn, form thoải mái, phù hợp mặc hằng ngày.', 'Áo bé gái cổ tròn tay ngắn cotton', 130000, 'Áo', '2026-03-07 15:16:00.821902'),
(14, b'0', 'Nam', '2026-03-07 15:16:42.488198', 'Quần dài nam dáng tapered, thiết kế ống gọn, form thể thao, phù hợp cho vận động nhẹ, đi chơi hoặc mặc thường ngày.', 'Quần dài nam dáng tapered thể thao', 150000, 'Quần', '2026-03-07 15:16:42.488198'),
(15, b'0', 'Trẻ em', '2026-03-07 15:17:03.490072', 'Áo thun bé trai chất liệu cotton thoáng mát, cổ tròn, tay ngắn, thiết kế in chữ năng động, phù hợp mặc đi học và vui chơi.', 'Áo thun bé trai cổ tròn cotton in chữ', 180000, 'Áo', '2026-03-07 15:17:03.490072'),
(16, b'0', 'Trẻ em', '2026-03-07 15:18:42.090550', 'Áo thun cotton dành cho bé trai, thiết kế cổ tròn, tay ngắn, kiểu dáng basic, dễ phối đồ cho nhiều hoàn cảnh.', 'Áo thun bé trai cổ tròn cotton trơn', 160000, 'Áo', '2026-03-07 15:18:42.090550'),
(17, b'0', 'Nữ', '2026-03-07 15:19:18.780419', 'Quần palazzo nữ ống rộng, họa tiết nổi bật, thiết kế cạp cao kèm thắt lưng, mang lại sự thoải mái và phong cách thời trang.', 'Quần palazzo nữ họa tiết kèm thắt lưng', 190000, 'Quần', '2026-03-07 15:19:18.780419'),
(18, b'0', 'Nữ', '2026-03-07 15:21:55.098603', 'Áo khoác nữ dáng relaxed, thiết kế khóa kéo phía trước, form vừa thoải mái, phù hợp mặc khi thời tiết mát hoặc đi làm, đi chơi.', 'Áo khoác nữ khóa kéo dáng relaxed', 170000, 'Áo khoác', '2026-03-07 15:21:55.098603'),
(19, b'0', 'Nữ', '2026-03-07 15:22:21.047950', 'Quần palazzo nữ thiết kế trơn, ống rộng, cạp cao, chất liệu mềm mại, tạo cảm giác thoải mái và thanh lịch.', 'Quần palazzo nữ trơn cạp cao', 200000, 'Quần', '2026-03-07 15:22:21.047950'),
(20, b'0', 'Trẻ em', '2026-03-07 15:22:48.611654', 'Áo thun cotton không tay dành cho bé trai, thiết kế cổ tròn, phong cách thể thao, phù hợp mặc mùa hè và hoạt động ngoài trời.', 'Áo thun bé trai cổ tròn cotton không tay', 180000, 'Áo', '2026-03-07 15:22:48.611654'),
(21, b'0', 'Trẻ em', '2026-03-07 15:23:17.538267', 'Áo sơ mi dành cho bé trai chất liệu cotton, thiết kế kẻ sọc dọc, tay ngắn, form thoải mái, phù hợp mặc đi chơi hoặc dạo phố.', 'Áo sơ mi bé trai kẻ sọc cotton', 210000, 'Áo', '2026-03-07 15:23:17.538267'),
(22, b'0', 'Trẻ em', '2026-03-07 15:24:03.375941', 'Áo cotton cho bé gái, thiết kế cổ tròn, tay ngắn, dáng rộng thoải mái, phong cách năng động và dễ thương.', 'Áo bé gái cổ tròn cotton dáng rộng', 190000, 'Áo', '2026-03-07 15:24:03.375941'),
(24, b'0', 'Nữ', '2026-03-07 15:27:30.922070', 'Áo khoác denim nữ thiết kế dáng relaxed, chất liệu jean mềm, khóa cài phía trước, phù hợp phối đồ casual hằng ngày.', 'Áo khoác denim nữ khóa cài dáng relaxed', 220000, 'Áo khoác', '2026-03-07 15:27:30.922070'),
(25, b'0', 'Trẻ em', '2026-03-07 15:28:05.408884', 'Đầm dành cho bé gái thiết kế cổ tròn, tay dài nhẹ, họa tiết hoa tươi sáng, mang phong cách dễ thương và nữ tính.', 'Đầm bé gái cổ tròn họa tiết hoa', 200000, 'Áo', '2026-03-07 15:28:05.408884'),
(26, b'0', 'Nam', '2026-03-07 15:28:31.398142', 'Áo khoác phao nam dáng slim, thiết kế giữ ấm tốt, form gọn gàng, phù hợp mặc trong thời tiết lạnh và đi chơi hằng ngày.', 'Áo khoác phao nam dáng slim', 230000, 'Áo khoác', '2026-03-07 15:28:31.398142'),
(27, b'0', 'Nữ', '2026-03-07 15:29:02.687620', 'Áo thun nữ cổ tròn chất liệu cotton, thiết kế đơn giản, form vừa vặn, phù hợp mặc thể thao hoặc sinh hoạt hằng ngày.', 'Áo thun nữ cổ tròn cotton thể thao', 210000, 'Áo', '2026-03-07 15:29:02.687620'),
(28, b'0', 'Trẻ em', '2026-03-07 15:29:30.664351', 'Áo cotton dành cho bé gái, thiết kế cổ tròn, tay ngắn, form thoải mái, phù hợp mặc đi học hoặc vui chơi.', 'Áo bé gái cổ tròn cotton tay ngắn', 240000, 'Áo', '2026-03-07 15:29:30.664351'),
(29, b'0', 'Nam', '2026-03-07 15:29:57.374101', 'Áo thun nam cổ tròn chất liệu cotton, thiết kế in logo phía trước, form basic, dễ phối với nhiều trang phục khác nhau.', 'Áo thun nam cổ tròn cotton in logo', 220000, 'Áo', '2026-03-07 15:29:57.374101'),
(30, b'0', 'Nam', '2026-03-07 15:30:37.449577', 'Áo thun nam chất liệu cotton, thiết kế cổ tròn, tay dài, phối màu ngang thân áo, form basic phù hợp mặc hằng ngày.', 'Áo thun nam dài tay cổ tròn cotton', 250000, 'Áo', '2026-03-07 15:30:37.449577'),
(31, b'0', 'Trẻ em', '2026-03-07 15:30:59.616489', 'Áo cotton dành cho bé gái, thiết kế cổ tròn, tay bèo dễ thương, form thoải mái, phù hợp mặc đi học hoặc đi chơi.', 'Áo bé gái cổ tròn cotton tay bèo', 230000, 'Áo', '2026-03-07 15:30:59.616489'),
(32, b'0', 'Nữ', '2026-03-07 15:32:59.478683', 'Áo nữ cổ tròn chất liệu cotton mềm mại, tay ngắn, dáng ôm nhẹ, mang phong cách đơn giản và năng động.', 'Áo nữ cổ tròn cotton dáng ôm nhẹ', 260000, 'Áo', '2026-03-07 15:32:59.478683'),
(33, b'0', 'Nữ', '2026-03-07 15:33:26.133034', 'Áo khoác nữ phong cách thể thao, thiết kế khóa kéo phía trước, cổ cao, chất liệu co giãn, phù hợp tập luyện và mặc hằng ngày.', 'Áo khoác nữ thể thao khóa kéo', 240000, 'Áo khoác', '2026-03-07 15:33:26.133034'),
(34, b'1', 'Nữ', '2026-03-07 15:33:57.691031', 'Áo khoác phao nữ thiết kế dáng relaxed, khóa kéo phía trước, chất liệu giữ ấm tốt, phù hợp mặc trong thời tiết lạnh.', 'Áo khoác phao nữ dáng relaxed', 270000, 'Áo khoác', '2026-03-07 15:33:57.691031'),
(35, b'0', 'Nữ', '2026-03-07 15:34:30.281594', 'Áo nữ chất liệu cotton nhẹ, thiết kế cổ tròn, tay ngắn, form suông thanh lịch, dễ phối đồ đi làm hoặc đi chơi.', 'Áo nữ cổ tròn cotton form suông', 260000, 'Áo', '2026-03-07 15:34:30.281594'),
(36, b'1', 'Nam', '2026-03-07 15:34:56.453356', 'Áo sơ mi dành cho bé trai chất liệu cotton, thiết kế tay ngắn, form thoải mái, dễ phối cùng áo thun và quần jean.', 'Áo sơ mi bé trai tay ngắn cotton', 280000, 'Áo', '2026-03-07 15:34:56.453356'),
(37, b'0', 'Nam', '2026-03-07 15:35:30.479721', 'Áo sơ mi nam chất liệu cotton, thiết kế họa tiết nhỏ, tay dài, form gọn gàng, phù hợp mặc đi làm hoặc dạo phố.', 'Áo sơ mi nam cotton họa tiết', 260000, 'Áo', '2026-03-07 15:35:30.479721'),
(38, b'1', 'Nam', '2026-03-07 15:35:53.595269', 'Áo khoác denim nam thiết kế không tay, dáng slim fit, có khóa kéo phía trước, phong cách năng động, phù hợp phối cùng áo thun.', 'Áo khoác denim nam không tay dáng slim', 290000, 'Áo khoác', '2026-03-07 15:35:53.595269'),
(39, b'0', 'Nam', '2026-03-07 15:36:28.087381', 'Áo thun nam cổ tròn chất liệu cotton, tay ngắn, thiết kế in họa tiết dọc thân áo, form basic dễ mặc hằng ngày.', 'Áo thun nam cổ tròn cotton in họa tiết', 270000, 'Áo', '2026-03-07 15:36:28.087381'),
(40, b'0', 'Trẻ em', '2026-03-07 15:36:52.497208', 'Áo thun dành cho bé trai chất liệu cotton thoáng mát, cổ tròn, tay ngắn, thiết kế in chữ năng động.', 'Áo thun bé trai cổ tròn cotton in chữ', 300000, 'Áo', '2026-03-07 15:36:52.497208'),
(41, b'0', 'Trẻ em', '2026-03-07 15:37:41.428401', 'Quần jean cho bé thiết kế dáng tapered slim, cạp chun phía sau, form gọn gàng, dễ vận động và thoải mái khi mặc.', 'Quần jean bé dáng tapered slim', 280000, 'Quần', '2026-03-07 15:37:41.428401'),
(42, b'0', 'Nữ', '2026-03-07 15:38:10.172141', 'Áo khoác nữ thiết kế dáng relaxed, khóa kéo phía trước, form rộng vừa phải, phù hợp mặc khi thời tiết mát.', 'Áo khoác nữ khóa kéo dáng relaxed', 310000, 'Áo khoác', '2026-03-07 15:38:10.172141'),
(43, b'0', 'Nam', '2026-03-07 15:38:32.235936', 'Áo khoác phao nam dáng slim fit, thiết kế giữ ấm tốt, phối màu hiện đại, phù hợp mặc trong thời tiết lạnh.', 'Áo khoác phao nam dáng slim', 290000, 'Áo khoác', '2026-03-07 15:38:32.235936'),
(44, b'0', 'Nam', '2026-03-07 15:38:56.546937', 'Áo khoác denim nam dáng slim, thiết kế khóa kéo phía trước, form gọn gàng, phù hợp mặc đi làm hoặc đi chơi.', 'Áo khoác denim nam dáng slim khóa kéo', 320000, 'Áo khoác', '2026-03-07 15:38:56.546937'),
(45, b'0', 'Trẻ em', '2026-03-07 15:39:18.991139', 'Quần dài dành cho trẻ em thiết kế dáng tapered, cạp chun co giãn, chất liệu mềm mại, mang lại sự thoải mái khi vận động.', 'Quần dài bé cạp chun dáng tapered', 300000, 'Quần', '2026-03-07 15:39:18.991139'),
(46, b'0', 'Nam', '2026-03-07 15:39:38.691851', 'Áo khoác denim nam dáng slim fit, thiết kế cổ bẻ, cài nút phía trước, phong cách trẻ trung, dễ phối với áo thun và quần jean.', 'Áo khoác denim nam dáng slim', 330000, 'Áo khoác', '2026-03-07 15:39:38.691851'),
(47, b'0', 'Trẻ em', '2026-03-07 15:39:59.670969', 'Quần dài dành cho trẻ em thiết kế dáng tapered slim, họa tiết chấm nhỏ, form gọn gàng, phù hợp mặc hằng ngày.', 'Quần dài bé dáng tapered slim họa tiết', 310000, 'Quần', '2026-03-07 15:39:59.670969'),
(48, b'0', 'Trẻ em', '2026-03-07 15:40:26.613370', 'Quần dài cho trẻ em thiết kế dáng tapered, cạp chun kèm dây buộc, chất liệu nhẹ, thoải mái cho vận động.', 'Quần dài bé cạp chun dáng tapered', 340000, 'Quần', '2026-03-07 15:40:26.613370'),
(49, b'0', 'Nữ', '2026-03-07 15:40:48.716367', 'Áo khoác nữ thiết kế dáng relaxed, khóa kéo phía trước, form gọn gàng, phù hợp mặc khi thời tiết mát.', 'Áo khoác nữ khóa kéo dáng relaxed', 320000, 'Áo khoác', '2026-03-07 15:40:48.716367'),
(50, b'0', 'Nam', '2026-03-07 15:41:29.651706', 'Áo thun nam cổ tròn chất liệu cotton mềm mại, tay ngắn, thiết kế trơn đơn giản, dễ mặc và dễ phối đồ.', 'Áo thun nam cổ tròn cotton trơn', 200000, 'Áo', '2026-03-07 15:41:29.651706'),
(51, b'1', 'Nam', '2026-03-07 15:41:55.230201', 'Áo khoác denim nam dáng slim, thiết kế cài nút phía trước, form gọn gàng, phù hợp mặc đi chơi hoặc dạo phố.', 'Áo khoác denim nam dáng slim khóa cài', 350000, 'Áo khoác', '2026-03-07 15:41:55.230201'),
(52, b'0', 'Trẻ em', '2026-03-07 15:42:19.493759', 'Đầm dành cho bé gái thiết kế cổ tròn, tay dài nhẹ, họa tiết hoa tươi sáng, phong cách dễ thương và nữ tính.', 'Đầm bé gái cổ tròn họa tiết hoa', 220000, 'Áo', '2026-03-07 15:42:19.493759'),
(53, b'0', 'Nam', '2026-03-07 15:42:52.506558', 'Áo thun nam cổ tròn chất liệu cotton, thiết kế in logo phía trước, form basic, phù hợp mặc hằng ngày.', 'Áo thun nam cổ tròn cotton in logo', 110000, 'Áo', '2026-03-07 15:42:52.506558'),
(54, b'0', 'Nữ', '2026-03-07 15:43:11.069458', 'Áo thun nữ cổ tròn chất liệu cotton, thiết kế dáng ôm vừa, phong cách thể thao, phù hợp tập luyện hoặc mặc thường ngày.', 'Áo thun nữ cổ tròn cotton thể thao', 130000, 'Áo', '2026-03-07 15:43:11.069458'),
(55, b'0', 'Trẻ em', '2026-03-07 15:43:40.042811', 'Áo cotton dành cho bé gái, thiết kế cổ tròn, tay ngắn, form thoải mái, phù hợp mặc đi học hoặc vui chơi.', 'Áo bé gái cổ tròn cotton tay ngắn', 140000, 'Áo', '2026-03-07 15:43:40.042811'),
(56, b'0', 'Nam', '2026-03-07 15:44:07.255951', 'Quần dài nam thiết kế dáng tapered slim, form gọn gàng, chất liệu bền đẹp, phù hợp mặc đi làm hoặc đi chơi.', 'Quần dài nam dáng tapered slim', 190000, 'Quần', '2026-03-07 15:44:07.255951'),
(61, b'0', 'Nam', '2026-03-07 17:36:22.190952', 'Áo thun nam cổ tròn tay dài, chất liệu cotton, thiết kế phối màu ngang thân áo, phong cách trẻ trung và năng động.', 'Áo thun nam dài tay cổ tròn cotton', 200000, 'Áo', '2026-03-12 15:23:04.076432'),
(62, b'0', 'Nam', '2026-03-12 15:24:37.547316', 'Quần dài nam thiết kế dáng tapered slim, form gọn gàng, chất liệu bền đẹp, phù hợp mặc đi làm hoặc đi chơi.', 'Quần dài nam dáng tapered slim', 190000, 'Quần', '2026-03-12 15:24:37.547316');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_image`
--

CREATE TABLE `product_image` (
  `product_id` bigint(20) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_image`
--

INSERT INTO `product_image` (`product_id`, `image`) VALUES
(5, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772867306/h0tokl0svftvrb6wuba3.png'),
(6, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772870880/jh9q8xgvwaugc00srqkr.png'),
(7, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772870933/nbtaa6c2imkxyjmtb6wv.png'),
(8, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772870978/tgvfdqjrfnoygirydse8.png'),
(9, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871004/efd2xbrnh25vvkpdcwn9.png'),
(10, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871208/wzt6k5fvmvoeruesnagn.png'),
(11, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871254/ewbxe7yo8ukttgphin02.png'),
(12, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871323/giy8gqbjgdg70otunzne.png'),
(13, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871360/db7purkhnjarrn5dplan.png'),
(14, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871402/h84eny44mwq4bhvuosxf.png'),
(15, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871423/nvqerhatant26ckb3x3n.png'),
(16, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871521/jo2owdthmbjtxf2vmnt5.png'),
(17, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871558/wj7y6zqy4d8x2bbjmhfu.png'),
(18, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871714/uygd5k881mixoeavbkq9.png'),
(19, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871740/yc5pqtkhluszhjcegbdu.png'),
(20, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871767/oi4j1t19nw6m6k6gongt.png'),
(21, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871797/msefqmrkyyq6waauhpbg.png'),
(22, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772871842/zxllapuemy2blbelnaej.png'),
(24, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872050/zngrha1soxuxyiew9zvr.png'),
(25, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872084/tosoiun7phdmzxk7qlms.png'),
(26, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872110/rsusbiwnvn0lxd2kyivc.png'),
(27, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872142/l1nbhxh5i7qdcd3auhiz.png'),
(28, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872170/cj6wfhtfbziotjwbhtqf.png'),
(29, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872196/dffgpwgb50777kovw5qq.png'),
(30, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872236/jxfqf5csjycw6qwnzdfi.png'),
(31, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872259/bxbcrneriuxojq0zufvn.png'),
(32, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872378/iyu0ujpxjkz2zoxze5fl.png'),
(33, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872405/qy7mksjfzuxbtw62o1jj.png'),
(34, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872437/u9lyrndqlle4neijclkj.png'),
(35, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872469/irrr4so9kssksknh8epo.png'),
(36, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872495/dy1pbeggb7eashfoxsna.png'),
(37, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872530/xe2n0m2brfsqci3y4fvz.png'),
(38, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872553/gtw714dfojzrrqri1cjv.png'),
(39, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872587/vppxcyw0fswdeimxie5v.png'),
(40, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872612/e9klwvnh7gnr4ivsp43t.png'),
(41, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872660/k4vdnec2to8yuzltir62.png'),
(42, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872689/kfyfl3zrwms58lwh65np.png'),
(43, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872711/k45vh1iuwipjvkdk9s7g.png'),
(44, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872735/v5j4mka6b3w2zengwmsv.png'),
(45, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872758/eupfmgrezrthq6lbdagt.png'),
(46, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872778/aau334sssamqwc6mdyhb.png'),
(47, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872799/mriqogjjh79d8jfos9q9.png'),
(48, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872826/qogjwdp27bgfszizpeaj.png'),
(49, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872848/filtio5miv5fcwetmuyy.png'),
(50, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872883/x5iyovpz0s7xrgkq4dno.png'),
(50, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872885/avapqlbet8x1iwfrtyzf.png'),
(50, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872887/mcngsnlk7b0u3tjgklsy.png'),
(50, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872889/noumynbonlaue3rtag7i.png'),
(51, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872914/cun50hvubnm3nhuhwyrx.png'),
(52, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872939/hwj8mcqnxfmdn6crntm8.png'),
(53, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872972/qrejbcuk8suh72mfyzfs.png'),
(54, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772872990/id52ou3dltr9sy7o2ff0.png'),
(55, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772873019/mp13qaog8ae3syywn5lm.png'),
(56, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772873046/vyb2jjakxc25aaikpd6f.png'),
(61, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1772948319/k2o3gezyq9m1jtrcm3kj.png'),
(62, 'https://res.cloudinary.com/ddjmyyryf/image/upload/v1773303876/u0tctzki8l2ynmx1o8k0.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_inventory`
--

CREATE TABLE `product_inventory` (
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `variant_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_inventory`
--

INSERT INTO `product_inventory` (`product_id`, `quantity`, `variant_key`) VALUES
(5, 47, 'L__Trắng'),
(5, 96, 'L__Xám'),
(5, 14, 'L__Đen'),
(5, 79, 'M__Trắng'),
(5, 25, 'M__Xám'),
(5, 0, 'M__Đen'),
(5, 110, 'XL__Trắng'),
(5, 73, 'XL__Xám'),
(5, 101, 'XL__Đen'),
(6, 17, 'L__Trắng'),
(6, 49, 'L__Xám'),
(6, 126, 'L__Đen'),
(6, 63, 'S__Trắng'),
(6, 49, 'S__Xám'),
(6, 15, 'S__Đen'),
(6, 29, 'XL__Trắng'),
(6, 28, 'XL__Xám'),
(6, 62, 'XL__Đen'),
(7, 7, 'L__Trắng'),
(7, 90, 'L__Xám'),
(7, 85, 'L__Đen'),
(7, 115, 'M__Trắng'),
(7, 43, 'M__Xám'),
(7, 38, 'M__Đen'),
(7, 111, 'S__Trắng'),
(7, 79, 'S__Xám'),
(7, 18, 'S__Đen'),
(8, 55, 'L__Trắng'),
(8, 103, 'L__Xám'),
(8, 45, 'L__Đen'),
(8, 91, 'M__Trắng'),
(8, 22, 'M__Xám'),
(8, 69, 'M__Đen'),
(8, 34, 'S__Trắng'),
(8, 97, 'S__Xám'),
(8, 52, 'S__Đen'),
(8, 59, 'XL__Trắng'),
(8, 40, 'XL__Xám'),
(8, 91, 'XL__Đen'),
(9, 43, 'L__Trắng'),
(9, 50, 'L__Xám'),
(9, 109, 'L__Đen'),
(9, 2, 'M__Trắng'),
(9, 124, 'M__Xám'),
(9, 93, 'M__Đen'),
(9, 48, 'S__Trắng'),
(9, 54, 'S__Xám'),
(9, 47, 'S__Đen'),
(9, 35, 'XL__Trắng'),
(9, 121, 'XL__Xám'),
(9, 75, 'XL__Đen'),
(10, 29, 'L__Trắng'),
(10, 78, 'L__Xám'),
(10, 5, 'L__Đen'),
(10, 32, 'M__Trắng'),
(10, 107, 'M__Xám'),
(10, 115, 'M__Đen'),
(10, 108, 'S__Trắng'),
(10, 72, 'S__Xám'),
(10, 62, 'S__Đen'),
(11, 25, 'L__Trắng'),
(11, 82, 'L__Xám'),
(11, 124, 'L__Đen'),
(11, 50, 'M__Trắng'),
(11, 5, 'M__Xám'),
(11, 47, 'M__Đen'),
(11, 64, 'S__Trắng'),
(11, 98, 'S__Xám'),
(11, 22, 'S__Đen'),
(11, 110, 'XL__Trắng'),
(11, 108, 'XL__Xám'),
(11, 78, 'XL__Đen'),
(12, 121, 'L__Trắng'),
(12, 78, 'L__Xám'),
(12, 30, 'L__Đen'),
(12, 20, 'M__Trắng'),
(12, 109, 'M__Xám'),
(12, 40, 'M__Đen'),
(12, 57, 'S__Trắng'),
(12, 19, 'S__Xám'),
(12, 53, 'S__Đen'),
(12, 54, 'XL__Trắng'),
(12, 125, 'XL__Xám'),
(12, 53, 'XL__Đen'),
(13, 5, 'L__Trắng'),
(13, 50, 'L__Xám'),
(13, 25, 'L__Đen'),
(13, 126, 'M__Trắng'),
(13, 98, 'M__Xám'),
(13, 76, 'M__Đen'),
(13, 54, 'S__Trắng'),
(13, 123, 'S__Xám'),
(13, 40, 'S__Đen'),
(13, 116, 'XL__Trắng'),
(13, 83, 'XL__Xám'),
(13, 128, 'XL__Đen'),
(14, 85, 'L__Trắng'),
(14, 77, 'L__Xám'),
(14, 100, 'L__Đen'),
(14, 103, 'M__Trắng'),
(14, 121, 'M__Xám'),
(14, 90, 'M__Đen'),
(14, 37, 'S__Trắng'),
(14, 36, 'S__Xám'),
(14, 114, 'S__Đen'),
(14, 80, 'XL__Trắng'),
(14, 21, 'XL__Xám'),
(14, 109, 'XL__Đen'),
(15, 54, 'L__Trắng'),
(15, 116, 'L__Xám'),
(15, 88, 'L__Đen'),
(15, 81, 'M__Trắng'),
(15, 105, 'M__Xám'),
(15, 119, 'M__Đen'),
(15, 9, 'S__Trắng'),
(15, 92, 'S__Xám'),
(15, 27, 'S__Đen'),
(15, 58, 'XL__Trắng'),
(15, 129, 'XL__Xám'),
(15, 75, 'XL__Đen'),
(16, 100, 'L__Trắng'),
(16, 81, 'L__Xám'),
(16, 51, 'L__Đen'),
(16, 126, 'M__Trắng'),
(16, 76, 'M__Xám'),
(16, 89, 'M__Đen'),
(16, 88, 'S__Trắng'),
(16, 39, 'S__Xám'),
(16, 29, 'S__Đen'),
(16, 57, 'XL__Trắng'),
(16, 89, 'XL__Xám'),
(16, 87, 'XL__Đen'),
(17, 104, 'L__Trắng'),
(17, 12, 'L__Xám'),
(17, 42, 'L__Đen'),
(17, 21, 'M__Trắng'),
(17, 51, 'M__Xám'),
(17, 16, 'M__Đen'),
(17, 60, 'S__Trắng'),
(17, 90, 'S__Xám'),
(17, 74, 'S__Đen'),
(17, 48, 'XL__Trắng'),
(17, 20, 'XL__Xám'),
(17, 18, 'XL__Đen'),
(18, 37, 'L__Trắng'),
(18, 114, 'L__Xám'),
(18, 88, 'L__Đen'),
(18, 42, 'M__Trắng'),
(18, 119, 'M__Xám'),
(18, 96, 'M__Đen'),
(18, 113, 'S__Trắng'),
(18, 100, 'S__Xám'),
(18, 70, 'S__Đen'),
(18, 24, 'XL__Trắng'),
(18, 107, 'XL__Xám'),
(18, 60, 'XL__Đen'),
(19, 125, 'L__Trắng'),
(19, 61, 'L__Xám'),
(19, 119, 'L__Đen'),
(19, 1, 'M__Trắng'),
(19, 109, 'M__Xám'),
(19, 39, 'M__Đen'),
(19, 48, 'S__Trắng'),
(19, 34, 'S__Xám'),
(19, 105, 'S__Đen'),
(19, 56, 'XL__Trắng'),
(19, 0, 'XL__Xám'),
(19, 95, 'XL__Đen'),
(20, 7, 'L__Trắng'),
(20, 22, 'L__Xám'),
(20, 7, 'L__Đen'),
(20, 52, 'M__Trắng'),
(20, 41, 'M__Xám'),
(20, 104, 'M__Đen'),
(20, 120, 'S__Trắng'),
(20, 119, 'S__Xám'),
(20, 73, 'S__Đen'),
(20, 88, 'XL__Trắng'),
(20, 1, 'XL__Xám'),
(20, 34, 'XL__Đen'),
(21, 90, 'L__Trắng'),
(21, 129, 'L__Xám'),
(21, 60, 'L__Đen'),
(21, 9, 'M__Trắng'),
(21, 94, 'M__Xám'),
(21, 48, 'M__Đen'),
(21, 6, 'S__Trắng'),
(21, 55, 'S__Xám'),
(21, 87, 'S__Đen'),
(21, 99, 'XL__Trắng'),
(21, 56, 'XL__Xám'),
(21, 28, 'XL__Đen'),
(22, 103, 'L__Trắng'),
(22, 93, 'L__Xám'),
(22, 94, 'L__Đen'),
(22, 11, 'M__Trắng'),
(22, 80, 'M__Xám'),
(22, 44, 'M__Đen'),
(22, 30, 'S__Trắng'),
(22, 77, 'S__Xám'),
(22, 53, 'S__Đen'),
(22, 115, 'XL__Trắng'),
(22, 93, 'XL__Xám'),
(22, 67, 'XL__Đen'),
(24, 15, 'L__Trắng'),
(24, 119, 'L__Xám'),
(24, 69, 'L__Đen'),
(24, 79, 'M__Trắng'),
(24, 108, 'M__Xám'),
(24, 42, 'M__Đen'),
(24, 86, 'S__Trắng'),
(24, 8, 'S__Xám'),
(24, 85, 'S__Đen'),
(24, 114, 'XL__Trắng'),
(24, 75, 'XL__Xám'),
(24, 7, 'XL__Đen'),
(25, 35, 'L__Trắng'),
(25, 15, 'L__Xám'),
(25, 21, 'L__Đen'),
(25, 67, 'M__Trắng'),
(25, 126, 'M__Xám'),
(25, 3, 'M__Đen'),
(25, 55, 'S__Trắng'),
(25, 81, 'S__Xám'),
(25, 82, 'S__Đen'),
(25, 80, 'XL__Trắng'),
(25, 117, 'XL__Xám'),
(25, 18, 'XL__Đen'),
(26, 20, 'L__Trắng'),
(26, 30, 'L__Xám'),
(26, 102, 'L__Đen'),
(26, 97, 'M__Trắng'),
(26, 96, 'M__Xám'),
(26, 121, 'M__Đen'),
(26, 41, 'S__Trắng'),
(26, 41, 'S__Xám'),
(26, 49, 'S__Đen'),
(26, 118, 'XL__Trắng'),
(26, 13, 'XL__Xám'),
(26, 105, 'XL__Đen'),
(27, 26, 'L__Trắng'),
(27, 101, 'L__Xám'),
(27, 6, 'L__Đen'),
(27, 21, 'M__Trắng'),
(27, 47, 'M__Xám'),
(27, 32, 'M__Đen'),
(27, 37, 'S__Trắng'),
(27, 9, 'S__Xám'),
(27, 51, 'S__Đen'),
(27, 120, 'XL__Trắng'),
(27, 117, 'XL__Xám'),
(27, 66, 'XL__Đen'),
(28, 57, 'L__Trắng'),
(28, 0, 'L__Xám'),
(28, 51, 'L__Đen'),
(28, 109, 'M__Trắng'),
(28, 20, 'M__Xám'),
(28, 50, 'M__Đen'),
(28, 76, 'S__Trắng'),
(28, 118, 'S__Xám'),
(28, 94, 'S__Đen'),
(28, 108, 'XL__Trắng'),
(28, 42, 'XL__Xám'),
(28, 113, 'XL__Đen'),
(29, 9, 'L__Trắng'),
(29, 72, 'L__Xám'),
(29, 6, 'L__Đen'),
(29, 49, 'M__Trắng'),
(29, 21, 'M__Xám'),
(29, 36, 'M__Đen'),
(29, 42, 'S__Trắng'),
(29, 14, 'S__Xám'),
(29, 85, 'S__Đen'),
(29, 69, 'XL__Trắng'),
(29, 99, 'XL__Xám'),
(29, 102, 'XL__Đen'),
(30, 106, 'L__Trắng'),
(30, 123, 'L__Xám'),
(30, 10, 'L__Đen'),
(30, 10, 'M__Trắng'),
(30, 17, 'M__Xám'),
(30, 102, 'M__Đen'),
(30, 64, 'S__Trắng'),
(30, 29, 'S__Xám'),
(30, 14, 'S__Đen'),
(30, 124, 'XL__Trắng'),
(30, 30, 'XL__Xám'),
(30, 107, 'XL__Đen'),
(31, 104, 'L__Trắng'),
(31, 77, 'L__Xám'),
(31, 5, 'L__Đen'),
(31, 12, 'M__Trắng'),
(31, 110, 'M__Xám'),
(31, 35, 'M__Đen'),
(31, 79, 'S__Trắng'),
(31, 71, 'S__Xám'),
(31, 81, 'S__Đen'),
(31, 108, 'XL__Trắng'),
(31, 88, 'XL__Xám'),
(31, 74, 'XL__Đen'),
(32, 97, 'L__Trắng'),
(32, 29, 'L__Xám'),
(32, 73, 'L__Đen'),
(32, 69, 'M__Trắng'),
(32, 7, 'M__Xám'),
(32, 34, 'M__Đen'),
(32, 89, 'S__Trắng'),
(32, 123, 'S__Xám'),
(32, 99, 'S__Đen'),
(32, 21, 'XL__Trắng'),
(32, 45, 'XL__Xám'),
(32, 45, 'XL__Đen'),
(33, 91, 'L__Trắng'),
(33, 93, 'L__Xám'),
(33, 108, 'L__Đen'),
(33, 16, 'M__Trắng'),
(33, 110, 'M__Xám'),
(33, 121, 'M__Đen'),
(33, 21, 'S__Trắng'),
(33, 128, 'S__Xám'),
(33, 5, 'S__Đen'),
(33, 6, 'XL__Trắng'),
(33, 43, 'XL__Xám'),
(33, 8, 'XL__Đen'),
(34, 2, 'L__Trắng'),
(34, 5, 'L__Xám'),
(34, 69, 'L__Đen'),
(34, 21, 'M__Trắng'),
(34, 65, 'M__Xám'),
(34, 6, 'M__Đen'),
(34, 86, 'S__Trắng'),
(34, 120, 'S__Xám'),
(34, 108, 'S__Đen'),
(34, 40, 'XL__Trắng'),
(34, 94, 'XL__Xám'),
(34, 129, 'XL__Đen'),
(35, 63, 'L__Trắng'),
(35, 16, 'L__Xám'),
(35, 29, 'L__Đen'),
(35, 11, 'M__Trắng'),
(35, 22, 'M__Xám'),
(35, 19, 'M__Đen'),
(35, 89, 'S__Trắng'),
(35, 100, 'S__Xám'),
(35, 15, 'S__Đen'),
(35, 28, 'XL__Trắng'),
(35, 69, 'XL__Xám'),
(35, 36, 'XL__Đen'),
(36, 100, 'L__Trắng'),
(36, 92, 'L__Xám'),
(36, 12, 'L__Đen'),
(36, 93, 'M__Trắng'),
(36, 116, 'M__Xám'),
(36, 94, 'M__Đen'),
(36, 49, 'S__Trắng'),
(36, 5, 'S__Xám'),
(36, 66, 'S__Đen'),
(36, 24, 'XL__Trắng'),
(36, 29, 'XL__Xám'),
(36, 119, 'XL__Đen'),
(37, 98, 'L__Trắng'),
(37, 120, 'L__Xám'),
(37, 84, 'L__Đen'),
(37, 10, 'M__Trắng'),
(37, 26, 'M__Xám'),
(37, 81, 'M__Đen'),
(37, 84, 'S__Trắng'),
(37, 37, 'S__Xám'),
(37, 2, 'S__Đen'),
(37, 23, 'XL__Trắng'),
(37, 61, 'XL__Xám'),
(37, 116, 'XL__Đen'),
(38, 90, 'L__Trắng'),
(38, 59, 'L__Xám'),
(38, 76, 'L__Đen'),
(38, 49, 'M__Trắng'),
(38, 36, 'M__Xám'),
(38, 57, 'M__Đen'),
(38, 116, 'S__Trắng'),
(38, 29, 'S__Xám'),
(38, 45, 'S__Đen'),
(38, 1, 'XL__Trắng'),
(38, 89, 'XL__Xám'),
(38, 114, 'XL__Đen'),
(39, 27, 'L__Trắng'),
(39, 93, 'L__Xám'),
(39, 66, 'L__Đen'),
(39, 61, 'M__Trắng'),
(39, 63, 'M__Xám'),
(39, 69, 'M__Đen'),
(39, 117, 'S__Trắng'),
(39, 55, 'S__Xám'),
(39, 87, 'S__Đen'),
(39, 10, 'XL__Trắng'),
(39, 12, 'XL__Xám'),
(39, 51, 'XL__Đen'),
(40, 0, 'L__Trắng'),
(40, 8, 'L__Xám'),
(40, 40, 'L__Đen'),
(40, 30, 'M__Trắng'),
(40, 37, 'M__Xám'),
(40, 22, 'M__Đen'),
(40, 120, 'S__Trắng'),
(40, 113, 'S__Xám'),
(40, 33, 'S__Đen'),
(40, 47, 'XL__Trắng'),
(40, 112, 'XL__Xám'),
(40, 71, 'XL__Đen'),
(41, 20, 'L__Trắng'),
(41, 69, 'L__Xám'),
(41, 50, 'L__Đen'),
(41, 41, 'M__Trắng'),
(41, 11, 'M__Xám'),
(41, 24, 'M__Đen'),
(41, 11, 'S__Trắng'),
(41, 59, 'S__Xám'),
(41, 47, 'S__Đen'),
(41, 32, 'XL__Trắng'),
(41, 98, 'XL__Xám'),
(41, 4, 'XL__Đen'),
(42, 115, 'L__Trắng'),
(42, 20, 'L__Xám'),
(42, 16, 'L__Đen'),
(42, 126, 'M__Trắng'),
(42, 37, 'M__Xám'),
(42, 81, 'M__Đen'),
(42, 75, 'S__Trắng'),
(42, 22, 'S__Xám'),
(42, 89, 'S__Đen'),
(42, 44, 'XL__Trắng'),
(42, 12, 'XL__Xám'),
(42, 18, 'XL__Đen'),
(43, 14, 'L__Trắng'),
(43, 70, 'L__Xám'),
(43, 113, 'L__Đen'),
(43, 62, 'M__Trắng'),
(43, 92, 'M__Xám'),
(43, 99, 'M__Đen'),
(43, 47, 'S__Trắng'),
(43, 36, 'S__Xám'),
(43, 24, 'S__Đen'),
(43, 107, 'XL__Trắng'),
(43, 113, 'XL__Xám'),
(43, 84, 'XL__Đen'),
(44, 126, 'L__Trắng'),
(44, 21, 'L__Xám'),
(44, 78, 'L__Đen'),
(44, 61, 'M__Trắng'),
(44, 120, 'M__Xám'),
(44, 49, 'M__Đen'),
(44, 85, 'S__Trắng'),
(44, 3, 'S__Xám'),
(44, 33, 'S__Đen'),
(44, 76, 'XL__Trắng'),
(44, 30, 'XL__Xám'),
(44, 69, 'XL__Đen'),
(45, 93, 'L__Trắng'),
(45, 43, 'L__Xám'),
(45, 123, 'L__Đen'),
(45, 74, 'M__Trắng'),
(45, 24, 'M__Xám'),
(45, 91, 'M__Đen'),
(45, 89, 'S__Trắng'),
(45, 59, 'S__Xám'),
(45, 110, 'S__Đen'),
(45, 51, 'XL__Trắng'),
(45, 114, 'XL__Xám'),
(45, 102, 'XL__Đen'),
(46, 19, 'L__Trắng'),
(46, 2, 'L__Xám'),
(46, 32, 'L__Đen'),
(46, 119, 'M__Trắng'),
(46, 113, 'M__Xám'),
(46, 37, 'M__Đen'),
(46, 14, 'S__Trắng'),
(46, 75, 'S__Xám'),
(46, 31, 'S__Đen'),
(46, 38, 'XL__Trắng'),
(46, 41, 'XL__Xám'),
(46, 119, 'XL__Đen'),
(47, 37, 'L__Trắng'),
(47, 74, 'L__Xám'),
(47, 16, 'L__Đen'),
(47, 112, 'M__Trắng'),
(47, 79, 'M__Xám'),
(47, 18, 'M__Đen'),
(47, 120, 'S__Trắng'),
(47, 48, 'S__Xám'),
(47, 81, 'S__Đen'),
(47, 81, 'XL__Trắng'),
(47, 16, 'XL__Xám'),
(47, 42, 'XL__Đen'),
(48, 84, 'L__Trắng'),
(48, 16, 'L__Xám'),
(48, 113, 'L__Đen'),
(48, 91, 'M__Trắng'),
(48, 63, 'M__Xám'),
(48, 83, 'M__Đen'),
(48, 71, 'S__Trắng'),
(48, 68, 'S__Xám'),
(48, 115, 'S__Đen'),
(48, 36, 'XL__Trắng'),
(48, 111, 'XL__Xám'),
(48, 55, 'XL__Đen'),
(49, 80, 'L__Trắng'),
(49, 83, 'L__Xám'),
(49, 48, 'L__Đen'),
(49, 55, 'M__Trắng'),
(49, 77, 'M__Xám'),
(49, 84, 'M__Đen'),
(49, 57, 'S__Trắng'),
(49, 64, 'S__Xám'),
(49, 40, 'S__Đen'),
(49, 92, 'XL__Trắng'),
(49, 80, 'XL__Xám'),
(49, 85, 'XL__Đen'),
(50, 36, 'L__Trắng'),
(50, 55, 'L__Xám'),
(50, 32, 'L__Đen'),
(50, 73, 'M__Trắng'),
(50, 99, 'M__Xám'),
(50, 91, 'M__Đen'),
(50, 105, 'XL__Trắng'),
(50, 80, 'XL__Xám'),
(50, 91, 'XL__Đen'),
(51, 7, 'L__Trắng'),
(51, 129, 'L__Xám'),
(51, 12, 'L__Đen'),
(51, 87, 'M__Trắng'),
(51, 121, 'M__Xám'),
(51, 129, 'M__Đen'),
(51, 52, 'S__Trắng'),
(51, 30, 'S__Xám'),
(51, 104, 'S__Đen'),
(51, 20, 'XL__Trắng'),
(51, 92, 'XL__Xám'),
(51, 113, 'XL__Đen'),
(52, 16, 'L__Trắng'),
(52, 92, 'L__Xám'),
(52, 70, 'L__Đen'),
(52, 86, 'S__Trắng'),
(52, 120, 'S__Xám'),
(52, 96, 'S__Đen'),
(52, 85, 'XL__Trắng'),
(52, 6, 'XL__Xám'),
(52, 56, 'XL__Đen'),
(53, 20, 'M__Trắng'),
(53, 49, 'M__Xám'),
(53, 9, 'M__Đen'),
(53, 89, 'S__Trắng'),
(53, 107, 'S__Xám'),
(53, 20, 'S__Đen'),
(53, 77, 'XXL__Trắng'),
(53, 18, 'XXL__Xám'),
(53, 31, 'XXL__Đen'),
(54, 58, 'L__Trắng'),
(54, 56, 'L__Xám'),
(54, 40, 'L__Đen'),
(54, 66, 'M__Trắng'),
(54, 67, 'M__Xám'),
(54, 13, 'M__Đen'),
(54, 20, 'XL__Trắng'),
(54, 35, 'XL__Xám'),
(54, 41, 'XL__Đen'),
(55, 39, 'L__Trắng'),
(55, 65, 'L__Xám'),
(55, 37, 'L__Đen'),
(55, 121, 'S__Trắng'),
(55, 36, 'S__Xám'),
(55, 102, 'S__Đen'),
(55, 98, 'XL__Trắng'),
(55, 97, 'XL__Xám'),
(55, 64, 'XL__Đen'),
(56, 24, 'L__Trắng'),
(56, 8, 'L__Xám'),
(56, 24, 'L__Đen'),
(56, 73, 'S__Trắng'),
(56, 126, 'S__Xám'),
(56, 55, 'S__Đen'),
(56, 109, 'XL__Trắng'),
(56, 9, 'XL__Xám'),
(56, 40, 'XL__Đen'),
(61, 10, 'L__Trắng'),
(61, 42, 'L__Xám'),
(61, 86, 'L__Đen'),
(61, 22, 'M__Trắng'),
(61, 19, 'M__Xám'),
(61, 28, 'M__Đen'),
(61, 108, 'S__Trắng'),
(61, 29, 'S__Xám'),
(61, 69, 'S__Đen'),
(62, 111, 'L__Trắng'),
(62, 94, 'L__Xám'),
(62, 15, 'L__Đen'),
(62, 100, 'S__Trắng'),
(62, 118, 'S__Xám'),
(62, 90, 'S__Đen'),
(62, 36, 'XL__Trắng'),
(62, 127, 'XL__Xám'),
(62, 4, 'XL__Đen');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_sizes`
--

CREATE TABLE `product_sizes` (
  `product_id` bigint(20) NOT NULL,
  `sizes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_sizes`
--

INSERT INTO `product_sizes` (`product_id`, `sizes`) VALUES
(5, 'M'),
(5, 'L'),
(5, 'XL'),
(6, 'S'),
(6, 'L'),
(6, 'XL'),
(7, 'S'),
(7, 'M'),
(7, 'L'),
(8, 'S'),
(8, 'M'),
(8, 'L'),
(8, 'XL'),
(9, 'S'),
(9, 'M'),
(9, 'L'),
(9, 'XL'),
(10, 'S'),
(10, 'M'),
(10, 'L'),
(11, 'M'),
(11, 'S'),
(11, 'L'),
(11, 'XL'),
(12, 'S'),
(12, 'M'),
(12, 'L'),
(12, 'XL'),
(13, 'S'),
(13, 'M'),
(13, 'L'),
(13, 'XL'),
(14, 'S'),
(14, 'M'),
(14, 'L'),
(14, 'XL'),
(15, 'S'),
(15, 'M'),
(15, 'L'),
(15, 'XL'),
(16, 'S'),
(16, 'M'),
(16, 'L'),
(16, 'XL'),
(17, 'S'),
(17, 'M'),
(17, 'L'),
(17, 'XL'),
(18, 'S'),
(18, 'M'),
(18, 'L'),
(18, 'XL'),
(19, 'S'),
(19, 'M'),
(19, 'L'),
(19, 'XL'),
(20, 'S'),
(20, 'M'),
(20, 'L'),
(20, 'XL'),
(21, 'S'),
(21, 'M'),
(21, 'L'),
(21, 'XL'),
(22, 'S'),
(22, 'M'),
(22, 'L'),
(22, 'XL'),
(24, 'S'),
(24, 'M'),
(24, 'L'),
(24, 'XL'),
(25, 'S'),
(25, 'M'),
(25, 'L'),
(25, 'XL'),
(26, 'S'),
(26, 'M'),
(26, 'L'),
(26, 'XL'),
(27, 'S'),
(27, 'M'),
(27, 'L'),
(27, 'XL'),
(28, 'S'),
(28, 'M'),
(28, 'L'),
(28, 'XL'),
(29, 'S'),
(29, 'M'),
(29, 'L'),
(29, 'XL'),
(30, 'S'),
(30, 'M'),
(30, 'L'),
(30, 'XL'),
(31, 'S'),
(31, 'M'),
(31, 'L'),
(31, 'XL'),
(32, 'S'),
(32, 'M'),
(32, 'L'),
(32, 'XL'),
(33, 'S'),
(33, 'M'),
(33, 'L'),
(33, 'XL'),
(34, 'S'),
(34, 'M'),
(34, 'L'),
(34, 'XL'),
(35, 'S'),
(35, 'M'),
(35, 'L'),
(35, 'XL'),
(36, 'S'),
(36, 'M'),
(36, 'L'),
(36, 'XL'),
(37, 'S'),
(37, 'M'),
(37, 'L'),
(37, 'XL'),
(38, 'S'),
(38, 'M'),
(38, 'L'),
(38, 'XL'),
(39, 'S'),
(39, 'M'),
(39, 'L'),
(39, 'XL'),
(40, 'S'),
(40, 'M'),
(40, 'L'),
(40, 'XL'),
(41, 'S'),
(41, 'M'),
(41, 'L'),
(41, 'XL'),
(42, 'S'),
(42, 'M'),
(42, 'L'),
(42, 'XL'),
(43, 'S'),
(43, 'M'),
(43, 'XL'),
(43, 'L'),
(44, 'S'),
(44, 'M'),
(44, 'L'),
(44, 'XL'),
(45, 'S'),
(45, 'M'),
(45, 'L'),
(45, 'XL'),
(46, 'S'),
(46, 'M'),
(46, 'XL'),
(46, 'L'),
(47, 'S'),
(47, 'M'),
(47, 'L'),
(47, 'XL'),
(48, 'S'),
(48, 'M'),
(48, 'L'),
(48, 'XL'),
(49, 'S'),
(49, 'M'),
(49, 'L'),
(49, 'XL'),
(50, 'M'),
(50, 'L'),
(50, 'XL'),
(51, 'S'),
(51, 'M'),
(51, 'L'),
(51, 'XL'),
(52, 'S'),
(52, 'L'),
(52, 'XL'),
(53, 'S'),
(53, 'M'),
(53, 'XXL'),
(54, 'M'),
(54, 'L'),
(54, 'XL'),
(55, 'S'),
(55, 'L'),
(55, 'XL'),
(56, 'S'),
(56, 'L'),
(56, 'XL'),
(61, 'S'),
(61, 'M'),
(61, 'L'),
(62, 'S'),
(62, 'L'),
(62, 'XL');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ROLE_USER'),
(2, 'ROLE_ADMIN');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cart_data` text DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `ward` varchar(255) DEFAULT NULL,
  `reset_password_expires_at` datetime(6) DEFAULT NULL,
  `reset_password_token` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `address`, `cart_data`, `city`, `created_at`, `district`, `email`, `first_name`, `last_name`, `name`, `password`, `phone`, `updated_at`, `ward`, `reset_password_expires_at`, `reset_password_token`) VALUES
(7, '', '{\"5\":{\"XL\":0,\"L\":4}}', '', '2026-03-07 10:15:43.817140', '', 'totrungkiet@gmail.com', '', '', 'totrungkiet', '$2a$10$xSGBqiz..6F01r9fwcF9JexCZBi5Xm2hsKI./gkjxQTqoI2ZTW3jK', '', '2026-03-12 15:25:19.215340', '', NULL, NULL),
(8, '', '{\"7\":{\"M\":1}}', '', '2026-03-12 14:08:33.152655', '', 'trungkiet@gmail.com', '', '', 'trungkiet', '$2a$10$HOtdV7ZpSpzp3QmjowB.4OP5jvcFTwOcQfvbArXg7srL/vbKAx186', '', '2026-03-12 14:09:23.990100', '', NULL, NULL),
(9, '', '{}', '', '2026-03-12 14:17:21.847158', '', 'admin@fashionstore.com', '', '', 'Admin', '$2a$10$oqlsgM4vu8VhAajiw4BNA.3beFgc4346ZN5oQkTTv/3YlEqGEbcDG', '', '2026-03-12 14:17:21.847158', '', NULL, NULL),
(10, '', '{}', '', '2026-03-14 19:44:08.687504', '', 'dat2004@gmail.com', '', '', 'tandat', '$2a$10$UDrf1EoLe8UAi0WCgg7Gi.wBPX7ijoTiuoHds/4a.OUygjfgffBs2', '', '2026-03-15 08:09:11.357065', '', NULL, NULL),
(11, '199 Hoang Huu Nam', '{}', 'Thành phố Hồ Chí Minh', '2026-03-18 12:53:31.000000', 'Thành phố Thủ Đức', 'lamnguyenhuugia@gmail.com', 'Nguyễn Hữu', 'Gia Lâm', 'GiaLam', '$2a$10$DiSe5r8UA8iQ930h/WHpaOCB2/NRCOdreL3QhkwEJZjsAVb1eenB.', '0327621734', '2026-03-19 21:51:19.000000', 'Phường Long Thạnh Mỹ', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_role`
--

CREATE TABLE `user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(7, 1),
(8, 1),
(9, 2),
(10, 1),
(11, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKnllyjgu84r34me8gvummx7ldq` (`transaction_ref`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product_image`
--
ALTER TABLE `product_image`
  ADD KEY `FK1n91c4vdhw8pa4frngs4qbbvs` (`product_id`);

--
-- Chỉ mục cho bảng `product_inventory`
--
ALTER TABLE `product_inventory`
  ADD PRIMARY KEY (`product_id`,`variant_key`);

--
-- Chỉ mục cho bảng `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD KEY `FK4isa0j51hpdn7cx04m831jic4` (`product_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`);

--
-- Chỉ mục cho bảng `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKt7e7djp752sqn6w22i6ocqy6q` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `FK1n91c4vdhw8pa4frngs4qbbvs` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `product_inventory`
--
ALTER TABLE `product_inventory`
  ADD CONSTRAINT `FK40jwyi5ktpjmllk3nvvgiy6r0` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD CONSTRAINT `FK4isa0j51hpdn7cx04m831jic4` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `FKj345gk1bovqvfame88rcx7yyx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKt7e7djp752sqn6w22i6ocqy6q` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
