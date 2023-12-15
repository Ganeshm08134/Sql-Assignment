/*
Stored Procedures

They support procedural operations, which are helpful while building powerful database apps 
and it increases their performance, productivity, and scalability
The main reason for the concept of stored procedures is that in functions transcations cannot be executed.
ie., starting a transaction and commit or rollback it.

There are two types of stored procedures
1.Non-paramterised procedure
2.Parameterised procedure.

*/
--Non-paramterised procedure
CREATE OR REPLACE PROCEDURE sp_updatestipend()
LANGUAGE plpgsql
AS $$

BEGIN
	UPDATE students
	SET stipend = 16000
	WHERE student_department = 6;
	
	COMMIT;
END;
$$

CALL sp_updatestipend();

----Parameterised procedure

CREATE OR REPLACE PROCEDURE sp_updatemarks(increment_value INT)
LANGUAGE plpgsql AS $$
BEGIN 

UPDATE students 
SET subject1_marks = subject1_marks + increment_value;

COMMIT;
END; $$

CALL sp_updatemarks(4);
------in parameter
CREATE OR REPLACE PROCEDURE sp_proceduresample1(IN value_ INT)
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT COUNT(s.subject1_marks) INTO value_ 
	FROM students s 
	JOIN department d ON s.student_department = d.department_id;
    IF value_ IS NULL THEN 
		value_ := 1;
	END IF;
	raise notice '%',value_;
END
$$

CALL sp_proceduresample1(1);

----inout paramter
CREATE OR REPLACE PROCEDURE sp_proceduresample(INOUT value_ INT)
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT MIN(stipend) INTO value_ FROM students;
    IF value_ IS NULL THEN 
		value_ := 1;
	END IF;
END
$$

CALL sp_proceduresample(1);

SELECT * FROM students,departments


CREATE OR REPLACE PROCEDURE usp_new(IN stu_id INTEGER,IN stud_name VARCHAR(20))
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF(stu_id != NULL OR (NOT EXISTS(SELECT student_id FROM students where student_id = stu_id))) THEN
		 IF((stud_name IS NULL) OR (stud_name = '') OR (stud_name LIKE '__')) THEN
		 RAISE NOTICE 'null is not accepted';
		 ELSE 
		 INSERT INTO students VALUES(stu_id,stud_name,3,36444);
		 ROLLBACK;
-- 		 PERFORM  * FROM students;
		 END IF;
		 ELSE 
		 RAISE NOTICE 'student is present in table or null is not accepted';
	END IF;
END
$$
BEGIN;
CALL usp_new(22,'dhanush')
FETCH ALL IN "<unnamed portal 4>";
COMMIT

SELECT * FROM students;

DELETE FROM students
WHERE student_id IN(20,21)

CREATE OR REPLACE FUNCTION USP_stud()
RETURNS SETOF students
LANGUAGE PLPGSQL
AS
$$
DECLARE r1 refCURSOR ;

BEGIN
	RETURN QUERY
	SELECT * FROM students  WHERE student_id IN (1,2,3,4,5);
-- RETURN 'res';
END
$$
	
SELECT USP_stud()
DO
$$
BEGIN
	EXEC 'SELECT * FROM res';
END
$$
LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION incre()
RETURNS INT
AS
$$
DECLARE val1 INT = 20;
BEGIN
RETURN val1 + 1;
END;
$$
LANGUAGE PLPGSQL;

SELECT incre()

CREATE OR REPLACE PROCEDURE sp_usp()
LANGUAGE PLPGSQL
AS
$$
BEGIN
CREATE TEMP tbl INTO 
SELECT * FROM students;
END;
$$


CREATE OR REPLACE PROCEDURE ret(OUT ret refcursor)
LANGUAGE PLPGSQL
AS
$$
BEGIN
OPEN ret FOR SELECT * FROM students;
END;
$$

BEGIN;
CALL ret(NULL);
FETCH ALL IN "<unnamed portal 2>"
COMMIT;