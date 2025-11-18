DELIMITER //
DROP TABLE IF EXISTS hub.place //
CREATE TABLE `hub`.`place` (
  `idEntity`  BINARY(16) NOT NULL,
  `placeType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPlace` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertPlace//
CREATE PROCEDURE hub.insertPlace (IN p_idEntity CHAR(36), IN p_placeType INT)
BEGIN
	INSERT INTO hub.place (idEntity, placeType) VALUES(UUID_TO_BIN(p_idEntity), placeType);
END//
DROP PROCEDURE IF EXISTS hub.selectPlace//
CREATE PROCEDURE hub.selectPlace (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, placeType FROM hub.place where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updatePlace//
CREATE PROCEDURE hub.updatePlace (IN p_idEntity CHAR(36), IN p_placeType INT)
BEGIN
	UPDATE hub.place SET placeType = p_placeType WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deletePlace//
CREATE PROCEDURE hub.deletePlace (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.place WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
