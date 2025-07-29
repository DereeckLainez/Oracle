--Leccion 12

CREATE TABLE copy_departments
 AS (SELECT * FROM departments);

DESCRIBE copy_employees;

SELECT * FROM copy_employees;

DESCRIBE copy_departments;

SELECT * FROM copy_departments;

INSERT INTO copy_departments
 (department_id, department_name, manager_id, location_id)
 VALUES (200,'Human Resources', 205, 1500);

INSERT INTO copy_departments
 VALUES 
(210,'Estate Management', 102, 1700);

DESCRIBE copy_departments;



INSERT INTO copy_employees
 (employee_id, first_name, last_name, email, phone_number,    
hire_date, job_id, salary)
 VALUES
 (302,'Grigorz','Polanski', 'gpolanski', '', '15-Jun-2017',   
'IT_PROG',4200);

CREATE TABLE copy_employees (
    employee_id     INTEGER PRIMARY KEY,
    first_name      VARCHAR(20),
    last_name       VARCHAR(25) NOT NULL,
    email           VARCHAR(25) UNIQUE,
    phone_number    VARCHAR(20),
    hire_date       DATE NOT NULL,
    job_id          VARCHAR(10) NOT NULL,
    salary          NUMERIC(8,2),      
    comm_pct        NUMERIC(2,2),      
    manager_id      INTEGER,          
    department_id   INTEGER,         
    bonus           VARCHAR(10)
);

INSERT INTO copy_employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES
(304, 'Test', 'USER', 't_user', 4159982010, CURRENT_DATE, 'ST_CLERK', 2500);

SELECT first_name, TO_CHAR(hire_date,'Month, fmdd, yyyy')
FROM employees
WHERE employee_id = 101;

INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, 
hire_date,job_id, salary)
VALUES
(301,'Katie','Hernandez', 'khernandez','8586667641', 
TO_DATE('July 8, 2017', 'Month fmdd, yyyy'),
'MK_REP',4200); 


INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, 
hire_date, job_id, salary)
VALUES
(303,'Angelina','Wright', 'awright','4159982010', 
TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'),
'MK_REP', 3600); 

SELECT first_name, last_name, 
TO_CHAR(hire_date, 'dd-Mon-YYYY HH24:MI') As "Date and Time"
FROM copy_employees
WHERE employee_id = 303;

CREATE TABLE sales_reps (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100), 
    salary NUMERIC(10,2),
    commission_pct NUMERIC(5,2)
);

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

INSERT INTO sales_reps
SELECT * 
FROM employees;

UPDATE copy_employees
SET phone_number = '123456'
WHERE employee_id = 303;

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE employee_id >= 303;

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE employee_id = 100)
WHERE employee_id = 101;

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE employee_id = 205), 
job_id = (SELECT job_id
FROM copy_employees
WHERE employee_id = 205)
WHERE employee_id = 206;

UPDATE copy_employees
SET salary = (SELECT salary
FROM employees
WHERE employee_id = 205)
WHERE employee_id = 202;

ALTER TABLE copy_employees
ADD COLUMN department_name VARCHAR(30) DEFAULT 'Desconocido' NOT NULL;

UPDATE copy_employees
SET department_name = 'Ventas'
WHERE employee_id = 100;

ALTER TABLE copy_employees
ADD COLUMN department_name VARCHAR(30) DEFAULT 'Sin Asignar' NOT NULL;

UPDATE copy_employees
SET department_name = 'Contabilidad'
WHERE employee_id = 200;

UPDATE copy_employees
SET department_name = d.department_name
FROM departments d
WHERE copy_employees.department_id = d.department_id;

DELETE from copy_employees
WHERE employee_id = 303;

DELETE FROM copy_employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Shipping');

DELETE FROM copy_employees
WHERE manager_id IN (
    SELECT manager_id
    FROM employees
    GROUP BY manager_id
    HAVING COUNT(DISTINCT department_id) < 2 
);

UPDATE copy_employees
SET last_name = (SELECT last_name
FROM copy_employees
WHERE employee_id = 999)
WHERE employee_id = 101;

SELECT e.employee_id, e.salary, d.department_name
FROM employees e JOIN departments d USING(department_id)
WHERE job_id = 'ST_CLERK' AND location_id = 1500
ORDER BY e.employee_id
FOR UPDATE;            

CREATE TABLE my_employees (
    hire_date DATE DEFAULT CURRENT_DATE,
    first_name VARCHAR(15),          
    last_name VARCHAR(15)               
);

INSERT INTO my_employees
(hire_date, first_name, last_name)
VALUES
(DEFAULT, 'Angelina','Wright');

INSERT INTO my_employees
(first_name, last_name)
VALUES
('Angelina','Wright');

UPDATE my_employees
SET hire_date = DEFAULT
WHERE last_name = 'Wright';

INSERT INTO my_employees (first_name, last_name)
VALUES
    ('John', 'Doe'),
    ('Jane', 'Smith'),
    ('Peter', 'Jones');

INSERT INTO all_calls (caller_id, call_timestamp, call_duration, call_format)
SELECT caller_id, call_timestamp, call_duration, call_format
FROM calls
WHERE call_format IN ('tik','txt','pic');

INSERT INTO police_record_calls (caller_id, call_timestamp, recipient_caller)
SELECT caller_id, call_timestamp, recipient_caller
FROM calls
WHERE call_format IN ('tik','txt');

INSERT INTO short_calls (caller_id, call_timestamp, call_duration)
SELECT caller_id, call_timestamp, call_duration
FROM calls
WHERE call_duration > 50 AND call_type = 'tik'; 

INSERT INTO long_calls (caller_id, call_timestamp, call_duration, call_format, recipient_caller) 
SELECT caller_id, call_timestamp, call_duration, call_format, recipient_caller
FROM calls
WHERE DATE_TRUNC('day', call_timestamp) = CURRENT_DATE;

CREATE TABLE all_calls (
    caller_id VARCHAR(50),
    call_timestamp TIMESTAMP,
    call_duration INTEGER,    
    call_format VARCHAR(10)   
);

CREATE TABLE police_record_calls (
    caller_id VARCHAR(50), 
    call_timestamp TIMESTAMP,
    recipient_caller VARCHAR(50) 
);

CREATE TABLE calls (
    caller_id VARCHAR(50),      
    call_timestamp TIMESTAMP,  
    call_duration INTEGER,     
    call_format VARCHAR(10), 
    recipient_caller VARCHAR(50),
    call_type VARCHAR(10)    
);

INSERT INTO calls (caller_id, call_timestamp, call_duration, call_format, recipient_caller, call_type) VALUES
('user1', '2025-07-24 10:00:00', 60, 'tik', 'receiver1', 'tik'),
('user2', '2025-07-24 10:05:00', 30, 'txt', 'receiver2', 'txt'),
('user3', '2025-07-23 11:10:00', 70, 'pic', 'receiver3', 'tik'),
('user4', '2025-07-24 10:15:00', 45, 'vid', 'receiver4', 'vid');

CREATE TABLE short_calls (
    caller_id VARCHAR(50),     
    call_timestamp TIMESTAMP, 
    call_duration INTEGER     
);

CREATE TABLE long_calls (
    caller_id VARCHAR(50),
    call_timestamp TIMESTAMP,
    call_duration INTEGER,
    call_format VARCHAR(10),
    recipient_caller VARCHAR(50)
);