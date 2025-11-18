DELIMITER //
DROP TABLE IF EXISTS `hub`.`notification`//
CREATE TABLE `hub`.`notification` (
  `idNotification` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity` BINARY(16) NOT NULL,
  `serviceBeingBookedEmail` BIT(1) NOT NULL,
  `serviceBeingBookedText` BIT(1) NOT NULL,
  `bookingRequestSubmittedEmail` BIT(1) NOT NULL,
  `bookingRequestSubmittedText` BIT(1) NOT NULL,
  `bookingRequestConfirmedEmail` BIT(1) NOT NULL,
  `bookingRequestConfirmedText` BIT(1) NOT NULL,
  `bookingCancelEmail` BIT(1) NOT NULL,
  `bookingCancelText` BIT(1) NOT NULL,
  `reminderProviderApptEmail` BIT(1) NOT NULL,
  `reminderProviderApptText` BIT(1) NOT NULL,
  `reminderConsumerApptEmail` BIT(1) NOT NULL,
  `reminderConsumerApptText` BIT(1) NOT NULL,
  PRIMARY KEY (`idNotification`),
  UNIQUE INDEX `idEntity_UNIQUE` (`idEntity` ASC) VISIBLE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertNotification//
CREATE PROCEDURE hub.insertNotification (
  IN p_idEntity CHAR(36),
  IN p_serviceBeingBookedEmail BIT(1),
  IN p_serviceBeingBookedText BIT(1),
  IN p_bookingRequestSubmittedEmail BIT(1),
  IN p_bookingRequestSubmittedText BIT(1),
  IN p_bookingRequestConfirmedEmail BIT(1),
  IN p_bookingRequestConfirmedText BIT(1),
  IN p_bookingCancelEmail BIT(1),
  IN p_bookingCancelText BIT(1),
  IN p_reminderProviderApptEmail BIT(1),
  IN p_reminderProviderApptText BIT(1),
  IN p_reminderConsumerApptEmail BIT(1),
  IN p_reminderConsumerApptText BIT(1))
BEGIN
	INSERT INTO hub.notification (idEntity,
    serviceBeingBookedEmail,
    serviceBeingBookedText,
    bookingRequestSubmittedEmail,
    bookingRequestSubmittedText,
    bookingRequestConfirmedEmail,
    bookingRequestConfirmedText,
    bookingCancelEmail,
    bookingCancelText,
    reminderProviderApptEmail,
    reminderProviderApptText,
    reminderConsumerApptEmail,
    reminderConsumerApptText) 
  VALUES (UUID_TO_BIN(p_idEntity),
    p_serviceBeingBookedEmail,
    p_serviceBeingBookedText,
    p_bookingRequestSubmittedEmail,
    p_bookingRequestSubmittedText,
    p_bookingRequestConfirmedEmail,
    p_bookingRequestConfirmedText,
    p_bookingCancelEmail,
    p_bookingCancelText,
    p_reminderProviderApptEmail,
    p_reminderProviderApptText,
    p_reminderConsumerApptEmail,
    p_reminderConsumerApptText);
	SELECT LAST_INSERT_ID() as idNotification;
END//
DROP PROCEDURE IF EXISTS hub.selectNotification//
CREATE PROCEDURE hub.selectNotification (IN p_idEntity CHAR(36))
BEGIN
	SELECT idNotification,
    BIN_TO_UUID(idEntity) AS idEntity,
    serviceBeingBookedEmail,
    serviceBeingBookedText,
    bookingRequestSubmittedEmail,
    bookingRequestSubmittedText,
    bookingRequestConfirmedEmail,
    bookingRequestConfirmedText,
    bookingCancelEmail,
    bookingCancelText,
    reminderProviderApptEmail,
    reminderProviderApptText,
    reminderConsumerApptEmail,
    reminderConsumerApptText
  FROM hub.notification where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateNotification//
CREATE PROCEDURE hub.updateNotification (IN p_idNotification INT,
  IN p_serviceBeingBookedEmail BIT(1),
  IN p_serviceBeingBookedText BIT(1),
  IN p_bookingRequestSubmittedEmail BIT(1),
  IN p_bookingRequestSubmittedText BIT(1),
  IN p_bookingRequestConfirmedEmail BIT(1),
  IN p_bookingRequestConfirmedText BIT(1),
  IN p_bookingCancelEmail BIT(1),
  IN p_bookingCancelText BIT(1),
  IN p_reminderProviderApptEmail BIT(1),
  IN p_reminderProviderApptText BIT(1),
  IN p_reminderConsumerApptEmail BIT(1),
  IN p_reminderConsumerApptText BIT(1))
BEGIN
	UPDATE hub.notification 
  SET serviceBeingBookedEmail = p_serviceBeingBookedEmail,
    serviceBeingBookedText = p_serviceBeingBookedText,
    bookingRequestSubmittedEmail = p_bookingRequestSubmittedEmail,
    bookingRequestSubmittedText = p_bookingRequestSubmittedText,
    bookingRequestConfirmedEmail = p_bookingRequestConfirmedEmail,
    bookingRequestConfirmedText = p_bookingRequestConfirmedText,
    bookingCancelEmail = p_bookingCancelEmail,
    bookingCancelText = p_bookingCancelText,
    reminderProviderApptEmail = p_reminderProviderApptEmail,
    reminderProviderApptText = p_reminderProviderApptText,
    reminderConsumerApptEmail = p_reminderConsumerApptEmail,
    reminderConsumerApptText = p_reminderConsumerApptText
	WHERE  idNotification = p_idNotification;
END//
DROP PROCEDURE IF EXISTS hub.deleteNotification//
CREATE PROCEDURE hub.deleteNotification (IN p_idNotification INT)
BEGIN
	DELETE FROM hub.notification WHERE  idNotification = p_idNotification;
END//
INSERT INTO hub.notification (idEntity,
    serviceBeingBookedEmail,
    serviceBeingBookedText,
    bookingRequestSubmittedEmail,
    bookingRequestSubmittedText,
    bookingRequestConfirmedEmail,
    bookingRequestConfirmedText,
    bookingCancelEmail,
    bookingCancelText,
    reminderProviderApptEmail,
    reminderProviderApptText,
    reminderConsumerApptEmail,
    reminderConsumerApptText) 
  SELECT u.idEntity,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1
  FROM user as u //
DELIMITER;