CREATE DATABASE ASSIGNMENT12
USE ASSIGNMENT12

CREATE TABLE tblDepartment
(
	DepartmentId INT PRIMARY KEY,
	DepartmentName VARCHAR(50)
)

CREATE TABLE tblSubjects
(	
	SubId INT PRIMARY KEY,
	Subject VARCHAR(50)
)

CREATE TABLE tblDepartmentSubjects
(
	SlNo INT PRIMARY KEY,
	DepartmentId INT
		FOREIGN KEY REFERENCES tblDepartment(DepartmentID),
	SubId INT 
		FOREIGN KEY REFERENCES tblSubjects(SubId)
)

CREATE TABLE tblStudentMaster
(
	ID INT PRIMARY KEY,
	Name VARCHAR(50),
	DateOfJoin DATE,
	DepartMent INT 
		FOREIGN KEY REFERENCES tblDepartment(DepartmentID)
)


CREATE TABLE tblMarks
(
	Id INT IDENTITY(1,1),
	StudentID INT,
	SubjectID INT
		FOREIGN KEY REFERENCES tblSubjects(SubId),
	DoE DATE,
	Scores INT,
	CONSTRAINT Pk_stusub PRIMARY KEY(StudentId,SubjectId)
)



INSERT INTO tblDepartment
VALUES
(1,'CSE'),(2,'ECE'),(3,'ME'),(4,'IS')

INSERT INTO tblSubjects
VALUES
(1001,'C Program'),
(1002,'Python'),
(1003,'Computer Networks'),
(1004,'DBMS'),
(1005,'Web Technology'),
(1006,'Data Mining'),
(1007,'Big Data Analytics'),
(1008,'Arduino Programming'),
(1009,'Digital Electronics'),
(1010,'Computer Fundamentals'),
(1011,'Basic Electronics'),
(1012,'Thermodynamics'),
(1013,'Kinametics'),
(1014,'Dynametics'),
(1015,'MOM')

INSERT INTO tblDepartmentSubjects
VALUES
(1,1,1001),(2,1,1002),(3,1,1003),(4,1,1004),(5,1,1005),
(6,4,1006),(7,4,1007),(8,4,1001),(9,4,1002),(10,4,1005),
(11,3,1012),(12,3,1013),(13,3,1014),(14,3,1015),(15,3,1001),
(16,2,1008),(17,2,1009),(18,2,1010),(19,2,1011),(20,2,1001)

INSERT INTO tblStudentMaster
VALUES
(101,'Sathish','05-15-2020',1),
(102,'Balraju','10-5-2020',2),
(103,'Chethan','1-15-2020',3),
(104,'Prathibha','10-22-2020',4),
(105,'Vasanth','12-20-2020',1),
(106,'Santhosh','08-15-2020',2),
(107,'Mahesh','07-15-2020',3),
(108,'rani','1-15-2020',4),
(109,'Raju','1-20-2020',1),
(110,'Sangeetha','10-15-2020',2)





SELECT * FROM tblDepartment
SELECT * FROM tblSubjects
SELECT * FROM tblDepartmentSubjects
SELECT * FROM tblStudentMaster
SELECT * FROM tblMarks


INSERT INTO tblStudentMaster
VALUES
(101,'Sathish','05-15-2020',1),
(102,'Balraju','10-5-2020',2),
(103,'Chethan','1-15-2020',3),
(104,'Prathibha','10-22-2020',4),
(105,'Vasanth','12-20-2020',1),
(106,'Santhosh','08-15-2020',2),
(107,'Mahesh','07-15-2020',3),
(108,'rani','1-15-2020',4),
(109,'Raju','1-20-2020',1),
(110,'Sangeetha','10-15-2020',2)

INSERT INTO tblMarks
VALUES
(111,1001,'10-14-2023',30),
(111,1002,'10-11-2023',90),
(111,1003,'06-22-2023',66),
(111,1005,'04-13-2023',15),

(112,1008,'09-15-2023',70),
(112,1009,'09-18-2023',95),
(112,1010,'05-10-2023',32),
(112,1011,'10-15-2023',63),

(113,1001,'08-16-2023',60),
(113,1015,'08-20-2023',75),
(113,1013,'04-11-2023',20),
(113,1012,'09-16-2023',51),

(114,1006,'07-17-2023',80),
(114,1007,'07-21-2023',72),
(114,1001,'05-22-2023',25),
(114,1002,'08-19-2023',25)

SELECT * FROM tblDepartment
SELECT * FROM tblDepartmentSubjects
SELECT * FROM tblMarks
SELECT * FROM tblStudentMaster
SELECT * FROM tblSubjects




CREATE FUNCTION udf_res(@department_id INT,@pass_marks INT)
RETURNS TABLE
 AS
RETURN (SELECT tsm.id,tsm.Name,SUM(tm.Scores),(SUM(tm.Scores)/(COUNT(tm.SubjectID)*100)) AS Percentage
FROM tblStudentMaster tsm
INNER JOIN tblMarks tm
ON tm.StudentID = tsm.ID
INNER JOIN tblDepartment td
ON td.DepartmentId = tsm.DepartMent
WHERE tm.
GROUP BY tsm.id,tsm.Name) 


SELECT tsm.id,Name, SUM(Scores)
FROM tblStudentMaster tsm
INNER JOIN tblMarks tm
ON tm.StudentID = tsm.ID
SELECT SUM(Scores) AS Percentage
FROM tblMarks 
GROUP BY StudentID




