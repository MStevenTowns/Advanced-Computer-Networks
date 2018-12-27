drop database if exists ProjectDB;

create database ProjectDB;
#Chain Delete

CREATE TRIGGER User_Delete
AFTER DELETE ON User
FOR EACH ROW
BEGIN
    DELETE FROM Rates WHERE Rates.uid = OLD.uid
DELETE FROM Covers WHERE Covers.uid = OLD.uid
END


#Backup

CREATE TRIGGER User_Backup
BEFORE DELETE ON User
FOR EACH ROW
BEGIN 
INSERT INTO User_Backup VALUES(Old.user_id, OLD.Name, OLD.dob, OLD..address, Now());
END

#User Age Check

CREATE TRIGGER Age_Check
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
DECLARE msg varchar(255);
IF ((DateDiff(Now(),DOB)/365) < 18) THEN
            SET msg = 'Invalid Date of Birth';
        SIGNAL sqlstate '45000' set message_text = msg;
END IF;
END

#Stub Entries

CREATE TRIGGER  Stub_Creation
BEFORE INSERT ON Rates
FOR EACH ROW
BEGIN
IF NOT EXISTS(SELECT uid from User WHERE uid=NEW.uid)THEN INSERT INTO User VALUES(NEW.uid)
END IF;
END
, or non




/*

The simple way would be to disable the foreign key check; make the changes then re-enable foreign key check.

SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them

*/