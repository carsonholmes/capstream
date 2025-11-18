DELIMITER //
DROP PROCEDURE IF EXISTS hub.selectUserEvents//
CREATE PROCEDURE hub.selectUserEvents (IN p_idEntity CHAR(36))
BEGIN
	(SELECT idEvent, 
            BIN_TO_UUID(idEntity) as idEntity,
            eventType,
            dtStart,
            dtEnd,
            allDay,
            repeatType,
            repeatTimeFrame,
            repeatMonthlyType,
            repeatInterval,
            repeatSun,
            repeatMon,
            repeatTue,
            repeatWed,
            repeatThu,
            repeatFri,
            repeatSat,
            repeatEndType,
            repeatEnd,
            repeatOccurences,
            allServices,
            null as idBooking,
            null as idAvailability,
            null as idConsumer,
            null as consumerTitle,
            null as idService,
            null as confirmed
    FROM hub.event
    WHERE idEntity = UUID_TO_BIN(p_idEntity) AND eventType < 2)
    UNION ALL 
    (SELECT e.idEvent, 
            BIN_TO_UUID(e.idEntity) as idEntity,
            eventType,
            dtStart,
            dtEnd,
            allDay,
            repeatType,
            repeatTimeFrame,
            repeatMonthlyType,
            repeatInterval,
            repeatSun,
            repeatMon,
            repeatTue,
            repeatWed,
            repeatThu,
            repeatFri,
            repeatSat,
            repeatEndType,
            repeatEnd,
            repeatOccurences,
            allServices,
            idBooking,
            idAvailability,
            BIN_TO_UUID(idConsumer) as idConsumer,
            en.entityTitle as consumerTitle,
            BIN_TO_UUID(idService) as idService,
            confirmed
    FROM hub.event AS e, hub.booking AS b, entity AS en
    WHERE e.idEntity = UUID_TO_BIN(p_idEntity) AND eventType = 3 AND e.idEvent = b.idEvent AND en.idEntity = b.idConsumer AND confirmed <> 2)
    ORDER BY eventType ASC, dtStart ASC, dtEnd ASC, idService ASC;
END//
DROP PROCEDURE IF EXISTS hub.selectProviderUnconfirmedCount//
CREATE PROCEDURE hub.selectProviderUnconfirmedCount (IN p_idEntity CHAR(36))
BEGIN
    SELECT COUNT(e.idEvent) as unconfirmedBookings
    FROM hub.event AS e, hub.booking AS b
    WHERE e.idEntity = UUID_TO_BIN(p_idEntity) AND eventType = 3 AND e.idEvent = b.idEvent AND confirmed = 0;    
END//
