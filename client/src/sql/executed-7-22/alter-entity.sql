DELIMITER //
DROP PROCEDURE IF EXISTS hub.selectEntityByOwner//
CREATE PROCEDURE hub.selectEntityByOwner(IN p_idEntity CHAR(36), IN p_entityType INT)
BEGIN
	SELECT BIN_TO_UUID(e.idEntity) AS idEntity, e.entityTitle, e.entityDesc, e.entityType, e.idMedia, e.dtCreated, e.dtLastEdited, 
    o.idOffer, o.offerType, o.confirmMethod, o.price, o.rateType, o.negotiable, o.quantify, o.quantity, 
	o.minTimeIncrement, o.maxTimeIncrement, o.startTimeIncrement, o.bookingLeadNumber, o.bookingLeadType,
	o.cancelLeadNumber, o.cancelLeadType, o.cancelFee, o.handlePayment, o.depositRequired, o.cancelPolicyOn, o.cancelFeeType, o.depositAmountType, o.depositAmount
	FROM entity AS e 
		RIGHT JOIN `entity-relate` AS er ON er.idEntity = e.idEntity
		LEFT OUTER JOIN offer AS o ON o.idEntity = e.idEntity
	WHERE idRelated = UUID_TO_BIN(p_idEntity) AND er.relateType = 1 AND entityType = p_entityType
	ORDER BY dtCreated DESC;
END //
DELIMITER ;