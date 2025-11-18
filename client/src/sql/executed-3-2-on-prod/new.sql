DELIMITER //
CREATE TABLE `hub`.`cart` (
  `idEntity` BINARY(16) NOT NULL,
  `idUser` BINARY(16) NOT NULL,
  `quantity` INT UNSIGNED NULL,
  `idOffer` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idEntity`, `idUser`),
  CONSTRAINT `fkEntityCart` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`),
  CONSTRAINT `fkUserCart` FOREIGN KEY (`idUser`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertCart//
CREATE PROCEDURE hub.insertCart (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_idOffer INT(10))
BEGIN
	INSERT INTO cart (idUser, idEntity, quantity, idOffer) VALUES(UUID_TO_BIN(p_idUser), UUID_TO_BIN(p_idEntity), p_quantity, p_idOffer);
END//
DROP PROCEDURE IF EXISTS hub.selectCart//
CREATE PROCEDURE hub.selectCart (IN p_idUser CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) AS idEntity, BIN_TO_UUID(idUser) AS idUser, quantity, idOffer
    	FROM cart as c
    	WHERE c.idUser = UUID_TO_BIN(p_idUser);
END//
DROP PROCEDURE IF EXISTS hub.updateCartItem//
CREATE PROCEDURE hub.updateCartItem (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_quantity INT, IN p_idOffer INT(10))
BEGIN
	UPDATE cart SET quantity=p_quantity, idOffer=p_idOffer WHERE idUser = UUID_TO_BIN(p_idUser) AND idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteCartItem//
CREATE PROCEDURE hub.deleteCartItem (IN p_idUser CHAR(36), IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM cart WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idUser = UUID_TO_BIN(p_idUser);
END//
DROP PROCEDURE IF EXISTS hub.deleteCart//
CREATE PROCEDURE hub.deleteCart (IN p_idUser CHAR(36))
BEGIN
	DELETE FROM cart WHERE idUser = UUID_TO_BIN(p_idUser);
END//

DROP PROCEDURE IF EXISTS hub.insertOffer//
CREATE PROCEDURE hub.insertOffer (IN p_idEntity CHAR(36), IN p_offerType INT, IN p_price FLOAT, IN p_timeType INT, IN p_timeIncrMins INT, IN p_active BIT(1))
BEGIN
	INSERT INTO offer (idEntity, offerType, price, timeType, timeIncrMins, active) VALUES(UUID_TO_BIN(p_idEntity), p_offerType, p_price, p_timeType, p_timeIncrMins, p_active);
  SELECT LAST_INSERT_ID() AS idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectOffer//
CREATE PROCEDURE hub.selectOffer (IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, price, timeType, timeIncrMins, active
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updateOffer//
CREATE PROCEDURE hub.updateOffer (IN p_idOffer INT, IN p_offerType INT, IN p_price FLOAT, IN p_timeType INT, IN p_timeIncrMins INT, IN p_active BIT(1))
BEGIN
	UPDATE offer 
  SET offerType=p_offertType, price=p_price, timeType=p_timeType, timeIncrMins=p_timeIncrMins, active=p_active 
  WHERE idOffer = p_idOffer;
END//
DROP PROCEDURE IF EXISTS hub.deleteOffer//
CREATE PROCEDURE hub.deleteOffer (IN p_idOffer INT)
BEGIN
	DELETE FROM offer WHERE idOffer = p_idOffer;
END//
