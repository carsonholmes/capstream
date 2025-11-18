DELIMITER //
CREATE PROCEDURE hub.insertEntity (IN title VARCHAR(255), OUT idEntity INT(10))
BEGIN
	INSERT INTO hub.entity (entityTitle, dtCreated) VALUES(title, Now());
	SELECT LAST_INSERT_ID() into idEntity;
END//
CREATE PROCEDURE hub.updateEntity (IN idUser INT(10), IN entityTitle VARCHAR(255))
BEGIN
	UPDATE hub.entity SET entityTitle = entityTitle WHERE idEntity = idUser;
END//
CREATE PROCEDURE `insertEmail`(IN idEntity INT(10),
									IN emailAddress VARCHAR(320),
									IN emailVerified TINYINT(1),
                                    IN emailVerifyCode CHAR(6),
                                    OUT idEmail INT(10))
BEGIN
	INSERT INTO hub.email (idEntity, emailAddress, emailVerified, emailVerifyCode) VALUES(idEntity, emailAddress, emailVerified, emailVerifyCode);
    SELECT LAST_INSERT_ID() into idEmail;
END//
CREATE PROCEDURE hub.insertPerson (IN idEntity INT(10),
									IN personFirstName VARCHAR(128),
									IN personLastName VARCHAR(128))
BEGIN
	INSERT INTO hub.person (idEntity, personFirstName, personLastName) VALUES(idEntity, personFirstName, personLastName);
END//
CREATE PROCEDURE hub.updatePerson (IN idUser INT(10),
									IN personFirstName VARCHAR(128),
									IN personLastName VARCHAR(128))
BEGIN
	UPDATE hub.person SET personFirstName = personFirstName, personLastName = personLastName WHERE idEntity = idUser;
END//
CREATE PROCEDURE hub.insertUser (IN userName VARCHAR(64), 
								                IN userPassword VARCHAR(128),
                                IN userSalt VARCHAR(128),
                                IN personFirstName VARCHAR(128),
                                IN personLastName VARCHAR(128),
                                IN emailAddress VARCHAR(320))
BEGIN
  SET @space = '';
  IF LENGTH(personFirstName) > 0 AND LENGTH(personLastName) > 0 THEN
    SET @space = ' ';
  END IF;
	CALL hub.insertEntity(CONCAT(personFirstName, @space, personLastName), @idEntity);
  CALL verifyCode( @verifyCode);
	CALL hub.insertEmail(@idEntity, emailAddress, False, @verifyCode, @idEmail);
	INSERT INTO hub.user (idEntity, userName, userPassword, userSalt, userPrimaryEmail) VALUES(@idEntity, userName, userPassword, userSalt, @idEmail);
  CALL hub.insertPerson(@idEntity, personFirstName, personLastName);
  CALL createSessionOutParam( @idEntity, @idSession);
  SELECT @idEntity as idEntity, userName, emailAddress, @verifyCode as verifyCode, @idSession as idSession;
END//
CREATE PROCEDURE hub.updateUser (IN idUser INT(10),
                                IN userName VARCHAR(64), 
								                IN personFirstName VARCHAR(128),
                                IN personLastName VARCHAR(128),
                                IN entityTitle VARCHAR(255))
BEGIN
	CALL hub.updateEntity(idUser, entityTitle);
  CALL hub.updatePerson(idUser, personFirstName, personLastName);
  UPDATE hub.user SET userName = userName WHERE idEntity = idUser;
END//
CREATE PROCEDURE `verifyCode` (OUT verifyCode CHAR(6))
BEGIN
	DECLARE seed DECIMAL DEFAULT CONVERT(TIME(CURRENT_TIMESTAMP), DECIMAL);
  SELECT LPAD(ROUND(RAND(seed*seed*13)*1000000,0),6,0) INTO verifyCode;
END//
CREATE PROCEDURE hub.verifySession (IN idUser INT(10), 
                                    IN idSesh VARCHAR(32))
BEGIN
  SET @dtActive = 0;
  SELECT dtActive 
  FROM `user-session` 
  WHERE idSession = idSesh
  AND idEntity = idUser 
  AND done = 0 
  INTO @dtActive;
  IF @dtActive != 0 THEN
    IF @dtActive > DATE_ADD( Now(), INTERVAL -240 MINUTE) THEN
      UPDATE `user-session` 
      SET dtActive = Now() 
      WHERE idSession = @idSesh
      AND idEntity = idUser 
      AND done = 0;
      SELECT 'Valid' as messageText;
    ELSE
      SELECT 'Expired' as messageText;
    END IF;
  ELSE
    SELECT 'Invalid' as messageText;
  END IF;
END//
CREATE PROCEDURE hub.verifyEmail (IN idUser INT(10), 
								  IN emailAddress VARCHAR(320),
                                  IN verifyCode CHAR(6))
BEGIN
	SELECT e.emailVerifyCode, e.idEmail 
    FROM hub.user AS u, hub.email AS e 
    WHERE u.idEntity = idUser 
      AND u.userPrimaryEmail = e.idEmail
      AND e.emailAddress = emailAddress 
	INTO @verifyCode, @idEmail;
    IF @verifyCode = verifyCode THEN
		UPDATE hub.email AS e SET emailVerified = True
		WHERE e.idEmail = @idEmail;
		SELECT "Success" INTO @response;
	ELSE
		SELECT "Failed" INTO @response;
    END IF;
	SELECT @response as response;
END//
CREATE PROCEDURE hub.resendEmail (IN idUser INT(10), 
								  IN emailAddress VARCHAR(320))
BEGIN
	SELECT e.idEmail 
    FROM hub.user AS u, hub.email AS e 
    WHERE u.idEntity = idUser 
      AND u.userPrimaryEmail = e.idEmail
      AND e.emailAddress = emailAddress 
	INTO @idEmail;
    CALL verifyCode( @verifyCode);
	UPDATE hub.email SET emailVerifyCode = @verifyCode
		WHERE idEmail = @idEmail;
	SELECT @verifyCode as verifyCode;
END//
CREATE PROCEDURE hub.checkUserName (IN usrName VARCHAR(64))
BEGIN
	SELECT u.userName
    FROM hub.user AS u
    WHERE u.userName = usrName
    LIMIT 1
	INTO @userName;
  IF @userName = usrName THEN
		SELECT "Taken" INTO @response;
	ELSE
		SELECT "Unique" INTO @response;
    END IF;
	SELECT @response as response;
END//
CREATE PROCEDURE hub.createSession (IN idUser INT(10))
BEGIN
  DELETE FROM `user-session` WHERE idEntity = idUser;
	SET @idSession = replace(UUID(),'-','');
	INSERT INTO `user-session` (idEntity, idSession, dtStarted, dtActive, done) VALUES (idUser, @idSession, Now(), Now(), 0);
  SELECT @idSession as idSession;
END//
CREATE PROCEDURE hub.createSessionOutParam (IN idUser INT(10), OUT idSession CHAR(32))
BEGIN
	DELETE FROM `user-session` WHERE idEntity = idUser;
	SET @idSession = replace(UUID(),'-','');
	INSERT INTO `user-session` (idEntity, idSession, dtStarted, dtActive, done) VALUES (idUser, @idSession, Now(), Now(), 0);
  SELECT @idSession INTO idSession;
END//
CREATE PROCEDURE hub.forgotPassword (IN usrName VARCHAR(64), IN emailAddr VARCHAR(320))
BEGIN
  SET @idEntity = 0;
  SELECT user.idEntity, email.emailAddress FROM user, email WHERE user.userPrimaryEmail = email.idEmail AND ( user.userName =  usrName OR emailAddress = emailAddr )
  INTO @idEntity, @emailAddress;
  IF @idEntity > 0 THEN
    SET @passwordCode = replace(UUID(),'-','');
    INSERT INTO `forgot-password-session` (idEntity, idSession, dtStarted, done) VALUES (@idEntity, @passwordCode, Now(), 0);
  ELSE
    SET @passwordCode = 0;
  END IF;
  SELECT @idEntity as idEntity, @emailAddress as emailAddress, @passwordCode as passwordCode;
END//
CREATE PROCEDURE hub.getUserName (IN emailAddr VARCHAR(320))
BEGIN
  SELECT e.emailAddress, u.userName
  FROM email AS e, user AS u
  WHERE e.idEntity = u.idEntity AND e.emailAddress = emailAddr AND (e.emailVerified = 1 OR e.idEmail = u.userPrimaryEmail);
END//
CREATE PROCEDURE hub.forgotPasswordUser (IN passwordCode VARCHAR(32))
BEGIN
  SELECT fps.idEntity, fps.dtStarted, user.userSalt FROM `forgot-password-session` AS fps, user WHERE idSession = passwordCode AND user.idEntity = fps.idEntity;
END//
CREATE PROCEDURE hub.getUser (IN idUser INT(10))
BEGIN
  SELECT * FROM user WHERE idEntity = idUser;
END//
CREATE PROCEDURE hub.updateUserPassword (IN idUser INT(10), IN newPassword VARCHAR(128))
BEGIN
  UPDATE user SET userPassword = newPassword WHERE idEntity = idUser;
END//
CREATE PROCEDURE insertMedia (IN idEntityIn INT(10), 
                              IN idUser INT(10), 
                              IN fileName VARCHAR(50),
                              IN ext VARCHAR(4),
                              IN xOffset FLOAT,
                              IN yOffset FLOAT)
BEGIN
	SET @idMasterType = 0;
    SELECT idMasterType  FROM `master-type` WHERE `table` = 'entity-media' and `column` = 'type' and value = ext
    INTO @idMasterType;
    SELECT MAX(sortOrder)+1 FROM `entity-media` WHERE idEntity = idEntityIn INTO @sortOrder;
    IF @sortOrder IS NULL THEN
      SET @sortOrder = 1;
    END IF;
    INSERT INTO `entity-media` (idEntity, idType, idUser, fileName, dtCreated, sortOrder, xOffset, yOffset) 
    VALUES (idEntityIn, @idMasterType, idUser, fileName, Now(), @sortOrder, xOffset, yOffset);
    SELECT * FROM `entity-media` WHERE idMedia = LAST_INSERT_ID();
END//
CREATE PROCEDURE hub.insertSuggestion (IN suggestion TEXT, IN id INT(10))
BEGIN
	INSERT INTO hub.suggestion (idEntity, suggestion, dtCreated) VALUES(id, suggestion, Now());
  SELECT entityTitle FROM entity WHERE idEntity = id;
END//
CALL insertUser ('Steve', '$2a$13$n9oqd6kJyEHFEuVlQWcedewLX/7rrt79AnV050p/kdBfXhTOgesyS',
'$2a$13$n9oqd6kJyEHFEuVlQWcede', 'Steve', 'DeLollis', 'stevedelollis@gmail.com')//
CALL insertUser ('Carson', '$2a$13$1lS.EIHiVXoKnuX2CiODA.X6oFZRR1RzbjsnYa2bOfpMJVi/cTi0i',
'$2a$13$1lS.EIHiVXoKnuX2CiODA.', 'Carson', 'Holmes', 'carsonholmes@gmail.com')//
UPDATE email SET emailVerified = 1 WHERE idEmail = 1 OR idEmail = 2//
DELIMITER ;