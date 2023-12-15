CREATE TABLE departments
(
   department_id INT PRIMARY KEY,
   department_name VARCHAR(100));

CREATE TABLE students
(
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100),
  student_department INT,
  stipend INT,
  CONSTRAINT fk_student FOREIGN KEY(student_department) REFERENCES departments(department_id));
  
INSERT INTO departments VALUES
(1,'Science'),
(2,'Commerce'),
(3,'Bio-Chemistry'),
(4,'Bio-Medical'),
(5,'Fine Arts'),
(6,'Literature'),
(7,'Animation'),
(8,'Marketing');

select student_id, student_name,student_department,stipend
from students order by student_id limit 20
INSERT INTO students VALUES
(1,'Hadria',7,2000),
(2,'Trumann',2,2000),
(3,'Earlie',3,2000),
(4,'Monika',4,2000),
(5,'Aila',5,2000),
(6,'Trina',5,2000),
(7,'Esteban',3,2000),
(8,'Camilla',1,2000),
(9,'Georgina',4,2000),
(10,'Reed',6,16000),
(11,'Northrup',7,2000),
(12,'Tina',2,2000),
(13,'Jonathan',	2,2000),
(14,'Renae',7,2000),
(15,'Sophi',6,16000),
(16,'Rayner',3,2000),
(17,'Mona',6,16000),
(18,'Aloin',5,2000),
(19,'Florance',5,2000),
(20,'Elsie',5,2000);


-- 1.Write a stored procedure to insert values into the student table
-- ans also update the student_department to 7 when the student_id
-- is between 400 and 700.
	CREATE OR REPLACE PROCEDURE sp_new(IN stuid INT,IN stu_name VARCHAR(30),
							IN stu_dep INT,IN stipend INT)
	LANGUAGE plpgsql
	AS
	$$
	BEGIN
		if stuid BETWEEN 400 AND 700
		THEN
			stu_dep := 7;
		END IF;
		
		BEGIN	
				INSERT INTO students(student_id,student_name,student_department,stipend)
				VALUES(stuid,stu_name,stu_dep,stipend);
			EXCEPTION
			WHEN OTHERS THEN 
				RAISE NOTICE 'Duplicate Data not allowed';
		END;
	END;
	$$
	
CALL sp_new(400,'raghu',2,1000);

SELECT * FROM students
-- 2.Write a procedure to update the department name to 'Animation'
-- when the department id is 7. This command has to be committed.
-- Write another statement to delete the record from the students
-- table based on the studentid passed as the input parameter.
-- This statement should not be committed.
CREATE OR REPLACE PROCEDURE sp_ins_upd(IN stuid INT)
LANGUAGE PLPGSQL
AS
$$
	BEGIN
		UPDATE departments
		SET department_name = 'cartoon'
		WHERE department_id = 7;
	COMMIT;
	BEGIN
				DELETE FROM students
				WHERE student_id = stuid;
			ROLLBACK ;
		EXCEPTION
			WHEN OTHERS THEN
			RAISE EXCEPTION 'data is not there';
		
END;
END;
$$

CALL sp_ins_upd(5);

SELECT * FROM students

CREATE PROCEDURE th()
AS $$
BEGIN
	SELECT * FROM adjcbhsv;
EXcePTION 
WHEN OTHERS THEN RAISE NOTICE 'HELLo';
END;
$$
LANGUAGE PLPGSQL;

CALL th()



SELECT * FROM departments
SELECT * FROM students


-- 3.Write a procedure to display the sum,average,
-- minimum and maximum values of the column stipend from the students table.

	CREATE OR REPLACE PROCEDURE sp_disp(
	OUT _sum INT,
	OUT _avg INT,
	OUT _min INT,
	OUT _max INT
	)
	LANGUAGE PLPGSQL
	AS
		$$
			BEGIN
				SELECT SUM(stipend),AVG(stipend),MIN(stipend),MAX(stipend) INTO 
				_sum ,_avg ,_min, _max 
				FROM students;
			END;
		$$
		
	CALL sp_disp(null,null,null,null);	
		
		BEGIN;
DECLARE	test ref cursor	
CALL sp_disp(OUT 'test');
fetch all in "test";
COMMIT;


-- 1.Fetch all the records from the table students 
-- where the stipend is more than 'Florence'

SELECT *
FROM Students
WHERE stipend NOT IN (SELECT stipend
				FROM Students
				WHERE student_name = 'Florance')


-- 2.Return all the records from the students table who
-- get more than the minimum stipend for the department 'FineArts'.

SELECT *
FROM students
WHERE stipend >(
				SELECT MIN(stipend)
				FROM students
				WHERE 
	student_department = (SELECT department_id
										   FROM departments
										   WHERE department_name = 'Fine Arts'))



SELECT * FROM departments
SELECT * FROM students

CREATE TABLE demo(
id INT )

CREATE OR REPLACE FUNCTION udf_new()
RETURNS VOID
AS
$$
BEGIN
-- CREATE TABLE demo(
-- id INT );
-- INSERT INTO demo VALUES(1);
UPDATE demo
SET id = 1000;
-- DROP TABLE demo;
-- DECLARE ret INT;
-- SELECT id INTO ret FROM demo 
-- RETURN ret;
END;
$$
LANGUAGE PLPGSQL;

SELECT udf_new()
SELECT * FROM demo

CREATE OR REPLACE FUNCTION udf_rand(IN var2 INT,OUT var3 INTEGER)
RETURNS VOID
AS 
$$
begin
   for counter in 1..5 loop
    var3 := var2 * counter;
	raise notice '% * % = %', var2,counter,var3;
   end loop;
END; $$
LANGUAGE PLPGSQL;

SELECT udf_rand(5)
CREATE VIEW view_new
AS
SELECT  FROM
students
JOIN departments
ON students.student_department_id = departments.department_id;


CREATE OR REPLACE triggers
RETURNS TRIGGER


