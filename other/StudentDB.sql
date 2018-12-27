drop database if exists Studentdb; 

create database Studentdb;

use Studentdb;

create table Students(
    SID varchar(10) not null,
    Name varchar(45),
    Address varchar(45),
    primary key(SID)
); 

create table Professors(
    PID varchar(10) not null,
    Name varchar(45),
    Office varchar(45),
    Age Int,
    DepartmentName varchar(45),
    primary key(`PID`)
);

ALTER TABLE Professors CHANGE COLUMN Age DateOfBirth DATE NOT NULL;

ALTER TABLE Professors ADD NewDate DATE;

ALTER TABLE Professors DROP NewDate;

ALter Table Professors drop DepartmentName;

create table Departments(
    DeptName varchar(45) not null,
    ChairmanID varchar(45),
    primary key(DeptName)
);

create table Courses(
    CourseNum INTEGER not null,
    DeptName varchar(45) not null,
    CourseName varchar(45),
    ClassRoom varchar(45),
    Enrollment INT,
    primary key(`CourseNum`,`DeptName`)
    
);

drop table Courses;

create table Courses(
    CourseNum INTEGER not null,
    DeptName varchar(45) not null,
    CourseName varchar(45),
    ClassRoom varchar(45),
    Enrollment INT,
    primary key(`CourseNum`,`DeptName`),
    Constraint DeptNameFK
    foreign key (DeptName)
    references Departments(DeptName)
);

create table PreReq(
    CourseNum Integer not null,
    DeptName varchar(45),
    PreReqNumber INT,
    PreReqDeptName varchar(45),
    primary key(`CourseNum`,`DeptName`)
);


CREATE TABLE Teach (
  PID VARCHAR(10),
  CourseNum INT,
  DeptName VARCHAR(45),
  PRIMARY KEY(PID,CourseNum,DeptName ),

  CONSTRAINT PIDFKey
    FOREIGN KEY (PID)
    REFERENCES Professors(PID),
  CONSTRAINT CourseNumFKey
    FOREIGN KEY (CourseNum)
    REFERENCES Courses(CourseNum),
  CONSTRAINT DeptNameFKey
    FOREIGN KEY (DeptName)
    REFERENCES Departments(DeptName)
    );



CREATE  TABLE Take (
  SID VARCHAR(10),
  CourseNum INT,
  DeptName VARCHAR(45),
  Grade Decimal(4,2),
  ProfessorEval Decimal(4,2),
  PRIMARY KEY(SID,CourseNum,DeptName),
  CONSTRAINT SIDFKey2
    FOREIGN KEY (SID)
    REFERENCES Students(SID),
  CONSTRAINT CourseNumFKey2
    FOREIGN KEY (CourseNum)
    REFERENCES Courses(CourseNum),
  CONSTRAINT DeptNameFKey2
    FOREIGN KEY (DeptName)
    REFERENCES Departments(DeptName)
    );


insert into Students(SID,Name,Address) 
values('S001','Amy o`Brian','NY');

insert into Students(SID,Name,Address)
values('S002','Bob Catillo','Texas')
,('S003','Candice DeMello','Louisiana')
,('S004','Darrel West','Michigan');

#Select * from Professors;

insert into Professors
values('P001','Dr. John Smith','NH101','19651231');

insert into Professors
values('P002','Dr. Mary Smith','NH102','19700101'),
('P003','Dr. Ardella Ayres','NH103','19700501'),
('P004','Dr. David Dennett','NH104','19750204');


insert into Departments
values('Engineering and Science','Dr. John Smith'),
('Education','Dr. Ralph Ahner'),
('Business','Dr. Kelley Gade');

insert into Courses
values(101,'Engineering and Science','Software Programming','NH150',30),
(102,'Engineering and Science','Introduction to Datamining', 'NH150',25),
(103,'Education','Education 101','BH101',30),
(104,'Business','Business 101','BH101',20),
(200,'Business','Introduction to Administration','BH102',15),
(300,'Business','Advanced Administration','BH103',20);

insert into PreReq
values(101,'Engineering and Science',100,'Engineering and Science'),
(103,'Education',102,'Engineering and Science'),
(104,'Business',103,'Education'),
(300,'Business',200,'Business');


insert into Teach
values('P003',101,'Engineering and Science'),
('P003',101,'Education'),
('P003',101,'Business');

insert into Take values('S001',101,'Engineering and Science',3.9,3.9);
insert into Take values('S002',101,'Education',3.5,3.3);
insert into Take values('S003',101,'Business',3.4,3.6);
insert into Take values('S004',101,'Engineering and Science',2.9,2.5);
