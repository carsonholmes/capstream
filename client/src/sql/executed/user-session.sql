DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertUserSession//
CREATE PROCEDURE hub.insertUserSession (IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	SET @Now = Now();
	INSERT INTO `user-session` (idSession, idEntity, dtStarted, dtActive, done) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), @Now, @Now, 0);
	SELECT @idSession as idSession;
END//
DROP PROCEDURE IF EXISTS hub.selectUserSession//
CREATE PROCEDURE hub.selectUserSession (IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID( idSession) as idSession, BIN_TO_UUID( idEntity ) as idEntity, dtStarted, dtActive, done
	FROM `user-session` where idSession = UUID_TO_BIN(p_idSession);
END//
DROP PROCEDURE IF EXISTS hub.updateUserSession//
CREATE PROCEDURE hub.updateUserSession (IN p_idSession CHAR(36), IN p_idEntity CHAR(36), IN p_done BIT(1))
BEGIN
	UPDATE `user-session` SET dtActive = Now(), done = p_done WHERE idSession = UUID_TO_BIN(p_idSession) AND idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteUserSession//
CREATE PROCEDURE hub.deleteUserSession (IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `user-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END//
DELIMITER ;