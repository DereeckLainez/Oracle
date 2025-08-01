--Leccion 16

DROP TABLE IF EXISTS runners CASCADE;
DROP TABLE IF EXISTS employees_base CASCADE;
DROP TABLE IF EXISTS departments_base CASCADE;
DROP SEQUENCE IF EXISTS runner_id_seq;
DROP SEQUENCE IF EXISTS departments_seq;
DROP SEQUENCE IF EXISTS employees_seq;

CREATE SEQUENCE runner_id_seq
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 50000
    CACHE 1
    NO CYCLE;

CREATE TABLE runners (
    runner_id NUMERIC(6,0) CONSTRAINT runners_id_pk PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30)
);

INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Adam', 'Curtis');

SELECT runner_id, first_name, last_name
FROM runners;

SELECT currval('runner_id_seq');

SELECT sequence_name, minimum_value, maximum_value, increment
FROM information_schema.sequences
WHERE sequence_name = 'runner_id_seq';

ALTER SEQUENCE runner_id_seq
    MAXVALUE 999999;

DROP SEQUENCE runner_id_seq;

CREATE TABLE departments_base (
    department_id NUMERIC PRIMARY KEY,
    department_name VARCHAR(100),
    location_id NUMERIC
);

CREATE TABLE employees_base (
    employee_id NUMERIC PRIMARY KEY,
    last_name VARCHAR(100),
    department_id NUMERIC
);

CREATE SEQUENCE departments_seq START WITH 1;
CREATE SEQUENCE employees_seq START WITH 1;

INSERT INTO departments_base (department_id, department_name, location_id)
VALUES (nextval('departments_seq'), 'Support', 2500);

INSERT INTO employees_base (employee_id, department_id, last_name)
VALUES (nextval('employees_seq'), currval('departments_seq'), 'Miller');

DROP INDEX IF EXISTS wf_cont_reg_id_idx;
DROP INDEX IF EXISTS emps_name_idx;
DROP INDEX IF EXISTS upper_last_name_idx;
DROP INDEX IF EXISTS emp_hire_year_idx;
DROP VIEW IF EXISTS amy_emps;
DROP TABLE IF EXISTS employees_base CASCADE;
DROP TABLE IF EXISTS wf_countries_base CASCADE;
DROP TABLE IF EXISTS amy_copy_employees_base CASCADE;

CREATE TABLE employees_base (
    employee_id NUMERIC,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);

CREATE TABLE wf_countries_base (
    country_id NUMERIC,
    region_id NUMERIC
);

CREATE TABLE amy_copy_employees_base (
    id NUMERIC PRIMARY KEY,
    data VARCHAR(100)
);

CREATE INDEX wf_cont_reg_id_idx
ON wf_countries_base (region_id);

CREATE INDEX emps_name_idx
ON employees_base(first_name, last_name);

CREATE INDEX upper_last_name_idx
ON employees_base (UPPER(last_name));

CREATE INDEX emp_hire_year_idx
ON employees_base (EXTRACT(YEAR FROM hire_date));

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'employees_base';

DROP INDEX upper_last_name_idx;
DROP INDEX emps_name_idx;
DROP INDEX emp_hire_year_idx;

CREATE VIEW amy_emps AS
SELECT * FROM amy_copy_employees_base;

DROP VIEW amy_emps;


SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'employees_base';

DROP INDEX upper_last_name_idx;
DROP INDEX emps_name_idx;
DROP INDEX emp_hire_year_idx;

CREATE VIEW amy_emps AS
SELECT * FROM amy_copy_employees_base;

DROP VIEW amy_emps;

 SELECT first_name, last_name, hire_date
 FROM employees
 WHERE TO_CHAR(hire_date, 'yyyy') = '1987'

