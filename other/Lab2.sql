/*
Question 1:	Using aliasing, select the names and 
grades of students with Grade greater than 3.0.

Question 2:	For each student compute the average 
between their grade and their ProfessorEval and sort 
the result in ascending order.

Question 3:	Use a subquery in the FROM clause 
to find those students belonging to the ‘Education 
Department’ who have taken course numbered 101. 

Question 4:	Find those courses that were taken by 
student that do not have any perquisites 

Question 5:	List all the courses that have 
prerequisites (using EXISTS)
*/

use Studentdb;

/*1*/
Select S.Name, T.Grade 
from Students S, Take T
where S.SID = T.SID AND T.Grade > 3.0;

/*2*/
Select S.*, (T.Grade+T.ProfessorEval)/2 as average
from Take T, Students S
where S.SID=T.SID
order by average asc;

/*3*/
Select S.*
from Students S, (select * from Take where DeptName = 'Education' and CourseNum=101) T
where S.SID=T.SID;

/*4*/
/*hold = all courses without prereqs*/
select hold.*
from Take T, (select * from Courses C where NOT EXISTS (select * from PreReq P where P.CourseNum = C.CourseNum)) as hold
where hold.CourseNum=T.CourseNum;

/*5*/
Select C.*
from Courses C
where EXISTS (select * from PreReq P where P.CourseNum=C.CourseNum);

