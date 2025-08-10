--leccion 20

DROP VIEW IF EXISTS V2;
DROP VIEW IF EXISTS Dept_Managers_view;
DROP VIEW IF EXISTS V3;
DROP TABLE IF EXISTS emp CASCADE;
DROP TABLE IF EXISTS dept CASCADE;
DROP TABLE IF EXISTS job_history_base CASCADE;
DROP TABLE IF EXISTS employees_base CASCADE;
DROP TABLE IF EXISTS departments_base CASCADE;
DROP TABLE IF EXISTS locations_base CASCADE;
DROP TABLE IF EXISTS countries_base CASCADE;
DROP SEQUENCE IF EXISTS ct_seq;
DROP FUNCTION IF EXISTS immutable_upper(text);

CREATE TABLE countries_base (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40)
);

CREATE TABLE locations_base (
    location_id NUMERIC PRIMARY KEY,
    city VARCHAR(30),
    country_id CHAR(2) REFERENCES countries_base(country_id)
);

CREATE TABLE departments_base (
    department_id NUMERIC PRIMARY KEY,
    department_name VARCHAR(30),
    manager_id NUMERIC,
    location_id NUMERIC REFERENCES locations_base(location_id)
);

CREATE TABLE employees_base (
    employee_id NUMERIC PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    hire_date DATE,
    job_id VARCHAR(10),
    salary NUMERIC(8,2),
    manager_id NUMERIC,
    department_id NUMERIC REFERENCES departments_base(department_id)
);

CREATE TABLE job_history_base (
    employee_id NUMERIC,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id NUMERIC,
    CONSTRAINT jhist_pk PRIMARY KEY (employee_id, start_date)
);

INSERT INTO countries_base (country_id, country_name) VALUES
('US', 'United States of America'), ('CA', 'Canada'), ('UK', 'United Kingdom');

INSERT INTO locations_base (location_id, city, country_id) VALUES
(1700, 'Seattle', 'US'), (2500, 'South San Francisco', 'US'), (1800, 'Southlake', 'US'), (2400, 'London', 'UK');

INSERT INTO departments_base (department_id, department_name, manager_id, location_id) VALUES
(90, 'Executive', 100, 1700),
(60, 'IT', 103, 1800),
(80, 'Sales', 145, 2500),
(50, 'Shipping', 121, 1700),
(20, 'Marketing', 201, 1800),
(110, 'Accounting', 205, 1700),
(10, 'Administration', 200, 1700);

INSERT INTO employees_base (employee_id, first_name, last_name, email, hire_date, job_id, salary, manager_id, department_id) VALUES
(100, 'Steven', 'King', 'SKING', '1987-06-17', 'AD_PRES', 24000.00, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '1989-09-21', 'AD_VP', 17000.00, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '1993-01-13', 'AD_VP', 17000.00, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '1990-01-03', 'IT_PROG', 9000.00, 102, 60),
(145, 'John', 'Russell', 'JRUSSEL', '1996-10-01', 'SA_MAN', 14000.00, 100, 80),
(200, 'Jennifer', 'Whalen', 'JWHALEN', '1987-09-17', 'AD_ASST', 4400.00, 101, 10),
(201, 'Michael', 'Hartstein', 'MHARTSTE', '1996-02-17', 'MK_MAN', 13000.00, 100, 20),
(205, 'Shelley', 'Higgins', 'SHIGGINS', '1994-06-07', 'AC_MGR', 12000.00, 101, 110);


CREATE TABLE emp AS SELECT * FROM employees_base;
CREATE TABLE dept AS SELECT * FROM departments_base;

SELECT tc.constraint_name, tc.constraint_type, kcu.column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
WHERE tc.table_name = 'job_history_base';

ALTER TABLE emp ADD CONSTRAINT emp_id_pk PRIMARY KEY (employee_id);
ALTER TABLE dept ADD CONSTRAINT dept_id_pk PRIMARY KEY (department_id);

ALTER TABLE emp
ADD CONSTRAINT emp_dept_id_fk FOREIGN KEY (department_id)
REFERENCES dept (department_id) ON DELETE CASCADE;

DELETE FROM dept WHERE department_id = 10;
SELECT COUNT(*) FROM emp;

SELECT last_name, salary, department_id, department_avg_salary
FROM (
    SELECT
        last_name,
        salary,
        department_id,
        AVG(salary) OVER (PARTITION BY department_id) AS department_avg_salary
    FROM emp
) AS salary_comparison
WHERE salary > department_avg_salary;

CREATE VIEW V2("Nombre del Departamento", "Lowest Salary", "Highest Salary", "Average Salary") AS
SELECT d.department_name, MIN(e.salary), MAX(e.salary), AVG(e.salary)
FROM emp e JOIN dept d ON e.department_id = d.department_id
GROUP BY d.department_name;

CREATE VIEW Dept_Managers_view("DEPT_NAME", "MGR_NAME") AS
SELECT d.department_name, SUBSTR(e.first_name, 1, 1) || '.' || e.last_name
FROM dept d JOIN emp e ON d.manager_id = e.employee_id;

CREATE VIEW V3 AS SELECT 1;
DROP VIEW V3;

CREATE SEQUENCE ct_seq;
SELECT nextval('ct_seq');

INSERT INTO emp (employee_id, first_name, last_name, email, hire_date, job_id, salary, manager_id, department_id)
VALUES (nextval('ct_seq'), 'Kaare', 'Hansen', 'KHANSEN', current_date, 'Manager', 6500, 100, 10);

CREATE FUNCTION immutable_upper(text) RETURNS text AS $$ SELECT UPPER($1); $$ LANGUAGE sql IMMUTABLE;
CREATE INDEX emp_indx ON emp (employee_id DESC, immutable_upper(SUBSTR(first_name,1,1) ||' '|| last_name));
DROP INDEX emp_indx;
DROP FUNCTION immutable_upper(text);

SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name LIKE '%priv%';

GRANT SELECT ON emp TO PUBLIC;
SELECT grantee, table_schema, table_name, privilege_type FROM information_schema.table_privileges WHERE table_name = 'emp' AND grantee = 'PUBLIC';
REVOKE SELECT ON emp FROM PUBLIC;

SELECT e.employee_id, d.department_name
FROM emp e CROSS JOIN dept d;

SELECT e.employee_id, d.department_name
FROM emp e JOIN dept d ON e.department_id = d.department_id;

SELECT e.last_name, d.department_name, e.salary, c.country_name
FROM emp e
JOIN dept d ON e.department_id = d.department_id
JOIN locations_base l ON d.location_id = l.location_id
JOIN countries_base c ON l.country_id = c.country_id;

SELECT e.last_name, d.department_name, e.salary, c.country_name
FROM emp e
LEFT JOIN dept d ON e.department_id = d.department_id
LEFT JOIN locations_base l ON d.location_id = l.location_id
LEFT JOIN countries_base c ON l.country_id = c.country_id;




DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS countries CASCADE;

CREATE TABLE countries (
    country_id   CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40)
);

CREATE TABLE locations (
    location_id    NUMERIC PRIMARY KEY,
    city           VARCHAR(30),
    country_id     CHAR(2) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id   NUMERIC PRIMARY KEY,
    department_name VARCHAR(30),
    location_id     NUMERIC REFERENCES locations(location_id)
);

CREATE TABLE employees (
    employee_id   NUMERIC PRIMARY KEY,
    last_name     VARCHAR(25),
    salary        NUMERIC(8,2),
    department_id NUMERIC REFERENCES departments(department_id)
);

INSERT INTO countries (country_id, country_name) VALUES
('US', 'United States of America'),
('CA', 'Canada'),
('UK', 'United Kingdom');

INSERT INTO locations (location_id, city, country_id) VALUES
(1700, 'Seattle', 'US'),
(2000, 'Toronto', 'CA'),
(2400, 'London', 'UK');

INSERT INTO departments (department_id, department_name, location_id) VALUES
(90, 'Executive', 1700),
(80, 'Sales', 2400),
(60, 'IT', 1700),
(50, 'Shipping', 1700),
(20, 'Marketing', 2000),
(110, 'Accounting', 1700),
(10, 'Administration', 1700);

INSERT INTO employees (employee_id, last_name, salary, department_id) VALUES
(100, 'King', 24000, 90),
(101, 'Kochhar', 17000, 90),
(102, 'De Haan', 17000, 90),
(103, 'Hunold', 9000, 60),
(114, 'Whalen', 4400, 10),
(121, 'Mourgos', 5800, 50),
(141, 'Rajs', 3500, 50),
(142, 'Davies', 3100, 50),
(143, 'Matos', 2600, 50),
(144, 'Vargas', 2500, 50),
(145, 'Zlotkey', 10500, 80),
(146, 'Abel', 11000, 80),
(147, 'Taylor', 8600, 80),
(201, 'Hartstein', 13000, 20),
(202, 'Fay', 6000, 20),
(205, 'Higgins', 12000, 110),
(206, 'Gietz', 8300, 110),
(207, 'Grant', 7000, NULL); 


SELECT e.last_name, d.department_name, e.salary, c.country_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id;