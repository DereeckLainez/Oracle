--Leccion 3

--SELECT last_name, department_id, salary
 --FROM employees
 --WHERE department_id > 50 AND salary > 12000;

--SELECT department_name, manager_id, location_id
-- FROM departments
-- WHERE location_id = 2500 OR manager_id=124;

 --SELECT department_name, location_id
 --FROM departments
 --WHERE location_id NOT IN (1700,1800);

--SELECT last_name||' '||salary*1.05 
--AS "Employee Raise", department_id, 
--first_name
-- FROM employees
-- WHERE department_id IN(50,80) 
--AND first_name LIKE 'C%' 
--OR last_name LIKE '%s%';

-- SELECT last_name||' '||salary*1.05 AS "Employee Raise", 
-- department_id, 
-- first_name
-- FROM employees
-- WHERE (department_id IN(50,80) OR first_name LIKE 'C%')
-- AND last_name LIKE '%s%';

-- 
-- SELECT last_name, hire_date
-- FROM employees
-- ORDER BY hire_date;

--SELECT last_name, hire_date
-- FROM employees
-- ORDER BY hire_date DESC;

--SELECT last_name, hire_date 
--AS "Date Started"
--FROM employees
--ORDER BY "Date Started";

-- SELECT employee_id, 
-- first_name
-- FROM employees
-- WHERE employee_id < 105
-- ORDER BY last_name;

-- SELECT department_id, last_name
-- FROM employees
-- WHERE department_id <= 50 
-- ORDER BY department_id, 
-- last_name;

-- SELECT department_id, 
-- last_name
-- FROM employees
-- WHERE department_id <= 50 
-- ORDER BY department_id DESC, 
-- last_name;

--fin de la leccion 3
