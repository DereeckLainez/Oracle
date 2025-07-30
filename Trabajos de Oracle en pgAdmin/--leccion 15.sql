--leccion 15

DROP VIEW IF EXISTS view_employees_p9;
DROP VIEW IF EXISTS view_euro_countries_p15;
DROP VIEW IF EXISTS view_euro_countries_aliases_inline_p19;
DROP VIEW IF EXISTS view_euro_countries_aliases_toplevel_p19;
DROP VIEW IF EXISTS view_euro_countries_joined_p21;
DROP VIEW IF EXISTS view_high_pop_p23;

DROP TABLE IF EXISTS employees_base CASCADE;
DROP TABLE IF EXISTS wf_countries_base CASCADE;
DROP TABLE IF EXISTS wf_world_regions_base CASCADE;

CREATE TABLE employees_base (
    employee_id NUMERIC,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE wf_world_regions_base (
    region_id NUMERIC PRIMARY KEY,
    region_name VARCHAR(100)
);

CREATE TABLE wf_countries_base (
    country_id VARCHAR(10),
    region_id NUMERIC REFERENCES wf_world_regions_base(region_id),
    country_name VARCHAR(100),
    capitol VARCHAR(100),
    location VARCHAR(100),
    population NUMERIC
);

CREATE OR REPLACE VIEW view_employees_p9 AS
SELECT employee_id, first_name, last_name, email
FROM employees_base
WHERE employee_id BETWEEN 100 AND 124;

CREATE OR REPLACE VIEW view_euro_countries_p15 AS
SELECT country_id, region_id, country_name, capitol
FROM wf_countries_base
WHERE location LIKE '%Europe';

CREATE OR REPLACE VIEW view_euro_countries_aliases_inline_p19 AS
SELECT country_id AS "ID", country_name AS "Country", capitol AS "Capitol City"
FROM wf_countries_base
WHERE location LIKE '%Europe';

CREATE OR REPLACE VIEW view_euro_countries_aliases_toplevel_p19("ID", "Country", "Capitol City") AS
SELECT country_id, country_name, capitol
FROM wf_countries_base
WHERE location LIKE '%Europe';

CREATE OR REPLACE VIEW view_euro_countries_joined_p21("ID", "Country", "Capitol City", "Region") AS
SELECT c.country_id, c.country_name, c.capitol, r.region_name
FROM wf_countries_base c JOIN wf_world_regions_base r
USING (region_id)
WHERE c.location LIKE '%Europe';

CREATE OR REPLACE VIEW view_high_pop_p23("Region ID", "Highest population") AS
SELECT region_id, MAX(population)
FROM wf_countries_base
GROUP BY region_id;

DROP VIEW IF EXISTS view_dept50_p7;
DROP VIEW IF EXISTS view_dept50_check_p10;

DROP TABLE IF EXISTS copy_employees_p7 CASCADE;
DROP TABLE IF EXISTS employees_p10 CASCADE;

CREATE TABLE copy_employees_p7 (
    department_id NUMERIC,
    employee_id NUMERIC,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary NUMERIC
);


CREATE TABLE employees_p10 (
    department_id NUMERIC,
    employee_id NUMERIC,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary NUMERIC
);


CREATE OR REPLACE VIEW view_dept50_p7 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM copy_employees_p7
WHERE department_id = 50;

CREATE OR REPLACE VIEW view_dept50_check_p10 AS
SELECT department_id, employee_id, first_name, last_name, salary
FROM employees_p10
WHERE department_id = 50
WITH CHECK OPTION;

DROP VIEW IF EXISTS dummy_view_to_drop;
DROP TABLE IF EXISTS employees_base CASCADE;

CREATE TABLE employees_base (
    employee_id NUMERIC,
    last_name VARCHAR(50),
    hire_date DATE,
    salary NUMERIC,
    department_id NUMERIC
);

INSERT INTO employees_base (employee_id, last_name, hire_date, salary, department_id) VALUES
(100, 'King', '1987-06-17', 24000, 90),
(101, 'Kochhar', '1989-09-21', 17000, 90),
(102, 'De Haan', '1993-01-13', 17000, 90),
(145, 'Russell', '1996-10-01', 14000, 80),
(146, 'Partners', '1997-01-05', 13500, 80),
(201, 'Hartstein', '1996-02-17', 13000, 20),
(206, 'Gietz', '1994-06-07', 8300, 20);

CREATE VIEW dummy_view_to_drop AS
SELECT employee_id, last_name FROM employees_base;

DROP VIEW dummy_view_to_drop;

SELECT
    e.last_name,
    e.salary,
    e.department_id,
    d.maxsal
FROM
    employees_base AS e
JOIN
    (SELECT department_id, MAX(salary) AS maxsal
     FROM employees_base
     GROUP BY department_id) AS d
ON e.department_id = d.department_id AND e.salary = d.maxsal;

SELECT
    last_name,
    hire_date
FROM
    employees_base
ORDER BY
    hire_date ASC
LIMIT 5;