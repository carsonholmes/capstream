DELIMITER //
DROP TABLE IF EXISTS `hub`.`message`//
CREATE TABLE `hub`.`message` (
  `idMessage` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idThread` BIGINT UNSIGNED NOT NULL,
  `idSender` BINARY(16) NOT NULL,
  `idRecipient` BINARY(16) NOT NULL,
  `dtSent` DATETIME NOT NULL,
  `messageText` TEXT NOT NULL,
  `dtViewed` DATETIME NULL,
  PRIMARY KEY (`idMessage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertMessage//
CREATE PROCEDURE hub.insertMessage (
  IN p_idThread BIGINT,
  IN p_idSender CHAR(36),
  IN p_idRecipient CHAR(36),
  IN p_dtSent DATETIME,
  IN p_messageText TEXT)
BEGIN
	DECLARE idNew BIGINT;
  INSERT INTO hub.message (idThread,
    idSender,
    idRecipient,
    dtSent,
    messageText,
    dtViewed)
  VALUES (p_idThread,
    UUID_TO_BIN(p_idSender),
    UUID_TO_BIN(p_idRecipient),
    p_dtSent,
    p_messageText,
    NULL);
  SET idNew = LAST_INSERT_ID();
  IF p_idThread = 0 THEN UPDATE hub.message SET idThread = idNew WHERE idMessage = idNew;
  END IF;
	SELECT LAST_INSERT_ID() as idMessage;
END//
DROP PROCEDURE IF EXISTS hub.selectMessage//
CREATE PROCEDURE hub.selectMessage (IN p_idEntity CHAR(36))
BEGIN
	WITH ranked_messages AS (SELECT idMessage,
    idThread,
    BIN_TO_UUID(idSender) AS idSender,
    e1.entityTitle AS senderName,
    BIN_TO_UUID(idRecipient) AS idRecipient,
    e2.entityTitle as recipientName,
    dtSent,
    messageText,
    dtViewed,
    ROW_NUMBER() OVER (PARTITION BY idThread ORDER BY dtSent DESC) AS rn
  FROM hub.message, hub.entity e1, hub.entity e2
  WHERE (idSender = UUID_TO_BIN(p_idEntity) OR idRecipient = UUID_TO_BIN(p_idEntity)) 
    AND idSender = e1.idEntity AND idRecipient = e2.idEntity
  )
  SELECT * FROM ranked_messages WHERE rn = 1 ORDER BY dtSent DESC;
END//
DROP PROCEDURE IF EXISTS hub.selectThread//
CREATE PROCEDURE hub.selectThread (IN p_idThread BIGINT)
BEGIN
	SELECT idMessage,
    idThread,
    BIN_TO_UUID(idSender) AS idSender,
    e1.entityTitle AS senderName,
    BIN_TO_UUID(idRecipient) AS idRecipient,
    e2.entityTitle as recipientName,
    dtSent,
    messageText,
    dtViewed
  FROM hub.message, hub.entity e1, hub.entity e2
  WHERE idThread = p_idThread
    AND idSender = e1.idEntity AND idRecipient = e2.idEntity
  ORDER BY dtSent DESC;
END//
DROP PROCEDURE IF EXISTS hub.updateMessage//
CREATE PROCEDURE hub.updateMessage (IN p_idMessage INT,
  IN p_dtViewed DATETIME)
BEGIN
	UPDATE hub.message 
  SET dtViewed = p_dtViewed
	WHERE idMessage = p_idMessage;
END//
DROP PROCEDURE IF EXISTS hub.deleteMessage//
CREATE PROCEDURE hub.deleteMessage (IN p_idMessage INT)
BEGIN
	DELETE FROM hub.message WHERE  idMessage = p_idMessage;
END//
DELIMITER ;