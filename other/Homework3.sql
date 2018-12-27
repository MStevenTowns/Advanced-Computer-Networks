use Studentdb;

/*1*/
Select * From Students s
Join Take t
On s.SID = t.SID;

/*2*/
Select * From Students
Natural Join Take;

/*3*/
Select * From Students s
Join Take t
Using (SID, SID);

/*4*/
Select * From Courses c
Left Join PreReq p
On c.CourseNum=p.CourseNum;

/*5*/
Select DeptName, Avg(Enrollment)
From Courses
Group By DeptName;