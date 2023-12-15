

CREATE TABLE tblEmployee​
(​
 Id int Primary Key,​
 Name nvarchar(30),​
 Gender nvarchar(10),​
 DepartmentId int​
)

--SQL Script to create tblDepartment table ​
CREATE TABLE tblDepartment​
(​
DeptId int Primary Key,​
DeptName nvarchar(20)​
)


Insert data into tblDepartment table​
Insert into tblDepartment values (1,'IT')​
Insert into tblDepartment values (2,'Payroll')​
Insert into tblDepartment values (3,'HR')​
Insert into tblDepartment values (4,'Admin')​
​
Insert data into tblEmployee table​
Insert into tblEmployee values (1,'John', 'Male', 3)​
Insert into tblEmployee values (2,'Mike', 'Male', 2) 
Insert into tblEmployee values (3,'Pam', 'Female', 1) 
Insert into tblEmployee values (4,'Todd', 'Male', 4)​
Insert into tblEmployee values (5,'Sara', 'Female', 1)​
Insert into tblEmployee values (6,'Ben', 'Male', 3) 




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
INSERT INTO @reports(Id,Name,TotalMarks,Percentage,NoOfSubjectsAttended,NoOfPassed,Result,Grade)
  
SELECT X.id,x.name,SUM(X.marks),SUM(X.MARKS)*100/(COUNT(X.MARKS)*100) AS PERCENTAGE,COUNT(X.MARKS) AS ATTEMPTED,
      COUNT(X.RESULT) AS PASSED,
	  CASE WHEN COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'PASS'
	  ELSE 'FAIL'
	  END AS RESULTS,
	  CASE 
	  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) >80 AND COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'DISTINCTION'
	  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) BETWEEN 70 AND 80 AND COUNT(X.MARKS)=COUNT(X.RESULT)THEN 'FIRST CLASS'
	  WHEN (SUM(X.MARKS)*100/(COUNT(X.MARKS)*100)) BETWEEN 50 AND 70 AND COUNT(X.MARKS)=COUNT(X.RESULT) THEN 'SECOND CLASS'
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

SELECT * from ufn_report(1,35)





--SELECT * FROM tblDepartment
--SELECT * FROM tblDeptSub
--SELECT * FROM tblMarks
--SELECT * FROM tblStudent
--SELECT * FROM tblSubject
