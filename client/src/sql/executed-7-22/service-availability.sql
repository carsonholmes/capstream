DELIMITER //
DROP TABLE IF EXISTS `hub`.`service-availability`//
CREATE TABLE `hub`.`service-availability` (
  `idEvent` int(10) unsigned not NULL,
  `idService` binary(16) NOT NULL,
  UNIQUE KEY `ServiceAvailability_UNIQUE` (`idEvent`,`idService`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertServiceAvailability//
CREATE PROCEDURE hub.insertServiceAvailability (IN p_idEvent int, IN p_idService CHAR(36))
BEGIN
	INSERT INTO hub.`service-availability` (idEvent, idService) VALUES(p_idEvent, UUID_TO_BIN(p_idService));
END//
DROP PROCEDURE IF EXISTS hub.selectServiceAvailability//
CREATE PROCEDURE hub.selectServiceAvailability (IN p_idEvent INT)
BEGIN
	SELECT idEvent, BIN_TO_UUID(idService) as idService 
  FROM hub.`service-availability` where idEvent = p_idEvent;
END//
DROP PROCEDURE IF EXISTS hub.deleteServiceAvailability//
CREATE PROCEDURE hub.deleteServiceAvailability (IN p_idEvent int, IN p_idService CHAR(36))
BEGIN
	DELETE FROM hub.`service-availability` WHERE  idEvent = p_idEvent AND idService = UUID_TO_BIN(p_idService);
END//