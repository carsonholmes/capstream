DELIMITER //
DROP TABLE IF EXISTS `hub`.`common-attribute`//
DROP TABLE IF EXISTS `hub`.`entity-attribute`//
DROP TABLE IF EXISTS `hub`.`attribute`//
CREATE TABLE `hub`.`attribute` (
  `idAttribute` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attrName` varchar(1024) DEFAULT NULL,
  `attrType` int(10) unsigned NOT NULL,
  `idSuggestor` binary(16) NOT NULL,
  PRIMARY KEY (`idAttribute`),
  UNIQUE KEY `idAttribute_UNIQUE` (`idAttribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertAttribute//
CREATE PROCEDURE hub.insertAttribute (IN p_attrName VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO hub.attribute (attrName, attrType, idSuggestor) VALUES(p_attrName, p_attrType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.selectAttribute//
CREATE PROCEDURE hub.selectAttribute (IN p_idAttribute INT)
BEGIN
	SELECT idAttribute, attrName, attrType, BIN_TO_UUID(idSuggestor) as idSuggestor FROM hub.attribute where idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.updateAttribute//
CREATE PROCEDURE hub.updateAttribute (IN p_idAttribute INT, IN p_attrName VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE hub.attribute SET attrName = p_attrName, attrType = p_attrType, idSuggestor = UUID_TO_BIN(p_idSuggestor) 
	WHERE  idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.deleteAttribute//
CREATE PROCEDURE hub.deleteAttribute (IN p_idAttribute INT)
BEGIN
	DELETE FROM hub.attribute WHERE  idAttribute = p_idAttribute;
END//