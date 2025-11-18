-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: hub
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Current Database: `hub`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `hub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `hub`;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `idAddress` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `idLocation` bigint unsigned NOT NULL,
  PRIMARY KEY (`idAddress`),
  KEY `fkLocationAddress` (`idLocation`),
  CONSTRAINT `fkLocationAddress` FOREIGN KEY (`idLocation`) REFERENCES `location` (`idLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute` (
  `idAttribute` int unsigned NOT NULL AUTO_INCREMENT,
  `attrName` varchar(1024) DEFAULT NULL,
  `attrType` int unsigned NOT NULL,
  `idSuggestor` binary(16) NOT NULL,
  PRIMARY KEY (`idAttribute`),
  UNIQUE KEY `idAttribute_UNIQUE` (`idAttribute`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
INSERT INTO `attribute` VALUES (1,'gfdhjfghj',2,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª'),(2,'Color',3,_binary '¢t\ñt\Õì–½8\"\â#€ª'),(3,'test attribute',2,_binary '¢t\ñt\Õì–½8\"\â#€ª'),(4,'test',2,_binary '¢t\ñt\Õì–½8\"\â#€ª'),(5,'test attribute',2,_binary '¢t\ñt\Õì–½8\"\â#€ª'),(6,'db',2,_binary '¢t\ñt\Õì–½8\"\â#€ª');
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute-value`
--

DROP TABLE IF EXISTS `attribute-value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute-value` (
  `idAttributeValue` int unsigned NOT NULL AUTO_INCREMENT,
  `idAttribute` int unsigned NOT NULL,
  `attrValue` varchar(1024) DEFAULT NULL,
  `sortOrder` smallint NOT NULL,
  `idSuggestor` binary(16) NOT NULL,
  PRIMARY KEY (`idAttributeValue`),
  UNIQUE KEY `idAttributeValue_UNIQUE` (`idAttributeValue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute-value`
--

LOCK TABLES `attribute-value` WRITE;
/*!40000 ALTER TABLE `attribute-value` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute-value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `idBooking` int unsigned NOT NULL AUTO_INCREMENT,
  `idEvent` int unsigned NOT NULL,
  `idAvailability` int unsigned NOT NULL,
  `idConsumer` binary(16) NOT NULL,
  `idService` binary(16) NOT NULL,
  `confirmed` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idBooking`),
  UNIQUE KEY `idBooking_UNIQUE` (`idBooking`)
) ENGINE=InnoDB AUTO_INCREMENT=332 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (241,294,285,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',0),(246,299,284,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(249,302,283,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(250,303,283,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1),(252,305,285,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',1),(253,306,285,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',0),(255,308,284,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',2),(256,309,283,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',2),(257,310,284,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',1),(258,311,285,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',0),(259,312,283,_binary '´uk±Q\ì™(8\"\â#€ª',_binary ':¥\0©\Ñ\×ìŒ˜8\"\â#€ª',1),(260,313,284,_binary '´uk±Q\ì™(8\"\â#€ª',_binary ':¥\0©\Ñ\×ìŒ˜8\"\â#€ª',0),(261,314,283,_binary '´uk±Q\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1),(262,315,284,_binary '´uk±Q\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1),(263,316,285,_binary '´uk±Q\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',0),(264,317,285,_binary '´uk±Q\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1),(265,318,283,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',1),(266,319,283,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',1),(272,327,325,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(275,330,325,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1),(277,332,325,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1),(280,335,325,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary ':¥\0©\Ñ\×ìŒ˜8\"\â#€ª',0),(282,337,325,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(283,338,320,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(285,340,284,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',1),(286,344,341,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(287,345,341,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(288,346,341,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(289,347,341,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',1),(292,352,351,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',2),(293,354,285,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(294,355,285,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',1),(295,356,285,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(296,366,357,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(297,367,358,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(298,368,361,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(300,377,373,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(301,378,373,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(302,379,360,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(303,380,325,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(304,401,374,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(305,406,404,_binary '´uk±Q\ì™(8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(307,408,404,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(308,409,404,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(309,410,404,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'eA‚\î\Ñ\×ìŒ˜8\"\â#€ª',1),(310,411,405,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',2),(313,462,417,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(314,463,417,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(315,464,417,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(316,465,417,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(317,466,417,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(318,467,417,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(322,471,285,_binary '´uk±Q\ì™(8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(323,472,285,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',1),(324,473,430,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(325,474,431,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(326,483,435,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(327,484,436,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(328,485,436,_binary '´uk±Q\ì™(8\"\â#€ª',_binary '®VB\Ü\ì¶Á8\"\â#€ª',0),(329,486,436,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0),(330,487,481,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary ':¥\0©\Ñ\×ìŒ˜8\"\â#€ª',0),(331,488,413,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',0);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `idEntity` binary(16) NOT NULL,
  `idUser` binary(16) NOT NULL,
  `quantity` int unsigned DEFAULT NULL,
  `idOffer` int unsigned NOT NULL,
  PRIMARY KEY (`idEntity`,`idUser`),
  KEY `fkUserCart` (`idUser`),
  CONSTRAINT `fkEntityCart` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkUserCart` FOREIGN KEY (`idUser`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `idCategory` int unsigned NOT NULL AUTO_INCREMENT,
  `idParent` int unsigned NOT NULL,
  `catLevel` int NOT NULL,
  `catDesc` varchar(1024) NOT NULL,
  `entityType` int NOT NULL,
  `idSuggestor` binary(16) DEFAULT NULL,
  `approved` bit(1) DEFAULT b'0',
  PRIMARY KEY (`idCategory`),
  UNIQUE KEY `idCategory_UNIQUE` (`idCategory`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (101,4,2,'Music',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(102,101,3,'Guitars',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(103,102,4,'Acoustic',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(104,102,4,'Electric',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(105,101,3,'Drums',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(106,4,2,'Electronics',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(107,4,2,'Home',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(108,107,3,'Appliances',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(109,4,2,'Hardware',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(110,4,2,'Art',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(111,4,2,'Sports',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(112,4,2,'Video Games',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(113,4,2,'Automotive',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(114,113,3,'Used Cars',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(115,113,3,'New Cars',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(116,101,3,'Keyboards',4,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(117,5,2,'Technology',5,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0'),(118,5,2,'Music',5,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '\0');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `common-attribute`
--

DROP TABLE IF EXISTS `common-attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `common-attribute` (
  `idCommonAttribute` int unsigned NOT NULL,
  `idAttribute` int unsigned NOT NULL,
  `idCategory` int unsigned NOT NULL,
  `sortOrder` int DEFAULT NULL,
  `required` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idCommonAttribute`),
  KEY `fkCategory_idx` (`idCategory`),
  KEY `fkAttribute_idx` (`idAttribute`),
  CONSTRAINT `fkAttribute` FOREIGN KEY (`idAttribute`) REFERENCES `attribute` (`idAttribute`),
  CONSTRAINT `fkCategory` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `common-attribute`
--

LOCK TABLES `common-attribute` WRITE;
/*!40000 ALTER TABLE `common-attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `common-attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `idCountry` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `code` char(2) NOT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`idCountry`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Ã…land Islands','AX',_binary '\0'),(2,'Afghanistan','AF',_binary '\0'),(3,'Albania','AL',_binary '\0'),(4,'Algeria','DZ',_binary '\0'),(5,'American Samoa','AS',_binary '\0'),(6,'Andorra','AD',_binary '\0'),(7,'Angola','AO',_binary '\0'),(8,'Anguilla','AI',_binary '\0'),(9,'Antarctica','AQ',_binary '\0'),(10,'Antigua & Barbuda','AG',_binary '\0'),(11,'Argentina','AR',_binary '\0'),(12,'Armenia','AM',_binary '\0'),(13,'Aruba','AW',_binary '\0'),(14,'Australia','AU',_binary '\0'),(15,'Austria','AT',_binary '\0'),(16,'Azerbaijan','AZ',_binary '\0'),(17,'Bahamas','BS',_binary '\0'),(18,'Bahrain','BH',_binary '\0'),(19,'Bangladesh','BD',_binary '\0'),(20,'Barbados','BB',_binary '\0'),(21,'Belarus','BY',_binary '\0'),(22,'Belgium','BE',_binary '\0'),(23,'Belize','BZ',_binary '\0'),(24,'Benin','BJ',_binary '\0'),(25,'Bermuda','BM',_binary '\0'),(26,'Bhutan','BT',_binary '\0'),(27,'Bolivia','BO',_binary '\0'),(28,'Bonaire, Sint Eustatius and Saba','BQ',_binary '\0'),(29,'Bosnia & Herzegovina','BA',_binary '\0'),(30,'Botswana','BW',_binary '\0'),(31,'Bouvet Island','BV',_binary '\0'),(32,'Brazil','BR',_binary '\0'),(33,'British Indian Ocean Territory','IO',_binary '\0'),(34,'Brunei-Darussalam','BN',_binary '\0'),(35,'Bulgaria','BG',_binary '\0'),(36,'Burkina Faso','BF',_binary '\0'),(37,'Burundi','BI',_binary '\0'),(38,'CÃ´te D\'Ivoire (Ivory Coast)','CI',_binary '\0'),(39,'Cambodia','KH',_binary '\0'),(40,'Cameroon','CM',_binary '\0'),(41,'Canada','CA',_binary ''),(42,'Cape Verde','CV',_binary '\0'),(43,'Cayman Islands','KY',_binary '\0'),(44,'Central African Republic','CF',_binary '\0'),(45,'Chad','TD',_binary '\0'),(46,'Chile','CL',_binary '\0'),(47,'China','CN',_binary '\0'),(48,'Chrismas Island','CX',_binary '\0'),(49,'Cocos (Keeling) Islands','CC',_binary '\0'),(50,'Collectivity of Saint Martin','MF',_binary '\0'),(51,'Colombia','CO',_binary '\0'),(52,'Comoros','KM',_binary '\0'),(53,'Congo','CG',_binary '\0'),(54,'Congo, Democratic Republic','CD',_binary '\0'),(55,'Cook Islands','CK',_binary '\0'),(56,'Costa Rica','CR',_binary '\0'),(57,'Croatia','HR',_binary '\0'),(58,'Cuba','CU',_binary '\0'),(59,'CuraÃ§ao','CW',_binary '\0'),(60,'Cyprus','CY',_binary '\0'),(61,'Czech Republic','CZ',_binary '\0'),(62,'Denmark','DK',_binary '\0'),(63,'Djibouti','DJ',_binary '\0'),(64,'Dominica','DM',_binary '\0'),(65,'Dominican Republic','DO',_binary '\0'),(66,'Ecuador','EC',_binary '\0'),(67,'Egypt','EG',_binary '\0'),(68,'El Salvador','SV',_binary '\0'),(69,'Equatorial Guinea','GQ',_binary '\0'),(70,'Eritrea','ER',_binary '\0'),(71,'Estonia','EE',_binary '\0'),(72,'Ethiopia','ET',_binary '\0'),(73,'Falkand Islands (Malvinas)','FK',_binary '\0'),(74,'Faroe Islands','FO',_binary '\0'),(75,'Fiji','FJ',_binary '\0'),(76,'Finland','FI',_binary '\0'),(77,'France','FR',_binary '\0'),(78,'French Guiana','GF',_binary '\0'),(79,'French Polynesia','PF',_binary '\0'),(80,'French Southern Territories','TF',_binary '\0'),(81,'Gabon','GA',_binary '\0'),(82,'Gambia','GM',_binary '\0'),(83,'Georgia','GE',_binary '\0'),(84,'Germany','DE',_binary '\0'),(85,'Ghana','GH',_binary '\0'),(86,'Gibraltar','GI',_binary '\0'),(87,'Greece','GR',_binary '\0'),(88,'Greenland','GL',_binary '\0'),(89,'Grenada','GD',_binary '\0'),(90,'Guadeloupe','GP',_binary '\0'),(91,'Guam','GU',_binary '\0'),(92,'Guatemala','GT',_binary '\0'),(93,'Guinea','GN',_binary '\0'),(94,'Guinea-Bissau','GW',_binary '\0'),(95,'Guyana','GY',_binary '\0'),(96,'Haiti','HT',_binary '\0'),(97,'Heard Island And McDonald Islands','HM',_binary '\0'),(98,'Honduras','HN',_binary '\0'),(99,'Hong Kong','HK',_binary '\0'),(100,'Hungary','HU',_binary '\0'),(101,'Iceland','IS',_binary '\0'),(102,'India','IN',_binary '\0'),(103,'Indonesia','ID',_binary '\0'),(104,'Iran','IR',_binary '\0'),(105,'Iraq','IQ',_binary '\0'),(106,'Ireland','IE',_binary '\0'),(107,'Israel','IL',_binary '\0'),(108,'Italy','IT',_binary '\0'),(109,'Jamaica','JM',_binary '\0'),(110,'Japan','JP',_binary '\0'),(111,'Jordan','JO',_binary '\0'),(112,'Kazakhstan','KZ',_binary '\0'),(113,'Kenya','KE',_binary '\0'),(114,'Kiribati','KI',_binary '\0'),(115,'Kuwait','KW',_binary '\0'),(116,'Kyrgyzstan','KG',_binary '\0'),(117,'Laos','LA',_binary '\0'),(118,'Latvia','LV',_binary '\0'),(119,'Lebanon','LB',_binary '\0'),(120,'Lesotho','LS',_binary '\0'),(121,'Liberia','LR',_binary '\0'),(122,'Libyan Arab Jamahiriya','LY',_binary '\0'),(123,'Liechtenstein','LI',_binary '\0'),(124,'Lithuania','LT',_binary '\0'),(125,'Luxembourg','LU',_binary '\0'),(126,'Macao','MO',_binary '\0'),(127,'Macedonia  (former YR)','MK',_binary '\0'),(128,'Madagascar','MG',_binary '\0'),(129,'Malawi','MW',_binary '\0'),(130,'Malaysia','MY',_binary '\0'),(131,'Maldives (Maladive Ilands)','MV',_binary '\0'),(132,'Mali','ML',_binary '\0'),(133,'Malta','MT',_binary '\0'),(134,'Marshall Islands','MH',_binary '\0'),(135,'Martinique','MQ',_binary '\0'),(136,'Mauritania','MR',_binary '\0'),(137,'Mauritius','MU',_binary '\0'),(138,'Mayotte','YT',_binary '\0'),(139,'Mexico','MX',_binary '\0'),(140,'Micronesia  (Federa States of)','FM',_binary '\0'),(141,'Moldova, Republic of','MD',_binary '\0'),(142,'Monaco','MC',_binary '\0'),(143,'Mongolia','MN',_binary '\0'),(144,'Montenegro','ME',_binary '\0'),(145,'Montserrat','MS',_binary '\0'),(146,'Morocco','MA',_binary '\0'),(147,'Mozambique','MZ',_binary '\0'),(148,'Myanmar (Burma)','MM',_binary '\0'),(149,'Namibia','NA',_binary '\0'),(150,'Nauru','NR',_binary '\0'),(151,'Nepal','NP',_binary '\0'),(152,'Netherlands','NL',_binary '\0'),(153,'Netherlands Antilles','AN',_binary '\0'),(154,'New Caledonia','NC',_binary '\0'),(155,'New Zealand','NZ',_binary '\0'),(156,'Nicaragua','NI',_binary '\0'),(157,'Niger','NE',_binary '\0'),(158,'Nigeria','NG',_binary '\0'),(159,'Niue','NU',_binary '\0'),(160,'Norfolk Island','NF',_binary '\0'),(161,'North Korea','KP',_binary '\0'),(162,'Northern Mariana Islands','MP',_binary '\0'),(163,'Norway','NO',_binary '\0'),(164,'Oman','OM',_binary '\0'),(165,'Pakistan','PK',_binary '\0'),(166,'Palau','PW',_binary '\0'),(167,'Palestinian Territory, Occupied','PS',_binary '\0'),(168,'Panama','PA',_binary '\0'),(169,'Papua-New Guinea','PG',_binary '\0'),(170,'Paraguay','PY',_binary '\0'),(171,'Peru','PE',_binary '\0'),(172,'Philippines','PH',_binary '\0'),(173,'Pitcairn','PN',_binary '\0'),(174,'Poland','PL',_binary '\0'),(175,'Portugal','PT',_binary '\0'),(176,'Puerto Rico','PR',_binary '\0'),(177,'Quatar','QA',_binary '\0'),(178,'Reunion','RE',_binary '\0'),(179,'Romania','RO',_binary '\0'),(180,'Russian Federation','RU',_binary '\0'),(181,'Rwanda','RW',_binary '\0'),(182,'Saint BarthÃ©lemy','BL',_binary '\0'),(183,'Saint Helena, Ascension and Tristan da Cunha','SH',_binary '\0'),(184,'Saint Pierre And Micquelon','PM',_binary '\0'),(185,'San Marino','SM',_binary '\0'),(186,'Sao Tome & Principe','ST',_binary '\0'),(187,'Saudi Arabia','SA',_binary '\0'),(188,'Senegal','SN',_binary '\0'),(189,'Serbia','RS',_binary '\0'),(190,'Seychelles','SC',_binary '\0'),(191,'Sierra Leone','SL',_binary '\0'),(192,'Singapore','SG',_binary '\0'),(193,'Sint-Maarten','SX',_binary '\0'),(194,'Slovakia','SK',_binary '\0'),(195,'Slovenia','SI',_binary '\0'),(196,'Solomon Islands','SB',_binary '\0'),(197,'Somalia','SO',_binary '\0'),(198,'South Africa','ZA',_binary '\0'),(199,'South Georgia & South Sandwich Islands','GS',_binary '\0'),(200,'South Korea','KR',_binary '\0'),(201,'Spain','ES',_binary '\0'),(202,'Sri Lanka','LK',_binary '\0'),(203,'St. Kitts & Nevis','KN',_binary '\0'),(204,'St. Lucia','LC',_binary '\0'),(205,'St. Vincent & Grenadines','VC',_binary '\0'),(206,'Sudan','SD',_binary '\0'),(207,'Suriname','SR',_binary '\0'),(208,'Svalbard And Jan Mayen','SJ',_binary '\0'),(209,'Swaziland','SZ',_binary '\0'),(210,'Sweden','SE',_binary '\0'),(211,'Switzerland','CH',_binary '\0'),(212,'Syrian Arab Republic','SY',_binary '\0'),(213,'Taiwan','TW',_binary '\0'),(214,'Tajikistan','TJ',_binary '\0'),(215,'Tanzania','TZ',_binary '\0'),(216,'Thailand','TH',_binary '\0'),(217,'Timor-Leste','TL',_binary '\0'),(218,'Togo','TG',_binary '\0'),(219,'Tokelau','TK',_binary '\0'),(220,'Tonga','TO',_binary '\0'),(221,'Trinidad & Tobago','TT',_binary '\0'),(222,'Tunisia','TN',_binary '\0'),(223,'Turkey','TR',_binary '\0'),(224,'Turkmenistan','TM',_binary '\0'),(225,'Turks And Caicos Islands','TC',_binary '\0'),(226,'Tuvalu','TV',_binary '\0'),(227,'Uganda','UG',_binary '\0'),(228,'Ukraine','UA',_binary '\0'),(229,'United Arab Emirates','AE',_binary '\0'),(230,'United Kingdom','GB',_binary '\0'),(231,'United States','US',_binary ''),(232,'United States Minor Outlying Islands','UM',_binary '\0'),(233,'Uruguay','UY',_binary '\0'),(234,'Uzbekistan','UZ',_binary '\0'),(235,'Vanuatu','VU',_binary '\0'),(236,'Vatican City','VA',_binary '\0'),(237,'Venezuela','VE',_binary '\0'),(238,'Vietnam','VN',_binary '\0'),(239,'Virgin Islands, British','VG',_binary '\0'),(240,'Virgin Islands, U.S.','VI',_binary '\0'),(241,'Wallis And Futuna','WF',_binary '\0'),(242,'Western Sahara','EH',_binary '\0'),(243,'Western Samoa','WS',_binary '\0'),(244,'Yemen','YE',_binary '\0'),(245,'Zambia','ZM',_binary '\0'),(246,'Zimbabwe','ZW',_binary '\0');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit-card`
--

DROP TABLE IF EXISTS `credit-card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit-card` (
  `idCreditCard` bigint unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(16) NOT NULL,
  `expiration` date NOT NULL,
  `ccv` varchar(4) NOT NULL,
  `idAddressBilling` bigint unsigned NOT NULL,
  PRIMARY KEY (`idCreditCard`),
  KEY `fkAddressCreditCard` (`idAddressBilling`),
  CONSTRAINT `fkAddressCreditCard` FOREIGN KEY (`idAddressBilling`) REFERENCES `address` (`idAddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit-card`
--

LOCK TABLES `credit-card` WRITE;
/*!40000 ALTER TABLE `credit-card` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit-card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email` (
  `idEmail` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idEntity` binary(16) NOT NULL,
  `emailAddress` varchar(320) NOT NULL,
  `emailVerified` tinyint(1) DEFAULT NULL,
  `emailVerifyCode` char(6) NOT NULL,
  PRIMARY KEY (`idEmail`),
  UNIQUE KEY `idEmail_UNIQUE` (`idEmail`),
  KEY `fkEntityEmail_idx` (`idEntity`),
  CONSTRAINT `fkEntityEmail` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
INSERT INTO `email` VALUES (1,_binary '¢t\ñt\Õì–½8\"\â#€ª','stevedelollis@gmail.com',1,'701296'),(2,_binary 'w?A\",\Óì–½8\"\â#€ª','test@test.test',NULL,'100505'),(5,_binary 'lŒ>Q®ì¾¯8\"\â#€ª','stevedelollis@gmail.com',1,'547283'),(6,_binary '\Ç9h¡]B\ìª\á8\"\â#€ª','stevedelollis@gmail.com',1,'966122'),(7,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','stevedelollis@gmail.com',1,'070821'),(8,_binary '´uk±Q\ì™(8\"\â#€ª','stevedelollis@gmail.com',1,'735227'),(9,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','stevedelollis@gmail.com',1,'052822'),(10,_binary 'Á¢:»\á\ì§b8\"\â#€ª','Stevedelollis@gmail.com',1,'535357'),(11,_binary '¢t\ñt\Õì–½8\"\â#€ª','carson.holmes@gmail.com',NULL,'559184'),(12,_binary '¢t\ñt\Õì–½8\"\â#€ª','carson.holmes@gmail.com',NULL,'752969'),(13,_binary '¢t\ñt\Õì–½8\"\â#€ª','ThisIsTheLongEmailAddressTest@fairhub.com',NULL,'572417'),(16,_binary '•K|Á!ìŒ˜8\"\â#€ª','Stevedelollis@gmail.com',1,'197518'),(17,_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','carson.holmes@gmail.com',1,'382440'),(18,_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','carson.holmes@gmail.com',1,'658652'),(19,_binary 'Õ½².\Ì(ìŒ˜8\"\â#€ª','Stevedelollis@gmail.com',NULL,'838656');
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity`
--

DROP TABLE IF EXISTS `entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity` (
  `idEntity` binary(16) NOT NULL,
  `entityTitle` varchar(255) DEFAULT NULL,
  `entityDesc` text,
  `entityType` int NOT NULL,
  `idMedia` bigint unsigned DEFAULT NULL,
  `dtCreated` datetime NOT NULL,
  `dtLastEdited` datetime DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity`
--

LOCK TABLES `entity` WRITE;
/*!40000 ALTER TABLE `entity` DISABLE KEYS */;
INSERT INTO `entity` VALUES (_binary '°I\óû;\ì³8\"\â#€ª','gfjkghkghkjg','',5,NULL,'2022-07-04 09:45:40','2022-07-04 09:47:08'),(_binary '\Şj¬ &ì§…8\"\â#€ª','Test','Test',4,NULL,'2022-03-10 11:56:05',NULL),(_binary '\è úh®\ì°	8\"\â#€ª','A test item with a really really really really really really really really really really really really long title','Here\'s a really really really really really really really really really really really really really really really really really really really long description.\n\nThis long description is for the purpose of testing various layouts and blah blah blah.',4,NULL,'2021-12-29 21:48:34',NULL),(_binary '@µ%\÷k\ì’P8\"\â#€ª','uilhulj','',5,NULL,'2022-06-29 13:19:14',NULL),(_binary 'lŒ>Q®ì¾¯8\"\â#€ª','Steve2','null',1,NULL,'2021-11-30 15:20:38','2021-11-30 15:21:36'),(_binary 'q\ö°ì«ª8\"\â#€ª','blah','',5,NULL,'2022-06-28 15:00:40',NULL),(_binary 'cÌ¦\ö®ì«ª8\"\â#€ª','test service','',5,NULL,'2022-06-28 14:46:23',NULL),(_binary 'c??­¥\ì™(8\"\â#€ª','booking settings test 3/27','here\'s a description',5,NULL,'2022-03-27 16:08:06','2022-03-28 07:30:04'),(_binary '²,q\ö°ì«ª8\"\â#€ª','blah','',5,NULL,'2022-06-28 15:00:46',NULL),(_binary '	¾\Ş\İ\ö°ì«ª8\"\â#€ª','blah','',5,NULL,'2022-06-28 15:00:47',NULL),(_binary '\r-kšü\Ì\ì¾\È8\"\â#€ª','xvxcvxvxvcxcv','',5,NULL,'2022-07-06 09:36:26',NULL),(_binary '\r7\ßS$ì¾¯8\"\â#€ª','test item w/4-line desc','one\ntwo\nthree\nfour',4,NULL,'2021-12-02 11:58:04',NULL),(_binary '\rºO\òm\à\ì°	8\"\â#€ª','new item w/2 images','blah',4,NULL,'2022-01-05 12:29:21',NULL),(_binary '\r\ÆS-ª‚\ì™(8\"\â#€ª','Ethan\'s test place','blahhhhhhhhhhhhhhhhhhhhhh to you                                                 \n1+2+3+4+5+6+7+8x9=100',7,NULL,'2022-03-23 16:20:09',NULL),(_binary 'œe\Ùt\ç\ì•D8\"\â#€ª','second test 1-14 w/price','',4,NULL,'2022-01-14 11:07:08',NULL),(_binary '\"¥©¶\ì™(8\"\â#€ª','booking settings test 3/22','Here\'s a description.',5,NULL,'2022-03-22 15:59:56','2022-03-22 18:20:35'),(_binary '´«Ò®E\ì™(8\"\â#€ª','rate test','',5,NULL,'2022-03-28 11:13:39',NULL),(_binary '\õ«\Ü\ö®ì«ª8\"\â#€ª','test service','',5,NULL,'2022-06-28 14:46:41',NULL),(_binary 'E[Pª[\ì™(8\"\â#€ª','booking settings test 3/23','asdfasdfasdf',5,NULL,'2022-03-23 11:41:06',NULL),(_binary '²2kù\ì‚Q8\"\â#€ª','bvnm','',5,NULL,'2022-07-01 16:23:26','2022-07-01 16:23:32'),(_binary '\÷S!ì¾¯8\"\â#€ª','test item w/long desc, 1 image, no links','asdfgasdf\nasdf\nsdfasdf\n\n\nasdfasdf\nasdf\n\nasdfasdf\nasdf\nasdf\nasdf',4,NULL,'2021-12-02 11:36:52',NULL),(_binary '\ZVP‚7\ì­\Z8\"\â#€ª','image test','Testing image zoom.',4,NULL,'2022-01-31 09:42:51','2022-01-31 09:43:41'),(_binary '´uk±Q\ì™(8\"\â#€ª','Stevetest2','',1,NULL,'2022-04-01 08:17:27','2022-04-01 12:07:24'),(_binary ' ¥r.l\õ\ì°	8\"\â#€ª','Test Item with Price','',4,NULL,'2022-01-04 08:27:41',NULL),(_binary ' ³’oQ\Äì¾¯8\"\â#€ª','Test item with a description, 2 images & some linked content','Here\'s the description.',4,NULL,'2021-11-30 17:58:54',NULL),(_binary '!TIü\Ğ\ì¾\È8\"\â#€ª','xvcbxcxcvb','',5,NULL,'2022-07-06 10:05:38','2022-07-06 10:09:31'),(_binary '!9%—ûn\ì³8\"\â#€ª','vcvcv','',5,NULL,'2022-07-04 15:51:36','2022-07-04 15:52:04'),(_binary '!=`Zû~\ì³8\"\â#€ª','ghjkfgk','',5,NULL,'2022-07-04 17:46:08','2022-07-04 17:46:18'),(_binary '#\Å\÷l\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:27:15',NULL),(_binary '$LfR<ì¾¯8\"\â#€ª','item test w/no description, one image and two linked content','',4,NULL,'2021-12-01 08:17:59',NULL),(_binary '\'•™V®C\ì™(8\"\â#€ª','new test','xfbxdfb',5,NULL,'2022-03-28 10:59:59',NULL),(_binary ')’Eb\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:38:31',NULL),(_binary '*ˆ-\è®M\ì™(8\"\â#€ª','free test 3','',5,NULL,'2022-03-28 12:11:39',NULL),(_binary '+¹O®D\ì™(8\"\â#€ª','test price save','',5,NULL,'2022-03-28 11:07:14',NULL),(_binary '+ü\ßLı—\ì„8\"\â#€ª','new','',5,NULL,'2022-07-07 09:50:26','2022-07-07 09:52:46'),(_binary ',\ß\"\ò\öšì«ª8\"\â#€ª','yet another new service','',5,NULL,'2022-06-28 12:24:17',NULL),(_binary '0apD\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:38:42',NULL),(_binary '1©59‚5\ì­\Z8\"\â#€ª','family cookies','They\'re really yummy!!! (yummier than ever!!!!)',4,NULL,'2022-01-31 09:29:11','2022-02-02 09:30:59'),(_binary '3ªoÁ®{\ì™(8\"\â#€ª','service lead time test','',5,NULL,'2022-03-28 17:41:11',NULL),(_binary '3\ìœ\÷o\ì’P8\"\â#€ª','s','',5,NULL,'2022-06-29 13:49:12',NULL),(_binary '4\n\Î\÷m\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:34:53',NULL),(_binary ':¥\0©\Ñ\×ìŒ˜8\"\â#€ª','manual confirm, quantity=1','',5,NULL,'2022-05-12 17:38:07',NULL),(_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª','new image test','new description',4,NULL,'2022-02-01 09:06:47','2022-03-08 12:44:39'),(_binary ';Ê¼\÷m\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:35:05',NULL),(_binary ';.ªmø?\ì¢ 8\"\â#€ª','Thu 10','dsfsdfgsdfg',5,NULL,'2022-06-30 14:38:20','2022-06-30 14:38:30'),(_binary ';…@\\\÷o\ì’P8\"\â#€ª','s','',5,NULL,'2022-06-29 13:49:25',NULL),(_binary '>\Ë}=\÷o\ì’P8\"\â#€ª','s','',5,NULL,'2022-06-29 13:49:30',NULL),(_binary '>\ê]\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:39:07',NULL),(_binary '@K\ä\"ø\ì¢ 8\"\â#€ª','new test','',5,NULL,'2022-06-30 09:09:11',NULL),(_binary 'E\è#8\÷o\ì’P8\"\â#€ª','s','Here\'s a description for s.',5,NULL,'2022-06-29 13:49:42',NULL),(_binary 'H~?\ã\÷k\ì’P8\"\â#€ª','fdgndfgnh','',5,NULL,'2022-06-29 13:21:09',NULL),(_binary 'I1@b\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:39:24',NULL),(_binary 'I\Î\Û\÷o\ì’P8\"\â#€ª','s','Here\'s a description for s.',5,NULL,'2022-06-29 13:49:49',NULL),(_binary 'K.0ı¤8\ì™(8\"\â#€ª','new item with price, images, description, and linked content','lajksdf\nasdjf;l;\nasfd\nasdf\nsdf\nsdf\nasdfasdf\n\nasdfasdf\ndsf\nasdf\nasdf\nasfdasdfasdf',4,NULL,'2022-03-15 16:17:02',NULL),(_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª','manual confirm, quantity=3','',5,NULL,'2022-05-12 17:38:35',NULL),(_binary 'L‚Át(\ì•D8\"\â#€ª','new item w/price','lasdjfklsjf',4,NULL,'2022-01-13 12:21:37',NULL),(_binary 'MØ‡…¨\Õ\ì™(8\"\â#€ª','service test w/booking settings','Description is here.',5,NULL,'2022-03-21 13:11:02',NULL),(_binary 'N?Ê“ü-\ì™v8\"\â#€ª','cv','',5,NULL,'2022-07-05 14:40:05','2022-07-05 14:40:11'),(_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª','second test 1-13','',4,NULL,'2022-01-14 08:45:45','2022-01-14 08:46:12'),(_binary 'O³\ôQ˜ì¾¯8\"\â#€ª','A test post with a description and one image','This is the description.',3,NULL,'2021-11-30 12:45:15',NULL),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª','Roadie Lessons','TJGHJ\nGFHJ\nGH\nGH\nM\nHJMGFHJK\nFGHJ\ndf\nfj\ndfgjh\n\ndfgjhdfhgj',5,NULL,'2022-03-29 08:36:45','2022-04-06 17:38:32'),(_binary 'QÔ‚\÷o\ì’P8\"\â#€ª','s','Here\'s a description for s.',5,NULL,'2022-06-29 13:50:01',NULL),(_binary 'R)\ÇS$ì¾¯8\"\â#€ª','test item w/3-line desc','one\n\ntwo',4,NULL,'2021-12-02 12:00:00',NULL),(_binary 'R`\ÑUm\Í\ì°	8\"\â#€ª','short','lkasdfg',4,NULL,'2022-01-05 10:15:15',NULL),(_binary 'R\Êy\ö™ì«ª8\"\â#€ª','Another new service','',5,NULL,'2022-06-28 12:18:12',NULL),(_binary 'S§R8\÷o\ì’P8\"\â#€ª','s','Here\'s a description for s.',5,NULL,'2022-06-29 13:50:05',NULL),(_binary 'S\õµÎ®M\ì™(8\"\â#€ª','free test 4','',5,NULL,'2022-03-28 12:12:48',NULL),(_binary 'S\ö€1\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:39:42',NULL),(_binary 'V\Ä×¶û}\ì³8\"\â#€ª','jkl;jkl;','',5,NULL,'2022-07-04 17:40:28','2022-07-04 17:45:10'),(_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª','auto confirm, quantity=1','',5,NULL,'2022-05-12 17:38:56',NULL),(_binary 'Y;59ü\Ì\ì¾\È8\"\â#€ª','qwqvsdbshsdfgth','',5,NULL,'2022-07-06 09:38:34','2022-07-06 09:39:43'),(_binary 'Y\Ê`ª\\\ì™(8\"\â#€ª','second booking settings test 3/23','',5,NULL,'2022-03-23 11:50:16',NULL),(_binary '_)‹\÷m\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:36:06',NULL),(_binary '_v=\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:40:01',NULL),(_binary 'bŒ\÷m\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:36:11',NULL),(_binary 'd‘¹\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:40:10',NULL),(_binary 'd\×úm$\ì°	8\"\â#€ª','Another new item with a price, desc, two images, and some linked content','blah, blah, blah',4,NULL,'2022-01-04 14:06:01',NULL),(_binary 'eMx\÷m\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:36:16',NULL),(_binary 'f\ï\Ñ\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:40:12',NULL),(_binary 'fIigü\É\ì¾\È8\"\â#€ª','uoiuio','',5,NULL,'2022-07-06 09:17:27',NULL),(_binary 'gU\×\öœì«ª8\"\â#€ª','yet again new service','',5,NULL,'2022-06-28 12:40:15',NULL),(_binary 'hPDm!\ì°	8\"\â#€ª','New test item with a price to check layout','Here\'s a description. laksdfjn asdlkf aslkdhgsa fg \na sdgf\nasghasgh\nasdgfh\nasdgasdhg;lashdghsad;lg\nasklgdf\nl;s\n\nas;ldgfhaskhg\nkajsdfgkashdfgl;ashld;fghas;',4,NULL,'2022-01-04 13:44:39',NULL),(_binary 'iÒ¯ \÷t\ì’P8\"\â#€ª','ulhjklhjkl','',5,NULL,'2022-06-29 14:26:30',NULL),(_binary 'j³\ğ~n‡\ì°	8\"\â#€ª','Ethan\'s test item','dsfkldsfklijdsfkijlsdfkildfsgkilsdfgakiljdfskilfdsakijlfgdsakijlgfsdakjilfgsdakijlfgsdakijlfdgakilg',4,NULL,'2022-01-06 08:27:23','2022-01-14 08:19:43'),(_binary 'k6\Ét\Í\ì•D8\"\â#€ª','New Test 1-13','',4,NULL,'2022-01-14 08:03:35','2022-01-14 08:31:33'),(_binary 'k¶ı{\ö¸ì«ª8\"\â#€ª','sfd','',5,NULL,'2022-06-28 16:00:48',NULL),(_binary 'l	ƒC\÷t\ì’P8\"\â#€ª','ulhjklhjkl','',5,NULL,'2022-06-29 14:26:34',NULL),(_binary 'm%³!\ö¸ì«ª8\"\â#€ª','sfd','',5,NULL,'2022-06-28 16:00:50',NULL),(_binary 'mı\ö\ä\ö¸ì«ª8\"\â#€ª','sfd','',5,NULL,'2022-06-28 16:00:52',NULL),(_binary 'n\ó§\÷t\ì’P8\"\â#€ª','ulhjklhjkl','',5,NULL,'2022-06-29 14:26:37',NULL),(_binary 'pT\n\÷t\ì’P8\"\â#€ª','ulhjklhjkl','',5,NULL,'2022-06-29 14:26:40',NULL),(_binary 'pLm¯\ö¸ì«ª8\"\â#€ª','sfd','sdfsadfasdf',5,NULL,'2022-06-28 16:00:56',NULL),(_binary 's\à\Ö\Éû|\ì³8\"\â#€ª','jukljk','',5,NULL,'2022-07-04 17:34:08','2022-07-04 17:34:26'),(_binary 't\í‹\÷t\ì’P8\"\â#€ª','ulhjklhjkl','',5,NULL,'2022-06-29 14:26:47',NULL),(_binary 'tM\Ï8©\Ë\ì™(8\"\â#€ª','second booking settings test 3/22','',5,NULL,'2022-03-22 18:33:03','2022-03-23 08:49:23'),(_binary 'u\áœ\÷V\ì’P8\"\â#€ª','fgsd','',5,NULL,'2022-06-29 10:52:05',NULL),(_binary 'vH\ó¥‚ú\ì­\Z8\"\â#€ª','condition test','',4,NULL,'2022-02-01 09:01:17','2022-02-02 09:03:42'),(_binary 'vsƒsø\ì¢ 8\"\â#€ª','new test','',5,NULL,'2022-06-30 09:10:42',NULL),(_binary 'w?A\",\Óì–½8\"\â#€ª','test test','null',1,NULL,'2021-10-14 17:45:29',NULL),(_binary 'x­nº®L\ì™(8\"\â#€ª','free test','',5,NULL,'2022-03-28 12:06:40','2022-03-28 12:07:17'),(_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª','Vocal Lessons','Learn to sing, dude.',5,NULL,'2022-05-10 17:13:38','2022-05-11 17:41:28'),(_binary 'zA=®I\ì™(8\"\â#€ª','zero','',5,NULL,'2022-03-28 11:45:15',NULL),(_binary '|Œ˜\÷o\ì’P8\"\â#€ª','s','Here\'s a description for s.',5,NULL,'2022-06-29 13:51:14',NULL),(_binary '€A„ü\Ê\ì¾\È8\"\â#€ª','ouiouio','',5,NULL,'2022-07-06 09:25:20',NULL),(_binary 'ƒ,\ñÀm\Í\ì°	8\"\â#€ª','yo','dgf',4,NULL,'2022-01-05 10:16:37',NULL),(_binary 'ƒĞ™Un\ì°	8\"\â#€ª','Ethan\'s test item','dsfkldsfklijdsfkijlsdfkildfsgkilsdfgakiljdfskilfdsakijlfgdsakijlgfsdakjilfgsdakijlfgsdakijlfdgakilg',4,NULL,'2022-01-05 17:11:49','2022-02-19 14:02:07'),(_binary '†\ÙN\×\÷t\ì’P8\"\â#€ª','Online English tutoring','',5,NULL,'2022-06-29 14:27:19',NULL),(_binary '‰	\É\Üt(\ì•D8\"\â#€ª','Test Price Item','',4,NULL,'2022-01-13 12:23:18',NULL),(_binary '‰\âs\÷S\"ì¾¯8\"\â#€ª','test item w/2-line description','line one\nline two',4,NULL,'2021-12-02 11:47:14',NULL),(_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','Stevetest3','',1,NULL,'2022-04-04 11:15:58','2022-04-04 11:17:05'),(_binary 'š\\\÷t\ì’P8\"\â#€ª','Online English tutoring','',5,NULL,'2022-06-29 14:27:30',NULL),(_binary '~©Á\÷t\ì’P8\"\â#€ª','Online English tutoring','',5,NULL,'2022-06-29 14:27:33',NULL),(_binary '•K|Á!ìŒ˜8\"\â#€ª','Joel','\'Sup?',1,NULL,'2022-04-21 11:17:32','2022-04-21 17:33:53'),(_binary '•}šü\È\ì¾\È8\"\â#€ª','uoiuio','',5,NULL,'2022-07-06 09:11:37',NULL),(_binary '–I\ô¿ü\È\ì¾\È8\"\â#€ª','uoiuio','',5,NULL,'2022-07-06 09:11:38',NULL),(_binary '–\í\Ôü\È\ì¾\È8\"\â#€ª','uoiuio','',5,NULL,'2022-07-06 09:11:39',NULL),(_binary '—˜\âUü\È\ì¾\È8\"\â#€ª','uoiuio','',5,NULL,'2022-07-06 09:11:40',NULL),(_binary '˜Lbü\È\ì¾\È8\"\â#€ª','uoiuio','',5,NULL,'2022-07-06 09:11:42',NULL),(_binary '˜T\å\÷t\ì’P8\"\â#€ª','Online English tutoring','Learn English online, beeyatch.',5,NULL,'2022-06-29 14:27:48',NULL),(_binary '™ÖEû|\ì³8\"\â#€ª','hjk,.hjk.','glghl,gh,n,jkl',5,NULL,'2022-07-04 17:35:11','2022-07-04 17:37:36'),(_binary 'šN(m\Í\ì°	8\"\â#€ª','hey','hi',4,NULL,'2022-01-05 10:17:16',NULL),(_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª','third test item 1-14 w/price, image & condition','Here\'s a description.',4,NULL,'2022-01-14 11:11:01','2022-01-18 08:11:02'),(_binary 'š\'r\ŞQ–ì¾¯8\"\â#€ª','A test post with no description and one image','',3,NULL,'2021-11-30 12:33:01','2022-02-19 13:47:40'),(_binary '››•!R<ì¾¯8\"\â#€ª','New Item','',4,NULL,'2021-12-01 08:21:20',NULL),(_binary 'œ%™\÷t\ì’P8\"\â#€ª','Online English tutoring','Learn English online, beeyatch.',5,NULL,'2022-06-29 14:27:54',NULL),(_binary 'ŸŒ#\÷t\ì’P8\"\â#€ª','Online English tutoring','Learn English online, beeyatch.',5,NULL,'2022-06-29 14:27:59',NULL),(_binary ' IÉ®L\ì™(8\"\â#€ª','free test2','',5,NULL,'2022-03-28 12:07:47',NULL),(_binary '¢t\ñt\Õì–½8\"\â#€ª','Steve DeLollis','This is a sample bio. Blah blah blah. Also, blah blah blah and more stuff lasdkfjl;ksajf jas;ldkfj  sadlfkjsaldfjlk sdalkfjalsdkf lksadf lkjsadf lksdjflkasdjf  aslkdfj aslkdjf aslkdf aslkdjf lksadj flkasdjflkasjd fklasdfklasdjf klsad fs adflk sadfkjsadf sdlfjlksadf\n\nParagrah 2 Furthermore, blah blah blah\n\nParagrah 3 Also,\nI shall write yet more so that we can view the layout in the view section.\n\nThis is content added in Profile edit.\n\nThree line breaks here:\n\n\n\nblahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',1,NULL,'2021-09-24 09:20:42','2022-06-13 10:22:23'),(_binary '¤4`¿\÷o\ì’P8\"\â#€ª','Here\'s a Service With a Rather Long Name for Testing Layouts','',5,NULL,'2022-06-29 13:52:20',NULL),(_binary '§0†qø\ì¢ 8\"\â#€ª','Thu 5','',5,NULL,'2022-06-30 09:55:01',NULL),(_binary '¨\÷¾@\÷o\ì’P8\"\â#€ª','Here\'s a Service With a Rather Long Name for Testing Layouts','',5,NULL,'2022-06-29 13:52:28',NULL),(_binary 'ªPC®t\ì™(8\"\â#€ª','service test 3/28','Here\'s a description alksdjfklas sakldfj sakdj flkasjd flkasjd flkasjhdflkas dflkasjhd flkjas dfl;kjsadf\nalskdf \n\naslkd fh;laskjdflkj\naskldfl;kas dflk\n;laksdfhlksa',5,NULL,'2022-03-28 16:54:23',NULL),(_binary 'ªB\í¿\÷o\ì’P8\"\â#€ª','Here\'s a Service With a Rather Long Name for Testing Layouts','',5,NULL,'2022-06-29 13:52:31',NULL),(_binary 'ª‡‘®D\ì™(8\"\â#€ª','another test','sdhgfsdgfdsfg',5,NULL,'2022-03-28 11:10:48',NULL),(_binary '­\Ğ\Ä0\÷y\ì’P8\"\â#€ª','fgffh','',5,NULL,'2022-06-29 15:04:12',NULL),(_binary '®VB\Ü\ì¶Á8\"\â#€ª','service w/no min time block, qty=3','',5,NULL,'2022-05-25 17:40:15',NULL),(_binary '¯Ê­)¹…\ì™(8\"\â#€ª','Guitar lessons','Learn to shred, dude.',5,NULL,'2022-04-11 18:53:57','2022-04-22 10:15:18'),(_binary '±W_ı\Ô\ì„8\"\â#€ª','newer test service','',5,NULL,'2022-07-07 17:10:49','2022-07-07 17:10:57'),(_binary '±F\ñ¨·\ì™(8\"\â#€ª','booking settings test 2','',5,NULL,'2022-03-21 09:39:05',NULL),(_binary '²´\04\öšì«ª8\"\â#€ª','new service again','',5,NULL,'2022-06-28 12:28:02',NULL),(_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','Jill Holmes','',1,NULL,'2022-05-02 11:33:57',NULL),(_binary '³‰‰\÷o\ì’P8\"\â#€ª','Here\'s a Service With a Rather Long Name for Testing Layouts','Description for service with a long name.',5,NULL,'2022-06-29 13:52:46',NULL),(_binary '´M{²ø\ì¢ 8\"\â#€ª','fgjhgj','',5,NULL,'2022-06-30 09:12:26',NULL),(_binary '¶¬8)ù\ì‚Q8\"\â#€ª','fgh','',5,NULL,'2022-07-01 16:42:17',NULL),(_binary '¹\ã\ğ\ÛQ—ì¾¯8\"\â#€ª','A test post with no description and two images','',3,NULL,'2021-11-30 12:41:04',NULL),(_binary '»’\în¾ùìŒ˜8\"\â#€ª','English tutoring','Online English classes',5,NULL,'2022-04-18 17:27:14',NULL),(_binary '»\ĞE\÷\÷l\ì’P8\"\â#€ª','ghjk','',5,NULL,'2022-06-29 13:31:32',NULL),(_binary '½%Nw®~\ì™(8\"\â#€ª','test service 3/28','',5,NULL,'2022-03-28 18:06:30',NULL),(_binary '¾—\Ä\ó\÷r\ì’P8\"\â#€ª','test','',5,NULL,'2022-06-29 14:14:33',NULL),(_binary 'ÀiQ\÷s\ì’P8\"\â#€ª','ulhjklhjkl','',5,NULL,'2022-06-29 14:21:46',NULL),(_binary 'Á¢:»\á\ì§b8\"\â#€ª','SteveTestWithAVeryLongName','',1,NULL,'2022-04-14 18:58:02','2022-04-14 18:58:54'),(_binary 'Áƒ\n\ö–ì«ª8\"\â#€ª','New Service','',5,NULL,'2022-06-28 11:59:49',NULL),(_binary 'Á\â\õ\Üù\ì‚Q8\"\â#€ª','hjkhkjhkj','khjkghjkghjkghjk',5,NULL,'2022-07-01 16:35:26','2022-07-01 16:40:25'),(_binary 'Âx\÷x\ì’P8\"\â#€ª','seg','',5,NULL,'2022-06-29 14:57:37',NULL),(_binary '\Â\í‚ú\ì­\Z8\"\â#€ª','new','',4,NULL,'2022-02-01 09:03:26',NULL),(_binary '\Ã\Ò\Ù\÷o\ì’P8\"\â#€ª','Here\'s a Service With a Rather Long Name for Testing Layouts','Description for service with a long name.',5,NULL,'2022-06-29 13:53:14',NULL),(_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','SteveTest','',1,NULL,'2022-03-09 17:32:00','2022-06-10 11:52:39'),(_binary '\Æ\Ò\İü\Ç\ì¾\È8\"\â#€ª','jhjkghjk','',5,NULL,'2022-07-06 09:05:50','2022-07-06 09:05:56'),(_binary '\Ç9h¡]B\ìª\á8\"\â#€ª','Test Test','Test123',1,NULL,'2021-12-15 09:03:13','2021-12-15 09:10:41'),(_binary '\É\ÛÓ¿\÷x\ì’P8\"\â#€ª','seg','',5,NULL,'2022-06-29 14:57:49',NULL),(_binary '\Ë\ï@ü\É\ì¾\È8\"\â#€ª','kljkjkl','',5,NULL,'2022-07-06 09:20:18',NULL),(_binary '\Ì\Z\æ®C\ì™(8\"\â#€ª','Test','Test',5,NULL,'2022-03-28 11:04:35',NULL),(_binary '\ÌÒŸd\÷j\ì’P8\"\â#€ª','','',5,NULL,'2022-06-29 13:17:41',NULL),(_binary '\Ì\Ş\\vü\É\ì¾\È8\"\â#€ª','kljkjkl','',5,NULL,'2022-07-06 09:20:19',NULL),(_binary '\Í`\äƒü\É\ì¾\È8\"\â#€ª','kljkjkl','',5,NULL,'2022-07-06 09:20:20',NULL),(_binary '\Ís*:\÷y\ì’P8\"\â#€ª','fgffh','',5,NULL,'2022-06-29 15:05:05',NULL),(_binary '\Î\Ä\Âü\É\ì¾\È8\"\â#€ª','kljkjkl','',5,NULL,'2022-07-06 09:20:21',NULL),(_binary 'Î¢u·\÷y\ì’P8\"\â#€ª','fgffh','',5,NULL,'2022-06-29 15:05:07',NULL),(_binary '\Îìœ«ü\É\ì¾\È8\"\â#€ª','kljkjkl','',5,NULL,'2022-07-06 09:20:23',NULL),(_binary '\Ğ\÷\õû7\ì³8\"\â#€ª','jkjhkl','',5,NULL,'2022-07-04 09:22:47','2022-07-04 09:24:55'),(_binary '\ÑH@‚ü\É\ì¾\È8\"\â#€ª','kljkjkl','',5,NULL,'2022-07-06 09:20:27',NULL),(_binary 'Ô‡²Pn\ì°	8\"\â#€ª','Medium length title: price, pic, & links','short description',4,NULL,'2022-01-05 16:52:36',NULL),(_binary '\Õ¹/m\Í\ì°	8\"\â#€ª','yo','dgf',4,NULL,'2022-01-05 10:18:55',NULL),(_binary '\ÕH\ß\÷o\ì’P8\"\â#€ª','Here\'s a Service With a Rather Long Name for Testing Layouts','Description for service with a long name.',5,NULL,'2022-06-29 13:53:43',NULL),(_binary 'Õ½².\Ì(ìŒ˜8\"\â#€ª','test','',1,NULL,'2022-05-05 12:07:09',NULL),(_binary 'Ø¼ûUø@\ì¢ 8\"\â#€ª','Thu 12','asasdfgsdfgsdfgsdfgsdfg',5,NULL,'2022-06-30 14:49:53','2022-06-30 14:50:02'),(_binary '\Ú5#\Ã\ö“ì«ª8\"\â#€ª','test title','',5,NULL,'2022-06-28 11:39:02',NULL),(_binary '\Û\Ãpû{\ì³8\"\â#€ª','hhj','',5,NULL,'2022-07-04 17:29:52','2022-07-04 17:30:11'),(_binary '\ÜZ®x\ì™(8\"\â#€ª','service flat fee test','',5,NULL,'2022-03-28 17:24:25','2022-03-28 17:25:35'),(_binary '\ßTd5\÷V\ì’P8\"\â#€ª','sdfgsg','',5,NULL,'2022-06-29 10:55:02',NULL),(_binary '\ß\Ç\õ®C\ì™(8\"\â#€ª','test','test',5,NULL,'2022-03-28 11:05:08',NULL),(_binary '\à°It\ä\ì•D8\"\â#€ª','test 1-14 w/price','',4,NULL,'2022-01-14 10:51:31',NULL),(_binary '\âx€-ü\Ê\ì¾\È8\"\â#€ª','wqwqewer','',5,NULL,'2022-07-06 09:28:05',NULL),(_binary '\ã\'+¥n\ì°	8\"\â#€ª','An item with a long title, description, and price, and some images and linked content','asdfdfdfs dg\nsdfgdfgkdgf\ndfg\nsdfg\ndgkd8fsg7dsf8glsd7yfglk8dsjflkgyujdslkfiugjlsdk7yjvglk7dsjfg7lkhsjdlkjtlgfkjusdl67lsktgjlf7ks6jvrsld;fkbdvtfr78as6jv owe6f7poweavxf5r76v\n5rjfs\'ajf\n\nsadfjasdfjasdjfasjfd\nsjfgu7h6saifjd7vas5kl7klas576vfpo75jweaporf7jw7ep6oiajf76tpow76tefpotjwtfjbt6fubtugtugtbi87b87ibu8u7jby7uvtf',4,NULL,'2022-01-05 17:21:39',NULL),(_binary '\åW\0´ù\ì‚Q8\"\â#€ª','Yy','',5,NULL,'2022-07-01 16:57:54','2022-07-01 16:58:57'),(_binary '\ç1e>şZì¶8\"\â#€ª','Fri 1 updated title hhhhwwwwhhhhhhhhhhhhhhhhhhhhhhhhhhhhh','',5,NULL,'2022-07-08 09:11:32','2022-07-08 18:56:10'),(_binary '\çFBø\ì¢ 8\"\â#€ª','Thu 8','Test',5,NULL,'2022-06-30 10:03:58','2022-06-30 10:04:18'),(_binary '\çÒ“|¯\ì™(8\"\â#€ª','Drum Tuning Tutorial','asdfsg\nsf\nsadf\nsf\nsdf\nsadf\nsadf\nsdf\nsadfdfsadfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',5,NULL,'2022-03-29 11:39:58','2022-04-08 11:46:09'),(_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','Carson Holmes','',1,NULL,'2022-05-02 11:28:16',NULL),(_binary '\è\ä\Ú	\ö°ì«ª8\"\â#€ª','blah','\'sup?',5,NULL,'2022-06-28 15:07:02',NULL),(_binary '\è\ö\÷x\ì’P8\"\â#€ª','fgffh','',5,NULL,'2022-06-29 14:58:41',NULL),(_binary '\é\Ê\î\÷j\ì’P8\"\â#€ª','dhgdfgh','',5,NULL,'2022-06-29 13:18:29',NULL),(_binary '\îø\0\nS ì¾¯8\"\â#€ª','test post w/long desc, 1 image, no links','asdfgasdf\nasdf\nsdfasdf\n\n\nasdfasdf\nasdf\n\nasdfasdf\nasdf\nasdf\nasdf',3,NULL,'2021-12-02 11:35:45',NULL),(_binary '\ïV\óšü\×\ì¾\È8\"\â#€ª','vbbvnmvbmnbvmnvbm','',5,NULL,'2022-07-06 11:01:30',NULL),(_binary '\ñ¸-\ßS#ì¾¯8\"\â#€ª','test item w/4-line desc','one\ntwo\n\nfour',4,NULL,'2021-12-02 11:57:18',NULL),(_binary 'ò¦»m\Ö\ì°	8\"\â#€ª','short title','long price',4,NULL,'2022-01-05 11:24:10',NULL),(_binary '\ô\äüüw\ò\ì­\Z8\"\â#€ª','New Item','',4,NULL,'2022-01-18 08:09:51',NULL),(_binary '\÷Æš®D\ì™(8\"\â#€ª','rate test','',5,NULL,'2022-03-28 11:12:57',NULL),(_binary 'ùw\Ê\Ğn\ì°	8\"\â#€ª','Medium length title: price, pic, & links','Ladies & gentlemen, Carson Holmes on the drums!',4,NULL,'2022-01-05 16:53:38',NULL),(_binary 'úš\á\áø\ì¢ 8\"\â#€ª','Thurs 2','lsahglashgflasdf;l',5,NULL,'2022-06-30 09:35:52','2022-06-30 09:36:04'),(_binary 'û‰\òK\÷y\ì’P8\"\â#€ª','fgffh','',5,NULL,'2022-06-29 15:06:22',NULL),(_binary 'ü–ø \öšì«ª8\"\â#€ª','new service again','',5,NULL,'2022-06-28 12:30:06',NULL),(_binary 'şV\\*\ö­ì«ª8\"\â#€ª','test service','',5,NULL,'2022-06-28 14:46:09',NULL),(_binary 'ş\ìtš\÷j\ì’P8\"\â#€ª','uilhulj','',5,NULL,'2022-06-29 13:19:05',NULL);
/*!40000 ALTER TABLE `entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity-attribute`
--

DROP TABLE IF EXISTS `entity-attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity-attribute` (
  `idEntity` binary(16) NOT NULL,
  `idAttribute` int unsigned NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  `dtCreated` datetime DEFAULT NULL,
  `dtLastEdited` datetime DEFAULT NULL,
  KEY `fkEntityEA_idx` (`idEntity`),
  KEY `fkAttributeEA_idx` (`idAttribute`),
  CONSTRAINT `fkAttributeEA` FOREIGN KEY (`idAttribute`) REFERENCES `attribute` (`idAttribute`),
  CONSTRAINT `fkEntityEA` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity-attribute`
--

LOCK TABLES `entity-attribute` WRITE;
/*!40000 ALTER TABLE `entity-attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity-attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity-category`
--

DROP TABLE IF EXISTS `entity-category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity-category` (
  `idEntity` binary(16) NOT NULL,
  `idCategory` int unsigned NOT NULL,
  `dtCreated` datetime NOT NULL,
  KEY `fkEntityEC_idx` (`idEntity`),
  KEY `fkCategoryEC_idx` (`idCategory`),
  CONSTRAINT `fkCategoryEC` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`),
  CONSTRAINT `fkEntityEC` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity-category`
--

LOCK TABLES `entity-category` WRITE;
/*!40000 ALTER TABLE `entity-category` DISABLE KEYS */;
INSERT INTO `entity-category` VALUES (_binary '¯Ê­)¹…\ì™(8\"\â#€ª',118,'2022-04-22 10:15:18');
/*!40000 ALTER TABLE `entity-category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity-media`
--

DROP TABLE IF EXISTS `entity-media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity-media` (
  `idMedia` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idEntity` binary(16) NOT NULL,
  `idUser` binary(16) NOT NULL,
  `mediaType` int unsigned NOT NULL,
  `fileName` varchar(50) NOT NULL,
  `dtCreated` datetime NOT NULL,
  `sortOrder` int NOT NULL,
  `xOffset` float DEFAULT '0',
  `yOffset` float DEFAULT '0',
  `scale` float DEFAULT '1',
  PRIMARY KEY (`idMedia`),
  KEY `fkEntityEM_idx` (`idEntity`),
  CONSTRAINT `fkEntityEM` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity-media`
--

LOCK TABLES `entity-media` WRITE;
/*!40000 ALTER TABLE `entity-media` DISABLE KEYS */;
INSERT INTO `entity-media` VALUES (39,_binary 'š\'r\ŞQ–ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'83d2a432736c17c64f3a427d1d50e073.jpg','2021-11-30 12:33:01',1,-89.5412,0,1),(40,_binary '¹\ã\ğ\ÛQ—ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'babb8f7f514d219bccc0f51ce8bda385.jpg','2021-11-30 12:41:04',2,-175,0,1),(41,_binary '¹\ã\ğ\ÛQ—ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'1fcee509d3467de89f70bd7eb97577db.jpg','2021-11-30 12:41:04',1,-67.3077,0,1),(42,_binary 'O³\ôQ˜ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'24cc55d5cb64ccc8fe33db653dd8aa7b.jpg','2021-11-30 12:45:15',1,-105,0,1),(45,_binary ' ³’oQ\Äì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'93902cc51460ca951a6757739445a389.jpg','2021-11-30 17:58:54',2,-58.3333,0,1),(46,_binary ' ³’oQ\Äì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'600356b6416686a7465097f4447935a7.jpg','2021-11-30 17:58:54',1,-58.3333,0,1),(52,_binary '$LfR<ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'b9d445b951ad0cb29ce1887982fd65c2.jpg','2021-12-01 08:17:59',1,-42.2414,0,1),(57,_binary '\îø\0\nS ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'04a631b27eb22f12d4aff13606d83c92.jpg','2021-12-02 11:35:45',1,-50,0,1),(58,_binary '\÷S!ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'676c6b2762c4c71550d3a42af4c7e0e7.jpg','2021-12-02 11:36:52',1,-42.2414,0,1),(62,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'7e356f49ed71a3751868d9630d525f44.jpg','2021-12-07 08:31:43',53,-154.12,-36.75,1.21),(71,_binary '\è úh®\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'3a0f773e71cb3c7b9616a3d6e493f132.JPG','2021-12-29 21:48:34',1,-58.3333,0,1),(72,_binary 'hPDm!\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'e3dc147c5ca3de4709bb4e5e3570e0ec.jpg','2022-01-04 13:44:39',1,0,-58.3333,1),(73,_binary 'd\×úm$\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'39da4a893353d2f2e9e9f412f7712837.JPG','2022-01-04 14:06:02',1,-58.3333,0,1),(74,_binary '\rºO\òm\à\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'8c6c07d386160be350c248eb01d28fa4.JPG','2022-01-05 12:29:21',1,-58.3333,0,1),(75,_binary 'Ô‡²Pn\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'f0b02bb867fdb89dda1b54a3c759bd94.JPG','2022-01-05 16:52:36',1,-58.3333,0,1),(76,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'2a312e01618b9bf90d50ebc8b0bf94dc.jpg','2022-01-05 17:11:49',1,0,-58.3333,1),(77,_binary '\ã\'+¥n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'a9468ce809b765840f26e28be5265352.JPG','2022-01-05 17:21:39',1,0,-38.3333,1),(78,_binary '\ã\'+¥n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'c488395aa91fdcb5e5221db4d98ae013.jpg','2022-01-05 17:21:39',2,-38.3333,0,1),(79,_binary 'L‚Át(\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'bd29e083ca0f38a45091a4e2df46d59e.jpg','2022-01-13 12:21:37',1,0,-58.3333,1),(80,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'2f8890810c762edaca09026131eef065.jpg','2022-01-14 11:07:08',1,-58.3333,0,1),(81,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'71bcec9618b51f0affea0ceb7dd5e1b9.jpg','2022-01-14 11:11:01',1,0,-58.3333,1),(82,_binary '1©59‚5\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'07ff8be9809aaf999e9cf02ec63d4d5a.JPG','2022-01-31 09:29:11',2,0,-58.3333,1),(83,_binary '1©59‚5\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'c2400cbb33e1b62feb40fe2ca8343d39.jpg','2022-01-31 09:29:11',1,0,-58.3333,1),(84,_binary '\ZVP‚7\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'8d39ab096d84490728b16c5de78f76a3.JPG','2022-01-31 09:42:51',1,-275.4,-160.2,2.59374),(85,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'9f3c1136e14d8b8e297f2e5bfb8c5509.JPG','2022-02-01 09:06:47',1,-1485.85,-1008.38,8.14029),(86,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'859ace26b94f92a4755d906865f2e3ac.jpg','2022-02-17 08:26:05',2,0,-58.3333,1),(87,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'b911b360665356e8c9b1445122150084.jpg','2022-02-17 08:26:05',4,-76.2,-129.4,1.4641),(97,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'81bcd1ba5be1b40bf4eeb3e4ea2b4fd8.JPG','2022-02-19 14:02:07',2,-36.75,-630.376,3.45227),(102,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'4781344355732c2f83f5d5f223b0882b.jpg','2022-02-23 08:32:57',11,-87.5,0,1),(109,_binary 'K.0ı¤8\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'18779eb7bc886602cc58756a8066cf70.jpg','2022-03-15 16:17:02',1,-58.3333,0,1),(110,_binary 'K.0ı¤8\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'55e1c9fab00bde941299241aa6d9e2d0.jpg','2022-03-15 16:17:02',2,0,-58.3333,1),(114,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'907128f296e765502d153fd832474810.jpg','2022-03-16 10:09:11',6,-58.3333,0,1),(115,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'9d3eb7f9a17f33094417bbf488d3a50d.JPG','2022-03-16 10:09:11',3,-189.6,-82.2,1.4641),(116,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'780dfb616642dc65b182ddd413283e0c.JPG','2022-03-16 10:09:11',19,-58.3333,0,1),(119,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'28ea4f4e6cd08cb20ae165ade67f54a4.jpg','2022-03-16 10:12:13',7,0,0,1),(123,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',15,'b270c42db5eb5a676416b0f69b95869d.jpg','2022-03-17 11:17:24',1,-386.2,-120.6,2.35795),(126,_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'99a988c6189f0c3ae2215580255782fd.jpg','2022-03-29 09:28:19',1,-58.3333,0,1),(127,_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'4e7481fc7113afdb5d59c407c9c400ce.jpg','2022-03-29 09:28:53',2,-58.3333,0,1),(129,_binary '\çÒ“|¯\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'d71e4d681266c5de9f6141666ac9d161.jpg','2022-03-29 17:23:17',3,-58.3333,0,1),(130,_binary '\çÒ“|¯\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'bb9b38010567e35b55555810dffe9eb9.jpg','2022-03-29 17:23:17',2,-58.3333,0,1),(131,_binary '´uk±Q\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª',15,'87aa12553f30e965eaa4b7fe8088d852.jpg','2022-04-01 08:21:41',1,-111.8,0,1),(132,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',15,'ff06faa34c2c0b8ed7bae9109f8a13f0.JPG','2022-04-04 11:23:46',1,0,-34.2,1),(136,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª',15,'40b876b4ec13627d0df27a5ba13312f5.jpg','2022-04-14 18:59:51',1,0,0,1),(139,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª',15,'f745e26670b5b6e1ac91a859003e1d28.jpg','2022-04-23 15:18:54',1,0,-58.3333,1),(140,_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'10b43bd456024230c079ad21de449cbe.JPG','2022-05-10 17:13:38',1,-58.3333,0,1),(144,_binary 'Á\â\õ\Üù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'1deaadb9a20403388f6d9ef94789e181.jpg','2022-07-01 16:35:49',1,0,-58.2018,1),(145,_binary '\ç1e>şZì¶8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'838821b53b84995d1a6d58db935ea154.JPG','2022-07-08 10:23:02',1,0,-57.5,1),(146,_binary '\ç1e>şZì¶8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'303b5a9d8c886963f39c57bb19f66b7b.jpg','2022-07-08 10:25:54',2,-58.3333,0,1),(147,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'6773951197ec55d5c24601388af193b1.JPG','2022-07-08 10:36:47',2,-419,0,1.94872),(148,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',15,'90514397024357b3611e701b9716eac0.jpg','2022-07-08 11:15:34',1,-198.4,0,1.61051);
/*!40000 ALTER TABLE `entity-media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity-relate`
--

DROP TABLE IF EXISTS `entity-relate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity-relate` (
  `idEntity` binary(16) NOT NULL,
  `idRelated` binary(16) NOT NULL,
  `relateType` int NOT NULL,
  PRIMARY KEY (`idEntity`,`idRelated`,`relateType`),
  KEY `fkEntityET2` (`idRelated`),
  CONSTRAINT `fkEntityET` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkEntityET2` FOREIGN KEY (`idRelated`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity-relate`
--

LOCK TABLES `entity-relate` WRITE;
/*!40000 ALTER TABLE `entity-relate` DISABLE KEYS */;
INSERT INTO `entity-relate` VALUES (_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '\Şj¬ &ì§…8\"\â#€ª',2),(_binary 'd\×úm$\ì°	8\"\â#€ª',_binary '\è úh®\ì°	8\"\â#€ª',2),(_binary 'j³\ğ~n‡\ì°	8\"\â#€ª',_binary '\è úh®\ì°	8\"\â#€ª',2),(_binary 'Ô‡²Pn\ì°	8\"\â#€ª',_binary '\è úh®\ì°	8\"\â#€ª',2),(_binary '\ã\'+¥n\ì°	8\"\â#€ª',_binary '\è úh®\ì°	8\"\â#€ª',2),(_binary 'ùw\Ê\Ğn\ì°	8\"\â#€ª',_binary '\è úh®\ì°	8\"\â#€ª',2),(_binary ' ³’oQ\Äì¾¯8\"\â#€ª',_binary 'lŒ>Q®ì¾¯8\"\â#€ª',2),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '\r\ÆS-ª‚\ì™(8\"\â#€ª',2),(_binary '\çÒ“|¯\ì™(8\"\â#€ª',_binary '\r\ÆS-ª‚\ì™(8\"\â#€ª',2),(_binary 'hPDm!\ì°	8\"\â#€ª',_binary '\÷S!ì¾¯8\"\â#€ª',2),(_binary 'K.0ı¤8\ì™(8\"\â#€ª',_binary '\ZVP‚7\ì­\Z8\"\â#€ª',2),(_binary '\è úh®\ì°	8\"\â#€ª',_binary ' ³’oQ\Äì¾¯8\"\â#€ª',2),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '3ªoÁ®{\ì™(8\"\â#€ª',2),(_binary 'K.0ı¤8\ì™(8\"\â#€ª',_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',2),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',2),(_binary '\çÒ“|¯\ì™(8\"\â#€ª',_binary 'K.0ı¤8\ì™(8\"\â#€ª',2),(_binary 'Ô‡²Pn\ì°	8\"\â#€ª',_binary 'R`\ÑUm\Í\ì°	8\"\â#€ª',2),(_binary 'ùw\Ê\Ğn\ì°	8\"\â#€ª',_binary 'R`\ÑUm\Í\ì°	8\"\â#€ª',2),(_binary 'd\×úm$\ì°	8\"\â#€ª',_binary 'w?A\",\Óì–½8\"\â#€ª',2),(_binary '$LfR<ì¾¯8\"\â#€ª',_binary 'š\'r\ŞQ–ì¾¯8\"\â#€ª',2),(_binary 'hPDm!\ì°	8\"\â#€ª',_binary '››•!R<ì¾¯8\"\â#€ª',2),(_binary '°I\óû;\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\è úh®\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\r7\ßS$ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\rºO\òm\à\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\r\ÆS-ª‚\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '²2kù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\÷S!ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\ZVP‚7\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary ' ¥r.l\õ\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary ' ³’oQ\Äì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '!TIü\Ğ\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '!9%—ûn\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '!=`Zû~\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '$LfR<ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '1©59‚5\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'K.0ı¤8\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'L‚Át(\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'N?Ê“ü-\ì™v8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'O³\ôQ˜ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'R)\ÇS$ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'R`\ÑUm\Í\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'V\Ä×¶û}\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'd\×úm$\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'hPDm!\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'j³\ğ~n‡\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'k6\Ét\Í\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 's\à\Ö\Éû|\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'vH\ó¥‚ú\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '€A„ü\Ê\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'ƒ,\ñÀm\Í\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'ƒĞ™Un\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '‰	\É\Üt(\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '‰\âs\÷S\"ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '•}šü\È\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '–I\ô¿ü\È\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '–\í\Ôü\È\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '—˜\âUü\È\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '˜Lbü\È\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '™ÖEû|\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'šN(m\Í\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'š\'r\ŞQ–ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '±W_ı\Ô\ì„8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '¶¬8)ù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '¹\ã\ğ\ÛQ—ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'Á\â\õ\Üù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Â\í‚ú\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Æ\Ò\İü\Ç\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Ë\ï@ü\É\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Í`\äƒü\É\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Îìœ«ü\É\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Ğ\÷\õû7\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'Ô‡²Pn\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\Û\Ãpû{\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\à°It\ä\ì•D8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\ã\'+¥n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\åW\0´ù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\ç1e>şZì¶8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\çÒ“|¯\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\îø\0\nS ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\ñ¸-\ßS#ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'ò¦»m\Ö\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary '\ô\äüüw\ò\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'ùw\Ê\Ğn\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª',1),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary 'ªPC®t\ì™(8\"\â#€ª',2),(_binary '\Şj¬ &ì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',1),(_binary '\è úh®\ì°	8\"\â#€ª',_binary '\Ç9h¡]B\ìª\á8\"\â#€ª',2),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '\ÜZ®x\ì™(8\"\â#€ª',2),(_binary 'K.0ı¤8\ì™(8\"\â#€ª',_binary '\îø\0\nS ì¾¯8\"\â#€ª',2),(_binary '\ã\'+¥n\ì°	8\"\â#€ª',_binary 'ò¦»m\Ö\ì°	8\"\â#€ª',2);
/*!40000 ALTER TABLE `entity-relate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `idEvent` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idEntity` binary(16) NOT NULL,
  `eventType` tinyint NOT NULL,
  `dtStart` datetime NOT NULL,
  `dtEnd` datetime DEFAULT NULL,
  `allDay` bit(1) NOT NULL,
  `repeatType` tinyint NOT NULL,
  `repeatTimeFrame` tinyint NOT NULL,
  `repeatMonthlyType` tinyint NOT NULL,
  `repeatInterval` smallint NOT NULL,
  `repeatSun` bit(1) NOT NULL,
  `repeatMon` bit(1) NOT NULL,
  `repeatTue` bit(1) NOT NULL,
  `repeatWed` bit(1) NOT NULL,
  `repeatThu` bit(1) NOT NULL,
  `repeatFri` bit(1) NOT NULL,
  `repeatSat` bit(1) NOT NULL,
  `repeatEndType` tinyint NOT NULL,
  `repeatEnd` datetime DEFAULT NULL,
  `repeatOccurences` smallint DEFAULT NULL,
  `allServices` bit(1) NOT NULL,
  PRIMARY KEY (`idEvent`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEvent`),
  KEY `fkEntityEvent` (`idEntity`),
  CONSTRAINT `fkEntityEvent` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB AUTO_INCREMENT=491 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (283,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-25 01:00:00','2022-05-25 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-24 16:00:00',10,_binary ''),(284,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-26 01:00:00','2022-05-26 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-25 16:00:00',10,_binary ''),(285,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-27 01:00:00','2022-05-27 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(294,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 04:00:00','2022-05-27 05:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(299,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-26 03:00:00','2022-05-26 04:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-26 04:00:00',10,_binary ''),(302,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 02:00:00','2022-05-25 04:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-25 04:00:00',10,_binary ''),(303,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 07:00:00','2022-05-25 08:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-24 16:00:00',10,_binary ''),(305,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 06:00:00','2022-05-27 07:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(306,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 08:00:00','2022-05-27 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(308,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-26 01:00:00','2022-05-26 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-25 16:00:00',10,_binary ''),(309,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 08:00:00','2022-05-25 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-25 09:00:00',10,_binary ''),(310,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-26 07:00:00','2022-05-26 08:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-26 08:00:00',10,_binary ''),(311,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 02:00:00','2022-05-27 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(312,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 04:00:00','2022-05-25 06:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-24 16:00:00',10,_binary ''),(313,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-26 05:00:00','2022-05-26 07:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-25 16:00:00',10,_binary ''),(314,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 06:00:00','2022-05-25 06:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-24 16:00:00',10,_binary ''),(315,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-26 04:00:00','2022-05-26 05:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-25 16:00:00',10,_binary ''),(316,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 01:30:00','2022-05-27 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(317,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 03:00:00','2022-05-27 04:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(318,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 01:00:00','2022-05-25 02:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-24 16:00:00',10,_binary ''),(319,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-25 06:30:00','2022-05-25 07:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-24 16:00:00',10,_binary ''),(320,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 04:00:00','2022-05-29 12:00:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-28 16:00:00',10,_binary '\0'),(325,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-30 01:00:00','2022-05-30 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary '\0'),(327,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-30 02:00:00','2022-05-30 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(330,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-30 03:00:00','2022-05-30 03:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(332,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-30 08:00:00','2022-05-30 08:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(335,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-30 03:30:00','2022-05-30 04:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(337,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-30 06:30:00','2022-05-30 07:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(338,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-29 06:00:00','2022-05-29 07:00:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 07:00:00',10,_binary ''),(340,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-26 01:30:00','2022-05-26 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-25 16:00:00',10,_binary ''),(341,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-01 00:00:00','2022-06-02 00:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-31 16:00:00',10,_binary ''),(344,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-01 17:00:00','2022-06-01 17:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-01 16:00:00',10,_binary ''),(345,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-01 18:00:00','2022-06-01 18:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-01 16:00:00',10,_binary ''),(346,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-01 17:00:00','2022-06-01 17:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-01 17:30:00',10,_binary ''),(347,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-01 00:00:00','2022-06-01 00:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-31 16:00:00',10,_binary ''),(349,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-10 14:00:00','2022-05-10 18:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-09 16:00:00',10,_binary ''),(351,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-04 16:00:00','2022-05-06 16:00:00',_binary '',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-04 16:00:00',10,_binary ''),(352,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-05 14:30:00','2022-05-05 19:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-04 16:00:00',10,_binary ''),(353,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-03 14:00:00','2022-05-03 18:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-02 16:00:00',10,_binary ''),(354,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 01:00:00','2022-05-27 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(355,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 01:30:00','2022-05-27 02:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(356,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 05:30:00','2022-05-27 06:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-26 16:00:00',10,_binary ''),(357,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 04:00:00','2022-05-28 04:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(358,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 10:15:00','2022-05-28 10:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(359,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 10:00:00','2022-05-28 10:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(360,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 11:00:00','2022-05-28 11:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(361,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 12:00:00','2022-05-28 12:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(362,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 01:00:00','2022-05-28 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(363,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 08:00:00','2022-05-28 08:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(364,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 06:45:00','2022-05-28 09:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(365,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-03 00:00:00','2022-06-03 00:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-02 16:00:00',10,_binary ''),(366,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-28 04:00:00','2022-05-28 04:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(367,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-28 10:15:00','2022-05-28 10:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(368,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-28 12:00:00','2022-05-28 12:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(369,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 02:45:00','2022-05-28 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(370,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-28 05:00:00','2022-05-28 05:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(371,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-27 23:45:00','2022-05-28 00:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(372,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-27 19:00:00','2022-05-27 19:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(373,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-04 05:00:00','2022-06-04 05:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-03 16:00:00',10,_binary ''),(374,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-04 14:00:00','2022-06-04 15:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-03 16:00:00',10,_binary ''),(375,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-04 08:00:00','2022-06-04 08:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-03 16:00:00',10,_binary ''),(377,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-04 05:00:00','2022-06-04 05:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-03 16:00:00',10,_binary ''),(378,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-04 05:00:00','2022-06-04 05:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-04 05:30:00',10,_binary ''),(379,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-28 11:00:00','2022-05-28 11:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-05-27 16:00:00',10,_binary ''),(380,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-30 07:00:00','2022-05-30 07:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(381,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-30 12:00:00','2022-05-30 12:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(382,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 21:00:00','2022-05-29 21:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(383,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 22:00:00','2022-05-29 22:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(384,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 17:00:00','2022-05-29 17:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(385,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 19:00:00','2022-05-29 19:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(386,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-30 00:00:00','2022-05-30 00:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(387,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 20:00:00','2022-05-29 20:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(388,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-30 10:00:00','2022-05-30 10:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(389,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-30 21:00:00','2022-05-30 21:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-30 16:00:00',10,_binary ''),(390,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-31 01:00:00','2022-05-31 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-30 16:00:00',10,_binary ''),(391,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 23:00:00','2022-05-29 23:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(392,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-29 23:30:00','2022-05-29 23:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-29 16:00:00',10,_binary ''),(393,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-31 00:00:00','2022-05-31 00:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-30 16:00:00',10,_binary ''),(394,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-31 03:00:00','2022-05-31 03:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-30 16:00:00',10,_binary ''),(395,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-31 04:00:00','2022-05-31 04:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-30 16:00:00',10,_binary ''),(396,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-03 02:00:00','2022-06-03 02:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-02 16:00:00',10,_binary ''),(397,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-02 20:00:00','2022-06-02 20:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-02 16:00:00',10,_binary ''),(398,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-02 20:15:00','2022-06-02 21:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-02 16:00:00',10,_binary ''),(399,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-02 19:00:00','2022-06-02 20:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-02 16:00:00',10,_binary ''),(400,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-04 01:15:00','2022-06-04 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-03 16:00:00',10,_binary ''),(401,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-04 14:00:00','2022-06-04 14:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',0,'2022-06-03 16:00:00',10,_binary ''),(402,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-24 03:00:00','2022-05-24 03:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-23 16:00:00',10,_binary ''),(403,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-24 11:00:00','2022-05-24 11:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-23 16:00:00',10,_binary ''),(404,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-12 01:00:00','2022-05-12 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-11 16:00:00',10,_binary ''),(405,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-13 01:00:00','2022-05-13 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-12 16:00:00',10,_binary ''),(406,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-12 02:00:00','2022-05-12 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-11 16:00:00',10,_binary ''),(408,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-12 02:00:00','2022-05-12 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-12 03:00:00',10,_binary ''),(409,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-12 04:00:00','2022-05-12 05:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-12 03:00:00',10,_binary ''),(410,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-12 02:00:00','2022-05-12 03:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-05-12 03:00:00',10,_binary ''),(411,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-13 01:00:00','2022-05-13 02:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-12 16:00:00',10,_binary ''),(412,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-04-30 16:00:00','2022-05-01 16:00:00',_binary '',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-04-30 16:00:00',10,_binary ''),(413,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-01 23:00:00','2022-05-02 02:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-01 16:00:00',10,_binary ''),(414,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-15 16:00:00','2022-05-15 16:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-15 16:00:00',10,_binary ''),(415,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-05-08 02:00:00','2022-05-08 02:15:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-07 16:00:00',10,_binary ''),(416,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 04:00:00','2022-06-05 04:15:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(417,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 19:15:00','2022-06-05 19:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(418,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 21:15:00','2022-06-05 21:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(421,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 01:00:00','2022-06-05 01:15:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(422,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 04:30:00','2022-06-05 06:45:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(423,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-07 12:00:00','2022-06-07 12:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-06 16:00:00',10,_binary ''),(424,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-07 05:00:00','2022-06-07 05:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-06 16:00:00',10,_binary ''),(425,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-07 10:00:00','2022-06-07 10:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-06 16:00:00',10,_binary ''),(426,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-08 01:00:00','2022-06-08 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-07 16:00:00',10,_binary ''),(427,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-09 02:00:00','2022-06-09 04:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-08 16:00:00',10,_binary ''),(429,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-09 05:15:00','2022-06-09 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-08 16:00:00',10,_binary ''),(430,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-08 22:00:00','2022-06-08 23:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-08 16:00:00',10,_binary ''),(431,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-09 00:00:00','2022-06-09 01:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-08 16:00:00',10,_binary ''),(432,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-14 04:00:00','2022-06-14 05:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-13 16:00:00',10,_binary ''),(433,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-13 01:00:00','2022-06-13 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '\0',0,'2022-06-12 16:00:00',10,_binary ''),(435,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-15 03:15:00','2022-06-15 05:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(436,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-15 07:00:00','2022-06-15 09:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(437,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-21 03:15:00','2022-06-21 07:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-20 16:00:00',10,_binary ''),(438,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-21 08:30:00','2022-06-21 11:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-20 16:00:00',10,_binary ''),(439,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-22 03:45:00','2022-06-22 06:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-21 16:00:00',10,_binary ''),(440,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-22 09:30:00','2022-06-22 12:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-21 16:00:00',10,_binary ''),(441,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-12 01:15:00','2022-06-12 01:45:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-11 16:00:00',10,_binary ''),(442,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-04 19:00:00','2022-06-04 19:30:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(443,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-04 23:00:00','2022-06-04 23:30:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(446,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-13 00:00:00','2022-06-13 00:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-12 16:00:00',10,_binary ''),(447,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-13 09:15:00','2022-06-13 10:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-12 16:00:00',10,_binary ''),(448,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-12 03:00:00','2022-06-12 04:15:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-11 16:00:00',10,_binary ''),(449,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-12 05:00:00','2022-06-12 06:00:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-11 16:00:00',10,_binary ''),(450,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-12 06:00:00','2022-06-12 07:00:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-11 16:00:00',10,_binary ''),(451,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-12 04:30:00','2022-06-12 05:00:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-11 16:00:00',10,_binary ''),(452,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 03:00:00','2022-06-05 04:00:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(453,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-05 06:45:00','2022-06-05 08:15:00',_binary '\0',0,2,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-04 16:00:00',10,_binary ''),(456,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-26 01:00:00','2022-06-26 09:00:00',_binary '\0',1,1,6,1,_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-25 16:00:00',10,_binary ''),(457,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-26 23:30:00','2022-06-27 00:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-26 16:00:00',10,_binary ''),(458,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-27 09:15:00','2022-06-27 11:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-26 16:00:00',10,_binary ''),(459,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-27 17:45:00','2022-06-27 21:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-27 16:00:00',10,_binary ''),(460,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-26 16:00:00','2022-06-26 22:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-26 16:00:00',10,_binary ''),(461,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-28 09:00:00','2022-06-28 15:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-27 16:00:00',10,_binary ''),(462,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-05 19:15:00','2022-06-05 19:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(463,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-05 19:15:00','2022-06-05 19:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(464,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-05 19:15:00','2022-06-05 19:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(465,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-05 19:15:00','2022-06-05 19:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(466,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-05 19:15:00','2022-06-05 19:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(467,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-05 19:15:00','2022-06-05 19:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-05 16:00:00',10,_binary ''),(471,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 01:00:00','2022-05-27 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-27 01:30:00',10,_binary ''),(472,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-27 01:00:00','2022-05-27 01:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-05-27 01:30:00',10,_binary ''),(473,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-08 22:00:00','2022-06-08 22:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-08 16:00:00',10,_binary ''),(474,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-09 00:00:00','2022-06-09 01:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-08 16:00:00',10,_binary ''),(476,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-17 11:00:00','2022-06-17 11:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-16 16:00:00',10,_binary ''),(477,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-17 00:00:00','2022-06-17 00:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-16 16:00:00',10,_binary ''),(478,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-15 00:00:00','2022-06-15 00:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(479,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-15 06:00:00','2022-06-15 06:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(480,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-23 01:00:00','2022-06-23 09:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-22 16:00:00',10,_binary ''),(481,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-16 05:00:00','2022-06-16 06:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-15 16:00:00',10,_binary ''),(482,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-06-17 03:00:00','2022-06-17 04:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',0,'2022-06-16 16:00:00',10,_binary ''),(483,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-15 04:00:00','2022-06-15 04:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(484,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-15 07:00:00','2022-06-15 07:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(485,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-15 09:00:00','2022-06-15 09:15:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(486,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-15 08:00:00','2022-06-15 08:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',0,'2022-06-14 16:00:00',10,_binary ''),(487,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-06-16 05:00:00','2022-06-16 05:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-06-15 16:00:00',10,_binary ''),(488,_binary '¢t\ñt\Õì–½8\"\â#€ª',3,'2022-05-01 23:00:00','2022-05-01 23:30:00',_binary '\0',0,2,6,1,_binary '\0',_binary '',_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,'2022-05-01 16:00:00',10,_binary ''),(489,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-07-20 18:30:00','2022-07-20 21:45:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-07-20 16:00:00',10,_binary ''),(490,_binary '¢t\ñt\Õì–½8\"\â#€ª',1,'2022-07-20 22:00:00','2022-07-20 23:00:00',_binary '\0',0,2,6,1,_binary '\0',_binary '\0',_binary '\0',_binary '\0',_binary '',_binary '\0',_binary '\0',0,'2022-07-20 16:00:00',10,_binary '');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event-chain-edit`
--

DROP TABLE IF EXISTS `event-chain-edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event-chain-edit` (
  `idEventChainEdit` int unsigned NOT NULL AUTO_INCREMENT,
  `idEvent` int unsigned NOT NULL,
  `editType` tinyint unsigned NOT NULL,
  `dtStart` datetime NOT NULL,
  `idNewEvent` int unsigned NOT NULL,
  PRIMARY KEY (`idEventChainEdit`),
  UNIQUE KEY `idEventChainEdit_UNIQUE` (`idEventChainEdit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event-chain-edit`
--

LOCK TABLES `event-chain-edit` WRITE;
/*!40000 ALTER TABLE `event-chain-edit` DISABLE KEYS */;
/*!40000 ALTER TABLE `event-chain-edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `idEntity` binary(16) NOT NULL,
  `groupType` int NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityGroup` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `idEntity` binary(16) NOT NULL,
  `condition` int NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityItem` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (_binary '\Şj¬ &ì§…8\"\â#€ª',0),(_binary '\è úh®\ì°	8\"\â#€ª',0),(_binary '\r7\ßS$ì¾¯8\"\â#€ª',0),(_binary '\rºO\òm\à\ì°	8\"\â#€ª',0),(_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',0),(_binary '\÷S!ì¾¯8\"\â#€ª',0),(_binary '\ZVP‚7\ì­\Z8\"\â#€ª',0),(_binary ' ¥r.l\õ\ì°	8\"\â#€ª',0),(_binary ' ³’oQ\Äì¾¯8\"\â#€ª',0),(_binary '$LfR<ì¾¯8\"\â#€ª',0),(_binary '1©59‚5\ì­\Z8\"\â#€ª',1001),(_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0),(_binary 'K.0ı¤8\ì™(8\"\â#€ª',0),(_binary 'L‚Át(\ì•D8\"\â#€ª',0),(_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',0),(_binary 'R)\ÇS$ì¾¯8\"\â#€ª',0),(_binary 'R`\ÑUm\Í\ì°	8\"\â#€ª',0),(_binary 'd\×úm$\ì°	8\"\â#€ª',0),(_binary 'hPDm!\ì°	8\"\â#€ª',0),(_binary 'j³\ğ~n‡\ì°	8\"\â#€ª',0),(_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0),(_binary 'vH\ó¥‚ú\ì­\Z8\"\â#€ª',1001),(_binary 'ƒ,\ñÀm\Í\ì°	8\"\â#€ª',0),(_binary 'ƒĞ™Un\ì°	8\"\â#€ª',1001),(_binary '‰	\É\Üt(\ì•D8\"\â#€ª',0),(_binary '‰\âs\÷S\"ì¾¯8\"\â#€ª',0),(_binary 'šN(m\Í\ì°	8\"\â#€ª',0),(_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1004),(_binary '››•!R<ì¾¯8\"\â#€ª',0),(_binary '\Â\í‚ú\ì­\Z8\"\â#€ª',1),(_binary 'Ô‡²Pn\ì°	8\"\â#€ª',1),(_binary '\à°It\ä\ì•D8\"\â#€ª',0),(_binary '\ã\'+¥n\ì°	8\"\â#€ª',0),(_binary '\ñ¸-\ßS#ì¾¯8\"\â#€ª',0),(_binary 'ò¦»m\Ö\ì°	8\"\â#€ª',0),(_binary '\ô\äüüw\ò\ì­\Z8\"\â#€ª',0),(_binary 'ùw\Ê\Ğn\ì°	8\"\â#€ª',0);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `idLocation` bigint unsigned NOT NULL AUTO_INCREMENT,
  `addressLine1` varchar(255) NOT NULL,
  `addressLine2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `idProvince` int unsigned NOT NULL,
  `idCountry` int unsigned NOT NULL,
  `postalCode` varchar(12) NOT NULL,
  PRIMARY KEY (`idLocation`),
  UNIQUE KEY `idLocation_UNIQUE` (`idLocation`),
  KEY `fkLocationProvince` (`idProvince`),
  KEY `fkLocationCountry` (`idCountry`),
  CONSTRAINT `fkLocationCountry` FOREIGN KEY (`idCountry`) REFERENCES `country` (`idCountry`),
  CONSTRAINT `fkLocationProvince` FOREIGN KEY (`idProvince`) REFERENCES `province` (`idProvince`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master-type`
--

DROP TABLE IF EXISTS `master-type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master-type` (
  `idMasterType` int NOT NULL AUTO_INCREMENT,
  `table` varchar(100) NOT NULL,
  `column` varchar(100) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMasterType`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master-type`
--

LOCK TABLES `master-type` WRITE;
/*!40000 ALTER TABLE `master-type` DISABLE KEYS */;
INSERT INTO `master-type` VALUES (1,'entity','entityType','user','1'),(2,'entity','entityType','media','2'),(3,'entity','entityType','post','3'),(4,'entity','entityType','person','4'),(5,'entity','entityType','item','5'),(6,'entity','entityType','service','6'),(7,'entity','entityType','event','7'),(8,'entity','entityType','place','8'),(9,'entity','entityType','group','9'),(10,'entity-relate','relateType','tagged in post','1'),(11,'entity-relate','relateType','owns','2'),(12,'entity-media','mediaType','bmp','bmp'),(13,'entity-media','mediaType','gif','gif'),(14,'entity-media','mediaType','jpeg','jpeg'),(15,'entity-media','mediaType','jpg','jpg'),(16,'entity-media','mediaType','png','png'),(17,'entity-media','mediaType','tiff','tiff'),(18,'entity-media','mediaType','tif','tif'),(19,'entity-media','mediaType','avi','avi'),(20,'entity-media','mediaType','mp4','mp4'),(21,'entity-media','mediaType','webm','webm'),(22,'entity-media','mediaType','mpg','mpg'),(23,'entity-media','mediaType','ogg','ogg'),(24,'entity-media','mediaType','mov','mov'),(25,'entity-media','mediaType','mp3','mp3'),(26,'entity-media','mediaType','wav','wav'),(27,'entity-media','mediaType','m4a','m4a'),(28,'offer','offerType','Fixed Price','1'),(29,'offer','offerType','Time Based Rate','2'),(30,'offer','offerType','Auction','3');
/*!40000 ALTER TABLE `master-type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `idMessage` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idThread` bigint unsigned NOT NULL,
  `idSender` binary(16) NOT NULL,
  `idRecipient` binary(16) NOT NULL,
  `dtSent` datetime NOT NULL,
  `messageText` text NOT NULL,
  `dtViewed` datetime DEFAULT NULL,
  PRIMARY KEY (`idMessage`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 03:18:08','This is the first message to Joel.',NULL),(2,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 04:13:53','This is the second message to Joel. Hello!?!?!?',NULL),(3,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 04:54:23','This is my third attempt to reach you.',NULL),(4,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 04:54:49','This is my fourth attempt to reach you.',NULL),(5,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 04:56:59','This is my fifth attempt to reach you.',NULL),(6,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 04:59:32','sixth',NULL),(7,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 05:00:49','seventh',NULL),(8,8,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-02 03:00:15','Test message from Joel (stevetest4) to stevetest2.',NULL),(9,9,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-02 03:09:30','Message from Joel to stevetest',NULL),(10,10,_binary '³#%2\É\ÈìŒ˜8\"\â#€ª',_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','2022-05-02 03:52:19','Test',NULL),(11,10,_binary '³#%2\É\ÈìŒ˜8\"\â#€ª',_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','2022-05-02 03:52:47','Test 2',NULL),(12,9,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-02 08:03:16','2nd message from Joel to stevetest',NULL),(13,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-02 08:04:22','Okay, okay. What?',NULL),(14,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-03 03:52:03','Are you going to respond?',NULL),(15,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-03 03:54:17','Hello?',NULL),(16,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-03 03:55:52','Come on!?!?!',NULL),(17,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-03 03:58:48','Please respond!',NULL),(18,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-03 03:59:29','Last time.',NULL),(19,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-03 04:08:00','I am here',NULL),(20,20,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','2022-05-03 04:08:26','First message to Jill from Joel',NULL),(21,21,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','2022-05-03 04:14:15','Yo',NULL),(22,21,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','2022-05-03 04:14:38','Yo again',NULL),(23,20,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','2022-05-03 04:14:48','Hey Jill',NULL),(24,1,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-04 10:19:38','Joel to Stevetest3 on May 4th.',NULL),(25,1,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-04 10:29:19','Stevetest3 to Joel - May 4th.',NULL),(26,26,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-04 10:50:25','Stevetest to steve w/long name. May 4th.',NULL),(27,26,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-04 10:53:22','Steve w/long name reply to stevetest ',NULL),(28,26,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-05 03:31:57','stevetest to steve w/long name',NULL),(29,26,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-05 09:47:50','Long name reply to stevetest. May 5th.\nAdding more text to inspect the layout. Hdjdjdhdhdhdhdjdjjdjd jxjxhdhd bdndbdndbdbdnjdjdjd nxjxjdjdj\n\nJdjdjdjdjdjdj bxjxjdjd',NULL),(30,26,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-11 10:07:24','Steve with long name replies to Steve Test. What\'s up, Steve Test?hello byebrrrrrdmkd,emk867eb5dkmv5jxjxjxjxjxjxjxjxjjjxjxjxjxjxjxjxjxjxjxjxjxjxj',NULL),(31,26,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-11 10:09:10','wut up?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',NULL),(32,32,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-27 09:05:05','This is a message from Steve to stevetestwithaverylongname. \'Sup dude?',NULL),(33,33,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-27 09:09:55','Message from Steve to Joel.',NULL),(34,32,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 09:13:19','Hey Steve. This is stevetestwithaverylongname. Don\'t take any wooden nickels.\n\nThen there\'s a line break above this line.',NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `idNotification` int unsigned NOT NULL AUTO_INCREMENT,
  `idEntity` binary(16) NOT NULL,
  `serviceBeingBookedEmail` bit(1) NOT NULL,
  `serviceBeingBookedText` bit(1) NOT NULL,
  `bookingRequestSubmittedEmail` bit(1) NOT NULL,
  `bookingRequestSubmittedText` bit(1) NOT NULL,
  `bookingRequestConfirmedEmail` bit(1) NOT NULL,
  `bookingRequestConfirmedText` bit(1) NOT NULL,
  `bookingCancelEmail` bit(1) NOT NULL,
  `bookingCancelText` bit(1) NOT NULL,
  `reminderProviderApptEmail` bit(1) NOT NULL,
  `reminderProviderApptText` bit(1) NOT NULL,
  `reminderConsumerApptEmail` bit(1) NOT NULL,
  `reminderConsumerApptText` bit(1) NOT NULL,
  PRIMARY KEY (`idNotification`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (2,_binary '¢t\ñt\Õì–½8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(3,_binary 'w?A\",\Óì–½8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(4,_binary 'lŒ>Q®ì¾¯8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(5,_binary '\Ç9h¡]B\ìª\á8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(6,_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(7,_binary '´uk±Q\ì™(8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(8,_binary 'Œqÿ³\Å\ì™(8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(9,_binary 'Á¢:»\á\ì§b8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(10,_binary '•K|Á!ìŒ˜8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(17,_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(18,_binary '³#%2\É\ÈìŒ˜8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary ''),(19,_binary 'Õ½².\Ì(ìŒ˜8\"\â#€ª',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '',_binary '');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer` (
  `idOffer` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idEntity` binary(16) NOT NULL,
  `offerType` smallint NOT NULL,
  `confirmMethod` tinyint NOT NULL,
  `price` float NOT NULL,
  `rateType` smallint NOT NULL,
  `negotiable` tinyint NOT NULL,
  `maxTimeIncrement` smallint DEFAULT NULL,
  `startTimeIncrement` smallint DEFAULT NULL,
  `bookingLeadNumber` smallint DEFAULT NULL,
  `bookingLeadType` tinyint DEFAULT NULL,
  `cancelLeadNumber` smallint DEFAULT NULL,
  `cancelLeadType` tinyint DEFAULT NULL,
  `cancelFee` float DEFAULT NULL,
  `quantify` bit(1) DEFAULT NULL,
  `quantity` smallint NOT NULL,
  `minTimeIncrement` smallint DEFAULT NULL,
  `handlePayment` bit(1) NOT NULL,
  `depositRequired` tinyint NOT NULL,
  `cancelPolicyOn` bit(1) NOT NULL,
  `cancelFeeType` tinyint DEFAULT NULL,
  `depositAmountType` tinyint DEFAULT NULL,
  `depositAmount` float DEFAULT NULL,
  PRIMARY KEY (`idOffer`),
  UNIQUE KEY `idOffer_UNIQUE` (`idOffer`),
  KEY `fkEntityOffer` (`idEntity`),
  CONSTRAINT `fkEntityOffer` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer`
--

LOCK TABLES `offer` WRITE;
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
INSERT INTO `offer` VALUES (5,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,10000000000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(6,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,10000000000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(7,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,98,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(8,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,10000000000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(9,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,10000000000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(10,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',0,0,10,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(11,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(12,_binary '\à°It\ä\ì•D8\"\â#€ª',0,0,777,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',341,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(13,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',0,0,888,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',65,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(14,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',0,0,999,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',966,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(15,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',0,0,999,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',999,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(16,_binary '\ô\äüüw\ò\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(17,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',0,0,999,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',999,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(18,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '\0',0,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(19,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,987654000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(20,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,987654000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',915,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(21,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,987654000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',915,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(22,_binary '\ZVP‚7\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(23,_binary '\ZVP‚7\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(24,_binary 'vH\ó¥‚ú\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(25,_binary '\Â\í‚ú\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(26,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(27,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',0,0,_binary '\0',0,_binary '\0',NULL,NULL,NULL),(28,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(29,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(30,_binary 'vH\ó¥‚ú\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(31,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,987654000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',915,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(32,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,987654000,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',8987,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(33,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(34,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(35,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(36,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,3454350,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1002,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(37,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,4564570,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',6443,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(38,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,98765.7,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '\0',0,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(39,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(40,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(41,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(42,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(43,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(44,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(45,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(46,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(47,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(48,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(49,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(50,_binary '\Şj¬ &ì§…8\"\â#€ª',0,0,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',1,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(51,_binary 'K.0ı¤8\ì™(8\"\â#€ª',0,0,999,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,_binary '',999,0,_binary '\0',0,_binary '',NULL,NULL,NULL),(52,_binary '±F\ñ¨·\ì™(8\"\â#€ª',0,1,50,1,0,60,0,1,2,5,3,0,_binary '',5,60,_binary '\0',0,_binary '',NULL,NULL,NULL),(53,_binary 'MØ‡…¨\Õ\ì™(8\"\â#€ª',0,1,1000,4,0,60,0,1,2,5,3,0,_binary '',10,60,_binary '\0',0,_binary '',NULL,NULL,NULL),(54,_binary '\"¥©¶\ì™(8\"\â#€ª',0,0,777,3,0,120,30,7,2,7,1,0,_binary '',7,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(55,_binary 'tM\Ï8©\Ë\ì™(8\"\â#€ª',0,1,888,3,0,0,0,24,1,36,1,0,_binary '',12,60,_binary '\0',0,_binary '',NULL,NULL,NULL),(56,_binary 'E[Pª[\ì™(8\"\â#€ª',0,0,888,3,0,0,0,1,1,24,1,555,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(57,_binary 'Y\Ê`ª\\\ì™(8\"\â#€ª',0,0,0,3,0,0,0,1,1,0,1,0,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(58,_binary 'c??­¥\ì™(8\"\â#€ª',0,0,777,3,0,120,30,12,1,5,1,75,_binary '',99,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(59,_binary '\'•™V®C\ì™(8\"\â#€ª',0,0,0,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(60,_binary '\Ì\Z\æ®C\ì™(8\"\â#€ª',0,0,0,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(61,_binary '\ß\Ç\õ®C\ì™(8\"\â#€ª',0,0,0,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(62,_binary '+¹O®D\ì™(8\"\â#€ª',0,0,222,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(63,_binary 'ª‡‘®D\ì™(8\"\â#€ª',0,0,777,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(64,_binary '\÷Æš®D\ì™(8\"\â#€ª',0,0,777,1,1,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(65,_binary '´«Ò®E\ì™(8\"\â#€ª',0,0,777,1,1,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(66,_binary 'zA=®I\ì™(8\"\â#€ª',0,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(67,_binary 'x­nº®L\ì™(8\"\â#€ª',0,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(68,_binary ' IÉ®L\ì™(8\"\â#€ª',0,0,0,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(69,_binary '*ˆ-\è®M\ì™(8\"\â#€ª',0,0,0,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(70,_binary 'S\õµÎ®M\ì™(8\"\â#€ª',0,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(71,_binary 'ªPC®t\ì™(8\"\â#€ª',0,0,100,2,0,120,0,1,1,24,1,50,_binary '',1,60,_binary '\0',0,_binary '',NULL,NULL,NULL),(72,_binary '\ÜZ®x\ì™(8\"\â#€ª',0,0,500,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(73,_binary '3ªoÁ®{\ì™(8\"\â#€ª',0,0,777,1,0,0,0,20,0,24,2,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(74,_binary '½%Nw®~\ì™(8\"\â#€ª',0,0,888,1,1,8,2,100,0,240,2,77,_binary '',77,4,_binary '\0',0,_binary '',NULL,NULL,NULL),(75,_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',1,0,777,2,1,0,0,1,0,24,2,5,_binary '',88,120,_binary '\0',0,_binary '',NULL,NULL,NULL),(76,_binary '\çÒ“|¯\ì™(8\"\â#€ª',1,0,88.75,0,1,120,2,24,1,12,1,25,_binary '',2,60,_binary '\0',0,_binary '',NULL,NULL,NULL),(77,_binary '¯Ê­)¹…\ì™(8\"\â#€ª',1,0,500,2,1,120,0,24,1,12,1,50,_binary '',3,60,_binary '\0',0,_binary '',NULL,NULL,NULL),(78,_binary '»’\în¾ùìŒ˜8\"\â#€ª',1,0,150,2,1,60,1,12,1,6,1,25,_binary '',4,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(79,_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',1,1,50,2,0,60,1,24,1,12,1,50,_binary '',3,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(81,_binary ':¥\0©\Ñ\×ìŒ˜8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(82,_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',3,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(83,_binary 'W\ô\ç¯\Ñ\×ìŒ˜8\"\â#€ª',1,1,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(85,_binary '®VB\Ü\ì¶Á8\"\â#€ª',1,0,1000,3,0,0,0,1,1,24,1,50,_binary '',3,15,_binary '\0',0,_binary '',NULL,NULL,NULL),(86,_binary '\Ú5#\Ã\ö“ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(87,_binary 'Áƒ\n\ö–ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(88,_binary 'R\Êy\ö™ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(89,_binary ',\ß\"\ò\öšì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(90,_binary '²´\04\öšì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(91,_binary 'ü–ø \öšì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(92,_binary ')’Eb\öœì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(93,_binary '0apD\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(94,_binary '>\ê]\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(95,_binary 'I1@b\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(96,_binary 'S\ö€1\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(97,_binary '_v=\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(98,_binary 'd‘¹\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(99,_binary 'f\ï\Ñ\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(100,_binary 'gU\×\öœì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(101,_binary 'şV\\*\ö­ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(102,_binary 'cÌ¦\ö®ì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(103,_binary '\õ«\Ü\ö®ì«ª8\"\â#€ª',1,0,500,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(104,_binary 'q\ö°ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(105,_binary '²,q\ö°ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(106,_binary '	¾\Ş\İ\ö°ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(107,_binary '\è\ä\Ú	\ö°ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(108,_binary 'k¶ı{\ö¸ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(109,_binary 'm%³!\ö¸ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(110,_binary 'mı\ö\ä\ö¸ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(111,_binary 'pLm¯\ö¸ì«ª8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(112,_binary 'u\áœ\÷V\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(113,_binary '\ßTd5\÷V\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(114,_binary '\ÌÒŸd\÷j\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(115,_binary '\é\Ê\î\÷j\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(116,_binary 'ş\ìtš\÷j\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(117,_binary '@µ%\÷k\ì’P8\"\â#€ª',1,0,10,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(118,_binary 'H~?\ã\÷k\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(119,_binary '#\Å\÷l\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(120,_binary '»\ĞE\÷\÷l\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(121,_binary '4\n\Î\÷m\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(122,_binary ';Ê¼\÷m\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(123,_binary '_)‹\÷m\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(124,_binary 'bŒ\÷m\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(125,_binary 'eMx\÷m\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(126,_binary '3\ìœ\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(127,_binary ';…@\\\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(128,_binary '>\Ë}=\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(129,_binary 'E\è#8\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(130,_binary 'I\Î\Û\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(131,_binary 'QÔ‚\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(132,_binary 'S§R8\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(133,_binary '|Œ˜\÷o\ì’P8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(134,_binary '¤4`¿\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(135,_binary '¨\÷¾@\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(136,_binary 'ªB\í¿\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(137,_binary '³‰‰\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(138,_binary '\Ã\Ò\Ù\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(139,_binary '\ÕH\ß\÷o\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '\0',0,_binary '',NULL,NULL,NULL),(140,_binary '¾—\Ä\ó\÷r\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(141,_binary 'ÀiQ\÷s\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(142,_binary 'iÒ¯ \÷t\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(143,_binary 'l	ƒC\÷t\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(144,_binary 'n\ó§\÷t\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(145,_binary 'pT\n\÷t\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(146,_binary 't\í‹\÷t\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(147,_binary '†\ÙN\×\÷t\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(148,_binary 'š\\\÷t\ì’P8\"\â#€ª',1,0,50,1,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(149,_binary '~©Á\÷t\ì’P8\"\â#€ª',1,0,50,1,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(150,_binary '˜T\å\÷t\ì’P8\"\â#€ª',1,0,50,1,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(151,_binary 'œ%™\÷t\ì’P8\"\â#€ª',1,0,50,1,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(152,_binary 'ŸŒ#\÷t\ì’P8\"\â#€ª',1,0,50,1,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(153,_binary 'Âx\÷x\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(154,_binary '\É\ÛÓ¿\÷x\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(155,_binary '\è\ö\÷x\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(156,_binary '­\Ğ\Ä0\÷y\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(157,_binary '\Ís*:\÷y\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(158,_binary 'Î¢u·\÷y\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(159,_binary 'û‰\òK\÷y\ì’P8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(160,_binary '@K\ä\"ø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(161,_binary 'vsƒsø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(163,_binary '´M{²ø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(171,_binary 'úš\á\áø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(172,_binary 'úš\á\áø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(173,_binary 'úš\á\áø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(176,_binary '§0†qø\ì¢ 8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(179,_binary '\çFBø\ì¢ 8\"\â#€ª',1,0,10,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(183,_binary ';.ªmø?\ì¢ 8\"\â#€ª',1,0,110,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(185,_binary 'Ø¼ûUø@\ì¢ 8\"\â#€ª',1,0,120,2,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(196,_binary '²2kù\ì‚Q8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(197,_binary 'Á\â\õ\Üù\ì‚Q8\"\â#€ª',1,0,550,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(198,_binary '¶¬8)ù\ì‚Q8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(199,_binary '\åW\0´ù\ì‚Q8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(200,_binary '\Ğ\÷\õû7\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(201,_binary '°I\óû;\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(202,_binary '!9%—ûn\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(203,_binary '\Û\Ãpû{\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(204,_binary 's\à\Ö\Éû|\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(205,_binary '™ÖEû|\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(206,_binary 'V\Ä×¶û}\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(207,_binary '!=`Zû~\ì³8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(208,_binary 'N?Ê“ü-\ì™v8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(209,_binary '\Æ\Ò\İü\Ç\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(210,_binary '•}šü\È\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(211,_binary '–I\ô¿ü\È\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(212,_binary '–\í\Ôü\È\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(213,_binary '—˜\âUü\È\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(214,_binary '˜Lbü\È\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(215,_binary '\Ë\ï@ü\É\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(216,_binary '\Ì\Ş\\vü\É\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(217,_binary '\Í`\äƒü\É\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(218,_binary '\Î\Ä\Âü\É\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(219,_binary '\Îìœ«ü\É\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(220,_binary '\ÑH@‚ü\É\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(222,_binary '€A„ü\Ê\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(228,_binary '\âx€-ü\Ê\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(239,_binary '\r-kšü\Ì\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(243,_binary 'Y;59ü\Ì\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(245,_binary '!TIü\Ğ\ì¾\È8\"\â#€ª',1,0,0,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',NULL,NULL,NULL),(254,_binary '±W_ı\Ô\ì„8\"\â#€ª',1,0,10,0,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '\0',0,0,0),(255,_binary '\ç1e>şZì¶8\"\â#€ª',1,0,100,3,0,0,0,1,1,24,1,50,_binary '',1,30,_binary '',0,_binary '',0,0,0);
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `idOrder` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idUser` binary(16) NOT NULL,
  `idAddress` bigint unsigned DEFAULT NULL,
  `idCreditCard` bigint unsigned DEFAULT NULL,
  `state` tinyint NOT NULL,
  `inventoryLockTime` datetime DEFAULT NULL,
  PRIMARY KEY (`idOrder`),
  UNIQUE KEY `idOrder_UNIQUE` (`idOrder`),
  KEY `fkUserOrder` (`idUser`),
  KEY `fkAddressOrder` (`idAddress`),
  KEY `fkCreditCardOrder` (`idCreditCard`),
  CONSTRAINT `fkAddressOrder` FOREIGN KEY (`idAddress`) REFERENCES `address` (`idAddress`),
  CONSTRAINT `fkCreditCardOrder` FOREIGN KEY (`idCreditCard`) REFERENCES `credit-card` (`idCreditCard`),
  CONSTRAINT `fkUserOrder` FOREIGN KEY (`idUser`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB AUTO_INCREMENT=505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(2,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(3,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(4,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(5,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(6,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(7,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(8,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(9,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(10,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(11,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(12,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(13,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(14,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(15,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(16,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(17,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(18,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(19,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(20,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(21,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(22,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(23,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(24,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(25,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(26,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(27,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(28,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(29,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(30,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(31,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(32,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(33,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(34,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(35,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(36,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(37,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(38,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(39,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(40,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(41,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(42,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(43,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(44,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(45,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(46,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(47,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(48,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(49,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(50,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(51,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(52,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(53,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(54,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(55,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(56,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(57,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(58,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(59,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(60,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(61,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(62,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(63,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(64,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(65,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(66,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(67,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(68,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(69,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(70,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(71,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(72,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(73,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(74,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(75,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(76,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(77,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(78,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(79,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(80,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(81,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(82,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(83,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(84,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(85,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(86,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(87,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(88,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(89,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(90,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(91,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(92,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(93,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(94,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(95,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(96,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(97,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(98,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(99,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(100,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(101,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(102,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(103,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(104,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(105,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(106,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(107,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(108,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(109,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(110,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(111,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(112,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(113,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(114,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(115,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(116,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(117,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(118,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(119,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(120,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(121,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(122,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(123,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(124,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(125,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(126,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(127,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(128,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(129,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(130,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(131,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(132,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(133,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(134,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(135,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(136,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(137,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(138,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(139,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(140,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(141,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(142,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(143,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(144,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(145,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(146,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(147,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(148,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(149,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(150,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(151,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(152,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(153,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(154,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(155,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(156,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(157,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(158,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(159,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(160,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(161,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(162,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(163,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(164,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(165,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(166,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(167,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(168,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(169,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(170,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(171,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(172,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(173,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(174,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(175,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(176,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(177,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(178,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(179,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(180,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(181,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(182,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(183,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(184,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(185,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(186,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(187,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(188,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(189,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(190,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(191,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(192,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(193,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(194,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(195,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(196,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(197,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(198,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(199,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(200,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(201,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(202,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(203,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(204,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(205,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(206,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(207,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(208,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(209,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(210,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(211,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(212,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(213,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(214,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(215,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(216,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(217,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(218,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(219,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(220,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(221,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(222,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(223,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(224,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(225,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(226,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(227,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(228,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(229,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(230,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(231,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(232,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(233,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(234,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(235,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(236,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(237,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(238,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(239,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(240,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(241,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(242,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(243,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(244,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(245,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(246,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(247,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(248,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(249,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(250,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(251,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(252,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(253,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(254,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(255,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(256,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(257,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(258,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(259,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(260,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(261,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(262,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(263,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(264,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(265,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(266,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(267,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(268,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(269,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(270,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(271,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(272,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(273,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(274,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(275,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(276,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(277,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(278,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(279,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(280,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(281,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(282,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(283,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(284,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(285,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(286,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(287,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(288,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(289,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(290,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(291,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(292,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(293,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(294,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(295,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(296,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(297,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(298,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(299,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(300,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(301,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(302,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(303,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(304,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(305,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(306,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(307,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(308,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(309,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(310,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(311,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(312,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(313,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(314,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(315,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(316,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(317,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(318,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(319,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(320,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(321,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(322,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(323,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(324,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(325,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(326,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(327,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(328,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(329,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(330,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(331,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(332,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(333,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(334,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(335,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(336,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(337,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(338,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(339,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(340,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(341,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(342,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(343,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(344,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(345,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(346,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(347,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(348,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(349,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(350,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(351,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(352,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(353,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(354,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(355,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(356,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(357,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(358,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(359,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(360,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(361,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(362,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(363,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(364,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(365,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(366,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(367,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(368,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(369,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(370,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(371,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(372,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(373,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(374,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(375,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(376,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(377,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(378,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(379,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(380,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(381,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(382,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(383,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(384,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(385,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(386,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(387,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(388,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(389,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(390,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(391,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(392,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(393,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(394,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(395,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(396,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(397,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(398,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(399,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(400,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(401,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(402,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(403,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(404,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(405,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(406,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(407,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(408,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(409,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(410,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(411,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(412,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(413,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(414,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(415,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(416,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(417,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(418,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(419,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(420,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(421,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(422,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(423,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(424,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(425,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(426,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(427,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(428,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(429,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(430,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(431,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(432,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(433,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(434,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(435,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(436,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(437,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(438,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(439,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(440,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(441,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(442,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(443,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(444,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(445,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(446,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(447,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(448,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(449,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(450,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(451,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(452,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(453,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(454,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(455,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(456,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(457,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(458,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(459,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(460,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(461,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(462,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(463,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(464,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(465,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(466,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(467,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(468,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(469,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(470,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(471,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(472,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(473,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(474,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(475,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(476,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(477,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(478,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(479,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(480,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(481,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(482,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(483,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(484,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(485,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(486,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(487,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(488,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(489,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(490,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(491,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(492,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(493,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(494,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(495,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(496,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(497,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(498,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(499,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(500,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(501,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(502,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(503,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL),(504,_binary '¢t\ñt\Õì–½8\"\â#€ª',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order-item`
--

DROP TABLE IF EXISTS `order-item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order-item` (
  `idOrder` bigint unsigned NOT NULL,
  `idEntity` binary(16) NOT NULL,
  `quantity` smallint NOT NULL,
  `totalPrice` double NOT NULL,
  `idOffer` bigint unsigned NOT NULL,
  PRIMARY KEY (`idOrder`,`idEntity`),
  KEY `fkEntityOrderItem` (`idEntity`),
  KEY `fkOfferOrderItem` (`idOffer`),
  CONSTRAINT `fkEntityOrderItem` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkOfferOrderItem` FOREIGN KEY (`idOffer`) REFERENCES `offer` (`idOffer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order-item`
--

LOCK TABLES `order-item` WRITE;
/*!40000 ALTER TABLE `order-item` DISABLE KEYS */;
INSERT INTO `order-item` VALUES (1,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',2,0,7),(1,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',1,0,5),(2,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(2,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(3,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(3,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(4,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(4,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(4,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(5,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(5,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(5,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(6,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(6,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(6,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(7,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(7,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(7,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(8,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(8,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(8,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(9,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(9,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(9,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(10,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(10,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(10,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(11,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(11,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(11,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(12,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(12,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(12,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(13,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(13,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(13,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(14,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(14,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(14,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(17,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(17,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(17,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(18,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(18,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(18,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(19,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(19,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(19,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(20,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(20,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(20,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(21,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(21,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(21,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(22,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(22,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(22,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(23,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(23,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(23,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(24,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(24,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(24,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(26,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(26,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(26,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(27,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(27,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(27,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(29,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(29,_binary 'k6\Ét\Í\ì•D8\"\â#€ª',0,0,7),(29,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(30,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(30,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(34,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(34,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(35,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',3,0,10),(35,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(36,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',2,0,10),(36,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(41,_binary 'OU³\Ôt\Ó\ì•D8\"\â#€ª',0,0,10),(41,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,5),(42,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(43,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(48,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(49,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(50,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(50,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(52,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(52,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(53,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(53,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(54,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(54,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(55,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(55,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(56,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(56,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(57,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(57,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(58,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(58,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(59,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(59,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(60,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(60,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(61,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(61,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(62,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(62,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(63,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(63,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(64,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(64,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(65,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(65,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(66,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(66,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(68,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(68,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(69,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(69,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(70,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(70,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(71,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(71,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(72,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(72,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(74,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(74,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(75,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(75,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(76,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(76,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(77,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(77,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(78,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(78,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(79,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(79,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(80,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(80,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(81,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(81,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(82,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(82,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(83,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(83,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(84,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(84,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(85,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(85,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(86,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(86,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(87,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(87,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(88,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(88,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(89,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(89,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(90,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(90,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(91,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(91,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(92,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(92,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(93,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(93,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(94,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(94,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(95,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(95,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(96,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(96,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(97,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(97,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(98,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(98,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(99,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(99,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(100,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(100,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(101,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(101,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(103,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(103,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(104,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(104,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(105,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(105,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(106,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(106,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(107,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(107,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(108,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(108,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(109,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(109,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(110,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(110,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(111,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(111,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(112,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(112,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(114,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(114,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(115,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(115,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(116,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(116,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(117,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(117,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(118,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(118,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(120,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(120,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(121,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(121,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(122,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(122,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(123,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(123,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(124,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(124,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(125,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(125,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(126,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(126,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(127,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(127,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(128,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(128,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(129,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(129,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(130,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(130,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(131,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(131,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(132,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(132,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(133,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(133,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(134,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(134,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(135,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(135,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(136,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(136,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(137,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(137,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(138,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(138,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(139,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(139,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(140,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(140,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(141,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(141,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(142,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(142,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(143,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(143,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(144,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(144,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(145,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(145,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(146,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(146,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(150,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(150,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(151,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(151,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(152,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(152,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(153,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(153,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(154,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(154,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(155,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(155,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(156,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(156,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(157,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(157,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(158,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(158,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(159,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(159,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(160,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(160,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(164,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(164,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(167,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(167,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(168,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(168,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(170,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(170,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(171,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(171,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(172,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(172,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(173,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(173,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(174,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(174,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(175,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(175,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(176,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(176,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(177,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(177,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(178,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(178,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(179,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(179,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(180,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(180,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(181,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(181,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(182,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(182,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(183,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(183,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(184,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(184,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(185,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(185,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(186,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(186,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(187,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(187,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(188,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(188,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(189,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(189,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(190,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(190,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(192,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(192,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(193,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(193,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(194,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(194,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(195,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(195,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(196,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(196,_binary '\à°It\ä\ì•D8\"\â#€ª',2,0,12),(197,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(197,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',1,0,6),(197,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(198,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(198,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(198,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(199,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(199,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(199,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(200,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(200,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(200,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(201,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(201,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(201,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(202,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(202,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(202,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(203,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(203,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(203,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(204,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(204,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(204,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(205,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(205,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(205,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(206,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(206,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(206,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(207,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(207,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(207,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(208,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(208,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(208,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(210,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(210,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(210,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(211,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(211,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(211,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(212,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(212,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(212,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(213,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(213,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(213,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(214,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(214,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(214,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(215,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(215,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(215,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(216,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(216,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(216,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(218,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(218,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(218,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(219,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(219,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(219,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(220,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(220,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(220,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(221,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(221,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(221,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(222,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(222,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(222,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(223,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(223,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(223,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(224,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(224,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(224,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(225,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(225,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(225,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(226,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(226,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(226,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(227,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(227,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(227,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(228,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(228,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(228,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(229,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(229,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(229,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(230,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(230,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(230,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(231,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(231,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(231,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(232,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(232,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(232,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(233,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(233,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(233,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(234,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(234,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(234,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(235,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(235,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(235,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(236,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(236,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(236,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(237,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(237,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(237,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(238,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(238,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(238,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(239,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(239,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(239,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(240,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(240,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(240,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(241,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(241,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(241,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(242,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(242,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(242,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(243,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(243,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(243,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(244,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(244,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(244,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(245,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(245,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(245,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(246,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(246,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(246,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(247,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(247,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(247,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(248,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(248,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(248,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(249,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(249,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(249,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(250,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(250,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(250,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(251,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',3,0,13),(251,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(251,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(252,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',3,0,13),(252,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(252,_binary '\à°It\ä\ì•D8\"\â#€ª',3,0,12),(253,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(253,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(253,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(254,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(254,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(254,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(255,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(255,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(255,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(256,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(256,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(256,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(257,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(257,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(257,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(259,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(259,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(259,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(260,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(260,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(260,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(261,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(261,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,6),(261,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(262,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(262,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(263,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',3,0,13),(263,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(264,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(264,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(264,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(265,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(265,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(265,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(267,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(267,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(267,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(269,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(269,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(269,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(271,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(271,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(271,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(273,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(273,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(273,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(275,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(275,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(275,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(277,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(277,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(277,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(279,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(279,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(279,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(280,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(280,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(280,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(283,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(283,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(283,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(284,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(284,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(284,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(285,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(285,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(285,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(286,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(286,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(286,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(287,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(287,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(287,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(288,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(288,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(288,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(289,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(289,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(289,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(290,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(290,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(290,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(291,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(291,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(291,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(292,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(292,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(292,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(293,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(293,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(293,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(294,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(294,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(294,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(295,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(295,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(295,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(296,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(296,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(296,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(297,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(297,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(297,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(298,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(299,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(300,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(301,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(302,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(303,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(304,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(304,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(304,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(305,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(305,_binary 'š\Ş\Ôt\ç\ì•D8\"\â#€ª',1,0,14),(305,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(306,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(307,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(308,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(309,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(310,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(311,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(312,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(313,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(314,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(315,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(316,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(317,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',1,0,8),(317,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(318,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',2,0,8),(318,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(319,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',2,0,8),(319,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(320,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(320,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(321,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(321,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(322,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(322,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(323,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(323,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(324,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(324,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(325,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(325,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(326,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(326,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(327,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(327,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(328,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(328,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(329,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(329,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(330,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(330,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(331,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(331,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(332,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(332,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(333,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(333,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(334,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(334,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(335,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(335,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(336,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(336,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(337,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(337,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(338,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(338,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(339,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,8),(339,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(340,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(341,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',1,0,9),(341,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(342,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',2,0,9),(342,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(343,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',2,0,9),(343,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(344,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(344,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(345,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(345,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(346,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(346,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(347,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(347,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(348,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(348,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(349,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(349,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(349,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(350,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(350,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(350,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(351,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(351,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(351,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(352,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(352,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(352,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(353,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(353,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(353,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(354,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(354,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(354,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(355,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(355,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(355,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(356,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(356,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(356,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(357,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(357,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(357,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(358,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(358,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(358,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(359,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(359,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(359,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(360,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(360,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(360,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(361,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(361,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(361,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(362,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(362,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(362,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(363,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(363,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(363,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(364,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(364,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(364,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(365,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(365,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(365,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(366,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(366,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(366,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(367,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(367,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(367,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(368,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(368,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(368,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(369,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(369,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(369,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(370,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(370,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(370,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(371,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(371,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(371,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(372,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(372,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(372,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(373,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(373,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(373,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(374,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(374,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(374,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(375,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(375,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(375,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(376,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(376,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(376,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(377,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(377,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(377,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(378,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(378,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(378,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(379,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(379,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(379,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(380,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(380,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(380,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(381,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(381,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(381,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(382,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(382,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(382,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(383,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(383,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(383,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(384,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(384,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(384,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(385,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(385,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(385,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(386,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(386,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(386,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(387,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(387,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(387,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(388,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(388,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(388,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(389,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(389,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(389,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(390,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(390,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(390,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(391,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(391,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(391,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(392,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(392,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(392,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(393,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(393,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(393,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(394,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(394,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(394,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(395,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(395,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(395,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(396,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(396,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(396,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(397,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(397,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(397,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(398,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(398,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(398,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(399,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(399,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(399,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(400,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(400,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(400,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(401,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(401,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(401,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(402,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(402,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(402,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(403,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(403,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(403,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(404,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(404,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(404,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(405,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(405,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(405,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(406,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(406,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(406,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(407,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(407,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(407,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(408,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(408,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(408,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(409,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(409,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(409,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(410,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(410,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(410,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(411,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(411,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(411,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(412,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(412,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(412,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(413,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(413,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(413,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(414,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(414,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(414,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(415,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(415,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(415,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(416,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(416,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(416,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(417,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(417,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(417,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(418,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(418,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(418,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(419,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(419,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(419,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(420,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(420,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(420,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(421,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(421,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(421,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(422,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(422,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(422,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(423,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(423,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(423,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(424,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(424,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(424,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(425,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(425,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(425,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(426,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(426,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(426,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(427,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(427,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(427,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(428,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(428,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(428,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(429,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(429,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(429,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(430,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(430,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(430,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(431,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(431,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(431,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(432,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(432,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(432,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(433,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(433,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(433,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(434,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(434,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(434,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(435,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(435,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(435,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(436,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(436,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(436,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(437,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(437,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(437,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(438,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(438,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(438,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(439,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(439,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(439,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(440,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(440,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(440,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(441,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(441,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(441,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(442,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(442,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(442,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(443,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(443,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(443,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(444,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(444,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(444,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(445,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(445,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(445,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(446,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(446,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(446,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(447,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(447,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(447,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(448,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(448,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(448,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(449,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(449,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(449,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(450,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(450,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(450,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(451,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(451,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(451,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(452,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(452,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(452,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(453,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(453,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(453,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(454,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(454,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(454,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(455,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(455,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(455,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(456,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(456,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(456,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(457,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(457,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(457,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(458,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(458,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(458,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(459,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(459,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(459,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(460,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(460,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(460,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(461,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(461,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(461,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(462,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(462,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(462,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(463,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(463,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(463,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(464,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(464,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(464,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(465,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(465,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(465,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(466,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(466,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(466,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(467,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(467,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(467,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(468,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(468,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(468,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(469,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(469,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(469,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(470,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(470,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(470,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(471,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(471,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(471,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(472,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(472,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(472,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(473,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(473,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(473,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(474,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(474,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(474,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(475,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(475,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(475,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(476,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(476,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(476,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(477,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(477,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(477,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(478,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(478,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(478,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(479,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(479,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(479,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(480,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(480,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(480,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(481,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(481,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(481,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(482,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(482,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(482,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(483,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(483,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(483,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(484,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(484,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(484,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(485,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(485,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(485,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(486,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(486,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(486,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(487,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(487,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(487,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(488,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(488,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(488,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(489,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(489,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(489,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(490,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(490,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(490,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(491,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(491,_binary 'ƒĞ™Un\ì°	8\"\â#€ª',0,0,9),(491,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(492,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(492,_binary '1©59‚5\ì­\Z8\"\â#€ª',28,0,19),(492,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(493,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(493,_binary '1©59‚5\ì­\Z8\"\â#€ª',28,0,19),(493,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(494,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',1,0,13),(494,_binary '1©59‚5\ì­\Z8\"\â#€ª',28,0,19),(494,_binary '\à°It\ä\ì•D8\"\â#€ª',1,0,12),(500,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',2,0,13),(500,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',1,0,26),(501,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',87,0,13),(501,_binary '1©59‚5\ì­\Z8\"\â#€ª',666,0,19),(501,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,26),(502,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',87,0,13),(502,_binary '1©59‚5\ì­\Z8\"\â#€ª',249,0,19),(502,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,26),(503,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',87,0,13),(503,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,19),(503,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',0,0,26),(504,_binary 'œe\Ùt\ç\ì•D8\"\â#€ª',87,0,13),(504,_binary '1©59‚5\ì­\Z8\"\â#€ª',0,0,19),(504,_binary ':Ë¸O‚û\ì­\Z8\"\â#€ª',1,0,27),(504,_binary '\Â\í‚ú\ì­\Z8\"\â#€ª',1,0,25);
/*!40000 ALTER TABLE `order-item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `idEntity` binary(16) NOT NULL,
  `personFirstName` varchar(128) DEFAULT NULL,
  `personLastName` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPerson` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (_binary 'lŒ>Q®ì¾¯8\"\â#€ª','Steve','DeLollis'),(_binary '´uk±Q\ì™(8\"\â#€ª','Steve','DeLollis'),(_binary 'w?A\",\Óì–½8\"\â#€ª','test','test'),(_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','Steve','DeLollis'),(_binary '•K|Á!ìŒ˜8\"\â#€ª','Joel',''),(_binary '¢t\ñt\Õì–½8\"\â#€ª','Steve','DeLollis'),(_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','Jill','Holmes'),(_binary 'Á¢:»\á\ì§b8\"\â#€ª','Steve','DeLollis'),(_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','Steve','Test'),(_binary '\Ç9h¡]B\ìª\á8\"\â#€ª','Test','Test'),(_binary 'Õ½².\Ì(ìŒ˜8\"\â#€ª','test',''),(_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','Carson','Holmes');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place` (
  `idEntity` binary(16) NOT NULL,
  `placeType` int NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPlace` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place`
--

LOCK TABLES `place` WRITE;
/*!40000 ALTER TABLE `place` DISABLE KEYS */;
/*!40000 ALTER TABLE `place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `idEntity` binary(16) NOT NULL,
  `seeking` bit(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPost` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (_binary 'O³\ôQ˜ì¾¯8\"\â#€ª',_binary '\0'),(_binary 'š\'r\ŞQ–ì¾¯8\"\â#€ª',_binary ''),(_binary '¹\ã\ğ\ÛQ—ì¾¯8\"\â#€ª',_binary '\0'),(_binary '\îø\0\nS ì¾¯8\"\â#€ª',_binary '\0');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `province` (
  `idProvince` int unsigned NOT NULL AUTO_INCREMENT,
  `idCountry` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `code` char(2) NOT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`idProvince`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
INSERT INTO `province` VALUES (1,231,'Alabama','AL',_binary ''),(2,231,'Alaska','AK',_binary ''),(3,231,'American Samoa','AS',_binary ''),(4,231,'Arizona','AZ',_binary ''),(5,231,'Arkansas','AR',_binary ''),(6,231,'California','CA',_binary ''),(7,231,'Colorado','CO',_binary ''),(8,231,'Connecticut','CT',_binary ''),(9,231,'Delaware','DE',_binary ''),(10,231,'District of Columbia','DC',_binary ''),(11,231,'Federated States of Micronesia','FM',_binary ''),(12,231,'Florida','FL',_binary ''),(13,231,'Georgia','GA',_binary ''),(14,231,'Guam','GU',_binary ''),(15,231,'Hawaii','HI',_binary ''),(16,231,'Idaho','ID',_binary ''),(17,231,'Illinois','IL',_binary ''),(18,231,'Indiana','IN',_binary ''),(19,231,'Iowa','IA',_binary ''),(20,231,'Kansas','KS',_binary ''),(21,231,'Kentucky','KY',_binary ''),(22,231,'Louisiana','LA',_binary ''),(23,231,'Maine','ME',_binary ''),(24,231,'Marshall Islands','MH',_binary ''),(25,231,'Maryland','MD',_binary ''),(26,231,'Massachusetts','MA',_binary ''),(27,231,'Michigan','MI',_binary ''),(28,231,'Minnesota','MN',_binary ''),(29,231,'Mississippi','MS',_binary ''),(30,231,'Missouri','MO',_binary ''),(31,231,'Montana','MT',_binary ''),(32,231,'Nebraska','NE',_binary ''),(33,231,'Nevada','NV',_binary ''),(34,231,'New Hampshire','NH',_binary ''),(35,231,'New Jersey','NJ',_binary ''),(36,231,'New Mexico','NM',_binary ''),(37,231,'New York','NY',_binary ''),(38,231,'North Carolina','NC',_binary ''),(39,231,'North Dakota','ND',_binary ''),(40,231,'Northern Mariana Islands','MP',_binary ''),(41,231,'Ohio','OH',_binary ''),(42,231,'Oklahoma','OK',_binary ''),(43,231,'Oregon','OR',_binary ''),(44,231,'Palau','PW',_binary ''),(45,231,'Pennsylvania','PA',_binary ''),(46,231,'Puerto Rico','PR',_binary ''),(47,231,'Rhode Island','RI',_binary ''),(48,231,'South Carolina','SC',_binary ''),(49,231,'South Dakota','SD',_binary ''),(50,231,'Tennessee','TN',_binary ''),(51,231,'Texas','TX',_binary ''),(52,231,'Utah','UT',_binary ''),(53,231,'Vermont','VT',_binary ''),(54,231,'Virgin Islands','VI',_binary ''),(55,231,'Virginia','VA',_binary ''),(56,231,'Washington','WA',_binary ''),(57,231,'West Virginia','WV',_binary ''),(58,231,'Wisconsin','WI',_binary ''),(59,231,'Wyoming','WY',_binary ''),(60,41,'Alberta','AB',_binary ''),(61,41,'British Columbia','BC',_binary ''),(62,41,'Manitoba','MB',_binary ''),(63,41,'New Brunswick','NB',_binary ''),(64,41,'Newfoundland and Labrador','NL',_binary ''),(65,41,'Northwest Territories','NT',_binary ''),(66,41,'Nova Scotia','NS',_binary ''),(67,41,'Nunavut','NU',_binary ''),(68,41,'Ontario','ON',_binary ''),(69,41,'Prince Edward Island','PE',_binary ''),(70,41,'Quebec','QC',_binary ''),(71,41,'Saskatchewan','SK',_binary ''),(72,41,'Yukon','YT',_binary '');
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset-password-session`
--

DROP TABLE IF EXISTS `reset-password-session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reset-password-session` (
  `idSession` binary(16) NOT NULL,
  `idEntity` binary(16) NOT NULL,
  `dtStarted` datetime NOT NULL,
  PRIMARY KEY (`idSession`),
  KEY `fkUserFPS_idx` (`idEntity`),
  CONSTRAINT `fkUserFPS` FOREIGN KEY (`idEntity`) REFERENCES `user` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset-password-session`
--

LOCK TABLES `reset-password-session` WRITE;
/*!40000 ALTER TABLE `reset-password-session` DISABLE KEYS */;
INSERT INTO `reset-password-session` VALUES (_binary ',—ü\Ã\è]\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 09:32:21');
/*!40000 ALTER TABLE `reset-password-session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `idEntity` binary(16) NOT NULL,
  `online` bit(1) NOT NULL,
  `inPerson` bit(1) NOT NULL,
  `onDemand` bit(1) NOT NULL,
  `byAppt` bit(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityService` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (_binary '°I\óû;\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '²2kù\ì‚Q8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '!TIü\Ğ\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '!9%—ûn\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '!=`Zû~\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'Koa†\Ñ\×ìŒ˜8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'N?Ê“ü-\ì™v8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'O\Å5Å®ø\ì™(8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'V\Ä×¶û}\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 's\à\Ö\Éû|\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'vsƒsø\ì¢ 8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'zÇ–\ĞAìŒ˜8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '€A„ü\Ê\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '•}šü\È\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '–I\ô¿ü\È\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '–\í\Ôü\È\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '—˜\âUü\È\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '˜Lbü\È\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '™ÖEû|\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '±W_ı\Ô\ì„8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '¶¬8)ù\ì‚Q8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '»’\în¾ùìŒ˜8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary 'Á\â\õ\Üù\ì‚Q8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\Æ\Ò\İü\Ç\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\Ë\ï@ü\É\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\Í`\äƒü\É\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\Îìœ«ü\É\ì¾\È8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\Ğ\÷\õû7\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\Û\Ãpû{\ì³8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\åW\0´ù\ì‚Q8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\ç1e>şZì¶8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0'),(_binary '\çÒ“|¯\ì™(8\"\â#€ª',_binary '\0',_binary '\0',_binary '\0',_binary '\0');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service-availability`
--

DROP TABLE IF EXISTS `service-availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service-availability` (
  `idEvent` int unsigned NOT NULL,
  `idService` binary(16) NOT NULL,
  UNIQUE KEY `ServiceAvailability_UNIQUE` (`idEvent`,`idService`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service-availability`
--

LOCK TABLES `service-availability` WRITE;
/*!40000 ALTER TABLE `service-availability` DISABLE KEYS */;
INSERT INTO `service-availability` VALUES (1,_binary '\n¨TSVì¾¯8\"\â#€ª'),(1,_binary '`\í*Ye\ìª\á8\"\â#€ª'),(1,_binary 'e\æ,R=ì¾¯8\"\â#€ª'),(1,_binary 'h#³m\Í\ì°	8\"\â#€ª'),(1,_binary '³¸\êÔ•\Zì™™8\"\â#€ª'),(1,_binary '\ñPQ\Ğì¾¯8\"\â#€ª'),(2,_binary '\n¨TSVì¾¯8\"\â#€ª'),(2,_binary '`\í*Ye\ìª\á8\"\â#€ª'),(2,_binary 'e\æ,R=ì¾¯8\"\â#€ª'),(2,_binary 'h#³m\Í\ì°	8\"\â#€ª'),(2,_binary '³¸\êÔ•\Zì™™8\"\â#€ª'),(2,_binary '\ñPQ\Ğì¾¯8\"\â#€ª'),(3,_binary '\n¨TSVì¾¯8\"\â#€ª'),(3,_binary 'C³l¤\Ï\ì™(8\"\â#€ª'),(3,_binary '`\í*Ye\ìª\á8\"\â#€ª'),(3,_binary 'e\æ,R=ì¾¯8\"\â#€ª'),(3,_binary 'h#³m\Í\ì°	8\"\â#€ª'),(3,_binary '³¸\êÔ•\Zì™™8\"\â#€ª'),(165,_binary '¯Ê­)¹…\ì™(8\"\â#€ª');
/*!40000 ALTER TABLE `service-availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestion`
--

DROP TABLE IF EXISTS `suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suggestion` (
  `idSuggestion` int unsigned NOT NULL AUTO_INCREMENT,
  `idEntity` binary(16) DEFAULT NULL,
  `suggestion` text,
  `dtCreated` datetime NOT NULL,
  PRIMARY KEY (`idSuggestion`),
  UNIQUE KEY `idSuggestion_UNIQUE` (`idSuggestion`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestion`
--

LOCK TABLES `suggestion` WRITE;
/*!40000 ALTER TABLE `suggestion` DISABLE KEYS */;
INSERT INTO `suggestion` VALUES (1,_binary '¢t\ñt\Õì–½8\"\â#€ª','I like FairHub!(everything)\nETHAN','2022-01-29 15:40:20'),(2,_binary '¢t\ñt\Õì–½8\"\â#€ª','I like FairHub!(everything)\nETHAN','2022-01-29 15:42:46'),(3,_binary '¢t\ñt\Õì–½8\"\â#€ª','test suggestion 2/2/22','2022-02-02 08:51:48'),(4,_binary '¢t\ñt\Õì–½8\"\â#€ª','test suggestion 2/2/22','2022-02-02 08:53:31'),(5,_binary '¢t\ñt\Õì–½8\"\â#€ª','I like FairHub (everything)!\nEthan','2022-02-02 09:20:56'),(6,_binary '¢t\ñt\Õì–½8\"\â#€ª','why is FairHub sooooooooooooooooo cool?!','2022-02-18 19:44:51'),(7,_binary '¢t\ñt\Õì–½8\"\â#€ª','test','2022-06-06 15:19:29'),(8,_binary '¢t\ñt\Õì–½8\"\â#€ª','test 2','2022-06-06 15:22:01'),(9,_binary '¢t\ñt\Õì–½8\"\â#€ª','test 3','2022-06-06 15:23:13'),(10,_binary '¢t\ñt\Õì–½8\"\â#€ª','test 4','2022-06-06 15:23:30'),(11,_binary '¢t\ñt\Õì–½8\"\â#€ª','test 5','2022-06-06 15:26:22'),(12,_binary '¢t\ñt\Õì–½8\"\â#€ª','Hey FairHub!','2022-06-08 09:12:05');
/*!40000 ALTER TABLE `suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `idEntity` binary(16) NOT NULL,
  `userName` varchar(64) NOT NULL,
  `userPassword` varchar(60) NOT NULL,
  `userSalt` varchar(29) NOT NULL,
  `userPrimaryEmail` bigint unsigned NOT NULL,
  `userTimeZone` tinyint NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  KEY `fkUserEmail` (`userPrimaryEmail`),
  CONSTRAINT `fkEntityUser` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkUserEmail` FOREIGN KEY (`userPrimaryEmail`) REFERENCES `email` (`idEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (_binary 'lŒ>Q®ì¾¯8\"\â#€ª','Steve2','$2a$13$2biqdmSlr7W8gtPt7KpbYOY/MWe31Uvvj6Nq0r41gc/GrJMK4F6RG','$2a$13$2biqdmSlr7W8gtPt7KpbYO',5,0),(_binary '´uk±Q\ì™(8\"\â#€ª','Stevetest2','$2a$13$Cd4nqEvy4SLGZ2jBZtBuhuyKIxFuLBHNgM/ghIK6E0mZrmYYscBui','$2a$13$Cd4nqEvy4SLGZ2jBZtBuhu',8,0),(_binary 'w?A\",\Óì–½8\"\â#€ª','test','$2a$13$jHrSvzcp70nWR8xGsxqSieqpIJj.FxDUzAvJ4WsBKXFNtV2s/kX7G','$2a$13$jHrSvzcp70nWR8xGsxqSie',2,0),(_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','Stevetest3','$2a$13$ZPp.8sUXhvtHk.Zh8vwo/epN..B8MUfySGaXhXsj.KvOFBV3hYLOm','$2a$13$ZPp.8sUXhvtHk.Zh8vwo/e',9,0),(_binary '•K|Á!ìŒ˜8\"\â#€ª','Stevetest4','$2a$13$aKvoHl6tFkTAlKu9Xn4tW.jGh9WLEHEPIwzMUDVIhCMNC7H4nIoFq','$2a$13$aKvoHl6tFkTAlKu9Xn4tW.',16,0),(_binary '¢t\ñt\Õì–½8\"\â#€ª','Steve','$2a$13$WJQxTZy2w1UetsI.MHkmRuuX3M1AJYxjiVBi0hvGKdmqIBn5W2nFm','$2a$13$WJQxTZy2w1UetsI.MHkmRu',1,8),(_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','Jill','$2a$13$5TQsoLGdCN813WA28WFUfOM.uny/Ni.3dBF2vGpxutcaToxRl7OPi','$2a$13$5TQsoLGdCN813WA28WFUfO',18,0),(_binary 'Á¢:»\á\ì§b8\"\â#€ª','stevetestwithaverylongname','$2a$13$1Mqk0vOYmPZj77JBSI2oH.7VnSF6x5j0dBpdtK5sIWe/ZGZ7cjcoC','$2a$13$1Mqk0vOYmPZj77JBSI2oH.',10,0),(_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','SteveTest','$2a$13$WJQxTZy2w1UetsI.MHkmRuuX3M1AJYxjiVBi0hvGKdmqIBn5W2nFm','$2a$13$WJQxTZy2w1UetsI.MHkmRu',7,4),(_binary '\Ç9h¡]B\ìª\á8\"\â#€ª','TestUser','$2a$13$4htM67oLHW3KzfAmDMjDtOFypTdkbY/x/BSq0Ngv/cJBcTgo0hXBS','$2a$13$4htM67oLHW3KzfAmDMjDtO',6,0),(_binary 'Õ½².\Ì(ìŒ˜8\"\â#€ª','newtestuser','$2a$13$0OgAKllksEdSgFceBlF8me8Y8i1avQTmpT.wFJCrFsiZI967.Yt6W','$2a$13$0OgAKllksEdSgFceBlF8me',19,0),(_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','Carson','$2a$13$1wQZFurwL5wx.QniEOw3nu2Zj2cAiCBfAvGGgNIK0Hfroez811C4q','$2a$13$1wQZFurwL5wx.QniEOw3nu',17,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user-session`
--

DROP TABLE IF EXISTS `user-session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user-session` (
  `idSession` binary(16) NOT NULL,
  `idEntity` binary(16) NOT NULL,
  `dtStarted` datetime NOT NULL,
  `dtActive` datetime NOT NULL,
  `done` bit(1) NOT NULL,
  PRIMARY KEY (`idSession`,`idEntity`),
  KEY `fkUserUS` (`idEntity`),
  CONSTRAINT `fkUserUS` FOREIGN KEY (`idEntity`) REFERENCES `user` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user-session`
--

LOCK TABLES `user-session` WRITE;
/*!40000 ALTER TABLE `user-session` DISABLE KEYS */;
INSERT INTO `user-session` VALUES (_binary '\0#\î\Â\İìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 16:11:38','2022-04-23 16:11:38',_binary '\0'),(_binary '\0]±.\í\İ\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-17 09:29:59','2022-06-17 09:29:59',_binary '\0'),(_binary '\0•\ëX™\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 10:37:50','2021-12-09 10:37:50',_binary '\0'),(_binary '\0·\"-İ–\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 16:21:26','2022-05-27 16:21:26',_binary '\0'),(_binary '\0Ã–\É+ºì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-13 08:10:41','2021-10-13 08:10:41',_binary '\0'),(_binary '\0Çº\Ô\Û\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 11:10:02','2022-05-24 11:10:02',_binary '\0'),(_binary '†¤m¿\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 08:32:47','2022-01-05 08:32:47',_binary '\0'),(_binary '¹1 \ñ\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-21 09:32:26','2022-06-21 09:32:26',_binary '\0'),(_binary 'q\Ç\íD\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-16 15:14:48','2022-06-16 15:14:48',_binary '\0'),(_binary 'U˜:\Â+ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-22 18:57:32','2022-04-22 18:57:32',_binary '\0'),(_binary '†¯I®?\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-28 10:30:19','2022-03-28 10:30:19',_binary '\0'),(_binary 'ş\ôŠg}\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-28 09:25:16','2021-12-28 09:25:16',_binary '\0'),(_binary '…Éƒ\È\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-02-02 09:32:40','2022-02-02 09:32:40',_binary '\0'),(_binary '^…·A)\ì˜\ö8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-09 14:48:14','2021-11-09 14:48:14',_binary '\0'),(_binary 'ª¾•¹ø\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 08:32:20','2022-04-12 08:32:20',_binary '\0'),(_binary '\ïK	\Øì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-20 13:59:30','2022-05-20 13:59:30',_binary '\0'),(_binary 'z©\İn\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 11:35:12','2022-05-27 11:35:12',_binary '\0'),(_binary 'Z¤,\Øì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-14 18:18:03','2021-10-14 18:18:03',_binary '\0'),(_binary 'm\ÍxQ®ì¾¯8\"\â#€ª',_binary 'lŒ>Q®ì¾¯8\"\â#€ª','2021-11-30 15:20:38','2021-11-30 15:20:38',_binary '\0'),(_binary '™\n!‡ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-30 08:40:32','2021-09-30 08:40:32',_binary '\0'),(_binary '~\æ\è\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-08 13:01:12','2022-06-08 13:01:12',_binary '\0'),(_binary '¯\ÅT\Â\ÙìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 15:43:08','2022-04-23 15:43:08',_binary '\0'),(_binary 'Ø¢/\è–\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 16:19:16','2022-06-10 16:19:16',_binary '\0'),(_binary '\í³]‹\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-15 17:40:20','2021-12-15 17:40:20',_binary '\0'),(_binary '™\ö\rşYì¶8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-08 08:58:04','2022-07-08 08:58:04',_binary '\0'),(_binary '±^´{\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-05 08:55:01','2022-04-05 08:55:01',_binary '\0'),(_binary '\ì&n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-06 11:09:12','2022-01-06 11:09:12',_binary '\0'),(_binary 'EH†,–ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-14 10:25:42','2021-10-14 10:25:42',_binary '\0'),(_binary 'd<!Cšì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-12 17:22:16','2021-11-12 17:22:16',_binary '\0'),(_binary 'û¥*\ç\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-09 09:03:53','2022-06-09 09:03:53',_binary '\0'),(_binary 'E ı\ë¦\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 13:51:27','2022-06-14 13:51:27',_binary '\0'),(_binary '¹4	\'%ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-07 12:14:15','2021-10-07 12:14:15',_binary '\0'),(_binary '\ê_\Û \ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 13:11:57','2022-05-24 13:11:57',_binary '\0'),(_binary '	3©mÜ¥\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-26 11:36:32','2022-05-26 11:36:32',_binary '\0'),(_binary '	;WÖº/\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 15:06:12','2022-04-12 15:06:12',_binary '\0'),(_binary '\na\÷ \Öì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-29 11:33:41','2021-09-29 11:33:41',_binary '\0'),(_binary '\nƒ\Ğ\ĞìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 12:38:30','2022-05-10 12:38:30',_binary '\0'),(_binary '\n\â\r°¿ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-18 20:28:24','2022-04-18 20:28:24',_binary '\0'),(_binary 'Ó—µp\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 14:08:57','2022-04-06 14:08:57',_binary '\0'),(_binary '‘=Á\ĞìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-22 08:06:23','2022-04-22 08:06:23',_binary '\0'),(_binary '¿ü™³º\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-04 09:53:38','2022-04-04 09:53:38',_binary '\0'),(_binary '\àœo¿ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-19 11:23:13','2022-04-19 11:23:13',_binary '\0'),(_binary '\õ\÷c}\Ë\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-25 18:39:17','2022-01-25 18:39:17',_binary '\0'),(_binary 'úL>ºK\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 18:26:42','2022-04-12 18:26:42',_binary '\0'),(_binary ' 9\n\ëŠ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 10:31:08','2022-06-14 10:31:08',_binary '\0'),(_binary 'Xû=\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-04 09:10:49','2021-11-04 09:10:49',_binary '\0'),(_binary 'b¨\ÊX˜\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 10:31:00','2021-12-09 10:31:00',_binary '\0'),(_binary '²±k·\"\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-08 17:55:41','2022-04-08 17:55:41',_binary '\0'),(_binary '\Ô\0\ÍoW\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-07 09:13:40','2022-01-07 09:13:40',_binary '\0'),(_binary 'âŸ™µ’\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 18:12:22','2022-04-06 18:12:22',_binary '\0'),(_binary '\rlN¾½ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-18 10:12:52','2022-04-18 10:12:52',_binary '\0'),(_binary '\rÿ\Î\Â\ÓìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-23 15:00:27','2022-04-23 15:00:27',_binary '\0'),(_binary 'œš°\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-30 16:40:29','2022-03-30 16:40:29',_binary '\0'),(_binary '\×û\ÌìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-05 09:31:15','2022-05-05 09:31:15',_binary '\0'),(_binary 'a\ZW\rì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:23:32','2021-12-07 11:23:32',_binary '\0'),(_binary 'Áaï¿•ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-19 11:59:06','2022-04-19 11:59:06',_binary '\0'),(_binary 'œ€\÷\à}\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-31 09:00:27','2022-05-31 09:00:27',_binary '\0'),(_binary '/\Ün/\ñ\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 16:54:56','2021-10-18 16:54:56',_binary '\0'),(_binary 'ˆQ/\ñ\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 16:54:56','2021-10-18 16:54:56',_binary '\0'),(_binary '\ÃG9*ıì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-12 09:38:15','2021-10-12 09:38:15',_binary '\0'),(_binary 'ù‹\'Oì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-07 17:15:09','2021-10-07 17:15:09',_binary '\0'),(_binary 'œƒË´{\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-05 08:55:22','2022-04-05 08:55:22',_binary '\0'),(_binary '€B{\Û$\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 13:40:53','2022-05-24 13:40:53',_binary '\0'),(_binary 'Ÿ\ÚÀ¶\ç\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 10:53:32','2022-04-08 10:53:32',_binary '\0'),(_binary '²Q’¶/\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-07 12:56:25','2022-04-07 12:56:25',_binary '\0'),(_binary '_=K\Ñ\ÙìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-12 17:51:22','2022-05-12 17:51:22',_binary '\0'),(_binary '½\ÆÕ¿ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-17 16:55:20','2022-05-17 16:55:20',_binary '\0'),(_binary '\öÓ¬°\Ş\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-31 18:34:02','2022-03-31 18:34:02',_binary '\0'),(_binary '5\ï@*\ì˜\ö8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-08 08:23:23','2021-11-08 08:23:23',_binary '\0'),(_binary 't\çû\Ğ\ÒìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-11 10:28:46','2022-05-11 10:28:46',_binary '\0'),(_binary '\ç·\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 17:20:09','2022-04-08 17:20:09',_binary '\0'),(_binary '#wZ\ì_\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-15 11:56:07','2022-06-15 11:56:07',_binary '\0'),(_binary 'Z\õ\å±e\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 10:40:26','2022-04-01 10:40:26',_binary '\0'),(_binary 'µ\âW\ê\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:45:45','2021-12-08 13:45:45',_binary '\0'),(_binary 'I] ¥¦\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-17 11:55:31','2022-03-17 11:55:31',_binary '\0'),(_binary 'n…G\Û \ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 13:12:22','2022-05-24 13:12:22',_binary '\0'),(_binary '“\æ†AE\ì˜\ö8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-09 18:09:14','2021-11-09 18:09:14',_binary '\0'),(_binary '¦\Û\Ñ\Å\àìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-27 12:11:20','2022-04-27 12:11:20',_binary '\0'),(_binary 'ß£\î \êì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-29 13:57:13','2021-09-29 13:57:13',_binary '\0'),(_binary '4¡}\Û\ã\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 12:28:15','2022-05-25 12:28:15',_binary '\0'),(_binary 'sW\ë\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:52:58','2021-12-08 13:52:58',_binary '\0'),(_binary 'N%!\Ğì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-30 17:23:39','2021-09-30 17:23:39',_binary '\0'),(_binary '&gn\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-06 11:09:44','2022-01-06 11:09:44',_binary '\0'),(_binary 'J=m\è\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 13:26:56','2022-01-05 13:26:56',_binary '\0'),(_binary '\Ñ\ã*F”ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-16 12:17:24','2021-11-16 12:17:24',_binary '\0'),(_binary '\Zgg¦\ĞAìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-10 17:10:57','2022-05-10 17:10:57',_binary '\0'),(_binary 'IL\óì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-24 14:52:35','2021-11-24 14:52:35',_binary '\0'),(_binary '½\\>\'(ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-07 12:36:15','2021-10-07 12:36:15',_binary '\0'),(_binary 'Ø´™«\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-24 09:52:49','2022-03-24 09:52:49',_binary '\0'),(_binary '1\à!\Å\àìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-27 12:11:27','2022-04-27 12:11:27',_binary '\0'),(_binary '£\ğ5»¡\ì§b8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-14 11:15:18','2022-04-14 11:15:18',_binary '\0'),(_binary '¶\ğÛ±Q\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-01 08:17:27','2022-04-01 08:17:27',_binary '\0'),(_binary '\×!\å=\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-06 10:05:18','2022-06-06 10:05:18',_binary '\0'),(_binary '\äX“›ì™™8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-02-22 12:51:35','2022-02-22 12:51:35',_binary '\0'),(_binary 'úŸİˆ\ì­8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-27 14:42:01','2022-05-27 14:42:01',_binary '\0'),(_binary 'ŠµW\ë\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:53:06','2021-12-08 13:53:06',_binary '\0'),(_binary '\ójĞºJ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 18:20:03','2022-04-12 18:20:03',_binary '\0'),(_binary '\0‹\'\ÉìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-01 13:39:49','2022-05-01 13:39:49',_binary '\0'),(_binary '†$·\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-08 17:13:13','2022-04-08 17:13:13',_binary '\0'),(_binary 'HÌ¿•ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-19 11:59:32','2022-04-19 11:59:32',_binary '\0'),(_binary '–\È\í-½\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-15 21:38:02','2021-10-15 21:38:02',_binary '\0'),(_binary 'š²\ÇqìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-29 12:02:00','2022-04-29 12:02:00',_binary '\0'),(_binary '¦\İb\Õì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-16 18:44:10','2022-05-16 18:44:10',_binary '\0'),(_binary '±¶9ºK\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 18:27:14','2022-04-12 18:27:14',_binary '\0'),(_binary 'ı‘³\Û$\ì¶Á8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-24 13:41:12','2022-05-24 13:41:12',_binary '\0'),(_binary '\àG=\ã\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-05 10:50:22','2021-11-05 10:50:22',_binary '\0'),(_binary ' !\Ó\Ğ;ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-10 16:28:08','2022-05-10 16:28:08',_binary '\0'),(_binary 'tmz\ñ\ğ\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-22 13:56:56','2022-06-22 13:56:56',_binary '\0'),(_binary '|\Å\Ö,‘ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-14 09:50:35','2021-10-14 09:50:35',_binary '\0'),(_binary 'œ\ÖA\ÑìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-11 18:28:39','2022-05-11 18:28:39',_binary '\0'),(_binary '\ê^¹µT\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-06 10:49:05','2022-04-06 10:49:05',_binary '\0'),(_binary ' 2\Ş\ğd\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-20 14:42:16','2022-06-20 14:42:16',_binary '\0'),(_binary ' 9\Ö\õ»\â\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 19:00:41','2022-04-14 19:00:41',_binary '\0'),(_binary ' »#_\í\Û\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-17 09:16:34','2022-06-17 09:16:34',_binary '\0'),(_binary ' \â¬\Ü\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 17:14:49','2022-05-25 17:14:49',_binary '\0'),(_binary '!o—Ò Oì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-10 16:50:26','2022-03-10 16:50:26',_binary '\0'),(_binary '!Uc\n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-22 17:32:50','2021-12-22 17:32:50',_binary '\0'),(_binary '\"+\ğŸË˜ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-04 18:51:21','2022-05-04 18:51:21',_binary '\0'),(_binary '\"QN\ÛG:ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-17 08:05:55','2021-11-17 08:05:55',_binary '\0'),(_binary '\"\îz\ĞBìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-10 17:18:21','2022-05-10 17:18:21',_binary '\0'),(_binary '#E=\â\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-02 09:27:16','2022-06-02 09:27:16',_binary '\0'),(_binary '$0\0•QŒì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-30 11:18:08','2021-11-30 11:18:08',_binary '\0'),(_binary '$\Ü-»¡\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 11:15:32','2022-04-14 11:15:32',_binary '\0'),(_binary '$\ì!w\Û\ß\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 11:59:58','2022-05-25 11:59:58',_binary '\0'),(_binary '$\ñ­\à}\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-31 09:01:03','2022-05-31 09:01:03',_binary '\0'),(_binary '%[\Ó)£7\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-14 09:36:18','2022-03-14 09:36:18',_binary '\0'),(_binary '%\Ä3H\à‡\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-31 10:12:40','2022-05-31 10:12:40',_binary '\0'),(_binary '&ü\î#\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-17 17:52:07','2022-06-17 17:52:07',_binary '\0'),(_binary '&J\÷\Û\Ï\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 10:05:28','2022-05-25 10:05:28',_binary '\0'),(_binary '&µ„ÏƒìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-09 18:31:13','2022-05-09 18:31:13',_binary '\0'),(_binary '\'G\Û\ã\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 12:28:40','2022-05-25 12:28:40',_binary '\0'),(_binary '\'\÷”¯\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-29 11:41:44','2022-03-29 11:41:44',_binary '\0'),(_binary '\'júom¿\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 08:33:50','2022-01-05 08:33:50',_binary '\0'),(_binary '\'±›\'Ñ­ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-12 12:36:56','2022-05-12 12:36:56',_binary '\0'),(_binary '\'\Ş\ËR°\Ş\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-31 18:34:33','2022-03-31 18:34:33',_binary '\0'),(_binary '\'\ã†r\ó\ìª\Ø8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-24 17:08:04','2022-06-24 17:08:04',_binary '\0'),(_binary '(-=;/\ç\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 15:43:59','2021-10-18 15:43:59',_binary '\0'),(_binary '(2\Õz\Â\ÒìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-23 14:54:01','2022-04-23 14:54:01',_binary '\0'),(_binary '(´ı ì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-10 10:38:24','2022-03-10 10:38:24',_binary '\0'),(_binary '(\ô7\ò/ª\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 08:27:21','2021-10-18 08:27:21',_binary '\0'),(_binary ')ØŸ(ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 16:53:10','2021-10-08 16:53:10',_binary '\0'),(_binary '*,\Æî¼¦ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-15 18:23:59','2022-04-15 18:23:59',_binary '\0'),(_binary '*~\Æ\ÜìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-28 18:15:45','2022-04-28 18:15:45',_binary '\0'),(_binary '*\â—\à†\ì­8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-31 10:05:38','2022-05-31 10:05:38',_binary '\0'),(_binary '*\å{\á¿ìŒ˜8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-04-18 20:29:18','2022-04-18 20:29:18',_binary '\0'),(_binary '+º@m¾\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 08:26:48','2022-01-05 08:26:48',_binary '\0'),(_binary ',%·x£\ö\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-15 08:23:43','2022-03-15 08:23:43',_binary '\0'),(_binary ',qˆü¤\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-15 11:29:51','2022-03-15 11:29:51',_binary '\0'),(_binary ',–_g»\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-13 18:12:07','2022-04-13 18:12:07',_binary '\0'),(_binary '-\ìÌ¬»“\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 09:35:34','2022-04-14 09:35:34',_binary '\0'),(_binary '/Œøº\Ë\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-13 09:43:57','2022-04-13 09:43:57',_binary '\0'),(_binary '/\ô\ô»’\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 09:28:27','2022-04-14 09:28:27',_binary '\0'),(_binary '/0Á¯\Å\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-30 09:03:17','2022-03-30 09:03:17',_binary '\0'),(_binary '/B‘\ã\Ü\n\ì¶Á8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-25 17:08:04','2022-05-25 17:08:04',_binary '\0'),(_binary '/e\Æ\ò¿ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-19 11:09:54','2022-04-19 11:09:54',_binary '\0'),(_binary '/y‡t\Øı\ì˜ı8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-21 19:57:27','2022-05-21 19:57:27',_binary '\0'),(_binary '/V\r¦X\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-18 09:10:22','2022-03-18 09:10:22',_binary '\0'),(_binary '/»\rv¶\î\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 11:44:26','2022-04-08 11:44:26',_binary '\0'),(_binary '/şd\ß\Û\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 11:18:31','2022-05-24 11:18:31',_binary '\0'),(_binary '0RpÆ¦X\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-18 09:10:23','2022-03-18 09:10:23',_binary '\0'),(_binary '0SF\ì¦X\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-18 09:10:23','2022-03-18 09:10:23',_binary '\0'),(_binary '0b\îêµ–\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 18:42:00','2022-04-06 18:42:00',_binary '\0'),(_binary '1e±q\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-01 12:07:05','2022-04-01 12:07:05',_binary '\0'),(_binary '1\"¢^µ‚\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-06 16:18:51','2022-04-06 16:18:51',_binary '\0'),(_binary '13“¤\å:\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:44:23','2022-06-06 09:44:23',_binary '\0'),(_binary '1—¥\ÌìŒ˜8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-05 09:03:37','2022-05-05 09:03:37',_binary '\0'),(_binary '1\à!±\Ï=ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-09 10:10:27','2022-05-09 10:10:27',_binary '\0'),(_binary '2\Ì\éìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-06 11:04:08','2022-05-06 11:04:08',_binary '\0'),(_binary '2Ì±¼°‰\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-31 08:26:25','2022-03-31 08:26:25',_binary '\0'),(_binary '3N‹¤¿•ìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-19 12:00:07','2022-04-19 12:00:07',_binary '\0'),(_binary '3k–5Á]ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-21 18:24:18','2022-04-21 18:24:18',_binary '\0'),(_binary '3w3¥¦\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-17 11:56:18','2022-03-17 11:56:18',_binary '\0'),(_binary '4œ\Ğ\Ü\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 17:15:22','2022-05-25 17:15:22',_binary '\0'),(_binary '4·;\ĞÔ­ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-16 08:14:52','2022-05-16 08:14:52',_binary '\0'),(_binary '4ş0I\Í*ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-06 18:49:30','2022-05-06 18:49:30',_binary '\0'),(_binary '5„¶)\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-07 12:14:24','2022-04-07 12:14:24',_binary '\0'),(_binary '5NÔ®ì‡»8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-16 08:22:03','2022-05-16 08:22:03',_binary '\0'),(_binary '5\ëq[·\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-08 17:13:53','2022-04-08 17:13:53',_binary '\0'),(_binary '6jTZ\Ğ;ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 16:28:47','2022-05-10 16:28:47',_binary '\0'),(_binary '6½\ÈSNì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-02 16:59:53','2021-12-02 16:59:53',_binary '\0'),(_binary '6Ï³i&ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-06 18:14:38','2021-10-06 18:14:38',_binary '\0'),(_binary '7\êv\ğo\ì\÷8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-20 16:01:39','2022-06-20 16:01:39',_binary '\0'),(_binary '70œ,–ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-14 10:27:02','2021-10-14 10:27:02',_binary '\0'),(_binary '7Y%hE°ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-15 09:06:08','2021-11-15 09:06:08',_binary '\0'),(_binary '7c\ì¼\Û#\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 13:34:44','2022-05-24 13:34:44',_binary '\0'),(_binary '8w¸\Ò\å<\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-06 09:58:54','2022-06-06 09:58:54',_binary '\0'),(_binary '8Œ©NÜ¤\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-26 11:30:42','2022-05-26 11:30:42',_binary '\0'),(_binary '8³A²¨©\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-21 07:55:29','2022-03-21 07:55:29',_binary '\0'),(_binary '8Ç…R\ö­ì«ª8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-28 14:40:38','2022-06-28 14:40:38',_binary '\0'),(_binary '9t\Ú\ö¯\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-29 11:42:14','2022-03-29 11:42:14',_binary '\0'),(_binary ':\Ø\÷ÿ”\ì‘y8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-09 22:34:23','2022-07-09 22:34:23',_binary '\0'),(_binary ';ÿb\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-21 10:46:43','2021-12-21 10:46:43',_binary '\0'),(_binary '<%\êg\È9ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-30 11:54:28','2022-04-30 11:54:28',_binary '\0'),(_binary '<f\Î\Ã\Òoì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-13 11:46:13','2022-05-13 11:46:13',_binary '\0'),(_binary '<½E¥ \ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-17 11:13:37','2022-03-17 11:13:37',_binary '\0'),(_binary '==L—\'Eì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-07 16:04:47','2021-10-07 16:04:47',_binary '\0'),(_binary '=K¦\õ¹\õ\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-12 08:12:28','2022-04-12 08:12:28',_binary '\0'),(_binary '=\Ïû«¹\÷\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 08:26:48','2022-04-12 08:26:48',_binary '\0'),(_binary '=üVE\à‡\ì­8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-31 10:13:20','2022-05-31 10:13:20',_binary '\0'),(_binary '>š+\öºI\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 18:13:48','2022-04-12 18:13:48',_binary '\0'),(_binary '?/\ò8\É\îìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-02 16:02:44','2022-05-02 16:02:44',_binary '\0'),(_binary '?4¡´-¼\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-15 21:31:47','2021-10-15 21:31:47',_binary '\0'),(_binary '?f*\Â\ÓìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-23 15:01:49','2022-04-23 15:01:49',_binary '\0'),(_binary '?h‚z\å=\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:06:16','2022-06-06 10:06:16',_binary '\0'),(_binary '?–5	\É\ÆìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-02 11:16:24','2022-05-02 11:16:24',_binary '\0'),(_binary '@Ë˜ìŒ˜8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-04 18:52:11','2022-05-04 18:52:11',_binary '\0'),(_binary '@%ij\æ\Ü\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-08 11:36:58','2022-06-08 11:36:58',_binary '\0'),(_binary '@*\ïÈ¤¿\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-16 08:23:06','2022-03-16 08:23:06',_binary '\0'),(_binary '@´¥ÑìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-12 09:10:03','2022-05-12 09:10:03',_binary '\0'),(_binary '@\Û\Èş\×\ğì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-20 11:52:22','2022-05-20 11:52:22',_binary '\0'),(_binary 'A0!\\•\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-14 12:21:05','2021-12-14 12:21:05',_binary '\0'),(_binary 'A*F;¼]ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-15 09:42:05','2022-04-15 09:42:05',_binary '\0'),(_binary 'Am\"\İ{\ì­8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-27 13:09:59','2022-05-27 13:09:59',_binary '\0'),(_binary 'AÁ\'®\ò\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-29 07:53:25','2022-03-29 07:53:25',_binary '\0'),(_binary 'B‡‚\ë‘\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 11:22:46','2022-06-14 11:22:46',_binary '\0'),(_binary 'B³Ö­\×ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-19 09:23:17','2022-05-19 09:23:17',_binary '\0'),(_binary 'C~a-µo\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-06 14:03:21','2022-04-06 14:03:21',_binary '\0'),(_binary 'C¿D»\Õ\ì§b8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-14 17:28:38','2022-04-14 17:28:38',_binary '\0'),(_binary 'DhÔ¬¤A\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-15 17:21:16','2022-03-15 17:21:16',_binary '\0'),(_binary 'Dœ%ı½\ì„8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-07 14:23:08','2022-07-07 14:23:08',_binary '\0'),(_binary 'D¶w©³\Í\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-04 12:11:14','2022-04-04 12:11:14',_binary '\0'),(_binary 'E\Úø\ĞBìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 17:19:18','2022-05-10 17:19:18',_binary '\0'),(_binary 'EŠF£\ö\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-15 08:24:26','2022-03-15 08:24:26',_binary '\0'),(_binary 'FN\è\çÔ°ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-16 08:36:50','2022-05-16 08:36:50',_binary '\0'),(_binary 'F«±¨/«\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 08:35:21','2021-10-18 08:35:21',_binary '\0'),(_binary 'F\Ö+»±q\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-01 12:07:41','2022-04-01 12:07:41',_binary '\0'),(_binary 'G\r\Ú\Æø<\ì¢ 8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-30 14:17:11','2022-06-30 14:17:11',_binary '\0'),(_binary 'H\İ\öÇ”ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-29 16:13:41','2022-04-29 16:13:41',_binary '\0'),(_binary 'H\è\×}\Í\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-25 18:55:17','2022-01-25 18:55:17',_binary '\0'),(_binary 'H8|\õÁ\ì¾8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-27 10:31:43','2022-06-27 10:31:43',_binary '\0'),(_binary 'HŠ!\"W\ê\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:47:09','2021-12-08 13:47:09',_binary '\0'),(_binary 'H˜nœ,\Òì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-14 17:37:01','2021-10-14 17:37:01',_binary '\0'),(_binary 'Ij\çw¨¹\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-21 09:50:29','2022-03-21 09:50:29',_binary '\0'),(_binary 'I–\â*°‰\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-31 08:27:03','2022-03-31 08:27:03',_binary '\0'),(_binary 'IĞ¬²Q¼ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-30 17:02:47','2021-11-30 17:02:47',_binary '\0'),(_binary 'J	\ãX\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 11:15:41','2021-12-09 11:15:41',_binary '\0'),(_binary 'Jb\ğµªC\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-23 08:50:52','2022-03-23 08:50:52',_binary '\0'),(_binary 'J…ª+*ûì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-12 09:25:31','2021-10-12 09:25:31',_binary '\0'),(_binary 'J§Æ¥¦\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-17 11:56:57','2022-03-17 11:56:57',_binary '\0'),(_binary 'J\Î\ô)»\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-13 18:12:58','2022-04-13 18:12:58',_binary '\0'),(_binary 'K}\ÒÁ]ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-21 18:24:58','2022-04-21 18:24:58',_binary '\0'),(_binary 'K\Âitü-\ì™v8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-05 14:40:01','2022-07-05 14:40:01',_binary '\0'),(_binary 'LJs \Çì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-29 09:48:08','2021-09-29 09:48:08',_binary '\0'),(_binary 'L\"_2&Lì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-06 10:22:47','2021-10-06 10:22:47',_binary '\0'),(_binary 'M(+ ì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-10 08:23:25','2022-03-10 08:23:25',_binary '\0'),(_binary 'M>\0:Ü¤\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-26 11:31:17','2022-05-26 11:31:17',_binary '\0'),(_binary 'MW<Kºù\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-13 15:14:04','2022-04-13 15:14:04',_binary '\0'),(_binary 'M\Æ8\éşì¶8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-08 15:19:28','2022-07-08 15:19:28',_binary '\0'),(_binary 'Nªİ“¥–\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-17 10:02:32','2022-03-17 10:02:32',_binary '\0'),(_binary 'O\Z¤¶\Ì\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 07:41:55','2022-04-08 07:41:55',_binary '\0'),(_binary 'O\İ\ê>¿ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 20:30:20','2022-04-18 20:30:20',_binary '\0'),(_binary 'PKø\õ\Û$\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 13:42:35','2022-05-24 13:42:35',_binary '\0'),(_binary 'Q¸\Ô;»†\ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-14 08:03:31','2022-04-14 08:03:31',_binary '\0'),(_binary 'Q\×$·\Û#\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 13:35:28','2022-05-24 13:35:28',_binary '\0'),(_binary 'R^\Æªì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-25 10:43:10','2021-09-25 10:43:10',_binary '\0'),(_binary 'RˆUÇ”ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 16:13:59','2022-04-29 16:13:59',_binary '\0'),(_binary 'R\ñ¶Ç¯\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-29 10:24:13','2022-03-29 10:24:13',_binary '\0'),(_binary 'SV—¥\'#ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-07 12:02:01','2021-10-07 12:02:01',_binary '\0'),(_binary 'S`\'ÀRìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-20 10:33:56','2022-04-20 10:33:56',_binary '\0'),(_binary 'SdeÈ·\"\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 17:57:39','2022-04-08 17:57:39',_binary '\0'),(_binary 'SüY%³\Í\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-04 12:11:40','2022-04-04 12:11:40',_binary '\0'),(_binary 'T\'X8·\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 17:29:03','2022-04-08 17:29:03',_binary '\0'),(_binary 'T9½em\Ä\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 09:10:53','2022-01-05 09:10:53',_binary '\0'),(_binary 'TK8†\â\ñ\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-03 11:57:47','2022-06-03 11:57:47',_binary '\0'),(_binary 'TÎ® \nì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-10 08:37:56','2022-03-10 08:37:56',_binary '\0'),(_binary 'T¢\ğSì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-02 11:24:17','2021-12-02 11:24:17',_binary '\0'),(_binary 'T¯\Ãø\Ğ\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-01 07:56:59','2022-07-01 07:56:59',_binary '\0'),(_binary 'T\Æ\óG»‰\ì§b8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-14 08:25:04','2022-04-14 08:25:04',_binary '\0'),(_binary 'UH+pË–ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-04 18:38:27','2022-05-04 18:38:27',_binary '\0'),(_binary 'U†ü\Ğøì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-24 13:29:05','2021-09-24 13:29:05',_binary '\0'),(_binary 'U¢/}Ò—ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-13 16:33:16','2022-05-13 16:33:16',_binary '\0'),(_binary 'V@ı@Y\ì˜\ö8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-08 14:01:38','2021-11-08 14:01:38',_binary '\0'),(_binary 'V¹„U2\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-21 08:46:33','2021-10-21 08:46:33',_binary '\0'),(_binary 'W\n*İŠ\ì­8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-27 14:57:57','2022-05-27 14:57:57',_binary '\0'),(_binary 'W\Z*„\ÆìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-27 16:37:58','2022-04-27 16:37:58',_binary '\0'),(_binary 'W^¡³*\ñì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-12 08:14:18','2021-10-12 08:14:18',_binary '\0'),(_binary 'WF\áS\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-01 10:34:20','2022-06-01 10:34:20',_binary '\0'),(_binary 'X\Z6±q\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 12:08:10','2022-04-01 12:08:10',_binary '\0'),(_binary 'Xh\Ã+\É\ÆìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-02 11:17:06','2022-05-02 11:17:06',_binary '\0'),(_binary 'XP\èP\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 08:00:32','2022-06-10 08:00:32',_binary '\0'),(_binary 'Ye°\å<\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:59:49','2022-06-06 09:59:49',_binary '\0'),(_binary 'Y\à™¯¾\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-30 08:14:21','2022-03-30 08:14:21',_binary '\0'),(_binary 'Y#´\â·\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-08 17:22:01','2022-04-08 17:22:01',_binary '\0'),(_binary 'YŸ%\èa\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-10 10:02:15','2022-06-10 10:02:15',_binary '\0'),(_binary 'Y£ü*\Û\Ô\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 10:42:42','2022-05-25 10:42:42',_binary '\0'),(_binary 'Y\ä«	7\Õ\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-28 17:56:41','2021-10-28 17:56:41',_binary '\0'),(_binary 'Yı]°/\â\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 15:09:36','2021-10-18 15:09:36',_binary '\0'),(_binary 'Z¥Dº\ÇtìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-29 12:25:09','2022-04-29 12:25:09',_binary '\0'),(_binary '[M…¾\ÊìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-18 11:48:06','2022-04-18 11:48:06',_binary '\0'),(_binary '[{\ä\ñ\Í\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-22 09:48:04','2022-06-22 09:48:04',_binary '\0'),(_binary '[š\ãµ\×ì‡»8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-19 09:23:58','2022-05-19 09:23:58',_binary '\0'),(_binary '[¬\÷Á\áìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-22 10:10:19','2022-04-22 10:10:19',_binary '\0'),(_binary '[\ÅeÈµ‚\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 16:20:03','2022-04-06 16:20:03',_binary '\0'),(_binary '\\„+¹?\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-11 10:30:32','2022-04-11 10:30:32',_binary '\0'),(_binary '\\\ğ\Ö1<•\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-03 19:01:14','2021-11-03 19:01:14',_binary '\0'),(_binary ']0VCü\ò\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-06 14:10:41','2022-07-06 14:10:41',_binary '\0'),(_binary '];­\ÛÔ­ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-16 08:16:00','2022-05-16 08:16:00',_binary '\0'),(_binary ']h\ãN»ˆ\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 08:18:09','2022-04-14 08:18:09',_binary '\0'),(_binary ']’\ÜC¾°ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 08:42:03','2022-04-18 08:42:03',_binary '\0'),(_binary ']±²ß°‰\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-31 08:27:37','2022-03-31 08:27:37',_binary '\0'),(_binary '^-\İ{\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 13:10:47','2022-05-27 13:10:47',_binary '\0'),(_binary '^-ş¨\È1ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-30 10:58:10','2022-04-30 10:58:10',_binary '\0'),(_binary '^G1FÑ‰ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-12 08:20:46','2022-05-12 08:20:46',_binary '\0'),(_binary '^\\®\á\İ{\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 13:10:47','2022-05-27 13:10:47',_binary '\0'),(_binary '^Ïƒº¿¤ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-19 13:48:42','2022-04-19 13:48:42',_binary '\0'),(_binary '_I\Û#\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 13:35:50','2022-05-24 13:35:50',_binary '\0'),(_binary '_k\â³ (ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-28 14:50:31','2021-09-28 14:50:31',_binary '\0'),(_binary '_\ÛB´®\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-05 15:02:36','2022-04-05 15:02:36',_binary '\0'),(_binary 'a\ÔC]\ß\Ì\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-30 11:55:44','2022-05-30 11:55:44',_binary '\0'),(_binary 'bW¾\å=\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:07:14','2022-06-06 10:07:14',_binary '\0'),(_binary 'bW\ß\å=\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:07:14','2022-06-06 10:07:14',_binary '\0'),(_binary 'bl \İq\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 11:59:19','2022-05-27 11:59:19',_binary '\0'),(_binary 'bm\ä\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 13:00:21','2022-01-05 13:00:21',_binary '\0'),(_binary 'b—dº\Ë\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-13 09:45:23','2022-04-13 09:45:23',_binary '\0'),(_binary 'b\ÂÀ\ÊÒ–ì‡»8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-13 16:26:28','2022-05-13 16:26:28',_binary '\0'),(_binary 'b\òI½W\ë\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:55:03','2021-12-08 13:55:03',_binary '\0'),(_binary 'cG\Ì\ì^\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-15 11:51:07','2022-06-15 11:51:07',_binary '\0'),(_binary 'c*\rÁ¥†\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-17 08:08:34','2022-03-17 08:08:34',_binary '\0'),(_binary 'c.~\òÁ\éìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-22 11:07:47','2022-04-22 11:07:47',_binary '\0'),(_binary 'c^d¦W\ç\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:26:25','2021-12-08 13:26:25',_binary '\0'),(_binary 'cdü¼(ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 16:40:27','2021-10-08 16:40:27',_binary '\0'),(_binary 'c§—±P\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 08:12:16','2022-04-01 08:12:16',_binary '\0'),(_binary 'c\Ô\åı£B\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-14 10:56:47','2022-03-14 10:56:47',_binary '\0'),(_binary 'd†i¼UìŒ˜8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-04-15 08:45:48','2022-04-15 08:45:48',_binary '\0'),(_binary 'd\ÃL²¹ø\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-12 08:35:03','2022-04-12 08:35:03',_binary '\0'),(_binary 'dÛ²\Æ\Û3\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-24 15:30:32','2022-05-24 15:30:32',_binary '\0'),(_binary 'd\àAÜ¤\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-26 11:31:56','2022-05-26 11:31:56',_binary '\0'),(_binary 'd\ã™r¿wìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-19 08:26:45','2022-04-19 08:26:45',_binary '\0'),(_binary 'e=\è~ ì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-10 09:42:50','2022-03-10 09:42:50',_binary '\0'),(_binary 'eMD_¿•ìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-19 12:01:31','2022-04-19 12:01:31',_binary '\0'),(_binary 'ea“9\Û$\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 13:43:10','2022-05-24 13:43:10',_binary '\0'),(_binary 'ev\å¡\Ä\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-12 13:22:22','2022-03-12 13:22:22',_binary '\0'),(_binary 'e„y\ê\í\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-13 15:49:47','2022-06-13 15:49:47',_binary '\0'),(_binary 'f§È¢¶\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-13 18:14:42','2022-03-13 18:14:42',_binary '\0'),(_binary 'f:)W½\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 08:25:51','2021-12-08 08:25:51',_binary '\0'),(_binary 'gÜ°c¡\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-23 11:35:41','2021-12-23 11:35:41',_binary '\0'),(_binary 'gBş .ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-28 15:33:41','2021-09-28 15:33:41',_binary '\0'),(_binary 'giY\Ü\n\ì¶Á8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-25 17:09:38','2022-05-25 17:09:38',_binary '\0'),(_binary 'gx\ê \×ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-19 09:52:56','2022-05-19 09:52:56',_binary '\0'),(_binary 'h0Ö±\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 14:03:09','2022-04-01 14:03:09',_binary '\0'),(_binary 'h…¾Å·\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 17:15:18','2022-04-08 17:15:18',_binary '\0'),(_binary 'hûÿQ¾\ÂìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 10:51:13','2022-04-18 10:51:13',_binary '\0'),(_binary 'iOo/\î\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-18 16:35:55','2021-10-18 16:35:55',_binary '\0'),(_binary 'iœ\ßİˆ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 14:44:09','2022-05-27 14:44:09',_binary '\0'),(_binary 'j\ÉF ¨½\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-21 10:20:03','2022-03-21 10:20:03',_binary '\0'),(_binary 'j\ö(\ì\'\Êì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 07:58:07','2021-10-08 07:58:07',_binary '\0'),(_binary 'k\ô\\n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-06 09:31:50','2022-01-06 09:31:50',_binary '\0'),(_binary 'lø`\Â\ÌìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 14:12:58','2022-04-23 14:12:58',_binary '\0'),(_binary 'l\'ª.\Â+ìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-22 19:00:29','2022-04-22 19:00:29',_binary '\0'),(_binary 'lq5\óË™ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-04 19:00:35','2022-05-04 19:00:35',_binary '\0'),(_binary 'm3¯½\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-30 08:07:45','2022-03-30 08:07:45',_binary '\0'),(_binary 'm7J\r»†\ì§b8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-14 08:04:17','2022-04-14 08:04:17',_binary '\0'),(_binary 'n¦\\\÷V\ì’P8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-29 10:51:52','2022-06-29 10:51:52',_binary '\0'),(_binary 'n&UkP\Èì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-29 11:57:11','2021-11-29 11:57:11',_binary '\0'),(_binary 'n—bCiì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-12 11:34:24','2021-11-12 11:34:24',_binary '\0'),(_binary 'n\ŞË¾úìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-18 17:32:15','2022-04-18 17:32:15',_binary '\0'),(_binary 'n\ãZh¹…\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-11 18:52:08','2022-04-11 18:52:08',_binary '\0'),(_binary 'o)©O\Ç]ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-29 09:41:05','2022-04-29 09:41:05',_binary '\0'),(_binary 'o.˜‚«\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-24 08:22:05','2022-03-24 08:22:05',_binary '\0'),(_binary 'o£‹\åK5ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-22 09:42:21','2021-11-22 09:42:21',_binary '\0'),(_binary 'p…D“\ÖDì‡»8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-18 08:49:57','2022-05-18 08:49:57',_binary '\0'),(_binary 'q3Ë¤4\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-15 15:49:28','2022-03-15 15:49:28',_binary '\0'),(_binary 'q\é\ìn\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-15 13:46:03','2022-06-15 13:46:03',_binary '\0'),(_binary 'q–\ëÄ±u\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-01 12:37:31','2022-04-01 12:37:31',_binary '\0'),(_binary 'q¹$\Ü!šì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-30 10:59:35','2021-09-30 10:59:35',_binary '\0'),(_binary 'so£ZH\Ñì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-19 08:41:36','2021-11-19 08:41:36',_binary '\0'),(_binary 's’\áı¥£\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-17 11:36:37','2022-03-17 11:36:37',_binary '\0'),(_binary 't5\Ûo\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 22:40:27','2022-05-24 22:40:27',_binary '\0'),(_binary 't>*!›ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-30 11:06:49','2021-09-30 11:06:49',_binary '\0'),(_binary 'tJN£>\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-14 10:28:37','2022-03-14 10:28:37',_binary '\0'),(_binary 't^¦¯ÁìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-21 10:55:08','2022-04-21 10:55:08',_binary '\0'),(_binary 'u\"\ì±P\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-01 08:12:46','2022-04-01 08:12:46',_binary '\0'),(_binary 'u#\'\Ç\æ\Ô\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-08 10:41:11','2022-06-08 10:41:11',_binary '\0'),(_binary 'wAXh,\Óì–½8\"\â#€ª',_binary 'w?A\",\Óì–½8\"\â#€ª','2021-10-14 17:45:29','2021-10-14 17:45:29',_binary '\0'),(_binary 'wyNº\Í\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-13 10:00:17','2022-04-13 10:00:17',_binary '\0'),(_binary 'w\ç	\ò\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-23 09:04:44','2022-06-23 09:04:44',_binary '\0'),(_binary 'wî•» \ä\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-11 10:39:26','2022-03-11 10:39:26',_binary '\0'),(_binary 'w\ò\İ>AD\ì˜\ö8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-09 18:04:46','2021-11-09 18:04:46',_binary '\0'),(_binary 'xE%³\Í\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-04 12:12:40','2022-04-04 12:12:40',_binary '\0'),(_binary 'xx\ï8›\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-29 17:34:53','2021-10-29 17:34:53',_binary '\0'),(_binary 'xøƒ\Ü\ì¶Á8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-25 16:05:41','2022-05-25 16:05:41',_binary '\0'),(_binary 'yK\ÙdNrì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-26 12:36:50','2021-11-26 12:36:50',_binary '\0'),(_binary 'y¦5Å¶\è\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-08 11:03:33','2022-04-08 11:03:33',_binary '\0'),(_binary 'y\÷C€Ñ‰ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-12 08:21:32','2022-05-12 08:21:32',_binary '\0'),(_binary 'zc,r°ˆ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-31 08:21:15','2022-03-31 08:21:15',_binary '\0'),(_binary 'zyu7ü\Ê\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-06 09:25:11','2022-07-06 09:25:11',_binary '\0'),(_binary 'zŠ8\Æ\nìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-27 17:14:44','2022-04-27 17:14:44',_binary '\0'),(_binary 'z\÷F\ÑìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 17:41:06','2022-05-11 17:41:06',_binary '\0'),(_binary 'zú\Ç\Å\É\ÃìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-02 10:56:36','2022-05-02 10:56:36',_binary '\0'),(_binary 'zü?\íP«ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-29 08:29:57','2021-11-29 08:29:57',_binary '\0'),(_binary '{9ùx‡ì™™8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-02-17 08:20:59','2022-02-17 08:20:59',_binary '\0'),(_binary '{¢§¤Á\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-16 08:39:04','2022-03-16 08:39:04',_binary '\0'),(_binary '{„\ô0¹\ò\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 07:52:44','2022-04-12 07:52:44',_binary '\0'),(_binary '|Rü´\Â\ÒìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 14:56:22','2022-04-23 14:56:22',_binary '\0'),(_binary '|[]\Ğ\ÃìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-11 08:44:16','2022-05-11 08:44:16',_binary '\0'),(_binary '|g”¶\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-07 10:43:20','2022-04-07 10:43:20',_binary '\0'),(_binary '|\ØøT±\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-01 14:03:44','2022-04-01 14:03:44',_binary '\0'),(_binary '|\ö\Âb\×ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-19 09:53:32','2022-05-19 09:53:32',_binary '\0'),(_binary '}8\ñ‡ß²\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-30 08:50:23','2022-05-30 08:50:23',_binary '\0'),(_binary '}[n†ş¬ì¶8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-08 18:55:33','2022-07-08 18:55:33',_binary '\0'),(_binary '}\ö\åU\Û\à\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 12:09:37','2022-05-25 12:09:37',_binary '\0'),(_binary '~L\Ş7¶/\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-07 12:59:24','2022-04-07 12:59:24',_binary '\0'),(_binary '~lg\Û#\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-24 13:36:43','2022-05-24 13:36:43',_binary '\0'),(_binary 'V½\Ü\Û\Ş\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 11:55:20','2022-05-25 11:55:20',_binary '\0'),(_binary 'xi›;º\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-02 16:54:33','2021-11-02 16:54:33',_binary '\0'),(_binary '\Å\Ìrn\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-06 09:32:23','2022-01-06 09:32:23',_binary '\0'),(_binary '\ô\ã\ã¤\È\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-16 09:29:18','2022-03-16 09:29:18',_binary '\0'),(_binary '€qt3Qrì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-30 08:14:36','2021-11-30 08:14:36',_binary '\0'),(_binary '€…Q6\Û\ì¶Á8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-24 11:13:36','2022-05-24 11:13:36',_binary '\0'),(_binary '€\ìÀ^ &ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-28 14:37:08','2021-09-28 14:37:08',_binary '\0'),(_binary '9t\à†\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-31 10:08:03','2022-05-31 10:08:03',_binary '\0'),(_binary 'Wi¤\Æ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-16 09:15:02','2022-03-16 09:15:02',_binary '\0'),(_binary 'ÿ8ı•\ì„8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-07 09:38:31','2022-07-07 09:38:31',_binary '\0'),(_binary '‚2à¼¾\ÈìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-18 11:34:52','2022-04-18 11:34:52',_binary '\0'),(_binary '‚Ÿ\Æ[±t\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 12:30:50','2022-04-01 12:30:50',_binary '\0'),(_binary '‚¾$ƒ¶ı\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-08 13:34:07','2022-04-08 13:34:07',_binary '\0'),(_binary 'ƒ\'\Ì\â¶ \ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-07 11:12:09','2022-04-07 11:12:09',_binary '\0'),(_binary 'ƒBkœ-[\ìŒ\Ú8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-15 09:59:20','2021-10-15 09:59:20',_binary '\0'),(_binary 'ƒs2\n\åB\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:43:57','2022-06-06 10:43:57',_binary '\0'),(_binary 'ƒ„…ã©\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-22 11:23:59','2022-03-22 11:23:59',_binary '\0'),(_binary 'ƒ“I±¼\\ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-15 09:36:47','2022-04-15 09:36:47',_binary '\0'),(_binary '„–½2\Í\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-22 08:18:01','2021-10-22 08:18:01',_binary '\0'),(_binary '„©Xs\Â\ÕìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-23 15:18:05','2022-04-23 15:18:05',_binary '\0'),(_binary '„·œ3\\“\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-14 12:08:39','2021-12-14 12:08:39',_binary '\0'),(_binary '„\ÕŠCªì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-12 19:20:19','2021-11-12 19:20:19',_binary '\0'),(_binary '„\Ú,AK5ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-22 09:42:57','2021-11-22 09:42:57',_binary '\0'),(_binary '…\04\ÑìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 18:24:20','2022-05-11 18:24:20',_binary '\0'),(_binary '…50¶ø\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-08 12:58:24','2022-04-08 12:58:24',_binary '\0'),(_binary '…u\É\'¾\ÂìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-18 10:52:01','2022-04-18 10:52:01',_binary '\0'),(_binary '…¬j\ö~ì«ª8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-28 09:06:21','2022-06-28 09:06:21',_binary '\0'),(_binary '†j\ÄU;\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-01 20:52:09','2021-11-01 20:52:09',_binary '\0'),(_binary '†|Ü†³\Í\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-04 12:13:04','2022-04-04 12:13:04',_binary '\0'),(_binary '†=£\ô\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-15 08:11:56','2022-03-15 08:11:56',_binary '\0'),(_binary '‡jtº\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 10:09:05','2022-04-12 10:09:05',_binary '\0'),(_binary 'ˆ,Ô‹\ÖCì‡»8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-18 08:43:27','2022-05-18 08:43:27',_binary '\0'),(_binary 'ˆT@TX\Ë\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 16:39:33','2021-12-09 16:39:33',_binary '\0'),(_binary '‰	¿Ú±{\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 13:21:07','2022-04-01 13:21:07',_binary '\0'),(_binary '‰\ì!\Ä\ÖBì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-18 08:36:21','2022-05-18 08:36:21',_binary '\0'),(_binary 'Š{DW\rì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:27:01','2021-12-07 11:27:01',_binary '\0'),(_binary 'Š¦\Zk\Û#\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 13:37:03','2022-05-24 13:37:03',_binary '\0'),(_binary 'Š\Úv\É\ÃìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-02 10:57:02','2022-05-02 10:57:02',_binary '\0'),(_binary 'Š\á\öf¼[ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-15 09:29:49','2022-04-15 09:29:49',_binary '\0'),(_binary '‹²\Ö\ã¬\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-04 10:17:54','2022-06-04 10:17:54',_binary '\0'),(_binary '‹4¶A\Û\÷\ì¶Á8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-25 14:54:38','2022-05-25 14:54:38',_binary '\0'),(_binary '‹ƒ\ò®¶\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-07 10:43:45','2022-04-07 10:43:45',_binary '\0'),(_binary '‹–ş\Ña\õ\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-21 08:32:57','2021-12-21 08:32:57',_binary '\0'),(_binary '‹ H0\Ã\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-19 18:01:36','2021-10-19 18:01:36',_binary '\0'),(_binary 'Œ·\ñW\ê\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:49:02','2021-12-08 13:49:02',_binary '\0'),(_binary 'Œs	z³\Å\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-04 11:15:58','2022-04-04 11:15:58',_binary '\0'),(_binary 'Œ¸w¹\õ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 08:14:42','2022-04-12 08:14:42',_binary '\0'),(_binary 'Œ\ëh±r\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-01 12:16:49','2022-04-01 12:16:49',_binary '\0'),(_binary '¹r¦ /ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-28 15:41:55','2021-09-28 15:41:55',_binary '\0'),(_binary 'Ê–1F•ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-16 12:27:48','2021-11-16 12:27:48',_binary '\0'),(_binary '\÷x\ËÔ­ì‡»8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-16 08:17:21','2022-05-16 08:17:21',_binary '\0'),(_binary '¸AHHì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-18 16:21:40','2021-11-18 16:21:40',_binary '\0'),(_binary 'A®Ü¤\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-26 11:33:06','2022-05-26 11:33:06',_binary '\0'),(_binary 'c\ÎN\Û\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 11:28:19','2022-05-24 11:28:19',_binary '\0'),(_binary '–y\å?\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:22:47','2022-06-06 10:22:47',_binary '\0'),(_binary '(r\ÑìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-11 17:41:40','2022-05-11 17:41:40',_binary '\0'),(_binary '0:\Ş\ĞHìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 18:04:20','2022-05-10 18:04:20',_binary '\0'),(_binary 'À¾¾\ÊìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 11:49:34','2022-04-18 11:49:34',_binary '\0'),(_binary ',,‹\Û$\ì¶Á8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-24 13:44:22','2022-05-24 13:44:22',_binary '\0'),(_binary '^#È©‡\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-22 10:27:04','2022-03-22 10:27:04',_binary '\0'),(_binary '½ª!º\Ë\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-13 09:46:41','2022-04-13 09:46:41',_binary '\0'),(_binary 'Õ§¨\ÌXìŒ˜8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-05 17:48:50','2022-05-05 17:48:50',_binary '\0'),(_binary '‘&ÿÁµV\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-06 11:06:34','2022-04-06 11:06:34',_binary '\0'),(_binary '‘‹‡[ ì§…8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-10 09:44:04','2022-03-10 09:44:04',_binary '\0'),(_binary '‘\î\Û®ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-25 11:13:35','2021-09-25 11:13:35',_binary '\0'),(_binary '’ˆ	.!ˆì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-30 08:51:39','2021-09-30 08:51:39',_binary '\0'),(_binary '’\Û@\ĞAìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 17:14:19','2022-05-10 17:14:19',_binary '\0'),(_binary '“pV’ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-06 20:46:47','2021-12-06 20:46:47',_binary '\0'),(_binary '“¸¥µŒ\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-06 17:33:10','2022-04-06 17:33:10',_binary '\0'),(_binary '“FŠz\'\áì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 10:43:53','2021-10-08 10:43:53',_binary '\0'),(_binary '”•hÿ\ë¦\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 13:55:23','2022-06-14 13:55:23',_binary '\0'),(_binary '”\ä\Ñ\ZìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 19:07:43','2022-05-11 19:07:43',_binary '\0'),(_binary '•Mz­Á!ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-21 11:17:32','2022-04-21 11:17:32',_binary '\0'),(_binary '•” ~I\Şì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-20 16:48:08','2021-11-20 16:48:08',_binary '\0'),(_binary '•¸.K°\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-30 18:53:08','2022-03-30 18:53:08',_binary '\0'),(_binary '•\ä¡\ã¹-\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-11 08:23:18','2022-04-11 08:23:18',_binary '\0'),(_binary '–B9\â \ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-02 11:03:32','2022-06-02 11:03:32',_binary '\0'),(_binary '–\ÊZ+¾\÷ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 17:11:53','2022-04-18 17:11:53',_binary '\0'),(_binary '–\ía\×ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-24 09:34:41','2021-09-24 09:34:41',_binary '\0'),(_binary '—Z\ÓJº0\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 15:17:20','2022-04-12 15:17:20',_binary '\0'),(_binary '—–¢\Û\Ş\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 11:56:01','2022-05-25 11:56:01',_binary '\0'),(_binary '˜Ahq¹\õ\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 08:15:01','2022-04-12 08:15:01',_binary '\0'),(_binary '˜`\rY\åû\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-07 08:48:49','2022-06-07 08:48:49',_binary '\0'),(_binary '˜—¼ÁìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-21 08:47:18','2022-04-21 08:47:18',_binary '\0'),(_binary '˜µe2µT\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 10:52:28','2022-04-06 10:52:28',_binary '\0'),(_binary '™’Ç“Ô­ì‡»8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-16 08:17:41','2022-05-16 08:17:41',_binary '\0'),(_binary 'šDP\âË˜ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-04 18:54:42','2022-05-04 18:54:42',_binary '\0'),(_binary 'š“‡A\'\Üì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 10:08:18','2021-10-08 10:08:18',_binary '\0'),(_binary 'šè§¾»\Ú\ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-14 18:06:51','2022-04-14 18:06:51',_binary '\0'),(_binary '›\Ø%ÀºI\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 18:16:25','2022-04-12 18:16:25',_binary '\0'),(_binary 'œb\â\ĞBìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-10 17:21:45','2022-05-10 17:21:45',_binary '\0'),(_binary 'œ\Ã\Ë\Ã\Ô\Æì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-16 11:16:44','2022-05-16 11:16:44',_binary '\0'),(_binary 'œÅ”\ìÜ¤\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-26 11:33:30','2022-05-26 11:33:30',_binary '\0'),(_binary 'œ\ÏT#\å;\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-06 09:54:33','2022-06-06 09:54:33',_binary '\0'),(_binary 'œ\íKIª>\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-23 08:17:23','2022-03-23 08:17:23',_binary '\0'),(_binary '\Ô|\íV\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-16 17:28:00','2022-06-16 17:28:00',_binary '\0'),(_binary 'Rq µn\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 13:58:43','2022-04-06 13:58:43',_binary '\0'),(_binary 'O—G´{\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-05 08:59:17','2022-04-05 08:59:17',_binary '\0'),(_binary 'ªjU\Ú5\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-23 09:13:57','2022-05-23 09:13:57',_binary '\0'),(_binary '\â¦\Ë\ìn\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-15 13:47:19','2022-06-15 13:47:19',_binary '\0'),(_binary 'Ÿ\ë\ğ‚\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-20 18:20:34','2022-06-20 18:20:34',_binary '\0'),(_binary 'Ÿ5¤\ñ\Ğ;ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-10 16:31:43','2022-05-10 16:31:43',_binary '\0'),(_binary 'Ÿ€;­±{\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-01 13:21:45','2022-04-01 13:21:45',_binary '\0'),(_binary ' R>¨\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-06 10:24:10','2021-11-06 10:24:10',_binary '\0'),(_binary ' ÈŠV\Û\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 09:34:18','2022-05-24 09:34:18',_binary '\0'),(_binary ' \Òi¯\Ü\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-25 17:25:33','2022-05-25 17:25:33',_binary '\0'),(_binary '¡\0Z	¾\ÂìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 10:52:47','2022-04-18 10:52:47',_binary '\0'),(_binary '¡€\Û\÷\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 14:55:14','2022-05-25 14:55:14',_binary '\0'),(_binary '¢Y\"£\ô\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-15 08:12:43','2022-03-15 08:12:43',_binary '\0'),(_binary '¢h¨u*ûì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-12 09:27:59','2021-10-12 09:27:59',_binary '\0'),(_binary '¢v³\Õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-24 09:20:42','2021-09-24 09:20:42',_binary '\0'),(_binary '¢²\åg½\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-28 17:07:51','2021-12-28 17:07:51',_binary '\0'),(_binary '¢\Ñ:µ;\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-01 20:52:56','2021-11-01 20:52:56',_binary '\0'),(_binary '¢û›‰±V\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-01 08:57:00','2022-04-01 08:57:00',_binary '\0'),(_binary '£-¸¯\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-29 11:38:02','2022-03-29 11:38:02',_binary '\0'),(_binary '£n*É¹†\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-11 19:00:46','2022-04-11 19:00:46',_binary '\0'),(_binary '£oY#¼UìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-15 08:47:34','2022-04-15 08:47:34',_binary '\0'),(_binary '¤fk\æ\Û\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-24 11:28:56','2022-05-24 11:28:56',_binary '\0'),(_binary '¤ş–€\Û\Ô\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 10:44:48','2022-05-25 10:44:48',_binary '\0'),(_binary '¥\ñøÏº0\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 15:17:44','2022-04-12 15:17:44',_binary '\0'),(_binary '¦Nˆ¶*\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-07 12:24:43','2022-04-07 12:24:43',_binary '\0'),(_binary '¦\ÑWB\ÖDì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-18 08:51:28','2022-05-18 08:51:28',_binary '\0'),(_binary '§Lúx\Â\ÕìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 15:19:03','2022-04-23 15:19:03',_binary '\0'),(_binary '§šê— ì§…8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-10 08:54:35','2022-03-10 08:54:35',_binary '\0'),(_binary '§\×Ï‰¹/\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-11 08:38:07','2022-04-11 08:38:07',_binary '\0'),(_binary '¨N\É\ÇìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-02 11:26:29','2022-05-02 11:26:29',_binary '\0'),(_binary '¨jTdXš\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 10:49:41','2021-12-09 10:49:41',_binary '\0'),(_binary '¨\î\áH\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-01 09:17:52','2022-06-01 09:17:52',_binary '\0'),(_binary '¨Â\0´\í¶ª8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-11 08:59:04','2022-07-11 08:59:04',_binary '\0'),(_binary '¨\Ã\'‚\×ì‡»8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-19 09:54:46','2022-05-19 09:54:46',_binary '\0'),(_binary '©C\nHşì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-19 14:05:13','2021-11-19 14:05:13',_binary '\0'),(_binary '©Hµ\Û\ã\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-25 12:32:18','2022-05-25 12:32:18',_binary '\0'),(_binary '©¥\Ñ\×ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-12 17:41:12','2022-05-12 17:41:12',_binary '\0'),(_binary '©]\Ò~J\ì­\Z8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-26 09:52:47','2022-01-26 09:52:47',_binary '\0'),(_binary '©¤¦eÔ­ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-16 08:18:08','2022-05-16 08:18:08',_binary '\0'),(_binary '©û(P¥¡\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-17 11:23:50','2022-03-17 11:23:50',_binary '\0'),(_binary 'ªO‡µ\ë\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 11:18:30','2022-06-14 11:18:30',_binary '\0'),(_binary 'ª°¤v\Ô\Æì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-16 11:17:07','2022-05-16 11:17:07',_binary '\0'),(_binary '«­\ZµŒ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-06 17:33:51','2022-04-06 17:33:51',_binary '\0'),(_binary '«92=\ìN\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-15 09:58:36','2022-06-15 09:58:36',_binary '\0'),(_binary '®#\Ï\àƒ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-31 09:47:50','2022-05-31 09:47:50',_binary '\0'),(_binary '®8q¤\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-15 11:04:51','2022-03-15 11:04:51',_binary '\0'),(_binary '®bù6\æ\Ñ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-08 10:21:18','2022-06-08 10:21:18',_binary '\0'),(_binary '¯K\Ñ\à†\ì­8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-31 10:09:21','2022-05-31 10:09:21',_binary '\0'),(_binary '¯Qÿj®C\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-28 11:03:46','2022-03-28 11:03:46',_binary '\0'),(_binary '°ƒŸÔ­ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-16 08:18:18','2022-05-16 08:18:18',_binary '\0'),(_binary '°†¦\Ì8ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-05 14:00:38','2022-05-05 14:00:38',_binary '\0'),(_binary '°9®g\åB\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:45:12','2022-06-06 10:45:12',_binary '\0'),(_binary '±<bdX—\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 10:28:27','2021-12-09 10:28:27',_binary '\0'),(_binary '±¥&pÁ\ììŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-22 11:31:27','2022-04-22 11:31:27',_binary '\0'),(_binary '±\Óm­ÑŠìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-12 08:30:16','2022-05-12 08:30:16',_binary '\0'),(_binary '²Z_\Ğ\ÚìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-11 11:30:25','2022-05-11 11:30:25',_binary '\0'),(_binary '²øFgº\Ê\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-13 09:40:29','2022-04-13 09:40:29',_binary '\0'),(_binary '³$’€\É\ÈìŒ˜8\"\â#€ª',_binary '³#%2\É\ÈìŒ˜8\"\â#€ª','2022-05-02 11:33:57','2022-05-02 11:33:57',_binary '\0'),(_binary '³\Ù8\\\\À\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-14 17:32:06','2021-12-14 17:32:06',_binary '\0'),(_binary '´Fş^\Ù\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-17 09:36:06','2021-12-17 09:36:06',_binary '\0'),(_binary '´Ô¯\Ğ;ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 16:32:19','2022-05-10 16:32:19',_binary '\0'),(_binary 'µCŠÀ\íB\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-16 15:05:30','2022-06-16 15:05:30',_binary '\0'),(_binary 'µ¶ık\áC\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-01 08:42:26','2022-06-01 08:42:26',_binary '\0'),(_binary '¶I\ÉB¾\ÂìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-18 10:53:23','2022-04-18 10:53:23',_binary '\0'),(_binary '¶±—=”ì™™8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-02-23 16:07:58','2022-02-23 16:07:58',_binary '\0'),(_binary '¶ü|V\Ü\ì¶Á8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-25 17:40:29','2022-05-25 17:40:29',_binary '\0'),(_binary '·J¸\èo\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-10 11:45:05','2022-06-10 11:45:05',_binary '\0'),(_binary '·›ø˜û{\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-04 17:28:52','2022-07-04 17:28:52',_binary '\0'),(_binary '¸W]%E­ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-15 08:48:16','2021-11-15 08:48:16',_binary '\0'),(_binary '¸ZFV\å?\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-06 10:23:58','2022-06-06 10:23:58',_binary '\0'),(_binary '¸{° ¼ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-29 08:32:26','2021-09-29 08:32:26',_binary '\0'),(_binary '¹Pı_\æ\Ñ\ì­8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-06-08 10:21:37','2022-06-08 10:21:37',_binary '\0'),(_binary 'º\'\ì	\ÑìŒ˜8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-11 18:04:20','2022-05-11 18:04:20',_binary '\0'),(_binary 'º6†¶\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-07 11:06:32','2022-04-07 11:06:32',_binary '\0'),(_binary 'º¤?Gm\ä\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 13:02:49','2022-01-05 13:02:49',_binary '\0'),(_binary 'º­”W\rì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:28:21','2021-12-07 11:28:21',_binary '\0'),(_binary 'º\óÔ²\ÏLìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-09 12:01:40','2022-05-09 12:01:40',_binary '\0'),(_binary '»_Ğ¿\åB\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-06 10:45:31','2022-06-06 10:45:31',_binary '\0'),(_binary '»Å•ºÁ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-13 08:36:17','2022-04-13 08:36:17',_binary '\0'),(_binary '¼U\İk¯\Ì\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-30 09:57:20','2022-03-30 09:57:20',_binary '\0'),(_binary '¼nÛ\Ğ\ÕìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 10:54:54','2022-05-11 10:54:54',_binary '\0'),(_binary '¼¥\Z[º\á\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-13 12:25:23','2022-04-13 12:25:23',_binary '\0'),(_binary '¼\Ú\÷´\Û$\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-24 13:45:37','2022-05-24 13:45:37',_binary '\0'),(_binary '½¤\à”\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-31 11:49:57','2022-05-31 11:49:57',_binary '\0'),(_binary '½\â§Jİ‘\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-27 15:50:56','2022-05-27 15:50:56',_binary '\0'),(_binary '½\ô\ë\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 11:19:03','2022-06-14 11:19:03',_binary '\0'),(_binary '¾`¤\é\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-16 13:27:16','2022-03-16 13:27:16',_binary '\0'),(_binary '¾«I¬CMì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-12 08:16:13','2021-11-12 08:16:13',_binary '\0'),(_binary '¾«\ÃWWì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:35:38','2021-12-07 11:35:38',_binary '\0'),(_binary '¿\r\ã\Û\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-24 11:08:12','2022-05-24 11:08:12',_binary '\0'),(_binary '¿Y~C\åB\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:45:38','2022-06-06 10:45:38',_binary '\0'),(_binary '¿Ñ\×ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-19 09:48:14','2022-05-19 09:48:14',_binary '\0'),(_binary '¿É»ºÀ\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-13 08:29:15','2022-04-13 08:29:15',_binary '\0'),(_binary '¿\õ±Ï¯\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-29 11:24:32','2022-03-29 11:24:32',_binary '\0'),(_binary 'À\ãr\èp\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-10 11:52:31','2022-06-10 11:52:31',_binary '\0'),(_binary 'Áëª»\á\ì§b8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-04-14 18:58:02','2022-04-14 18:58:02',_binary '\0'),(_binary 'Á­£@\â\ó\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-03 12:15:09','2022-06-03 12:15:09',_binary '\0'),(_binary 'Á\Ãú{-Z\ìŒ\Ú8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-15 09:53:56','2021-10-15 09:53:56',_binary '\0'),(_binary 'Á\È\âı¾úìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-18 17:34:34','2022-04-18 17:34:34',_binary '\0'),(_binary '\Â»\Ğ\ÂìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 08:39:03','2022-05-11 08:39:03',_binary '\0'),(_binary 'Â…¼,\ÏLìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-09 12:01:52','2022-05-09 12:01:52',_binary '\0'),(_binary 'Â–ÀV»\Õ\ì§b8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-14 17:32:10','2022-04-14 17:32:10',_binary '\0'),(_binary 'Â·\Ê\Ó\×ì‡»8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-19 10:02:39','2022-05-19 10:02:39',_binary '\0'),(_binary '\Â\÷\éa\É\ÖìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-02 13:14:37','2022-05-02 13:14:37',_binary '\0'),(_binary '\Ãµ1“\ì²f8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-20 18:52:04','2021-10-20 18:52:04',_binary '\0'),(_binary '\ÃD×§Ngì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-26 11:20:10','2021-11-26 11:20:10',_binary '\0'),(_binary '\Ãi8¯ü\Ç\ì¾\È8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-06 09:05:44','2022-07-06 09:05:44',_binary '\0'),(_binary 'Ã†,n¾\ÄìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 11:08:04','2022-04-18 11:08:04',_binary '\0'),(_binary 'Ã\ĞYc\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-10 10:49:15','2021-12-10 10:49:15',_binary '\0'),(_binary 'Ã¦&\Ë:ª\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-01 08:29:24','2021-11-01 08:29:24',_binary '\0'),(_binary '\ÃÁ:n\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-06 11:07:21','2022-01-06 11:07:21',_binary '\0'),(_binary '\Ã\Ş9¹:ª\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-01 08:29:24','2021-11-01 08:29:24',_binary '\0'),(_binary '\Ã\é\ğ\ç\Û\ö\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 14:49:03','2022-05-25 14:49:03',_binary '\0'),(_binary '\Ä?\ÌÀ]ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-20 11:55:49','2022-04-20 11:55:49',_binary '\0'),(_binary '\Å8’\èn\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 11:38:19','2022-06-10 11:38:19',_binary '\0'),(_binary '\ÅD/Ÿ‹ì§…8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-09 17:32:00','2022-03-09 17:32:00',_binary '\0'),(_binary 'Å†\äoW½\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 08:28:31','2021-12-08 08:28:31',_binary '\0'),(_binary '\Åû\åS\Õì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-03 09:10:15','2021-12-03 09:10:15',_binary '\0'),(_binary '\Æ^\ã=Ü¨\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-26 12:03:18','2022-05-26 12:03:18',_binary '\0'),(_binary '\Æ\Ñ\ÚK\'\Ëì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 08:07:50','2021-10-08 08:07:50',_binary '\0'),(_binary '\Æ\á]İ¿’ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-19 11:42:46','2022-04-19 11:42:46',_binary '\0'),(_binary '\Æ\ìµ	Frì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-16 08:18:51','2021-11-16 08:18:51',_binary '\0'),(_binary '\Ç:\Óû]B\ìª\á8\"\â#€ª',_binary '\Ç9h¡]B\ìª\á8\"\â#€ª','2021-12-15 09:03:13','2021-12-15 09:03:13',_binary '\0'),(_binary '\Ç\ä§¼UìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-15 08:48:35','2022-04-15 08:48:35',_binary '\0'),(_binary '\È:^\æ\Ñ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-08 10:22:02','2022-06-08 10:22:02',_binary '\0'),(_binary '\È\Â`W\rì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:28:44','2021-12-07 11:28:44',_binary '\0'),(_binary '\È:\"î¹†\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-11 19:01:47','2022-04-11 19:01:47',_binary '\0'),(_binary '\ÈH•\ÂL\Ñì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-24 10:54:03','2021-11-24 10:54:03',_binary '\0'),(_binary '\É0Q4\è†\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 14:30:14','2022-06-10 14:30:14',_binary '\0'),(_binary '\Éy£g¶û\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 13:21:47','2022-04-08 13:21:47',_binary '\0'),(_binary 'Éƒ\'\É\ÖìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-02 13:14:48','2022-05-02 13:14:48',_binary '\0'),(_binary 'É¯7Ë–ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-04 18:41:43','2022-05-04 18:41:43',_binary '\0'),(_binary 'É²”Ö¶û\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-08 13:21:47','2022-04-08 13:21:47',_binary '\0'),(_binary '\Ê%n5¿{ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-19 08:58:13','2022-04-19 08:58:13',_binary '\0'),(_binary 'Ê£O Nì§…8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-10 16:48:00','2022-03-10 16:48:00',_binary '\0'),(_binary '\Ë\ÜÁ\Ü\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 17:41:03','2022-05-25 17:41:03',_binary '\0'),(_binary '\ËK­\ê\å?\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 10:24:29','2022-06-06 10:24:29',_binary '\0'),(_binary 'Ë\\V¾¼ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-18 10:11:01','2022-04-18 10:11:01',_binary '\0'),(_binary 'Ë fb¼\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-22 08:19:15','2021-12-22 08:19:15',_binary '\0'),(_binary '\ÌTz\'\õì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-08 13:08:39','2021-10-08 13:08:39',_binary '\0'),(_binary '\ÌÛšYT\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-10 09:02:09','2021-12-10 09:02:09',_binary '\0'),(_binary '\Í\Ô\È1ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-30 11:01:16','2022-04-30 11:01:16',_binary '\0'),(_binary '\Í@R\ì^\ì­8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-06-15 11:54:05','2022-06-15 11:54:05',_binary '\0'),(_binary 'ÍšW¦\Ü\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 17:26:48','2022-05-25 17:26:48',_binary '\0'),(_binary '\Í\Ê)cû4\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-04 09:01:15','2022-07-04 09:01:15',_binary '\0'),(_binary '\ÎSM]\ÖAì‡»8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-18 08:31:06','2022-05-18 08:31:06',_binary '\0'),(_binary '\Îc`\ô\á\\\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-01 11:42:05','2022-06-01 11:42:05',_binary '\0'),(_binary 'Î®–•¼\\ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-15 09:38:53','2022-04-15 09:38:53',_binary '\0'),(_binary '\ĞLG¶¤\Æ\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-16 09:17:14','2022-03-16 09:17:14',_binary '\0'),(_binary 'Ğ†k»µ’\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-06 18:17:50','2022-04-06 18:17:50',_binary '\0'),(_binary '\Ñ?Nø\ì¢ 8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-30 09:06:05','2022-06-30 09:06:05',_binary '\0'),(_binary '\Òp\Õ{\"ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-01 16:23:14','2021-10-01 16:23:14',_binary '\0'),(_binary '\Ò\õ Ô­ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-16 08:19:17','2022-05-16 08:19:17',_binary '\0'),(_binary '\Ó\Úù\ë\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 11:19:39','2022-06-14 11:19:39',_binary '\0'),(_binary '\Ó@\ÏÜ¦\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-26 11:49:20','2022-05-26 11:49:20',_binary '\0'),(_binary '\ÓU\Ë\æ\Ñ\ì­8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-06-08 10:22:20','2022-06-08 10:22:20',_binary '\0'),(_binary '\Ô8—\ìn\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-15 13:48:49','2022-06-15 13:48:49',_binary '\0'),(_binary '\Ôn\å\ê]<\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-15 08:20:38','2021-12-15 08:20:38',_binary '\0'),(_binary 'Ô†\Ì{» \ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-14 11:13:17','2022-04-14 11:13:17',_binary '\0'),(_binary 'Ô«sù\ĞAìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-10 17:16:10','2022-05-10 17:16:10',_binary '\0'),(_binary '\ÕZ\Èûm\ì³8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-04 15:49:28','2022-07-04 15:49:28',_binary '\0'),(_binary '\Õf¿£5\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-14 09:26:54','2022-03-14 09:26:54',_binary '\0'),(_binary '\Õ?\Ô¿’ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-19 11:43:10','2022-04-19 11:43:10',_binary '\0'),(_binary '\Õ|A’\Öì™™8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-02-21 13:26:34','2022-02-21 13:26:34',_binary '\0'),(_binary 'Õ¸³50\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-25 09:14:00','2021-10-25 09:14:00',_binary '\0'),(_binary '\ÕÀ,\Ì(ìŒ˜8\"\â#€ª',_binary 'Õ½².\Ì(ìŒ˜8\"\â#€ª','2022-05-05 12:07:09','2022-05-05 12:07:09',_binary '\0'),(_binary '\Õ\é½\Ë;\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-01 20:04:16','2021-11-01 20:04:16',_binary '\0'),(_binary '\Ö×‘\Û\ì¶Á8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-24 11:08:52','2022-05-24 11:08:52',_binary '\0'),(_binary '\×$¹\í\ÉÁìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-02 10:44:51','2022-05-02 10:44:51',_binary '\0'),(_binary '\×C\èm\ë\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-05 13:53:43','2022-01-05 13:53:43',_binary '\0'),(_binary '\×|\ØV\Ü\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 16:08:21','2022-05-25 16:08:21',_binary '\0'),(_binary '\Ø\ö,\Î\ò\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-22 18:34:08','2022-06-22 18:34:08',_binary '\0'),(_binary '\Ù{\ó!\õ\ì¹	8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-26 13:00:07','2022-06-26 13:00:07',_binary '\0'),(_binary 'Ù\ÂJ\\~\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-14 09:40:42','2021-12-14 09:40:42',_binary '\0'),(_binary '\ÛDµ‘\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-06 18:10:59','2022-04-06 18:10:59',_binary '\0'),(_binary '\Ûc*ÿì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-12 09:58:12','2021-10-12 09:58:12',_binary '\0'),(_binary '\Û\ã`¬¯\Ì\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-30 09:58:13','2022-03-30 09:58:13',_binary '\0'),(_binary '\ÜC\ÄZFtì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-16 08:33:46','2021-11-16 08:33:46',_binary '\0'),(_binary '\Ü~\ân\æ\Æ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-08 09:03:51','2022-06-08 09:03:51',_binary '\0'),(_binary 'Ü™„£Á\ÒìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-22 08:26:32','2022-04-22 08:26:32',_binary '\0'),(_binary '\Ü\Õxúº¼\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-13 08:01:26','2022-04-13 08:01:26',_binary '\0'),(_binary '\Ü\î^ŸTì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-03 16:20:23','2021-12-03 16:20:23',_binary '\0'),(_binary '\Ü\ïG¶K\òì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-23 08:18:20','2021-11-23 08:18:20',_binary '\0'),(_binary '\Ş[×¢X\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 11:12:40','2021-12-09 11:12:40',_binary '\0'),(_binary '\Ş\ê¬\ê®\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-13 08:22:12','2022-06-13 08:22:12',_binary '\0'),(_binary '\ßVUÒ–ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-13 16:29:57','2022-05-13 16:29:57',_binary '\0'),(_binary 'ß½\÷\ß\è]\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 09:37:22','2022-06-10 09:37:22',_binary '\0'),(_binary '\ßÁ¨¹¼]ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-15 09:46:31','2022-04-15 09:46:31',_binary '\0'),(_binary '\ß\âÕ \ĞAìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-10 17:16:28','2022-05-10 17:16:28',_binary '\0'),(_binary '\à\Ä\÷X„\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 08:13:46','2021-12-09 08:13:46',_binary '\0'),(_binary '\à\á±<b\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-03 12:59:51','2021-11-03 12:59:51',_binary '\0'),(_binary '\à\ìSzù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-01 16:57:47','2022-07-01 16:57:47',_binary '\0'),(_binary '\á\ò\ë\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 11:20:02','2022-06-14 11:20:02',_binary '\0'),(_binary '\á_J\rW\é\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-08 13:44:16','2021-12-08 13:44:16',_binary '\0'),(_binary '\á”\â\Û\ö\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 14:49:53','2022-05-25 14:49:53',_binary '\0'),(_binary '\á\à3\Û\ó›\ìª\Ø8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-24 16:58:57','2022-06-24 16:58:57',_binary '\0'),(_binary '\á\à‘\ğ»\Õ\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 17:33:03','2022-04-14 17:33:03',_binary '\0'),(_binary '\á\èú³\ÑìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 17:22:30','2022-05-11 17:22:30',_binary '\0'),(_binary '\áû´Œ±V\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-01 08:58:45','2022-04-01 08:58:45',_binary '\0'),(_binary '\â(r\ÊÊ’ìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-03 11:41:14','2022-05-03 11:41:14',_binary '\0'),(_binary '\â9\ÜÁ¼UìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-15 08:49:19','2022-04-15 08:49:19',_binary '\0'),(_binary '\â¦U«¹H\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-11 11:38:43','2022-04-11 11:38:43',_binary '\0'),(_binary '\âÈ„H%ì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-18 12:13:29','2021-11-18 12:13:29',_binary '\0'),(_binary '\äúx\ìn\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-15 13:49:15','2022-06-15 13:49:15',_binary '\0'),(_binary '\ä%qÀ\Ü\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 17:41:45','2022-05-25 17:41:45',_binary '\0'),(_binary '\äX\Í\Â\ÛìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-23 16:03:42','2022-04-23 16:03:42',_binary '\0'),(_binary '\å{\'ş\÷x\ì’P8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-29 14:58:35','2022-06-29 14:58:35',_binary '\0'),(_binary 'å‚‰‘\ÑìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-11 18:27:02','2022-05-11 18:27:02',_binary '\0'),(_binary '\å\ÇAŠ\Â\ÔìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 15:13:38','2022-04-23 15:13:38',_binary '\0'),(_binary '\å\Ö2\Ònì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-13 11:43:48','2022-05-13 11:43:48',_binary '\0'),(_binary '\æ\"\áWì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:36:44','2021-12-07 11:36:44',_binary '\0'),(_binary '\æIg¹I\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-11 11:45:58','2022-04-11 11:45:58',_binary '\0'),(_binary '\æL•kºI\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 18:18:30','2022-04-12 18:18:30',_binary '\0'),(_binary '\æ†À‚oV\ì°	8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-01-07 09:12:36','2022-01-07 09:12:36',_binary '\0'),(_binary 'æ©ƒ\ğ\æ\Ñ\ì­8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-06-08 10:22:53','2022-06-08 10:22:53',_binary '\0'),(_binary '\çœ\×\õ\ì\ì¾8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-27 15:43:58','2022-06-27 15:43:58',_binary '\0'),(_binary '\ç¼H\ÇrìŒ˜8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-04-29 12:14:45','2022-04-29 12:14:45',_binary '\0'),(_binary '\çB\×\÷Ü¤\ì­8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-26 11:35:35','2022-05-26 11:35:35',_binary '\0'),(_binary '\ç\İÔ‹\É\ÇìŒ˜8\"\â#€ª',_binary '\çÛ‚\Ó\É\ÇìŒ˜8\"\â#€ª','2022-05-02 11:28:16','2022-05-02 11:28:16',_binary '\0'),(_binary '\èo™\÷LEì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-23 18:12:47','2021-11-23 18:12:47',_binary '\0'),(_binary '\é`Í¥¥\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-17 11:54:14','2022-03-17 11:54:14',_binary '\0'),(_binary '\é“^ß»\Ú\ì§b8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-14 18:09:03','2022-04-14 18:09:03',_binary '\0'),(_binary '\ë\'}­–\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-27 14:27:04','2022-03-27 14:27:04',_binary '\0'),(_binary '\ë“f\Ò\ò\ì\÷8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-22 18:06:01','2022-06-22 18:06:01',_binary '\0'),(_binary '\ë—IˆÁ\ÕìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-22 08:48:26','2022-04-22 08:48:26',_binary '\0'),(_binary '\ë\è\ĞıX„\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 08:14:05','2021-12-09 08:14:05',_binary '\0'),(_binary '\í0m\İ\óš\ìª\Ø8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-24 16:52:07','2022-06-24 16:52:07',_binary '\0'),(_binary '\í‡\åÎ¥”\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-17 09:52:40','2022-03-17 09:52:40',_binary '\0'),(_binary '\í®ˆºJ\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 18:25:51','2022-04-12 18:25:51',_binary '\0'),(_binary '\î¹-\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-11 08:25:46','2022-04-11 08:25:46',_binary '\0'),(_binary '\îIX\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-09 11:13:07','2021-12-09 11:13:07',_binary '\0'),(_binary '\ï>ÒYj\ìª\á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-10 11:40:35','2021-12-10 11:40:35',_binary '\0'),(_binary '\ï­Sj¶O\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-07 16:51:38','2022-04-07 16:51:38',_binary '\0'),(_binary '\ïºC\õ8š\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-29 17:31:03','2021-10-29 17:31:03',_binary '\0'),(_binary '\ğ“ Sì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-02 08:36:49','2021-12-02 08:36:49',_binary '\0'),(_binary '\ğ@¾\Ğ\Û\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-24 11:31:03','2022-05-24 11:31:03',_binary '\0'),(_binary '\ğkeŸ¯\Ì\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-30 09:58:48','2022-03-30 09:58:48',_binary '\0'),(_binary '\ğŸÊ½\Û\ì¶Á8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-05-24 13:11:16','2022-05-24 13:11:16',_binary '\0'),(_binary '\ğ\Ã0lQì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-30 10:05:07','2021-11-30 10:05:07',_binary '\0'),(_binary '\ñ¬­Mì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-25 07:55:03','2021-11-25 07:55:03',_binary '\0'),(_binary '\ñe€Wì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-07 11:22:43','2021-12-07 11:22:43',_binary '\0'),(_binary '\ñH3h\æ\Ñ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-08 10:23:11','2022-06-08 10:23:11',_binary '\0'),(_binary '\ñŠ\â\ñ\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-03 12:02:10','2022-06-03 12:02:10',_binary '\0'),(_binary '\ñÍ©\Í\â\ä\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-03 10:29:07','2022-06-03 10:29:07',_binary '\0'),(_binary '\ñ\ğ(5/\ì\ò8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-25 09:07:38','2021-10-25 09:07:38',_binary '\0'),(_binary '\ò0Ÿ\ÑìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-11 17:22:57','2022-05-11 17:22:57',_binary '\0'),(_binary '\ò[§\â\èf\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 10:42:19','2022-06-10 10:42:19',_binary '\0'),(_binary '\òg8\È>\ì\ä8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-06 09:14:53','2021-11-06 09:14:53',_binary '\0'),(_binary '\òtÁ*\Ğ\ÑìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-11 10:27:47','2022-05-11 10:27:47',_binary '\0'),(_binary '\ò\òHi\èo\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-10 11:46:45','2022-06-10 11:46:45',_binary '\0'),(_binary '\ó\"\ç\àx\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-31 08:31:02','2022-05-31 08:31:02',_binary '\0'),(_binary '\ósfŸ\í\Û\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-17 09:22:27','2022-06-17 09:22:27',_binary '\0'),(_binary '\ó³û´v\ì™(8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-04-05 08:25:52','2022-04-05 08:25:52',_binary '\0'),(_binary '\ó»T\Û\ì¶Á8\"\â#€ª',_binary '•K|Á!ìŒ˜8\"\â#€ª','2022-05-24 11:09:40','2022-05-24 11:09:40',_binary '\0'),(_binary '\ôºù\ì‚Q8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-07-01 16:01:04','2022-07-01 16:01:04',_binary '\0'),(_binary '\ôÄœØ¹/\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-11 08:40:16','2022-04-11 08:40:16',_binary '\0'),(_binary '\ô\Í\ÖY\ì]\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-15 11:48:02','2022-06-15 11:48:02',_binary '\0'),(_binary '\õƒ\Û\Û\ì¶Á8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-25 11:37:09','2022-05-25 11:37:09',_binary '\0'),(_binary '\õL\'iÜ¤\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-26 11:35:58','2022-05-26 11:35:58',_binary '\0'),(_binary '\õŠ\òµ&ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-06 18:34:17','2021-10-06 18:34:17',_binary '\0'),(_binary '\õ\èP)\å;\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:57:03','2022-06-06 09:57:03',_binary '\0'),(_binary '\õ\éQ\å;\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:57:03','2022-06-06 09:57:03',_binary '\0'),(_binary '\õé™­\å;\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:57:03','2022-06-06 09:57:03',_binary '\0'),(_binary '\õ\ê;\æ\å;\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:57:03','2022-06-06 09:57:03',_binary '\0'),(_binary '\õ\ë\å;\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:57:03','2022-06-06 09:57:03',_binary '\0'),(_binary '\õë¢¥\å;\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:57:03','2022-06-06 09:57:03',_binary '\0'),(_binary '\ö,\òXBƒì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-11 08:11:47','2021-11-11 08:11:47',_binary '\0'),(_binary '\ö™»\åÜ¨\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-26 12:04:39','2022-05-26 12:04:39',_binary '\0'),(_binary '\ö¾¯Ë£P\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-03-14 12:41:07','2022-03-14 12:41:07',_binary '\0'),(_binary '\ö\ñK¥¢\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-17 11:33:08','2022-03-17 11:33:08',_binary '\0'),(_binary '\öø°\'» \ì§b8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-14 11:14:15','2022-04-14 11:14:15',_binary '\0'),(_binary '\÷.‹\Ğ\æ\Ô\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-06-08 10:44:49','2022-06-08 10:44:49',_binary '\0'),(_binary '\÷.\ÛÜ¬\ì­8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-26 12:33:18','2022-05-26 12:33:18',_binary '\0'),(_binary '\÷^=İœ\ì­8\"\â#€ª',_binary 'Á¢:»\á\ì§b8\"\â#€ª','2022-05-27 17:11:17','2022-05-27 17:11:17',_binary '\0'),(_binary '\÷·\×/´‚\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-05 09:51:53','2022-04-05 09:51:53',_binary '\0'),(_binary '\÷\ë&€\å4\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-06 09:07:00','2022-06-06 09:07:00',_binary '\0'),(_binary 'øQHK,ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-10-14 09:49:29','2021-10-14 09:49:29',_binary '\0'),(_binary 'ø}*ºÔ­ì‡»8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-16 08:20:20','2022-05-16 08:20:20',_binary '\0'),(_binary 'ø~!ş³\Ä\ì™(8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-04 11:11:50','2022-04-04 11:11:50',_binary '\0'),(_binary 'ø¦w\ÖAì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-18 08:32:17','2022-05-18 08:32:17',_binary '\0'),(_binary 'ù¦\ÊAGŠì‘œ8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-17 17:44:36','2021-11-17 17:44:36',_binary '\0'),(_binary 'ù\à\n\Ë 	ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-28 11:12:56','2021-09-28 11:12:56',_binary '\0'),(_binary 'ú ı¼UìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-15 08:49:59','2022-04-15 08:49:59',_binary '\0'),(_binary 'ú,i\ê¿ìŒ˜8\"\â#€ª',_binary '´uk±Q\ì™(8\"\â#€ª','2022-04-18 20:27:56','2022-04-18 20:27:56',_binary '\0'),(_binary 'úfp‹\×ì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-19 10:04:12','2022-05-19 10:04:12',_binary '\0'),(_binary 'úsvP¶\×\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-08 09:05:27','2022-04-08 09:05:27',_binary '\0'),(_binary 'ú¼\ë\Ä\âP\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-02 16:49:57','2022-06-02 16:49:57',_binary '\0'),(_binary 'û\àg\Õì‡»8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-16 18:43:11','2022-05-16 18:43:11',_binary '\0'),(_binary 'ü&²P³ì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-11-29 09:30:50','2021-11-29 09:30:50',_binary '\0'),(_binary 'ü¥\0Ã¾¼ìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 10:12:24','2022-04-18 10:12:24',_binary '\0'),(_binary 'ıÀ\Û\à\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 12:13:11','2022-05-25 12:13:11',_binary '\0'),(_binary 'ı U£³¹\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-04 09:53:14','2022-04-04 09:53:14',_binary '\0'),(_binary 'ş\rMºJ\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-12 18:26:19','2022-04-12 18:26:19',_binary '\0'),(_binary 'ş]\áŒ\ë—\ì­8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-06-14 12:10:58','2022-06-14 12:10:58',_binary '\0'),(_binary 'şƒªŞ£/\ì™(8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-03-14 08:45:07','2022-03-14 08:45:07',_binary '\0'),(_binary 'ş¢n\' ½ì–½8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-09-29 08:41:33','2021-09-29 08:41:33',_binary '\0'),(_binary 'ş°FO\Û\ö\ì¶Á8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-25 14:50:42','2022-05-25 14:50:42',_binary '\0'),(_binary 'ş²¨[\Â\ËìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-23 14:09:54','2022-04-23 14:09:54',_binary '\0'),(_binary 'şÍ6º.\ì™(8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-12 15:05:54','2022-04-12 15:05:54',_binary '\0'),(_binary 'ş\Õ*€SSì¾¯8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2021-12-02 17:41:16','2021-12-02 17:41:16',_binary '\0'),(_binary 'ÿ#“¾\ÈìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-04-18 11:38:22','2022-04-18 11:38:22',_binary '\0'),(_binary 'ÿ#°Ë”ìŒ˜8\"\â#€ª',_binary 'Œqÿ³\Å\ì™(8\"\â#€ª','2022-05-04 18:28:53','2022-05-04 18:28:53',_binary '\0'),(_binary 'ÿº°¦»\Ô\ì§b8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-04-14 17:26:43','2022-04-14 17:26:43',_binary '\0'),(_binary 'ÿ\ŞA\Ñ\ØìŒ˜8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-12 17:50:47','2022-05-12 17:50:47',_binary '\0'),(_binary 'ÿ\ä¼\×\Şì‡»8\"\â#€ª',_binary '¢t\ñt\Õì–½8\"\â#€ª','2022-05-20 09:48:51','2022-05-20 09:48:51',_binary '\0'),(_binary 'ÿ\÷V(Ë–ìŒ˜8\"\â#€ª',_binary '\Å@ƒ2Ÿ‹ì§…8\"\â#€ª','2022-05-04 18:43:14','2022-05-04 18:43:14',_binary '\0');
/*!40000 ALTER TABLE `user-session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hub'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteAddress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAddress`(IN p_idAddress BIGINT)
BEGIN
	DELETE FROM hub.address WHERE idAddress = p_idAddress;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAttribute`(IN p_idAttribute INT)
BEGIN
	DELETE FROM hub.attribute WHERE  idAttribute = p_idAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteAttributeValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAttributeValue`(IN p_idAttributeValue INT)
BEGIN
	DELETE FROM `attribute-value` WHERE  idAttributeValue = p_idAttributeValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBooking`(IN p_idBooking INT)
BEGIN
	DELETE FROM hub.booking WHERE  idBooking = p_idBooking;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCart`(IN p_idUser CHAR(36))
BEGIN
	DELETE FROM cart WHERE idUser = UUID_TO_BIN(p_idUser);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCartItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCartItem`(IN p_idUser CHAR(36), IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM cart WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idUser = UUID_TO_BIN(p_idUser);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCategory`(IN p_idCategory INT)
BEGIN
	DELETE FROM hub.category WHERE  idCategory = p_idCategory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCommonAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCommonAttribute`(IN p_idCommonAttribute INT)
BEGIN
	DELETE FROM `common-attribute` WHERE  idCommonAttribute = p_idCommonAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCreditCard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCreditCard`(IN p_idCreditCard bigint(20))
BEGIN
	DELETE FROM `credit-card` WHERE idCreditCard = p_idCreditCard;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmail`(IN p_idEmail BIGINT)
BEGIN
	DELETE FROM hub.email WHERE idEmail = p_idEmail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntity`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntityAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityAttribute`(IN p_idEntity CHAR(36), IN p_idAttribute INT)
BEGIN
	DELETE FROM `hub.entity-attribute` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idAttribute = p_idAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntityCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityCategory`(IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	DELETE FROM `entity-category` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idCategory = p_idCategory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntityMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityMedia`(IN p_idMedia BIGINT)
BEGIN
	DELETE FROM `entity-media` WHERE idMedia = p_idMedia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntityMediaAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityMediaAll`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntityRelate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityRelate`(IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEntityRelateAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityRelateAll`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) OR idRelated = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEvent`(IN p_idEvent BIGINT)
BEGIN
	DELETE FROM hub.event WHERE idEvent = p_idEvent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteEventChainEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEventChainEdit`(IN p_idEventChainEdit INT)
BEGIN
	DELETE FROM `event-chain-edit` WHERE  idEventChainEdit = p_idEventChainEdit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteGroup`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.group WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteItem`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.item WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLocation`(IN p_idLocation BIGINT)
BEGIN
	DELETE FROM hub.location WHERE idLocation = p_idLocation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMasterType`(IN p_idMasterType INT)
BEGIN
	DELETE FROM `master-type` WHERE  idMasterType = p_idMasterType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMessage`(IN p_idMessage INT)
BEGIN
	DELETE FROM hub.message WHERE  idMessage = p_idMessage;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNotification`(IN p_idNotification INT)
BEGIN
	DELETE FROM hub.notification WHERE  idNotification = p_idNotification;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteOffer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOffer`(IN p_idOffer INT)
BEGIN
	DELETE FROM offer WHERE idOffer = p_idOffer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOrder`(IN p_idOrder BIGINT)
BEGIN
	DELETE FROM hub.order WHERE idOrder = p_idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteOrderItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOrderItem`(IN p_idOrder bigint(20))
BEGIN
	DELETE FROM `order-item` WHERE idOrder = p_idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePerson`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePlace` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePlace`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.place WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePost`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.post WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteResetPasswordSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteResetPasswordSession`(IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteService`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.service WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteServiceAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteServiceAvailability`(IN p_idEvent int, IN p_idService CHAR(36))
BEGIN
	DELETE FROM hub.`service-availability` WHERE  idEvent = p_idEvent AND idService = UUID_TO_BIN(p_idService);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteSuggestion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSuggestion`(IN p_idSuggestion INT)
BEGIN
	DELETE FROM hub.suggestion WHERE idSuggestion = p_idSuggestion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUser`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUserSession`(IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertAddress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAddress`(IN p_name varchar(100), 
    IN p_idLocation bigint(20))
BEGIN
	INSERT INTO hub.address (name, idLocation) 
    VALUES (p_name, p_idLocation);
	SELECT LAST_INSERT_ID() AS idAddress;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAttribute`(IN p_attrName VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO hub.attribute (attrName, attrType, idSuggestor) VALUES(p_attrName, p_attrType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertAttributeValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAttributeValue`(IN p_idAttribute int(10), IN p_attrValue VARCHAR(1024), IN p_sortOrder smallint, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO `attribute-value` (idAttribute, attrValue, sortOrder, idSuggestor) VALUES(p_idAttribute, p_attrValue, p_sortOrder, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttributeValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBooking`(IN p_idEvent int, IN p_idAvailability int, IN p_idConsumer char(36), IN p_idService char(36), IN p_confirmed TINYINT)
BEGIN
	INSERT INTO hub.booking (idEvent, idAvailability, idConsumer, idService, confirmed)
  VALUES (p_idEvent, p_idAvailability, UUID_TO_BIN(p_idConsumer), UUID_TO_BIN(p_idService), p_confirmed);
	SELECT LAST_INSERT_ID() as idBooking;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCart`(IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_idOffer INT(10))
BEGIN
	INSERT INTO cart (idUser, idEntity, quantity, idOffer) VALUES(UUID_TO_BIN(p_idUser), UUID_TO_BIN(p_idEntity), p_quantity, p_idOffer);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCategory`(IN p_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_entityType INT, p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO hub.category (idParent, catDesc, catLevel, entityType, idSuggestor) VALUES(p_idParent, p_catDesc, p_catLevel, p_entityType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idCategory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCommonAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCommonAttribute`(IN p_idAttribute INT, IN p_idCategory INT, IN p_sortOrder INT, IN p_required BIT(1))
BEGIN
	INSERT INTO `common-attribute` (idAttribute, idCategory, sortOrder, required) VALUES (p_idAttribute, p_idCategory, p_sortOrder, p_required);
	SELECT LAST_INSERT_ID() as idCommonAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertCreditCard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCreditCard`(IN p_number varchar(16), 
    IN p_expiration date, 
    IN p_ccv varchar(4), 
    IN p_idAddressBilling bigint(20))
BEGIN
	INSERT INTO `credit-card` (number, expiration, ccv, idAddressBilling) 
    VALUES (p_number, p_expiration, p_ccv, p_idAddressBilling);
	SELECT LAST_INSERT_ID() AS idCreditCard;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmail`(IN p_idEntity CHAR(36), IN p_emailAddress VARCHAR(320), IN p_emailVerifyCode CHAR(6))
BEGIN
	INSERT INTO hub.email (idEntity, emailAddress, emailVerifyCode) VALUES(UUID_TO_BIN(p_idEntity), p_emailAddress, p_emailVerifyCode);
	SELECT LAST_INSERT_ID() AS idEmail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntity`(IN p_entityTitle VARCHAR(255), IN p_entityDesc TEXT, IN p_entityType INT)
BEGIN
	SET @idEntity = UUID_TO_BIN(UUID());
	INSERT INTO hub.entity (idEntity, entityTitle, entityDesc, entityType, dtCreated) VALUES(@idEntity, p_entityTitle, p_entityDesc, p_entityType, Now());
	SELECT BIN_TO_UUID(@idEntity) as idEntity;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEntityAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityAttribute`(IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	INSERT INTO `hub.entity-attribute` (idEntity, idAttribute, value, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idAttribute, p_value, Now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEntityCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityCategory`(IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	INSERT INTO `entity-category` (idEntity, idCategory, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idCategory, Now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEntityMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityMedia`(IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_mediaType INT, IN p_fileName VARCHAR(50), IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT, IN p_scale FLOAT)
BEGIN
	INSERT INTO `entity-media` (idEntity, idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale) 
	VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idUser), p_mediaType, p_fileName, Now(), p_sortOrder, p_xOffset, p_yOffset, p_scale);
	SELECT LAST_INSERT_ID() AS idMedia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEntityRelate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityRelate`(IN p_idEntity CHAR(36), IN p_idRelated CHAR(36), IN p_relateType INT)
BEGIN
	INSERT INTO `entity-relate` (idEntity, idRelated, relateType) VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idRelated), p_relateType);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEvent`(IN p_idEntity char(36),
  IN p_eventType TINYINT,
  IN p_dtStart DATETIME,
  IN p_dtEnd DATETIME,
  IN p_allDay bit(1),
  IN p_repeatType TINYINT,
  IN p_repeatTimeFrame TINYINT,
  IN p_repeatMonthlyType TINYINT,
  IN p_repeatInterval SMALLINT,
  IN p_repeatSun bit(1),
  IN p_repeatMon bit(1),
  IN p_repeatTue bit(1),
  IN p_repeatWed bit(1),
  IN p_repeatThu bit(1),
  IN p_repeatFri bit(1),
  IN p_repeatSat bit(1),
  IN p_repeatEndType tinyint,
  IN p_repeatEnd datetime,
  IN p_repeatOccurences smallint, 
  IN p_allServices bit(1))
BEGIN
	INSERT INTO hub.event (idEntity,
            eventType,
            dtStart,
            dtEnd,
            allDay,
            repeatType,
            repeatTimeFrame,
            repeatMonthlyType,
            repeatInterval,
            repeatSun,
            repeatMon,
            repeatTue,
            repeatWed,
            repeatThu,
            repeatFri,
            repeatSat,
            repeatEndType,
            repeatEnd,
            repeatOccurences,
            allServices) 
    VALUES (UUID_TO_BIN(p_idEntity),
            p_eventType,
            p_dtStart,
            p_dtEnd,
            p_allDay,
            p_repeatType,
            p_repeatTimeFrame,
            p_repeatMonthlyType,
            p_repeatInterval,
            p_repeatSun,
            p_repeatMon,
            p_repeatTue,
            p_repeatWed,
            p_repeatThu,
            p_repeatFri,
            p_repeatSat,
            p_repeatEndType,
            p_repeatEnd,
            p_repeatOccurences, 
            p_allServices);
	SELECT LAST_INSERT_ID() AS idEvent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEventChainEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEventChainEdit`(IN p_idEvent int(10), IN p_editType tinyint, IN p_dtStart datetime, IN p_idNewEvent CHAR(36))
BEGIN
	INSERT INTO `event-chain-edit` (idEvent, editType, dtStart, idNewEvent) VALUES(p_idEvent, p_editType, p_dtStart, p_idNewEvent);
	SELECT LAST_INSERT_ID() as idEventChainEdit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertGroup`(IN p_idEntity CHAR(36), IN p_groupType INT)
BEGIN
	INSERT INTO hub.group (idEntity, groupType) VALUES(UUID_TO_BIN(p_idEntity), groupType);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertItem`(IN p_idEntity CHAR(36), IN p_condition INT)
BEGIN
	INSERT INTO hub.item (idEntity, `condition`) VALUES(UUID_TO_BIN(p_idEntity), p_condition);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLocation`(IN p_addressLine1 varchar(255), 
    IN p_addressLine2 varchar(255), 
    IN p_city varchar(255), 
    IN p_idProvince int(10), 
    IN p_idCountry int(10),
    IN p_postalCode varchar(12))
BEGIN
	INSERT INTO hub.location (addressLine1, addressLine2, city, idProvince, idCountry, postalCode) 
    VALUES (p_addressLine1, p_addressLine2, p_city, p_idProvince, p_idCountry, p_postalCode);
	SELECT LAST_INSERT_ID() AS idLocation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertMasterType`(IN p_table VARCHAR(100), IN p_column VARCHAR(100), IN p_value VARCHAR(255), IN p_code VARCHAR(45))
BEGIN
	INSERT INTO `master-type` (`table`, `column`, `value`, `code`) VALUES (p_table, p_column, p_value, p_code);
	SELECT LAST_INSERTED_ID() as idMasterType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertMessage`(
  IN p_idThread BIGINT,
  IN p_idSender CHAR(36),
  IN p_idRecipient CHAR(36),
  IN p_dtSent DATETIME,
  IN p_messageText TEXT)
BEGIN
	DECLARE idNew BIGINT;
  INSERT INTO hub.message (idThread,
    idSender,
    idRecipient,
    dtSent,
    messageText,
    dtViewed)
  VALUES (p_idThread,
    UUID_TO_BIN(p_idSender),
    UUID_TO_BIN(p_idRecipient),
    p_dtSent,
    p_messageText,
    NULL);
  SET idNew = LAST_INSERT_ID();
  IF p_idThread = 0 THEN UPDATE hub.message SET idThread = idNew WHERE idMessage = idNew;
  END IF;
	SELECT LAST_INSERT_ID() as idMessage;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNotification`(
  IN p_idEntity CHAR(36),
  IN p_serviceBeingBookedEmail BIT(1),
  IN p_serviceBeingBookedText BIT(1),
  IN p_bookingRequestSubmittedEmail BIT(1),
  IN p_bookingRequestSubmittedText BIT(1),
  IN p_bookingRequestConfirmedEmail BIT(1),
  IN p_bookingRequestConfirmedText BIT(1),
  IN p_bookingCancelEmail BIT(1),
  IN p_bookingCancelText BIT(1),
  IN p_reminderProviderApptEmail BIT(1),
  IN p_reminderProviderApptText BIT(1),
  IN p_reminderConsumerApptEmail BIT(1),
  IN p_reminderConsumerApptText BIT(1))
BEGIN
	INSERT INTO hub.notification (idEntity,
    serviceBeingBookedEmail,
    serviceBeingBookedText,
    bookingRequestSubmittedEmail,
    bookingRequestSubmittedText,
    bookingRequestConfirmedEmail,
    bookingRequestConfirmedText,
    bookingCancelEmail,
    bookingCancelText,
    reminderProviderApptEmail,
    reminderProviderApptText,
    reminderConsumerApptEmail,
    reminderConsumerApptText) 
  VALUES (UUID_TO_BIN(p_idEntity),
    p_serviceBeingBookedEmail,
    p_serviceBeingBookedText,
    p_bookingRequestSubmittedEmail,
    p_bookingRequestSubmittedText,
    p_bookingRequestConfirmedEmail,
    p_bookingRequestConfirmedText,
    p_bookingCancelEmail,
    p_bookingCancelText,
    p_reminderProviderApptEmail,
    p_reminderProviderApptText,
    p_reminderConsumerApptEmail,
    p_reminderConsumerApptText);
	SELECT LAST_INSERT_ID() as idNotification;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertOffer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOffer`(IN p_idEntity CHAR(36), 
    IN p_offerType smallint, 
    IN p_confirmMethod TINYINT,
    IN p_price float, 
    IN p_rateType smallint, 
    IN p_negotiable bit(1),
    IN p_quantify bit(1),
    IN p_quantity smallint,
    IN p_minTimeIncrement smallint,
    IN p_maxTimeIncrement SMALLINT,
    IN p_startTimeIncrement SMALLINT,
    IN p_bookingLeadNumber SMALLINT,
    IN p_bookingLeadType SMALLINT,
    IN p_cancelLeadNumber SMALLINT,
    IN p_cancelLeadType SMALLINT,
    IN p_cancelFee FLOAT,
    IN p_handlePayment bit(1),
    IN p_depositRequired TINYINT,
    IN p_cancelPolicyOn bit(1),
    IN p_cancelFeeType TINYINT,
    IN p_depositAmountType TINYINT,
    IN p_depositAmount FLOAT)
BEGIN
	INSERT INTO offer (idEntity, offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, cancelPolicyOn, cancelFeeType, depositAmountType, depositAmount) 
    VALUES (UUID_TO_BIN(p_idEntity), p_offerType, p_confirmMethod, p_price, p_rateType, p_negotiable, p_quantify, p_quantity, p_minTimeIncrement, p_maxTimeIncrement, p_startTimeIncrement, p_bookingLeadNumber, p_bookingLeadType, p_cancelLeadNumber, p_cancelLeadType, p_cancelFee, p_handlePayment, p_depositRequired, p_cancelPolicyOn, p_cancelFeeType, p_depositAmountType, p_depositAmount);
  SELECT LAST_INSERT_ID() AS idOffer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOrder`(IN p_idUser char(36), IN p_state tinyint)
BEGIN
	INSERT INTO hub.order (idUser, state) 
    VALUES (UUID_TO_BIN(p_idUser), p_state);
	SELECT LAST_INSERT_ID() AS idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertOrderItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOrderItem`(IN p_idOrder bigint(20),
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(10))
BEGIN
	INSERT INTO `order-item` (idOrder, idEntity, quantity, totalPrice, idOffer) 
    VALUES (p_idOrder, UUID_TO_BIN(p_idEntity), p_quantity, p_totalPrice, p_idOffer);
	SELECT LAST_INSERT_ID() AS idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPerson`(IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	INSERT INTO hub.person (idEntity, personFirstName, personLastName) VALUES(UUID_TO_BIN(p_idEntity), p_personFirstName, p_personLastName);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPlace` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPlace`(IN p_idEntity CHAR(36), IN p_placeType INT)
BEGIN
	INSERT INTO hub.place (idEntity, placeType) VALUES(UUID_TO_BIN(p_idEntity), placeType);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPost`(IN p_idEntity CHAR(36), IN p_seeking BIT(1))
BEGIN
	INSERT INTO hub.post (idEntity, seeking) VALUES(UUID_TO_BIN(p_idEntity), p_seeking);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertResetPasswordSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertResetPasswordSession`(IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	INSERT INTO `reset-password-session` (idSession, idEntity, dtStarted) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), Now());
	SELECT @idSession as idSession;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertService`(IN p_idEntity CHAR(36), IN p_online BIT(1), IN p_inPerson BIT(1), IN p_onDemand BIT(1), IN p_byAppt BIT(1))
BEGIN
	INSERT INTO hub.service (idEntity, `online`, inPerson, onDemand, byAppt) VALUES(UUID_TO_BIN(p_idEntity), p_online, p_inPerson, p_onDemand, p_byAppt);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertServiceAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertServiceAvailability`(IN p_idEvent int, IN p_idService CHAR(36))
BEGIN
	INSERT INTO hub.`service-availability` (idEvent, idService) VALUES(p_idEvent, UUID_TO_BIN(p_idService));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertSuggestion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSuggestion`(IN p_idEntity CHAR(36), IN p_suggestion TEXT)
BEGIN
	INSERT INTO hub.suggestion (idEntity, suggestion, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_suggestion, Now());
	SELECT LAST_INSERT_ID() as idSuggestion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUser`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT, IN p_userTimeZone TINYINT)
BEGIN
	INSERT INTO hub.user (idEntity, userName, userPassword, userSalt, userPrimaryEmail, userTimeZone) VALUES(UUID_TO_BIN(p_idEntity), p_userName, p_userPassword, p_userSalt, p_userPrimaryEmail, p_userTimeZone);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUserSession`(IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	SET @Now = Now();
	INSERT INTO `user-session` (idSession, idEntity, dtStarted, dtActive, done) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), @Now, @Now, 0);
	SELECT @idSession as idSession;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAddress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAddress`(IN p_idAddress bigint(20))
BEGIN
	SELECT idAddress, name, idLocation 
    FROM hub.address
    WHERE idAddress = p_idAddress;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAttribute`(IN p_idAttribute INT)
BEGIN
	SELECT idAttribute, attrName, attrType, BIN_TO_UUID(idSuggestor) as idSuggestor FROM hub.attribute where idAttribute = p_idAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectAttributeValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAttributeValue`(IN p_idAttributeValue INT)
BEGIN
	SELECT idAttributeValue, attrValue, BIN_TO_UUID(idSuggestor) as idSuggestor FROM `attribute-value` where idAttributeValue = p_idAttributeValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectBooking`(IN p_idBooking INT)
BEGIN
	SELECT idBooking, idEvent, idAvailable, BIN_TO_UUID(idConsumer) as idConsumer, BIN_TO_UUID(idService) as idService, confirmed
  FROM hub.booking where idBooking = p_idBooking AND confirmed <> 2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCart`(IN p_idUser CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, BIN_TO_UUID(idUser) AS idUser, quantity, idOffer
    	FROM cart as c
    	WHERE c.idUser = UUID_TO_BIN(p_idUser);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCategory`(IN p_idCategory INT)
BEGIN
	SELECT idCategory, idParent, catDesc, catLevel, entityType, BIN_TO_UUID(idSuggestor) as idSuggestor
	FROM hub.category where idCategory = p_idCategory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCategoryByType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCategoryByType`(IN p_entityType INT)
BEGIN
	SELECT idCategory, idParent, catDesc, catLevel, entityType, BIN_TO_UUID(idSuggestor) as idSuggestor
	FROM hub.category where entityType = p_entityType ORDER BY catLevel ASC, catDesc ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCommonAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCommonAttribute`(IN p_idCommonAttribute INT)
BEGIN
	SELECT idCommonAttribute, idAttribute, idCategory, sortOrder, required
    FROM `common-attribute` where idCommonAttribute = p_idCommonAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCommonAttributeByCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCommonAttributeByCategory`(IN p_idCategory INT)
BEGIN
	SELECT idCommonAttribute, idAttribute, idCategory, sortOrder, required
    FROM `common-attribute` where idCategory = p_idCategory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCountryActive` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCountryActive`()
BEGIN
	SELECT * FROM hub.country WHERE active = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectCreditCard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCreditCard`(IN p_idCreditCard bigint(20))
BEGIN
	SELECT idCreditCard, number, expiration, ccv, idAddressBilling
    FROM `credit-card`
    WHERE idCreditCard = p_idCreditCard;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEmail`(IN p_idEmail BIGINT)
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM hub.email WHERE idEmail = p_idEmail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEmailByEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEmailByEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM hub.email WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, entityDesc, entityType, idMedia, dtCreated, dtLastEdited  FROM hub.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityAttribute`(IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM `hub.entity-attribute` where idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityByEntityType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityByEntityType`(IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, entityDesc, entityType, idMedia, dtCreated, dtLastEdited FROM hub.entity WHERE entityType = p_entityType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityByOwner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityByOwner`(IN p_idEntity CHAR(36), IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, 
    o.idOffer, o.offerType, o.confirmMethod, o.price, o.rateType, o.negotiable, o.quantify, o.quantity, 
	o.minTimeIncrement, o.maxTimeIncrement, o.startTimeIncrement, o.bookingLeadNumber, o.bookingLeadType,
	o.cancelLeadNumber, o.cancelLeadType, o.cancelFee, o.handlePayment, o.depositRequired, o.cancelPolicyOn, o.cancelFeeType, o.depositAmountType, o.depositAmount
	FROM entity AS e 
		RIGHT JOIN `entity-relate` AS er ON er.idEntity = e.idEntity
		LEFT OUTER JOIN offer AS o ON o.idEntity = e.idEntity
	WHERE idRelated = UUID_TO_BIN(p_idEntity) AND er.relateType = 1 AND entityType = p_entityType
	ORDER BY dtCreated DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityBySearch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityBySearch`(IN p_searchValue CHAR(255))
BEGIN
  SELECT * FROM 
	  (SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset 
		FROM hub.entity AS e, `entity-media` as em
		WHERE e.idMedia = em.idMedia
	  UNION ALL 
	  SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL, NULL, 0, 0
		FROM hub.entity AS e
		WHERE e.idMedia is NULL) `combined-alias`
	 ORDER BY dtCreated DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityCategory`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity), idCategory, dtCreated FROM `entity-category` where idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityMedia`(IN p_idMedia BIGINT)
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale 
	FROM `entity-media` WHERE idMedia = p_idMedia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityMediaByEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityMediaByEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale
	FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity) ORDER BY sortOrder ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityRelate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityRelate`(IN p_idEntity CHAR(36), IN p_relateType INT)
BEGIN
	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset, em.scale 
		FROM hub.entity AS e, `entity-media` as em, `entity-relate` as er
		WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia = em.idMedia)
	UNION ALL 
  	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL as fileName, NULL as mediaType, 0 as xOffset, 0 as yOffset, 0 as scale
    	FROM hub.entity AS e, `entity-relate` as er
    	WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia is NULL);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEntityRelateByRelated` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityRelateByRelated`(IN p_idRelated CHAR(36))
BEGIN
	SELECT * FROM `entity-relate` WHERE idRelated = UUID_TO_BIN(p_idRelated);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEvent`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idEvent, 
            BIN_TO_UUID(idEntity) as idEntity,
            eventType,
            dtStart,
            dtEnd,
            allDay,
            repeatType,
            repeatTimeFrame,
            repeatMonthlyType,
            repeatInterval,
            repeatSun,
            repeatMon,
            repeatTue,
            repeatWed,
            repeatThu,
            repeatFri,
            repeatSat,
            repeatEndType,
            repeatEnd,
            repeatOccurences,
            allServices
    FROM hub.event
    WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectEventChainEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEventChainEdit`(IN p_idEvent INT)
BEGIN
	SELECT idEventChainEdit, idEvent, editType, dtStart, idNewEvent FROM `event-chain-edit` where idEvent = p_idEvent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroup`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, groupType FROM hub.group where idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectItem`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, `condition` FROM hub.item WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectLocation`(IN p_idLocation bigint(20))
BEGIN
	SELECT idLocation, addressLine1, addressLine2, city, idProvince, idCountry, postalCode 
    FROM hub.location
    WHERE idLocation = p_idLocation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectMasterType`(IN p_idMasterType INT)
BEGIN
	SELECT * FROM `master-type` WHERE idMasterType = p_idMasterType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectMasterTypeByValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectMasterTypeByValue`(IN p_value VARCHAR(255))
BEGIN
	SELECT * FROM `master-type` WHERE `value` = p_value;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectMessage`(IN p_idEntity CHAR(36))
BEGIN
	WITH ranked_messages AS (SELECT idMessage,
    idThread,
    BIN_TO_UUID(idSender) AS idSender,
    e1.entityTitle AS senderName,
    BIN_TO_UUID(idRecipient) AS idRecipient,
    e2.entityTitle as recipientName,
    dtSent,
    messageText,
    dtViewed,
    ROW_NUMBER() OVER (PARTITION BY idThread ORDER BY dtSent DESC) AS rn
  FROM hub.message, hub.entity e1, hub.entity e2
  WHERE (idSender = UUID_TO_BIN(p_idEntity) OR idRecipient = UUID_TO_BIN(p_idEntity)) 
    AND idSender = e1.idEntity AND idRecipient = e2.idEntity
  )
  SELECT * FROM ranked_messages WHERE rn = 1 ORDER BY dtSent DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectNotification`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idNotification,
    BIN_TO_UUID(idEntity) AS idEntity,
    serviceBeingBookedEmail,
    serviceBeingBookedText,
    bookingRequestSubmittedEmail,
    bookingRequestSubmittedText,
    bookingRequestConfirmedEmail,
    bookingRequestConfirmedText,
    bookingCancelEmail,
    bookingCancelText,
    reminderProviderApptEmail,
    reminderProviderApptText,
    reminderConsumerApptEmail,
    reminderConsumerApptText
  FROM hub.notification where idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectOffer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOffer`(IN p_idOffer bigint(20))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, cancelPolicyOn, cancelFeeType, depositAmountType, depositAmount
  FROM offer
  WHERE idOffer = p_idOffer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectOfferForEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOfferForEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity,offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, cancelPolicyOn, cancelFeeType, depositAmountType, depositAmount
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOrder`(IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idUser) as idUser, idAddress, idCreditCard, state, inventoryLockTime
    FROM hub.order
    WHERE idOrder = p_idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectOrderItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOrderItem`(IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idEntity), quantity, totalPrice, idOffer
    FROM `order-item`
    WHERE idOrder = p_idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPerson`(IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectPlace` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPlace`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, placeType FROM hub.place where idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPost`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, seeking FROM hub.post WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectProviderUnconfirmedCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectProviderUnconfirmedCount`(IN p_idEntity CHAR(36))
BEGIN
    SELECT COUNT(e.idEvent) as unconfirmedBookings
    FROM hub.event AS e, hub.booking AS b
    WHERE e.idEntity = UUID_TO_BIN(p_idEntity) AND eventType = 3 AND e.idEvent = b.idEvent AND confirmed = 0;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectProvinceByCountry` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectProvinceByCountry`(IN p_idCountry INT)
BEGIN
	SELECT * FROM hub.province WHERE idCountry = p_idCountry AND active = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectResetPasswordSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectResetPasswordSession`(IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idSession) AS idSession, BIN_TO_UUID(idEntity) AS idEntity, dtStarted 
	FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectService`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, `online`, inPerson, onDemand, byAppt FROM hub.service WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectServiceAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectServiceAvailability`(IN p_idEvent INT)
BEGIN
	SELECT idEvent, BIN_TO_UUID(idService) as idService 
  FROM hub.`service-availability` where idEvent = p_idEvent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectSuggestion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectSuggestion`(IN p_idSuggestion INT)
BEGIN
	SELECT * FROM hub.suggestion WHERE idSuggestion = p_idSuggestion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectSuggestionByEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectSuggestionByEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.suggestion WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectThread` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectThread`(IN p_idThread BIGINT)
BEGIN
  SELECT idMessage,
    idThread,
    BIN_TO_UUID(idSender) AS idSender,
    e1.entityTitle AS senderName,
    BIN_TO_UUID(idRecipient) AS idRecipient,
    e2.entityTitle as recipientName,
    dtSent,
    messageText,
    dtViewed
  FROM hub.message, hub.entity e1, hub.entity e2
  WHERE idThread = p_idThread
    AND idSender = e1.idEntity AND idRecipient = e2.idEntity
  ORDER BY dtSent DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUser`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, userName, userPassword, userSalt, userPrimaryEmail, userTimeZone FROM hub.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectUserByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserByEmail`(IN p_emailAddress VARCHAR(320))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.emailAddress, u.userTimeZone
	FROM hub.user AS u, hub.email AS e WHERE u.idEntity = e.idEntity AND e.emailAddress = p_emailAddress;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectUserByUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserByUserName`(IN p_userName CHAR(64))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.entityTitle, u.userTimeZone
    FROM hub.user AS u, hub.entity AS e
    WHERE userName = p_userName AND e.idEntity = u.idEntity;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectUserEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserEvents`(IN p_idEntity CHAR(36))
BEGIN
	(SELECT idEvent, 
            BIN_TO_UUID(idEntity) as idEntity,
            eventType,
            dtStart,
            dtEnd,
            allDay,
            repeatType,
            repeatTimeFrame,
            repeatMonthlyType,
            repeatInterval,
            repeatSun,
            repeatMon,
            repeatTue,
            repeatWed,
            repeatThu,
            repeatFri,
            repeatSat,
            repeatEndType,
            repeatEnd,
            repeatOccurences,
            allServices,
            null as idBooking,
            null as idAvailability,
            null as idConsumer,
            null as consumerTitle,
            null as idService,
            null as confirmed
    FROM hub.event
    WHERE idEntity = UUID_TO_BIN(p_idEntity) AND eventType < 2)
    UNION ALL 
    (SELECT e.idEvent, 
            BIN_TO_UUID(e.idEntity) as idEntity,
            eventType,
            dtStart,
            dtEnd,
            allDay,
            repeatType,
            repeatTimeFrame,
            repeatMonthlyType,
            repeatInterval,
            repeatSun,
            repeatMon,
            repeatTue,
            repeatWed,
            repeatThu,
            repeatFri,
            repeatSat,
            repeatEndType,
            repeatEnd,
            repeatOccurences,
            allServices,
            idBooking,
            idAvailability,
            BIN_TO_UUID(idConsumer) as idConsumer,
            en.entityTitle as consumerTitle,
            BIN_TO_UUID(idService) as idService,
            confirmed
    FROM hub.event AS e, hub.booking AS b, entity AS en
    WHERE e.idEntity = UUID_TO_BIN(p_idEntity) AND eventType = 3 AND e.idEvent = b.idEvent AND en.idEntity = b.idConsumer AND confirmed <> 2)
    ORDER BY eventType ASC, dtStart ASC, dtEnd ASC, idService ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selectUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserSession`(IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID( idSession) as idSession, BIN_TO_UUID( idEntity ) as idEntity, dtStarted, dtActive, done
	FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateAddress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAddress`(IN p_idAddress bigint(20), 
    IN p_name varchar(100), 
    IN p_idLocation  bigint(20))
BEGIN
	UPDATE hub.address 
    SET name = p_name, idLocation = p_idLocation 
    WHERE idAddress = p_idAddress;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAttribute`(IN p_idAttribute INT, IN p_attrName VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE hub.attribute SET attrName = p_attrName, attrType = p_attrType, idSuggestor = UUID_TO_BIN(p_idSuggestor) 
	WHERE  idAttribute = p_idAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateAttributeValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAttributeValue`(IN p_idAttribute INT, IN p_attrValue VARCHAR(1024), IN p_sortOrder smallint, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `attribute-value` SET idAttribute = p_idAttribute, attrValue = p_attrValue, sortOrder = p_sortOrder, idSuggestor = UUID_TO_BIN(p_idSuggestor)
	WHERE  idAttributeValue = p_idAttributeValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBooking`(IN p_idBooking INT, IN p_idEvent int, IN p_idAvailability int, IN p_idConsumer char(36), IN p_idService char(36), IN p_confirmed TINYINT)
BEGIN
	UPDATE hub.booking SET idEvent = p_idEvent, idAvailability = p_idAvailability, idConsumer = UUID_TO_BIN(p_idConsumer), idService = UUID_TO_BIN(p_idService), confirmed = p_confirmed
	WHERE  idBooking = p_idBooking;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCartItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCartItem`(IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_idOffer INT(10))
BEGIN
	UPDATE cart SET quantity=p_quantity, idOffer=p_idOffer WHERE idUser = UUID_TO_BIN(p_idUser) AND idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCategory`(IN p_idCategory INT, IN p_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_entityType INT, p_idSuggestor CHAR(36))
BEGIN
	UPDATE hub.category SET idParent = p_idParent, catDesc = p_catDesc, catLevel = p_catLevel, entityType = p_entityType, idSuggestor = p_idSuggestor
	WHERE  idCategory = p_idCategory;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCommonAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCommonAttribute`(IN p_idCommonAttribute INT, IN p_idAttribute INT, IN p_idCategory INT, IN p_sortOrder INT, IN p_required BIT(1))
BEGIN
	UPDATE `common-attribute` SET idAttribute = p_idAttribute, idCategory = p_idCategory, sortOrder = p_sortOrder, required = p_required
	WHERE  idCommonAttribute = p_idCommonAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCreditCard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCreditCard`(IN p_idCreditCard bigint(20), 
    IN p_number varchar(16), 
    IN p_expiration date, 
    IN p_ccv varchar(4), 
    IN p_idAddressBilling bigint(20))
BEGIN
	UPDATE `credit-card` 
    SET number = p_number, expiration = p_expiration, ccv = p_ccv, idAddressBilling = p_idAddressBilling
    WHERE idCreditCard = p_idCreditCard;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmail`(IN p_idEmail BIGINT, IN p_emailAddress VARCHAR(320), IN p_emailVerified TINYINT(1), IN p_emailVerifyCode CHAR(6))
BEGIN
	UPDATE hub.email SET emailAddress = p_emailAddress, emailVerified = p_emailVerified, emailVerifyCode = p_emailVerifyCode WHERE idEmail = p_idEmail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEntity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntity`(IN p_idEntity CHAR(36), IN p_entityTitle VARCHAR(255), IN p_entityDesc TEXT)
BEGIN
	UPDATE hub.entity 
  SET entityTitle = p_entityTitle, entityDesc = p_entityDesc, dtLastEdited = Now() 
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEntityAttribute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityAttribute`(IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	UPDATE `hub.entity-attribute` SET value = p_value, dtLastEdited = Now() 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idAttribute = p_idAttribute;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEntityMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityMedia`(IN p_idMedia BIGINT, IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT, IN p_scale FLOAT)
BEGIN
	UPDATE `entity-media` SET sortOrder = p_sortOrder, xOffset = p_xOffset, yOffset = p_yOffset, scale = p_scale WHERE idMedia = p_idMedia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEntityPrimaryMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityPrimaryMedia`(IN p_idEntity CHAR(36), IN p_idMedia BIGINT)
BEGIN
  UPDATE hub.entity
  SET idMedia = p_idMedia
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEvent`(IN p_idEvent bigint, 
  IN p_idEntity char(36),
  IN p_eventType TINYINT,
  IN p_dtStart DATETIME,
  IN p_dtEnd DATETIME,
  IN p_allDay bit(1),
  IN p_repeatType TINYINT,
  IN p_repeatTimeFrame TINYINT,
  IN p_repeatMonthlyType TINYINT,
  IN p_repeatInterval SMALLINT,
  IN p_repeatSun bit(1),
  IN p_repeatMon bit(1),
  IN p_repeatTue bit(1),
  IN p_repeatWed bit(1),
  IN p_repeatThu bit(1),
  IN p_repeatFri bit(1),
  IN p_repeatSat bit(1),
  IN p_repeatEndType tinyint,
  IN p_repeatEnd datetime,
  IN p_repeatOccurences smallint,
  IN p_allServices bit(1))
BEGIN
	UPDATE hub.event 
    SET idEntity = UUID_TO_BIN(p_idEntity),
          eventType = p_eventType,
          dtStart = p_dtStart,
          dtEnd = p_dtEnd,
          allDay = p_allDay,
          repeatType = p_repeatType,
          repeatTimeFrame = p_repeatTimeFrame,
          repeatMonthlyType = p_repeatMonthlyType,
          repeatInterval = p_repeatInterval,
          repeatSun = p_repeatSun,
          repeatMon = p_repeatMon,
          repeatTue = p_repeatTue,
          repeatWed = p_repeatWed,
          repeatThu = p_repeatThu,
          repeatFri = p_repeatFri,
          repeatSat = p_repeatSat,
          repeatEndType = p_repeatEndType,
          repeatEnd = p_repeatEnd,
          repeatOccurences = p_repeatOccurences,
          allServices = p_allServices
    WHERE idEvent = p_idEvent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateGroup`(IN p_idEntity CHAR(36), IN p_groupType INT)
BEGIN
	UPDATE hub.group SET groupType = p_groupType WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateItem`(IN p_idEntity CHAR(36), IN p_condition INT)
BEGIN
	UPDATE hub.item SET `condition`=p_condition WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateLocation`(IN p_idLocation bigint(20), 
    IN p_addressLine1 varchar(255), 
    IN p_addressLine2 varchar(255), 
    IN p_city varchar(255), 
    IN p_idProvince int(10), 
    IN p_idCountry int(10),
    IN p_postalCode varchar(12))
BEGIN
	UPDATE hub.location 
    SET addressLine1 = p_addressLine1, addressLine2 = p_addressLine2, city = p_city, 
        idProvince = p_idProvince, idCountry = p_idCountry, postalCode = p_postalCode 
    WHERE idLocation = p_idLocation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateMasterType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMasterType`(IN p_idMasterType INT, IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `master-type` SET `table` = p_table, `column` = p_column, `value` = p_value, `code` = p_code
	WHERE  idMasterType = p_idMasterType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMessage`(IN p_idMessage INT,
  IN p_dtViewed DATETIME)
BEGIN
	UPDATE hub.message 
  SET dtViewed = p_dtViewed
	WHERE idMessage = p_idMessage;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateNotification`(IN p_idNotification INT,
  IN p_serviceBeingBookedEmail BIT(1),
  IN p_serviceBeingBookedText BIT(1),
  IN p_bookingRequestSubmittedEmail BIT(1),
  IN p_bookingRequestSubmittedText BIT(1),
  IN p_bookingRequestConfirmedEmail BIT(1),
  IN p_bookingRequestConfirmedText BIT(1),
  IN p_bookingCancelEmail BIT(1),
  IN p_bookingCancelText BIT(1),
  IN p_reminderProviderApptEmail BIT(1),
  IN p_reminderProviderApptText BIT(1),
  IN p_reminderConsumerApptEmail BIT(1),
  IN p_reminderConsumerApptText BIT(1))
BEGIN
	UPDATE hub.notification 
  SET serviceBeingBookedEmail = p_serviceBeingBookedEmail,
    serviceBeingBookedText = p_serviceBeingBookedText,
    bookingRequestSubmittedEmail = p_bookingRequestSubmittedEmail,
    bookingRequestSubmittedText = p_bookingRequestSubmittedText,
    bookingRequestConfirmedEmail = p_bookingRequestConfirmedEmail,
    bookingRequestConfirmedText = p_bookingRequestConfirmedText,
    bookingCancelEmail = p_bookingCancelEmail,
    bookingCancelText = p_bookingCancelText,
    reminderProviderApptEmail = p_reminderProviderApptEmail,
    reminderProviderApptText = p_reminderProviderApptText,
    reminderConsumerApptEmail = p_reminderConsumerApptEmail,
    reminderConsumerApptText = p_reminderConsumerApptText
	WHERE  idNotification = p_idNotification;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateOffer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOffer`(IN p_idOffer bigint(20), 
    IN p_idEntity CHAR(36),
    IN p_offerType smallint, 
    IN p_confirmMethod TINYINT,
    IN p_price float, 
    IN p_rateType smallint,
    IN p_negotiable bit(1),
    IN p_quantify bit(1),
    IN p_quantity smallint,
    IN p_minTimeIncrement smallint,
    IN p_maxTimeIncrement SMALLINT,
    IN p_startTimeIncrement SMALLINT,
    IN p_bookingLeadNumber SMALLINT,
    IN p_bookingLeadType SMALLINT,
    IN p_cancelLeadNumber SMALLINT,
    IN p_cancelLeadType SMALLINT,
    IN p_cancelFee FLOAT,
    IN p_handlePayment bit(1),
    IN p_depositRequired TINYINT,
    IN p_cancelPolicyOn bit(1),
    IN p_cancelFeeType TINYINT,
    IN p_depositAmountType TINYINT,
    IN p_depositAmount FLOAT)
BEGIN
	UPDATE offer 
  SET offerType=p_offerType, confirmMethod=p_confirmMethod, price=p_price, rateType=p_rateType, negotiable=p_negotiable, quantify=p_quantify, quantity=p_quantity,  
    minTimeIncrement=p_minTimeIncrement, maxTimeIncrement = p_maxTimeIncrement, startTimeIncrement = p_startTimeIncrement, 
    bookingLeadNumber = p_bookingLeadNumber, bookingLeadType = p_bookingLeadType, 
    cancelLeadNumber = p_cancelLeadNumber, cancelLeadType = p_cancelLeadType, 
    cancelFee = p_cancelFee, handlePayment = p_handlePayment, depositRequired = p_depositRequired, cancelPolicyOn=p_cancelPolicyOn, cancelFeeType = p_cancelFeeType,
    depositAmountType = p_depositAmountType, depositAmount = p_depositAmount
  WHERE idOffer = p_idOffer AND idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrder`(IN p_idOrder bigint(20), 
    IN p_idUser char(36), 
    IN p_idAddress bigint(20), 
    IN p_idCreditCard bigint(20), 
    IN p_state tinyint, 
    IN p_inventoryLockTime datetime)
BEGIN
	UPDATE hub.order 
    SET idUser = UUID_TO_BIN(p_idUser), idAddress = p_idAddress, idCreditCard = p_idCreditCard, 
        state = p_state, inventoryLockTime = p_inventoryLockTime 
    WHERE idOrder = p_idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateOrderItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrderItem`(IN p_idOrder bigint(20), 
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(20))
BEGIN
	UPDATE `order-item` 
    SET idEntity = UUID_TO_BIN(p_idEntity), quantity = p_quantity, totalPrice = p_totalPrice, idOffer = p_idOffer
    WHERE idOrder = p_idOrder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePerson`(IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	UPDATE hub.person SET personFirstName = p_personFirstName, personLastName = p_personLastName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePlace` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePlace`(IN p_idEntity CHAR(36), IN p_placeType INT)
BEGIN
	UPDATE hub.place SET placeType = p_placeType WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePost`(IN p_idEntity CHAR(36), IN p_seeking BIT(1))
BEGIN
	UPDATE hub.post SET seeking=p_seeking WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateService` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateService`(IN p_idEntity CHAR(36), IN p_online BIT(1), IN p_inPerson BIT(1), IN p_onDemand BIT(1), IN p_byAppt BIT(1))
BEGIN
	UPDATE hub.service SET `online`=p_online, inPerson=p_inPerson, onDemand=p_onDemand, byAppt=p_byAppt WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT, IN p_userTimeZone TINYINT)
BEGIN
	UPDATE hub.user SET userName = p_userName, userPassword = p_userPassword, userSalt = p_userSalt, userPrimaryEmail = p_userPrimaryEmail, userTimeZone = p_userTimeZone WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserName`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64))
BEGIN
	UPDATE hub.user SET userName = p_userName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUserPrimaryEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserPrimaryEmail`(IN p_idEntity CHAR(36), IN p_userPrimaryEmail BIGINT)
BEGIN
	UPDATE hub.user SET userPrimaryEmail = p_userPrimaryEmail WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUserProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserProfile`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userTimeZone TINYINT)
BEGIN
	UPDATE hub.user SET userName = p_userName, userTimeZone = p_userTimeZone WHERE idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUserSession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserSession`(IN p_idSession CHAR(36), IN p_idEntity CHAR(36), IN p_done BIT(1))
BEGIN
	UPDATE `user-session` SET dtActive = Now(), done = p_done WHERE idSession = UUID_TO_BIN(p_idSession) AND idEntity = UUID_TO_BIN(p_idEntity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verifyEntityRelate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `verifyEntityRelate`(IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, relateType, BIN_TO_UUID(idRelated) as idRelated 
	FROM `entity-relate` 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-11 10:12:12
