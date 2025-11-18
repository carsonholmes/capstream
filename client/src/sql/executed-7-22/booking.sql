DELIMITER //
DROP TABLE IF EXISTS `hub`.`booking`//
CREATE TABLE `hub`.`booking` (
  `idBooking` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idEvent` int(10) unsigned NOT NULL,
  `idAvailability` int(10) unsigned NOT NULL,
  `idConsumer` binary(16) NOT NULL,
  PRIMARY KEY (`idBooking`),
  UNIQUE KEY `idBooking_UNIQUE` (`idBooking`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertBooking//
CREATE PROCEDURE hub.insertBooking (IN p_idEvent int, IN p_idAvailable int, IN p_idConsumer char(36))
BEGIN
	INSERT INTO hub.booking (attrName, idEvent, idConsumer) VALUES(p_attrName, p_idEvent, UUID_TO_BIN(p_idConsumer));
	SELECT LAST_INSERT_ID() as idBooking;
END//
DROP PROCEDURE IF EXISTS hub.selectBooking//
CREATE PROCEDURE hub.selectBooking (IN p_idBooking INT)
BEGIN
	SELECT idBooking, idEvent, idAvailable, BIN_TO_UUID(idConsumer) as idConsumer FROM hub.booking where idBooking = p_idBooking;
END//
DROP PROCEDURE IF EXISTS hub.updateBooking//
CREATE PROCEDURE hub.updateBooking (IN p_idBooking INT, IN p_idEvent int, IN p_idAvailable int, IN p_idConsumer char(36))
BEGIN
	UPDATE hub.booking SET attrName = p_attrName, idEvent = p_idEvent, idConsumer = UUID_TO_BIN(p_idConsumer) 
	WHERE  idBooking = p_idBooking;
END//
DROP PROCEDURE IF EXISTS hub.deleteBooking//
CREATE PROCEDURE hub.deleteBooking (IN p_idBooking INT)
BEGIN
	DELETE FROM hub.booking WHERE  idBooking = p_idBooking;
END//