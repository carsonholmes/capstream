DELIMITER //
DROP TABLE IF EXISTS `hub`.`order-items`//   # run order-items.sql after this
DROP TABLE  IF EXISTS hub.order//  # run order.sql after this
DROP TABLE IF EXISTS hub.offer// 
CREATE TABLE `hub`.`offer` (
  `idOffer` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity`  binary(16) NOT NULL,
  `offerType` smallint NOT NULL,
  `price` float NOT NULL,
  `timeType` smallint NOT NULL,
  `timeIncrMins` smallint NOT NULL,
  `quantify` bit(1) NOT NULL,
  `quantity` smallint NOT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`idOffer`),
  UNIQUE INDEX `idOffer_UNIQUE` (`idOffer` ASC) VISIBLE,
  CONSTRAINT `fkEntityOffer` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
  
DROP PROCEDURE IF EXISTS hub.insertOffer//
CREATE PROCEDURE hub.insertOffer (IN p_idEntity CHAR(36), 
    IN p_offerType smallint, 
    IN p_price float, 
    IN p_timeType smallint, 
    IN p_timeIncrMins smallint,
    IN p_quantify bit(1),
    IN p_quantity smallint,
    IN p_active bit(1))
BEGIN
	INSERT INTO offer (idEntity, offerType, price, timeType, timeIncrMins, quantify, quantity, active) 
    VALUES (UUID_TO_BIN(p_idEntity), p_offerType, p_price, p_timeType, p_timeIncrMins, p_quantify, p_quantity, p_active);
  SELECT LAST_INSERT_ID() AS idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectOffer//
CREATE PROCEDURE hub.selectOffer (IN p_idOffer bigint(20))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, price, timeType, timeIncrMins, quantify, quantity, active
  FROM offer
  WHERE idOffer = p_idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectActiveOffer//
CREATE PROCEDURE hub.selectActiveOffer (IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, price, timeType, timeIncrMins, quantify, quantity, active
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity) AND active = 1;
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
END//
DROP PROCEDURE IF EXISTS hub.deleteOffer//
CREATE PROCEDURE hub.deleteOffer (IN p_idOffer INT)
BEGIN
	DELETE FROM offer WHERE idOffer = p_idOffer;
END//