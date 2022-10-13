-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: tmdt
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `active` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'hient14@gmail.com','0582854569','hient14','$2a$10$S9OThrY32b8HJiUlJXClPeFVGdhW0uUv7yA62XAHwp3hmRClrY5Nq','ROLE_ADMIN',1),(2,'phuch@gmail.com','0954582357','phuch','	$2a$10$hfdLSVw3GbecILskhAjViOvSmEDAuZn8fmSy4g/7/gw3S1DdQmhLe','ROLE_ADMIN',1),(3,'vana1@gmail.com','0954485357','vana1','$2a$10$S9OThrY32b8HJiUlJXClPeFVGdhW0uUv7yA62XAHwp3hmRClrY5Nq','ROLE_SELLER',1),(4,'vanb2@gmail.com','0582858549','vanb2','	$2a$10$hfdLSVw3GbecILskhAjViOvSmEDAuZn8fmSy4g/7/gw3S1DdQmhLe','ROLE_SELLER',1),(5,'thia1@gmail.com','0582854459','thia1','$2a$10$S9OThrY32b8HJiUlJXClPeFVGdhW0uUv7yA62XAHwp3hmRClrY5Nq','ROLE_CUSTOMER',1),(15,'nguoiban22@gmail.com','0582832311','nguoiban','$2a$10$S9OThrY32b8HJiUlJXClPeFVGdhW0uUv7yA62XAHwp3hmRClrY5Nq','ROLE_SELLER',1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `id_account` int NOT NULL,
  `is_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_admin_account_idx` (`id_account`),
  CONSTRAINT `fk_admin_account` FOREIGN KEY (`id_account`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Hiền',1,0),(2,'Phúc',2,0);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Thời trang',NULL),(2,'Đời sống',NULL),(3,'Điện tử',NULL),(4,'Tiêu dùng',NULL),(5,'Sức khỏe',NULL),(6,'Sắc đẹp',NULL),(7,'Thể thao',NULL),(8,'Đồ chơi',NULL),(9,'Phụ kiện',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dob` datetime NOT NULL,
  `gender` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `id_hometown` int NOT NULL,
  `id_account` int NOT NULL,
  `is_delected` int NOT NULL DEFAULT '0',
  `description` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_customer_account_idx` (`id_account`),
  KEY `fk_customer_hometown_idx` (`id_hometown`),
  CONSTRAINT `fk_customer_account` FOREIGN KEY (`id_account`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_customer_location` FOREIGN KEY (`id_hometown`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Thị A','Trần','https://res.cloudinary.com/dxs9d8uua/image/upload/v1664388454/h2vgimqooh1i3e0pbjb4.jpg','2001-02-04 00:00:00','Nữ',5,5,0,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,0) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `id_product` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dp_product_idx` (`id_product`),
  CONSTRAINT `fk_dp_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image` text COLLATE utf8_unicode_ci NOT NULL,
  `id_product` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_image_product_idx` (`id_product`),
  CONSTRAINT `fk_image_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'https://cdn.tgdd.vn/Files/2022/03/29/1422922/iphone-13-pro-max-xanh-duong.png',1),(2,'https://didongviet.vn/dchannel/wp-content/uploads/2021/10/cusaciphone13-didongviet-1-2.jpg',1),(3,'https://sohanews.sohacdn.com/thumb_w/660/160588918557773824/2022/9/3/photo1662172963888-1662172966461391130569.jpg',1),(4,'https://image3.mouthshut.com/images/imagesp/925758122s.jpg',3),(5,'https://cdn01.dienmaycholon.vn/filewebdmclnew/DMCL21/Picture/Apro/Apro_product_27028/iphone-13-pro-m_main_193_450.png.webp',2),(6,'https://http2.mlstatic.com/D_NQ_NP_777111-MLA47781882964_102021-O.jpg',2),(7,'https://http2.mlstatic.com/D_NQ_NP_695651-MLA47781962633_102021-O.jpg',2),(8,'https://m.media-amazon.com/images/I/41XicJbSepL.jpg',3),(9,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN9Med39NQqLZW1Bi3Wk5SZLrg-ei3801tww&usqp=CAU',4),(10,'https://aothunhk.com/wp-content/uploads/2018/01/ao-thun-tron-trang-nam.jpg',4),(11,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEX0KQtJNMpdOuzyv1yipd7NDK7Gte07TtHQ&usqp=CAU',4),(12,'https://4menshop.com/images/thumbs/2020/07/ao-thun-tron-can-ban-form-slimfit-at018-mau-trang-15368.png',16),(13,'https://static.hotdeal.vn/images/700/699583/400x500/144229-ao-thun-nu-mau-tron-144220-vn-2-3-4-5.jpg',16),(14,'https://res.cloudinary.com/dxs9d8uua/image/upload/v1664476059/eavb36h7h9lhg59ry34r.jpg',20),(15,'https://res.cloudinary.com/dxs9d8uua/image/upload/v1664461130/txf3i7pug4njl2glax1r.png',20),(16,'https://res.cloudinary.com/dxs9d8uua/image/upload/v1664461132/rotysmoi0oiuyefvhymk.jpg',20),(17,'https://cf.shopee.vn/file/8a4bb29ee61c7143cf75294f93ea242f',21),(18,'https://cf.shopee.vn/file/e6681052e4188b360e18626081c7fe7f',21);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'An Giang'),(2,'Bà Rịa – Vũng Tàu'),(3,'Bắc Giang'),(4,'Bắc Kạn'),(5,'Bạc Liêu'),(6,'Bắc Ninh'),(7,'Bến Tre'),(8,'Bình Định'),(9,'Bình Dương'),(10,'Bình Phước'),(11,'Bình Thuận'),(12,'Cà Mau'),(13,'Cần Thơ'),(14,'Cao Bằng'),(15,'Đà Nẵng'),(16,'Đắk Lắk'),(17,'Đắk Nông'),(18,'Điện Biên'),(19,'Đồng Nai'),(20,'Đồng Tháp'),(21,'Gia Lai'),(22,'Hà Giang'),(23,'Hà Nam'),(24,'Hà Nội'),(25,'Hà Tĩnh'),(26,'Hải Dương'),(27,'Hải Phòng'),(28,'Hậu Giang'),(29,'Hòa Bình'),(30,'Hưng Yên'),(31,'Khánh Hòa'),(32,'Kiên Giang'),(33,'Kon Tum'),(34,'Lai Châu'),(35,'Lâm Đồng'),(36,'Lạng Sơn'),(37,'Lào Cai'),(38,'Long An'),(39,'Nam Định'),(40,'Nghệ An'),(41,'Ninh Bình'),(42,'Ninh Thuận'),(43,'Phú Thọ'),(44,'Phú Yên'),(45,'Quảng Bình'),(46,'Quảng Nam'),(47,'Quảng Ngãi'),(48,'Quảng Ninh'),(49,'Quảng Trị'),(50,'Sóc Trăng'),(51,'Sơn La'),(52,'Tây Ninh'),(53,'Thái Bình'),(54,'Thái Nguyên'),(55,'Thanh Hóa'),(56,'Thừa Thiên Huế'),(57,'Tiền Giang'),(58,'TP Hồ Chí Minh'),(59,'Trà Vinh'),(60,'Tuyên Quang'),(61,'Vĩnh Long'),(62,'Vĩnh Phúc'),(63,'Yên Bái'),(64,'Quốc tế');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_price` decimal(10,0) NOT NULL,
  `quantity` int NOT NULL,
  `discount` double NOT NULL,
  `id_product` int NOT NULL,
  `id_order` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_od_product_idx` (`id_product`),
  KEY `fk_od_order_idx` (`id_order`),
  CONSTRAINT `fk_od_order` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_od_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (1,32000000,2,0.1,1,1),(2,32000000,3,0.1,2,1),(4,32000000,1,0.1,2,3);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_customer` int DEFAULT NULL,
  `order_date` datetime NOT NULL,
  `required_date` datetime NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `ship_fee` int NOT NULL,
  `active` int NOT NULL,
  `payment_type` int NOT NULL,
  `is_payment` int NOT NULL DEFAULT '0',
  `id_voucher` int DEFAULT NULL,
  `id_seller` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_customer_idx` (`id_customer`),
  KEY `fk_order_voucher_idx` (`id_voucher`),
  KEY `fk_order_seller_idx` (`id_seller`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`),
  CONSTRAINT `fk_order_voucher` FOREIGN KEY (`id_voucher`) REFERENCES `voucher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2022-05-05 00:00:00','2022-05-15 00:00:00',28800000,0,0,1,1,2,1),(3,1,'2022-05-06 00:00:00','2022-05-16 00:00:00',28800000,0,1,1,1,2,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturer` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `active` int NOT NULL,
  `quantity` int NOT NULL,
  `id_category` int NOT NULL,
  `id_seller` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_category_idx` (`id_category`),
  KEY `fk_product_seller_idx` (`id_seller`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_product_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Iphone 13 promax xanh',' màu xanh dương','32000000','Apple','2022-09-10 00:00:00',1,10,3,1),(2,'Iphone 13 promax trắng',' màu trắng','29600000','Apple','2022-09-12 00:00:00',1,10,3,1),(3,'Asus X552CL-SX019D','Laptop','26600000','Asus','2022-09-12 00:00:44',1,10,3,1),(4,'Áo thun trắng trơn','Màu trắng ','145000','Nobrand','2022-09-14 00:00:44',1,10,1,1),(16,'Áo thun vàng trơn','Màu vàng','145000','Nobrand','2022-09-14 00:00:44',1,12,1,1),(20,'Áo thun đen','sadasd','145000','NoBrand','2022-09-30 01:27:24',0,12,1,1),(21,'Áo thun sọc','sadasd','145000','NoBrand','2022-09-30 01:27:24',1,12,1,2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rating` int NOT NULL,
  `content` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `review_date` datetime NOT NULL,
  `id_account` int NOT NULL,
  `id_product` int DEFAULT NULL,
  `id_seller` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comment_product_idx` (`id_product`),
  KEY `fk_review_account_idx` (`id_account`),
  KEY `fk_review_seller_idx` (`id_seller`),
  CONSTRAINT `fk_review_account` FOREIGN KEY (`id_account`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_review_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_review_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (35,2,'Hài lòng','2022-10-04 04:47:44',5,1,NULL),(36,1,'thất vọng','2022-10-04 04:47:55',5,1,NULL),(38,2,'Woww','2022-10-07 17:54:10',5,1,NULL),(40,2,'Tuyệt','2022-10-07 18:21:51',5,1,NULL),(43,3,'gf','2022-10-07 18:21:51',5,NULL,1),(44,5,'fgg','2022-10-07 18:21:51',5,NULL,1),(45,5,'fd','2022-10-07 18:21:51',5,NULL,2);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_account` int NOT NULL,
  `id_location` int NOT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seller_account_idx` (`id_account`),
  KEY `fk_seller_location_idx` (`id_location`),
  CONSTRAINT `fk_seller_account` FOREIGN KEY (`id_account`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_seller_location` FOREIGN KEY (`id_location`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'Văn A','https://res.cloudinary.com/dxs9d8uua/image/upload/v1664388454/h2vgimqooh1i3e0pbjb4.jpg',3,4,'10/2 Au Duong Lan','Văn a luôn hỗ trợ'),(2,'Văn B','https://res.cloudinary.com/dxs9d8uua/image/upload/v1664388454/h2vgimqooh1i3e0pbjb4.jpg',4,5,'72 Hàn Hải',NULL),(4,'nguoiban','https://res.cloudinary.com/dxs9d8uua/image/upload/v1664388454/h2vgimqooh1i3e0pbjb4.jpg',15,2,'67 nguyen hai',NULL);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ship_adress`
--

DROP TABLE IF EXISTS `ship_adress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ship_adress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `id_customer` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ship_customer_idx` (`id_customer`),
  CONSTRAINT `fk_ship_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ship_adress`
--

LOCK TABLES `ship_adress` WRITE;
/*!40000 ALTER TABLE `ship_adress` DISABLE KEYS */;
/*!40000 ALTER TABLE `ship_adress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(10,0) DEFAULT NULL,
  `max_quantity` int DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `voucher_code` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decription` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_delected` int DEFAULT '0',
  `id_admin` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voucher_admin_idx` (`id_admin`),
  CONSTRAINT `fk_voucher_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (2,'voucher mới',10000,5,'2022-05-09 00:00:00','2022-05-30 00:00:00','XINCHAO10',NULL,0,1);
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_customer`
--

DROP TABLE IF EXISTS `voucher_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher_customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_voucher` int NOT NULL,
  `id_customer` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dk_vc_voucher_idx` (`id_voucher`),
  KEY `fk_vc_customer_idx` (`id_customer`),
  CONSTRAINT `dk_vc_voucher` FOREIGN KEY (`id_voucher`) REFERENCES `voucher` (`id`),
  CONSTRAINT `fk_vc_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_customer`
--

LOCK TABLES `voucher_customer` WRITE;
/*!40000 ALTER TABLE `voucher_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher_customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-13 19:29:35
