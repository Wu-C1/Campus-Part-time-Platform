-- MySQL dump 10.13  Distrib 8.0.32, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: job_web
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `email` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `is_enable` tinyint(1) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `role` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `ix_admin_is_enable` (`is_enable`)
) ENGINE=InnoDB AUTO_INCREMENT=171143033704418001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('2024-03-26 19:46:48','2024-04-01 15:59:01','admin@admin.com','pbkdf2:sha256:150000$oPrhx1e0$c29acbf425c679061bec0d7508303c248e2f6e265657d1dd0d7d15caedec1cfd',1,171143033704418000,'管理员',30);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('cb0a052a04f1');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `email` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `is_enable` tinyint(1) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `website` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logo` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` smallint DEFAULT NULL,
  `finance_stage` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `field` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_general_ci,
  `rate` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_company_is_enable` (`is_enable`),
  CONSTRAINT `company_chk_1` CHECK ((`is_enable` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('2024-03-26 13:18:57','2024-04-01 17:52:48','lwolfe@example.com','pbkdf2:sha256:150000$Dn0Uwpn3$049bad1d7f3543f2b90445d817dba60bbd8f019fa1b7e211df1f7d2240e323d6',0,1,'相关应用文化然后',NULL,'一点','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'A轮','硬件','次数','出来',0),('2024-03-26 13:18:57','2024-04-01 17:19:00','fmartin@example.com','pbkdf2:sha256:150000$i1y4TBZj$4ec265e7e512961f7159dfd0b36f3a95450a5d343b6073749115bbfe850e0ba8',0,2,'什么精华没有地方',NULL,'但是','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'A轮','O2O','但是','同时',0),('2024-03-26 13:18:57','2024-03-26 13:18:57','colemankarla@example.com','pbkdf2:sha256:150000$saNr3Wf1$2b1a1fcd94500cdc5e8a977551730f8a269118b75edc9dede3b3452eab552ae0',1,3,'上海科技最新不要',NULL,'原因','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'未融资','游戏','那么','大小',0),('2024-03-26 13:18:57','2024-03-26 13:18:57','emilyprice@example.net','pbkdf2:sha256:150000$ZUqayllV$ba31731a6b0d12300f9baf4add2021e049e945c790ffab6531be297ea3e0a9d6',1,4,'不断美国企业留言',NULL,'组织','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'未融资','文化娱乐','谢谢','我的',0),('2024-03-26 13:18:57','2024-03-26 13:18:57','eroberts@example.com','pbkdf2:sha256:150000$zsxZHXH6$b7b10a30209cae688aec1ab5ec7de1d4aecf14b9bc5062021d8776ac79ebfe7f',1,5,'作为文化市场行业',NULL,'提高','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'A轮','移动互联网','完成','社区',0),('2024-03-26 13:18:57','2024-03-26 13:18:57','ecruz@example.com','pbkdf2:sha256:150000$FpVUpLsu$f5750923ea6867a407d180cd3f24f75f2b1dcb6f52ddcfdb62b71ddc920a9b96',1,6,'不过商品密码技术',NULL,'这种','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'C轮','电子商务','具有','然后',0),('2024-03-26 13:18:58','2024-03-26 13:18:58','carrkevin@example.com','pbkdf2:sha256:150000$kfbb2Moi$faf21cdbbaea31a11260a2c669a1e637549bd117dfaf195e282f3b9c86928619',1,7,'教育准备更新个人',NULL,'必须','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'A轮','移动互联网','数据','虽然',0),('2024-03-26 13:18:58','2024-03-26 13:18:58','abuckley@example.org','pbkdf2:sha256:150000$voc8zvdi$2ec6d78d13412bfab330b243497be093e9719dd84ce66592b01ecce537c4218b',1,8,'计划这些支持男人',NULL,'单位','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'C轮','企业服务','设备','就是',0),('2024-03-26 13:18:58','2024-03-26 13:18:58','christinaosborne@example.org','pbkdf2:sha256:150000$5Nhqt5jJ$72f220de861ca40fcf123450238db1948af245480a694167aa3c2f5345b1fe26',1,9,'中文方面产品汽车',NULL,'文件','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'上市公司','金融','发现','计划',0),('2024-03-26 13:18:58','2024-03-26 13:18:58','fjennings@example.net','pbkdf2:sha256:150000$sOvFyHGs$dd8dbfc34ab7745dab18c47c64f02237eeb7dc7bab994cf26142f9988cfb1415',1,10,'怎么能力网上看到',NULL,'全国','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'B轮','企业服务','网络','提高',0),('2024-03-26 13:18:58','2024-03-26 13:18:58','luispayne@example.com','pbkdf2:sha256:150000$o5siG8jS$970c0b5a60fde981aa7bce41ed323cebf18ab1c415e9991bb9ac14599e193a9f',1,11,'一样是否一点工程',NULL,'汽车','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','移动互联网','男人','介绍',0),('2024-03-26 13:18:58','2024-03-26 13:18:58','rmiller@example.org','pbkdf2:sha256:150000$EEVV4UNz$2a43b19f2a24c8d57dcb4849bc08c5540872f6563d0aaae30adb29b532067c90',1,12,'参加合作那个一起',NULL,'的人','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'A轮','游戏','只是','的人',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','foxrachel@example.net','pbkdf2:sha256:150000$CIWQLyln$b4fc23b8b80f2bffe4d7b5cf839e3d09592b24ba2f02ad8615aa634e57b3d359',1,13,'系统登录认为美国',NULL,'所以','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','电子商务','资料','有些',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','yharris@example.org','pbkdf2:sha256:150000$3kTqHrBp$a4ed431a12f7990906c03c25510672f9cbca627849bd9adf8d35ec324a05931c',1,14,'文章开始行业因此',NULL,'地方','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'B轮','教育','服务','同时',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','jocelyn87@example.net','pbkdf2:sha256:150000$kvMn5Twy$38bed2ff336ea90e3dbf6fe97f72c3a6e3d000924b4e5d48ba7ee0a1dde728dc',1,15,'使用发布有关过程',NULL,'的是','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'A轮','O2O','认为','表示',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','ttrevino@example.net','pbkdf2:sha256:150000$x9WvwhdI$c7234789d38f49b3010a5fddbed7a57babf4829c3310a6b5b6b5f7133757b9b9',1,16,'是一相关行业密码',NULL,'发表','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','电子商务','以上','一些',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','edixon@example.org','pbkdf2:sha256:150000$hWOUMb5s$15fdf60df673f73b96040bf690262d274286db57eb9736d1d07778ee7882b53d',1,17,'具有评论不断服务',NULL,'时间','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'天使轮','教育','实现','使用',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','annethompson@example.net','pbkdf2:sha256:150000$ohcMWZz1$8ee4063ba10bc74f3ef6a018b674945292f1492c37426d8801f10e9c27267c68',1,18,'完全合作或者这是',NULL,'中国','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'未融资','O2O','规定','北京',0),('2024-03-26 13:18:59','2024-03-26 13:18:59','kmann@example.net','pbkdf2:sha256:150000$FxOFnq8i$3d778c2fe78402cbd966a6e2dbbb08e3bd8af2fd0be77f7efc12e5e93ba8b9da',1,19,'怎么资源地址活动',NULL,'的话','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'天使轮','文化娱乐','时候','日本',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','palmersamuel@example.net','pbkdf2:sha256:150000$qIS9KWvk$77e0e354f594b469271bce087b74e77029fc8fb281290a1ae426e20fb766d4da',1,20,'现在还是软件查看',NULL,'标准','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'上市公司','硬件','现在','因此',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','aprilcole@example.org','pbkdf2:sha256:150000$7wcJm9oz$e8d67419ce04164a6be65711ab0d0a1db6ce710043cfa04ed6a4cbbe13bc3aba',1,21,'联系一直运行女人',NULL,'发生','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'B轮','教育','语言','他们',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','amy19@example.net','pbkdf2:sha256:150000$bFhhdUUJ$30a3cf38eb6acc44055cac6bbcf1b919612968ac0d7afc51aff6191a1f869bf0',1,22,'经济自己所以更多',NULL,'浏览','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'不需要融资','企业服务','加入','资料',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','andreamyers@example.org','pbkdf2:sha256:150000$BK6GSG29$1201968a12dfcdf971751ae686ba769ebeaccd27af15ed2a5b293756e81f981c',1,23,'标准需要学习这里',NULL,'一般','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'天使轮','文化娱乐','经营','服务',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','jonathan35@example.com','pbkdf2:sha256:150000$aHgvcqaC$16dd0d6341583c804a180508f956a3c5a49c369de203d746296ccc3dbccdaa15',1,24,'建设城市方面等级',NULL,'单位','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'未融资','硬件','认为','以上',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','douglasrodney@example.net','pbkdf2:sha256:150000$dPPvTgRb$8d4a34666cbe19cb8a527e2cd4d951c0fc9e7d13747b0e38d274c50071b0ef85',1,25,'具有就是专业已经',NULL,'任何','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','移动互联网','留言','无法',0),('2024-03-26 13:19:00','2024-03-26 13:19:00','daniel96@example.com','pbkdf2:sha256:150000$xuUhymNp$281275e49821420abbd337dffd2119155278ceb65cc925f97d913d0104f33dc6',1,26,'到了一下处理今天',NULL,'所有','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','文化娱乐','以及','社会',0),('2024-03-26 13:19:01','2024-03-26 13:19:01','michaelmitchell@example.net','pbkdf2:sha256:150000$kiet9BX4$8737ff755874a5c5af95154a05335290bf5eae3f2b7d4f7a0768df9e90fe55c5',1,27,'起来选择公司分析',NULL,'不同','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'C轮','O2O','基本','参加',0),('2024-03-26 13:19:01','2024-04-01 17:11:21','gutierrezdana@example.net','pbkdf2:sha256:150000$9Y5U64Kc$26063e16736b9fad4b0f65e2871d35c9082d065e7269aa443ccc9163358e3309',0,28,'发生今年地区商品',NULL,'中心','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','企业服务','实现','标准',0),('2024-03-26 13:19:01','2024-04-01 17:10:38','sheilajones@example.com','pbkdf2:sha256:150000$67sPCMI3$46a2e0c3613daffad4305912956687b21645d5a5401000742573a01c2cdc237c',0,29,'中文质量基本主要',NULL,'单位','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'C轮','移动互联网','经营','处理',0),('2024-03-26 13:19:01','2024-04-01 17:12:21','ryan22@example.org','pbkdf2:sha256:150000$pgjKoyjl$76aac32c0f03be11ba38088853047f6d8c829e5c26334b2dcdd251286f58abda',0,30,'继续一下方面内容',NULL,'专业','https://www.zhipin.com/v2/chat_v2/images/v2/defaultlogov2.jpg',20,'D轮及以上','游戏','留言','决定',0),('2024-03-26 16:12:13','2024-04-03 12:46:26','testqiye@qq.com','pbkdf2:sha256:150000$R2jhh9WK$a7e7689c9183ff72b647cc1e88abbfd69d19e2b7513d2693c895f59fe7d7467a',1,31,'测试企业','https://www.jd.com/','北京','http://127.0.0.1:5000/_uploads/logo/8bfc28f709fe5f6d6d76f74eb6bd12ad.jpg',20,'未融资','移动互联网','暂无','<p>暂无</p>\r\n',5);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `resume` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint DEFAULT NULL,
  `company_response` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rate` int NOT NULL DEFAULT '5',
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `job_id` (`job_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_delivery_status` (`status`),
  CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE SET NULL,
  CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE SET NULL,
  CONSTRAINT `delivery_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES ('2024-04-03 10:40:13','2024-04-03 10:42:45',1,64,171202882133280512,31,'http://127.0.0.1:5000/_uploads/resume/e44e2061e7d88668efc25b1f5270cf12.jpg',2,NULL,5),('2024-04-03 10:40:32','2024-04-03 12:46:26',2,63,171202882133280512,31,'http://127.0.0.1:5000/_uploads/resume/e44e2061e7d88668efc25b1f5270cf12.jpg',3,NULL,5);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `salary_min` smallint NOT NULL,
  `salary_max` smallint NOT NULL,
  `company_id` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `treatment` text COLLATE utf8mb4_general_ci,
  `exp` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `education` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tags` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_enable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `ix_job_city` (`city`),
  KEY `ix_job_education` (`education`),
  KEY `ix_job_exp` (`exp`),
  KEY `ix_job_is_enable` (`is_enable`),
  KEY `ix_job_salary_max` (`salary_max`),
  KEY `ix_job_salary_min` (`salary_min`),
  CONSTRAINT `job_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `job_chk_1` CHECK ((`is_enable` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES ('2024-03-26 13:19:01','2024-03-26 13:19:01',1,'相关工程师',3,5,1,'为什','如何','1年','专科','广州','信息,只有,标准,最新',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',2,'这里工程师',10,30,29,'不断','而且','10年以上','不限学历','广州','工程,单位,制作,下载',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',3,'音乐工程师',10,30,9,'内容','帮助','1-3年','不限学历','北京','准备,我们,对于,没有',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',4,'能够工程师',7,10,24,'特别','等级','不限','博士','上海','来自,使用,还有,记者',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',5,'有关工程师',3,5,3,'虽然','资料','5-10年','本科','广州','很多,最大,只要,类型',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',6,'威望工程师',50,100,14,'北京','广告','1年','博士','上海','手机,女人,时候,一样',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',7,'包括工程师',7,10,8,'欢迎','一点','3-5年','本科','广州','组织,目前,分析,解决',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',8,'他们工程师',5,8,18,'软件','无法','1-3年','不限学历','广州','经验,完成,精华,基本',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',9,'进行工程师',7,10,11,'公司','一般','1年','不限学历','上海','他们,质量,如果,问题',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',10,'根据工程师',10,30,21,'质量','上海','不限','专科','北京','还有,音乐,增加,法律',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',11,'东西工程师',5,8,4,'成为','东西','10年以上','硕士','北京','资源,控制,数据,就是',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',12,'部门工程师',3,5,30,'一直','加入','不限','专科','北京','如何,什么,以及,内容',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',13,'女人工程师',5,8,29,'规定','正在','5-10年','硕士','广州','以下,作为,有限,部门',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',14,'进入工程师',3,5,25,'觉得','学习','10年以上','本科','上海','您的,两个,手机,到了',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',15,'谢谢工程师',5,8,24,'只是','威望','3-5年','专科','北京','发生,通过,一样,可能',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',16,'那些工程师',10,30,13,'网站','次数','1-3年','专科','上海','国际,是否,自己,回复',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',17,'进入工程师',3,5,18,'活动','能够','1-3年','本科','上海','必须,之后,经济,主题',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',18,'名称工程师',10,30,18,'朋友','是一','不限','本科','北京','学生,信息,特别,留言',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',19,'通过工程师',10,30,19,'都是','学生','1年','不限学历','北京','所有,或者,你的,可是',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',20,'实现工程师',5,8,28,'来源','说明','3-5年','硕士','广州','联系,包括,开发,感觉',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',21,'关于工程师',50,100,8,'不要','不会','不限','本科','上海','自己,发生,介绍,能力',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',22,'欢迎工程师',5,8,27,'希望','等级','1-3年','不限学历','上海','情况,应该,这些,主要',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',23,'无法工程师',50,100,24,'具有','积分','不限','硕士','北京','音乐,世界,类型,具有',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',24,'这里工程师',3,5,9,'产品','已经','不限','不限学历','上海','可是,发生,工具,可能',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',25,'自己工程师',7,10,7,'发表','不同','1-3年','专科','北京','历史,价格,经验,大小',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',26,'社区工程师',7,10,20,'技术','全国','1-3年','硕士','上海','发展,在线,非常,看到',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',27,'虽然工程师',50,100,23,'无法','的人','10年以上','不限学历','北京','你们,位置,准备,报告',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',28,'而且工程师',50,100,10,'不要','有限','10年以上','专科','北京','产品,浏览,资源,通过',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',29,'质量工程师',10,30,6,'今天','文化','1年','本科','上海','到了,密码,这种,来源',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',30,'公司工程师',7,10,15,'组织','选择','5-10年','博士','广州','软件,次数,经营,上海',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',31,'次数工程师',7,10,13,'一下','软件','不限','硕士','北京','公司,论坛,的话,有关',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',32,'情况工程师',10,30,8,'一种','不是','1-3年','本科','广州','其中,运行,这里,资源',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',33,'信息工程师',3,5,2,'学校','单位','5-10年','不限学历','广州','发现,同时,文章,如果',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',34,'准备工程师',5,8,22,'城市','操作','10年以上','专科','广州','投资,学习,历史,使用',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',35,'时候工程师',50,100,3,'资料','为了','5-10年','本科','上海','最大,只要,程序,看到',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',36,'其中工程师',5,8,23,'发现','方面','不限','硕士','北京','只是,手机,新闻,国家',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',37,'她的工程师',5,8,16,'一下','来源','不限','不限学历','北京','客户,能够,日本,学习',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',38,'网上工程师',5,8,29,'可能','起来','1-3年','专科','广州','设备,一次,设备,功能',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',39,'处理工程师',50,100,4,'密码','电子','不限','专科','广州','密码,报告,支持,以后',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',40,'科技工程师',3,5,7,'朋友','回复','不限','硕士','广州','如何,项目,开始,是一',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',41,'所以工程师',10,30,29,'必须','文化','5-10年','硕士','广州','就是,图片,论坛,图片',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',42,'相关工程师',7,10,30,'新闻','可是','1年','博士','广州','不断,而且,包括,情况',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',43,'正在工程师',50,100,15,'有限','最新','不限','博士','广州','中国,无法,运行,不会',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',44,'也是工程师',5,8,11,'汽车','学习','5-10年','不限学历','上海','设计,精华,工作,可是',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',45,'我们工程师',50,100,19,'以上','这种','1-3年','博士','上海','生活,需要,也是,目前',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',46,'的话工程师',5,8,9,'威望','系统','1年','博士','上海','发展,的人,怎么,北京',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',47,'提高工程师',10,30,22,'电脑','同时','3-5年','专科','北京','等级,科技,最新,浏览',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',48,'女人工程师',7,10,7,'位置','部门','1年','专科','北京','起来,分析,是否,回复',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',49,'这是工程师',10,30,15,'中心','电影','5-10年','不限学历','上海','欢迎,业务,地区,查看',1),('2024-03-26 13:19:01','2024-03-26 13:19:01',50,'介绍工程师',5,8,20,'登录','只是','1-3年','博士','北京','部分,环境,今天,一切',1),('2024-03-26 16:19:15','2024-04-02 22:58:30',51,'前端开发',8,12,31,'<p>vue nodejs css精通</p>\r\n','<p>包吃包住</p>\r\n','不限','不限学历','北京','',1),('2024-04-01 17:49:02','2024-04-04 20:18:22',52,'测试职位2',10,12,31,'<p>测试2</p>\r\n','','不限','不限学历','北京','测试2',0),('2024-04-01 17:49:12','2024-04-01 17:49:12',53,'测试职位',10,12,31,'<p>测试职位</p>\r\n','测试','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',54,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',55,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',56,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',57,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',58,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',59,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',60,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',61,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',62,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',63,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1),('2024-04-01 17:49:12','2024-04-01 17:49:12',64,'测试职位',10,12,31,'<p>测试职位</p>\r\n','','不限','不限学历','北京','测试职位',1);
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `email` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `is_enable` tinyint(1) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `resume` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` smallint DEFAULT NULL,
  `hobby` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `skill` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `education` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `ix_user_is_enable` (`is_enable`),
  CONSTRAINT `user_chk_1` CHECK ((`is_enable` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=171202882133280513 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('2024-03-26 13:18:57','2024-04-01 16:33:19','megan75@example.org','pbkdf2:sha256:150000$dYu3hcdE$05e4966a8f8089b1123ad7e0dd917213f78d1d2ad388ac0edea04c748f977445',0,171143033657289824,'简介',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:57','2024-04-01 17:23:59','miranda01@example.com','pbkdf2:sha256:150000$wHVlP8gA$ee37922c72edd4196b16964f20c5b94ead31cbde1e51ddb5e5c0e4b76335302b',0,171143033675141824,'重要',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:57','2024-04-01 16:34:24','diana41@example.net','pbkdf2:sha256:150000$VjlhvNsb$77a9d013906747a6e199238909d6fc75923419bd4f20492abc6ccb84b7b78eaf',0,171143033689801696,'是一',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:57','2024-04-01 17:24:01','schultzwilliam@example.org','pbkdf2:sha256:150000$b4CCnrmP$adfbfc54c8b9c48b55fe62dd40a7fe2e49a05884a151a9e42d1a498ec6d71f77',0,171143033704468000,'出来',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:57','2024-04-04 19:32:09','karen59@example.com','pbkdf2:sha256:150000$VZ2aNgOA$9987beaa62d74fefa6a04d474e02eeaaff09ed725919ae81c09d909f22510619',0,171143033719283424,'标准',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:57','2024-04-04 19:30:48','iespinoza@example.com','pbkdf2:sha256:150000$fURvnWXB$bc72e105c57a1a2528edb93e829475a5d8b0357a959dc33fcc9df15a4f5dc15d',0,171143033733988704,'一起',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','kwilson@example.org','pbkdf2:sha256:150000$BsGJ0InI$d97269d6b7bb5a3bb3f833b79edc9da3b02370b270e9ae67340953716608b8d1',1,171143033748793824,'关系',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','jeremybond@example.org','pbkdf2:sha256:150000$cavzHO3C$060735b578b2c488c028ceb8f67cf5b7268fb14d85a1dd7ca1142b132f7b32b2',1,171143033763561312,'部分',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','jessicahernandez@example.org','pbkdf2:sha256:150000$CJSCr1XG$260930977731497aad88db414e023d6bb6ce7e97e41d620cb9b61f3d30a6d00d',1,171143033778111872,'电话',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','ssummers@example.net','pbkdf2:sha256:150000$qW0qn4RQ$b415bd5550c38bc389a8f9deae33700b92d4f2e46b22e002378f176808373786',1,171143033792815904,'这样',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','lozanocourtney@example.com','pbkdf2:sha256:150000$bKtsgM2F$ed62839cb37b2263af7507aee1a12679aa7dce7202fad225113ca6224ba92535',1,171143033807524000,'自己',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','emccarthy@example.org','pbkdf2:sha256:150000$ILJJNYyv$14ac3259f89d9900f4dd6f9ee329ba8f5eec9b75a79d67c3c818f46623ba7c31',1,171143033822279808,'深圳',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:58','2024-03-26 13:18:58','michelle69@example.net','pbkdf2:sha256:150000$aeWRwHiA$74136d2efb986c12faec8c86cbc314f727c3c7d57e7d47c53862b6855ff60d6e',1,171143033836995424,'功能',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','martinwilliam@example.com','pbkdf2:sha256:150000$xEeMIzSI$cdaf42f1e2613d6959d99fd4583114c063323b9c9095c1e9087eb5f6ee3c84de',1,171143033851714624,'文件',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','brett57@example.net','pbkdf2:sha256:150000$PauwfSHV$91f7c425d0fc474468cb28ae031a91a05295c6bad4f18933e3feaa0f139a53e7',1,171143033866335008,'应该',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','wallsherri@example.net','pbkdf2:sha256:150000$pWFNkXcD$128d00920e546ac0918b510266bb5d47c09f74280f3b0ee51311755c3802c4ba',1,171143033880925312,'自己',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','millerbrandon@example.org','pbkdf2:sha256:150000$Cutc5ZXl$4b836c27a7a8986083b53cc994879497f1e3ec9d166cc1485e28e2490f9d4826',1,171143033895658720,'用户',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','robinsonphillip@example.net','pbkdf2:sha256:150000$chxvbK9m$3b88cae025a5402dc50da8dd13f6e8702b964fc09b88ad0897a36424d85d0a44',1,171143033910173792,'其实',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','nancylane@example.org','pbkdf2:sha256:150000$ytNvgfHJ$7c97a841f7bfe4da182466e7183da32d9ad028690c4c32cef3422fbcfc7c50d5',1,171143033924903200,'全国',NULL,10,NULL,NULL,NULL),('2024-03-26 13:18:59','2024-03-26 13:18:59','jjohnson@example.org','pbkdf2:sha256:150000$RAapwimD$a791f015f9d1d6047e5ada371efc2490a7add7bba060f994a788b5e9427eb53b',1,171143033939642496,'比较',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','hwilliams@example.org','pbkdf2:sha256:150000$ebDUnVu8$7151f61efd597fecb8063bf74ad11faa2e826e6d1c05bf26392640f4f4522b46',1,171143033954224000,'类型',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','zmartinez@example.com','pbkdf2:sha256:150000$IoBmqulL$24bee8ae57401de6c636dd3731321e7b433ac900be1cec77a7cf4b3027a3a75b',1,171143033968941792,'生活',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','richard38@example.net','pbkdf2:sha256:150000$98q7ihct$9cd7481576674af75478cbb73fa12ce150744da2e774198ec977d277f725e115',1,171143033983602880,'目前',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','villaaimee@example.net','pbkdf2:sha256:150000$nQk5geyA$580f1ed9af5d092b3c171473e481fb2408b1f23a8f9bca530a8615671bfa352d',1,171143033998288992,'内容',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','joshua98@example.org','pbkdf2:sha256:150000$DdHVAeCp$c4c9dcc9ce8e4f19ec107af85f69c7b96c6e642e84f02c7095ce1a7628ed8f2a',1,171143034013091392,'功能',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','kevin26@example.com','pbkdf2:sha256:150000$oPyMECMR$3092b5e48a97f38390b3f709d42c821a3c13862af091ed367d90560e23385c21',1,171143034027873696,'继续',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:00','2024-03-26 13:19:00','spencerclayton@example.org','pbkdf2:sha256:150000$3alMmy1O$7c158a46629228a61e9ef36c0c4fba560965da36e04f6ce08287022a3d838910',1,171143034042497792,'虽然',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:01','2024-03-26 13:19:01','herreradominic@example.org','pbkdf2:sha256:150000$5iminD3P$8a33022fe2938de9c2cf1f8d580021e6bbc0dcf44161f0ec9f959f77c2423b39',1,171143034057204192,'有关',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:01','2024-03-26 13:19:01','thomasdiane@example.org','pbkdf2:sha256:150000$KiFfX11H$8f063d5d65f65ad798480314f214284f4e6c254640d4e5c2917436b9fffd728b',1,171143034072076480,'进入',NULL,10,NULL,NULL,NULL),('2024-03-26 13:19:01','2024-03-26 13:19:01','roseangelica@example.com','pbkdf2:sha256:150000$mUvJu8Bc$1b0b3a374617cdb87338b59df1f60fc873baff02ca6a3bcaace3904ee8e25835',1,171143034086650016,'实现',NULL,10,NULL,NULL,NULL),('2024-03-26 16:09:28','2024-04-01 16:13:39','test@qq.com','pbkdf2:sha256:150000$V98Rl8Np$7f678789b1de4b02afa7831226364aa9196f75adc4b14cd97f391453900a58fd',1,171144056797053696,'测试用户','http://127.0.0.1:5000/_uploads/resume/cac24d0aee79b26a413c269a2f8f30d6.jpg',10,NULL,NULL,NULL),('2024-04-02 11:33:41','2024-04-03 10:40:07','test2@qq.com','pbkdf2:sha256:150000$KTlgFhLp$fa8718584ff70166816526a452cb08d8ef012df3092a2d03bc3f29098534d85f',1,171202882133280512,'测试角色','http://127.0.0.1:5000/_uploads/resume/e44e2061e7d88668efc25b1f5270cf12.jpg',10,'羽毛球、跑步、打篮球','精通java、css、html、js','本科');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-17 16:41:09
