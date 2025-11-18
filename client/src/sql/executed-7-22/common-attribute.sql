DELIMITER //
DROP TABLE IF EXISTS `hub`.`common-attribute`//
CREATE TABLE `hub`.`common-attribute` (
  `idCommonAttribute` int(10) unsigned NOT NULL,
  `idAttribute` int(10) unsigned NOT NULL,
  `idCategory` int(10) unsigned NOT NULL,
  `sortOrder` int(10) NULL,
  `required` bit(1) NULL,
  PRIMARY KEY (`idCommonAttribute`),
  KEY `fkCategory_idx` (`idCategory`),
  KEY `fkAttribute_idx` (`idAttribute`),
  CONSTRAINT `fkAttribute` FOREIGN KEY (`idAttribute`) REFERENCES `attribute` (`idattribute`),
  CONSTRAINT `fkCategory` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idcategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
DROP PROCEDURE IF EXISTS hub.insertCommonAttribute//
CREATE PROCEDURE hub.insertCommonAttribute (IN p_idAttribute INT, IN p_idCategory INT, IN p_sortOrder INT, IN p_required BIT(1))
BEGIN
	INSERT INTO `common-attribute` (idAttribute, idCategory, sortOrder, required) VALUES (p_idAttribute, p_idCategory, p_sortOrder, p_required);
	SELECT LAST_INSERT_ID() as idCommonAttribute;
END//
DROP PROCEDURE IF EXISTS hub.selectCommonAttribute//
CREATE PROCEDURE hub.selectCommonAttribute (IN p_idCommonAttribute INT)
BEGIN
	SELECT idCommonAttribute, idAttribute, idCategory, sortOrder, required
    FROM `common-attribute` where idCommonAttribute = p_idCommonAttribute;
END//
DROP PROCEDURE IF EXISTS hub.selectCommonAttributeByCategory//
CREATE PROCEDURE hub.selectCommonAttributeByCategory (IN p_idCategory INT)
BEGIN
	SELECT idCommonAttribute, idAttribute, idCategory, sortOrder, required
    FROM `common-attribute` where idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.updateCommonAttribute//
CREATE PROCEDURE hub.updateCommonAttribute (IN p_idCommonAttribute INT, IN p_idAttribute INT, IN p_idCategory INT, IN p_sortOrder INT, IN p_required BIT(1))
BEGIN
	UPDATE `common-attribute` SET idAttribute = p_idAttribute, idCategory = p_idCategory, sortOrder = p_sortOrder, required = p_required
	WHERE  idCommonAttribute = p_idCommonAttribute;
END//
DROP PROCEDURE IF EXISTS hub.deleteCommonAttribute//
CREATE PROCEDURE hub.deleteCommonAttribute (IN p_idCommonAttribute INT)
BEGIN
	DELETE FROM `common-attribute` WHERE  idCommonAttribute = p_idCommonAttribute;
END//
