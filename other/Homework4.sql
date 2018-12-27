use Studentdb;

/*Make sure triggers are applied propperly*/
Drop Trigger If Exists Prof_Age;
Drop Trigger If Exists Backup;
Drop Trigger If Exists Default_Course;
Drop Trigger If Exists Grade_Tracker;

/* Used for Problems 2 and 4*/
/* Taken straight from assignment*/
CREATE TABLE TAKE_BACKUP (SELECT * FROM Take WHERE 1 = 2);
CREATE TABLE GRADE_CHANGED (
	SID VARCHAR(45) NOT NULL ,
	OLDGrade VARCHAR(45) NULL ,  
	NEWGrade VARCHAR(45) NULL );

/*1*/
DELIMITER $$
Create Trigger Prof_Age
Before Insert On Professors
For Each Row
Begin
	declare msg varchar(255);
	If ((DateDiff(Now(),DateOfBirth)/365) < 18) Then
		set msg = 'Invalid Date of Birth';
        signal sqlstate '45000' set message_text = msg;
    End If;
End$$

/*2*/
DELIMITER $$
Create Trigger Backup
Before Delete on Take
For Each Row
Begin
	Insert Into TAKE_BACKUP Values(Old.SID, Old.CourseNum, Old.DeptName, Old.Grade, Old.ProfessorEval);
End$$

/*3*/
DELIMITER $$
Create Trigger Default_Course
After Insert on Professors
For Each Row
Begin
	Insert Into  Teach Values(New.PID, 101, 'Engineering and Science');
End$$
/*4*/
DELIMITER $$
Create Trigger Grade_Tracker
After Update on Take
For Each Row
Begin
	Insert Into GRADE_CHANGE Values(Old.SID, Old.Grade, New.Grade);
End$$