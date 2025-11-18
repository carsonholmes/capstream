-- -----------------------------------------------------
-- Use database
-- -----------------------------------------------------
USE `capstream`;

-- -----------------------------------------------------
-- Table `capstream`.`property-position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`cash-activity`;
DROP TABLE IF EXISTS `capstream`.`cap-update`;
DROP TABLE IF EXISTS `capstream`.`property-position`;
DROP TABLE IF EXISTS `capstream`.`entity-attachment`;

CREATE TABLE `entity-attachment` (
  `idAttachment` int NOT NULL,
  `idEntity` binary(16) NOT NULL,
  `fileName` varchar(255) NOT NULL,
  `dtAdded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAttachment`),
  KEY `idx_entity_attachment_entity` (`idEntity`),
  KEY `idx_entity_attachment_dtAdded` (`dtAdded`),
  KEY `idx_entity_attachment_fileName` (`fileName`),
  CONSTRAINT `fk_entity_attachment_entity` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `capstream`.`property-position` (
  `idEntity`              BINARY(16)     NOT NULL,
  -- Property
  `propertyName`          VARCHAR(255)   NOT NULL,
  `sponsorGP`             VARCHAR(255)   NOT NULL,
  `partnershipLP`         VARCHAR(255)   NULL,
  `acquisitionDate`       DATE           NULL,
  `propertyNotes`         TEXT           NULL,
  -- Position
  `lpEntity`              VARCHAR(255)   NOT NULL,
  `investedEquity`        DECIMAL(18,2)  NOT NULL,
  `investmentDate`        DATE           NOT NULL,
  `ownershipPct`          DECIMAL(5,2)   NULL,
  `prefReturnPct`         DECIMAL(5,2)   NULL,
  `distributionCadence`   VARCHAR(32)    NOT NULL DEFAULT 'Quarterly',
  -- Targets
  `targetIRR`             DECIMAL(5,2)   NULL,
  `targetEquityMultiple`  DECIMAL(6,3)   NULL,
  `projectedSaleDate`     DATE           NULL,

  PRIMARY KEY (`idEntity`),

  -- Helpful lookup indexes for lists/search
  INDEX `idx_property_position_propertyName` (`propertyName`),
  INDEX `idx_property_position_lpEntity`     (`lpEntity`),

  CONSTRAINT `fk_property_position_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- =====================================================
-- Stored Procedures (CRUD + lookups)
-- =====================================================

-- -----------------------------------------------------
-- procedure insertPropertyPosition
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `insertPropertyPosition`$$
CREATE PROCEDURE `insertPropertyPosition`(
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
-- procedure selectPropertyPosition (by idEntity)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectPropertyPosition`$$
CREATE PROCEDURE `selectPropertyPosition`(IN p_idEntity CHAR(36))
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
-- procedure selectPropertyPositionByPropertyName
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectPropertyPositionByPropertyName`$$
CREATE PROCEDURE `selectPropertyPositionByPropertyName`(IN p_propertyName VARCHAR(255))
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
-- procedure selectPropertyPositionByLpEntity
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectPropertyPositionByLpEntity`$$
CREATE PROCEDURE `selectPropertyPositionByLpEntity`(IN p_lpEntity VARCHAR(255))
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
-- procedure updatePropertyPosition
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `updatePropertyPosition`$$
CREATE PROCEDURE `updatePropertyPosition`(
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
-- procedure deletePropertyPosition
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `deletePropertyPosition`$$
CREATE PROCEDURE `deletePropertyPosition`(IN p_idEntity CHAR(36))
BEGIN
  DELETE FROM `property-position`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Use database
-- -----------------------------------------------------
USE `capstream`;

-- -----------------------------------------------------
-- Table `capstream`.`cap-update`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`cap-update`;

CREATE TABLE IF NOT EXISTS `capstream`.`cap-update` (
  `idEntity`               BINARY(16)     NOT NULL,     -- PK (Update entity id)
  `idProperty`             BINARY(16)     NOT NULL,     -- FK to `property-position`.idEntity (the property/position being updated)
  `propertyName`           VARCHAR(255)   NULL,         -- Optional snapshot for convenience
  `updateDate`             DATE           NOT NULL,     -- Required
  -- Revisions (optional)
  `revisedSaleDate`        DATE           NULL,
  `revisedIrrPct`          DECIMAL(5,2)   NULL,
  `revisedEquityMultiple`  DECIMAL(6,3)   NULL,
  `distributionGuidance`   VARCHAR(32)    NOT NULL DEFAULT 'Same as OM',  -- Same as OM / Increase / Decrease / Suspend
  `notes`                  TEXT           NULL,

  PRIMARY KEY (`idEntity`),

  -- Helpful lookups for timeline and filtering
  INDEX `idx_cap_update_property` (`idProperty`),
  INDEX `idx_cap_update_updateDate` (`updateDate`),

  -- FKs
  CONSTRAINT `fk_cap_update_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),

  CONSTRAINT `fk_cap_update_property`
    FOREIGN KEY (`idProperty`)
    REFERENCES `capstream`.`property-position` (`idEntity`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- =====================================================
-- Stored Procedures (CRUD + common selects)
-- =====================================================

-- -----------------------------------------------------
-- procedure insertCapUpdate
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `insertCapUpdate`$$
CREATE PROCEDURE `insertCapUpdate`(
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
    p_notes );
  -- Return UUID (never return binary)
  SELECT p_idEntity AS idEntity;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure selectCapUpdate (by idEntity)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectCapUpdate`$$
CREATE PROCEDURE `selectCapUpdate`(IN p_idEntity CHAR(36))
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
-- procedure selectCapUpdatesByProperty (timeline; newest first)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectCapUpdatesByProperty`$$
CREATE PROCEDURE `selectCapUpdatesByProperty`(IN p_idProperty CHAR(36))
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

-- -----------------------------------------------------
-- procedure selectCapUpdatesByDateRange (optional helper)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectCapUpdatesByDateRange`$$
CREATE PROCEDURE `selectCapUpdatesByDateRange`(
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

-- -----------------------------------------------------
-- procedure updateCapUpdate
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `updateCapUpdate`$$
CREATE PROCEDURE `updateCapUpdate`(
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
-- procedure deleteCapUpdate
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `deleteCapUpdate`$$
CREATE PROCEDURE `deleteCapUpdate`(IN p_idEntity CHAR(36))
BEGIN
  DELETE FROM `cap-update`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Use database
-- -----------------------------------------------------
USE `capstream`;

-- -----------------------------------------------------
-- Table `capstream`.`cap-update`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`cap-update`;

CREATE TABLE IF NOT EXISTS `capstream`.`cap-update` (
  `idEntity`               BINARY(16)     NOT NULL,     -- PK (Update entity id)
  `idProperty`             BINARY(16)     NOT NULL,     -- FK to `property-position`.idEntity (the property/position being updated)
  `propertyName`           VARCHAR(255)   NULL,         -- Optional snapshot for convenience
  `updateDate`             DATE           NOT NULL,     -- Required
  -- Revisions (optional)
  `revisedSaleDate`        DATE           NULL,
  `revisedIrrPct`          DECIMAL(5,2)   NULL,
  `revisedEquityMultiple`  DECIMAL(6,3)   NULL,
  `distributionGuidance`   VARCHAR(32)    NOT NULL DEFAULT 'Same as OM',  -- Same as OM / Increase / Decrease / Suspend
  `notes`                  TEXT           NULL,

  PRIMARY KEY (`idEntity`),

  -- Helpful lookups for timeline and filtering
  INDEX `idx_cap_update_property` (`idProperty`),
  INDEX `idx_cap_update_updateDate` (`updateDate`),

  -- FKs
  CONSTRAINT `fk_cap_update_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`),

  CONSTRAINT `fk_cap_update_property`
    FOREIGN KEY (`idProperty`)
    REFERENCES `capstream`.`property-position` (`idEntity`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- =====================================================
-- Stored Procedures (CRUD + common selects)
-- =====================================================

-- -----------------------------------------------------
-- procedure insertCapUpdate
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `insertCapUpdate`$$
CREATE PROCEDURE `insertCapUpdate`(
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
-- procedure selectCapUpdate (by idEntity)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectCapUpdate`$$
CREATE PROCEDURE `selectCapUpdate`(IN p_idEntity CHAR(36))
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
-- procedure selectCapUpdatesByProperty (timeline; newest first)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectCapUpdatesByProperty`$$
CREATE PROCEDURE `selectCapUpdatesByProperty`(IN p_idProperty CHAR(36))
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
-- procedure selectCapUpdatesByDateRange (optional helper)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectCapUpdatesByDateRange`$$
CREATE PROCEDURE `selectCapUpdatesByDateRange`(
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
-- procedure updateCapUpdate
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `updateCapUpdate`$$
CREATE PROCEDURE `updateCapUpdate`(
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
-- procedure deleteCapUpdate
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `deleteCapUpdate`$$
CREATE PROCEDURE `deleteCapUpdate`(IN p_idEntity CHAR(36))
BEGIN
  DELETE FROM `cap-update`
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END$$
DELIMITER ;

-- -----------------------------------------------------
-- Use database
-- -----------------------------------------------------
USE `capstream`;

-- -----------------------------------------------------
-- Table `capstream`.`entity-attachment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `capstream`.`entity-attachment`;

CREATE TABLE IF NOT EXISTS `capstream`.`entity-attachment` (
  `idAttachment`  BINARY(16)      NOT NULL,   -- PK (attachment id)
  `idEntity`      BINARY(16)      NOT NULL,   -- FK -> entity.idEntity
  `name`          VARCHAR(255)    NOT NULL,   -- display name / title
  `fileName`      VARCHAR(255)    NOT NULL,   -- stored filename (or original)
  `fileSize`      BIGINT UNSIGNED NOT NULL,   -- bytes
  `fileExt`       VARCHAR(16)     NOT NULL,   -- e.g., pdf, jpg
  `dtAdded`       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAttachment`),

  -- helpful lookups
  INDEX `idx_entity_attachment_entity` (`idEntity`),
  INDEX `idx_entity_attachment_dtAdded` (`dtAdded`),
  INDEX `idx_entity_attachment_fileName` (`fileName`),

  CONSTRAINT `fk_entity_attachment_entity`
    FOREIGN KEY (`idEntity`)
    REFERENCES `capstream`.`entity` (`idEntity`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- =====================================================
-- Stored Procedures (CRUD + common selects)
-- =====================================================

-- -----------------------------------------------------
-- procedure insertEntityAttachment
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `insertEntityAttachment`$$
CREATE PROCEDURE `insertEntityAttachment`(
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
-- procedure selectEntityAttachment (by idAttachment)
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectEntityAttachment`$$
CREATE PROCEDURE `selectEntityAttachment`(IN p_idAttachment CHAR(36))
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
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectEntityAttachmentsByEntity`$$
CREATE PROCEDURE `selectEntityAttachmentsByEntity`(IN p_idEntity CHAR(36))
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
-- procedure updateEntityAttachment
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `updateEntityAttachment`$$
CREATE PROCEDURE `updateEntityAttachment`(
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
-- procedure deleteEntityAttachment
-- -----------------------------------------------------
DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `deleteEntityAttachment`$$
CREATE PROCEDURE `deleteEntityAttachment`(IN p_idAttachment INT)
BEGIN
  DELETE FROM `entity-attachment`
  WHERE idAttachment = p_idAttachment;
END$$
DELIMITER ;

DELIMITER $$
USE `capstream`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selectGroupsAll`()
BEGIN
	SELECT BIN_TO_UUID(g.idEntity) as idEntity, e.entityTitle, g.groupType, g.backgroundColor FROM capstream.group as g, capstream.entity as e
    where e.entityType = 3
    AND e.idEntity = g.idEntity;
END$$
DELIMITER ;

DELIMITER $$
USE `capstream`$$
DROP PROCEDURE IF EXISTS `selectPropertyPositionByClient`$$
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