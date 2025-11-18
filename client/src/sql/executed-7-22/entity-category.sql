DELIMITER //
DROP TABLE IF EXISTS `hub`.`entity-category`//
CREATE TABLE `hub`.`entity-category` (
  `idEntity`  BINARY(16) NOT NULL,
  `idCategory` INT UNSIGNED NOT NULL,
  `dtCreated` DATETIME NOT NULL,
  KEY `fkEntityEC_idx` (`idEntity`),
  KEY `fkCategoryEC_idx` (`idCategory`),
  CONSTRAINT `fkCategoryEC` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idcategory`),
  CONSTRAINT `fkEntityEC` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//

DROP PROCEDURE IF EXISTS hub.insertEntityCategory//
CREATE PROCEDURE hub.insertEntityCategory (IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	INSERT INTO `entity-category` (idEntity, idCategory, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idCategory, Now());
END//
DROP PROCEDURE IF EXISTS hub.selectEntityCategory//
CREATE PROCEDURE hub.selectEntityCategory (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity), idCategory, dtCreated FROM `entity-category` where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntityCategory//
DROP PROCEDURE IF EXISTS hub.deleteEntityCategory//
CREATE PROCEDURE hub.deleteEntityCategory (IN p_idEntity CHAR(36), IN p_idCategory INT)
BEGIN
	DELETE FROM `entity-category` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idCategory = p_idCategory;
END//
DELIMITER ;