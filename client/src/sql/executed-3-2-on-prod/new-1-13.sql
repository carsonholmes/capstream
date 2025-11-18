DELIMITER //
DROP PROCEDURE IF EXISTS hub.selectEntityByOwner//
CREATE PROCEDURE hub.selectEntityByOwner (IN p_idEntity CHAR(36), IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited 
  FROM hub.entity AS e, `entity-relate` AS er
  WHERE idRelated = UUID_TO_BIN(p_idEntity) AND er.relateType = 1 AND er.idEntity = e.idEntity AND entityType = p_entityType
  ORDER BY dtCreated DESC;
END//
DROP PROCEDURE IF EXISTS hub.selectEntityBySearch//
CREATE PROCEDURE hub.selectEntityBySearch (IN p_searchValue CHAR(255))
BEGIN
  SELECT * FROM 
	  (SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset 
		FROM hub.entity AS e, `entity-media` as em
		WHERE e.idMedia = em.idMedia
	  UNION ALL 
	  SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL, NULL, 0, 0
		FROM hub.entity AS e
		WHERE e.idMedia is NULL) `combined-alias`
	 ORDER BY dtCreated DESC;
END//
DROP PROCEDURE IF EXISTS hub.updateOffer//
CREATE PROCEDURE hub.updateOffer (IN p_idOffer bigint(20), 
    IN p_idEntity CHAR(36), 
    IN p_offerType smallint, 
    IN p_price float, 
    IN p_timeType smallint, 
    IN p_timeIncrMins smallint,
    IN p_quantify bit(1),
    IN p_quantity smallint,
    IN p_active bit(1))
BEGIN
	UPDATE offer 
  SET offerType=p_offerType, price=p_price, timeType=p_timeType, timeIncrMins=p_timeIncrMins, 
    quantify=p_quantify, quantity=p_quantity, active=p_active 
  WHERE idOffer = p_idOffer AND idEntity = UUID_TO_BIN(p_idEntity);
END//DROP PROCEDURE IF EXISTS hub.insertOrder//
CREATE PROCEDURE hub.insertOrder (IN p_idUser char(36), IN p_state tinyint)
BEGIN
	INSERT INTO hub.order (idUser, state) 
    VALUES (UUID_TO_BIN(p_idUser), p_state);
	SELECT LAST_INSERT_ID() AS idOrder;
END//
DELIMITER //
DROP TABLE IF EXISTS `hub`.`order-item`//
DROP TABLE IF EXISTS `hub`.`order-items`//

CREATE TABLE `hub`.`order-item` (
  `idOrder` bigint(20) UNSIGNED NOT NULL,
  `idEntity` binary(16) NOT NULL,
  `quantity` smallint NOT NULL,
  `totalPrice` double NOT NULL,
  `idOffer` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`idOrder`, `idEntity`),
  CONSTRAINT `fkEntityOrderItem` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkOfferOrderItem` FOREIGN KEY (`idOffer`) REFERENCES `offer` (`idOffer`))//

DROP PROCEDURE IF EXISTS hub.insertOrderItems//
CREATE PROCEDURE hub.insertOrderItem (IN p_idOrder bigint(20),
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(10))
BEGIN
	INSERT INTO `order-item` (idOrder, idEntity, quantity, totalPrice, idOffer) 
    VALUES (p_idOrder, UUID_TO_BIN(p_idEntity), p_quantity, p_totalPrice, p_idOffer);
	SELECT LAST_INSERT_ID() AS idOrder;
END//
DROP PROCEDURE IF EXISTS hub.selectOrderItems//
CREATE PROCEDURE hub.selectOrderItem (IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idEntity), quantity, totalPrice, idOffer
    FROM `order-item`
    WHERE idOrder = p_idOrder;
END//
DROP PROCEDURE IF EXISTS hub.updateOrderItems//
CREATE PROCEDURE hub.updateOrderItem  (IN p_idOrder bigint(20), 
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(20))
BEGIN
	UPDATE `order-item` 
    SET idEntity = UUID_TO_BIN(p_idEntity), quantity = p_quantity, totalPrice = p_totalPrice, idOffer = p_idOffer
    WHERE idOrder = p_idOrder;
END//
DROP PROCEDURE IF EXISTS hub.deleteOrderItems//
CREATE PROCEDURE hub.deleteOrderItem (IN p_idOrder bigint(20))
BEGIN
	DELETE FROM `order-item` WHERE idOrder = p_idOrder;
END//