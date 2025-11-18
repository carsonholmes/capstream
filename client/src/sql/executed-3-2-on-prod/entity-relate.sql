DELIMITER //
DROP PROCEDURE IF EXISTS hub.insertEntityRelate//
CREATE PROCEDURE hub.insertEntityRelate (IN p_idEntity CHAR(36), IN p_idRelated CHAR(36), IN p_relateType INT)
BEGIN
	INSERT INTO `entity-relate` (idEntity, idRelated, relateType) VALUES(UUID_TO_BIN(p_idEntity), UUID_TO_BIN(p_idRelated), p_relateType);
END//
DELIMITER //
DROP PROCEDURE IF EXISTS hub.selectEntityRelate//
CREATE PROCEDURE hub.selectEntityRelate (IN p_idEntity CHAR(36), IN p_relateType INT)
BEGIN
	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, em.fileName, em.mediaType, em.xOffset, em.yOffset, em.scale 
		FROM hub.entity AS e, `entity-media` as em, `entity-relate` as er
		WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia = em.idMedia)
	UNION ALL 
  	(SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, NULL as fileName, NULL as mediaType, 0 as xOffset, 0 as yOffset, 0 as scale
    	FROM hub.entity AS e, `entity-relate` as er
    	WHERE er.idEntity = UUID_TO_BIN(p_idEntity) AND er.relateType = p_relateType AND er.idRelated = e.idEntity AND e.idMedia is NULL);
END//
DROP PROCEDURE IF EXISTS hub.selectEntityRelateByRelated//
CREATE PROCEDURE hub.selectEntityRelateByRelated (IN p_idRelated CHAR(36))
BEGIN
	SELECT * FROM `entity-relate` WHERE idRelated = UUID_TO_BIN(p_idRelated);
END//
DROP PROCEDURE IF EXISTS hub.verifyEntityRelate//
CREATE PROCEDURE hub.verifyEntityRelate (IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	SELECT BIN_TO_UUID(idEntity) as idEntity, relateType, BIN_TO_UUID(idRelated) as idRelated 
	FROM `entity-relate` 
	WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityRelate//
CREATE PROCEDURE hub.deleteEntityRelate (IN p_idEntity CHAR(36), IN p_idRelated CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) AND idRelated = UUID_TO_BIN(p_idRelated);
END//
DROP PROCEDURE IF EXISTS hub.deleteEntityRelateAll//
CREATE PROCEDURE hub.deleteEntityRelateAll (IN p_idEntity CHAR(36))
BEGIN
	DELETE FROM `entity-relate` WHERE idEntity = UUID_TO_BIN(p_idEntity) OR idRelated = UUID_TO_BIN(p_idEntity);
END//
DELIMITER ;