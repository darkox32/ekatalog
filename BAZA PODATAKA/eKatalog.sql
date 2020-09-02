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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.administrator: ~3 rows (approximately)
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'Admin1', 'C82D0A3CD48A7EBD80ED61B1B3169B9CA5C818E35ACF8E87145E163A1302C281F51780040FC2B31EB5933AEC322E15C2F967348411466D1E250AB136F128F092'),
	(8, 'Jovo2', 'D184D6BBC47CCDA893B84FDF8F8A130D6454690C364E591DA5FD3347E25A474E51C18E2067D626468314ADFEDB107AE647203D34CBEA928572B014C90BBCA47D'),
	(9, 'darko', 'A6282E9984EEEC7932B6593CD223FB7373DE12BEAA502976C72B2C29A5068399029552AC59B8784E7E5BC06DD52CDC50972422B1DC6C6DED83F80E4B9FCA7733');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

-- Dumping structure for table ekatalog.administrator_token
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `token` text NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`administrator_token_id`),
  KEY `fk_administrator_id_token_administrator_id` (`administrator_id`),
  CONSTRAINT `fk_administrator_id_token_administrator_id` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.administrator_token: ~25 rows (approximately)
/*!40000 ALTER TABLE `administrator_token` DISABLE KEYS */;
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(1, 9, '2020-07-08 23:11:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk2OTIxMTE0LjY5NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyNDI3MTR9.d7g8EnoV2C2TaLmAMaZAIu7u60Vhl-eL-K_-skHAXLE', '2020-08-08 21:11:54', 1),
	(2, 9, '2020-07-08 23:14:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk2OTIxMjU0LjM0NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyNDI4NTR9.H0byQ_eGz_Tjj_KKNDSz1rS82xZaVOuDV-WOoY98cz0', '2020-08-08 21:14:14', 1),
	(3, 9, '2020-07-08 23:22:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk2OTIxNzI1LjAwNywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyNDMzMjV9.xYK_93dUTuiFy7qM2F4O9WyBxiYXPLg8QAGnZuD-eJs', '2020-08-08 21:22:05', 1),
	(4, 9, '2020-07-08 23:26:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk2OTIxOTkzLjI3NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyNDM1OTN9.63aYiCndVHGlVJJur5Xatwzi8i2_yNxkZj38eYCo5Lg', '2020-08-08 21:26:33', 1),
	(5, 9, '2020-07-08 23:31:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk2OTIyMjk1LjI1NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyNDM4OTV9.Ov1BWR6UhOSJZcZrDhxaLlU54EDhbLikcNcQructbZM', '2020-08-08 21:31:35', 1),
	(6, 9, '2020-07-21 16:50:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MDIxNDUwLjgsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI1LjAiLCJpYXQiOjE1OTUzNDMwNTB9.Me8wiHVZRVyVwKbtvTGxOXITN7ECZFEY5l1iaqLJMgo', '2020-08-21 14:50:50', 1),
	(7, 9, '2020-07-22 16:07:21', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MTA1MjQxLjM3OCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMSIsImlhdCI6MTU5NTQyNjg0MX0.GTxz2sis62NdYYj4Gz-8tTn9W-Qh5xIS0lJb6KER7vM', '2020-08-22 14:07:21', 1),
	(8, 9, '2020-07-22 16:41:44', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MTA3MzA0Ljg1NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTQyODkwNH0.0LLYxPGsX0FAQD7BKYoleikDiQ6kYem5utv5Lf3Cmk8', '2020-08-22 14:41:44', 1),
	(9, 9, '2020-07-22 16:45:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MTA3NTIyLjQyNywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTQyOTEyMn0.zfXRUGfEK0SIFzxtdxplMgA9ZL13yMz5k5r00Xo2G9g', '2020-08-22 14:45:22', 1),
	(10, 9, '2020-07-22 16:51:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MTA3ODk0LjAxOCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMSIsImlhdCI6MTU5NTQyOTQ5NH0.pINhXXi3MyNLmpNRb4tw3_xjyLQxttjb_uXLrVVnCRI', '2020-08-22 14:51:34', 1),
	(11, 9, '2020-07-22 16:58:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MTA4MzAwLjk1MSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMSIsImlhdCI6MTU5NTQyOTkwMH0.0hAI5HWXzMWrrE9JWnVLpCSW7RlXQy3h8ZRejgXwlHU', '2020-08-22 14:58:20', 1),
	(12, 9, '2020-07-22 19:55:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4MTE4OTA5Ljg3MiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTQ0MDUwOX0.P71VbT1UH_MAo4xXWveyhoqWzUuXBDpPe2iQqviSnEc', '2020-08-22 17:55:09', 1),
	(13, 9, '2020-07-24 15:49:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4Mjc2OTY0LjMzNywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NTU5ODU2NH0.lmQu73V8fkQ1vyfvcfwE1coJ9Kz1AjcECJp1V07JFu8', '2020-08-24 13:49:24', 1),
	(14, 9, '2020-07-24 15:50:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4Mjc3MDQwLjMxNSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTU5ODY0MH0.YU4kECSTJhzwLmsFKMXgaus_7uPAeDdEU7W0VHn-V5E', '2020-08-24 13:50:40', 1),
	(15, 9, '2020-07-24 16:01:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4Mjc3Njc4LjI2OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTU5OTI3OH0.c-y4oDCxzZkwjMOrpXBuUIXdV6IambjlFP2k9lVOGoM', '2020-08-24 14:01:18', 1),
	(16, 9, '2020-07-24 16:16:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4Mjc4NTcwLjc2NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTYwMDE3MH0.8gZHy9VQi0QMw3bbxaynHdGDOTCbLXjHHLWqXwhG0TA', '2020-08-24 14:16:10', 1),
	(17, 9, '2020-07-24 16:26:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4Mjc5MTc2LjYzNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NTYwMDc3Nn0.hPazDoPCH0gasoDfDu9QIF6ey-eKjG6HRgxsmFxmx_k', '2020-08-24 14:26:16', 1),
	(18, 9, '2020-07-26 16:19:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4NDUxNTgyLjUyNiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTc3MzE4Mn0.vOCH3qADeaJs1UB5f407FeUASBETgD0eRPLZNn3ylgc', '2020-08-26 14:19:42', 1),
	(19, 9, '2020-07-26 16:55:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4NDUzNzA0LjcwOSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTc3NTMwNH0.UNSH9UHQ5uwH6_H39jA8WcePiG7Tz_g-KDnuwd65WCY', '2020-08-26 14:55:04', 1),
	(20, 9, '2020-07-26 17:47:46', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4NDU2ODY2LjcwOSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTc3ODQ2Nn0.-IEHfEXnHXlNpPtNE9wRV_x9Pjb1S_fziJch23O-h1M', '2020-08-26 15:47:46', 1),
	(21, 9, '2020-07-26 18:45:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4NDYwMzUwLjU2NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTc4MTk1MH0.PyhcjoPE5b0aT9ne64vvZsetLLMU175iTd5Kn2XkmWw', '2020-08-26 16:45:50', 1),
	(22, 9, '2020-07-28 16:33:32', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4NjI1MjEyLjcyMSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuODkgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NTk0NjgxMn0.2fi-pm2QmXo0QsVt7IPy3Hf7weqQXkB85TN7DNACoWQ', '2020-08-28 14:33:32', 1),
	(23, 9, '2020-07-28 16:57:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNTk4NjI2NjYxLjQ3NSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NTk0ODI2MX0.9EQYu8kBqUPeCbcVfBNcmh5q-i45orttPQCdIHtBn0U', '2020-08-28 14:57:41', 1),
	(24, 9, '2020-08-27 18:32:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNjAxMjI0MzU3LjI1OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTM1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTg1NDU5NTd9.kUmTIUCMkYpjvfBmyt0KyOdMnsHQOBzmrvujAkbWuts', '2020-09-27 16:32:37', 1),
	(25, 9, '2020-09-02 21:58:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjo5LCJpZGVudGl0eSI6ImRhcmtvIiwiZXhwIjoxNjAxNzU1MTAwLjIxMiwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5OTA3NjcwMH0.AT3PJmd9Npjr2NrCaGxEfVsovZPYVPyCKjUvQRmP3Mo', '2020-10-03 19:58:20', 1);
/*!40000 ALTER TABLE `administrator_token` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='feature kod milana';

-- Dumping data for table ekatalog.network: ~5 rows (approximately)
/*!40000 ALTER TABLE `network` DISABLE KEYS */;
INSERT INTO `network` (`network_id`, `name`) VALUES
	(1, '1G'),
	(2, '2G'),
	(3, '3G'),
	(5, '5G'),
	(4, 'Technology');
/*!40000 ALTER TABLE `network` ENABLE KEYS */;

-- Dumping structure for table ekatalog.phone
CREATE TABLE IF NOT EXISTS `phone` (
  `phone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `category_id` int(10) unsigned NOT NULL DEFAULT 0,
  `description` mediumtext DEFAULT NULL,
  `os` enum('Android','iOS','Windows','Blackberry') DEFAULT NULL,
  `ram_size` int(255) NOT NULL DEFAULT 0,
  `storage_size` int(255) NOT NULL DEFAULT 0,
  `screen_size` int(255) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`phone_id`) USING BTREE,
  KEY `fk_phone_category_id` (`category_id`),
  CONSTRAINT `fk_phone_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.phone: ~5 rows (approximately)
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` (`phone_id`, `name`, `category_id`, `description`, `os`, `ram_size`, `storage_size`, `screen_size`, `created_at`) VALUES
	(15, 'Android Pepe', 3, 'Novi opis :)', 'Blackberry', 555, 444, 222, '2020-06-06 20:51:59'),
	(16, 'Windows 45', 2, 'Kratak opis..121212321423543gsdgsdg.', 'Windows', 32, 10, 15, '2020-06-06 21:06:18'),
	(17, 'Apple X', 4, 'Stiv Jobs napravio telefon opis', 'iOS', 64, 1024, 9, '2020-06-07 19:25:05'),
	(18, 'Apple 55', 3, ' Roko ide niz planinu planinuRoko ide niz planinu planinuRoko ide niz planinu planinuRoko ide niz planinu planinuRoko ide niz planinu planinuRoko ide niz planinu planinu ', 'iOS', 64, 1024, 9, '2020-06-14 17:49:57'),
	(19, 'Samsung A80', 2, 'Testiram dal radi dodavanj i dalje, posto description mora bit duzi od 64 karaktera pisem jos teksta ne bi li konacno doso do tog broja', 'Android', 128, 2048, 7, '2020-07-28 17:00:58');
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
  CONSTRAINT `fk_phone_network_network_id` FOREIGN KEY (`network_id`) REFERENCES `network` (`network_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_phone_network_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table ekatalog.phone_network: ~7 rows (approximately)
/*!40000 ALTER TABLE `phone_network` DISABLE KEYS */;
INSERT INTO `phone_network` (`phone_network_id`, `phone_id`, `network_id`, `band`) VALUES
	(13, 16, 1, 'LTE 15005'),
	(15, 15, 3, 'CBA 929'),
	(16, 17, 3, 'GSP 550'),
	(17, 18, 3, 'GSP 550'),
	(18, 19, 3, 'GSP 550'),
	(19, 19, 2, 'ZVK 444'),
	(20, 19, 1, 'ABE 155');
/*!40000 ALTER TABLE `phone_network` ENABLE KEYS */;

-- Dumping structure for table ekatalog.phone_price
CREATE TABLE IF NOT EXISTS `phone_price` (
  `phone_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_id` int(10) unsigned NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`phone_price_id`) USING BTREE,
  KEY `fk_phone_price_phone_id` (`phone_id`) USING BTREE,
  CONSTRAINT `fk_phone_price_phone_id` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.phone_price: ~7 rows (approximately)
/*!40000 ALTER TABLE `phone_price` DISABLE KEYS */;
INSERT INTO `phone_price` (`phone_price_id`, `phone_id`, `price`, `created_at`) VALUES
	(11, 15, 950.90, '2020-06-06 20:51:59'),
	(12, 16, 117.23, '2020-06-06 21:06:18'),
	(13, 15, 666.00, '2020-06-06 21:56:56'),
	(14, 15, 999.00, '2020-06-06 22:02:24'),
	(15, 17, 20.00, '2020-06-07 19:25:05'),
	(16, 18, 20.00, '2020-06-14 17:49:57'),
	(17, 19, 850.00, '2020-07-28 17:00:58');
/*!40000 ALTER TABLE `phone_price` ENABLE KEYS */;

-- Dumping structure for table ekatalog.photo
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_id` int(10) unsigned NOT NULL DEFAULT 0,
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_phone_id` (`phone_id`) USING BTREE,
  CONSTRAINT `FK_photo_phone` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`phone_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.photo: ~6 rows (approximately)
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `phone_id`, `image_path`) VALUES
	(5, 18, '2020615-7443438586-aninu-tiddies.png'),
	(6, 16, '2020722-3380233274-windows.png'),
	(7, 17, '2020722-2516176042-apple.jpg'),
	(8, 18, '2020722-4700231839-apple.jpg'),
	(10, 15, '2020722-4180323798-android.png'),
	(11, 19, '2020728-3388612731-cropd.png');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.user: ~4 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `name`, `surname`) VALUES
	(10, 'test@test.com', 'DAEF4953B9783365CAD6615223720506CC46C5167CD16AB500FA597AA08FF964EB24FB19687F34D7665F778FCB6C5358FC0A5B81E1662CF90F73A2671C53F991', 'Tester', 'Testovski'),
	(11, 'dokodokic@gmail.com', '3B60A2A3C32547C24D56DA1A23DA7AC1F54927F3E71C86F9019390378648D7A2666EA874D1BAD7E65559F8D22DCBDF3F2C5B414C6C63B42EB7E021C849A76A24', 'Doko', 'Dokic'),
	(12, 'jovo@gmail.com', 'AA762C0A83E1CD11916DC77D01C036FB197762CB52A1DBFCDDFCE41968722C138AE5E73A0ADDA9B2251E7090277F374655E6A24CEA633C9060ACD5B1E172F242', 'jovo', 'jovovic'),
	(13, 'darko@gmail.com', 'C74EB92C5C4AA3864AEB0FD9CE7C35F07F55EC1A109FEEBB604EEDDB3A85EF1799BC961D0A0F868E75461100C2663212404BF6D22CD3EE96B1A3CADC65883096', 'darkox32', 'darkox32');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table ekatalog.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `token` text NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_token_id`),
  KEY `fk_user_token_user_id` (`user_id`),
  CONSTRAINT `fk_user_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table ekatalog.user_token: ~12 rows (approximately)
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(14, 10, '2020-06-15 22:25:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMCwiaWRlbnRpdHkiOiJ0ZXN0QHRlc3QuY29tIiwiZXhwIjoxNTk0OTMxMTM4Ljg5NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODMuMC40MTAzLjk3IE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNTkyMjUyNzM4fQ.3dvhVq_wpbe5vrl6u_yUIUqW-AICHzcMhIh7__5l-oo', '2020-07-16 20:25:38', 1),
	(15, 10, '2020-06-15 22:27:43', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMCwiaWRlbnRpdHkiOiJ0ZXN0QHRlc3QuY29tIiwiZXhwIjoxNTk0OTMxMjYzLjI3OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MjI1Mjg2M30.KF4S2y3LWbff-XtZfwzhnyDpNsVP62HUGGUEC5QWJtY', '2020-07-16 20:27:43', 1),
	(16, 11, '2020-06-17 16:49:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMSwiaWRlbnRpdHkiOiJkb2tvZG9raWNAZ21haWwuY29tIiwiZXhwIjoxNTk1MDgzNzQ2LjAzNCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MjQwNTM0Nn0.UpegVjXRNXyiuHMWwQCtS57JpjvnZVj3HdpJ9jNQcpo', '2020-07-18 14:49:06', 1),
	(17, 11, '2020-06-17 17:03:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMSwiaWRlbnRpdHkiOiJkb2tvZG9raWNAZ21haWwuY29tIiwiZXhwIjoxNTk1MDg0NTkwLjg2OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuOTcgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5MjQwNjE5MH0.3P-LLK3d3-1OFIiIS1L8Svf_IFHL_OuZSytTCLvDkz0', '2020-07-18 15:03:10', 1),
	(18, 11, '2020-06-18 18:15:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMSwiaWRlbnRpdHkiOiJkb2tvZG9raWNAZ21haWwuY29tIiwiZXhwIjoxNTk1MTc1MzM1LjM3MSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjUuMCIsImlhdCI6MTU5MjQ5NjkzNX0.O7TJCKRW5-uM72t9zubkiVM2nnAk5YhtPkO30gZDkDk', '2020-07-19 16:15:35', 1),
	(19, 10, '2020-07-08 16:57:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMCwiaWRlbnRpdHkiOiJ0ZXN0QHRlc3QuY29tIiwiZXhwIjoxNTk2ODk4NjU5LjM3NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyMjAyNTl9.9dWgmyE4yBF4zxIvvD99CErUg5usQbPHy2UuqmqqWlg', '2020-08-08 14:57:39', 1),
	(20, 10, '2020-07-08 23:26:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMCwiaWRlbnRpdHkiOiJ0ZXN0QHRlc3QuY29tIiwiZXhwIjoxNTk2OTIxOTg3LjExOSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQyNDM1ODd9.DJFUHz4WBaUgMVJ6BLGUKG-dDFBxP2Fo3CiTByjKeE0', '2020-08-08 21:26:27', 1),
	(21, 13, '2020-07-22 16:48:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMywiaWRlbnRpdHkiOiJkYXJrb0BnbWFpbC5jb20iLCJleHAiOjE1OTgxMDc3MTEuNTM0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny44OSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNTk1NDI5MzExfQ._QSvLcfDpAzU8wyBRz8UEiK2W0fS3bWj_ssCGwhyt2Q', '2020-08-22 14:48:31', 1),
	(22, 13, '2020-07-24 16:20:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMywiaWRlbnRpdHkiOiJkYXJrb0BnbWFpbC5jb20iLCJleHAiOjE1OTgyNzg4MzcuNjUxLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny44OSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNTk1NjAwNDM3fQ.otSoR97_ecVKrL3PaewHlapXGcLGrzv3z32aoe2qJ0g', '2020-08-24 14:20:37', 1),
	(23, 13, '2020-07-26 16:22:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMywiaWRlbnRpdHkiOiJkYXJrb0BnbWFpbC5jb20iLCJleHAiOjE1OTg0NTE3MjQuMzg0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny44OSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNTk1NzczMzI0fQ._pmZtNq7EgvAYbwafRGqhA8Bzz-1lJtueMuOWxFdFro', '2020-08-26 14:22:04', 1),
	(24, 13, '2020-07-26 16:23:17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMywiaWRlbnRpdHkiOiJkYXJrb0BnbWFpbC5jb20iLCJleHAiOjE1OTg0NTE3OTcuOTUzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny44OSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNTk1NzczMzk3fQ.CNvaxVmorpWqmjelI3uTicrg6DoIq4VHovxP9bf0L7o', '2020-08-26 14:23:17', 1),
	(25, 13, '2020-08-27 18:34:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxMywiaWRlbnRpdHkiOiJkYXJrb0BnbWFpbC5jb20iLCJleHAiOjE2MDEyMjQ0ODguNjk0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny4xMzUgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5ODU0NjA4OH0.NWdFJqI_Lcu9cyoCOKVhVo2pa_RsUdIYN9rMMaf0j1Y', '2020-09-27 16:34:48', 1);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
