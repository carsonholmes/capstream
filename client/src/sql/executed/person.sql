DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertPerson//
CREATE PROCEDURE hub.insertPerson (IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	INSERT INTO hub.person (idEntity, personFirstName, personLastName) VALUES(UUID_TO_BIN(p_idEntity), p_personFirstName, p_personLastName);
END//
DROP PROCEDURE IF EXISTS hub.selectPerson//
CREATE PROCEDURE hub.selectPerson (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.person where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.updatePerson//
CREATE PROCEDURE hub.updatePerson (IN p_idEntity CHAR(36), IN p_personFirstName VARCHAR(128), IN p_personLastName VARCHAR(128))
BEGIN
	UPDATE hub.person SET personFirstName = p_personFirstName, personLastName = p_personLastName WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deletePerson//
CREATE PROCEDURE hub.deletePerson (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.person WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DELIMITER ;