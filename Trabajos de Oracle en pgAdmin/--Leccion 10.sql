--Leccion 10

UPDATE employees SET first_name = 'Eleni', hire_date = '2000-01-29' WHERE last_name = 'Zlotkey';
UPDATE employees SET first_name = 'Kimberely', hire_date = '1999-05-24' WHERE last_name = 'Grant';
UPDATE employees SET first_name = 'Kevin', hire_date = '1999-11-16' WHERE last_name = 'Mourgos';
UPDATE employees SET first_name = 'Diana', hire_date = '1999-02-07' WHERE last_name = 'Lorentz';

SELECT first_name, last_name, hire_date
FROM employees
WHERE last_name IN ('Zlotkey', 'Grant', 'Mourgos', 'Lorentz');

SELECT last_name, job_id, department_id
 FROM employees
 WHERE department_id = 
(SELECT department_id
 FROM departments
 WHERE department_name = 'Marketing')
 ORDER BY job_id;

SELECT last_name, job_id, salary, department_id
 FROM employees
 WHERE job_id = 
(SELECT job_id
 FROM employees 
WHERE employee_id= 141)
 AND department_id = 
(SELECT department_id
 FROM departments 
WHERE location_id= 1500);

ALTER TABLE locations ADD COLUMN country_id VARCHAR(2);


INSERT INTO locations (location_id, city, country_id)
VALUES (1500, 'South San Francisco', 'US')
ON CONFLICT (location_id) DO NOTHING; e

UPDATE departments SET location_id = 1500 WHERE department_id = 50;
ALTER TABLE employees ADD PRIMARY KEY (employee_id);


INSERT INTO employees (employee_id, last_name, job_id, department_id)
VALUES (141, 'Walsh', 'ST_CLERK', 50)
ON CONFLICT (employee_id) DO UPDATE 
SET job_id = EXCLUDED.job_id; 

UPDATE employees SET department_id = 50 WHERE last_name = 'Rajs';
UPDATE employees SET department_id = 50 WHERE last_name = 'Davies';
UPDATE employees SET department_id = 50 WHERE last_name = 'Matos';
UPDATE employees SET department_id = 50 WHERE last_name = 'Vargas';

SELECT last_name, salary
 FROM employees
 WHERE salary < 
(SELECT AVG(salary)
 FROM employees);

SELECT department_id, MIN(salary)
 FROM employees
 GROUP BY department_id
 HAVING MIN(salary) >
 (SELECT MIN(salary)
 FROM employees
 WHERE department_id= 50);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
    (SELECT EXTRACT(YEAR FROM hire_date)
     FROM employees
     WHERE department_id = 90);

UPDATE employees SET hire_date = '1996-02-17' WHERE last_name = 'Hartstein';
UPDATE employees SET hire_date = '1997-08-17' WHERE last_name = 'Fay';

UPDATE employees SET department_id = 90 WHERE last_name = 'King';
UPDATE employees SET department_id = 90 WHERE last_name = 'Kochhar';
UPDATE employees SET department_id = 90 WHERE last_name = 'De Haan';

UPDATE employees SET hire_date = '1987-06-17' WHERE last_name = 'King';
UPDATE employees SET hire_date = '1989-09-21' WHERE last_name = 'Kochhar';
UPDATE employees SET hire_date = '1993-01-13' WHERE last_name = 'De Haan';
UPDATE employees SET hire_date = '1987-09-17' WHERE last_name = 'Whalen';

 SELECT last_name, hire_date FROM employees
 WHERE EXTRACT(YEAR FROM hire_date) < ALL
 (SELECT EXTRACT(YEAR FROM hire_date)
 FROM employees
 WHERE department_id=90);

 SELECT last_name, 
employee_id
 FROM employees
 WHERE employee_id IN
 (SELECT manager_id
 FROM employees);

 SELECT department_id, MIN(salary)
 FROM employees
 GROUP BY department_id
 HAVING MIN(salary) < ANY
 (SELECT salary
 FROM employees
 WHERE department_id IN (10,20))
 ORDER BY department_id;

SELECT employee_id, manager_id, department_id
 FROM employees
 WHERE(manager_id,department_id) IN
 (SELECT manager_id,department_id
 FROM   
employees
 WHERE  employee_id IN (149,174))
 AND employee_id NOT IN (149,174)

UPDATE employees SET manager_id = 149, department_id = 80 WHERE employee_id = 174; -- Taylor
UPDATE employees SET manager_id = 149, department_id = 80 WHERE employee_id = 176; -- Grant

SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN
    (SELECT manager_id, department_id
     FROM employees
     WHERE employee_id IN (149, 174))
AND employee_id NOT IN (149, 174);

UPDATE employees SET manager_id = 100, department_id = 80 WHERE employee_id = 149; -- Zlotkey
UPDATE employees SET manager_id = 149, department_id = 80 WHERE employee_id = 174; -- Taylor
UPDATE employees SET manager_id = 149, department_id = 80 WHERE employee_id = 176; -- Grant

SELECT
    employee_id,
    manager_id,
    department_id
FROM
    employees
WHERE
    manager_id IN (SELECT manager_id FROM employees WHERE employee_id IN (149, 174))
AND
    department_id IN (SELECT department_id FROM employees WHERE employee_id IN (149, 174))
AND
    employee_id NOT IN (149, 174);

SELECT first_name, last_name, 
job_id
 FROM employees
 WHERE job_id =
 (SELECT job_id
 FROM employees
 WHERE last_name = 'Ernst');

 SELECT o.first_name,o.last_name, 
o.salary
 FROM employees o
 WHERE o.salary > 
(SELECT AVG(i.salary)
 FROM employees i
 WHERE i.department_id = 
o.department_id);

-- Corregir nombres y salarios para que coincidan con el ejemplo
UPDATE employees SET first_name = 'Steven', salary = 24000 WHERE last_name = 'King';
UPDATE employees SET first_name = 'Shelley', salary = 12000 WHERE last_name = 'Higgins';
UPDATE employees SET first_name = 'Eleni', salary = 10500 WHERE last_name = 'Zlotkey';
UPDATE employees SET first_name = 'Ellen', salary = 11000 WHERE last_name = 'Abel';
UPDATE employees SET first_name = 'Kevin', salary = 5800 WHERE last_name = 'Mourgos';
UPDATE employees SET first_name = 'Alexander', salary = 9000 WHERE last_name = 'Hunold';
UPDATE employees SET first_name = 'Michael', salary = 13000 WHERE last_name = 'Hartstein';

-- Asignar salarios a los compañeros de departamento para que la lógica AVG funcione
UPDATE employees SET salary = 8000 WHERE last_name = 'Gietz';    
UPDATE employees SET salary = 8000 WHERE last_name = 'Taylor';   
UPDATE employees SET salary = 7000 WHERE last_name = 'Grant';    
UPDATE employees SET salary = 3500 WHERE last_name = 'Rajs';   
UPDATE employees SET salary = 6000 WHERE last_name = 'Ernst';   
UPDATE employees SET salary = 6000 WHERE last_name = 'Fay';      
UPDATE employees SET salary = 17000 WHERE last_name = 'Kochhar';
UPDATE employees SET salary = 17000 WHERE last_name = 'De Haan';

 SELECT last_name AS "Not a Manager"
 FROM 
  employees emp 
WHERE NOT EXISTS 
(SELECT * 
FROM employees mgr
 WHERE  mgr.manager_id = emp.employee_id);

 SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE NOT EXISTS (
    SELECT 1 -- '1' es más eficiente que '*' aquí
    FROM employees mgr
    WHERE mgr.manager_id = emp.employee_id
);