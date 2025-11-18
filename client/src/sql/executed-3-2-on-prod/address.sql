DELIMITER //
DROP TABLE IF EXISTS hub.address//
CREATE TABLE `hub`.`address` (
  `idAddress`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `idLocation`  bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`idAddress`),
  CONSTRAINT `fkLocationAddress` FOREIGN KEY (`idLocation`) REFERENCES `location` (`idLocation`)
)//

DROP PROCEDURE IF EXISTS hub.insertAddress//
CREATE PROCEDURE hub.insertAddress (IN p_name varchar(100), 
    IN p_idLocation bigint(20))
BEGIN
	INSERT INTO hub.address (name, idLocation) 
    VALUES (p_name, p_idLocation);
	SELECT LAST_INSERT_ID() AS idAddress;
END//
DROP PROCEDURE IF EXISTS hub.selectAddress//
CREATE PROCEDURE hub.selectAddress (IN p_idAddress bigint(20))
BEGIN
	SELECT idAddress, name, idLocation 
    FROM hub.address
    WHERE idAddress = p_idAddress;
END//
DROP PROCEDURE IF EXISTS hub.updateAddress//
CREATE PROCEDURE hub.updateAddress  (IN p_idAddress bigint(20), 
    IN p_name varchar(100), 
    IN p_idLocation  bigint(20))
BEGIN
	UPDATE hub.address 
    SET name = p_name, idLocation = p_idLocation 
    WHERE idAddress = p_idAddress;
END//
DROP PROCEDURE IF EXISTS hub.deleteAddress//
CREATE PROCEDURE hub.deleteAddress (IN p_idAddress BIGINT)
BEGIN
	DELETE FROM hub.address WHERE idAddress = p_idAddress;
END//