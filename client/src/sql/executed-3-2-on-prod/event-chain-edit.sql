DELIMITER //
DROP TABLE IF EXISTS `hub`.`event-chain-edit`//
CREATE TABLE `hub`.`event-chain-edit` (
  `idEventChainEdit` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idEvent` int(10) unsigned NOT NULL,
  `editType` tinyint unsigned NOT NULL,
  `dtStart` datetime NOT NULL,
  `idNewEvent` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idEventChainEdit`),
  UNIQUE KEY `idEventChainEdit_UNIQUE` (`idEventChainEdit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertEventChainEdit//
CREATE PROCEDURE hub.insertEventChainEdit (IN p_idEvent int(10), IN p_editType tinyint, IN p_dtStart datetime, IN p_idNewEvent CHAR(36))
BEGIN
	INSERT INTO `event-chain-edit` (idEvent, editType, dtStart, idNewEvent) VALUES(p_idEvent, p_editType, p_dtStart, p_idNewEvent);
	SELECT LAST_INSERT_ID() as idEventChainEdit;
END//
DROP PROCEDURE IF EXISTS hub.selectEventChainEdit//
CREATE PROCEDURE hub.selectEventChainEdit (IN p_idEvent INT)
BEGIN
	SELECT idEventChainEdit, idEvent, editType, dtStart, idNewEvent FROM `event-chain-edit` where idEvent = p_idEvent;
END//
DROP PROCEDURE IF EXISTS hub.deleteEventChainEdit//
CREATE PROCEDURE hub.deleteEventChainEdit (IN p_idEventChainEdit INT)
BEGIN
	DELETE FROM `event-chain-edit` WHERE  idEventChainEdit = p_idEventChainEdit;
END//