DELIMITER //
DROP TABLE IF EXISTS hub.offer//
CREATE TABLE `hub`.`offer` (
  `idOffer` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEntity`  BINARY(16) NOT NULL,
  `offerType` INT NOT NULL,
  `price` FLOAT NOT NULL,
  `timeType` INT NOT NULL,
  `timeIncrMins` INT NOT NULL,
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`idOffer`),
  UNIQUE INDEX `idOffer_UNIQUE` (`idOffer` ASC) VISIBLE,
  CONSTRAINT `fkEntityOffer` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`event` (
  `idEntity`  BINARY(16) NOT NULL,
  `eventType` INT NOT NULL,
  `dtStart` DATETIME NOT NULL,
  `dtEnd` DATETIME DEFAULT NULL,
  `allDay` bit(1) NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityEvent` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`group` (
  `idEntity`  BINARY(16) NOT NULL,
  `groupType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityGroup` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
CREATE TABLE `hub`.`place` (
  `idEntity`  BINARY(16) NOT NULL,
  `placeType` INT NOT NULL,
  PRIMARY KEY (`idEntity`),
  UNIQUE KEY `idEntity_UNIQUE` (`idEntity`),
  CONSTRAINT `fkEntityPlace` FOREIGN KEY (`idEntity`) REFERENCES `entity` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
