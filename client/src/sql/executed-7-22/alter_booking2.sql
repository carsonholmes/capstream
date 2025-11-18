DELIMITER //
ALTER TABLE `hub`.`booking` 
ADD COLUMN `confirmed` TINYINT NOT NULL DEFAULT 0 AFTER `idService`;
DROP PROCEDURE IF EXISTS hub.insertBooking//
CREATE PROCEDURE hub.insertBooking (IN p_idEvent int, IN p_idAvailability int, IN p_idConsumer char(36), IN p_idService char(36), IN p_confirmed TINYINT)
BEGIN
	INSERT INTO hub.booking (idEvent, idAvailability, idConsumer, idService, confirmed)
  VALUES (p_idEvent, p_idAvailability, UUID_TO_BIN(p_idConsumer), UUID_TO_BIN(p_idService), p_confirmed);
	SELECT LAST_INSERT_ID() as idBooking;
END//
DROP PROCEDURE IF EXISTS hub.selectBooking//
CREATE PROCEDURE hub.selectBooking (IN p_idBooking INT)
BEGIN
	SELECT idBooking, idEvent, idAvailable, BIN_TO_UUID(idConsumer) as idConsumer, BIN_TO_UUID(idService) as idService, confirmed
  FROM hub.booking where idBooking = p_idBooking AND confirmed <> 2;
END//
DROP PROCEDURE IF EXISTS hub.updateBooking//
CREATE PROCEDURE hub.updateBooking (IN p_idBooking INT, IN p_idEvent int, IN p_idAvailability int, IN p_idConsumer char(36), IN p_idService char(36), IN p_confirmed TINYINT)
BEGIN
	UPDATE hub.booking SET idEvent = p_idEvent, idAvailability = p_idAvailability, idConsumer = UUID_TO_BIN(p_idConsumer), idService = UUID_TO_BIN(p_idService), confirmed = p_confirmed
	WHERE  idBooking = p_idBooking;
END//
DROP PROCEDURE IF EXISTS hub.deleteBooking//
CREATE PROCEDURE hub.deleteBooking (IN p_idBooking INT)
BEGIN
	DELETE FROM hub.booking WHERE  idBooking = p_idBooking;
END//