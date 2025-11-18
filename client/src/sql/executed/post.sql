DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertPost//
CREATE PROCEDURE hub.insertPost (IN p_idEntity CHAR(36), IN p_idUser CHAR(36), IN p_postText TEXT)
BEGIN
	INSERT INTO hub.post (idEntity, idUser, postText, dtCreated) VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idUser), p_postText, Now());
END//
DROP PROCEDURE IF EXISTS hub.selectPost//
CREATE PROCEDURE hub.selectPost (IN p_idEntity CHAR(36))
BEGIN
	SELECT * FROM hub.post where idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.selectPostByUser//
CREATE PROCEDURE hub.selectPostByUser (IN p_idUser CHAR(36))
BEGIN
	SELECT * FROM hub.post where idUser = UUID_TO_BIN(p_idUser);
END//
DROP PROCEDURE IF EXISTS hub.updatePost//
CREATE PROCEDURE hub.updatePost (IN p_idEntity CHAR(36), IN p_postText TEXT)
BEGIN
	UPDATE hub.post SET postText = p_postText, dtLastEdited = Now() WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deletePost//
CREATE PROCEDURE hub.deletePost (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM hub.post WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DELIMITER ;