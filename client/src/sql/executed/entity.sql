DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertEntity//
CREATE PROCEDURE hub.insertEntity (IN p_entityTitle VARCHAR(255), IN p_entityType INT)
BEGIN
	SET @idEntity = UUID_TO_BIN(UUID());
	INSERT INTO hub.entity (idEntity, entityTitle, entityType, dtCreated) VALUES(@idEntity, p_entityTitle, p_entityType, Now());
	SELECT BIN_TO_UUID(@idEntity) as idEntity;
END//
DROP PROCEDURE IF EXISTS hub.selectEntity//
CREATE PROCEDURE hub.selectEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, entityTitle, dtCreated FROM hub.entity where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEntity//
CREATE PROCEDURE hub.updateEntity (IN p_idEntity CHAR(36), IN p_entityTitle VARCHAR(255))
BEGIN
	UPDATE hub.entity SET entityTitle = p_entityTitle WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntity//
CREATE PROCEDURE hub.deleteEntity (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.entity WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DELIMITER ;