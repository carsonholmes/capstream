DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertEmail//
CREATE PROCEDURE hub.insertEmail (IN p_idEntity CHAR(36), IN p_emailAddress VARCHAR(320), IN p_emailVerifyCode CHAR(6))
BEGIN
	INSERT INTO hub.email (idEntity, emailAddress, emailVerifyCode) VALUES(UUID_TO_BIN(p_idEntity), p_emailAddress, p_emailVerifyCode);
	SELECT LAST_INSERT_ID() AS idEmail;
END//
DROP PROCEDURE IF EXISTS hub.selectEmail//
CREATE PROCEDURE hub.selectEmail (IN p_idEmail BIGINT)
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM hub.email WHERE idEmail = p_idEmail;
END//
DROP PROCEDURE IF EXISTS hub.selectEmailByEntity//
CREATE PROCEDURE hub.selectEmailByEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT idEmail, BIN_TO_UUID(idEntity) as idEntity, emailAddress, emailVerified, emailVerifyCode FROM hub.email WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateEmail//
CREATE PROCEDURE hub.updateEmail  (IN p_idEmail BIGINT, IN p_emailAddress VARCHAR(320), IN p_emailVerified TINYINT(1), IN p_emailVerifyCode CHAR(6))
BEGIN
	UPDATE hub.email SET emailAddress = p_emailAddress, emailVerified = p_emailVerified, emailVerifyCode = p_emailVerifyCode WHERE idEmail = p_idEmail;
END//
DROP PROCEDURE IF EXISTS hub.deleteEmail//
CREATE PROCEDURE hub.deleteEmail (IN p_idEmail BIGINT)
BEGIN
	DELETE FROM hub.email WHERE idEmail = p_idEmail;
END//
DELIMITER ;