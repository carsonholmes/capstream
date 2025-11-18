DELIMITER //
DROP TABLE  IF EXISTS hub.order//
CREATE TABLE `hub`.`order` (
  `idOrder` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUser` binary(16) NOT NULL,
  `idAddress` bigint(20) UNSIGNED NULL,
  `idCreditCard` bigint(20) UNSIGNED NULL,
  `state` tinyint NOT NULL,
  `inventoryLockTime` datetime NULL,
  PRIMARY KEY (`idOrder`),
  UNIQUE INDEX `idOrder_UNIQUE` (`idOrder` ASC) VISIBLE, 
  CONSTRAINT `fkUserOrder` FOREIGN KEY (`idUser`) REFERENCES `entity` (`idEntity`),
  CONSTRAINT `fkAddressOrder` FOREIGN KEY (`idAddress`) REFERENCES `address` (`idAddress`),
  CONSTRAINT `fkCreditCardOrder` FOREIGN KEY (`idCreditCard`) REFERENCES `credit-card` (`idCreditCard`))//

DROP PROCEDURE IF EXISTS hub.insertOrder//
CREATE PROCEDURE hub.insertOrder (IN p_idUser char(36), IN p_state tinyint)
BEGIN
	INSERT INTO hub.order (idUser, state) 
    VALUES (UUID_TO_BIN(p_idUser), p_state);
	SELECT LAST_INSERT_ID() AS idOrder;
END//
DROP PROCEDURE IF EXISTS hub.selectOrder//
CREATE PROCEDURE hub.selectOrder (IN p_idOrder bigint(20))
BEGIN
	SELECT idOrder, BIN_TO_UUID(idUser) as idUser, idAddress, idCreditCard, state, inventoryLockTime
    FROM hub.order
    WHERE idOrder = p_idOrder;
END//
DROP PROCEDURE IF EXISTS hub.updateOrder//
CREATE PROCEDURE hub.updateOrder  (IN p_idOrder bigint(20), 
    IN p_idUser char(36), 
    IN p_idAddress bigint(20), 
    IN p_idCreditCard bigint(20), 
    IN p_state tinyint, 
    IN p_inventoryLockTime datetime)
BEGIN
	UPDATE hub.order 
    SET idUser = UUID_TO_BIN(p_idUser), idAddress = p_idAddress, idCreditCard = p_idCreditCard, 
        state = p_state, inventoryLockTime = p_inventoryLockTime 
    WHERE idOrder = p_idOrder;
END//
DROP PROCEDURE IF EXISTS hub.deleteOrder//
CREATE PROCEDURE hub.deleteOrder (IN p_idOrder BIGINT)
BEGIN
	DELETE FROM hub.order WHERE idOrder = p_idOrder;
END//