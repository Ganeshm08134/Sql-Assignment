CREATE TABLE departments 
(department_id NUMERIC PRIMARY KEY, 
department_name VARCHAR(20)); 


CREATE TABLE employees 
( employee_id NUMERIC PRIMARY KEY,  
first_name VARCHAR(20) NOT NULL,  
last_name VARCHAR(20) NOT NULL, 
email_id VARCHAR(20) UNIQUE,  
phonenumber VARCHAR(20), 
hire_date DATE DEFAULT CURRENT_DATE, 
job_id VARCHAR(20), 
salary NUMERIC CHECK (salary > 0 ),  
manager_id NUMERIC REFERENCES employees  
ON DELETE SET NULL ON UPDATE SET NULL,  
commission_pct numeric(2,2) 
); 



CREATE TABLE job_history 
( employee_id NUMERIC, 
start_date DATE, 
end_date DATE, 
job_id VARCHAR(20), 
department_id NUMERIC REFERENCES departments  
ON DELETE SET NULL ON UPDATE SET NULL, 
CONSTRAINT emp_date PRIMARY KEY (employee_id,start_date), 
 
CONSTRAINT empid_fk foreign key (employee_id) references employees  
ON DELETE SET NULL ON UPDATE SET NULL, 
CONSTRAINT job_hist_date CHECK (start_date < end_date) 
); 


select * from departments





-- 1.Retrieve the information of all the employees working in the organization. 
	SELECT *
	FROM employees

-- 2.fetch the specific details like employee_id, first_name, email_id and salary from the 
-- employees table. 
	SELECT employee_id,first_name,email_id
	FROM employees
	
-- 3.Display the department numbers in which employees are present. If the 
-- department_id is present more than once then, only one value should be retrieved. 
	SELECT department_id
	FROM employees
	WHERE department_id IS NOT NULL

-- 4. Display different job roles that are available in the company.  
	SELECT DISTINCT(job_id)
	FROM employees

-- 5.Display the department data  in the ascending order and salary must be in 
-- descending order. 
	SELECT department_id,salary
	FROM employees
	ORDER BY department_id ASC,salary DESC

-- 6.retrieve the details of all the employees working in 10th department. 
	SELECT *
	FROM Employees
	WHERE department_id = 10
	
-- 7.details of the employees working in 10th department along with the employee 
-- details whose earning is more than 40000. 
	SELECT *
	FROM Employees
	WHERE department_id = 10 AND salary > 40000

-- 8.display the last name and the job title of the employees who were not allocated to 
-- the manager. 
	SELECT last_name,job_id
	FROM employees
	WHERE manager_id IS NULL

-- 9.Generate a report for the employees whose salary ranges from 5000 to 12000 and 
-- they should either belongs to department 20 or department 50. Display the last name and 
-- the salary of the employee.  
-- Note: Rename the column name as Employee instead of lastname  and Monthly Salary 
-- instead of salary respectively. 
	SELECT last_name AS Employee,salary AS Monthly_salary
	FROM employees
	WHERE salary BETWEEN 5000 AND 12000 AND department_id IN(20,50)
	
	SELECT * FROM departments

-- 10. the employees details who had joined in the year 2003  
	SELECT *
	FROM employees
	WHERE EXTRACT(YEAR FROM hire_date) = 2003
	
	SELECT 
	
-- 11.Write a query to display the last_name and number of  months for which the 
-- employee have worked rounding the months_worked column to its nearest whole number.   
-- Hint: No of months should be calculated from the date of joining of an employee to till date. 

	SELECT last_name,((EXTRACT(YEAR FROM(CURRENT_DATE)) - EXTRACT(YEAR FROM(hire_date)))*12) + (EXTRACT(MONTH FROM(CURRENT_DATE)) - EXTRACT(MONTH FROM(hire_date) + ))  AS DATE
	FROM employees

-- 12.calculate their spending's designation-wise from each department.  
	SELECT job_id,SUM(salary + COALESCE(commission_pct,0)) AS Total_spending
	FROM employees
	GROUP BY job_id

-- 13.calculate the following details of the employees using aggregate function in a 
-- department. 
-- ∙Employee with highest salary 
-- ∙Employee with lowest salary 
-- ∙Total salary of all the employees in the department  
-- ∙Average salary of the department 
-- Write a query to display the output  rounding the resultant values to its nearest whole 
-- number.
	
	SELECT MAX(salary),MIN(salary),SUM(salary),ROUND(AVG(salary),0)
	FROM employees
	GROUP BY department_id
	
	SELECT * FROM employees
	

-- 14.Modify the result obtained in the previous exercise to display the minimum, 
-- maximum, total and average salary for each job type. 
-- 15.fetch the details of the departments having less than 3 employees and are working in 
-- the department whose department_id is greater than 10.
select d.*
from departments d
inner join employees e
on d.department_id=e.department_id
group by d.department_id
having count(e.employee_id)<3 and d.department_id>5
-- 16.fetch the manager_id and the minimum salary of the employee reporting to him. 
-- Arrange the result in descending order of the salaries excluding the details given below: 
-- ∙Exclude the employee whose manager is not mapped / not known. 
-- ∙Exclude the details if the minimum salary is less than or equal to 6000.
select e2.employee_id,min(e1.salary)
from employees e1 
inner join employees e2 on e2.employee_id=e1.manager_id
group by e2.employee_id,e1.salary
having min(e1.salary)>=6000
order by e1.salary desc

select * from employees
-- 17. details of the employees who have never changed their job role in the company. 

select *
from employees
where employee_id not in ( 
	 					  select employee_id
						  from job_history
						  )
						  
						  
-- 18.fetch the employee names and their departments in which they are working. 
select e.first_name,d.department_name
from departments d
inner join employees e on d.department_id=e.department_id
-- 19.retrieve all the department information with their corresponding employee names 
-- along with the newly added departments. 
select d.department_id,d.department_name,e.first_name
from departments d
inner join employees e on d.department_id=e.department_id
-- 20.details of the employee along with their managers. 
select e1.first_name as employee_name,e2.first_name as manager_name
from employees e1 
inner join employees e2 on e2.employee_id=e1.manager_id

-- 21. employee details who are reporting to the same manager as Maria reports to.
select * 
from employees
where manager_id in (select manager_id
					from employees
					where first_name='Jane'
                    )
-- 22.fetch the details of the employees working in the Executive department. 
select *
from employees
where department_id in ( select department_id
						from departments
						where department_name='HR'
						)
-- 23.fetch the details of employee whose salary is greater than the average salary of all 
-- the employees. 
select * 
from employees
where salary > (
				select avg(salary)
				from employees)
-- 24. Write a query which displays all Ellen's colleague's names. Label the name as "Ellen's 
-- colleague".  
-- Hint: If an employee is Ellen's colleague then their department_id will be same. 
select first_name as Alice_coleague
from employees
where department_id in ( select department_id
						from employees
						where first_name='Alice'
						 							) 
					  								and first_name!='Alice'
-- 25.which employees from adminstration team is/are earning less than all the 
-- employees. 
select first_name,min(salary)
from employees
where department_id in ( select department_id
						from departments
						where department_name='Administration'
						) 
group by first_name,employees.salary
-- having salary=min(salary)


select * from departments
-- 26.  Write a query to display the last name and salary of those who reports to King. 
select last_name,salary
from employees
where manager_id in ( select employee_id
						from employees
						where first_name='John')
-- 27. Write a query to display the below requirement.   
-- Fetch employee id and first name of who work in a department with the employee's having 
-- ‘u’ in the  last_name. 
select employee_id,first_name,last_name,department_id
from employees
where department_id in ( select department_id
						from employees
						where last_name ilike '%m%') and Department_Id IS NOT NULL

SELECT * FROM Employees

select employee_id,first_name,department_id
from employees
where
	last_name ilike '%m%'
	AND
	Department_Id IS NOT NULL;

-- 28.the employee who is getting highest pay in the specific department. 
select first_name,d.department_name
from employees e
inner join departments d on e.department_id=d.department_id
group by d.department_name,e.first_name,e.salary
having salary=max(salary)


select first_name,department_id
from employees 
group by department_id,first_name,salary
having salary=max(salary)

select * from departments
-- 29. the details of different employees who have atleast one person reporting to them.
select * 
from employees
where employee_id in (select manager_id
					from employees
                    )
-- 30. the departments which was formed but it does not have employees working in 
-- them currently.   
select D.department_name,e.first_name
from departments d
left join employees e on d.department_id=e.department_id
where e.department_id is null
