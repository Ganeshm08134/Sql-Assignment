CREATE DATABASE ASSIGNMENT12_new




CREATE TABLE tblDepartment 
						 (DId INT PRIMARY KEY,
						 DName VARCHAR(30)
						 );

INSERT INTO tblDepartment VALUES(1,'CS'),(2,'IS'),(3,'MECH');
SELECT * FROM tblDepartment;

CREATE TABLE tblSubject(SId INT PRIMARY KEY,
						SubName VARCHAR(30) NOT NULL
						);

INSERT INTO tblSubject VALUES(101,'C PROGRAMMING'),
							 (102,'PYTHON'),
							 (103,'H T M L'),
							 (104,'WEB DESIGN'),
							 (105,'SQL'),
							 (106,'DATA ANALYTICS'),
							 (107,'BIG DATA'),
							 (108,'.NET'),
							 (109,'THERMODYNAMICS'),
							 (110,'FLUID MECHINARY'),
							 (111,'MECHANICS OF MATERIALS'),
							 (112,'KINEMATICS');
							 
SELECT * FROM tblSubject;

CREATE TABLE tblDeptSub( DId INT FOREIGN KEY REFERENCES tbldepartment(Did),
                        SId int FOREIGN KEY REFERENCES tblsubject(sid)
						)

INSERT INTO tblDeptSub VALUES(1,101),(1,102),(1,103),(1,104),(1,105),
							 (2,106),(2,107),(2,105),(2,104),(2,108),
							 (3,109),(3,110),(3,111),(3,112),(3,101);

SELECT * FROM tblDeptSub;




SELECT * FROM tblDepartment;
SELECT * FROM tblSubject;
SELECT * FROM tblDeptSub;

CREATE TABLE tblStudent(StudentId INT PRIMARY KEY,
						StudentName VARCHAR(30),
						DepartmentId INT FOREIGN KEY REFERENCES tbldepartment(Did)
						);

INSERT INTO tblStudent VALUES(201,'raghu',1),(202,'akash',2),(203,'harshith',3);

SELECT * FROM tblStudent;

CREATE TABLE tblMarks(StudentId INT FOREIGN KEY REFERENCES tblSTUDENT(StudentId),
				SubjectId INT  FOREIGN KEY REFERENCES tblsubject(sid),
				ExamDate DATE,
				SCore INT
				);

INSERT INTO tblMarks VALUES(201,101,'10-01-2023',80),
							(201,102,'10-02-2023',67),
							(201,103,'10-3-2023',87),
							(201,104,'10-4-2023',91),
							(201,105,'10-5-2023',47),

							(202,106,'10-6-2023',76),
							(202,107,'10-7-2023',82),
							(202,105,'10-8-2023',86),
							(202,104,'10-9-2023',99),
							(202,108,'10-10-2023',34),

							
							(203,109,'10-11-2023',96),
							(203,110,'10-12-2023',82),
							(203,111,'10-13-2023',86),
							(203,112,'10-14-2023',99),
							(203,101,'10-15-2023',94);




CREATE OR ALTER FUNCTION ufn_report(@Dept INT ,@Marks INT)
RETURNS @reports table
(
	Id INT,
	Name varchar(50),
	TotalMarks INT,
	Percentage INT,
	NoOfPassed INT,
	NoOfSubjectsAttended INT,
	Result varchar(50),
	Grade Varchar(50))
AS
BEGIN
INSERT INTO @reports(Id,Name,TotalMarks,Percentage,NoOfPassed,NoOfSubjectsAttended,Result,Grade)
  
SELECT X.id,x.name,SUM(X.marks),SUM(X.MARKS)*100/(COUNT(X.MARKS)*100) AS PERCENTAGE,COUNT(X.MARKS) AS ATTEMPTED,
      COUNT(X.RESULT) AS PASSED,
	  CASE WHEN COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'PASS'
	  ELSE 'FAIL'
	  END AS RESULTS,
	  CASE 
	  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) >80 AND COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'DISTINCTION'
	  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) BETWEEN 70 AND 80 AND COUNT(X.MARKS)=COUNT(X.RESULT)THEN 'FIRST CLASS'
	  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) BETWEEN 50 AND 70 AND COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'SECOND CLASSN'
	  ELSE '--'
	  END AS GRADE

from 

  (SELECT M.StudentId AS ID ,S.StudentName AS NAME ,M.subjectid AS SubId,S.DepartmentId as Dept,M.SCore as marks,CASE
																	WHEN 
																	m.SCORE>@marks THEN 1
																	ELSE NULL
																	END as RESULT
  FROM tblStudent S
  INNER JOIN tblMarks M
  ON S.StudentId=M.StudentId) X
WHERE x.Dept=@Dept
GROUP BY x.id,x.Name
RETURN
END

SELECT * from ufn_report(3,30)