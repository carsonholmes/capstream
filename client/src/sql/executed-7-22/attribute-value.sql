DELIMITER //
DROP TABLE IF EXISTS `hub`.`attribute-value`//
CREATE TABLE `hub`.`attribute-value` (
  `idAttributeValue` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAttribute` int(10) unsigned NOT NULL,
  `attrValue` varchar(1024) DEFAULT NULL,
  `sortOrder` smallint NOT NULL,
  `idSuggestor` binary(16) NOT NULL,
  PRIMARY KEY (`idAttributeValue`),
  UNIQUE KEY `idAttributeValue_UNIQUE` (`idAttributeValue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertAttributeValue//
CREATE PROCEDURE hub.insertAttributeValue (IN p_idAttribute int(10), IN p_attrValue VARCHAR(1024), IN p_sortOrder smallint, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO `attribute-value` (idAttribute, attrValue, sortOrder, idSuggestor) VALUES(p_idAttribute, p_attrValue, p_sortOrder, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttributeValue;
END//
DROP PROCEDURE IF EXISTS hub.selectAttributeValue//
CREATE PROCEDURE hub.selectAttributeValue (IN p_idAttributeValue INT)
BEGIN
	SELECT idAttributeValue, attrValue, BIN_TO_UUID(idSuggestor) as idSuggestor FROM `attribute-value` where idAttributeValue = p_idAttributeValue;
END//
DROP PROCEDURE IF EXISTS hub.updateAttributeValue//
CREATE PROCEDURE hub.updateAttributeValue (IN p_idAttribute INT, IN p_attrValue VARCHAR(1024), IN p_sortOrder smallint, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `attribute-value` SET idAttribute = p_idAttribute, attrValue = p_attrValue, sortOrder = p_sortOrder, idSuggestor = UUID_TO_BIN(p_idSuggestor)
	WHERE  idAttributeValue = p_idAttributeValue;
END//
DROP PROCEDURE IF EXISTS hub.deleteAttributeValue//
CREATE PROCEDURE hub.deleteAttributeValue (IN p_idAttributeValue INT)
BEGIN
	DELETE FROM `attribute-value` WHERE  idAttributeValue = p_idAttributeValue;
END//