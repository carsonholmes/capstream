DELIMITER //
DROP TABLE IF EXISTS  `hub`.`entity-area`//
CREATE TABLE `hub`.`entity-area` (
  `idEntity` BINARY(16) NOT NULL,
  `idAddress` INT NULL,
  `postalCode` VARCHAR(12) NULL,
  `mileRadius` INT NULL,
  PRIMARY KEY (`idEntity`))//
DROP PROCEDURE IF EXISTS hub.insertEntityArea//
CREATE PROCEDURE hub.insertEntityArea (IN p_idEntity CHAR(36), IN p_idAddress INT, IN p_postalCode VARCHAR(12), IN p_mileRadius INT)
BEGIN
	INSERT INTO `hub`.`entity-area` (idEntity, idAddress, postalCode, mileRadius) 
    VALUES (UUID_TO_BIN(p_idEntity), p_idAddress, p_postalCode, p_mileRadius);
END//
DROP PROCEDURE IF EXISTS hub.selectEntityArea//
CREATE PROCEDURE hub.selectEntityArea (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, idAddress, postalCode, mileRadius FROM `hub`.`entity-area` where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntityArea//
CREATE PROCEDURE hub.updateEntityArea (IN p_idEntity CHAR(36), IN p_idAddress INT, IN p_postalCode VARCHAR(12), IN p_mileRadius INT)
BEGIN
	UPDATE `hub`.`entity-area` SET idAddress = p_idAddress, postalCode = p_postalCode, mileRadius = p_mileRadius
	WHERE  idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityArea//
CREATE PROCEDURE hub.deleteEntityArea (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `hub`.`entity-area` WHERE  idEntity = UUID_TO_BIN(p_idEntity);
END//
DELIMITER ;