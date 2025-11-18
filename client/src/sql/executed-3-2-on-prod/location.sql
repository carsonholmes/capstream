DELIMITER //
DROP TABLE  IF EXISTS hub.location//
CREATE TABLE hub.location (
  `idLocation` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressLine1` varchar(255) NOT NULL,
  `addressLine2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `idProvince` int(10) unsigned NOT NULL,
  `idCountry` int(10) unsigned NOT NULL,
  `postalCode` varchar(12) NOT NULL,
  PRIMARY KEY (`idLocation`),
  UNIQUE KEY `idLocation_UNIQUE` (`idLocation`),
  CONSTRAINT `fkLocationProvince` FOREIGN KEY (`idProvince`) REFERENCES `province` (`idProvince`),
  CONSTRAINT `fkLocationCountry` FOREIGN KEY (`idCountry`) REFERENCES `country` (`idCountry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//

DROP PROCEDURE IF EXISTS hub.insertLocation//
CREATE PROCEDURE hub.insertLocation (IN p_addressLine1 varchar(255), 
    IN p_addressLine2 varchar(255), 
    IN p_city varchar(255), 
    IN p_idProvince int(10), 
    IN p_idCountry int(10),
    IN p_postalCode varchar(12))
BEGIN
	INSERT INTO hub.location (addressLine1, addressLine2, city, idProvince, idCountry, postalCode) 
    VALUES (p_addressLine1, p_addressLine2, p_city, p_idProvince, p_idCountry, p_postalCode);
	SELECT LAST_INSERT_ID() AS idLocation;
END//
DROP PROCEDURE IF EXISTS hub.selectLocation//
CREATE PROCEDURE hub.selectLocation (IN p_idLocation bigint(20))
BEGIN
	SELECT idLocation, addressLine1, addressLine2, city, idProvince, idCountry, postalCode 
    FROM hub.location
    WHERE idLocation = p_idLocation;
END//
DROP PROCEDURE IF EXISTS hub.updateLocation//
CREATE PROCEDURE hub.updateLocation  (IN p_idLocation bigint(20), 
    IN p_addressLine1 varchar(255), 
    IN p_addressLine2 varchar(255), 
    IN p_city varchar(255), 
    IN p_idProvince int(10), 
    IN p_idCountry int(10),
    IN p_postalCode varchar(12))
BEGIN
	UPDATE hub.location 
    SET addressLine1 = p_addressLine1, addressLine2 = p_addressLine2, city = p_city, 
        idProvince = p_idProvince, idCountry = p_idCountry, postalCode = p_postalCode 
    WHERE idLocation = p_idLocation;
END//
DROP PROCEDURE IF EXISTS hub.deleteLocation//
CREATE PROCEDURE hub.deleteLocation (IN p_idLocation BIGINT)
BEGIN
	DELETE FROM hub.location WHERE idLocation = p_idLocation;
END//