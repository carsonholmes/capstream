DELIMITER //
DROP TABLE IF EXISTS `hub`.`order-item`//

CREATE TABLE `hub`.`order-item` (
  `idOrder` bigint(20) UNSIGNED NOT NULL,
  `idEntity` binary(16) NOT NULL,
  `quantity` smallint NOT NULL,
  `totalPrice` double NOT NULL,
  `idOffer` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`idOrder`, `idEntity`),
  CONSTRAINT `fkEntityOrderItem` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkOfferOrderItem` FOREIGN KEY (`idOffer`) REFERENCES `offer` (`idOffer`))//

DROP PROCEDURE IF EXISTS hub.insertOrderItem//
CREATE PROCEDURE hub.insertOrderItem (IN p_idOrder bigint(20),
    IN p_idEntity char(36), 
    IN p_quantity smallint, 
    IN p_totalPrice double, 
    IN p_idOffer bigint(10))
BEGIN
	INSERT INTO `order-item` (idOrder, idEntity, quantity, totalPrice, idOffer) 
    VALUES (p_idOrder, UUID_TO_BIN(p_idEntity), p_quantity, p_totalPrice, p_idOffer);
END//
DROP PROCEDURE IF EXISTS hub.selectOrderItem//
CREATE PROCEDURE hub.selectOrderItem (IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idEntity), quantity, totalPrice, idOffer
    FROM `order-item`
    WHERE idOrder = p_idOrder;
END//
DROP PROCEDURE IF EXISTS hub.updateOrderItem//
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
DROP PROCEDURE IF EXISTS hub.deleteOrderItem//
CREATE PROCEDURE hub.deleteOrderItem (IN p_idOrder bigint(20))
BEGIN
	DELETE FROM `order-item` WHERE idOrder = p_idOrder;
END//