DELIMITER //
ALTER TABLE `hub`.`user` 
ADD COLUMN `userTimeZone` TINYINT NOT NULL AFTER `userPrimaryEmail`;

DROP PROCEDURE IF EXISTS hub.insertUser//
CREATE PROCEDURE hub.insertUser (IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT, IN p_userTimeZone TINYINT)
BEGIN
	INSERT INTO hub.user (idEntity, userName, userPassword, userSalt, userPrimaryEmail, userTimeZone) VALUES(UUID_TO_BIN(p_idEntity), p_userName, p_userPassword, p_userSalt, p_userPrimaryEmail, p_userTimeZone);
END//
DROP PROCEDURE IF EXISTS hub.selectUser//
CREATE PROCEDURE hub.selectUser (IN p_idEntity CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, userName, userPassword, userSalt, userPrimaryEmail, userTimeZone FROM hub.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.selectUserByUserName//
CREATE PROCEDURE hub.selectUserByUserName (IN p_userName CHAR(64))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.entityTitle, u.userTimeZone
    FROM hub.user AS u, hub.entity AS e
    WHERE userName = p_userName AND e.idEntity = u.idEntity;
END//
DROP PROCEDURE IF EXISTS hub.selectUserByEmail//
CREATE PROCEDURE hub.selectUserByEmail (IN p_emailAddress VARCHAR(320))
BEGIN
	SELECT BIN_TO_UUID(u.idEntity) as idEntity, u.userName, u.userPassword, u.userSalt, u.userPrimaryEmail, e.emailAddress, u.userTimeZone
	FROM hub.user AS u, hub.email AS e WHERE u.idEntity = e.idEntity AND e.emailAddress = p_emailAddress;
END//
DROP PROCEDURE IF EXISTS hub.updateUser//
CREATE PROCEDURE hub.updateUser (IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userPassword VARCHAR(60), IN p_userSalt VARCHAR(29), IN p_userPrimaryEmail BIGINT, IN p_userTimeZone TINYINT)
BEGIN
	UPDATE hub.user SET userName = p_userName, userPassword = p_userPassword, userSalt = p_userSalt, userPrimaryEmail = p_userPrimaryEmail, userTimeZone = p_userTimeZone WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateUserProfile//
CREATE PROCEDURE hub.updateUserProfile (IN p_idEntity CHAR(36), IN p_userName VARCHAR(64), IN p_userTimeZone TINYINT)
BEGIN
	UPDATE hub.user SET userName = p_userName, userTimeZone = p_userTimeZone WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateUserPrimaryEmail//
CREATE PROCEDURE hub.updateUserPrimaryEmail (IN p_idEntity CHAR(36), IN p_userPrimaryEmail BIGINT)
BEGIN
	UPDATE hub.user SET userPrimaryEmail = p_userPrimaryEmail WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//DROP PROCEDURE IF EXISTS hub.deleteUser//
CREATE PROCEDURE hub.deleteUser (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.user WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DELIMITER ;