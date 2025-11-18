DELIMITER //
DROP TABLE IF EXISTS `hub`.`entity-attribute`//
CREATE TABLE `hub`.`entity-attribute` (
  `idEntity` binary(16) NOT NULL,
  `idAttribute` int(10) unsigned NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  `dtCreated` datetime DEFAULT NULL,
  `dtLastEdited` datetime DEFAULT NULL,
  KEY `fkEntityEA_idx` (`idEntity`),
  KEY `fkAttributeEA_idx` (`idAttribute`),
  CONSTRAINT `fkAttributeEA` FOREIGN KEY (`idAttribute`) REFERENCES `attribute` (`idattribute`),
  CONSTRAINT `fkEntityEA` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertEntityAttribute//
CREATE PROCEDURE hub.insertEntityAttribute (IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	INSERT INTO `hub.entity-attribute` (idEntity, idAttribute, value, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_idAttribute, p_value, Now());
END//
DROP PROCEDURE IF EXISTS hub.selectEntityAttribute//
CREATE PROCEDURE hub.selectEntityAttribute (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM `hub.entity-attribute` where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntityAttribute//
CREATE PROCEDURE hub.updateEntityAttribute (IN p_idEntity CHAR(36), IN p_idAttribute INT, IN p_value VARCHAR(1024))
BEGIN
	UPDATE `hub.entity-attribute` SET value = p_value, dtLastEdited = Now() 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityAttribute//
CREATE PROCEDURE hub.deleteEntityAttribute (IN p_idEntity CHAR(36), IN p_idAttribute INT)
BEGIN
	DELETE FROM `hub.entity-attribute` WHERE idEntity = UUID_TO_BIN(p_idEntity) and idAttribute = p_idAttribute;
END//
DELIMITER ;