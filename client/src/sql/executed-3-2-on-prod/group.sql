DELIMITER //
DROP TABLE IF EXISTS hub.group//
CREATE TABLE `hub`.`group` (
  `idEntity`  BINARY(16) NOT NULL,
  `groupType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityGroup` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertGroup//
CREATE PROCEDURE hub.insertGroup (IN p_idEntity CHAR(36), IN p_groupType INT)
BEGIN
	INSERT INTO hub.group (idEntity, groupType) VALUES(UUID_TO_BIN(p_idEntity), groupType);
END//
DROP PROCEDURE IF EXISTS hub.selectGroup//
CREATE PROCEDURE hub.selectGroup (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, groupType FROM hub.group where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateGroup//
CREATE PROCEDURE hub.updateGroup (IN p_idEntity CHAR(36), IN p_groupType INT)
BEGIN
	UPDATE hub.group SET groupType = p_groupType WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteGroup//
CREATE PROCEDURE hub.deleteGroup (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.group WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//