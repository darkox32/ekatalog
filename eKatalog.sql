-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5969
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for ekatalog
CREATE DATABASE IF NOT EXISTS `ekatalog` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `ekatalog`;

-- Dumping structure for table ekatalog.administrator
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`) USING BTREE,
  UNIQUE KEY `uq_admin_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.administrator: ~3 rows (approximately)
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'Admin1', 'C82D0A3CD48A7EBD80ED61B1B3169B9CA5C818E35ACF8E87145E163A1302C281F51780040FC2B31EB5933AEC322E15C2F967348411466D1E250AB136F128F092'),
	(2, 'admn2', '0u25y15029ohifadh\\'),
	(3, 'pperic', 'tajnaLozinka');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

-- Dumping structure for table ekatalog.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.category: ~4 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`) VALUES
	(1, 'Skupi', 'assets/pc.jpg'),
	(2, 'Jeftini', 'assets/home.jpg'),
	(3, 'Srednji', 'assets/pc/a500.jpg'),
	(4, 'Premium', 'assets/pc/e300.jpg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table ekatalog.network
CREATE TABLE IF NOT EXISTS `network` (
  `network_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`network_id`) USING BTREE,
  UNIQUE KEY `uq_network_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='feature kod milana';

-- Dumping data for table ekatalog.network: ~4 rows (approximately)
/*!40000 ALTER TABLE `network` DISABLE KEYS */;
INSERT INTO `network` (`network_id`, `name`) VALUES
	(1, '2G'),
	(2, '3G'),
	(3, '4G'),
	(4, 'Technology');
/*!40000 ALTER TABLE `network` ENABLE KEYS */;

-- Dumping structure for table ekatalog.phone
CREATE TABLE IF NOT EXISTS `phone` (
  `phone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `os` enum('Android','iOS','Windows','Blackberry') DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `ram_size` int(64) NOT NULL DEFAULT 0,
  `storage_size` int(64) NOT NULL DEFAULT 0,
  `screen_size` int(64) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`phone_id`) USING BTREE,
  KEY `fk_phone_category_id` (`category_id`),
  CONSTRAINT `fk_phone_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.phone: ~1 rows (approximately)
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` (`phone_id`, `category_id`, `name`, `os`, `description`, `ram_size`, `storage_size`, `screen_size`, `created_at`) VALUES
	(6, 1, 'Apple X', 'iOS', 'SuperFon', 64, 128, 12, '2020-05-09 15:30:45'),
	(8, 4, 'Samsung A70', 'Android', 'MojFonhue', 128, 246, 22, '2020-05-09 19:47:06');
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;

-- Dumping structure for table ekatalog.phone_network
CREATE TABLE IF NOT EXISTS `phone_network` (
  `phone_network_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `network_id` int(10) unsigned NOT NULL DEFAULT 0,
  `band` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`phone_network_id`) USING BTREE,
  UNIQUE KEY `uq_phone_network_phone_id_network_id` (`phone_id`,`network_id`),
  KEY `fk_phone_network_network_id` (`network_id`),
  CONSTRAINT `fk_phone_network_network_id` FOREIGN KEY (`network_id`) REFERENCES `network` (`network_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_phone_network_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table ekatalog.phone_network: ~2 rows (approximately)
/*!40000 ALTER TABLE `phone_network` DISABLE KEYS */;
INSERT INTO `phone_network` (`phone_network_id`, `phone_id`, `network_id`, `band`) VALUES
	(4, 6, 3, 'LTE 1'),
	(5, 6, 1, 'TRL1');
/*!40000 ALTER TABLE `phone_network` ENABLE KEYS */;

-- Dumping structure for table ekatalog.phone_price
CREATE TABLE IF NOT EXISTS `phone_price` (
  `phone_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_id` int(10) unsigned NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`phone_price_id`) USING BTREE,
  KEY `fk_phone_price_phone_id` (`phone_id`) USING BTREE,
  CONSTRAINT `fk_phone_price_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.phone_price: ~2 rows (approximately)
/*!40000 ALTER TABLE `phone_price` DISABLE KEYS */;
INSERT INTO `phone_price` (`phone_price_id`, `phone_id`, `price`, `created_at`) VALUES
	(1, 6, 65.00, '2020-05-09 19:09:21'),
	(4, 6, 55.00, '2020-05-09 19:09:34');
/*!40000 ALTER TABLE `phone_price` ENABLE KEYS */;

-- Dumping structure for table ekatalog.photo
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_phone_id` (`phone_id`) USING BTREE,
  CONSTRAINT `FK_photo_phone` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.photo: ~1 rows (approximately)
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `phone_id`, `image_path`) VALUES
	(1, 6, 'img/sr/pck');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

-- Dumping structure for table ekatalog.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '0',
  `surname` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.user: ~0 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `name`, `surname`) VALUES
	(1, '@gmail', 'darko', 'dax', 'daxi');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
