-- -- Questions based on the employee table 
-- -- 1.Using a subquery, list the name of the employees, 
-- paid more than 'Fred Costner' from employees.
	SELECT * FROM employees
	WHERE salary >(
		SELECT salary
	FROM employees
	WHERE first_name||' '||last_name = 'Alex Martin'
					)
	

-- -- 2.Find all employees 
-- who earn more than the average salary in their department.
	SELECT * FROM employees
	SELECT department_id,first_name,last_name
	FROM employees e1
	WHERE salary IN (select AVG(salary)
				   FROM employees e2
-- 					WHERE e1.employee_id = e2.employee_id
				   GROUP BY department_id)
	GROUP BY department_id,first_name,last_name


-- -- 3.Write a query to select those employees 
-- who does not work in those department
-- where the managers of ID between 100 and 200 works.
	SELECT *
	FROM employees
	WHERE department_id NOT IN(
								SELECT department_id
								FROM employees
								WHERE manager_id BETWEEN 1 AND 8);
-- -- 4.Find employees who have at least one person reporting to them.

SELECT DISTINCT(e2.first_name||e2.last_name) AS Employee_name,e2.employee_id
FROM employees e1
INNER JOIN employees e2
ON e1.manager_id = e2.employee_id
ORDER BY e2.employee_id



-- 1.Write a query to fetch the student_name,stipend and department_name from the students 
-- and departments table where the student_id is between 1 to 5 AND
-- stipend is in the range of 2000 to 4000.

WITH cte_fetch AS(
SELECT student_name,stipend,department_name
	FROM students
	INNER JOIN departments
	ON students.student_department = departments.department_id
	WHERE (student_id BETWEEN 1 AND 5) AND (stipend between 2000 AND 4000) 
)
SELECT * FROM cte_fetch


-- 2.Write a query to fetch the sum value of the stipend from the students
-- table based on the department_id where the departments 
-- 'Animation' and 'Marketing' should not be included and the sum value should be less than 4000.

SELECT * FROM departments
WITH cte_sum AS(
	SELECT SUM(stipend) AS Total_Stipend
	FROM students 
	WHERE student_department NOT IN (SELECT department_id
											FROM departments
											WHERE department_name IN ('Marketing','cartoon'))
	GROUP BY student_department
	HAVING SUM(stipend) < 4000
)
SELECT * FROM cte_sum


-- 3.Using the concept of multiple cte, fetch the maximum value, minimm value, average 
-- and sum of the stipend based on the department and return all the values.

WITH cte_new AS(
	SELECT Student_department,MAX(stipend) AS maxim
	FROM students
-- 	INNER JOIN cte2
-- 	ON cte2.Student_department = students.Student_department
	GROUP BY student_department
)
,	 cte2 AS (
	SELECT Student_department, MIN(stipend) AS MINUM
	FROM students
-- 	INNER JOIN cte3
-- 	ON cte3.Student_department = students.Student_department
	GROUP BY student_department
)
,	 cte3 AS(
	SELECT Student_department,ROUND(AVG(stipend),2) AS _AVG
	FROM students
-- 	INNER JOIN cte4
-- 	ON cte4.Student_department = students.Student_department
	GROUP BY student_department
)
,	 cte4 AS(
	SELECT Student_department,SUM(stipend) AS SUMS
	FROM students
	GROUP BY student_department
)


SELECT cte2.Student_department,maxim,MINUM,_AVG,SUMS 
FROM cte_new 
JOIN cte2 ON cte_new.Student_department = cte2.Student_department
JOIN cte3 ON cte2.Student_department = cte3.Student_department
JOIN cte4 ON cte3.Student_department = cte4.Student_department
ORDER BY cte2.Student_department


SELECT * FROM departments
OFFSET 5


