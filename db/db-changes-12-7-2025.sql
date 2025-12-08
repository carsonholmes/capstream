-- db-changes-12-7-2025.sql
-- New table and stored procedures for cash-activity tracking

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

USE `capstream`;

-- -----------------------------------------------------
-- Table `capstream`.`cash-activity`
-- Tracks cash flows (contributions, distributions, expenses, income) for properties
-- Similar structure to cap-update: linked to property via idProperty
-- Each record represents one cash event
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`cash-activity`;

CREATE TABLE IF NOT EXISTS `capstream`.`cash-activity` (
  `idEntity` BINARY(16) NOT NULL,
  `idProperty` BINARY(16) NOT NULL,
  `propertyName` VARCHAR(255) NULL DEFAULT NULL,
  `activityDate` DATE NOT NULL,
  `activityType` VARCHAR(32) NOT NULL,
  `amount` DECIMAL(18,2) NOT NULL,
  `method` VARCHAR(64) NULL DEFAULT NULL,
  `periodStart` DATE NULL DEFAULT NULL,
  `periodEnd` DATE NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idEntity`),
  INDEX `idx_cash_activity_property` (`idProperty` ASC) VISIBLE,
  INDEX `idx_cash_activity_activityDate` (`activityDate` ASC) VISIBLE,
  INDEX `idx_cash_activity_periodStart` (`periodStart` ASC) VISIBLE,
  INDEX `idx_cash_activity_activityType` (`activityType` ASC) VISIBLE,
  CONSTRAINT `fk_cash_activity_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),
  CONSTRAINT `fk_cash_activity_property`
    FOREIGN KEY (`idProperty`)
    REFERENCES `capstream`.`property-position` (`idEntity`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- procedure insertCashActivity
-- Insert a new cash activity record
-- Inserts into cash-activity table with all provided fields
-- Returns the idEntity (as UUID string)
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`insertCashActivity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCashActivity`(
  IN p_idEntity               CHAR(36),
  IN p_idProperty             CHAR(36),
  IN p_propertyName           VARCHAR(255),
  IN p_activityDate           DATE,
  IN p_activityType           VARCHAR(32),
  IN p_amount                 DECIMAL(18,2),
  IN p_method                 VARCHAR(64),
  IN p_periodStart            DATE,
  IN p_periodEnd              DATE,
  IN p_notes                  TEXT
)
BEGIN
  INSERT INTO `cash-activity` (
    idEntity, idProperty, propertyName, activityDate,
    activityType, amount, method, periodStart, periodEnd, notes
  ) VALUES (
    UUID_TO_BIN(p_idEntity),
    UUID_TO_BIN(p_idProperty),
    p_propertyName,
    p_activityDate,
    p_activityType,
    p_amount,
    p_method,
    p_periodStart,
    p_periodEnd,
    p_notes
  );
  -- Return UUID (never return binary)
  SELECT p_idEntity AS idEntity;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCashActivity
-- Select one cash activity by idEntity
-- Returns: single row with all fields
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCashActivity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCashActivity`(
  IN p_idEntity CHAR(36)
)
BEGIN
  SELECT
    BIN_TO_UUID(idEntity) AS idEntity,
    BIN_TO_UUID(idProperty) AS idProperty,
    propertyName,
    activityDate,
    activityType,
    amount,
    method,
    periodStart,
    periodEnd,
    notes
  FROM `cash-activity`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCashActivitiesByProperty
-- Get all cash activities for a property, newest first
-- Returns: array of rows sorted by activityDate DESC
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCashActivitiesByProperty`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCashActivitiesByProperty`(
  IN p_idProperty CHAR(36)
)
BEGIN
  SELECT
    BIN_TO_UUID(idEntity) AS idEntity,
    BIN_TO_UUID(idProperty) AS idProperty,
    propertyName,
    activityDate,
    activityType,
    amount,
    method,
    periodStart,
    periodEnd,
    notes
  FROM `cash-activity`
  WHERE idProperty = UUID_TO_BIN(p_idProperty)
  ORDER BY activityDate DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCashActivitiesByDateRange
-- Get cash activities for a property within a date range
-- Returns: array of rows sorted by activityDate DESC
-- Parameters:
--   p_idProperty: the property to filter by
--   p_startDate: start of date range (inclusive)
--   p_endDate: end of date range (inclusive)
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`selectCashActivitiesByDateRange`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCashActivitiesByDateRange`(
  IN p_idProperty CHAR(36),
  IN p_startDate DATE,
  IN p_endDate DATE
)
BEGIN
  SELECT
    BIN_TO_UUID(idEntity) AS idEntity,
    BIN_TO_UUID(idProperty) AS idProperty,
    propertyName,
    activityDate,
    activityType,
    amount,
    method,
    periodStart,
    periodEnd,
    notes
  FROM `cash-activity`
  WHERE idProperty = UUID_TO_BIN(p_idProperty)
    AND activityDate >= p_startDate
    AND activityDate <= p_endDate
  ORDER BY activityDate DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateCashActivity
-- Update an existing cash activity record
-- Updates all provided fields for the activity with given idEntity
-- Parameters match insertCashActivity (all fields)
-- Returns: empty result set (procedurally updates in place)
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`updateCashActivity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCashActivity`(
  IN p_idEntity               CHAR(36),
  IN p_idProperty             CHAR(36),
  IN p_propertyName           VARCHAR(255),
  IN p_activityDate           DATE,
  IN p_activityType           VARCHAR(32),
  IN p_amount                 DECIMAL(18,2),
  IN p_method                 VARCHAR(64),
  IN p_periodStart            DATE,
  IN p_periodEnd              DATE,
  IN p_notes                  TEXT
)
BEGIN
  UPDATE `cash-activity`
  SET
    idProperty = UUID_TO_BIN(p_idProperty),
    propertyName = p_propertyName,
    activityDate = p_activityDate,
    activityType = p_activityType,
    amount = p_amount,
    method = p_method,
    periodStart = p_periodStart,
    periodEnd = p_periodEnd,
    notes = p_notes
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deleteCashActivity
-- Delete a cash activity record by idEntity
-- Removes the record from cash-activity table
-- Parameters:
--   p_idEntity: the cash activity to delete
-- Returns: empty result set
-- Note: The associated entity should be deleted separately in a transaction
--       (matching the pattern in bplCashActivity.js)
-- -----------------------------------------------------

USE `capstream`;
DROP procedure IF EXISTS `capstream`.`deleteCashActivity`;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCashActivity`(
  IN p_idEntity CHAR(36)
)
BEGIN
  DELETE FROM `cash-activity`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$

DELIMITER ;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET SQL_MODE=@OLD_SQL_MODE;

-- -----------------------------------------------------
-- Fix: selectCapUpdates stored procedures without attachment columns
-- These procedures in `capstream-tables.sql` referenced
-- `attachmentName` and `attachmentSize` which do not exist on `cap-update`.
-- Add corrected procedures here so they can be applied via this migration file.
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
    notes
  FROM `cap-update`
  WHERE idProperty = UUID_TO_BIN(p_idProperty)
  ORDER BY updateDate DESC;
END$$

DELIMITER ;

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
    notes
  FROM `cap-update`
  WHERE idProperty = UUID_TO_BIN(p_idProperty)
    AND updateDate >= p_startDate
    AND updateDate <= p_endDate
  ORDER BY updateDate DESC;
END$$

DELIMITER ;
