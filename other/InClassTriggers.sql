/*Hands On #1*/
DELIMITER $$
Create Trigger students_trigger
Before Insert On students
For Each Row
Begin
	If (New.Address is null) Then
		Set New.Address = 'Ruston';
	End If;
end$$
DELIMITER;

/*Hands On #2*/
DELIMITER $$
Create Trigger client_DateOfBirth
Before Insert On client
For Each Row
Begin
	declare msg varchar(255);
	If (New.Age < 18) Then
		set msg = 'Invalid Date of Birth';
        signal sqlstate '45000' set message_text = msg;
    End If;
end$$
DELIMITER;

/*Hands On #3*/
DELIMITER $$
Create Trigger track_password
After Update On Users
For Each Row
BEGIN
	If(New.password <> Old.password) Then
		Insert Into users_logs Values(New.username, Old.password, New.password);
	End If;
end$$
DELIMITER;

/*Hands On #4*/
DELIMITER $$
Create Trigger NEW_Students
After Insert On STUDENTS
For Each Row
Begin
	Insert Into take values(New.SID,101,'Business',0,0);
end$$
DELIMITER;
