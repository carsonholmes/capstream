DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertEntityMedia//
CREATE PROCEDURE hub.insertEntityMedia (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_mediaType INT, IN p_fileName VARCHAR(50), IN p_sortOrder INT)
BEGIN
	INSERT INTO `entity-media` (idEntity, idUser, mediaType, fileName, dtCreated, sortOrder) 
	VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idUser), p_mediaType, p_fileName, Now(), p_sortOrder);
	SELECT LAST_INSERT_ID() AS idMedia;
END//
DROP PROCEDURE IF EXISTS hub.selectEntityMedia//
CREATE PROCEDURE hub.selectEntityMedia (IN p_idMedia BIGINT)
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder 
	FROM `entity-media` WHERE idMedia = p_idMedia;
END//
DROP PROCEDURE IF EXISTS hub.selectEntityMediaByEntity//
CREATE PROCEDURE hub.selectEntityMediaByEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT idMedia, BIN_TO_UUID(idEntity) as idEntity, BIN_TO_UUID(idUser) as idUser, mediaType, fileName, dtCreated, sortOrder 
	FROM `entity-media` WHERE idEntity = UUID_TO_BIN(p_idEntity) ORDER BY sortOrder ASC;
END//
DROP PROCEDURE IF EXISTS hub.updateEntityMedia//
CREATE PROCEDURE hub.updateEntityMedia  (IN p_idMedia BIGINT, IN p_sortOrder INT, IN p_xOffset FLOAT, IN p_yOffset FLOAT)
BEGIN
	UPDATE `entity-media` SET sortOrder = p_sortOrder, xOffset = p_xOffset, yOffset = p_yOffset WHERE idMedia = p_idMedia;
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityMedia//
CREATE PROCEDURE hub.deleteEntityMedia (IN p_idMedia BIGINT)
BEGIN
	DELETE FROM `entity-media` WHERE idMedia = p_idMedia;
END//
DELIMITER ;