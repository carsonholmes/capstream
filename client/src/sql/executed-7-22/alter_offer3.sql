DELIMITER //
ALTER TABLE `hub`.`offer` 
ADD COLUMN `handlePayment` BIT(1) NOT NULL AFTER `minTimeIncrement`,
ADD COLUMN `depositRequired` TINYINT NOT NULL AFTER `handlePayment` //

DROP PROCEDURE IF EXISTS hub.insertOffer//
CREATE PROCEDURE hub.insertOffer (IN p_idEntity CHAR(36), 
    IN p_offerType smallint, 
    IN p_confirmMethod TINYINT,
    IN p_price float, 
    IN p_rateType smallint, 
    IN p_negotiable bit(1),
    IN p_quantify bit(1),
    IN p_quantity smallint,
    IN p_minTimeIncrement smallint,
    IN p_maxTimeIncrement SMALLINT,
    IN p_startTimeIncrement SMALLINT,
    IN p_bookingLeadNumber SMALLINT,
    IN p_bookingLeadType SMALLINT,
    IN p_cancelLeadNumber SMALLINT,
    IN p_cancelLeadType SMALLINT,
    IN p_cancelFee FLOAT,
    IN p_handlePayment bit(1),
    IN p_depositRequired TINYINT,
    IN p_active bit(1))
BEGIN
	INSERT INTO offer (idEntity, offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, active) 
    VALUES (UUID_TO_BIN(p_idEntity), p_offerType, p_confirmMethod, p_price, p_rateType, p_negotiable, p_quantify, p_quantity, p_minTimeIncrement, p_maxTimeIncrement, p_startTimeIncrement, p_bookingLeadNumber, p_bookingLeadType, p_cancelLeadNumber, p_cancelLeadType, p_cancelFee, p_handlePayment, p_depositRequired, p_active);
  SELECT LAST_INSERT_ID() AS idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectOffer//
CREATE PROCEDURE hub.selectOffer (IN p_idOffer bigint(20))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, active
  FROM offer
  WHERE idOffer = p_idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectOfferForEntity//
CREATE PROCEDURE hub.selectOfferForEntity (IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity,offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, active
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.selectActiveOffer//
CREATE PROCEDURE hub.selectActiveOffer (IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity,offerType, confirmMethod, price, rateType, negotiable, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, handlePayment, depositRequired, active
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity) AND active = 1;
END//
DROP PROCEDURE IF EXISTS hub.updateOffer//
CREATE PROCEDURE hub.updateOffer (IN p_idOffer bigint(20), 
    IN p_idEntity CHAR(36),
    IN p_offerType smallint, 
    IN p_confirmMethod TINYINT,
    IN p_price float, 
    IN p_rateType smallint,
    IN p_negotiable bit(1),
    IN p_quantify bit(1),
    IN p_quantity smallint,
    IN p_minTimeIncrement smallint,
    IN p_maxTimeIncrement SMALLINT,
    IN p_startTimeIncrement SMALLINT,
    IN p_bookingLeadNumber SMALLINT,
    IN p_bookingLeadType SMALLINT,
    IN p_cancelLeadNumber SMALLINT,
    IN p_cancelLeadType SMALLINT,
    IN p_cancelFee FLOAT,
    IN p_handlePayment bit(1),
    IN p_depositRequired TINYINT,
    IN p_active bit(1))
BEGIN
	UPDATE offer 
  SET offerType=p_offerType, confirmMethod=p_confirmMethod, price=p_price, rateType=p_rateType, negotiable=p_negotiable, quantify=p_quantify, quantity=p_quantity,  
    minTimeIncrement=p_minTimeIncrement, maxTimeIncrement = p_maxTimeIncrement, startTimeIncrement = p_startTimeIncrement, 
    bookingLeadNumber = p_bookingLeadNumber, bookingLeadType = p_bookingLeadType, 
    cancelLeadNumber = p_cancelLeadNumber, cancelLeadType = p_cancelLeadType, 
    cancelFee = p_cancelFee, handlePayment = p_handlePayment, depositRequired = p_depositRequired, active=p_active 
  WHERE idOffer = p_idOffer AND idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteOffer//
CREATE PROCEDURE hub.deleteOffer (IN p_idOffer INT)
BEGIN
	DELETE FROM offer WHERE idOffer = p_idOffer;
END//