DELIMITER //
DROP TABLE IF EXISTS `hub`.`common-attribute`//
DROP TABLE IF EXISTS `hub`.`entity-category` //
DROP TABLE IF EXISTS `hub`.`category`//
CREATE TABLE `hub`.`category` (
  `idCategory` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idParent` int(10) unsigned NOT NULL,
  `catLevel` int(10) NOT NULL,
  `catDesc` varchar(1024) NOT NULL,
  `entityType` int NOT NULL,
  `idSuggestor` binary(16) NULL,
  `approved` bit(1) NULL DEFAULT 0,
  PRIMARY KEY (`idCategory`),
  UNIQUE KEY `idCategory_UNIQUE` (`idCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci//
ALTER TABLE hub.category AUTO_INCREMENT=101 //
DROP PROCEDURE IF EXISTS hub.insertCategory//
CREATE PROCEDURE hub.insertCategory (IN p_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_entityType INT, p_idSuggestor CHAR(36))
BEGIN
	INSERT INTO hub.category (idParent, catDesc, catLevel, entityType, idSuggestor) VALUES(p_idParent, p_catDesc, p_catLevel, p_entityType, UUID_TO_BIN(p_idSuggestor));
	SELECT LAST_INSERT_ID() as idCategory;
END//
DROP PROCEDURE IF EXISTS hub.selectCategory//
CREATE PROCEDURE hub.selectCategory (IN p_idCategory INT)
BEGIN
	SELECT idCategory, idParent, catDesc, catLevel, entityType, BIN_TO_UUID(idSuggestor) as idSuggestor
	FROM hub.category where idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.selectCategoryByType//
CREATE PROCEDURE hub.selectCategoryByType (IN p_entityType INT)
BEGIN
	SELECT idCategory, idParent, catDesc, catLevel, entityType, BIN_TO_UUID(idSuggestor) as idSuggestor
	FROM hub.category where entityType = p_entityType ORDER BY catLevel ASC, catDesc ASC;
END//
DROP PROCEDURE IF EXISTS hub.updateCategory//
CREATE PROCEDURE hub.updateCategory (IN p_idCategory INT, IN p_idParent INT, IN p_catDesc VARCHAR(1024), IN p_catLevel INT, IN p_entityType INT, p_idSuggestor CHAR(36))
BEGIN
	UPDATE hub.category SET idParent = p_idParent, catDesc = p_catDesc, catLevel = p_catLevel, entityType = p_entityType, idSuggestor = UUID_TO_BIN(p_idSuggestor)
	WHERE  idCategory = p_idCategory;
END//
DROP PROCEDURE IF EXISTS hub.deleteCategory//
CREATE PROCEDURE hub.deleteCategory (IN p_idCategory INT)
BEGIN
	DELETE FROM hub.category WHERE  idCategory = p_idCategory;
END//