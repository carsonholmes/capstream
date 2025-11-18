DELIMITER //
DROP TABLE  IF EXISTS `hub`.`credit-card`//

CREATE TABLE `hub`.`credit-card` (
  `idCreditCard` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` varchar(16) NOT NULL,
  `expiration` DATE NOT NULL,
  `ccv` varchar(4) NOT NULL,
  `idAddressBilling` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`idCreditCard`),
  CONSTRAINT `fkAddressCreditCard` FOREIGN KEY (`idAddressBilling`) REFERENCES `address` (`idAddress`))//

DROP PROCEDURE IF EXISTS hub.insertCreditCard//
CREATE PROCEDURE hub.insertCreditCard (IN p_number varchar(16), 
    IN p_expiration date, 
    IN p_ccv varchar(4), 
    IN p_idAddressBilling bigint(20))
BEGIN
	INSERT INTO `credit-card` (number, expiration, ccv, idAddressBilling) 
    VALUES (p_number, p_expiration, p_ccv, p_idAddressBilling);
	SELECT LAST_INSERT_ID() AS idCreditCard;
END//
DROP PROCEDURE IF EXISTS hub.selectCreditCard//
CREATE PROCEDURE hub.selectCreditCard (IN p_idCreditCard bigint(20))
BEGIN
	SELECT idCreditCard, number, expiration, ccv, idAddressBilling
    FROM `credit-card`
    WHERE idCreditCard = p_idCreditCard;
END//
DROP PROCEDURE IF EXISTS hub.updateCreditCard//
CREATE PROCEDURE hub.updateCreditCard  (IN p_idCreditCard bigint(20), 
    IN p_number varchar(16), 
    IN p_expiration date, 
    IN p_ccv varchar(4), 
    IN p_idAddressBilling bigint(20))
BEGIN
	UPDATE `credit-card` 
    SET number = p_number, expiration = p_expiration, ccv = p_ccv, idAddressBilling = p_idAddressBilling
    WHERE idCreditCard = p_idCreditCard;
END//
DROP PROCEDURE IF EXISTS hub.deleteCreditCard//
CREATE PROCEDURE hub.deleteCreditCard (IN p_idCreditCard bigint(20))
BEGIN
	DELETE FROM `credit-card` WHERE idCreditCard = p_idCreditCard;
END//