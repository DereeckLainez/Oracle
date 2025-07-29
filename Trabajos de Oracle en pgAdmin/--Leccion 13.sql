--Leccion 13

CREATE TABLE my_cd_collection (
    cd_number INTEGER,
    title VARCHAR(20),
    artist VARCHAR(20),
    purchase_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE my_friends (
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    email VARCHAR(30),
    phone_num VARCHAR(12),
    birth_date DATE
);

CREATE TABLE USER_TABLES (
    table_name VARCHAR(30),
    status VARCHAR(30)
);

SELECT table_name, status 
FROM USER_TABLES;

SELECT table_name, table_schema FROM information_schema.tables;

SELECT *
FROM information_schema.sequences
WHERE sequence_schema = 'public';

 CREATE TABLE time_ex1
 (exact_time TIMESTAMP);

  INSERT INTO time_ex1
 VALUES ('10-Jun-2017 10:52:29.123456');

INSERT INTO time_ex1 (exact_time)
VALUES (NOW());

INSERT INTO time_ex1 (exact_time)
VALUES (NOW());

 SELECT * 
FROM time_ex1;

 CREATE TABLE time_ex2
 (time_with_offset TIMESTAMP WITH TIME ZONE);

INSERT INTO time_ex2 (time_with_offset)
VALUES (NOW());

 INSERT INTO time_ex2
 VALUES ('10-Jun-2017 10:52:29.123456 AM +2:00');

  SELECT * 
FROM time_ex2;

CREATE TABLE time_ex3 (
    first_column TIMESTAMP WITH TIME ZONE,
    second_column TIMESTAMP WITH TIME ZONE
);

 INSERT INTO time_ex3
 (first_column, second_column)
 VALUES        
('15-Jul-2017 08:00:00 AM -07:00', '15-Nov-2007 08:00:00 AM -07:00');

SELECT * 
FROM time_ex3;

CREATE TABLE time_ex4 (
    loan_duration1 INTERVAL YEAR TO MONTH,
    loan_duration2 INTERVAL YEAR TO MONTH
);

INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES
    (INTERVAL '120' MONTH,
     INTERVAL '3-6' YEAR TO MONTH
    );

SELECT
    (DATE '2017-07-17' + loan_duration1) AS "120 months from now",
    (DATE '2017-07-17' + loan_duration2) AS "3 years 6 months from now"
FROM
    time_ex4;

CREATE TABLE time_ex5 (
    day_duration1 INTERVAL DAY TO SECOND,
    day_duration2 INTERVAL DAY TO SECOND
);

INSERT INTO time_ex5 (day_duration1, day_duration2)
VALUES
    (INTERVAL '25' DAY,
     INTERVAL '4 01:13:17' DAY TO SECOND
    );

SELECT
    (TIMESTAMP '2017-07-17 00:00:00' + day_duration1) AS "25 Days from now",
    TO_CHAR(TIMESTAMP '2017-07-17 00:00:00' + day_duration2, 'DD-Mon-YYYY HH24:MI:SS') AS "precise days and time from now"
FROM
    time_ex5;


CREATE TABLE mod_emp (
    last_name VARCHAR(20),
    salary NUMERIC(8,2)
);

ALTER TABLE mod_emp ALTER COLUMN last_name TYPE VARCHAR(30);

ALTER TABLE mod_emp ALTER COLUMN last_name TYPE VARCHAR(10);

 ALTER TABLE my_cd_collection
 DROP COLUMN release_date;

ALTER TABLE copy_employees
 DROP UNUSED COLUMNS;

CREATE SCHEMA IF NOT EXISTS recycle_bin;

ALTER TABLE my_cd_collection SET SCHEMA recycle_bin;

ALTER TABLE recycle_bin.my_cd_collection SET SCHEMA public;

 SELECT original_name, operation, droptime
 FROM user_recyclebin;

 SELECT table_name, comments
 FROM user_tab_comments;


CREATE TABLE employees_history (
    history_id SERIAL PRIMARY KEY,    
    operation_type CHAR(1) NOT NULL,  
    change_time TIMESTAMPTZ NOT NULL,  

    employee_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary NUMERIC(8,2),
    commission_pct NUMERIC(2,2),
    manager_id INT,
    department_id INT
);

CREATE OR REPLACE FUNCTION log_employees_changes()
RETURNS TRIGGER AS $$
BEGIN
    -- Quita 'email' de todas las listas de columnas
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO employees_history(operation_type, change_time, employee_id, first_name, last_name, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES ('D', NOW(), OLD.employee_id, OLD.first_name, OLD.last_name, OLD.phone_number, OLD.hire_date, OLD.job_id, OLD.salary, OLD.commission_pct, OLD.manager_id, OLD.department_id);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO employees_history(operation_type, change_time, employee_id, first_name, last_name, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES ('U', NOW(), NEW.employee_id, NEW.first_name, NEW.last_name, NEW.phone_number, NEW.hire_date, NEW.job_id, NEW.salary, NEW.commission_pct, NEW.manager_id, NEW.department_id);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO employees_history(operation_type, change_time, employee_id, first_name, last_name, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        VALUES ('I', NOW(), NEW.employee_id, NEW.first_name, NEW.last_name, NEW.phone_number, NEW.hire_date, NEW.job_id, NEW.salary, NEW.commission_pct, NEW.manager_id, NEW.department_id);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER employees_audit_trigger
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW EXECUTE FUNCTION log_employees_changes();

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (1, 'Natacha', 'Hansen', 'NHANSEN', '4412312341234', '1998-09-07', 'AD_VP', 12000, null, 100, 90);

UPDATE employees SET salary = 13500 WHERE employee_id = 1;

SELECT
    change_time,
    operation_type AS "OPERATION",
    first_name || ' ' || last_name AS "NAME",
    salary
FROM
    employees_history
WHERE
    employee_id = 1
ORDER BY
    change_time;




SELECT employee_id, salary
 FROM copy_employees
 WHERE employee_id = 1;