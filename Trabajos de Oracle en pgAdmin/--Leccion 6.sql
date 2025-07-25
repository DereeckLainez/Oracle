/*
--Leccion 6

CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(50) NOT NULL
);

INSERT INTO jobs (job_id, job_title) VALUES
('AD_PRES', 'President'),
('AD_VP', 'Administration Vice President'),
('AC_MGR', 'Accounting Manager'),
('AC_ACCOUNT', 'Public Accountant');

UPDATE employees SET job_id = 'AD_PRES', department_id = 90 WHERE last_name = 'King';
UPDATE employees SET job_id = 'AD_VP', department_id = 90 WHERE last_name = 'Kochhar';
UPDATE employees SET job_id = 'AD_VP', department_id = 90 WHERE last_name = 'De Haan';
UPDATE employees SET job_id = 'AC_MGR', department_id = 110 WHERE last_name = 'Higgins';
UPDATE employees SET job_id = 'AC_ACCOUNT', department_id = 110 WHERE last_name = 'Gietz';

UPDATE employees SET first_name = 'Steven' WHERE last_name = 'King';
UPDATE employees SET first_name = 'Neena' WHERE last_name = 'Kochhar';
UPDATE employees SET first_name = 'Lex' WHERE last_name = 'De Haan';
UPDATE employees SET first_name = 'Shelley' WHERE last_name = 'Higgins';
UPDATE employees SET first_name = 'William' WHERE last_name = 'Gietz';

SELECT first_name, last_name, job_id, job_title
 FROM employees NATURAL JOIN jobs
 WHERE department_id> 80;

 SELECT department_name, city
 FROM departments NATURAL JOIN 
locations;

 SELECT last_name, department_name
 FROM employees CROSS JOIN 
departments;

 SELECT first_name, last_name, department_id, department_name
 FROM employees JOIN departments USING (department_id);

  SELECT first_name, last_name, department_id, department_name
 FROM employees JOIN departments USING (department_id)
 WHERE last_name = 'Higgins';

  SELECT last_name, job_title
 FROM employees e JOIN jobs j
 ON (e.job_id = j.job_id);

INSERT INTO jobs (job_id, job_title) VALUES
('AD_ASST', 'Administration Assistant'),
('SA_MAN', 'Sales Manager'),
('SA_REP', 'Sales Representative');

UPDATE employees SET job_id = 'AD_ASST' WHERE last_name = 'Whalen';
UPDATE employees SET job_id = 'SA_MAN' WHERE last_name = 'Zlotkey';
UPDATE employees SET job_id = 'SA_REP' WHERE last_name = 'Abel';
UPDATE employees SET job_id = 'SA_REP' WHERE last_name = 'Taylor';

SELECT last_name, job_title
 FROM employees e JOIN jobs j
 ON (e.job_id = j.job_id);

  SELECT last_name, job_title
 FROM employees e JOIN jobs j
 ON (e.job_id = j.job_id)
 WHERE last_name LIKE 'H%';

SELECT last_name, salary, grade_level, lowest_sal, 
highest_sal
 FROM employees JOIN job_grades
 ON(salary BETWEEN lowest_sal AND highest_sal);

DELETE FROM job_grades;
INSERT INTO job_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 14999),
('E', 15000, 24000);

UPDATE employees SET salary = 2500 WHERE last_name = 'Vargas';
UPDATE employees SET salary = 2600 WHERE last_name = 'Matos';
UPDATE employees SET salary = 3100 WHERE last_name = 'Davies';
UPDATE employees SET salary = 3500 WHERE last_name = 'Rajs';
UPDATE employees SET salary = 4200 WHERE last_name = 'Lorentz';
UPDATE employees SET salary = 4400 WHERE last_name = 'Whalen';
UPDATE employees SET salary = 5800 WHERE last_name = 'Mourgos';
UPDATE employees SET salary = 6000 WHERE last_name = 'Fay';

UPDATE departments SET department_name = 'Marketing' WHERE department_id = 20;
UPDATE departments SET department_name = 'Sales' WHERE department_id = 80;
UPDATE departments SET department_name = 'IT' WHERE department_id = 60;
UPDATE departments SET department_name = 'Shipping' WHERE department_id = 50;

UPDATE employees SET department_id = 20 WHERE last_name = 'Hartstein';
UPDATE employees SET department_id = 20 WHERE last_name = 'Fay';
UPDATE employees SET department_id = 50 WHERE last_name = 'Mourgos';

SELECT last_name, department_name AS "Department", city
 FROM employees JOIN departments USING (department_id)
 JOIN locations USING (location_id);

  SELECT e.last_name, d.department_id, 
d.department_name
 FROM employees e LEFT OUTER JOIN 
departments d 
ON (e.department_id = 
d.department_id);

SELECT e.last_name, d.department_id, 
d.department_name
 FROM employees e RIGHT OUTER JOIN 
departments d 
ON (e.department_id = 
d.department_id);

CREATE TABLE job_history (
    employee_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id INTEGER,
    PRIMARY KEY (employee_id, start_date)
);

INSERT INTO jobs (job_id, job_title) VALUES ('IT_PROG', 'Programmer') ON CONFLICT (job_id) DO NOTHING;

INSERT INTO job_history (employee_id, start_date, end_date, job_id) VALUES
(101, '1993-10-28', '1997-03-15', 'AC_MGR'),
(101, '1989-09-21', '1993-10-27', 'AC_ACCOUNT'),
(102, '1993-01-13', '1998-07-24', 'IT_PROG'),
(200, '1987-09-17', '1993-06-17', 'AD_ASST'),
(200, '1994-07-01', '1998-12-31', 'AC_ACCOUNT');

 SELECT e.last_name, d.department_id, d.department_name
 FROM employees e FULL OUTER JOIN departments d 
ON (e.department_id= d.department_id);

SELECT last_name, e.job_id AS "Job", jh.job_id AS "Old job", 
end_date
 FROM employees e LEFT OUTER JOIN job_history jh
 ON(e.employee_id = jh.employee_id);

ALTER TABLE employees ADD COLUMN manager_id INTEGER;

UPDATE employees SET manager_id = 100 WHERE last_name = 'Kochhar';
UPDATE employees SET manager_id = 100 WHERE last_name = 'De Haan';
UPDATE employees SET manager_id = 100 WHERE last_name = 'Zlotkey';
UPDATE employees SET manager_id = 100 WHERE last_name = 'Mourgos';
UPDATE employees SET manager_id = 100 WHERE last_name = 'Hartstein';

UPDATE employees SET manager_id = 101 WHERE last_name = 'Whalen';
UPDATE employees SET manager_id = 101 WHERE last_name = 'Higgins';

UPDATE employees SET manager_id = 102 WHERE last_name = 'Hunold';

SELECT worker.last_name, worker.manager_id, manager.last_name
 AS "Manager name"
 FROM employees worker JOIN employees manager
 ON (worker.manager_id = manager.employee_id);

WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, last_name, job_id, manager_id
    FROM employees
    WHERE employee_id = 100

    UNION ALL

    SELECT e.employee_id, e.last_name, e.job_id, e.manager_id
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;

-- Versión con "reports to"
WITH RECURSIVE employee_hierarchy AS (
    -- Ancla
    SELECT employee_id, last_name FROM employees WHERE last_name = 'King'

    UNION ALL
    
    
    SELECT e.employee_id, e.last_name
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    e.last_name || ' reports to ' || m.last_name AS "Walk Top Down"
FROM 
    employees e
JOIN 
    employees m ON e.manager_id = m.employee_id
WHERE
    e.employee_id IN (SELECT employee_id FROM employee_hierarchy WHERE last_name != 'King');

 SELECT LEVEL, last_name ||               
' reports to ' ||               
PRIOR last_name
 AS "Walk Top Down"
 FROM employees
 START WITH last_name = 'King'
 CONNECT BY PRIOR             
employee_id = manager_id;

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        employee_id,
        manager_id,
        last_name,
        1 AS level
    FROM
        employees
    WHERE
        last_name = 'King'

    UNION ALL
    
    SELECT
        e.employee_id,
        e.manager_id,
        e.last_name,
        eh.level + 1
    FROM
        employees e
    JOIN
        employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    eh.level,
    eh.last_name || ' reports to ' || m.last_name AS "Walk Top Down"
FROM
    employee_hierarchy eh
JOIN
    employees m ON eh.manager_id = m.employee_id;


WITH RECURSIVE employee_hierarchy AS (
    SELECT
        employee_id,
        last_name,
        1 AS level
    FROM
        employees
    WHERE
        last_name = 'King'

    UNION ALL

    SELECT
        e.employee_id,
        e.last_name,
        eh.level + 1
    FROM
        employees e
    JOIN
        employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
    LPAD(last_name, CHAR_LENGTH(last_name) + (level * 2) - 2, '_') AS "Org_Chart"
FROM
    employee_hierarchy;


UPDATE employees SET manager_id = 149 WHERE last_name = 'Grant';

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        employee_id,
        manager_id,
        last_name,
        1 AS level
    FROM
        employees
    WHERE
        last_name = 'Grant'

    UNION ALL

    SELECT
        e.employee_id,
        e.manager_id,
        e.last_name,
        eh.level + 1
    FROM
        employees e
    JOIN
        employee_hierarchy eh ON e.employee_id = eh.manager_id
)
SELECT
    LPAD(last_name, CHAR_LENGTH(last_name) + (level * 2) - 2, '_') AS "Org_Chart"
FROM
    employee_hierarchy;
*/