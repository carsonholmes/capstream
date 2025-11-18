DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertAttribute//
CREATE PROCEDURE hub.insertAttribute (IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO hub.attribute (attrDesc, attrType, idSuggestor) VALUES(p_attrDesc, p_attrType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.selectAttribute//
CREATE PROCEDURE hub.selectAttribute (IN p_idAttribute INT)
BEGIN
	SELECT idAttribute, attrDesc, attrType, BIN_TO_UUID(idSuggestor) as idSuggestor FROM hub.attribute where idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.updateAttribute//
CREATE PROCEDURE hub.updateAttribute (IN p_idAttribute INT, IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE hub.attribute SET attrDesc = p_attrDesc, attrType = p_attrType, idSuggestor = UUID_TO_BIN(p_idSuggestor) 
	WHERE  idAttribute = p_idAttribute;
END//
DROP PROCEDURE IF EXISTS hub.deleteAttribute//
CREATE PROCEDURE hub.deleteAttribute (IN p_idAttribute INT)
BEGIN
	DELETE FROM hub.attribute WHERE  idAttribute = p_idAttribute;
END//