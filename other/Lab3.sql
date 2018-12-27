use Studentdb;

/*SQL defaults to inner join*/
Select * from Courses C
Join PreReq P
on C.CourseNum=P.CourseNum;

Select * from Courses C
Join PreReq P
on C.CourseNum=P.CourseNum
and C.Enrollment>=20;

Select * from Professors
Natural Join Teach;

/*Proffesors are left*/
Select * from Professors P
Left Join Teach T
on P.PID=T.PID;

Select DeptName, min(enrollment), max(enrollment)
from Courses
Group By DeptName
Having min(enrollment) >=10;