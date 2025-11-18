DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertSuggestion//
CREATE PROCEDURE hub.insertSuggestion (IN p_idEntity CHAR(36), IN p_suggestion TEXT)
BEGIN
	INSERT INTO hub.suggestion (idEntity, suggestion, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), p_suggestion, Now());
	SELECT LAST_INSERT_ID() as idSuggestion;
END//
DROP PROCEDURE IF EXISTS hub.selectSuggestion//
CREATE PROCEDURE hub.selectSuggestion (IN p_idSuggestion INT)
BEGIN
	SELECT * FROM hub.suggestion WHERE idSuggestion = p_idSuggestion;
END//
DROP PROCEDURE IF EXISTS hub.selectSuggestionByEntity//
CREATE PROCEDURE hub.selectSuggestionByEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.suggestion WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteSuggestion//
CREATE PROCEDURE hub.deleteSuggestion (IN p_idSuggestion INT)
BEGIN
	DELETE FROM hub.suggestion WHERE idSuggestion = p_idSuggestion;
END//
DELIMITER ;