/*
Common Table Expressions

It is a temporary result set which you can reference within another SQL statement 
including SELECT, INSERT, UPDATE or DELETE and they are temporary in the sense that they only exist 
during the execution of the query.

Syntax:
WITH cte_name (column_list) AS (
    CTE_query_definition 
)
statement;

*/

---simple CTE
WITH student_marks AS
(
	SELECT student_name,SUM(subject1_marks) AS marks
	FROM students
	WHERE stipend BETWEEN 3000 AND 5000	
	GROUP BY student_name
)
SELECT student_name,marks FROM student_marks;

------CTE in joins
WITH student_stipend AS
(
	SELECT student_name,SUM(stipend) AS stipend,student_department AS department_id
	FROM students
	WHERE stipend BETWEEN 3000 AND 5000	
	GROUP BY student_name,student_department
)
SELECT student_name,stipend 
FROM department d
JOIN student_stipend ss ON d.department_id = ss.department_id;

-----CTE with a window function
WITH cte_students AS
( 
	SELECT student_name,AVG(stipend) OVER(PARTITION BY student_department) AS average_value
	FROM students
	WHERE student_department NOT IN (6,7)
)
SELECT * FROM cte_students WHERE average_value > 3000;

-----------------------------------------------------------------
/*
Recursive CTE
--useful in querying hierarchial data such as organizational structure, bill of materials etc

Syntax:
WITH RECURSIVE cte_name AS(
    CTE_query_definition -- non-recursive term
    UNION [ALL]
    CTE_query definion  -- recursive term
) SELECT * FROM cte_name;

A recursive CTE has three elements:

Non-recursive term: 
the non-recursive term is a CTE query definition that forms the base result set of the CTE structure.

Recursive term: 
the recursive term is one or more CTE query definitions joined with the non-recursive term 
using the UNION or UNION ALL operator. The recursive term references the CTE name itself.

Termination check: 
the recursion stops when no rows are returned from the previous iteration.

*/

CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	full_name VARCHAR NOT NULL,
	manager_id INT
);

INSERT INTO employees (employee_id,full_name,manager_id)
VALUES
	(1, 'Michael North', NULL),
	(2, 'Megan Berry', 1),
	(3, 'Sarah Berry', 1),
	(4, 'Zoe Black', 1),
	(5, 'Tim James', 1),
	(6, 'Bella Tucker', 2),
	(7, 'Ryan Metcalfe', 2),
	(8, 'Max Mills', 2),
	(9, 'Benjamin Glover', 2),
	(10, 'Carolyn Henderson', 3),
	(11, 'Nicola Kelly', 3),
	(12, 'Alexandra Climo', 3),
	(13, 'Dominic King', 3),
	(14, 'Leonard Gray', 4),
	(15, 'Eric Rampling', 4),
	(16, 'Piers Paige', 7),
	(17, 'Ryan Henderson', 7),
	(18, 'Frank Tucker', 8),
	(19, 'Nathan Ferguson', 8),
	(20, 'Kevin Rampling', 8);



SELECT * FROM employees;


WITH RECURSIVE subordinates AS (
	SELECT
		employee_id,
		manager_id,
		full_name
	FROM
		employees
	WHERE
		employee_id = 2
	UNION
		SELECT
			e.employee_id,
			e.manager_id,
			e.full_name
		FROM
			employees e --where manager_id IN (16,17,18,19,20)
		INNER JOIN subordinates s ON s.employee_id = e.manager_id
) SELECT
	*
FROM
	subordinates;	
	



