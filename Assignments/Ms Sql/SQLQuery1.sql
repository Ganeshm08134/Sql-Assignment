CREATE TABLE tblEmployeeDt1(
Employeeid int,
EmployeeName Varchar(50),
Designation Varchar(50),
JoinedDate Date,
EmailId varchar(50),
Salary money,
DepartmentId int);

INSERT INTO tblEmployeeDt1(Employeeid,EmployeeName,Designation,JoinedDate,EmailId,Salary,DepartmentId) VALUES(9,'varun','Requirement Analysis','2017/01/24','varun@gmail.com',75000,1006);

Alter table tblEmployeeDt1
ALTER COLUMN Employeeid int NOT NULL;


Alter table tblEmployeeDt1
Add constraint fk foreign key (DepartmentId) references tblDepartment(DepartmentID);



SELECT GETDATE();

CREATE TABLE tblDepartment (
DepartmentID int primary key,
DepartmentName varchar(50) Not null,
Location varchar(50) not null);

drop table tblDepartment

SELECT * FROM tblDepartment 

exec sp_columns tblDepartment 

ALTER TABLE tblEmployeeDt1
ADD DepartmentId int;

SELECT * FROM tblEmployeeDt1;

insert into tblDepartment values(1001,'testing','mysore');
insert into tblDepartment values(1002,'SE','Banglore');
insert into tblDepartment values(1003,'QA','mysore');
insert into tblDepartment values(1004,'DEV','Banglore');
insert into tblDepartment values(1005,'HR','mysore');

SELECT * FROM tblEmployeeDt1;

update tblEmployeeDt1
SET DepartmentId = 1004
where Employeeid in(4,5);

--query 2
SELECT * FROM tblEmployeeDt1;
SELECT * FROM tblDepartment;

--query 3

SELECT EmployeeName,Employeeid,DepartmentId
FROM tblEmployeeDt1;

--query 4

SELECT EmployeeName,Employeeid,DepartmentId
FROM tblEmployeeDt1
where DepartmentId IN(1004,1005);

--query 5

select * FROM tblEmployeeDt1
WHERE Salary > 20000;

--query 6

select * FROM tblEmployeeDt1
WHERE Salary > 20000 AND DepartmentId = 1004;

--query 7

SELECT * fROM tblEmployeeDt1
Where DepartmentId IS Null;

--query 8

SELECT EmployeeName,DepartmentName
FROM tblEmployeeDt1,tblDepartment
WHERE tblEmployeeDt1.DepartmentId = tblDepartment.DepartmentId AND Designation = 'full stack Developer';

--Query 9

SELECT EmployeeName,Designation,Salary
FROM tblEmployeeDt1
where DepartmentId = 1005 AND Salary Between 20000 AND 40000;

--query 10

SELECT distinct(Designation)
FROM tblEmployeeDt1;

--query 11

select * FROM tblEmployeeDt1
WHERE Salary > 20000 AND DepartmentId IN(1004,1005);

--query 12

SELECT Designation,DepartmentId,FORMAT(JoinedDate,'dd/mm/yy')
FROM tblEmployeeDt1
WHERE DepartmentId = 1005;

--Query 13

SELECT * 
FROM tblEmployeeDt1
WHERE EmployeeName LIKE '[aeiou]%';

--Query 14

SELECt *
FROM tblEmployeeDt1
where
len(EmployeeName) < 10;

--query 15

SELECT * 
FROM tblEmployeeDt1
WHERE EmployeeName LIKE '%n%';

--query 16

SELECT * 
FROM tblEmployeeDt1
WHERE ( DATEPART(YYYY,getdate())) - (DATEPART(YYYY,JoinedDate) ) > 3;

SELECT * 
FROM tblEmployeeDt1
WHERE ( DATEDIFF(YYYY,JoinedDate,GETDATE())) > 3;

--SELECT DATEADD(WEEK,5,GETDATE());

--query 17

SELECT * 
FROM tblEmployeeDt1
WHERE DATEPART(DAY,JoinedDate) = '0';

--query 18

SELECT top 1 *
FROM tblEmployeeDt1
order by JoinedDate
;

SELECT *
FROM tblEmployeeDt1
WHERE DATEPART(DD,JoinedDate) = '12';



-- query 19

SELECT *
FROM tblEmployeeDt1
WHERE MONTH(JoinedDate) = 1;

--query 20 

SELECT CONCAT(EmployeeName,' ',lastname)
FROM tblEmployeeDt1;

SELECT CONCAT(SUBSTRING(EmployeeName,1,1),' ',SUBSTRING(EmployeeName,3,1))
FROM tblEmployeeDt1;

ALTER TABLE tblEmployeeDt1
ADD lastname char(10) ;

SELECT * 
FROM tblEmployeeDt1
WHERE EmployeeName LIKE 'a%';

SELECT * 
FROM tblEmployeeDt1
WHERE EmployeeName LIKE '_[aeiou]%';

SELECT * 
FROM tblEmployeeDt1
WHERE EmployeeName LIKE '%t';

SELECT * 
FROM tblEmployeeDt1
WHERE EmployeeName LIKE '%y%';


select concat(EmployeeName,' || ',Designation) 
FROM tblEmployeeDt1;

DELETE FROM tblEmployeeDt1
WHERE Employeeid = 1;

ROLLBACK;

SELECT  EmployeeName+'  ||  '+SUBSTRING(EmployeeName,2,10) 
FROM tblEmployeeDt1;


SELECT CHARINDEX('f','CRICKET fans')

SELECT EmployeeName
FROM tblEmployeeDt1;


/* ASSIGNMENT 2 Starts */

CREATE DATABASE assignment2;

CREATE TABLE tblDepartmentC(
DepartmentID int primary key,
DepartmentName varchar(50) not null,
DLocation varchar(50) not null
);

CREATE TABLE tblSubjectDtl(
SubjectID int primary key,
SubjectName varchar(50) not null
);

CREATE TABLE tblStudentDtl(
StudentID int primary key,
StudentName varchar(50) not null
);

CREATE TABLE tblEmployeeDtlC(
EmployeeID int primary key,
EmployeeName varchar(50) not null,
Designation varchar(50) not null,
JoiningDate date not null default (getdate()),
emailid varchar(25) not null unique,
PhoneNo bigint not null Check(len(PhoneNo) = 10),
Salary int not null Check (Salary > 15000),
DepartmentID int,
foreign key(DepartmentID) references tblDepartmentC(DepartmentID)
);



CREATE TABLE tblStudentSubMarks (
StudentId int,
SubjectID int,
Marks Decimal not null
primary key(StudentId,SubjectID)
Foreign key(StudentId) REFERENCES tblStudentDtl(StudentID),
Foreign key(SubjectID) REFERENCES tblSubjectDtl(SubjectID));


--SELECT * FROM tblDepartmentC;

INSERT INTO tblEmployeeDtlC VALUES (1,'Harish','HR','2018/07/02','harish@gmail.com',9405604053,16000,101);
INSERT INTO tblEmployeeDtlC VALUES (4,'Harsith','trainee','2019/03/24','harsith@gmail.com',9657846653,18000,101);
INSERT INTO tblEmployeeDtlC VALUES (5,'mahesh','trainee','2018/07/02','harish@gmail.com',9405604053,16000,101);
INSERT INTO tblEmployeeDtlC VALUES (6,'suresh','','2018/07/02','suresh@gmail.com',9406784053,28000,103);
INSERT INTO tblEmployeeDtlC VALUES (1,'Harish','HR','2018/07/02','harish@gmail.com',9405604053,16000,101);
INSERT INTO tblEmployeeDtlC VALUES (1,'Harish','HR','2018/07/02','harish@gmail.com',9405604053,16000,101);

/*Alter table tblEmployeeDtlC
ADD constraint emailid;*/

SELECT * FROM tblEmployeeDtlC;

SELECT GETDATE();

UPDATE tblEmployeeDtlC
SET DepartmentID = 106
WHERE EmployeeID = 4;


Alter table tblEmployeeDtlC
ADD Bonus int;

--Query 1
UPDATE tblEmployeeDtlC
SET DepartmentID = null
WHERE Designation = 'trainee';
--query 2										
UPDATE tblEmployeeDtlC
SET Bonus = 10000
WHERE ( DATEDIFF(YYYY,JoiningDate,GETDATE())) >= 2;

																				
--query 3
create PROCEDURE raghu as
SELECT EmployeeID,EmployeeName,(Salary+ISNULL(TotalBonus,0)) as Total_salary
FROM tblEmployeeDtlC;

EXEC raghu
EXEC sp_rename 'tblEmployeeDtlC.Bonus','TotalBonus','COLUMN'

SELECT * FROM tblEmployeeDtlC;

SELECT TOP 3 WITH ties Salary,EmployeeID
FROM tblEmployeeDtlC
ORDER BY Salary DESC;

SELECT TOP 3 PERCENT Salary,EmployeeID
FROM tblEmployeeDtlC
ORDER BY Salary DESC;

SELECT EmployeeName,Salary
FROM tblEmployeeDtlC
WHERE Salary IN(
SELECT MAX(Salary)
FROM tblEmployeeDtlC);



SELECT Designation,COUNT(Designation) AS Total
FROM tblEmployeeDtlC
Group BY Designation
HAVING COUNT(Designation) > 2
ORDER BY Designation;


/*---------------------------------------Assignment 3---------------------------------*/


/* Question 1: Display all the employees data by sorting the date of joining in the ascending order and 
then by name in descending order. */

SELECT *
FROM Employees
ORDER BY JoiningDate,Employee_FirstName DESC;

/* Question 2: Modify the column name EmployeeName to Employee_FirstName and also add another 
column Employee_LastName  */

EXEC sp_rename 'tblEmployeeDtlC.EmployeeName','Employee_FirstName','COLUMN'

ALTER TABLE tblEmployeeDtlC
ADD Employee_LastName VARCHAR(5);

-- Question 3 : Write a query to change the table name to Employees. 

EXEC sp_rename 'tblEmployeeDtlC','Employees'

--Question 4 :Write a query to update the salary of those employees whose location is ‘Mysore’ to 35000. 
/*SELECT *
FROM Employees*/

ALTER TABLE Employees
ADD Elocation varchar(20);

UPDATE Employees
SET Salary = 35000
WHERE Elocation = 'mysore';

--Question 5 : Write a query to disassociate all trainees from their department  

UPDATE Employees
set DepartmentID = null
WHERE Designation = 'trainee';


/*Question 6 : Write a query which adds another column ‘Bonus’ to the table Employees where the bonus 
is equal to the salary multiplied by ten.Update the value only when the experience is two 
years or above. */

UPDATE Employees
SET TotalBonus = Salary * 10
WHERE DATEDIFF(yyyy,JoiningDate,GETDATE()) >= 2;

SELECT *
FROM Employees;

-- Question 7 :Display name and salary of top 5 salaried employees from Mysore and Hyderabad. 

SELECT Top 5 Salary,Employee_FirstName
FROM Employees
WHERE Elocation IN('Mysore','Hydrabad');

--Question 8 : Display name and salary of top 3 salaried employees(Include employees with tie)

SELECT TOP 3 WITH TIES Salary,Employee_FirstName
FROM Employees
ORDER BY Salary DESC;

-- Question 9 : Display top 1% salaried employees from Noida and Bangalore 

SELECT TOP 1 PERCENT Salary,Employee_FirstName
FROM Employees
WHERE Elocation IN('Mysore','Banglore');


--Question 10 : Find average and total salary for each job. 

SELECT Designation,AVG(Salary) AS Average,Sum(Salary) AS Total_salary
FROM Employees
Group By Designation;


--Question 11 : Find highest salary of all departments.

SELECT Designation,MAX(Salary) AS Highest
FROM Employees
Group By Designation;

-- Question 12: Find minimum salary of all departments

SELECT Designation,MIN(Salary) AS Minimum
FROM Employees
Group By Designation;

-- Question 13:  Find difference in highest and lowest salary for all departments.
SELECT  DepartmentID,(MAX(Salary) - MIN(Salary) )AS Diff
FROM Employees
Group By DepartmentID;

-- Question 14: Find average and total salary for trainees 

SELECT Designation,AVG(Salary) AS Average,Sum(Salary) AS Total_salary
FROM Employees
WHERE Designation = 'trainee'
GROUP BY Designation;


-- Question 15: Count total different jobs held by dept no 30 

SELECT COUNT(DISTINCT(Designation)) AS Total_Diff_Jobs
FROM Employees
WHERE DepartmentID = 101;

--Question 16:  Find highest and lowest salary for non-managerial job

SELECT  Designation,MAX(Salary) Highest,MIN(Salary) Lowest
FROM Employees
WHERE Designation NOT IN('hr')
Group By Designation;


-- Question 17: Count employees and  average annual salary of each department. 

SELECT Designation,COUNT(*),AVG(salary  * 12) AVG_ANUAL_SAL
FROM Employees
Group By Designation;

-- Question 18: Display the number of employees sharing same joining date.

SELECT COUNT(*)
FROM Employees a
WHERE JoiningDate IN
(SELECT JoiningDate
FROM Employees
WHERE a.EmployeeID != EmployeeID);

-- Question 19 : Display number of employees with same experience 

SELECT COUNT(*)
FROM Employees a
WHERE JoiningDate IN
(SELECT JoiningDate
FROM Employees
WHERE a.EmployeeID != EmployeeID);


-- Question 20 : Display total number of employees in each department with same salary 

SELECT DepartmentID,COUNT(EmployeeID) 
FROM Employees a
WHERE Salary IN
(SELECT Salary
FROM Employees
WHERE a.EmployeeID != EmployeeID)
GROUP BY DepartmentID;


--Question 21 : Display the  number of Employees above 35 years in each department 

SELECT DepartmentID,COUNT(EmployeeID) AS ABOVE_35 
FROM Employees
WHERE DATEDIFF(yyyy,JoiningDate,GETDATE()) > 35
GROUP BY DepartmentID;




/*--------------------------------PRACTICE ASSIGNMENT-----------------------------*/


/* Question 1. Display All employees with their Department Names
(Exclude the employees not allocated with department)
*/

SELECT EmployeeID,CONCAT(Employee_FirstName,' ',Employee_LastName) EMP_Name,tblDepartmentC.DepartmentName
FROM Employees,tblDepartmentC
WHERE Employees.DepartmentID = tblDepartmentC.DepartmentID ;

--Question 2. Display employees joined in the year 2020 with their Department Names
select * from Employees;
SELECT EmployeeID,CONCAT(Employee_FirstName,' ',Employee_LastName) EMP_Name,tblDepartmentC.DepartmentName
FROM Employees,tblDepartmentC
WHERE Employees.DepartmentID = tblDepartmentC.DepartmentID AND DATEPART(yyyy,JoiningDate) = 2020;


/* Question 3. Display employees who work in their hometown  with their 
Department Names(Exclude the employees not allocated with department)*/

SELECT EmployeeID,CONCAT(Employee_FirstName,' ',Employee_LastName) EMP_Name,Elocation,tblDepartmentC.DepartmentName
FROM Employees,tblDepartmentC
WHERE Employees.DepartmentID = tblDepartmentC.DepartmentID AND tblDepartmentC.Dlocation = Elocation;


/* 4. Display All Departments
with their employees(Include departments without Employees too) */

SELECT EmployeeID,CONCAT(Employee_FirstName,' ',Employee_LastName) EMP_Name,tblDepartmentC.DepartmentName
FROM Employees
RIGHT OUTER JOIN tblDepartmentC
ON Employees.DepartmentID = tblDepartmentC.DepartmentID;

/*5. Display all employees with their department locations
(Include employees who are not allocated with department)
*/

SELECT EmployeeID,CONCAT(Employee_FirstName,' ',Employee_LastName) EMP_Name,tblDepartmentC.DepartmentName,tblDepartmentC.Dlocation
FROM Employees
LEFT OUTER JOIN tblDepartmentC
ON Employees.DepartmentID = tblDepartmentC.DepartmentID;




/*------------------------------ASSIGNMENT 4-------------------------------------*/

/*Create table salesmen. 
[Hint: (snum number(4) primary key,sname varchar(20),city 
varchar(20), commission decimal(6,2) ] */


CREATE TABLE salesmen 
(snum int PRIMARY KEY,            
sname VARCHAR(20) NOT null,          
city VARCHAR(20),
comission DECIMAL(6,2));



/*
Create table orders. 
[Hint: onum int primary key, amount decimal(7,2),odate datetime,cnum int 
references customers(cnum),snum int references salesmen(snum)] 
*/

CREATE TABLE ORDERS(onum int PRIMARY KEY,
amount DECIMAL(7,2),
odate DATETIME,
cnum INT,
snum INT,
FOREIGN KEY(snum) REFERENCES salesmen(snum),
FOREIGN KEY(cnum) REFERENCES customers(cnum) );




/*
Create table customers 
[Hint: (cnum int primary key,cname varchar(20),city varchar(20), rating 
number(5),snum int references salesmen(snum)] 
*/

CREATE TABLE customers(
cnum int PRIMARY KEY,
cname VARCHAR(20),
city VARCHAR(20),
rating int,
sunum int
FOREIGN KEY (sunum) REFERENCES salesmen(snum)
);

/*
SELECT * FROM salesmen;
SELECT * FROM customers;
SELECT * FROM ORDERS

*/

/*
Question 1.Display the following information about each order. 
a.Order No, Customer Name, Order Amount, Order Date */

SELECT onum,cname,amount,odate
FROM ORDERS,customers
WHERE ORDERS.cnum = customers.cnum;


-- Question 2.Display customers associated with each Salesman 

SELECT salesmen.sname,customers.cname
FROM salesmen,customers
WHERE salesmen.snum = customers.sunum;

/* Question 3.Display following information about each order: 
a.OrderNo , Customer Name, Salesman Name, Order Amount, Order 
Date 
*/

SELECT ORDERS.onum,customers.cname,salesmen.sname,ORDERS.amount,ORDERS.odate
FROM salesmen,customers,ORDERS
where salesmen.snum = ORDERS.snum AND customers.cnum = ORDERS.cnum;

/* Question 4.Display salesman with their order details in the decreasing order 
value(Include salesman who has not captured any order) 
a.Salesman name, Customer name,Ordervalue */

SELECT salesmen.sname,customers.cname,ORDERS.onum,ORDERS.amount
FROM salesmen
RIGHT OUTER JOIN ORDERS 
ON salesmen.snum = ORDERS.snum
INNER JOIN customers
ON customers.cnum = ORDERS.cnum
ORDER BY ORDERS.amount DESC;

/*
 Question 5.Display customers with their orders in the ascending order of date(Include 
customers who hasn’t booked any order) 
a.Customer Name, Order Value Order date 
*/

SELECT customers.cname,ORDERS.onum,ORDERS.amount,ORDERS.odate
FROM customers
INNER JOIN ORDERS 
ON customers.cnum = ORDERS.cnum
ORDER BY ORDERS.odate;


/*
Question 6.List the number of customers handled by each salesman.(Sales man 
name, Number of Customers handled) 
*/

SELECT salesmen.snum,salesmen.sname,COUNT(customers.sunum) AS NUM_OF_CUSTOMERS
FROM salesmen,customers
WHERE salesmen.snum = customers.sunum
GROUP BY salesmen.snum,salesmen.sname;


/*
 Question 7.List the customers(Name of the customer) who have placed more than 
one order 
*/

SELECT customers.cname
FROM customers,ORDERS
WHERE customers.cnum = ORDERS.cnum
GROUP BY customers.cname
HAVING COUNT(ORDERS.cnum) > 1;


/*
Question 8.Display sum of orders from each city from each customer and salesman 
*/

SELECT customers.city AS customer_City,customers.cname,COUNT(ORDERS.cnum) ,salesmen.sname,salesmen.city AS salesman_city,COUNT(ORDERS.snum),SUM(ORDERS.amount) AS Total_amt
FROM customers
Inner JOIN ORDERS
ON customers.cnum = ORDERS.cnum
LEFT OUTER JOIN salesmen
ON salesmen.snum = ORDERS.snum 
GROUP BY customers.city,salesmen.city,customers.cname,salesmen.sname;



/*---------------------------------Sample Questions------------------------------------*/

SELECT * FROM employees;

ALTER TABLE employees
ADD managerid int;

--COUNT of employess who reporting to a manager with manager name

SELECT e1.Employee_FirstName,COUNT(e2.Employee_FirstName) AS reporting
FROM Employees e1 LEFT JOIN Employees e2
ON e1.EmployeeID = e2.managerid
GROUP BY e1.Employee_FirstName;


SELECT e2.Employee_FirstName,COUNT(e1.Employee_FirstName) AS reporting
FROM Employees e1 RIGHT JOIN Employees e2
ON e1.managerid = e2.EmployeeID
GROUP BY e2.Employee_FirstName;


--display manager atleast one person reporting

SELECT e1.EmployeeID,e1.Employee_FirstName,COUNT(e2.Employee_FirstName) AS reporting
FROM Employees e1 JOIN Employees e2
ON e1.EmployeeID = e2.managerid
GROUP BY e1.EmployeeID,e1.Employee_FirstName
having COUNT(e2.Employee_FirstName)>=1;


/*---------------------------------ASSIGNMENT 5-------------------------------------*/


ALTER DATABASE Consultation MODIFY NAME = Hospital;


CREATE TABLE Patient(
patientid INT PRIMARY KEY,
pname VARCHAR(20) NOT NULL,
city VARCHAR(30) NOT NULL);

CREATE TABLE doctor(
doctorid int PRIMARY KEY,
dname VARCHAR(20) NOT NULL,
dept VARCHAR(20) ,
salary MONEY
);

CREATE TABLE consultation(
consultationid int PRIMARY KEY,
patientid int,
doctorid int,
fee MONEY
FOREIGN KEY(patientid) REFERENCES Patient(patientid),
FOREIGN KEY(doctorid) REFERENCES doctor(doctorid)
);


SELECT * FROM Patient;
SELECT * FROM doctor
SELECT * FROM consultation;

/*
Question 1: Identify the consultation details of patients with the letter ‘e’ anywhere in their name, who 
have consulted a cardiologist. Write a SQL query to display doctor’s name and patient’s 
name for the identified consultation details. 
*/

SELECT Patient.pname AS Patient_Name,doctor.dname AS Doctor_Name,doctor.dept AS Dept_Name
FROM Patient
JOIN consultation
ON consultation.patientid = Patient.patientid
JOIN doctor
on consultation.doctorid = doctor.doctorid
WHERE Patient.pname LIKE '%e%' AND doctor.dept = 'Cardiology';

/*
Question 2: Identify the doctors who have provided consultation to patients from the cities ‘Boston’ 
and ‘Chicago’. Write a SQL query to display department and number of patients as 
PATIENTS who consulted the identified doctor(s). 
*/

SELECT doctor.doctorid,doctor.dname AS Doctor_Name,Patient.city,COUNT(Patient.patientid) AS Patient_Count
FROM Patient
JOIN consultation
ON consultation.patientid = Patient.patientid
JOIN doctor
on consultation.doctorid = doctor.doctorid
WHERE Patient.city IN ('Boston','Chicago')
GROUP BY doctor.doctorid,doctor.dname,Patient.city;

/*
Question 3: Identify the cardiologist(s) who have provided consultation to more than one patient. 
Write a SQL query to display doctor’s id and doctor’s name for the identified 
cardiologists. 
*/

SELECT doctor.doctorid,doctor.dname AS Doctor_Name
FROM consultation
JOIN doctor
ON consultation.doctorid = doctor.doctorid
WHERE doctor.dept = 'Cardiology'
GROUP BY doctor.doctorid,doctor.dname
HAVING COUNT(consultation.patientid) >1;


/*
Question 4: Write a SQL query to combine the results of the following two reports into a single report. 
The query result should NOT contain duplicate records. 
Report 1 – Display doctor’s id of all cardiologists who have been consulted by 
patients. 
Report 2 – Display doctor’s id of all doctors whose total consultation fee charged 
in the portal is more than INR 800. 
*/

(SELECT doctor.doctorid
FROM consultation
JOIN doctor
ON consultation.doctorid = doctor.doctorid
WHERE doctor.dept = 'Cardiology'
GROUP BY doctor.doctorid,doctor.dname
HAVING COUNT(doctor.doctorid) >=1)
UNION
(SELECT doctor.doctorid
FROM consultation
JOIN doctor
ON consultation.doctorid = doctor.doctorid
WHERE consultation.fee  > 800)



/*
Question 5: Write a SQL query to combine the results of the following two reports into a single report. 
The query result should NOT contain duplicate records. 
Report 1 – Display patient’s id belonging to ‘New York’ city who have consulted 
with the doctor(s) through the portal. 
Report 2 – Display patient’s id who have consulted with doctors other than 
cardiologists and have paid a total consultation fee less than INR 1000. 
*/


SELECT Patient.patientid
FROM Patient
JOIN consultation
ON consultation.patientid = Patient.patientid
WHERE Patient.city = 'New York'
UNION
SELECT Patient.patientid
FROM Patient
JOIN consultation
ON consultation.patientid = Patient.patientid
JOIN doctor
on consultation.doctorid = doctor.doctorid
WHERE doctor.dept != 'cardiologist'
GROUP BY Patient.patientid
HAVING SUM(consultation.fee) < 1000;




CREATE DATABASE Toys;

CREATE TABLE Customers(
custId int PRIMARY KEY,
custname VARCHAR(20) NOT NULL,
CustType CHAR(1)
);


CREATE TABLE Category(
Cid CHAR(4) PRIMARY KEY,
cname VARCHAR(5)
);

CREATE TABLE Toys(
ToyID CHAR(5) PRIMARY KEY,
ToyName VARCHAR(50) UNIQUE NOT NULL,
Cid CHAR(4) NOT NULL,
Price INT NOT NULL CHECK(Price > 100),
Stock INT NOT NULL,
FOREIGN KEY(Cid) REFERENCES Category(Cid)
);


CREATE TABLE Transactions(
Txnid INT PRIMARY KEY,
custId INT,
Toyid CHAR(5),
Quantity INT,
TxnCost INT,
FOREIGN KEY(custId) REFERENCES Customers(custId),
FOREIGN KEY(Toyid) REFERENCES Toys(ToyID)
);

ALTER TABLE Category
ALTER COLUMN cname VARCHAR(20);

SELECT * FROM Category;
SELECT * FROM Customers;
SELECT * FROM Toys;
SELECT * FROM Transactions;



/*
Question 1 :Display CustName and total transaction cost as TotalPurchase for those customers 
whose total transaction cost is greater than 1000. 
*/

SELECT Customers.custName,SUM(Transactions.TxnCost) AS TotalPurchase
FROM Customers
JOIN Transactions
ON Transactions.custId = Customers.custid
GROUP BY Customers.custName
HAVING SUM(Transactions.TxnCost) > 1000;


/*
Question 2: List all the toyid, total quantity purchased as 'total quantity' irrespective of the 
customer. Toys that have not been sold should also appear in the result with total units as 
0 
*/

SELECT Toys.ToyID,COUNT(Transactions.Toyid) AS total_quantity
FROM Toys
LEFT JOIN Transactions
ON Toys.ToyID = Transactions.Toyid
GROUP BY Toys.ToyID;


/*
Question 3: The CEO of Toys corner wants to know which toy has the highest total Quantity sold. 
Display CName, ToyName, total Quantity sold of this toy. 
*/
SELECT TOP 1 Category.cname,Toys.ToyName,COUNT(Transactions.Quantity) AS total_Quantity_sold
FROM Toys
JOIN Transactions
ON Toys.ToyID = Transactions.Toyid
JOIN Category
ON Category.Cid = Toys.Cid
GROUP BY Category.cname,Toys.ToyName
ORDER BY COUNT(Transactions.Quantity) DESC;


SELECT TOP 1 Salary FROM Employees
WHERE Salary NOT IN (SELECT DISTINCT TOP 9 Salary
FROM Employees
ORDER BY Salary DESC)
ORDER BY Salary DESC;


SELECT *,(SELECT Avg(Salary) FROM Employees) AS AVG_SAL
FROM Employees


SELECT E1.Salary,E1.DepartmentID
FROM Employees E1
HAVING  AVG(Salary) IN (SELECT AVG(salary)
FROM Employees E2
WHERE E2.DepartmentID = E1.DepartmentID)


SELECT DepartmentID,SUM(Salary)
FROM Employees
GROUP BY DepartmentID
HAVING SUM(Salary) IN (SELECT MAX(Salary)
FROM Employees
GROUP BY DepartmentID);

SELECT DepartmentID
FROM tblDepartmentC d1
WHERE NOT EXISTS(SELECT 1 DepartmentID
FROM Employees e2
WHERE d1.DepartmentID = e2.DepartmentID )

SELECT DepartmentID
FROM tblDepartmentC d1
WHERE 1=ISNULL((SELECT DISTINCT DepartmentID
FROM Employees e2
WHERE d1.DepartmentID = e2.DepartmentID ),1)

SELECT DepartmentID
FROM tblDepartmentC d1
WHERE DepartmentID NOT IN((SELECT DepartmentID
FROM Employees e2
WHERE d1.DepartmentID = e2.DepartmentID )

USE Assignment2;

/*-----------------------------------------Assignment 6------------------------------------------*/


CREATE DATABASE BANK;

CREATE TABLE AccountType(
AccType INT PRIMARY KEY,
ACCOUNTName VARCHAR(30)
);

CREATE TABLE TransactionType(
TransType INT PRIMARY KEY,
TransName VARCHAR(50)
);


CREATE TABLE CustomerDetails(
AccNo INT PRIMARY KEY,
CustName VARCHAR(50),
CAddress VARCHAR(50),
AccType INT FOREIGN KEY REFERENCES AccountType(AccType)
);

CREATE TABLE AccountTransaction(
Tid INT PRIMARY KEY,
AccNo INT FOREIGN KEY REFERENCES CustomerDetails(Accno),
Amount MONEY,
DateOfTrans DATETIME,
TransType INT FOREIGN KEY REFERENCES TransactionType(TransType)
);


/*
1.List the Customer with transaction details who has done third lowest  
transaction
*/
SELECT Top 1 CustomerDetails.AccNo,CustomerDetails.CustName,AccountTransaction.Amount,AccountTransaction.DateOfTrans
FROM CustomerDetails
INNER JOIN AccountTransaction
ON AccountTransaction.AccNo = CustomerDetails.AccNo
WHERE AccountTransaction.Amount NOT IN (SELECT TOP 2 AccountTransaction.Amount
FROM AccountTransaction
ORDER BY AccountTransaction.Amount)
ORDER BY AccountTransaction.Amount;


/*
2.List the customers who has done more transactions than average number of  
transaction  
*/

SELECT AccountTransaction.AccNo,CustomerDetails.CustName,COUNT(AccountTransaction.AccNo) AS COUNT_OF_TRANS
FROM AccountTransaction
INNER JOIN CustomerDetails
ON AccountTransaction.AccNo = CustomerDetails.AccNo
GROUP BY AccountTransaction.AccNo,CustomerDetails.CustName
HAVING COUNT(AccountTransaction.AccNo) > (SELECT AVG(TranscationCount)
FROM (SELECT COUNT(AccountTransaction.Tid)AS TranscationCount 
FROM AccountTransaction
GROUP BY AccountTransaction.AccNo) AS TransactionC  )


/*3.List the total transactions under each account type. */

SELECT AccountTransaction.AccNo,AccountType.ACCOUNTName,COUNT(AccountTransaction.Tid) AS NUM_OF_TRANS
FROM AccountTransaction
INNER JOIN CustomerDetails
ON CustomerDetails.AccNo = AccountTransaction.AccNo
INNER JOIN AccountType
ON AccountType.AccType = CustomerDetails.AccType
GROUP BY AccountTransaction.AccNo,AccountType.ACCOUNTName;

/*4.List the total amount of transaction under each account type */


SELECT AccountType.ACCOUNTName,AccountTransaction.AccNo,SUM(AccountTransaction.Amount) AS NUM_OF_TRANS
FROM AccountTransaction
JOIN CustomerDetails
ON CustomerDetails.AccNo = AccountTransaction.AccNo
RIGHT JOIN AccountType
ON CustomerDetails.AccType = AccountType.AccType
GROUP BY AccountType.ACCOUNTName,AccountTransaction.AccNo;	


/*5. List the total tranctions along with the total amount on a Sunday. */

SELECT COUNT(Tid),SUM(AccountTransaction.Amount) AS NUM_OF_TRANS
FROM AccountTransaction
WHERE DATENAME(DW,DateOfTrans) = 'sunday'	


/*6. List the name, address, account type and total deposit from each customer 
account. */

SELECT CustomerDetails.CustName,CustomerDetails.CAddress,AccountType.ACCOUNTName,SUM(AccountTransaction.Amount) AS total_deposit
FROM CustomerDetails
INNER JOIN AccountType
ON AccountType.AccType = CustomerDetails.AccType
INNER JOIN AccountTransaction
ON AccountTransaction.AccNo = CustomerDetails.AccNo
RIGHT JOIN TransactionType
ON TransactionType.TransType = AccountTransaction.TransType
WHERE TransactionType.TransName !='Debit'
GROUP BY CustomerDetails.CustName,CustomerDetails.CAddress,AccountType.ACCOUNTName;

/*
7. List the total amount of transactions of Mysore customers.
*/

SELECT SUM(AccountTransaction.Amount) AS Total_Amt 
FROM AccountTransaction
INNER JOIN CustomerDetails
ON CustomerDetails.AccNo = AccountTransaction.AccNo
RIGHT JOIN TransactionType
ON TransactionType.TransType = AccountTransaction.TransType
WHERE CustomerDetails.CAddress = 'Mysore' AND TransactionType.TransName !='Debit';

/*
8. List the name,account type and the number of transactions performed by each customer
*/

SELECT CustomerDetails.CustName,AccountType.ACCOUNTName,COUNT(AccountTransaction.Tid) AS NUM_OF_Transaction
FROM CustomerDetails
LEFT JOIN AccountTransaction
ON CustomerDetails.AccNo = AccountTransaction.AccNo
INNER JOIN AccountType
ON CustomerDetails.AccType = AccountType.AccType
GROUP BY CustomerDetails.CustName,AccountType.ACCOUNTName;


/*9. List the amount of transaction from each Location. */

SELECT CustomerDetails.CAddress,COUNT(AccountTransaction.Tid) AS Num_Of_Transaction
FROM AccountTransaction
RIGHT JOIN CustomerDetails
ON CustomerDetails.AccNo = AccountTransaction.AccNo
GROUP BY CustomerDetails.CAddress;


/*10. Find out the number of customers  Under Each Account Type */

SELECT AccountType.ACCOUNTName,COUNT(CustomerDetails.AccNo) AS Number_Of_Customer
FROM AccountType
RIGHT JOIN CustomerDetails
ON CustomerDetails.AccType = AccountType.AccType
GROUP BY AccountType.ACCOUNTName;



/*-----------------------------------------Assignment 7------------------------------------------*/

/*
Salesman (Sid, Sname, Location) 
Product (Prodid, Pdesc, Price, Category, Discount) 
Sale (Saleid, Sid, Sldate, Amount) 
Saledetail (Saleid, Prodid, Quantity) 
*/

CREATE TABLE Salesman(
Sid int PRIMARY KEY,
sname VARCHAR(30) NOT NULL,
Slocation VARCHAR(50) NOT NULL
);

CREATE TABLE Product(
Prodid INT PRIMARY KEY, 
Pdesc VARCHAR(20),
Price MONEY,
Category VARCHAR(20),
Discount INT);

CREATE TABLE Sale (
Saleid INT PRIMARY KEY, 
Sid INT FOREIGN KEY REFERENCES Salesman(Sid),
Sldate DATE,
Amount MONEY);

CREATE TABLE Saledetail (
Saleid INT PRIMARY KEY,
Prodid INT FOREIGN KEY REFERENCES Product(Prodid),
Quantity INT);


/*
1.Display the sale id and date for most recent sale.
*/

SELECT TOP 1 Sale.Saleid,Sale.Sldate
FROM Sale
ORDER BY Sldate DESC;


/*2.Display the names of salesmen who have made at least 2 sales. */

SELECT Salesman.sname
FROM Salesman
WHERE Salesman.Sid IN(SELECT Sale.Sid
FROM Sale
GROUP BY Sale.Sid
HAVING COUNT(Sale.Sid)>1)


/*3.Display the product id and description of those products which are sold in 
minimum total quantity. 
*/

SELECT Product.Prodid,Product.Pdesc
FROM Product
INNER JOIN Saledetail
ON Product.Prodid = Saledetail.Prodid


SELECT Product.Prodid,Product.Pdesc
FROM Product
WHERE Product.Prodid IN (SELECT Saledetail.Prodid
FROM Saledetail
GROUP BY Saledetail.Prodid
HAVING SUM(Quantity) < (SELECT AVG(Quantity) FROM Saledetail)
)


/*
4. Display SId, SName and Location of those salesmen who have total sales 
amount greater than average sales amount of all the sales made. Amount can 
be calculated from Price and Discount of Product and Quantity sold. 
*/

SELECT Sid,sname,Slocation
FROM Salesman
WHERE Sid IN(SELECT Sale.Sid
FROM Sale
INNER JOIN Saledetail
ON Saledetail.Saleid = Sale.Saleid
INNER JOIN Product
ON Product.Prodid = Saledetail.Prodid
GROUP BY Sid
HAVING SUM((Product.Price * Product.Discount)- Saledetail.Quantity ) > AVG((Product.Price *  Product.Discount)- Saledetail.Quantity))


USE Assignment2


CREATE VIEW VIEW_EMPLOYEE_new
AS (
SELECT *
FROM Employees e)

SELECT EmployeeID,Employee_FirstName
FROM VIEW_EMPLOYEE

SP_HELPTEXT VIEW_EMPLOYEE


CREATE VIEW VIEW_Dept
AS (SELECT * FROM tblDepartmentC)

SELECT VIEW_Dept.DepartmentName,dbo.VIEW_EMPLOYEE_new.Employee_FirstName
FROM VIEW_Dept 
INNER JOIN VIEW_EMPLOYEE
ON VIEW_Dept.DepartmentID = VIEW_EMPLOYEE_new.DepartmentID

CREATE VIEW VIEW_EMPLOYEE_new
WITH ENCRYPTION,SCHEMABINDING AS(
SELECT dbo.Employees.EmployeeID,dbo.Employees.Employee_FirstName
FROM dbo.Employees )
CREATE USER Ganesh IDENTIFIED 
 GRANT SELECT ON ORDERS to GANESH

 GRANT CONNECT TO Ganesh IDENTIFIED BY password


SELECT * FROM tblStudentDtl
SELECT * FROM tblStudentSubMarks
SELECT * FROM tblSubjectDtl

CREATE TABLE GRADE(
lbound int,
ubound int,
grade CHAR)

SELECT tblStudentDtl.StudentName,tblSubjectDtl.SubjectName,tblStudentSubMarks.Marks,GRADE.grade
FROM tblStudentDtl
INNER JOIN tblStudentSubMarks
ON tblStudentDtl.StudentID = tblStudentSubMarks.StudentId
INNER JOIN tblSubjectDtl
ON tblSubjectDtl.SubjectID = tblStudentSubMarks.SubjectID
INNER JOIN GRADE
ON Marks BETWEEN lbound AND ubound;



/* 5. Display the product id, category, description and price for those products whose 
price is maximum in each category. */


SELECT p1.Prodid,p1.Category,p1.Pdesc,p1.Price
FROM Product AS p1
WHERE p1.Price IN ( SELECT MAX(p2.Price) AS MAX_Price
 FROM Product p2
 WHERE p2.Category = P1.Category
 GROUP BY p2.Category
 )




/*6. Display the names of salesmen who have not made any sales. */

SELECT A.sname
FROM SALESMAN AS A
WHERE A.Sid NOT IN (SELECT B.Sid
				FROM  Sale AS B
				WHERE A.Sid = B.Sid)


/*7. Display the names of salesmen who have made at least 1 sale in the month of 
Jun 2015.*/

SELECT A.sname
FROM SALESMAN AS A
JOIN (SELECT B.Sid
				FROM  Sale AS B
				WHERE DATEPART(yyyy,B.Sldate) = 2015 AND DATEPART(MM,B.Sldate) = 06
				GROUP BY B.Sid
				HAVING COUNT(B.Sldate) >= 1) as subquery
ON A.Sid = subquery.Sid
/*
8. Display SId, SName and Location of those salesmen who have total sales 
amount greater than average total sales amount of their location calculated per 
salesman. Amount can be calculated from Price and Discount of Product and 
Quantity sold. 
*/

SELECT s.Sid,s.sname,s.Slocation
FROM Salesman s
INNER JOIN Sale sa
s.Sid = sa.Sid
INNER JOIN 



DECLARE @count INT = 1
WHILE @count < 10
BEGIN
IF @count<5
PRINT 'Hello'
ELSE
BREAK
END

DECLARE @COUNT INT =0
WHILE @COUNT < 100
BEGIN
PRINT @COUNT
SET @count = @count + 2
END

--CHECK EVEN OR ODD
DECLARE @CHECK INT = 10
IF @CHECK % 2 = 0
print CONCAT('EVEN',' ',@CHECK)
ELSE
PRINT CONCAT('ODD',' ',@CHECK)


--FIBONACCI SERIES
DECLARE @ONE BIGINT = 0
DECLARE @TWO BIGINT = 1
DECLARE @NEXT BIGINT = 0
DECLARE @COUNT INT = 2
WHILE @count <= 50
BEGIN
SET @count =  @count + 1 
SET @ONE = @TWO
SET @TWO = @NEXT
SET @NEXT = @ONE + @TWO
PRINT @NEXT
END


SELECT EmployeeID,Employee_FirstName,Elocation,
CASE
WHEN Elocation IN('mysore','Shivamogga','manglore') THEN 'tyre 2'
WHEN Elocation IN('banglore','hydrabad') THEN 'METRO'
END AS TYRE
FROM Employees;


DECLARE @month VARCHAR(10) 
SET @month = DATENAME(MONTH,GETDATE())
if(@month = 'November')
BEGIN
SELECT Employees.Employee_FirstName,Employees.Salary,Employees.Salary+10000 AS Total_salary
FROM Employees
PRINT @month
END
ELSE 
PRINT ' NO Bonus'


CREATE TABLE STUDENT_new(
USN INT PRIMARY KEY,
Sname VARCHAR(20),
); 

CREATE TABLE RESULT(
mid INT,
USN INT, 
MARKS INT,
PRIMARY KEY(mid),
FOREIGN KEY(USN) REFERENCES STUDENT_new(USN)
);


/*3.Write query to find the grade of a student, if he scores above 90 its 'A’, 
above 80 'B', above 70 ‘C’, above 60 ‘D’, above 50 ‘F’ or else print 
failed.(Hint: Use Case ) */


SELECT s.USN,s.Sname,(
CASE
WHEN R.MARKS >= 90 THEN 'A'  
WHEN R.MARKS >= 80 AND R.MARKS <=89 THEN 'B'  
WHEN R.MARKS = 70 AND R.MARKS <= 79 THEN 'C'  
WHEN R.MARKS = 60 AND R.MARKS <= 69 THEN 'D'  
WHEN R.MARKS > 50 AND R.MARKS <= 59 THEN 'F'
ELSE
'Failed'
END)
FROM RESULT AS R 
JOIN STUDENT_new s
ON R.usn = s.usn


/*4. Display month on which the employee is born. Use case statement.*/

SELECT (CASE
WHEN DATENAME(MONTH,E.JoiningDate) = 'January' THEN 'January'
WHEN DATENAME(MONTH,E.JoiningDate) = 'February' THEN 'February'
WHEN DATENAME(MONTH,E.JoiningDate) = 'March' THEN 'March'
WHEN DATENAME(MONTH,E.JoiningDate) = 'April' THEN 'April'
WHEN DATENAME(MONTH,E.JoiningDate) = 'May' THEN 'May'
WHEN DATENAME(MONTH,E.JoiningDate) = 'June' THEN 'June'
WHEN DATENAME(MONTH,E.JoiningDate) = 'July' THEN 'July'
WHEN DATENAME(MONTH,E.JoiningDate) = 'august' THEN 'august'
WHEN DATENAME(MONTH,E.JoiningDate) = 'September' THEN 'September'
WHEN DATENAME(MONTH,E.JoiningDate) = 'November' THEN 'November'
WHEN DATENAME(MONTH,E.JoiningDate) = 'october' THEN 'october'
WHEN DATENAME(MONTH,E.JoiningDate) = 'December' THEN 'January'
END) AS JOIN_DATE
FROM Employees E;


/*5. Write T-SQL statements to generate 10 prime numbers greater than 1000.*/

DECLARE @n INT = 1000
DECLARE @i INT = 1001
DECLARE @flag INT =  1
DECLARE @CN INT = 0
WHILE (@CN <10)
BEGIN
SET @CN = @CN +1
SET @i = @i + 1
if(@n % @i = 0)
BEGIN
SET @flag = 0
END
SET @n = @n +1 
if(@flag =1)
BEGIN
PRINT @n
END
SET @n = @n + 1
END


/*6.Consider HR Database and generate bonus to employees as below: 
	A)one month salary  if Experience>10 years  
	B)50% of salary  if experience between 5 and 10 years  
	C)Rs. 5000  if Eexperience less than 5 years 
*/

DECLARE @Experence int = 0,@counts int,@cnn int = 0 
SELECT @counts = COUNT(joiningdate)
FROM Employees
WHILE (@cnn > @counts)
BEGIN
SELECT @Experence = DATEPART(yyyy,joiningdate)
FROM Employees
if(@Experence > 10)
BEGIN
UPDATE Employees
SET TotalBonus = Salary * 2
END
if(@Experence > 5 AND @Experence < 10 )
BEGIN
UPDATE Employees
SET TotalBonus = Salary / 2
END
if(@Experence < 5)
BEGIN
UPDATE Employees
SET TotalBonus = Salary + 5000
END
SET @cnn = @cnn + 1
END

/*
UPDATE Employees
SET TotalBonus = Salary * 2
WHERE DATEDIFF(yyyy,joiningdate,GETDATE()) > 10;
*/


--SELECT * FROM sys.sysmessages
BEGIN TRY
	DECLARE @cid int = 101,@lstock int = 0,@tid VARCHAR(5) = 'T1001',@Quantity int = 3
	DECLARE @txnid int =1005

	SELECT @lstock = Stock
	FROM Toys
	WHERE @tid = ToyID
		
	if(@lstock = 0 OR @lstock < @Quantity)
	BEGIN
	INSERT INTO Transactions VALUES (@txnid,@cid,@tid,@Quantity,1200)
	UPDATE Toys
	SET Stock = Stock - @Quantity
	WHERE ToyID = @tid
	END
	ELSE
	print'OUT of stock or insufficient stock'
END TRY

BEGIN CATCH

	if(ERROR_NUMBER() = 547)
	PRINT 'ENTER a valid customer id'
	IF(ERROR_NUMBER() = 2627)
	PRINT 'Duplicate vales are not allowed in Transaction id' 


END CATCH

CREATE PROCEDURE usp
AS
BEGIN
SELECT * FROM Transactions
END

usp


-- Question 2

DECLARE @SQLData VARCHAR(20)
SELECT @SQLData = 'SQL' AS STING 



CREATE TABLE tblProject
(
   ProjectId BIGINT PRIMARY KEY,
   Name VARCHAR(100) NOT NULL,
   Code NVARCHAR(50) NOT NULL,
   ExamYear SMALLINT NOT NULL
);


CREATE TABLE tblExamCentre 
(
  ExamCentreId BIGINT PRIMARY KEY,
  Code VARCHAR(100) NULL,
  Name VARCHAR(100)  NULL
);

CREATE TABLE tblProjectExamCentre
(
   ProjectExamCentreId BIGINT PRIMARY KEY,
   ExamCentreId BIGINT NOT NULL FOREIGN KEY REFERENCES tblExamCentre(ExamCentreId),
   ProjectId BIGINT FOREIGN KEY REFERENCES tblProject(ProjectId)
);





INSERT INTO tblProject(ProjectId,Name,Code,ExamYear) VALUES
(1,	'8808-01-CW-YE-GCEA-2022',	'PJ0001',	2022),
(2,	'6128-02-CW-YE-GCENT-2022',	'PJ0002',	2022),
(3, '7055-02-CW-YE-GCENA-2022','PJ0003',	2022),
(4,	'8882-01-CW-YE-GCEA-2022','	PJ0004',	2022),
(5,'7062-02-CW-YE-GCENT-2022',	'PJ0005',	2022),
(8,	'6128-02-CW-YE-GCENT-1000',	'PJ0008',	1000),
(9,	'7062-02-CW-YE-GCENT-5000',	'PJ0009',	5000),
(10,'8808-01-CW-YE-GCEA-2023',	'PJ0010',	2023),
(11,'8808-01-CW-YE-GCEA-2196',	'PJ0011',	2196),
(15,'6073-02-CW-YE-GCENA-2022',	'PJ0015',	2022),
(16,'8808-01-CW-YE-GCE0-2022',	'PJ0016',	2022);


INSERT INTO tblExamCentre(ExamCentreId,Name,Code) VALUES
(112,'VICTORIA SCHOOL-GCENA-S','2711'),
(185,'NORTHBROOKS SECONDARY SCHOOL-GCENA-S','2746'),
(227,'YIO CHU KANG SECONDARY SCHOOL-GCENA-S','2721'),
(302,'CATHOLIC JUNIOR COLLEGE','9066'),
(303,'ANGLO-CHINESE JUNIOR COLLEGE','9067'),
(304,'ST. ANDREW''S JUNIOR COLLEGE','9068'),
(305,'NANYANG JUNIOR COLLEGE','9069'),
(306,'HWA CHONG INSTITUTION','9070'),
(1,NULL,'2011'),
(2,'NORTHBROOKS SECONDARY SCHOOL-GCENA-S',NULL);


INSERT INTO tblProjectExamCentre(ProjectExamCentreId,ProjectId,ExamCentreId) VALUES
(44,1,112),
(45,1,227),
(46,1,185),
(47,2,112),
(48,2,227),
(49,2,185),
(50,3,112),
(51,3,227),
(52,3,185),
(69,4,112);

select * from tblProject
select * from tblExamCentre
select * from tblProjectExamCentre


/*
1.Write a procedure to fetch the ProjectId, ProjectName, ProjectCode, ExamCentreName
and ExamCentreCode from the tables tblProject and 
tblExamCentre based on the ProjectId and ExamCentreId passed as input parameters.
 */
CREATE PROCEDURE usp1 (@pid INT,@Eid INT)
AS
BEGIN
	 SELECT tp.ProjectId,tp.Name,tp.Code,tec.Name,tec.Code
	 FROM tblProject tp
	 INNER JOIN tblProjectExamCentre tpc
	 ON tpc.ProjectId = tp.ProjectId
	 INNER JOIN tblExamCentre tec
	 ON tpc.ExamCentreId = tec.ExamCentreId
	 WHERE tp.ProjectId = @pid AND tec.ExamCentreId = @Eid
END


usp1 2,112


/*
2.Write a procedure to insert values into the table tblProject when the data for the ProjectId 
which is being inserted does not exist in the table.
*/

CREATE PROCEDURE usp2_NEW(@pid INT,@Name VARCHAR(20),@Code VARCHAR(6),@Exam_Year INT)
AS
BEGIN
	IF(@pid NOT IN(SELECT ProjectId 
	FROM tblProject))
	BEGIN
		INSERT INTO tblProject VALUES(@pid,@Name,@Code,@Exam_Year)
	END
	ELSE
	PRINT'Row already exist'
END

EXEC usp2_NEW 7,'8808-01-CW-YE-GCEA-2022','pj0001',2022


/*
3.Write a procedure to update the columns-Code and Name in tblExamCentre when either of 
the Code or the Name column is NULL 
and also delete the records from the table tblProjectExamCentre when ProjectId IS 4.
*/

CREATE PROCEDURE usp3
AS
BEGIN
	UPDATE tblExamCentre
	SET Code = 2011,Name = 'VICTORIA SCHOOL-GCENA-S'
	WHERE Code IS NULL OR Name IS NULL

	DELETE tblProjectExamCentre
	WHERE ProjectId = 4
END

usp3

/*4.Write a procedure to fetch the total count of records present in the table 
tblProject based on the ProjectId AS OUTPUT parameter
and also sort the records in ascending order based on the ProjectName.*/

CREATE PROC usp4(
@count INT OUTPUT)
AS
BEGIN
	SELECT @count = (
	SELECT COUNT(*)
	FROM tblProject)
END

DECLARE @out INT 
EXEC usp4 @out OUTPUT 
PRINT @out


/*5.Write a procedure to create a Temp table named 
Students with columns- StudentId,StudentName and Marks where the 
column StudentId is generated automatically 
and insert data into the table and also retrieve the data.*/

CREATE PROC usp5(@Name VARCHAR(20),@marks INT) 
AS
BEGIN
	CREATE TABLE #students(
	StudentId INT IDENTITY(1,1) PRIMARY KEY,
	StudentName VARCHAR(20),
	Marks int
	)
	INSERT INTO #students(StudentName,Marks) VALUES(@Name,@marks)
	SELECT * FROM #students
END

usp5 'dinesh',60


+
/*6.Write a procedure to perform the following DML operations on the 
column - ProjectName in tblProject table by using a varibale. 
Declare a local variable and initialize it to value 0, 
1. When the value of the variable is equal to 2, then insert another record into the table tblProject.
2. When the value of the variable is equal to 10, then change the 
ProjectName to 'Project_New' for input @ProjectId

In the next part of the stored procedure, return all the fields
of the table tblProject(ProjectId,ProjectName,Code and Examyear)
based on the ProjectId and for the column ExamYear display it as given using CASE statement.
1.If the ExamYear is greater than or equal to 2022 then display 'New'
2.If the ExamYear is lesser than or equal to 2022 then display 'Old'
*/

ALTER PROCEDURE usp6
    @ProjectId BIGINT,
    @VariableValue INT = 0
AS
BEGIN
    SET NOCOUNT ON;

    -- Check the value of the variable
    IF @VariableValue = 2
    BEGIN
        -- When the variable value is 2, insert another record into tblProject
        INSERT INTO tblProject (ProjectId,Name, Code, ExamYear)
        VALUES (14,'New Project', 'NP0001', 2023);
    END
    ELSE IF @VariableValue = 10
    BEGIN

 -- When the variable value is 10, change the ProjectName to 'Project_New'
        UPDATE tblProject
        SET Name = 'Project_New'
        WHERE ProjectId = @ProjectId;
    END

    -- Retrieve and display data from tblProject with ExamYear as 'New' or 'Old'
    SELECT 
        ProjectId,
        Name,
        Code,
        CASE
            WHEN ExamYear >= 2022 THEN 'New'
            ELSE 'Old'
        END AS ExamYear
    FROM tblProject
    WHERE ProjectId = @ProjectId;
END;

exec usp6 2,2
exec usp6 2,10

SELECT * 
INTO Translogs
FROM tblEmployeeDt1
WHERE 1 = 0; 

SELECT * FROM Translogs
CREATE TABLE AUDIT(id INT,auditData VARCHAR(100))

--INSTED OF FOR
ALTER TRIGGER tgr1 
ON tblEmployeeDt1
FOR INSERT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Id INT
	SELECT @Id = Employeeid
	FROM INSERTED
	INSERT INTO AUDIT VALUES(@Id,'New USER '+CAST(@Id AS VARCHAR(5))+' '+'Created'+CAST(GETDATE() AS VARCHAR(12)))
END



SELECT * FROM inserted
SELECT * FROM AUDIT


CREATE TRIGGER tgr2 
ON tblEmployeeDt1
FOR UPDATE
AS
BEGIN
	
END

UPDATE tblEmployeeDt1 
SET Employeeid = 12
WHERE Employeeid = 11

--DELETE FOR TRIGGER
ALTER TRIGGER tgr1 
ON tblEmployeeDt1
FOR DELETE
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Id INT
	SELECT @Id = Employeeid
	FROM DELETED
	INSERT INTO AUDIT VALUES(@Id,'USER '+CAST(@Id AS VARCHAR(5))+' '+'DELETED'+CAST(GETDATE() AS VARCHAR(12)))
END

DELETE FROM AUDIT
WHERE id IS NULL;





CREATE TABLE Employee( 
Id INT IDENTITY(1,1),
Name VARCHAR(20),
Salary INT , 
Gender VARCHAR(10),
Department_id INT)

--update

CREATE TABLE tblEmployeeAudit​
(​
 Id int identity(1,1) primary key,​
 AuditData nvarchar(1000)​
) 

-- CREATE TRIGGER EXAMPLE

ALTER trigger tr_tblEmployee_Update​
on Employee​
for Update​
as​
Begin​
	  SET NOCOUNT ON
      Declare @Id int​
      Declare @OldName nvarchar(20), @NewName nvarchar(20)​
      Declare @OldSalary int, @NewSalary int​
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)​
      Declare @OldDeptId int, @NewDeptId int​
     ​
      Declare @AuditString nvarchar(1000)​
      ​
      Select *​
      into #TempTable​
      from inserted​
     
      WHILE(Exists(Select Id from #TempTable))​
      Begin​
            Set @AuditString = ''​
            Select Top 1 @Id = Id, @NewName = Name, ​
            @NewGender = Gender, @NewSalary = Salary,​
            @NewDeptId = Department_Id​
            from #TempTable​
           ​
            Select @OldName = Name, @OldGender = Gender, ​
            @OldSalary = Salary, @OldDeptId = Department_Id​
            from deleted where Id = @Id​
      ​
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + 'changed'​ 

            if(@OldName <> @NewName)​
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' +@NewName​ 

                 ​
            if(@OldGender <> @NewGender)​
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender​

                 ​
            if(@OldSalary <> @NewSalary)​
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))​

                  ​
    if(@OldDeptId <> @NewDeptId)​
                  Set @AuditString = @AuditString + ' DepartmentId from ' +Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))​ 

           ​
            insert into tblEmployeeAudit values(@AuditString)​
            ​
          
            Delete from #TempTable where Id = @Id​
      End​
End

SELECT * FROM Employee

UPDATE Employee
SET Name = 'raju',Salary = Salary + 1000

SELECT * FROM tblEmployeeAudit


-- 
ALTER TABLE tblEmployeeDt1
ADD Bonus INT;


--INSTED OF

CREATE TABLE tblEmployee​
(​
 Id int Primary Key,​
 Name nvarchar(30),​
 Gender nvarchar(10),​
 DepartmentId int​
)​
​
CREATE TABLE tblDepartment​
(​
DeptId int Primary Key,​
DeptName nvarchar(20)​
)​
​
--Insert data into tblDepartment table​
Insert into tblDepartment values (1,'IT')​
Insert into tblDepartment values (2,'Payroll')​
Insert into tblDepartment values (3,'HR')​
Insert into tblDepartment values (4,'Admin')​
​
--Insert data into tblEmployee table​
Insert into tblEmployee values (1,'John', 'Male', 3)​
Insert into tblEmployee values (2,'Mike', 'Male', 2) 
Insert into tblEmployee values (3,'Pam', 'Female', 1)​
Insert into tblEmployee values (4,'Todd', 'Male', 4)​
Insert into tblEmployee values (5,'Sara', 'Female', 1)​
Insert into tblEmployee values (6,'Ben', 'Male', 3) 
 

 --insted of trigger INSERT 

Create trigger tr_vWEmployeeDetails_InsteadOfInsert​
on vWEmployeeDetails​
Instead Of Insert​
as​
Begin​
Declare @DeptId int​
​
Select @DeptId = DeptId ​
from tblDepartment ​
join inserted​
on inserted.DeptName = tblDepartment.DeptName​
if(@DeptId is null)​
Begin​
Raiserror('Invalid Department Name. Statement terminated', 16, 1)​
return​
End​
Insert into tblEmployee(Id, Name, Gender, DepartmentId)​
Select Id, Name, Gender, @DeptId​
from inserted​
End 


/*
1.Consider table tblEmployeeDtls and write a stored procedure to generate 
bonus to employees for the given date  as below: 
A)One month salary  if Experience>10 years  
B)50% of salary  if experience between 5 and 10 years  
C)Rs. 5000  if experience is less than 5 years 
Also, return the total bonus dispatched for the year as output parameter. 
*/

CREATE PROC usp_Bonus(@year DATE)
AS
BEGIN
DECLARE @JoinDate DATE,@EmployeeID INT
SELECT * INTO #temp FROM tblEmployeeDtLC 
WHILE(EXISTS(SELECT * FROM #temp))
BEGIN
SELECT @JoinDate = JoiningDate,@EmployeeID = EmployeeID
FROM #temp
IF(DATEDIFF(yyyy,@JoinDate,@year)>10)
BEGIN
UPDATE tblEmployeeDtLC
SET Bonus = Salary
WHERE EmployeeID = @EmployeeID
END
ELSE IF(DATEDIFF(yyyy,@JoinDate,@year)>5 AND DATEDIFF(yyyy,@JoinDate,@year)<10)
BEGIN
UPDATE tblEmployeeDtLC
SET Bonus = (Salary) / 2
WHERE EmployeeID = @EmployeeID
END
ELSE
BEGIN
UPDATE tblEmployeeDtLC
SET Bonus = 5000
WHERE EmployeeID = @EmployeeID
END
DELETE FROM #temp WHERE EmployeeID = @EmployeeID
END
SELECT SUM(Bonus)
FROM tblEmployeeDtLC
END


EXEC usp_Bonus '2023-05-21'



DECLARE @oop INT
EXEC pr1 '2022-11-12',@oop OUTPUT
SELECT @oop


SELECT * FROM tblEmployeeDt1

/* 2. Create a stored procedure that returns a 
sales report for a given time period 
for a given Sales Person. Write commands to invoke the procedure
*/

ALTER PROC pr2(@startdate DATE,@enddate DATE,@sid INT)
AS
BEGIN
	IF(@sid IN (SELECT sid FROM Salesman))
	BEGIN
		SELECT * 
		FROM Sale
		WHERE Sldate BETWEEN @startdate AND @enddate AND Sid = @sid 
	END
	ELSE
		PRINT'Salesman not exists'
END


EXEC pr2 '2020/01/01','2023/11/10',104


/*
3. Also generate the month and maximum ordervalue booked by the given 
salesman(use output parameter) 
Tables 
SALESMAN 
SalesmanNo, Customerno, Orderno 
Customers 
CustomerNo,CustomerName, SalesmanNo, OrderNo 
Orders 
Orderno, ProductNo, Qty, CustomerNo, OrderDate 
Products 
ProdctNo, ProductName, UnitPrice,Discount 
*/

ALTER PROC pr3(@startdate DATE,@enddate DATE,@sid INT,
@month VARCHAR(10) OUTPUT,@max INT OUTPUT)
AS
BEGIN
	IF(@sid IN (SELECT sid FROM Salesman))
		BEGIN
		SELECT TOP 1 @month = DATENAME(MONTH,Sldate),@max = Amount 
		FROM Sale
		WHERE Sldate BETWEEN @startdate AND @enddate AND Sid = @sid
		ORDER BY Amount DESC
		END
	ELSE
	PRINT'Salesman not exists'
END


DECLARE @month VARCHAR(10),@Max_Amt INT
EXEC pr3 '2020/01/01','2023/11/10',103,@month OUTPUT,@Max_Amt OUTPUT
SELECT @month AS MONTH,@Max_Amt AS MAX_Amt


/*4.Consider Toy Centre database 
Procedure Name : usp_UpdatePrice 
Description:    This procedure is used to update the price of a 
given product. 
 
Input Parameters: 
∙ProductId 
∙Price 
Output Parameter 
    UpdatedPrice 
Functionality: 
∙Check if the product id is valid, i.e., it exists in the Products table 
∙If all the validations are successful, update the price in the table 
Products appropriately 
∙Set the output parameter to the updated price 
∙If the update is not successful or in case of exception, 
undo the entire operation and set the 
output parameter to 0 
Return Values: 
∙1 in case of successful update 
∙-1 in case of any errors or exception */

ALTER PROC usp_UpdatePrice(@productId VARCHAR(10),@price INT,
@updatedprice INT OUTPUT, @ou VARCHAR(10) OUTPUT)
AS
BEGIN
BEGIN TRANSACTION
	IF(@productId IN (SELECT ToyID FROM Toys))
	BEGIN
		UPDATE Toys
		SET Price = @price
		WHERE ToyID = @productId
		COMMIT
		SELECT @updatedprice = Price
		FROM Toys
		WHERE ToyID = @productId
		SET @ou = @productId
		RETURN 1
		END
	ELSE
	ROLLBACK
	RETURN -1
END 


DECLARE @out INT,@err INT,@ou VARCHAR(10)
EXEC @err =  usp_UpdatePrice 'T1006',3500,@out OUTPUT,@ou OUTPUT
if(@err = 1)
BEGIN
PRINT'Successfull Updated '+@ou+' With Price '+CAST(@out AS VARCHAR(10))
END
ELSE
BEGIN
PRINT 'product not found or some error occured'
END
PRINT @err



SELECT * FROM Toys
/*
5.Procedure Name : usp_InsertPurchaseDetails 
Description: 
This procedure is used to insert the purchase details into the 
table PurchaseDetails and 
update the available quantity of the product in the table
Products by performing the 
necessary validations based on the business requirements. 
Input Parameters: 
∙EmailId 
∙ProductId 
∙QuantityPurchased 
Output Parameter: 
    PurchaseId 
Functionality: 
∙Check if all the input parameters are not null 
∙Check if the Email is valid, i.e., it exists in the Users table 
∙Check if the product Id is valid, i.e., it exists in the Products table 
∙Check if the purchased quantity is greater than 0 
∙If all the validations are successful, insert the purchase details into the table 
PurchaseDetails 
∙Update the available quantity in the table Products appropriately 
∙Set the output parameter to the newly generated PurchaseId.If the insert or update 
is not successful, undo the entire operation and set the output parameter to 0 
Return Values : 
∙1 in case of successful insertion and update 
∙-1 if EmailId is null 
∙-2 if EmailId is not valid 
∙-3 if ProductId is null 
∙-4 if ProductId is not valid 
∙-5 if the QuantityPurchased is not valid or QuantityPurchased is null 
∙-99 if there is any exception 

5.(Toyid,cid,quantity) INPUT update(stock),insert(Trans) OUTPUT ID(TRAN_ID) 
*/

ALTER PROC usp_InsertPurchaseDetails(@ToyID VARCHAR(6),@CustID INT,
@Quantity INT,@trid INT,@txncost INT,@TransId INT OUTPUT)
AS
BEGIN
	IF(@ToyID IS NULL)
	RETURN -1
	IF(@CustID IS NULL)
	RETURN -2
	if(@ToyID NOT IN (SELECT Toyid FROM Toys))
	return -3
	if(@CustID NOT IN (SELECT custid FROM Customers))
	return -4
	if(@Quantity IS NULL OR @Quantity > (SELECT Stock FROM Toys
	WHERE ToyID = @ToyID))
	RETURN -5
	ELSE
		INSERT INTO Transactions VALUES(@trid,@CustID,@ToyID,@Quantity,@txncost)
		UPDATE Toys
		SET Stock = Stock - @Quantity
		WHERE ToyID = @ToyID
		SET @TransId = @trid
			RETURN 1
END

	
DECLARE @ret INT,@tid INT
EXEC @ret = usp_InsertPurchaseDetails 'T1001',103,2,1010,2034,@tid OUTPUT
PRINT @ret 

SELECT * FROM Toys
SELECT * FROM Transactions
------------------------------------------------------------------------


USE TEMPDB
GO

IF OBJECT_ID('dbo.orders') IS NOT NULL
	DROP TABLE dbo.orders;
GO
IF OBJECT_ID('dbo.customers') IS NOT NULL
	DROP TABLE dbo.Customers;
GO
CREATE DATABASE PRAC USE PRAc
CREATE TABLE dbo.Customers
(
	customerID CHAR(10) NOT NULL PRIMARY KEY,	
	city VARCHAR(10) NOT NULL
);

CREATE TABLE dbo.Orders
(
	OrderID INT NOT NULL PRIMARY KEY,
	customerID CHAR(10) 
)
GO

INSERT INTO dbo.customers(customerID, City) VALUES ('Chella','Bangalore');
INSERT INTO dbo.customers(customerID, City) VALUES ('Arun','Bangalore');
INSERT INTO dbo.customers(customerID, City) VALUES ('Vivek','Bangalore');
INSERT INTO dbo.customers(customerID, City) VALUES ('Sathiya','Chennai');

INSERT INTO dbo.Orders(OrderID, CustomerID) VALUES(1,'Arun')
INSERT INTO dbo.Orders(OrderID, CustomerID) VALUES(2,'Arun')
INSERT INTO dbo.Orders(OrderID, CustomerID) VALUES(3,'Vivek')
INSERT INTO dbo.Orders(OrderID, CustomerID) VALUES(4,'Vivek')
INSERT INTO dbo.Orders(OrderID, CustomerID) VALUES(5,'Vivek')
INSERT INTO dbo.Orders(OrderID, CustomerID) VALUES(7,'NULL')

SELECT * FROM dbo.Customers;
SELECT * FROM dbo.Orders;

SELECT C.CustomerID, cOUNT(O.OrderID) AS ordercount
FROM dbo.Customers AS C LEFT OUTER JOIN dbo.Orders AS O
ON C.CustomerID = O.cUSTOMERid --AND C.City = 'Bangalore'
WHERE C.City = 'Bangalore'
GROUP BY C.CustomerID
HAVING COUNT(O.OrderID) < 3
ORDER BY ORDERCOUNT;


CREATE OR ALTER FUNCTION DATE_convert(@date VARCHAR(12))
RETURNS VARCHAR(12)
BEGIN
RETURN (CONVERT(VARCHAR(12),@date,106))
END

SELECT dbo.DATE_convert(joiningdate)
FROM Employees


--write a function to display all employess with more than 10 years experience with following fromat
--empid,empname,joindate,Experience,salary,department_name,salary

CREATE FUNCTION Experience(@joining_date DATE,@CurDATE DATE)
RETURNS INT
BEGIN
RETURN(DATEDIFF(yyyy,@joining_date,@curdate))
END

SELECT e.employeeId,e.Employee_firstName,e.joiningdate,dbo.Experience(joiningdate,GETDATE()) AS EXPERIENCE,e.salary,d.departmentname
FROM Employees e
INNER JOIN tbldepartmentc d
ON e.departmentid = d.departmentID
WHERE dbo.EXPERIENCE(joiningdate,GETDATE()) > 10 

--Returning table function

 CREATE OR ALTER  FUNCTION Experience_new(@location VARCHAR(20))
RETURNS TABLE
AS
RETURN(SELECT e.employeeId,e.Employee_firstName,e.joiningdate,dbo.Experience(joiningdate,GETDATE()) AS EXPERIENCE,e.salary,d.departmentname
FROM Employees e
INNER JOIN tbldepartmentc d
ON e.departmentid = d.departmentID
WHERE dbo.Experience(joiningdate,GETDATE()) > 10 AND e.elocation = @location)

SELECT * FROM Experience_new('banglore')



/*------------------------------------------------------ASSIGNMENT 11-----------------------------------------------------*/

CREATE TABLE [tblUsers](
	[UserId]	VARCHAR(50)	Primary Key,
	[UserName]	VARCHAR(50)	NOT NULL,
	[Password]	VARCHAR(50)	NOT NULL,
	[Age]	INT	NOT NULL,
	[Gender]	CHAR(1)	NOT NULL,
	[EmailId]	VARCHAR(50)	UNIQUE,
	[PhoneNumber]	NUMERIC(10)	NOT NULL);

INSERT INTO [tblUsers]
VALUES
('mary_potter', 'Mary Potter', 'Mary@123', 25, 'F', 'mary_p@gmail.com', 9786543211),
('jack_sparrow', 'Jack Sparrow', 'Spar78!jack', 28, 'M', 'jack_spa@yahoo.com', 7865432102);


SELECT * FROM [tblUsers];

CREATE TABLE [tblTheatreDetails](
	[TheatreId]	INT	PRIMARY KEY, 
	[TheatreName] VARCHAR(50) NOT NULL,
	[Location] VARCHAR(50) NOT NULL);

INSERT INTO [tblTheatreDetails]
VALUES
	(1, 'PVR', 'Mysuru'),
	(2, 'Inox', 'Bengaluru');

SELECT * FROM [tblTheatreDetails];

CREATE TABLE [tblShowDetails](
	[ShowId] INT PRIMARY KEY IDENTITY(1001,1),
	[TheatreId] INT FOREIGN KEY REFERENCES [tblTheatreDetails]([TheatreId]),
	[ShowDate] DATE NOT NULL,
	[ShowTime] TIME NOT NULL,
	[MovieName] VARCHAR(50) NOT NULL,
	[TicketCost] DECIMAL(6,2) NOT NULL,
	[TicketsAvailable] INT NOT NULL);

INSERT INTO [tblShowDetails]
VALUES
	(1, '2023-11-28', '14:30:00', 'Avengers', 250.00, 100),
	(2, '2023-11-26', '17:30:00', 'Hit Man', 200.00, 150);

SELECT * FROM [tblShowDetails]

CREATE TABLE [tblBookingDetails](
[BookingId] VARCHAR(5) PRIMARY KEY,
[UserId] VARCHAR(50) FOREIGN KEY REFERENCES [tblUsers]([UserId]) NOT NULL,
[ShowId] INT FOREIGN KEY REFERENCES [tblShowDetails]([ShowId]) NOT NULL,
[NoOfTickets] INT NOT NULL,
[TotalAmt] DECIMAL(6,2) NOT NULL);

INSERT INTO [tblBookingDetails]
VALUES
('B1001', 'mary_potter', 1001, 2, 500.00),
('B1002', 'jack_sparrow', 1002, 5, 1000.00);

SELECT * FROM [tblBookingDetails]


ALTER PROC  usp_BookTheTicket(@booking_id VARCHAR(5),@userID varchar(20),@showid INT,@NoOfTickets INT)
AS
BEGIN
DECLARE @ttlamt INT 
SELECT @ttlamt = @NoOfTickets * TicketCost FROM tblShowDetails WHERE showid = @showid
if(@userID NOT IN(SELECT USERID FROM tblUsers))
	BEGIN
		RETURN -1
	END
if(@showid NOT IN(SELECT showid FROM tblUsers))
	BEGIN
		RETURN -2
	END
if(@NoOfTickets < 0)
	BEGIN
		RETURN -3
	END
if(@NoOfTickets > (SELECT TicketsAvailable FROM tblShowDetails WHERE ShowId = @showid))
	BEGIN
		RETURN -4
	END
	BEGIN TRY
		INSERT INTO tblBookingDetails VALUES(@booking_id,@userID,@showid,@NoOfTickets,@ttlamt)
	END TRY

	BEGIN CATCH
		if(ERROR_NUMBER = 2812)
		BEGIN
			PRINT''
		END
	END CATCH

RETURN 1
END


DECLARE @ret INT
EXEC  @ret = usp_BookTheTicket 'B1003','mary_potter',1001,2
print @ret
SELECT * FROM tblBookingDetails

--Function

--Question 1
CREATE OR ALTER FUNCTION dbo.ufn_GetMovieShowtimes(@MovieName VARCHAR(20),@Location VARCHAR(15))
RETURNS TABLE
AS
RETURN(SELECT tsd.MovieName,tsd.showdate,tsd.showtime,ttd.theatrename,tsd.ticketcost
      FROM tblShowDetails tsd
      INNER JOIN tblTheatreDetails ttd
      ON ttd.TheatreId = tsd.TheatreId
      WHERE tsd.MovieName = @MovieName AND ttd.location = @Location)

SELECT * FROM ufn_GetMovieShowtimes('Avengers','Mysuru')


--Question 2

CREATE OR ALTER FUNCTION dbo.ufn_BookedDetails(@bookingId VARCHAR(10))
RETURNS TABLE
AS
RETURN(SELECT BookingId,tu.username,
       MovieName,ttd.theatrename,tsd.ShowDate,tsd.ShowTime,NoOfTickets,TotalAmt
      FROM tblShowDetails tsd
      INNER JOIN tblTheatreDetails ttd
      ON ttd.TheatreId = tsd.TheatreId
	  INNER JOIN tblBookingDetails Tdb
	  ON tsd.ShowId = tdb.ShowId
	  INNER JOIN tblUsers tu
	  ON tu.UserId = tdb.UserId
      WHERE tdb.BookingId = @bookingId )

SELECT * FROM dbo.ufn_BookedDetails('B1001')