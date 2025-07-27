--Leccion 9

/*
SELECT department_id, AVG(salary)
 FROM employees
 GROUP BY department_id
 ORDER BY department_id;

SELECT MAX(salary)
 FROM employees
 GROUP BY department_id;

SELECT department_id, MAX(salary)
 FROM employees
 GROUP BY department_id;

SELECT COUNT(country_name), region_id
 FROM wf_countries
 GROUP BY region_id
 ORDER BY region_id;

ALTER TABLE wf_countries ADD COLUMN region_id INTEGER;

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R5-' || s.i, 5
FROM generate_series(1, 10) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R9-' || s.i, 9
FROM generate_series(1, 28) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R11-' || s.i, 11
FROM generate_series(1, 21) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R13-' || s.i, 13
FROM generate_series(1, 8) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R14-' || s.i, 14
FROM generate_series(1, 7) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R15-' || s.i, 15
FROM generate_series(1, 8) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R17-' || s.i, 17
FROM generate_series(1, 5) AS s(i);

INSERT INTO wf_countries (country_name, region_id)
SELECT 'País de Ejemplo R18-' || s.i, 18
FROM generate_series(1, 17) AS s(i);

SELECT department_id, MAX(salary)
 FROM employees
 WHERE last_name!= 'King'
 GROUP BY department_id;

SELECT department_id, job_id, 
count(*)
 FROM employees
 WHERE department_id > 40
 GROUP BY department_id, job_id;

 SELECT department_id,MAX(salary)
 FROM employees
 GROUP BY department_id
 HAVING COUNT(*)>1
 ORDER BY department_id;

 SELECT region_id,
 ROUND(AVG(population))
 FROM wf_countries
 GROUP BY region_id
 HAVING MIN(population)>300000
 ORDER BY region_id;

ALTER TABLE wf_countries ADD COLUMN population BIGINT;

INSERT INTO wf_countries (country_name, region_id) VALUES
('País de Ejemplo R30-1', 30),
('País de Ejemplo R34-1', 34),
('País de Ejemplo R143-1', 143),
('País de Ejemplo R145-1', 145),
('País de Ejemplo R151-1', 151);

UPDATE wf_countries SET population = 27037687 WHERE region_id = 14;
UPDATE wf_countries SET population = 18729285 WHERE region_id = 17;
UPDATE wf_countries SET population = 193332379 WHERE region_id = 30;
UPDATE wf_countries SET population = 173268273 WHERE region_id = 34;
UPDATE wf_countries SET population = 12023602 WHERE region_id = 143;
UPDATE wf_countries SET population = 8522790 WHERE region_id = 145;
UPDATE wf_countries SET population = 28343051 WHERE region_id = 151;

SELECT department_id, job_id, SUM(salary)
 FROM employees
 WHERE department_id< 50
 GROUP BY ROLLUP (department_id, job_id);

SELECT department_id, job_id, SUM(salary)
 FROM   employees
 WHERE department_id< 50
 GROUP BY (department_id, job_id);

 SELECT department_id, job_id, SUM(salary)
 FROM employees
 WHERE department_id< 50
 GROUP BY CUBE (department_id, job_id);

SELECT department_id, job_id, manager_id, SUM(salary)
 FROM employees
 WHERE department_id < 50
 GROUP BY GROUPING SETS
 ((job_id, manager_id),(department_id, job_id),
 (department_id, manager_id));

SELECT department_id, job_id, SUM(salary),
 GROUPING(department_id) AS "Dept sub total",
 GROUPING(job_id) AS "Job sub total"
 FROM employees
 WHERE department_id< 50
 GROUP BY CUBE (department_id, job_id);

SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT NULL::date, employee_id, job_id
FROM job_history;

SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT NULL::date, employee_id, job_id
FROM job_history
ORDER BY employee_id;

SELECT
    hire_date,
    employee_id,
    NULL::date AS start_date,   
    NULL::date AS end_date,     
    job_id,
    department_id
FROM
    employees
UNION
SELECT
    NULL::date AS hire_date,
    employee_id,
    start_date,
    end_date,
    job_id,
    department_id
FROM
    job_history
ORDER BY
    employee_id;
*/