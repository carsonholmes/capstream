-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema capstream
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `capstream` ;

-- -----------------------------------------------------
-- Schema capstream
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `capstream` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `capstream` ;

-- -----------------------------------------------------
-- Table `capstream`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`country` ;

CREATE TABLE IF NOT EXISTS `capstream`.`country` (
  `idCountry` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `code` CHAR(2) NOT NULL,
  `active` BIT(1) NOT NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB
AUTO_INCREMENT = 247
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`province`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`province` ;

CREATE TABLE IF NOT EXISTS `capstream`.`province` (
  `idProvince` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCountry` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `code` CHAR(2) NOT NULL,
  `active` BIT(1) NOT NULL,
  PRIMARY KEY (`idProvince`))
ENGINE = InnoDB
AUTO_INCREMENT = 73
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`location` ;

CREATE TABLE IF NOT EXISTS `capstream`.`location` (
  `idLocation` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `addressLine1` VARCHAR(255) NOT NULL,
  `addressLine2` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `idProvince` INT UNSIGNED NOT NULL,
  `idCountry` INT UNSIGNED NOT NULL,
  `postalCode` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idLocation`),
  UNIQUE INDEX `idLocation_UNIQUE` (`idLocation` ASC) VISIBLE,
  INDEX `fkLocationProvince` (`idProvince` ASC) VISIBLE,
  INDEX `fkLocationCountry` (`idCountry` ASC) VISIBLE,
  CONSTRAINT `fkLocationCountry`
    FOREIGN KEY (`idCountry`)
    REFERENCES `capstream`.`country` (`idCountry`),
  CONSTRAINT `fkLocationProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `capstream`.`province` (`idProvince`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`address` ;

CREATE TABLE IF NOT EXISTS `capstream`.`address` (
  `idAddress` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `idLocation` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `fkLocationAddress` (`idLocation` ASC) VISIBLE,
  CONSTRAINT `fkLocationAddress`
    FOREIGN KEY (`idLocation`)
    REFERENCES `capstream`.`location` (`idLocation`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`attribute` ;

CREATE TABLE IF NOT EXISTS `capstream`.`attribute` (
  `idAttribute` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `attrName` VARCHAR(1024) NULL DEFAULT NULL,
  `attrType` INT UNSIGNED NOT NULL,
  `idSuggestor` BINARY(16) NOT NULL,
  PRIMARY KEY (`idAttribute`),
  UNIQUE INDEX `idAttribute_UNIQUE` (`idAttribute` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`attribute-value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`attribute-value` ;

CREATE TABLE IF NOT EXISTS `capstream`.`attribute-value` (
  `idAttributeValue` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idAttribute` INT UNSIGNED NOT NULL,
  `attrValue` VARCHAR(1024) NULL DEFAULT NULL,
  `sortOrder` SMALLINT NOT NULL,
  `idSuggestor` BINARY(16) NOT NULL,
  PRIMARY KEY (`idAttributeValue`),
  UNIQUE INDEX `idAttributeValue_UNIQUE` (`idAttributeValue` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`booking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`booking` ;

CREATE TABLE IF NOT EXISTS `capstream`.`booking` (
  `idBooking` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEvent` INT UNSIGNED NOT NULL,
  `idAvailability` INT UNSIGNED NOT NULL,
  `idConsumer` BINARY(16) NOT NULL,
  `idService` BINARY(16) NOT NULL,
  `confirmed` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`idBooking`),
  UNIQUE INDEX `idBooking_UNIQUE` (`idBooking` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 332
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`entity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity` ;

CREATE TABLE IF NOT EXISTS `capstream`.`entity` (
  `idEntity` BINARY(16) NOT NULL,
  `entityTitle` VARCHAR(255) NULL DEFAULT NULL,
  `entityDesc` TEXT NULL DEFAULT NULL,
  `entityType` INT NOT NULL,
  `idMedia` BIGINT UNSIGNED NULL DEFAULT NULL,
  `dtCreated` DATETIME NOT NULL,
  `dtLastEdited` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`property-position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`property-position` ;

CREATE TABLE IF NOT EXISTS `capstream`.`property-position` (
  `idEntity` BINARY(16) NOT NULL,
  `propertyName` VARCHAR(255) NOT NULL,
  `sponsorGP` VARCHAR(255) NOT NULL,
  `partnershipLP` VARCHAR(255) NULL DEFAULT NULL,
  `acquisitionDate` DATE NULL DEFAULT NULL,
  `propertyNotes` TEXT NULL DEFAULT NULL,
  `lpEntity` VARCHAR(255) NOT NULL,
  `investedEquity` DECIMAL(18,2) NOT NULL,
  `investmentDate` DATE NOT NULL,
  `ownershipPct` DECIMAL(5,2) NULL DEFAULT NULL,
  `prefReturnPct` DECIMAL(5,2) NULL DEFAULT NULL,
  `distributionCadence` VARCHAR(32) NOT NULL DEFAULT 'Quarterly',
  `targetIRR` DECIMAL(5,2) NULL DEFAULT NULL,
  `targetEquityMultiple` DECIMAL(6,3) NULL DEFAULT NULL,
  `projectedSaleDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  INDEX `idx_property_position_propertyName` (`propertyName` ASC) VISIBLE,
  INDEX `idx_property_position_lpEntity` (`lpEntity` ASC) VISIBLE,
  CONSTRAINT `fk_property_position_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`cap-update`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`cap-update` ;

CREATE TABLE IF NOT EXISTS `capstream`.`cap-update` (
  `idEntity` BINARY(16) NOT NULL,
  `idProperty` BINARY(16) NOT NULL,
  `propertyName` VARCHAR(255) NULL DEFAULT NULL,
  `updateDate` DATE NOT NULL,
  `revisedSaleDate` DATE NULL DEFAULT NULL,
  `revisedIrrPct` DECIMAL(5,2) NULL DEFAULT NULL,
  `revisedEquityMultiple` DECIMAL(6,3) NULL DEFAULT NULL,
  `distributionGuidance` VARCHAR(32) NOT NULL DEFAULT 'Same as OM',
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  INDEX `idx_cap_update_property` (`idProperty` ASC) VISIBLE,
  INDEX `idx_cap_update_updateDate` (`updateDate` ASC) VISIBLE,
  CONSTRAINT `fk_cap_update_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),
  CONSTRAINT `fk_cap_update_property`
    FOREIGN KEY (`idProperty`)
    REFERENCES `capstream`.`property-position` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`cart` ;

CREATE TABLE IF NOT EXISTS `capstream`.`cart` (
  `idEntity` BINARY(16) NOT NULL,
  `idUser` BINARY(16) NOT NULL,
  `quantity` INT UNSIGNED NULL DEFAULT NULL,
  `idOffer` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idEntity`, `idUser`),
  INDEX `fkUserCart` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fkEntityCart`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),
  CONSTRAINT `fkUserCart`
    FOREIGN KEY (`idUser`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`category` ;

CREATE TABLE IF NOT EXISTS `capstream`.`category` (
  `idCategory` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idParent` INT UNSIGNED NOT NULL,
  `catLevel` INT NOT NULL,
  `catDesc` VARCHAR(1024) NOT NULL,
  `entityType` INT NOT NULL,
  `idSuggestor` BINARY(16) NULL DEFAULT NULL,
  `approved` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`idCategory`),
  UNIQUE INDEX `idCategory_UNIQUE` (`idCategory` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 119
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`common-attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`common-attribute` ;

CREATE TABLE IF NOT EXISTS `capstream`.`common-attribute` (
  `idCommonAttribute` INT UNSIGNED NOT NULL,
  `idAttribute` INT UNSIGNED NOT NULL,
  `idCategory` INT UNSIGNED NOT NULL,
  `sortOrder` INT NULL DEFAULT NULL,
  `required` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idCommonAttribute`),
  INDEX `fkCategory_idx` (`idCategory` ASC) VISIBLE,
  INDEX `fkAttribute_idx` (`idAttribute` ASC) VISIBLE,
  CONSTRAINT `fkAttribute`
    FOREIGN KEY (`idAttribute`)
    REFERENCES `capstream`.`attribute` (`idAttribute`),
  CONSTRAINT `fkCategory`
    FOREIGN KEY (`idCategory`)
    REFERENCES `capstream`.`category` (`idCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`credit-card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`credit-card` ;

CREATE TABLE IF NOT EXISTS `capstream`.`credit-card` (
  `idCreditCard` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(16) NOT NULL,
  `expiration` DATE NOT NULL,
  `ccv` VARCHAR(4) NOT NULL,
  `idAddressBilling` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idCreditCard`),
  INDEX `fkAddressCreditCard` (`idAddressBilling` ASC) VISIBLE,
  CONSTRAINT `fkAddressCreditCard`
    FOREIGN KEY (`idAddressBilling`)
    REFERENCES `capstream`.`address` (`idAddress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`email` ;

CREATE TABLE IF NOT EXISTS `capstream`.`email` (
  `idEmail` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NOT NULL,
  `emailAddress` VARCHAR(320) NOT NULL,
  `emailVerified` TINYINT(1) NULL DEFAULT NULL,
  `emailVerifyCode` CHAR(6) NOT NULL,
  PRIMARY KEY (`idEmail`),
  UNIQUE INDEX `idEmail_UNIQUE` (`idEmail` ASC) VISIBLE,
  INDEX `fkEntityEmail_idx` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityEmail`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`entity-attachment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity-attachment` ;

CREATE TABLE IF NOT EXISTS `capstream`.`entity-attachment` (
  `idAttachment` INT NOT NULL,
  `idEntity` BINARY(16) NOT NULL,
  `fileName` VARCHAR(255) NOT NULL,
  `dtAdded` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAttachment`),
  INDEX `idx_entity_attachment_entity` (`idEntity` ASC) VISIBLE,
  INDEX `idx_entity_attachment_dtAdded` (`dtAdded` ASC) VISIBLE,
  INDEX `idx_entity_attachment_fileName` (`fileName` ASC) VISIBLE,
  CONSTRAINT `fk_entity_attachment_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`entity-attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity-attribute` ;

CREATE TABLE IF NOT EXISTS `capstream`.`entity-attribute` (
  `idEntity` BINARY(16) NOT NULL,
  `idAttribute` INT UNSIGNED NOT NULL,
  `value` VARCHAR(1024) NULL DEFAULT NULL,
  `dtCreated` DATETIME NULL DEFAULT NULL,
  `dtLastEdited` DATETIME NULL DEFAULT NULL,
  INDEX `fkEntityEA_idx` (`idEntity` ASC) VISIBLE,
  INDEX `fkAttributeEA_idx` (`idAttribute` ASC) VISIBLE,
  CONSTRAINT `fkAttributeEA`
    FOREIGN KEY (`idAttribute`)
    REFERENCES `capstream`.`attribute` (`idAttribute`),
  CONSTRAINT `fkEntityEA`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`entity-category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity-category` ;

CREATE TABLE IF NOT EXISTS `capstream`.`entity-category` (
  `idEntity` BINARY(16) NOT NULL,
  `idCategory` INT UNSIGNED NOT NULL,
  `dtCreated` DATETIME NOT NULL,
  INDEX `fkEntityEC_idx` (`idEntity` ASC) VISIBLE,
  INDEX `fkCategoryEC_idx` (`idCategory` ASC) VISIBLE,
  CONSTRAINT `fkCategoryEC`
    FOREIGN KEY (`idCategory`)
    REFERENCES `capstream`.`category` (`idCategory`),
  CONSTRAINT `fkEntityEC`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`entity-media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity-media` ;

CREATE TABLE IF NOT EXISTS `capstream`.`entity-media` (
  `idMedia` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NOT NULL,
  `idUser` BINARY(16) NOT NULL,
  `mediaType` INT UNSIGNED NOT NULL,
  `fileName` VARCHAR(50) NOT NULL,
  `dtCreated` DATETIME NOT NULL,
  `sortOrder` INT NOT NULL,
  `xOffset` FLOAT NULL DEFAULT '0',
  `yOffset` FLOAT NULL DEFAULT '0',
  `scale` FLOAT NULL DEFAULT '1',
  PRIMARY KEY (`idMedia`),
  INDEX `fkEntityEM_idx` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityEM`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
AUTO_INCREMENT = 149
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`entity-relate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity-relate` ;

CREATE TABLE IF NOT EXISTS `capstream`.`entity-relate` (
  `idEntity` BINARY(16) NOT NULL,
  `idRelated` BINARY(16) NOT NULL,
  `relateType` INT NOT NULL,
  PRIMARY KEY (`idEntity`, `idRelated`, `relateType`),
  INDEX `fkEntityET2` (`idRelated` ASC) VISIBLE,
  CONSTRAINT `fkEntityET`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),
  CONSTRAINT `fkEntityET2`
    FOREIGN KEY (`idRelated`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`event` ;

CREATE TABLE IF NOT EXISTS `capstream`.`event` (
  `idEvent` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NOT NULL,
  `eventType` TINYINT NOT NULL,
  `dtStart` DATETIME NOT NULL,
  `dtEnd` DATETIME NULL DEFAULT NULL,
  `allDay` BIT(1) NOT NULL,
  `repeatType` TINYINT NOT NULL,
  `repeatTimeFrame` TINYINT NOT NULL,
  `repeatMonthlyType` TINYINT NOT NULL,
  `repeatInterval` SMALLINT NOT NULL,
  `repeatSun` BIT(1) NOT NULL,
  `repeatMon` BIT(1) NOT NULL,
  `repeatTue` BIT(1) NOT NULL,
  `repeatWed` BIT(1) NOT NULL,
  `repeatThu` BIT(1) NOT NULL,
  `repeatFri` BIT(1) NOT NULL,
  `repeatSat` BIT(1) NOT NULL,
  `repeatEndType` TINYINT NOT NULL,
  `repeatEnd` DATETIME NULL DEFAULT NULL,
  `repeatOccurences` SMALLINT NULL DEFAULT NULL,
  `allServices` BIT(1) NOT NULL,
  PRIMARY KEY (`idEvent`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEvent` ASC) VISIBLE,
  INDEX `fkEntityEvent` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityEvent`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
AUTO_INCREMENT = 491
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`event-chain-edit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`event-chain-edit` ;

CREATE TABLE IF NOT EXISTS `capstream`.`event-chain-edit` (
  `idEventChainEdit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEvent` INT UNSIGNED NOT NULL,
  `editType` TINYINT UNSIGNED NOT NULL,
  `dtStart` DATETIME NOT NULL,
  `idNewEvent` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idEventChainEdit`),
  UNIQUE INDEX `idEventChainEdit_UNIQUE` (`idEventChainEdit` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`group` ;

CREATE TABLE IF NOT EXISTS `capstream`.`group` (
  `idEntity` BINARY(16) NOT NULL,
  `groupType` INT NOT NULL,
  `backgroundColor` CHAR(7) NULL DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityGroup`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`item` ;

CREATE TABLE IF NOT EXISTS `capstream`.`item` (
  `idEntity` BINARY(16) NOT NULL,
  `condition` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityItem`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`master-type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`master-type` ;

CREATE TABLE IF NOT EXISTS `capstream`.`master-type` (
  `idMasterType` INT NOT NULL AUTO_INCREMENT,
  `table` VARCHAR(100) NOT NULL,
  `column` VARCHAR(100) NOT NULL,
  `value` VARCHAR(255) NULL DEFAULT NULL,
  `code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idMasterType`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`message` ;

CREATE TABLE IF NOT EXISTS `capstream`.`message` (
  `idMessage` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idThread` BIGINT UNSIGNED NOT NULL,
  `idSender` BINARY(16) NOT NULL,
  `idRecipient` BINARY(16) NOT NULL,
  `dtSent` DATETIME NOT NULL,
  `messageText` TEXT NOT NULL,
  `dtViewed` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idMessage`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`notification` ;

CREATE TABLE IF NOT EXISTS `capstream`.`notification` (
  `idNotification` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NOT NULL,
  `serviceBeingBookedEmail` BIT(1) NOT NULL,
  `serviceBeingBookedText` BIT(1) NOT NULL,
  `bookingRequestSubmittedEmail` BIT(1) NOT NULL,
  `bookingRequestSubmittedText` BIT(1) NOT NULL,
  `bookingRequestConfirmedEmail` BIT(1) NOT NULL,
  `bookingRequestConfirmedText` BIT(1) NOT NULL,
  `bookingCancelEmail` BIT(1) NOT NULL,
  `bookingCancelText` BIT(1) NOT NULL,
  `reminderProviderApptEmail` BIT(1) NOT NULL,
  `reminderProviderApptText` BIT(1) NOT NULL,
  `reminderConsumerApptEmail` BIT(1) NOT NULL,
  `reminderConsumerApptText` BIT(1) NOT NULL,
  PRIMARY KEY (`idNotification`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`offer` ;

CREATE TABLE IF NOT EXISTS `capstream`.`offer` (
  `idOffer` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NOT NULL,
  `offerType` SMALLINT NOT NULL,
  `confirmMethod` TINYINT NOT NULL,
  `price` FLOAT NOT NULL,
  `rateType` SMALLINT NOT NULL,
  `negotiable` TINYINT NOT NULL,
  `maxTimeIncrement` SMALLINT NULL DEFAULT NULL,
  `startTimeIncrement` SMALLINT NULL DEFAULT NULL,
  `bookingLeadNumber` SMALLINT NULL DEFAULT NULL,
  `bookingLeadType` TINYINT NULL DEFAULT NULL,
  `cancelLeadNumber` SMALLINT NULL DEFAULT NULL,
  `cancelLeadType` TINYINT NULL DEFAULT NULL,
  `cancelFee` FLOAT NULL DEFAULT NULL,
  `quantify` BIT(1) NULL DEFAULT NULL,
  `quantity` SMALLINT NOT NULL,
  `minTimeIncrement` SMALLINT NULL DEFAULT NULL,
  `handlePayment` BIT(1) NOT NULL,
  `depositRequired` TINYINT NOT NULL,
  `cancelPolicyOn` BIT(1) NOT NULL,
  `cancelFeeType` TINYINT NULL DEFAULT NULL,
  `depositAmountType` TINYINT NULL DEFAULT NULL,
  `depositAmount` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`idOffer`),
  UNIQUE INDEX `idOffer_UNIQUE` (`idOffer` ASC) VISIBLE,
  INDEX `fkEntityOffer` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityOffer`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
AUTO_INCREMENT = 256
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`order` ;

CREATE TABLE IF NOT EXISTS `capstream`.`order` (
  `idOrder` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUser` BINARY(16) NOT NULL,
  `idAddress` BIGINT UNSIGNED NULL DEFAULT NULL,
  `idCreditCard` BIGINT UNSIGNED NULL DEFAULT NULL,
  `state` TINYINT NOT NULL,
  `inventoryLockTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idOrder`),
  UNIQUE INDEX `idOrder_UNIQUE` (`idOrder` ASC) VISIBLE,
  INDEX `fkUserOrder` (`idUser` ASC) VISIBLE,
  INDEX `fkAddressOrder` (`idAddress` ASC) VISIBLE,
  INDEX `fkCreditCardOrder` (`idCreditCard` ASC) VISIBLE,
  CONSTRAINT `fkAddressOrder`
    FOREIGN KEY (`idAddress`)
    REFERENCES `capstream`.`address` (`idAddress`),
  CONSTRAINT `fkCreditCardOrder`
    FOREIGN KEY (`idCreditCard`)
    REFERENCES `capstream`.`credit-card` (`idCreditCard`),
  CONSTRAINT `fkUserOrder`
    FOREIGN KEY (`idUser`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
AUTO_INCREMENT = 505
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`order-item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`order-item` ;

CREATE TABLE IF NOT EXISTS `capstream`.`order-item` (
  `idOrder` BIGINT UNSIGNED NOT NULL,
  `idEntity` BINARY(16) NOT NULL,
  `quantity` SMALLINT NOT NULL,
  `totalPrice` DOUBLE NOT NULL,
  `idOffer` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idOrder`, `idEntity`),
  INDEX `fkEntityOrderItem` (`idEntity` ASC) VISIBLE,
  INDEX `fkOfferOrderItem` (`idOffer` ASC) VISIBLE,
  CONSTRAINT `fkEntityOrderItem`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),
  CONSTRAINT `fkOfferOrderItem`
    FOREIGN KEY (`idOffer`)
    REFERENCES `capstream`.`offer` (`idOffer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`person` ;

CREATE TABLE IF NOT EXISTS `capstream`.`person` (
  `idEntity` BINARY(16) NOT NULL,
  `personFirstName` VARCHAR(128) NULL DEFAULT NULL,
  `personLastName` VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityPerson`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`place` ;

CREATE TABLE IF NOT EXISTS `capstream`.`place` (
  `idEntity` BINARY(16) NOT NULL,
  `placeType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityPlace`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`post` ;

CREATE TABLE IF NOT EXISTS `capstream`.`post` (
  `idEntity` BINARY(16) NOT NULL,
  `seeking` BIT(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityPost`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`user` ;

CREATE TABLE IF NOT EXISTS `capstream`.`user` (
  `idEntity` BINARY(16) NOT NULL,
  `userName` VARCHAR(64) NOT NULL,
  `userPassword` VARCHAR(60) NOT NULL,
  `userSalt` VARCHAR(29) NOT NULL,
  `userPrimaryEmail` BIGINT UNSIGNED NOT NULL,
  `userTimeZone` TINYINT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  INDEX `fkUserEmail` (`userPrimaryEmail` ASC) VISIBLE,
  CONSTRAINT `fkEntityUser`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),
  CONSTRAINT `fkUserEmail`
    FOREIGN KEY (`userPrimaryEmail`)
    REFERENCES `capstream`.`email` (`idEmail`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`reset-password-session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`reset-password-session` ;

CREATE TABLE IF NOT EXISTS `capstream`.`reset-password-session` (
  `idSession` BINARY(16) NOT NULL,
  `idEntity` BINARY(16) NOT NULL,
  `dtStarted` DATETIME NOT NULL,
  PRIMARY KEY (`idSession`),
  INDEX `fkUserFPS_idx` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkUserFPS`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`user` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`service` ;

CREATE TABLE IF NOT EXISTS `capstream`.`service` (
  `idEntity` BINARY(16) NOT NULL,
  `online` BIT(1) NOT NULL,
  `inPerson` BIT(1) NOT NULL,
  `onDemand` BIT(1) NOT NULL,
  `byAppt` BIT(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkEntityService`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`service-availability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`service-availability` ;

CREATE TABLE IF NOT EXISTS `capstream`.`service-availability` (
  `idEvent` INT UNSIGNED NOT NULL,
  `idService` BINARY(16) NOT NULL,
  UNIQUE INDEX `ServiceAvailability_UNIQUE` (`idEvent` ASC, `idService` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`suggestion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`suggestion` ;

CREATE TABLE IF NOT EXISTS `capstream`.`suggestion` (
  `idSuggestion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NULL DEFAULT NULL,
  `suggestion` TEXT NULL DEFAULT NULL,
  `dtCreated` DATETIME NOT NULL,
  PRIMARY KEY (`idSuggestion`),
  UNIQUE INDEX `idSuggestion_UNIQUE` (`idSuggestion` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `capstream`.`user-session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`user-session` ;

CREATE TABLE IF NOT EXISTS `capstream`.`user-session` (
  `idSession` BINARY(16) NOT NULL,
  `idEntity` BINARY(16) NOT NULL,
  `dtStarted` DATETIME NOT NULL,
  `dtActive` DATETIME NOT NULL,
  `done` BIT(1) NOT NULL,
  PRIMARY KEY (`idSession`, `idEntity`),
  INDEX `fkUserUS` (`idEntity` ASC) VISIBLE,
  CONSTRAINT `fkUserUS`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`user` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `capstream` ;

-- -----------------------------------------------------
-- procedure deleteAddress
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteAddress`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAddress`(IN p_idAddress BIGINT)
BEGIN
	DELETE FROM capstream.address WHERE idAddress = p_idAddress;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAttribute`(IN p_idAttribute INT)
BEGIN
	DELETE FROM capstream.attribute WHERE  idAttribute = p_idAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteAttributeValue
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteAttributeValue`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAttributeValue`(IN p_idAttributeValue INT)
BEGIN
	DELETE FROM `attribute-value` WHERE  idAttributeValue = p_idAttributeValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteBooking
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteBooking`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBooking`(IN p_idBooking INT)
BEGIN
	DELETE FROM capstream.booking WHERE  idBooking = p_idBooking;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCapUpdate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCapUpdate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCapUpdate`(IN p_idEntity CHAR(36))
BEGIN
  DELETE FROM `cap-update`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCart
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCart`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCart`(IN p_idUser CHAR(36))
BEGIN
	DELETE FROM cart WHERE idUser = UUID_TO_BIN(p_idUser);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCartItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCartItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCartItem`(IN p_idUser CHAR(36), IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM cart WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idUser = UUID_TO_BIN(p_idUser);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCategory`(IN p_idCategory INT)
BEGIN
	DELETE FROM capstream.category WHERE  idCategory = p_idCategory;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCommonAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCommonAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCommonAttribute`(IN p_idCommonAttribute INT)
BEGIN
	DELETE FROM `common-attribute` WHERE  idCommonAttribute = p_idCommonAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCreditCard
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCreditCard`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCreditCard`(IN p_idCreditCard bigint(20))
BEGIN
	DELETE FROM `credit-card` WHERE idCreditCard = p_idCreditCard;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEmail
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEmail`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEmail`(IN p_idEmail BIGINT)
BEGIN
	DELETE FROM capstream.email WHERE idEmail = p_idEmail;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntity`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityAttachment
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityAttachment`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityAttachment`(IN p_idAttachment INT)
BEGIN
  DELETE FROM `entity-attachment`
  WHERE idAttachment = p_idAttachment;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityAttribute`(IN p_idEntity CHAR(36), IN p_idAttribute INT)
BEGIN
	DELETE FROM `capstream.entity-attribute` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idAttribute = p_idAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityCategory`(IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	DELETE FROM `entity-category` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idCategory = p_idCategory;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityMedia
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityMedia`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityMedia`(IN p_idMedia BIGINT)
BEGIN
	DELETE FROM `entity-media` WHERE idMedia = p_idMedia;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityMediaAll
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityMediaAll`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityMediaAll`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityRelate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityRelate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityRelate`(IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEntityRelateAll
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEntityRelateAll`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEntityRelateAll`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) OR idRelated = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEvent
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEvent`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEvent`(IN p_idEvent BIGINT)
BEGIN
	DELETE FROM capstream.event WHERE idEvent = p_idEvent;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteEventChainEdit
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteEventChainEdit`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteEventChainEdit`(IN p_idEventChainEdit INT)
BEGIN
	DELETE FROM `event-chain-edit` WHERE  idEventChainEdit = p_idEventChainEdit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteGroup
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteGroup`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteGroup`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.group WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteItem`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.item WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteLocation
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteLocation`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteLocation`(IN p_idLocation BIGINT)
BEGIN
	DELETE FROM capstream.location WHERE idLocation = p_idLocation;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteMasterType
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteMasterType`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMasterType`(IN p_idMasterType INT)
BEGIN
	DELETE FROM `master-type` WHERE  idMasterType = p_idMasterType;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteMessage
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteMessage`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteMessage`(IN p_idMessage INT)
BEGIN
	DELETE FROM capstream.message WHERE  idMessage = p_idMessage;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteNotification
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteNotification`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNotification`(IN p_idNotification INT)
BEGIN
	DELETE FROM capstream.notification WHERE  idNotification = p_idNotification;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteOffer
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteOffer`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOffer`(IN p_idOffer INT)
BEGIN
	DELETE FROM offer WHERE idOffer = p_idOffer;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteOrder
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteOrder`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOrder`(IN p_idOrder BIGINT)
BEGIN
	DELETE FROM capstream.order WHERE idOrder = p_idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteOrderItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteOrderItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOrderItem`(IN p_idOrder bigint(20))
BEGIN
	DELETE FROM `order-item` WHERE idOrder = p_idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deletePerson
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deletePerson`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePerson`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deletePlace
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deletePlace`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePlace`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.place WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deletePost
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deletePost`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePost`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.post WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deletePropertyPosition
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deletePropertyPosition`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePropertyPosition`(IN p_idEntity CHAR(36))
BEGIN
  DELETE FROM `property-position`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteResetPasswordSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteResetPasswordSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteResetPasswordSession`(IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteService
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteService`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteService`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.service WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteServiceAvailability
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteServiceAvailability`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteServiceAvailability`(IN p_idEvent int, IN p_idService CHAR(36))
BEGIN
	DELETE FROM capstream.`service-availability` WHERE  idEvent = p_idEvent AND idService = UUID_TO_BIN(p_idService);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteSuggestion
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteSuggestion`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSuggestion`(IN p_idSuggestion INT)
BEGIN
	DELETE FROM capstream.suggestion WHERE idSuggestion = p_idSuggestion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteUser
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteUser`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUser`(IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM capstream.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteUserSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteUserSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUserSession`(IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertAddress
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertAddress`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAddress`(IN p_name varchar(100), 
    IN p_idLocation bigint(20))
BEGIN
	INSERT INTO capstream.address (name, idLocation) 
    VALUES (p_name, p_idLocation);
	SELECT LAST_INSERT_ID() AS idAddress;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAttribute`(IN p_attrName VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO capstream.attribute (attrName, attrType, idSuggestor) VALUES(p_attrName, p_attrType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertAttributeValue
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertAttributeValue`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAttributeValue`(IN p_idAttribute int(10), IN p_attrValue VARCHAR(1024), IN p_sortOrder smallint, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO `attribute-value` (idAttribute, attrValue, sortOrder, idSuggestor) VALUES(p_idAttribute, p_attrValue, p_sortOrder, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttributeValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertBooking
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertBooking`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBooking`(IN p_idEvent int, IN p_idAvailability int, IN p_idConsumer char(36), IN p_idService char(36), IN p_confirmed TINYINT)
BEGIN
	INSERT INTO capstream.booking (idEvent, idAvailability, idConsumer, idService, confirmed)
  VALUES (p_idEvent, p_idAvailability, UUID_TO_BIN(p_idConsumer), UUID_TO_BIN(p_idService), p_confirmed);
	SELECT LAST_INSERT_ID() as idBooking;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertCapUpdate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertCapUpdate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCapUpdate`(
  IN p_idEntity               CHAR(36),
  IN p_idProperty             CHAR(36),
  IN p_propertyName           VARCHAR(255),
  IN p_updateDate             DATE,
  IN p_revisedSaleDate        DATE,
  IN p_revisedIrrPct          DECIMAL(5,2),
  IN p_revisedEquityMultiple  DECIMAL(6,3),
  IN p_distributionGuidance   VARCHAR(32),
  IN p_notes                  TEXT
)
BEGIN
  INSERT INTO `cap-update` (
    idEntity, idProperty, propertyName, updateDate,
    revisedSaleDate, revisedIrrPct, revisedEquityMultiple,
    distributionGuidance, notes
  ) VALUES (
    UUID_TO_BIN(p_idEntity),
    UUID_TO_BIN(p_idProperty),
    p_propertyName,
    p_updateDate,
    p_revisedSaleDate,
    p_revisedIrrPct,
    p_revisedEquityMultiple,
    p_distributionGuidance,
    p_notes
  );
  -- Return UUID (never return binary)
  SELECT p_idEntity AS idEntity;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertCart
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertCart`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCart`(IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_idOffer INT(10))
BEGIN
	INSERT INTO cart (idUser, idEntity, quantity, idOffer) VALUES(UUID_TO_BIN(p_idUser), UUID_TO_BIN(p_idEntity), p_quantity, p_idOffer);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCategory`(IN p_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_entityType INT, p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO capstream.category (idParent, catDesc, catLevel, entityType, idSuggestor) VALUES(p_idParent, p_catDesc, p_catLevel, p_entityType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idCategory;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertCommonAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertCommonAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCommonAttribute`(IN p_idAttribute INT, IN p_idCategory INT, IN p_sortOrder INT, IN p_required BIT(1))
BEGIN
	INSERT INTO `common-attribute` (idAttribute, idCategory, sortOrder, required) VALUES (p_idAttribute, p_idCategory, p_sortOrder, p_required);
	SELECT LAST_INSERT_ID() as idCommonAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertCreditCard
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertCreditCard`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCreditCard`(IN p_number varchar(16), 
    IN p_expiration date, 
    IN p_ccv varchar(4), 
    IN p_idAddressBilling bigint(20))
BEGIN
	INSERT INTO `credit-card` (number, expiration, ccv, idAddressBilling) 
    VALUES (p_number, p_expiration, p_ccv, p_idAddressBilling);
	SELECT LAST_INSERT_ID() AS idCreditCard;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEmail
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEmail`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmail`(IN p_idEntity CHAR(36), IN p_emailAddress VARCHAR(320), IN p_emailVerifyCode CHAR(6))
BEGIN
	INSERT INTO capstream.email (idEntity, emailAddress, emailVerifyCode) VALUES(UUID_TO_BIN(p_idEntity), p_emailAddress, p_emailVerifyCode);
	SELECT LAST_INSERT_ID() AS idEmail;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntity`(IN p_entityTitle VARCHAR(255), IN p_entityDesc TEXT, IN p_entityType INT)
BEGIN
	SET @idEntity = UUID_TO_BIN(UUID());
	INSERT INTO capstream.entity (idEntity, entityTitle, entityDesc, entityType, dtCreated) VALUES(@idEntity, p_entityTitle, p_entityDesc, p_entityType, Now());
	SELECT BIN_TO_UUID(@idEntity) as idEntity;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEntityAttachment
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEntityAttachment`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityAttachment`(
  IN p_idEntity      CHAR(36),
  IN p_fileName      VARCHAR(255),
  IN p_dtAdded       DATETIME
)
BEGIN
  INSERT INTO `entity-attachment` (
    idEntity, fileName, dtAdded
  ) VALUES (
    UUID_TO_BIN(p_idEntity),
    p_fileName,
    COALESCE(p_dtAdded, NOW())
  );
  -- Return UUID (never return binary)
  SELECT LAST_INSERT_ID() AS idAttachment;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEntityAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEntityAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityAttribute`(IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	INSERT INTO `capstream.entity-attribute` (idEntity, idAttribute, value, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idAttribute, p_value, Now());
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEntityCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEntityCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityCategory`(IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	INSERT INTO `entity-category` (idEntity, idCategory, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idCategory, Now());
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEntityMedia
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEntityMedia`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityMedia`(IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_mediaType INT, IN p_fileName VARCHAR(50), IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT, IN p_scale FLOAT)
BEGIN
	INSERT INTO `entity-media` (idEntity, idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale) 
	VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idUser), p_mediaType, p_fileName, Now(), p_sortOrder, p_xOffset, p_yOffset, p_scale);
	SELECT LAST_INSERT_ID() AS idMedia;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEntityRelate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEntityRelate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEntityRelate`(IN p_idEntity CHAR(36), IN p_idRelated CHAR(36), IN p_relateType INT)
BEGIN
	INSERT INTO `entity-relate` (idEntity, idRelated, relateType) VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idRelated), p_relateType);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEvent
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEvent`;

DELIMITER $$
USE `capstream`$$
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
	INSERT INTO capstream.event (idEntity,
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertEventChainEdit
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertEventChainEdit`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEventChainEdit`(IN p_idEvent int(10), IN p_editType tinyint, IN p_dtStart datetime, IN p_idNewEvent CHAR(36))
BEGIN
	INSERT INTO `event-chain-edit` (idEvent, editType, dtStart, idNewEvent) VALUES(p_idEvent, p_editType, p_dtStart, p_idNewEvent);
	SELECT LAST_INSERT_ID() as idEventChainEdit;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertGroup
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertGroup`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertGroup`(IN p_idEntity CHAR(36), IN p_groupType INT, p_backgroundColor CHAR(7))
BEGIN
	INSERT INTO capstream.group (idEntity, groupType, backgroundColor) VALUES(UUID_TO_BIN(p_idEntity), p_groupType, p_backgroundColor);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertItem`(IN p_idEntity CHAR(36), IN p_condition INT)
BEGIN
	INSERT INTO capstream.item (idEntity, `condition`) VALUES(UUID_TO_BIN(p_idEntity), p_condition);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertLocation
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertLocation`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLocation`(IN p_addressLine1 varchar(255), 
    IN p_addressLine2 varchar(255), 
    IN p_city varchar(255), 
    IN p_idProvince int(10), 
    IN p_idCountry int(10),
    IN p_postalCode varchar(12))
BEGIN
	INSERT INTO capstream.location (addressLine1, addressLine2, city, idProvince, idCountry, postalCode) 
    VALUES (p_addressLine1, p_addressLine2, p_city, p_idProvince, p_idCountry, p_postalCode);
	SELECT LAST_INSERT_ID() AS idLocation;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertMasterType
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertMasterType`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertMasterType`(IN p_table VARCHAR(100), IN p_column VARCHAR(100), IN p_value VARCHAR(255), IN p_code VARCHAR(45))
BEGIN
	INSERT INTO `master-type` (`table`, `column`, `value`, `code`) VALUES (p_table, p_column, p_value, p_code);
	SELECT LAST_INSERTED_ID() as idMasterType;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertMessage
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertMessage`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertMessage`(
  IN p_idThread BIGINT,
  IN p_idSender CHAR(36),
  IN p_idRecipient CHAR(36),
  IN p_dtSent DATETIME,
  IN p_messageText TEXT)
BEGIN
	DECLARE idNew BIGINT;
  INSERT INTO capstream.message (idThread,
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
  IF p_idThread = 0 THEN UPDATE capstream.message SET idThread = idNew WHERE idMessage = idNew;
  END IF;
	SELECT LAST_INSERT_ID() as idMessage;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertNotification
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertNotification`;

DELIMITER $$
USE `capstream`$$
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
	INSERT INTO capstream.notification (idEntity,
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertOffer
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertOffer`;

DELIMITER $$
USE `capstream`$$
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertOrder
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertOrder`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOrder`(IN p_idUser char(36), IN p_state tinyint)
BEGIN
	INSERT INTO capstream.order (idUser, state) 
    VALUES (UUID_TO_BIN(p_idUser), p_state);
	SELECT LAST_INSERT_ID() AS idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertOrderItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertOrderItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOrderItem`(IN p_idOrder bigint(20),
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(10))
BEGIN
	INSERT INTO `order-item` (idOrder, idEntity, quantity, totalPrice, idOffer) 
    VALUES (p_idOrder, UUID_TO_BIN(p_idEntity), p_quantity, p_totalPrice, p_idOffer);
	SELECT LAST_INSERT_ID() AS idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertPerson
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertPerson`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPerson`(IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	INSERT INTO capstream.person (idEntity, personFirstName, personLastName) VALUES(UUID_TO_BIN(p_idEntity), p_personFirstName, p_personLastName);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertPlace
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertPlace`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPlace`(IN p_idEntity CHAR(36), IN p_placeType INT)
BEGIN
	INSERT INTO capstream.place (idEntity, placeType) VALUES(UUID_TO_BIN(p_idEntity), placeType);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertPost
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertPost`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPost`(IN p_idEntity CHAR(36), IN p_seeking BIT(1))
BEGIN
	INSERT INTO capstream.post (idEntity, seeking) VALUES(UUID_TO_BIN(p_idEntity), p_seeking);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertPropertyPosition
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertPropertyPosition`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPropertyPosition`(
  IN p_idEntity             CHAR(36),
  IN p_propertyName         VARCHAR(255),
  IN p_sponsorGP            VARCHAR(255),
  IN p_partnershipLP        VARCHAR(255),
  IN p_acquisitionDate      DATE,
  IN p_propertyNotes        TEXT,
  IN p_lpEntity             VARCHAR(255),
  IN p_investedEquity       DECIMAL(18,2),
  IN p_investmentDate       DATE,
  IN p_ownershipPct         DECIMAL(5,2),
  IN p_prefReturnPct        DECIMAL(5,2),
  IN p_distributionCadence  VARCHAR(32),
  IN p_targetIRR            DECIMAL(5,2),
  IN p_targetEquityMultiple DECIMAL(6,3),
  IN p_projectedSaleDate    DATE
)
BEGIN
  INSERT INTO `property-position` (
    idEntity, propertyName, sponsorGP, partnershipLP, acquisitionDate, propertyNotes,
    lpEntity, investedEquity, investmentDate, ownershipPct, prefReturnPct,
    distributionCadence, targetIRR, targetEquityMultiple, projectedSaleDate
  ) VALUES (
    UUID_TO_BIN(p_idEntity), p_propertyName, p_sponsorGP, p_partnershipLP, p_acquisitionDate, p_propertyNotes,
    p_lpEntity, p_investedEquity, p_investmentDate, p_ownershipPct, p_prefReturnPct,
    p_distributionCadence, p_targetIRR, p_targetEquityMultiple, p_projectedSaleDate
  );
  -- Return the UUID (never return binary)
  SELECT p_idEntity AS idEntity;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertResetPasswordSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertResetPasswordSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertResetPasswordSession`(IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	INSERT INTO `reset-password-session` (idSession, idEntity, dtStarted) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), Now());
	SELECT @idSession as idSession;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertService
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertService`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertService`(IN p_idEntity CHAR(36), IN p_online BIT(1), IN p_inPerson BIT(1), IN p_onDemand BIT(1), IN p_byAppt BIT(1))
BEGIN
	INSERT INTO capstream.service (idEntity, `online`, inPerson, onDemand, byAppt) VALUES(UUID_TO_BIN(p_idEntity), p_online, p_inPerson, p_onDemand, p_byAppt);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertServiceAvailability
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertServiceAvailability`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertServiceAvailability`(IN p_idEvent int, IN p_idService CHAR(36))
BEGIN
	INSERT INTO capstream.`service-availability` (idEvent, idService) VALUES(p_idEvent, UUID_TO_BIN(p_idService));
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertSuggestion
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertSuggestion`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSuggestion`(IN p_idEntity CHAR(36), IN p_suggestion TEXT)
BEGIN
	INSERT INTO capstream.suggestion (idEntity, suggestion, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_suggestion, Now());
	SELECT LAST_INSERT_ID() as idSuggestion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertUser
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertUser`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUser`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT, IN p_userTimeZone TINYINT)
BEGIN
	INSERT INTO capstream.user (idEntity, userName, userPassword, userSalt, userPrimaryEmail, userTimeZone) VALUES(UUID_TO_BIN(p_idEntity), p_userName, p_userPassword, p_userSalt, p_userPrimaryEmail, p_userTimeZone);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertUserSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertUserSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertUserSession`(IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	SET @Now = Now();
	INSERT INTO `user-session` (idSession, idEntity, dtStarted, dtActive, done) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), @Now, @Now, 0);
	SELECT @idSession as idSession;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectAddress
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectAddress`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAddress`(IN p_idAddress bigint(20))
BEGIN
	SELECT idAddress, name, idLocation 
    FROM capstream.address
    WHERE idAddress = p_idAddress;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAttribute`(IN p_idAttribute INT)
BEGIN
	SELECT idAttribute, attrName, attrType, BIN_TO_UUID(idSuggestor) as idSuggestor FROM capstream.attribute where idAttribute = p_idAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectAttributeValue
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectAttributeValue`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAttributeValue`(IN p_idAttributeValue INT)
BEGIN
	SELECT idAttributeValue, attrValue, BIN_TO_UUID(idSuggestor) as idSuggestor FROM `attribute-value` where idAttributeValue = p_idAttributeValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectBooking
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectBooking`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectBooking`(IN p_idBooking INT)
BEGIN
	SELECT idBooking, idEvent, idAvailable, BIN_TO_UUID(idConsumer) as idConsumer, BIN_TO_UUID(idService) as idService, confirmed
  FROM capstream.booking where idBooking = p_idBooking AND confirmed <> 2;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCapUpdate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCapUpdate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCapUpdate`(IN p_idEntity CHAR(36))
BEGIN
  SELECT
    BIN_TO_UUID(idEntity)              AS idEntity,
    BIN_TO_UUID(idProperty)            AS idProperty,
    propertyName,
    updateDate,
    revisedSaleDate,
    revisedIrrPct,
    revisedEquityMultiple,
    distributionGuidance,
    notes
  FROM `cap-update`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCapUpdatesByDateRange
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCapUpdatesByDateRange`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCapUpdatesByDateRange`(
  IN p_idProperty CHAR(36),
  IN p_startDate  DATE,
  IN p_endDate    DATE
)
BEGIN
  SELECT
    BIN_TO_UUID(idEntity)     AS idEntity,
    BIN_TO_UUID(idProperty)   AS idProperty,
    propertyName,
    updateDate,
    revisedSaleDate,
    revisedIrrPct,
    revisedEquityMultiple,
    distributionGuidance,
    notes,
    attachmentName,
    attachmentSize
  FROM `cap-update`
  WHERE idProperty = UUID_TO_BIN(p_idProperty)
    AND updateDate >= p_startDate
    AND updateDate <= p_endDate
  ORDER BY updateDate DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCapUpdatesByProperty
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCapUpdatesByProperty`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCapUpdatesByProperty`(IN p_idProperty CHAR(36))
BEGIN
  SELECT
    BIN_TO_UUID(idEntity)              AS idEntity,
    BIN_TO_UUID(idProperty)            AS idProperty,
    propertyName,
    updateDate,
    revisedSaleDate,
    revisedIrrPct,
    revisedEquityMultiple,
    distributionGuidance,
    notes,
    attachmentName,
    attachmentSize
  FROM `cap-update`
  WHERE idProperty = UUID_TO_BIN(p_idProperty)
  ORDER BY updateDate DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCart
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCart`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCart`(IN p_idUser CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, BIN_TO_UUID(idUser) AS idUser, quantity, idOffer
    	FROM cart as c
    	WHERE c.idUser = UUID_TO_BIN(p_idUser);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCategory`(IN p_idCategory INT)
BEGIN
	SELECT idCategory, idParent, catDesc, catLevel, entityType, BIN_TO_UUID(idSuggestor) as idSuggestor
	FROM capstream.category where idCategory = p_idCategory;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCategoryByType
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCategoryByType`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCategoryByType`(IN p_entityType INT)
BEGIN
	SELECT idCategory, idParent, catDesc, catLevel, entityType, BIN_TO_UUID(idSuggestor) as idSuggestor
	FROM capstream.category where entityType = p_entityType ORDER BY catLevel ASC, catDesc ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCommonAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCommonAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCommonAttribute`(IN p_idCommonAttribute INT)
BEGIN
	SELECT idCommonAttribute, idAttribute, idCategory, sortOrder, required
    FROM `common-attribute` where idCommonAttribute = p_idCommonAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCommonAttributeByCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCommonAttributeByCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCommonAttributeByCategory`(IN p_idCategory INT)
BEGIN
	SELECT idCommonAttribute, idAttribute, idCategory, sortOrder, required
    FROM `common-attribute` where idCategory = p_idCategory;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCountryActive
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCountryActive`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCountryActive`()
BEGIN
	SELECT * FROM capstream.country WHERE active = 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCreditCard
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCreditCard`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCreditCard`(IN p_idCreditCard bigint(20))
BEGIN
	SELECT idCreditCard, number, expiration, ccv, idAddressBilling
    FROM `credit-card`
    WHERE idCreditCard = p_idCreditCard;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEmail
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEmail`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEmail`(IN p_idEmail BIGINT)
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM capstream.email WHERE idEmail = p_idEmail;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEmailByEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEmailByEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEmailByEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM capstream.email WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, entityDesc, entityType, idMedia, dtCreated, dtLastEdited  FROM capstream.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityAttachment
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityAttachment`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityAttachment`(IN p_idAttachment CHAR(36))
BEGIN
  SELECT
    idAttachment,
    BIN_TO_UUID(idEntity)     AS idEntity,
    fileName,
    dtAdded
  FROM `entity-attachment`
  WHERE idAttachment = p_idAttachment;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityAttachmentsByEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityAttachmentsByEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityAttachmentsByEntity`(IN p_idEntity CHAR(36))
BEGIN
  SELECT
    idAttachment,
    BIN_TO_UUID(idEntity)     AS idEntity,
    fileName,
    dtAdded
  FROM `entity-attachment`
  WHERE idEntity = UUID_TO_BIN(p_idEntity)
  ORDER BY dtAdded ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityAttribute`(IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM `capstream.entity-attribute` where idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityByEntityType
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityByEntityType`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityByEntityType`(IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, entityDesc, entityType, idMedia, dtCreated, dtLastEdited FROM capstream.entity WHERE entityType = p_entityType;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityByOwner
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityByOwner`;

DELIMITER $$
USE `capstream`$$
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityBySearch
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityBySearch`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityBySearch`(IN p_searchValue CHAR(255))
BEGIN
  SELECT * FROM 
	  (SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset 
		FROM capstream.entity AS e, `entity-media` as em
		WHERE e.idMedia = em.idMedia
	  UNION ALL 
	  SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL, NULL, 0, 0
		FROM capstream.entity AS e
		WHERE e.idMedia is NULL) `combined-alias`
	 ORDER BY dtCreated DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityCategory`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity), idCategory, dtCreated FROM `entity-category` where idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityMedia
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityMedia`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityMedia`(IN p_idMedia BIGINT)
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale 
	FROM `entity-media` WHERE idMedia = p_idMedia;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityMediaByEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityMediaByEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityMediaByEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder, xOffset, yOffset, scale
	FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity) ORDER BY sortOrder ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityRelate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityRelate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityRelate`(IN p_idEntity CHAR(36), IN p_relateType INT)
BEGIN
	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset, em.scale 
		FROM capstream.entity AS e, `entity-media` as em, `entity-relate` as er
		WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia = em.idMedia)
	UNION ALL 
  	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL as fileName, NULL as mediaType, 0 as xOffset, 0 as yOffset, 0 as scale
    	FROM capstream.entity AS e, `entity-relate` as er
    	WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia is NULL);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEntityRelateByRelated
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEntityRelateByRelated`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEntityRelateByRelated`(IN p_idRelated CHAR(36))
BEGIN
	SELECT * FROM `entity-relate` WHERE idRelated = UUID_TO_BIN(p_idRelated);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEvent
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEvent`;

DELIMITER $$
USE `capstream`$$
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
    FROM capstream.event
    WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectEventChainEdit
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectEventChainEdit`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectEventChainEdit`(IN p_idEvent INT)
BEGIN
	SELECT idEventChainEdit, idEvent, editType, dtStart, idNewEvent FROM `event-chain-edit` where idEvent = p_idEvent;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectGroup
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectGroup`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroup`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, groupType, backgroundColor FROM capstream.group where idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectGroupsAll
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectGroupsAll`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupsAll`()
BEGIN
	SELECT BIN_TO_UUID(g.idEntity) as idEntity, e.entityTitle, g.groupType, g.backgroundColor FROM capstream.group as g, capstream.entity as e
    where e.entityType = 3
    AND e.idEntity = g.idEntity
    ORDER BY e.entityTitle;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectItem`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, `condition` FROM capstream.item WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectLocation
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectLocation`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectLocation`(IN p_idLocation bigint(20))
BEGIN
	SELECT idLocation, addressLine1, addressLine2, city, idProvince, idCountry, postalCode 
    FROM capstream.location
    WHERE idLocation = p_idLocation;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectMasterType
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectMasterType`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectMasterType`(IN p_idMasterType INT)
BEGIN
	SELECT * FROM `master-type` WHERE idMasterType = p_idMasterType;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectMasterTypeByValue
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectMasterTypeByValue`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectMasterTypeByValue`(IN p_value VARCHAR(255))
BEGIN
	SELECT * FROM `master-type` WHERE `value` = p_value;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectMessage
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectMessage`;

DELIMITER $$
USE `capstream`$$
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
  FROM capstream.message, capstream.entity e1, capstream.entity e2
  WHERE (idSender = UUID_TO_BIN(p_idEntity) OR idRecipient = UUID_TO_BIN(p_idEntity)) 
    AND idSender = e1.idEntity AND idRecipient = e2.idEntity
  )
  SELECT * FROM ranked_messages WHERE rn = 1 ORDER BY dtSent DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectNotification
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectNotification`;

DELIMITER $$
USE `capstream`$$
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
  FROM capstream.notification where idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectOffer
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectOffer`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOffer`(IN p_idOffer bigint(20))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, cancelPolicyOn, cancelFeeType, depositAmountType, depositAmount
  FROM offer
  WHERE idOffer = p_idOffer;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectOfferForEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectOfferForEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOfferForEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity,offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, cancelPolicyOn, cancelFeeType, depositAmountType, depositAmount
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectOrder
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectOrder`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOrder`(IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idUser) as idUser, idAddress, idCreditCard, state, inventoryLockTime
    FROM capstream.order
    WHERE idOrder = p_idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectOrderItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectOrderItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectOrderItem`(IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idEntity), quantity, totalPrice, idOffer
    FROM `order-item`
    WHERE idOrder = p_idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPerson
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPerson`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPerson`(IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM capstream.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPlace
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPlace`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPlace`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, placeType FROM capstream.place where idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPost
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPost`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPost`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, seeking FROM capstream.post WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPropertyPosition
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPropertyPosition`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPropertyPosition`(IN p_idEntity CHAR(36))
BEGIN
  SELECT
    BIN_TO_UUID(idEntity)      AS idEntity,
    propertyName, sponsorGP, partnershipLP, acquisitionDate, propertyNotes,
    lpEntity, investedEquity, investmentDate, ownershipPct, prefReturnPct,
    distributionCadence, targetIRR, targetEquityMultiple, projectedSaleDate
  FROM `property-position`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPropertyPositionByClient
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPropertyPositionByClient`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPropertyPositionByClient`(IN p_idEntity CHAR(36))
BEGIN
  SELECT
    BIN_TO_UUID(p.idEntity)      AS idEntity,
    propertyName, sponsorGP, partnershipLP, acquisitionDate, propertyNotes,
    lpEntity, investedEquity, investmentDate, ownershipPct, prefReturnPct,
    distributionCadence, targetIRR, targetEquityMultiple, projectedSaleDate
  FROM `property-position` AS p, `entity-relate` AS er
  WHERE er.idEntity = UUID_TO_BIN(p_idEntity)
  AND er.idRelated = p.idEntity
  AND er.relateType = 2;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPropertyPositionByLpEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPropertyPositionByLpEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPropertyPositionByLpEntity`(IN p_lpEntity VARCHAR(255))
BEGIN
  SELECT
    BIN_TO_UUID(idEntity)      AS idEntity,
    propertyName, sponsorGP, partnershipLP, acquisitionDate, propertyNotes,
    lpEntity, investedEquity, investmentDate, ownershipPct, prefReturnPct,
    distributionCadence, targetIRR, targetEquityMultiple, projectedSaleDate
  FROM `property-position`
  WHERE lpEntity = p_lpEntity;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectPropertyPositionByPropertyName
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectPropertyPositionByPropertyName`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectPropertyPositionByPropertyName`(IN p_propertyName VARCHAR(255))
BEGIN
  SELECT
    BIN_TO_UUID(idEntity)      AS idEntity,
    propertyName, sponsorGP, partnershipLP, acquisitionDate, propertyNotes,
    lpEntity, investedEquity, investmentDate, ownershipPct, prefReturnPct,
    distributionCadence, targetIRR, targetEquityMultiple, projectedSaleDate
  FROM `property-position`
  WHERE propertyName = p_propertyName;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectProviderUnconfirmedCount
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectProviderUnconfirmedCount`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectProviderUnconfirmedCount`(IN p_idEntity CHAR(36))
BEGIN
    SELECT COUNT(e.idEvent) as unconfirmedBookings
    FROM capstream.event AS e, capstream.booking AS b
    WHERE e.idEntity = UUID_TO_BIN(p_idEntity) AND eventType = 3 AND e.idEvent = b.idEvent AND confirmed = 0;    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectProvinceByCountry
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectProvinceByCountry`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectProvinceByCountry`(IN p_idCountry INT)
BEGIN
	SELECT * FROM capstream.province WHERE idCountry = p_idCountry AND active = 1;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectResetPasswordSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectResetPasswordSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectResetPasswordSession`(IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idSession) AS idSession, BIN_TO_UUID(idEntity) AS idEntity, dtStarted 
	FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectService
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectService`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectService`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, `online`, inPerson, onDemand, byAppt FROM capstream.service WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectServiceAvailability
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectServiceAvailability`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectServiceAvailability`(IN p_idEvent INT)
BEGIN
	SELECT idEvent, BIN_TO_UUID(idService) as idService 
  FROM capstream.`service-availability` where idEvent = p_idEvent;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectSuggestion
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectSuggestion`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectSuggestion`(IN p_idSuggestion INT)
BEGIN
	SELECT * FROM capstream.suggestion WHERE idSuggestion = p_idSuggestion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectSuggestionByEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectSuggestionByEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectSuggestionByEntity`(IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM capstream.suggestion WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectThread
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectThread`;

DELIMITER $$
USE `capstream`$$
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
  FROM capstream.message, capstream.entity e1, capstream.entity e2
  WHERE idThread = p_idThread
    AND idSender = e1.idEntity AND idRecipient = e2.idEntity
  ORDER BY dtSent DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectUser
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectUser`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUser`(IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, userName, userPassword, userSalt, userPrimaryEmail, userTimeZone FROM capstream.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectUserByEmail
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectUserByEmail`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserByEmail`(IN p_emailAddress VARCHAR(320))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.emailAddress, u.userTimeZone
	FROM capstream.user AS u, capstream.email AS e WHERE u.idEntity = e.idEntity AND e.emailAddress = p_emailAddress;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectUserByUserName
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectUserByUserName`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserByUserName`(IN p_userName CHAR(64))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.entityTitle, u.userTimeZone, p.personFirstName, p.personLastName
    FROM capstream.user AS u, capstream.entity AS e, capstream.person AS p
    WHERE userName = p_userName AND e.idEntity = u.idEntity AND p.idEntity = u.idEntity;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectUserEvents
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectUserEvents`;

DELIMITER $$
USE `capstream`$$
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
    FROM capstream.event
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
    FROM capstream.event AS e, capstream.booking AS b, entity AS en
    WHERE e.idEntity = UUID_TO_BIN(p_idEntity) AND eventType = 3 AND e.idEvent = b.idEvent AND en.idEntity = b.idConsumer AND confirmed <> 2)
    ORDER BY eventType ASC, dtStart ASC, dtEnd ASC, idService ASC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectUserSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectUserSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserSession`(IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID( idSession) as idSession, BIN_TO_UUID( idEntity ) as idEntity, dtStarted, dtActive, done
	FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateAddress
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateAddress`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAddress`(IN p_idAddress bigint(20), 
    IN p_name varchar(100), 
    IN p_idLocation  bigint(20))
BEGIN
	UPDATE capstream.address 
    SET name = p_name, idLocation = p_idLocation 
    WHERE idAddress = p_idAddress;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAttribute`(IN p_idAttribute INT, IN p_attrName VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE capstream.attribute SET attrName = p_attrName, attrType = p_attrType, idSuggestor = UUID_TO_BIN(p_idSuggestor) 
	WHERE  idAttribute = p_idAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateAttributeValue
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateAttributeValue`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAttributeValue`(IN p_idAttribute INT, IN p_attrValue VARCHAR(1024), IN p_sortOrder smallint, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `attribute-value` SET idAttribute = p_idAttribute, attrValue = p_attrValue, sortOrder = p_sortOrder, idSuggestor = UUID_TO_BIN(p_idSuggestor)
	WHERE  idAttributeValue = p_idAttributeValue;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateBooking
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateBooking`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBooking`(IN p_idBooking INT, IN p_idEvent int, IN p_idAvailability int, IN p_idConsumer char(36), IN p_idService char(36), IN p_confirmed TINYINT)
BEGIN
	UPDATE capstream.booking SET idEvent = p_idEvent, idAvailability = p_idAvailability, idConsumer = UUID_TO_BIN(p_idConsumer), idService = UUID_TO_BIN(p_idService), confirmed = p_confirmed
	WHERE  idBooking = p_idBooking;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCapUpdate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateCapUpdate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCapUpdate`(
  IN p_idEntity               CHAR(36),
  IN p_idProperty             CHAR(36),
  IN p_propertyName           VARCHAR(255),
  IN p_updateDate             DATE,
  IN p_revisedSaleDate        DATE,
  IN p_revisedIrrPct          DECIMAL(5,2),
  IN p_revisedEquityMultiple  DECIMAL(6,3),
  IN p_distributionGuidance   VARCHAR(32),
  IN p_notes                  TEXT
)
BEGIN
  UPDATE `cap-update`
  SET
    idProperty             = UUID_TO_BIN(p_idProperty),
    propertyName           = p_propertyName,
    updateDate             = p_updateDate,
    revisedSaleDate        = p_revisedSaleDate,
    revisedIrrPct          = p_revisedIrrPct,
    revisedEquityMultiple  = p_revisedEquityMultiple,
    distributionGuidance   = p_distributionGuidance,
    notes                  = p_notes
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCartItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateCartItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCartItem`(IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_idOffer INT(10))
BEGIN
	UPDATE cart SET quantity=p_quantity, idOffer=p_idOffer WHERE idUser = UUID_TO_BIN(p_idUser) AND idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCategory
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateCategory`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCategory`(IN p_idCategory INT, IN p_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_entityType INT, p_idSuggestor CHAR(36))
BEGIN
	UPDATE capstream.category SET idParent = p_idParent, catDesc = p_catDesc, catLevel = p_catLevel, entityType = p_entityType, idSuggestor = p_idSuggestor
	WHERE  idCategory = p_idCategory;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCommonAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateCommonAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCommonAttribute`(IN p_idCommonAttribute INT, IN p_idAttribute INT, IN p_idCategory INT, IN p_sortOrder INT, IN p_required BIT(1))
BEGIN
	UPDATE `common-attribute` SET idAttribute = p_idAttribute, idCategory = p_idCategory, sortOrder = p_sortOrder, required = p_required
	WHERE  idCommonAttribute = p_idCommonAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCreditCard
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateCreditCard`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCreditCard`(IN p_idCreditCard bigint(20), 
    IN p_number varchar(16), 
    IN p_expiration date, 
    IN p_ccv varchar(4), 
    IN p_idAddressBilling bigint(20))
BEGIN
	UPDATE `credit-card` 
    SET number = p_number, expiration = p_expiration, ccv = p_ccv, idAddressBilling = p_idAddressBilling
    WHERE idCreditCard = p_idCreditCard;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEmail
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEmail`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmail`(IN p_idEmail BIGINT, IN p_emailAddress VARCHAR(320), IN p_emailVerified TINYINT(1), IN p_emailVerifyCode CHAR(6))
BEGIN
	UPDATE capstream.email SET emailAddress = p_emailAddress, emailVerified = p_emailVerified, emailVerifyCode = p_emailVerifyCode WHERE idEmail = p_idEmail;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEntity
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEntity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntity`(IN p_idEntity CHAR(36), IN p_entityTitle VARCHAR(255), IN p_entityDesc TEXT)
BEGIN
	UPDATE capstream.entity 
  SET entityTitle = p_entityTitle, entityDesc = p_entityDesc, dtLastEdited = Now() 
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEntityAttachment
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEntityAttachment`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityAttachment`(
  IN p_idAttachment  INT,
  IN p_idEntity      CHAR(36),
  IN p_fileName      VARCHAR(255),
  IN p_dtAdded       DATETIME
)
BEGIN
  UPDATE `entity-attachment`
  SET
    idEntity  = UUID_TO_BIN(p_idEntity),
    fileName  = p_fileName,
    dtAdded   = COALESCE(p_dtAdded, dtAdded)
  WHERE idAttachment = p_idAttachment;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEntityAttribute
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEntityAttribute`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityAttribute`(IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	UPDATE `capstream.entity-attribute` SET value = p_value, dtLastEdited = Now() 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idAttribute = p_idAttribute;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEntityMedia
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEntityMedia`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityMedia`(IN p_idMedia BIGINT, IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT, IN p_scale FLOAT)
BEGIN
	UPDATE `entity-media` SET sortOrder = p_sortOrder, xOffset = p_xOffset, yOffset = p_yOffset, scale = p_scale WHERE idMedia = p_idMedia;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEntityPrimaryMedia
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEntityPrimaryMedia`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEntityPrimaryMedia`(IN p_idEntity CHAR(36), IN p_idMedia BIGINT)
BEGIN
  UPDATE capstream.entity
  SET idMedia = p_idMedia
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateEvent
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateEvent`;

DELIMITER $$
USE `capstream`$$
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
	UPDATE capstream.event 
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateGroup
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateGroup`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateGroup`(IN p_idEntity CHAR(36), IN p_groupType INT, p_backgroundColor CHAR(7))
BEGIN
	UPDATE capstream.group SET groupType = p_groupType, backgroundColor=p_backgroundColor WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateItem`(IN p_idEntity CHAR(36), IN p_condition INT)
BEGIN
	UPDATE capstream.item SET `condition`=p_condition WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateLocation
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateLocation`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateLocation`(IN p_idLocation bigint(20), 
    IN p_addressLine1 varchar(255), 
    IN p_addressLine2 varchar(255), 
    IN p_city varchar(255), 
    IN p_idProvince int(10), 
    IN p_idCountry int(10),
    IN p_postalCode varchar(12))
BEGIN
	UPDATE capstream.location 
    SET addressLine1 = p_addressLine1, addressLine2 = p_addressLine2, city = p_city, 
        idProvince = p_idProvince, idCountry = p_idCountry, postalCode = p_postalCode 
    WHERE idLocation = p_idLocation;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateMasterType
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateMasterType`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMasterType`(IN p_idMasterType INT, IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `master-type` SET `table` = p_table, `column` = p_column, `value` = p_value, `code` = p_code
	WHERE  idMasterType = p_idMasterType;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateMessage
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateMessage`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMessage`(IN p_idMessage INT,
  IN p_dtViewed DATETIME)
BEGIN
	UPDATE capstream.message 
  SET dtViewed = p_dtViewed
	WHERE idMessage = p_idMessage;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateNotification
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateNotification`;

DELIMITER $$
USE `capstream`$$
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
	UPDATE capstream.notification 
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateOffer
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateOffer`;

DELIMITER $$
USE `capstream`$$
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateOrder
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateOrder`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrder`(IN p_idOrder bigint(20), 
    IN p_idUser char(36), 
    IN p_idAddress bigint(20), 
    IN p_idCreditCard bigint(20), 
    IN p_state tinyint, 
    IN p_inventoryLockTime datetime)
BEGIN
	UPDATE capstream.order 
    SET idUser = UUID_TO_BIN(p_idUser), idAddress = p_idAddress, idCreditCard = p_idCreditCard, 
        state = p_state, inventoryLockTime = p_inventoryLockTime 
    WHERE idOrder = p_idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateOrderItem
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateOrderItem`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOrderItem`(IN p_idOrder bigint(20), 
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(20))
BEGIN
	UPDATE `order-item` 
    SET idEntity = UUID_TO_BIN(p_idEntity), quantity = p_quantity, totalPrice = p_totalPrice, idOffer = p_idOffer
    WHERE idOrder = p_idOrder;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updatePerson
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updatePerson`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePerson`(IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	UPDATE capstream.person SET personFirstName = p_personFirstName, personLastName = p_personLastName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updatePlace
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updatePlace`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePlace`(IN p_idEntity CHAR(36), IN p_placeType INT)
BEGIN
	UPDATE capstream.place SET placeType = p_placeType WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updatePost
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updatePost`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePost`(IN p_idEntity CHAR(36), IN p_seeking BIT(1))
BEGIN
	UPDATE capstream.post SET seeking=p_seeking WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updatePropertyPosition
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updatePropertyPosition`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePropertyPosition`(
  IN p_idEntity             CHAR(36),
  IN p_propertyName         VARCHAR(255),
  IN p_sponsorGP            VARCHAR(255),
  IN p_partnershipLP        VARCHAR(255),
  IN p_acquisitionDate      DATE,
  IN p_propertyNotes        TEXT,
  IN p_lpEntity             VARCHAR(255),
  IN p_investedEquity       DECIMAL(18,2),
  IN p_investmentDate       DATE,
  IN p_ownershipPct         DECIMAL(5,2),
  IN p_prefReturnPct        DECIMAL(5,2),
  IN p_distributionCadence  VARCHAR(32),
  IN p_targetIRR            DECIMAL(5,2),
  IN p_targetEquityMultiple DECIMAL(6,3),
  IN p_projectedSaleDate    DATE
)
BEGIN
  UPDATE `property-position`
  SET
    propertyName         = p_propertyName,
    sponsorGP            = p_sponsorGP,
    partnershipLP        = p_partnershipLP,
    acquisitionDate      = p_acquisitionDate,
    propertyNotes        = p_propertyNotes,
    lpEntity             = p_lpEntity,
    investedEquity       = p_investedEquity,
    investmentDate       = p_investmentDate,
    ownershipPct         = p_ownershipPct,
    prefReturnPct        = p_prefReturnPct,
    distributionCadence  = p_distributionCadence,
    targetIRR            = p_targetIRR,
    targetEquityMultiple = p_targetEquityMultiple,
    projectedSaleDate    = p_projectedSaleDate
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateService
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateService`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateService`(IN p_idEntity CHAR(36), IN p_online BIT(1), IN p_inPerson BIT(1), IN p_onDemand BIT(1), IN p_byAppt BIT(1))
BEGIN
	UPDATE capstream.service SET `online`=p_online, inPerson=p_inPerson, onDemand=p_onDemand, byAppt=p_byAppt WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateUser
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateUser`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT, IN p_userTimeZone TINYINT)
BEGIN
	UPDATE capstream.user SET userName = p_userName, userPassword = p_userPassword, userSalt = p_userSalt, userPrimaryEmail = p_userPrimaryEmail, userTimeZone = p_userTimeZone WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateUserName
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateUserName`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserName`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64))
BEGIN
	UPDATE capstream.user SET userName = p_userName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateUserPrimaryEmail
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateUserPrimaryEmail`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserPrimaryEmail`(IN p_idEntity CHAR(36), IN p_userPrimaryEmail BIGINT)
BEGIN
	UPDATE capstream.user SET userPrimaryEmail = p_userPrimaryEmail WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateUserProfile
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateUserProfile`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserProfile`(IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userTimeZone TINYINT)
BEGIN
	UPDATE capstream.user SET userName = p_userName, userTimeZone = p_userTimeZone WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateUserSession
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateUserSession`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUserSession`(IN p_idSession CHAR(36), IN p_idEntity CHAR(36), IN p_done BIT(1))
BEGIN
	UPDATE `user-session` SET dtActive = Now(), done = p_done WHERE idSession = UUID_TO_BIN(p_idSession) AND idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure verifyEntityRelate
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`verifyEntityRelate`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verifyEntityRelate`(IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, relateType, BIN_TO_UUID(idRelated) as idRelated 
	FROM `entity-relate` 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
