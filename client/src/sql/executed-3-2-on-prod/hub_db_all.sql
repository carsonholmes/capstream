DELIMITER //
DROP DATABASE `hub`//
CREATE DATABASE `hub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci *///
use hub//
CREATE TABLE `entity` (
  `idEntity` BINARY(16) NOT NULL,
  `entityTitle` VARCHAR(255) DEFAULT NULL,
  `entityDesc` TEXT DEFAULT NULL,
  `entityType` INT NOT NULL,
  `idMedia` BIGINT UNSIGNED NULL,
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
  `xOffset` FLOAT DEFAULT '0',
  `yOffset` FLOAT DEFAULT '0',
  `scale` FLOAT DEFAULT '1',
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
CREATE TABLE `hub`.`post` (
  `idEntity`  BINARY(16) NOT NULL,
  `seeking` bit(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPost` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`item` (
  `idEntity`  BINARY(16) NOT NULL,
  `condition` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityItem` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`offer` (
  `idOffer` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity`  BINARY(16) NOT NULL,
  `offerType` INT NOT NULL,
  `price` FLOAT NOT NULL,
  `timeType` INT NOT NULL,
  `timeIncrMins` INT NOT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`idOffer`),
  UNIQUE INDEX `idOffer_UNIQUE` (`idOffer` ASC) VISIBLE,
  CONSTRAINT `fkEntityOffer` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`event` (
  `idEntity`  BINARY(16) NOT NULL,
  `eventType` INT NOT NULL,
  `dtStart` DATETIME NOT NULL,
  `dtEnd` DATETIME DEFAULT NULL,
  `allDay` bit(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityEvent` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`group` (
  `idEntity`  BINARY(16) NOT NULL,
  `groupType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityGroup` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`place` (
  `idEntity`  BINARY(16) NOT NULL,
  `placeType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPlace` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`location` (
  `idLocation` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity`  BINARY(16) NOT NULL,
  `addressLine1` VARCHAR(255) NOT NULL,
  `addressLine2` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  `postalCode` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idLocation`),
  UNIQUE INDEX `idLocation_UNIQUE` (`idLocation` ASC) VISIBLE,
  CONSTRAINT `fkEntityLocation` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`cart` (
  `idEntity` BINARY(16) NOT NULL,
  `idUser` BINARY(16) NOT NULL,
  `quanitty` INT UNSIGNED NULL,
  `lastPrice` DOUBLE NULL,
  PRIMARY KEY (`idEntity`, `idUser`),
  CONSTRAINT `fkEntityCart` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`),
  CONSTRAINT `fkUserCart` FOREIGN KEY (`idUser`) REFERENCES `entity` (`identity`)
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
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-relate', 'relateType', 'owns', '1')//
insert into `master-type` (`table`, `column`, `value`, `code`) values ('entity-relate', 'relateType', 'linked-to', '2')//
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

DROP PROCEDURE IF EXISTS hub.insertAttribute//
CREATE PROCEDURE hub.insertAttribute (IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO hub.attribute (attrDesc, attrType, idSuggestor) VALUES(p_attrDesc, p_attrType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.selectAttribute//
CREATE PROCEDURE hub.selectAttribute (IN p_idAttribute INT)
BEGIN
	SELECT * FROM hub.attribute WHERE idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.updateAttribute//
CREATE PROCEDURE hub.updateAttribute (IN p_idAttribute INT, IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE hub.attribute SET attrDesc = p_attrDesc, attrType = p_attrType, idSuggestor = p_idSuggestor 
	WHERE  idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.deleteAttribute//
CREATE PROCEDURE hub.deleteAttribute (IN p_idAttribute INT)
BEGIN
	DELETE FROM hub.attribute WHERE  idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.insertCategory//
CREATE PROCEDURE hub.insertCategory (IN P_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_catOther BIT(1))
BEGIN
	INSERT INTO hub.category (idParent, catDesc, catLevel, catOther) VALUES(p_idParent, p_catDesc, p_catLevel, p_catOther);
	SELECT LAST_INSERT_ID() as idCategory;
END//
DROP PROCEDURE IF EXISTS hub.selectCategory//
CREATE PROCEDURE hub.selectCategory (IN p_idCategory INT)
BEGIN
	SELECT * FROM hub.category WHERE idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.updateCategory//
CREATE PROCEDURE hub.updateCategory (IN p_idCategory INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_catOther BIT(1))
BEGIN
	UPDATE hub.category SET catDesc = p_catDesc, catLevel = p_catLevel, catOther = p_catOther
	WHERE  idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.deleteCategory//
CREATE PROCEDURE hub.deleteCategory (IN p_idCategory INT)
BEGIN
	DELETE FROM hub.category WHERE  idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.insertEmail//
CREATE PROCEDURE hub.insertEmail (IN p_idEntity CHAR(36), IN p_emailAddress VARCHAR(320), IN p_emailVerifyCode CHAR(6))
BEGIN
	INSERT INTO hub.email (idEntity, emailAddress, emailVerifyCode) VALUES(UUID_TO_BIN(p_idEntity), p_emailAddress, p_emailVerifyCode);
	SELECT LAST_INSERT_ID() AS idEmail;
END//
DROP PROCEDURE IF EXISTS hub.selectEmail//
CREATE PROCEDURE hub.selectEmail (IN p_idEmail BIGINT)
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM hub.email WHERE idEmail = p_idEmail;
END//
DROP PROCEDURE IF EXISTS hub.selectEmailByEntity//
CREATE PROCEDURE hub.selectEmailByEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM hub.email WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEmail//
CREATE PROCEDURE hub.updateEmail  (IN p_idEmail BIGINT, IN p_emailAddress VARCHAR(320), IN p_emailVerified TINYINT(1), IN p_emailVerifyCode CHAR(6))
BEGIN
	UPDATE hub.email SET emailAddress = p_emailAddress, emailVerified = p_emailVerified, emailVerifyCode = p_emailVerifyCode WHERE idEmail = p_idEmail;
END//
DROP PROCEDURE IF EXISTS hub.deleteEmail//
CREATE PROCEDURE hub.deleteEmail (IN p_idEmail BIGINT)
BEGIN
	DELETE FROM hub.email WHERE idEmail = p_idEmail;
END//
DROP PROCEDURE IF EXISTS hub.insertEntityAttribute//
CREATE PROCEDURE hub.insertEntityAttribute (IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	INSERT INTO `entity-attribute` (idEntity, idAttribute, value, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idAttribute, p_value, Now());
END//
DROP PROCEDURE IF EXISTS hub.selectEntityAttribute//
CREATE PROCEDURE hub.selectEntityAttribute (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM `entity-attribute` WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntityAttribute//
CREATE PROCEDURE hub.updateEntityAttribute (IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	UPDATE `entity-attribute` SET value = p_value, dtLastEdited = Now() 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityAttribute//
CREATE PROCEDURE hub.deleteEntityAttribute (IN p_idEntity CHAR(36), IN p_idAttribute INT)
BEGIN
	DELETE FROM `entity-attribute` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.insertEntityCategory//
CREATE PROCEDURE hub.insertEntityCategory (IN p_idEntity CHAR(36), IN p_idCategory INT, IN p_otherDesc VARCHAR(1024))
BEGIN
	INSERT INTO `entity-category` (idEntity, idCategory, otherDesc, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idCategory, p_otherDesc, Now());
END//
DROP PROCEDURE IF EXISTS hub.selectEntityCategory//
CREATE PROCEDURE hub.selectEntityCategory (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM `entity-category` WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntityCategory//
CREATE PROCEDURE hub.updateEntityCategory (IN p_idEntity CHAR(36), IN p_idCategory INT, IN p_otherDesc VARCHAR(1024))
BEGIN
	UPDATE `entity-category` SET otherDesc = p_otherDesc, dtLastEdited = Now() 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityCategory//
CREATE PROCEDURE hub.deleteEntityCategory (IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	DELETE FROM `entity-category` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.insertEntityMedia//
CREATE PROCEDURE hub.insertEntityMedia (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_mediaType INT, IN p_fileName VARCHAR(50), IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT, IN scale FLOAT)
BEGIN
	INSERT INTO `entity-media` (idEntity, idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale) 
	VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idUser), p_mediaType, p_fileName, Now(), p_sortOrder, p_xOffset, p_yOffset, p_scale);
	SELECT LAST_INSERT_ID() AS idMedia;
END//
DROP PROCEDURE IF EXISTS hub.selectEntityMedia//
CREATE PROCEDURE hub.selectEntityMedia (IN p_idMedia BIGINT)
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale 
	FROM `entity-media` WHERE idMedia = p_idMedia;
END//
DROP PROCEDURE IF EXISTS hub.selectEntityMediaByEntity//
CREATE PROCEDURE hub.selectEntityMediaByEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale
	FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity) ORDER BY sortOrder ASC;
END//
DROP PROCEDURE IF EXISTS hub.updateEntityMedia//
CREATE PROCEDURE hub.updateEntityMedia  (IN p_idMedia BIGINT, IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT, IN p_scale FLOAT)
BEGIN
	UPDATE `entity-media` SET sortOrder = p_sortOrder, xOffset = p_xOffset, yOffset = p_yOffset, scale = p_scale WHERE idMedia = p_idMedia;
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityMedia//
CREATE PROCEDURE hub.deleteEntityMedia (IN p_idMedia BIGINT)
BEGIN
	DELETE FROM `entity-media` WHERE idMedia = p_idMedia;
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityMediaAll//
CREATE PROCEDURE hub.deleteEntityMediaAll (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.insertEntityRelate//
CREATE PROCEDURE hub.insertEntityRelate (IN p_idEntity CHAR(36), IN p_idRelated CHAR(36), IN p_relateType INT)
BEGIN
	INSERT INTO `entity-relate` (idEntity, idRelated, relateType) VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idRelated), p_relateType);
END//
DELIMITER //
DROP PROCEDURE IF EXISTS hub.selectEntityRelate//
CREATE PROCEDURE hub.selectEntityRelate (IN p_idEntity CHAR(36), IN p_relateType INT)
BEGIN
	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset, em.scale 
		FROM hub.entity AS e, `entity-media` as em, `entity-relate` as er
		WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia = em.idMedia)
	UNION ALL 
  	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL as fileName, NULL as mediaType, 0 as xOffset, 0 as yOffset, 0 as scale
    	FROM hub.entity AS e, `entity-relate` as er
    	WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia is NULL);
END//
DROP PROCEDURE IF EXISTS hub.selectEntityRelateByRelated//
CREATE PROCEDURE hub.selectEntityRelateByRelated (IN p_idRelated CHAR(36))
BEGIN
	SELECT * FROM `entity-relate` WHERE idRelated = UUID_TO_BIN(p_idRelated);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityRelate//
CREATE PROCEDURE hub.deleteEntityRelate (IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityRelateAll//
CREATE PROCEDURE hub.deleteEntityRelateAll (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) OR idRelated = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.insertEntity//
CREATE PROCEDURE hub.insertEntity (IN p_entityTitle VARCHAR(255), IN p_entityDesc TEXT, IN p_entityType INT)
BEGIN
	SET @idEntity = UUID_TO_BIN(UUID());
	INSERT INTO hub.entity (idEntity, entityTitle, entityDesc, entityType, dtCreated) VALUES(@idEntity, p_entityTitle, p_entityDesc, p_entityType, Now());
	SELECT BIN_TO_UUID(@idEntity) as idEntity;
END//
DROP PROCEDURE IF EXISTS hub.selectEntity//
CREATE PROCEDURE hub.selectEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, entityDesc, entityType, idMedia, dtCreated, dtLastEdited  FROM hub.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.selectEntityBySearch//
CREATE PROCEDURE hub.selectEntityBySearch (IN p_searchValue CHAR(255))
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
END//
DROP PROCEDURE IF EXISTS hub.selectEntityByEntityType//
CREATE PROCEDURE hub.selectEntityByEntityType (IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, entityDesc, entityType, idMedia, dtCreated, dtLastEdited FROM hub.entity WHERE entityType = p_entityType;
END//
DROP PROCEDURE IF EXISTS hub.selectEntityByOwner//
CREATE PROCEDURE hub.selectEntityByOwner (IN p_idEntity CHAR(36), IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited 
  FROM hub.entity AS e, `entity-relate` AS er
  WHERE idRelated = UUID_TO_BIN(p_idEntity) AND er.relateType = 1 AND er.idEntity = e.idEntity AND entityType = p_entityType
  ORDER BY dtCreated DESC;
END//
DROP PROCEDURE IF EXISTS hub.updateEntity//
CREATE PROCEDURE hub.updateEntity (IN p_idEntity CHAR(36), IN p_entityTitle VARCHAR(255), IN p_entityDesc TEXT)
BEGIN
	UPDATE hub.entity 
  SET entityTitle = p_entityTitle, entityDesc = p_entityDesc, dtLastEdited = Now() 
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntityPrimaryMedia//
CREATE PROCEDURE hub.updateEntityPrimaryMedia (IN p_idEntity CHAR(36), IN p_idMedia BIGINT)
BEGIN
  UPDATE hub.entity
  SET idMedia = p_idMedia
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntity//
CREATE PROCEDURE hub.deleteEntity (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.insertMasterType//
CREATE PROCEDURE hub.insertMasterType (IN p_table VARCHAR(100), IN p_column VARCHAR(100), IN p_value VARCHAR(255), IN p_code VARCHAR(45))
BEGIN
	INSERT INTO `master-type` (`table`, `column`, `value`, `code`) VALUES (p_table, p_column, p_value, p_code);
	SELECT LAST_INSERT_ID() as idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.selectMasterType//
CREATE PROCEDURE hub.selectMasterType (IN p_idMasterType INT)
BEGIN
	SELECT * FROM `master-type` WHERE idMasterType = p_idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.selectMasterTypeByValue//
CREATE PROCEDURE hub.selectMasterTypeByValue (IN p_value VARCHAR(255))
BEGIN
	SELECT * FROM `master-type` WHERE `value` = p_value;
END//
DROP PROCEDURE IF EXISTS hub.updateMasterType//
CREATE PROCEDURE hub.updateMasterType (IN p_idMasterType INT, IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `master-type` SET `table` = p_table, `column` = p_column, `value` = p_value, `code` = p_code
	WHERE  idMasterType = p_idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.deleteMasterType//
CREATE PROCEDURE hub.deleteMasterType (IN p_idMasterType INT)
BEGIN
	DELETE FROM `master-type` WHERE  idMasterType = p_idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.insertPerson//
CREATE PROCEDURE hub.insertPerson (IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	INSERT INTO hub.person (idEntity, personFirstName, personLastName) VALUES(UUID_TO_BIN(p_idEntity), p_personFirstName, p_personLastName);
END//
DROP PROCEDURE IF EXISTS hub.selectPerson//
CREATE PROCEDURE hub.selectPerson (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updatePerson//
CREATE PROCEDURE hub.updatePerson (IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	UPDATE hub.person SET personFirstName = p_personFirstName, personLastName = p_personLastName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deletePerson//
CREATE PROCEDURE hub.deletePerson (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.insertResetPasswordSession//
CREATE PROCEDURE hub.insertResetPasswordSession (IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	INSERT INTO `reset-password-session` (idSession, idEntity, dtStarted) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), Now());
	SELECT @idSession as idSession;
END//
DROP PROCEDURE IF EXISTS hub.selectResetPasswordSession//
CREATE PROCEDURE hub.selectResetPasswordSession (IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idSession) AS idSession, BIN_TO_UUID(idEntity) AS idEntity, dtStarted 
	FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END//
DROP PROCEDURE IF EXISTS hub.deleteResetPasswordSession//
CREATE PROCEDURE hub.deleteResetPasswordSession (IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END//
DROP PROCEDURE IF EXISTS hub.insertSuggestion//
CREATE PROCEDURE hub.insertSuggestion (IN p_idEntity CHAR(36), IN p_suggestion TEXT)
BEGIN
	INSERT INTO hub.suggestion (idEntity, suggestion, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_suggestion, Now());
	SELECT LAST_INSERT_ID() as idSuggestion;
END//
DROP PROCEDURE IF EXISTS hub.selectSuggestion//
CREATE PROCEDURE hub.selectSuggestion (IN p_idSuggestion INT)
BEGIN
	SELECT * FROM hub.suggestion WHERE idSuggestion = p_idSuggestion;
END//
DROP PROCEDURE IF EXISTS hub.selectSuggestionByEntity//
CREATE PROCEDURE hub.selectSuggestionByEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.suggestion WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteSuggestion//
CREATE PROCEDURE hub.deleteSuggestion (IN p_idSuggestion INT)
BEGIN
	DELETE FROM hub.suggestion WHERE idSuggestion = p_idSuggestion;
END//
DROP PROCEDURE IF EXISTS hub.insertUserSession//
CREATE PROCEDURE hub.insertUserSession (IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	SET @Now = Now();
	INSERT INTO `user-session` (idSession, idEntity, dtStarted, dtActive, done) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), @Now, @Now, 0);
	SELECT @idSession as idSession;
END//
DROP PROCEDURE IF EXISTS hub.selectUserSession//
CREATE PROCEDURE hub.selectUserSession (IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID( idSession) as idSession, BIN_TO_UUID( idEntity ) as idEntity, dtStarted, dtActive, done
	FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END//
DROP PROCEDURE IF EXISTS hub.updateUserSession//
CREATE PROCEDURE hub.updateUserSession (IN p_idSession CHAR(36), IN p_idEntity CHAR(36), IN p_done BIT(1))
BEGIN
	UPDATE `user-session` SET dtActive = Now(), done = p_done WHERE idSession = UUID_TO_BIN(p_idSession) AND idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteUserSession//
CREATE PROCEDURE hub.deleteUserSession (IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END//
DROP PROCEDURE IF EXISTS hub.insertUser//
CREATE PROCEDURE hub.insertUser (IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT)
BEGIN
	INSERT INTO hub.user (idEntity, userName, userPassword, userSalt, userPrimaryEmail) VALUES(UUID_TO_BIN(p_idEntity), p_userName, p_userPassword, p_userSalt, p_userPrimaryEmail);
END//
DROP PROCEDURE IF EXISTS hub.selectUser//
CREATE PROCEDURE hub.selectUser (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, userName, userPassword, userSalt, userPrimaryEmail FROM hub.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.selectUserByUserName//
CREATE PROCEDURE hub.selectUserByUserName (IN p_userName CHAR(64))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, userName, userPassword, userSalt, userPrimaryEmail FROM hub.user WHERE userName = p_userName;
END//
DROP PROCEDURE IF EXISTS hub.selectUserByEmail//
CREATE PROCEDURE hub.selectUserByEmail (IN p_emailAddress VARCHAR(320))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.emailAddress
	FROM hub.user AS u, hub.email AS E WHERE u.idEntity = e.idEntity AND e.emailAddress = p_emailAddress;
END//
DROP PROCEDURE IF EXISTS hub.updateUser//
CREATE PROCEDURE hub.updateUser (IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT)
BEGIN
	UPDATE hub.user SET userName = p_userName, userPassword = p_userPassword, userSalt = p_userSalt, userPrimaryEmail = p_userPrimaryEmail WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateUserName//
CREATE PROCEDURE hub.updateUserName (IN p_idEntity CHAR(36), IN p_userName VARCHAR(64))
BEGIN
	UPDATE hub.user SET userName = p_userName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateUserPrimaryEmail//
CREATE PROCEDURE hub.updateUserPrimaryEmail (IN p_idEntity CHAR(36), IN p_userPrimaryEmail BIGINT)
BEGIN
	UPDATE hub.user SET userPrimaryEmail = p_userPrimaryEmail WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//DROP PROCEDURE IF EXISTS hub.deleteUser//
CREATE PROCEDURE hub.deleteUser (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.insertCart//
CREATE PROCEDURE hub.insertCart (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_lastPrice DOUBLE)
BEGIN
	INSERT INTO cart (idUser, idEntity, quantity, lastPrice) VALUES(UUID_TO_BIN(p_idUser), UUID_TO_BIN(p_idEntity), p_quantity, p_lastPrice);
END//
DROP PROCEDURE IF EXISTS hub.selectCart//
CREATE PROCEDURE hub.selectCart (IN p_idUser CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited
    	FROM hub.entity AS e, cart as c
    	WHERE c.idUser = UUID_TO_BIN(p_idUser) AND c.idEntity = e.idEntity;
END//
DROP PROCEDURE IF EXISTS hub.updateCartItem//
CREATE PROCEDURE hub.updateCartItem (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_lastPrice DOUBLE)
BEGIN
	UPDATE cart SET quanity=p_quantity, lastPrice=p_lastPrice WHERE idUser = UUID_TO_BIN(p_idUser) AND idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteCart//
CREATE PROCEDURE hub.deleteCart (IN p_idUser CHAR(36), IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM cart WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idUser = UUID_TO_BIN(p_idUser);
END//
DROP PROCEDURE IF EXISTS hub.deleteCart//
CREATE PROCEDURE hub.deleteCart (IN p_idUser CHAR(36))
BEGIN
	DELETE FROM cart WHERE idUser = UUID_TO_BIN(p_idUser);
END//

DELIMITER ;