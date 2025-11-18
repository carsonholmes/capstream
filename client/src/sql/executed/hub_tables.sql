DELIMITER //
DROP DATABASE `hub`//
CREATE DATABASE `hub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci *///
use hub//
CREATE TABLE `entity` (
  `idEntity` BINARY(16) NOT NULL,
  `entityTitle` VARCHAR(255) DEFAULT NULL,
  `entityDesc` VARCHAR(30000) DEFAULT NULL,
  `entityType` INT NOT NULL,
  `dtCreated` datetime NOT NULL,
  `dtLastEdited` datetime NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `email` (
  `idEmail` BIGINT unsigned NOT NULL AUTO_INCREMENT,
  `idEntity`  BINARY(16) NOT NULL,
  `emailAddress` varchar(320) NOT NULL,
  `emailVerified` tinyint(1) DEFAULT NULL,
  `emailVerifyCode` CHAR(6) NOT NULL,
  PRIMARY KEY (`idEmail`),
  UNIQUE KEY `idEmail_UNIQUE` (`idEmail`),
  KEY `fkEntityEmail_idx` (`idEntity`),
  CONSTRAINT `fkEntityEmail` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `user` (
  `idEntity`  BINARY(16) NOT NULL,
  `userName` varchar(64) NOT NULL,
  `userPassword` varchar(60) NOT NULL,
  `userSalt` varchar(29) NOT NULL,
  `userPrimaryEmail` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityUser` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`),
  CONSTRAINT `fkUserEmail` FOREIGN KEY (`userPrimaryEmail`) REFERENCES `hub`.`email` (`idEmail`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `person` (
  `idEntity`  BINARY(16) NOT NULL,
  `personFirstName` varchar(128) DEFAULT NULL,
  `personLastName` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPerson` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `user-session` (
  `idSession` BINARY(16) NOT NULL,
  `idEntity`  BINARY(16) NOT NULL,
  `dtStarted` datetime NOT NULL,
  `dtActive` datetime NOT NULL,
  `done` bit(1) NOT NULL,
  PRIMARY KEY (`idSession`, `idEntity`),
  CONSTRAINT `fkUserUS` FOREIGN KEY (`idEntity`) REFERENCES `user` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `reset-password-session` (
  `idSession` BINARY(16) NOT NULL,
  `idEntity`  BINARY(16) NOT NULL,
  `dtStarted` datetime NOT NULL,
  PRIMARY KEY (`idSession`),
  KEY `fkUserFPS_idx` (`idEntity`),
  CONSTRAINT `fkUserFPS` FOREIGN KEY (`idEntity`) REFERENCES `user` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`entity-media` (
  `idMedia` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity`  BINARY(16) NOT NULL,
  `idUser`  BINARY(16) NOT NULL,
  `mediaType` INT UNSIGNED NOT NULL,
  `fileName` VARCHAR(50) NOT NULL,
  `dtCreated` DATETIME NOT NULL,
  `sortOrder` INT NOT NULL,
  `xOffset` float DEFAULT '0',
  `yOffset` float DEFAULT '0',
  PRIMARY KEY (`idMedia`),
  KEY `fkEntityEM_idx` (`idEntity`),
  CONSTRAINT `fkEntityEM` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`master-type` (
  `idMasterType` INT NOT NULL AUTO_INCREMENT,
  `table` VARCHAR(100) NOT NULL,
  `column` VARCHAR(100) NOT NULL,
  `value` VARCHAR(255) NULL,
  `code` VARCHAR(45) NULL,
  PRIMARY KEY (`idMasterType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`suggestion` (
  `idSuggestion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity`  BINARY(16) NULL,
  `suggestion` TEXT NULL,
  `dtCreated` DATETIME NOT NULL,
  PRIMARY KEY (`idSuggestion`),
  UNIQUE INDEX `idSuggestion_UNIQUE` (`idSuggestion` ASC) VISIBLE
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`entity-relate` (
  `idEntity` BINARY(16) NOT NULL,
  `idRelated` BINARY(16) NOT NULL,
  `relateType` INT NOT NULL,
  PRIMARY KEY (`idEntity`, `idRelated`),
  CONSTRAINT `fkEntityET` FOREIGN KEY (`idEntity`) REFERENCES `hub`.`entity` (`idEntity`),
  CONSTRAINT `fkEntityET2` FOREIGN KEY (`idRelated`) REFERENCES `hub`.`entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`category` (
  `idCategory` INT UNSIGNED NOT NULL,
  `idParent` INT UNSIGNED NOT NULL,
  `catLevel` INT NOT NULL,
  `catDesc` VARCHAR(1024) NOT NULL,
  `catOther` bit(1) NOT NULL,
  PRIMARY KEY (`idCategory`),
  UNIQUE INDEX `idCategory_UNIQUE` (`idCategory` ASC) VISIBLE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`entity-category` (
  `idEntity`  BINARY(16) NOT NULL,
  `idCategory` INT UNSIGNED NOT NULL,
  `otherDesc` VARCHAR(1024) NULL,
  `dtCreated` DATETIME NOT NULL,
  `dtLastEdited` DATETIME NULL,
  KEY `fkEntityEC_idx` (`idEntity`),
  KEY `fkCategoryEC_idx` (`idCategory`),
  CONSTRAINT `fkCategoryEC` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idcategory`),
  CONSTRAINT `fkEntityEC` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`attribute` (
  `idAttribute` INT UNSIGNED NOT NULL,
  `attrDesc` VARCHAR(1024) NULL,
  `attrType` INT UNSIGNED NOT NULL,
  `idSuggestor` BINARY(16) NOT NULL,
  PRIMARY KEY (`idAttribute`),
  UNIQUE INDEX `idAttribute_UNIQUE` (`idAttribute` ASC) VISIBLE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`common-attribute` (
  `idAttribute` INT UNSIGNED NOT NULL,
  `idCategory` INT UNSIGNED NOT NULL,
  `sortOrder` INT NULL,
  PRIMARY KEY (`idAttribute`, `idCategory`),
  KEY `fkCategory_idx` (`idCategory`),
  CONSTRAINT `fkAttribute` FOREIGN KEY (`idAttribute`) REFERENCES `attribute` (`idattribute`),
  CONSTRAINT `fkCategory` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idcategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`entity-attribute` (
  `idEntity`  BINARY(16) NOT NULL,
  `idAttribute` INT UNSIGNED NOT NULL,
  `value` VARCHAR(1024) NULL,
  `dtCreated` DATETIME NULL,
  `dtLastEdited` DATETIME NULL,
  KEY `fkEntityEA_idx` (`idEntity`),
  KEY `fkAttributeEA_idx` (`idAttribute`),
  CONSTRAINT `fkAttributeEA` FOREIGN KEY (`idAttribute`) REFERENCES `attribute` (`idattribute`),
  CONSTRAINT `fkEntityEA` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//

insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'user', '1')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'media', '2')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'post', '3')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'person', '4')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'item', '5')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'service', '6')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'event', '7')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'place', '8')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity', 'entityType', 'group', '9')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-relate', 'relateType', 'tagged in post', '1')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-relate', 'relateType', 'owns', '2')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'bmp', 'bmp')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'gif', 'gif')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'jpeg', 'jpeg')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'jpg', 'jpg')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'png', 'png')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'tiff', 'tiff')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'tif', 'tif')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'avi', 'avi')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'mp4', 'mp4')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'webm', 'webm')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'mpg', 'mpg')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'ogg', 'ogg')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'mov', 'mov')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'mp3', 'mp3')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'wav', 'wav')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-media', 'mediaType', 'm4a', 'm4a')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('offer', 'offerType', 'Fixed Price', '1')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('offer', 'offerType', 'Time Based Rate', '2')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('offer', 'offerType', 'Auction', '3')//

DELIMITER ;