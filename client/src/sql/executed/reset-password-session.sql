DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertResetPasswordSession//
CREATE PROCEDURE hub.insertResetPasswordSession (IN p_idEntity CHAR(36))
BEGIN
	SET @idSession = UUID();
	INSERT INTO `reset-password-session` (idSession, idEntity, dtStarted) VALUES(UUID_TO_BIN(@idSession), UUID_TO_BIN(p_idEntity), Now());
	SELECT @idSession as idSession;
END//
DROP PROCEDURE IF EXISTS hub.selectResetPasswordSession//
CREATE PROCEDURE hub.selectResetPasswordSession (IN p_idSession CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idSession) AS idSession, BIN_TO_UUID(idEntity) AS idEntity, dtStarted 
	FROM `reset-password-session` where idSession = UUID_TO_BIN(p_idSession);
END//
DROP PROCEDURE IF EXISTS hub.deleteResetPasswordSession//
CREATE PROCEDURE hub.deleteResetPasswordSession (IN p_idSession CHAR(36))
BEGIN
	DELETE FROM `reset-password-session` WHERE idSession = UUID_TO_BIN(p_idSession);
END//
DELIMITER ;