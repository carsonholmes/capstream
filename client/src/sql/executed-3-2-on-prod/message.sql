DELIMITER //
DROP TABLE IF EXISTS hub.message //
CREATE TABLE hub.message (
  `idMessage` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idSender` BINARY(16) NOT NULL,
  `idRecipient` BINARY(16) NOT NULL,
  `title` varchar(1024) DEFAULT NULL,
  `message` text,
  `idRegarding` BINARY(16) NULL,
  `idThread` int(10) unsigned NOT NULL,
  `dateSent` datetime NOT NULL,
  PRIMARY KEY (`idMessage`),
  UNIQUE KEY `idMessage_UNIQUE` (`idMessage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci //
DROP PROCEDURE IF EXISTS hub.insertMessage//
CREATE PROCEDURE hub.insertMessage (IN p_idSender BINARY(16), 
    IN p_idRecipient BINARY(16), 
    IN p_title varchar(1024), 
    IN p_message text, 
    IN p_idRegarding BINARY(16),
    IN p_idThred int(10),
    IN p_dateSent datetime)
BEGIN
	INSERT INTO hub.message (idSender, idRecipient, title, message, idRegarding, idThred, dateSent) 
    VALUES (UUID_TO_BIN(p_idSender), UUID_TO_BIN(p_idRecipient), p_title, p_message, UUID_TO_BIN(p_idRegarding), p_idThread, p_dateSent);
	SELECT LAST_INSERT_ID() AS idMessage;
END//
DROP PROCEDURE IF EXISTS hub.selectMessage//
CREATE PROCEDURE hub.selectMessage (IN p_idMessage bigint(20))
BEGIN
	SELECT idMessage, BIN_TO_UUID(idSender), BIN_TO_UUID(idRecipient), title, message, BIN_TO_UUID(idRegarding), idThread, dateSent 
    FROM hub.message
    WHERE idMessage = p_idMessage;
END//
DROP PROCEDURE IF EXISTS hub.selectMessageByRecipient//
CREATE PROCEDURE hub.selectMessageByRecipient (IN p_idRecipient bigint(20))
BEGIN
	SELECT idMessage, BIN_TO_UUID(idSender), BIN_TO_UUID(idRecipient), title, message, BIN_TO_UUID(idRegarding), idThread, dateSent 
    FROM hub.message
    WHERE idRecipient = UUID_TO_BIN(p_idRecipient);
END//
DROP PROCEDURE IF EXISTS hub.selectMessageBySender//
CREATE PROCEDURE hub.selectMessageBySender (IN p_idSender bigint(20))
BEGIN
	SELECT idMessage, BIN_TO_UUID(idSender), BIN_TO_UUID(idRecipient), title, message, BIN_TO_UUID(idRegarding), idThread, dateSent 
    FROM hub.message
    WHERE idSender = UUID_TO_BIN(p_idSender);
END//
DROP PROCEDURE IF EXISTS hub.updateMessage//
CREATE PROCEDURE hub.updateMessage  (IN p_idMessage bigint(20), 
    IN p_idSender BINARY(16) , 
    IN p_idRecipient BINARY(16), 
    IN p_title varchar(1024), 
    IN p_message text, 
    IN p_idRegarding BINARY(16),
    IN p_idThred int(10),
    IN p_dateSent datetime)
BEGIN
	UPDATE hub.message 
    SET idSender = UUID_TO_BIN(p_idSender), idRecipient = UUID_TO_BIN(p_idRecipient), title = p_title, 
        message = p_message, idRegarding = p_idRegarding, idThread = p_idThread, dateSent = p_dateSent
    WHERE idMessage = p_idMessage;
END//
DROP PROCEDURE IF EXISTS hub.deleteMessage//
CREATE PROCEDURE hub.deleteMessage (IN p_idMessage BIGINT)
BEGIN
	DELETE FROM hub.message WHERE idMessage = p_idMessage;
END//