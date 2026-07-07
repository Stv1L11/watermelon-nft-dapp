-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: database02
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `command_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易ID，區塊鏈存證索引',
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `u_id` int DEFAULT NULL,
  `device_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作行為',
  `parameters` json DEFAULT NULL COMMENT '操作詳細參數(IP、持續時間等)',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Denied' COMMENT '操作結果: Verified 或 Denied',
  `timestamp` int NOT NULL COMMENT '操作發生之 Unix 時間戳記',
  `prev_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '前一筆日誌的 current_hash',
  `current_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '由數據計算所得 SHA-256',
  PRIMARY KEY (`command_id`),
  KEY `user_id` (`user_id`),
  KEY `device_id` (`device_id`),
  KEY `idx_audit_time` (`timestamp`),
  KEY `fk_audit_users_id` (`u_id`),
  CONSTRAINT `audit_logs_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`),
  CONSTRAINT `fk_audit_users_id` FOREIGN KEY (`u_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_telemetry`
--

DROP TABLE IF EXISTS `device_telemetry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_telemetry` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '歷史狀態快照(Online, Fault, LowBattery)',
  `telemetry_data` json DEFAULT NULL COMMENT '感測器物理數據',
  `recorded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `device_id` (`device_id`),
  KEY `idx_telemetry_time` (`recorded_at`),
  CONSTRAINT `device_telemetry_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_telemetry`
--

LOCK TABLES `device_telemetry` WRITE;
/*!40000 ALTER TABLE `device_telemetry` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_telemetry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `device_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主鍵。設備MAC位址',
  `device_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '設備種類',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active' COMMENT '目前營運狀態: Active, Revoked, Maintenance',
  `last_action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最後一次執行的人為動作',
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '心跳包更新時間',
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `families`
--

DROP TABLE IF EXISTS `families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `families` (
  `id` int NOT NULL AUTO_INCREMENT,
  `family_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_uid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `families`
--

LOCK TABLES `families` WRITE;
/*!40000 ALTER TABLE `families` DISABLE KEYS */;
INSERT INTO `families` VALUES (12,'台北測試總本山','admin_001','2026-06-01 14:31:37');
/*!40000 ALTER TABLE `families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `family_invitations`
--

DROP TABLE IF EXISTS `family_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_invitations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `family_id` int NOT NULL COMMENT '指向欲加入的家庭',
  `inviter_uid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '發起邀請的管理員 user_id',
  `invitee_uid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被邀請人的 user_id (帳號或 Email)',
  `role` enum('Admin','Member','Guest','Technician','SP','Visitor') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Guest',
  `status` enum('Pending','Accepted','Rejected','Expired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending' COMMENT '邀請狀態',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '邀請發起時間',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '狀態更新時間',
  PRIMARY KEY (`id`),
  KEY `fk_inv_family` (`family_id`),
  KEY `fk_inv_inviter` (`inviter_uid`),
  KEY `fk_inv_invitee` (`invitee_uid`),
  CONSTRAINT `fk_inv_family` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_inv_invitee` FOREIGN KEY (`invitee_uid`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_inv_inviter` FOREIGN KEY (`inviter_uid`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_invitations`
--

LOCK TABLES `family_invitations` WRITE;
/*!40000 ALTER TABLE `family_invitations` DISABLE KEYS */;
INSERT INTO `family_invitations` VALUES (1,12,'admin_001','target_user_99','Guest','Accepted','2026-06-01 14:47:38','2026-06-01 16:18:31'),(2,12,'admin_001','target_user_88','Member','Accepted','2026-06-01 16:24:22','2026-06-01 18:52:00');
/*!40000 ALTER TABLE `family_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_families`
--

DROP TABLE IF EXISTS `user_families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_families` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `family_id` int NOT NULL,
  `role` enum('Admin','Member','Guest','Technician','SP','Revoked') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Member' COMMENT '特定家庭場域內的身分組',
  `start_time` datetime DEFAULT NULL COMMENT '臨時權限開始時間',
  `end_time` datetime DEFAULT NULL COMMENT '臨時權限結束時間',
  `max_uses` int DEFAULT NULL COMMENT '最大允許操作次數，NULL代表無限次次數限制',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_family` (`user_id`,`family_id`),
  KEY `family_id` (`family_id`),
  CONSTRAINT `user_families_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_families_ibfk_2` FOREIGN KEY (`family_id`) REFERENCES `families` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_families`
--

LOCK TABLES `user_families` WRITE;
/*!40000 ALTER TABLE `user_families` DISABLE KEYS */;
INSERT INTO `user_families` VALUES (1,'admin_001',12,'Admin',NULL,NULL,NULL),(9,'target_user_99',12,'Guest','2026-06-04 00:00:00','2026-06-05 23:59:59',3),(10,'target_user_88',12,'Revoked',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主鍵。帳號或電子郵件',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Bcrypt加密後的密碼雜湊',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '帳號建立時間',
  `status` enum('Active','Disabled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active' COMMENT '全域帳號生命週期狀態',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (8,'admin_001','測試屋主老王','admin@example.com','0911000000','0123456','2026-06-01 14:31:18','Active'),(9,'target_user_99','訪客小明','xiaoming@example.com','0922000000','0123456','2026-06-01 14:32:05','Active'),(10,'target_user_88','新成員小華','xiaohua@example.com','0933000000','dummy_hash_test_only','2026-06-01 16:22:27','Active');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-04  4:28:08
