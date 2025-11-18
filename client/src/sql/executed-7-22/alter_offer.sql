DELIMITER //
ALTER TABLE `hub`.`offer` 
ADD COLUMN `confirmMethod` TINYINT NOT NULL AFTER `offerType`,
ADD COLUMN `maxTimeIncrement` SMALLINT NULL AFTER `minTimeIncrement`,
ADD COLUMN `startTimeIncrement` SMALLINT NULL AFTER `maxTimeIncrement`,
ADD COLUMN `bookingLeadNumber` SMALLINT NULL AFTER `startTimeIncrement`,
ADD COLUMN `bookingLeadType` TINYINT NULL AFTER `bookingLeadNumber`,
ADD COLUMN `cancelLeadNumber` SMALLINT NULL AFTER `bookingLeadNumber`,
ADD COLUMN `cancelLeadType` TINYINT NULL AFTER `cancelLeadNumber`,
ADD COLUMN `cancelFee` FLOAT NULL AFTER `cancelLeadNumber`,
CHANGE COLUMN `timeIncrMins` `minTimeIncrement` SMALLINT NULL AFTER `quantity`,
CHANGE COLUMN `timeType` `rateType` SMALLINT NOT NULL ,
CHANGE COLUMN `quantify` `quantify` BIT(1) NULL //

DROP PROCEDURE IF EXISTS hub.insertOffer//
CREATE PROCEDURE hub.insertOffer (IN p_idEntity CHAR(36), 
    IN p_offerType smallint, 
    IN p_confirmMethod TINYINT,
    IN p_price float, 
    IN p_rateType smallint, 
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
    IN p_active bit(1))
BEGIN
	INSERT INTO offer (idEntity, offerType, confirmMethod, price, rateType, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, active) 
    VALUES (UUID_TO_BIN(p_idEntity), p_offerType, p_confirmMethod, p_price, p_rateType, p_quantify, p_quantity, p_minTimeIncrement, p_maxTimeIncrement, p_startTimeIncrement, p_bookingLeadNumber, p_bookingLeadType, p_cancelLeadNumber, p_cancelLeadType, p_cancelFee, p_active);
  SELECT LAST_INSERT_ID() AS idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectOffer//
CREATE PROCEDURE hub.selectOffer (IN p_idOffer bigint(20))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity, offerType, confirmMethod, price, rateType, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, active
  FROM offer
  WHERE idOffer = p_idOffer;
END//
DROP PROCEDURE IF EXISTS hub.selectActiveOffer//
CREATE PROCEDURE hub.selectActiveOffer (IN p_idEntity CHAR(36))
BEGIN
	SELECT idOffer, BIN_TO_UUID(idEntity) AS idEntity,offerType, confirmMethod, price, rateType, quantify, quantity, minTimeIncrement, maxTimeIncrement, startTimeIncrement, bookingLeadNumber, bookingLeadType, cancelLeadNumber, cancelLeadType, cancelFee, active
  FROM offer
  WHERE idEntity = UUID_TO_BIN(p_idEntity) AND active = 1;
END//
DROP PROCEDURE IF EXISTS hub.updateOffer//
CREATE PROCEDURE hub.updateOffer (IN p_idOffer bigint(20), 
    IN p_offerType smallint, 
    IN p_confirmMethod TINYINT,
    IN p_price float, 
    IN p_rateType smallint, 
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
    IN p_active bit(1))
BEGIN
	UPDATE offer 
  SET offerType=p_offerType, confirmMethod=p_confirmMethod, price=p_price, rateType=p_rateType, quantify=p_quantify, quantity=p_quantity,  
    minTimeIncrement=p_minTimeIncrement, maxTimeIncrement = p_maxTimeIncrement, startTimeIncrement = p_startTimeIncrement, 
    bookingLeadNumber = p_bookingLeadNumber, bookingLeadType = p_bookingLeadType, 
    cancelLeadNumber = p_cancelLeadNumber, cancelLeadType = p_cancelLeadType, 
    cancelFee = p_cancelFee, active=p_active 
  WHERE idOffer = p_idOffer AND idEntity = UUID_TO_BIN(p_idEntity);
END//
DROP PROCEDURE IF EXISTS hub.deleteOffer//
CREATE PROCEDURE hub.deleteOffer (IN p_idOffer INT)
BEGIN
	DELETE FROM offer WHERE idOffer = p_idOffer;
END//