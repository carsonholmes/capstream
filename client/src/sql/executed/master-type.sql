DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertMasterType//
CREATE PROCEDURE hub.insertMasterType (IN p_table VARCHAR(100), IN p_column VARCHAR(100), IN p_value VARCHAR(255), IN p_code VARCHAR(45))
BEGIN
	INSERT INTO `master-type` (`table`, `column`, `value`, `code`) VALUES (p_table, p_column, p_value, p_code);
	SELECT LAST_INSERT_ID() as idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.selectMasterType//
CREATE PROCEDURE hub.selectMasterType (IN p_idMasterType INT)
BEGIN
	SELECT * FROM `master-type` where idMasterType = p_idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.selectMasterTypeByValue//
CREATE PROCEDURE hub.selectMasterTypeByValue (IN p_value VARCHAR(255))
BEGIN
	SELECT * FROM `master-type` where `value` = p_value;
END//
DROP PROCEDURE IF EXISTS hub.updateMasterType//
CREATE PROCEDURE hub.updateMasterType (IN p_idMasterType INT, IN p_attrDesc VARCHAR(1024), IN p_attrType INT, IN p_idSuggestor CHAR(36))
BEGIN
	UPDATE `master-type` SET `table` = p_table, `column` = p_column, `value` = p_value, `code` = p_code
	WHERE  idMasterType = p_idMasterType;
END//
DROP PROCEDURE IF EXISTS hub.deleteMasterType//
CREATE PROCEDURE hub.deleteMasterType (IN p_idMasterType INT)
BEGIN
	DELETE FROM `master-type` WHERE  idMasterType = p_idMasterType;
END//
DELIMITER ;