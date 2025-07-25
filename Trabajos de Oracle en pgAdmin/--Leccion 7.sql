--Leccion 7

/*

 SELECT employees.last_name, employees.job_id, jobs.job_title
 FROM employees, jobs 
WHERE employees.job_id = jobs.job_id;

 SELECT employees.last_name, departments.department_name
 FROM employees, departments
 WHERE employees.department_id= departments.department_id;

 SELECT last_name, e.job_id, job_title
 FROM employees e, jobs j 
WHERE e.job_id= j.job_id
 AND department_id= 80;

 SELECT employees.last_name, departments.department_name
 FROM employees, departments;

SELECT employees.last_name, employees.job_id, jobs.job_title
 FROM employees, jobs 
WHERE employees.job_id = jobs.job_id
 AND employees.department_id = 80;

 SELECT last_name, city
 FROM employees e, departments d, 
locations l
 WHERE e.department_id = d.department_id
 AND d.location_id = l.location_id;

-- Crear la tabla para los niveles de salario
CREATE TABLE job_grades (
    grade_level CHAR(1) PRIMARY KEY,
    lowest_sal INTEGER,
    highest_sal INTEGER
);

-- Llenar la tabla con los rangos de salario
INSERT INTO job_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 14999),
('E', 15000, 25000);

SELECT
    last_name,
    salary,
    grade_level,
    lowest_sal,
    highest_sal
FROM
    employees
JOIN
    job_grades ON salary BETWEEN lowest_sal AND highest_sal;

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
LEFT JOIN
    departments d ON e.department_id = d.department_id;

SELECT
    e.last_name,
    d.department_id,
    d.department_name
FROM
    employees e
LEFT JOIN
    departments d ON e.department_id = d.department_id;
*/