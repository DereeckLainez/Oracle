--Leccion 14

DROP TABLE IF EXISTS clients_p10;
CREATE TABLE clients_p10 (
    client_number NUMERIC(4),
    first_name VARCHAR(14),
    last_name VARCHAR(13)
);

DROP TABLE IF EXISTS clients_p11;
CREATE TABLE clients_p11 (
    client_number NUMERIC(4) CONSTRAINT clients_client_num_pk_p11 PRIMARY KEY,
    first_name VARCHAR(14),
    last_name VARCHAR(13)
);

DROP TABLE IF EXISTS clients_p14;
CREATE TABLE clients_p14 (
    client_number NUMERIC(4),
    last_name VARCHAR(13),
    email VARCHAR(80)
);

DROP TABLE IF EXISTS clients_p15;
CREATE TABLE clients_p15 (
    client_number NUMERIC(4) CONSTRAINT clients_client_number_pk_p15 PRIMARY KEY,
    last_name VARCHAR(13) CONSTRAINT clients_last_name_nn_p15 NOT NULL,
    email VARCHAR(80) CONSTRAINT clients_email_uk_p15 UNIQUE
);

DROP TABLE IF EXISTS clients_p16;
CREATE TABLE clients_p16 (
    client_number NUMERIC(4) CONSTRAINT clients_client_num_pk_p16 PRIMARY KEY,
    last_name VARCHAR(13) NOT NULL,
    email VARCHAR(80)
);

DROP TABLE IF EXISTS clients_p18;
CREATE TABLE clients_p18 (
    client_number NUMERIC(6) NOT NULL,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(10) NOT NULL,
    CONSTRAINT clients_phone_email_uk_p18 UNIQUE (email, phone)
);


DROP TABLE IF EXISTS clients_corrected;
CREATE TABLE clients_corrected (
    client_number NUMERIC(6),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(10) NOT NULL, 

    CONSTRAINT clients_corrected_pk PRIMARY KEY (client_number),
    CONSTRAINT clients_corrected_phone_email_uk UNIQUE (email, phone)
);

 INSERT INTO clients (client_number, first_name, Last_name, phone, 
email)
 VALUES (7234, 'Lonny', 'Vigil', 4072220091, 'lbv@lbv.net');

DROP TABLE IF EXISTS clients_p7 CASCADE;
CREATE TABLE clients_p7 (
    client_number NUMERIC(4) CONSTRAINT clients_client_num_pk_p7 PRIMARY KEY,
    first_name VARCHAR(14),
    last_name VARCHAR(13)
);

DROP TABLE IF EXISTS clients_p8 CASCADE;
CREATE TABLE clients_p8 (
    client_number NUMERIC(4),
    first_name VARCHAR(14),
    last_name VARCHAR(13),
    CONSTRAINT clients_client_num_pk_p8 PRIMARY KEY (client_number)
);

DROP TABLE IF EXISTS copy_job_history_p9 CASCADE;
CREATE TABLE copy_job_history_p9 (
    employee_id NUMERIC(6,0),
    start_date DATE,
    job_id VARCHAR(10),
    department_id NUMERIC(4,0),
    CONSTRAINT copy_jhist_id_st_date_pk_p9 PRIMARY KEY (employee_id, start_date)
);

DROP TABLE IF EXISTS departments_p18 CASCADE;
CREATE TABLE departments_p18 (
    department_id NUMERIC(4,0) PRIMARY KEY
);

DROP TABLE IF EXISTS copy_employees_p18 CASCADE;
CREATE TABLE copy_employees_p18 (
    employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk_p18 PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id NUMERIC(4,0) CONSTRAINT c_emps_dept_id_fk_p18 REFERENCES departments_p18 (department_id),
    email VARCHAR(25)
);

DROP TABLE IF EXISTS departments_p19 CASCADE;
CREATE TABLE departments_p19 (
    department_id NUMERIC(4,0) PRIMARY KEY
);

DROP TABLE IF EXISTS copy_employees_p19 CASCADE;
CREATE TABLE copy_employees_p19 (
    employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk_p19 PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id NUMERIC(4,0),
    email VARCHAR(25),
    CONSTRAINT c_emps_dept_id_fk_p19 FOREIGN KEY (department_id) REFERENCES departments_p19 (department_id)
);

DROP TABLE IF EXISTS copy_departments_p23 CASCADE;
CREATE TABLE copy_departments_p23 (
    department_id NUMERIC(4,0) PRIMARY KEY
);

DROP TABLE IF EXISTS copy_employees_p23 CASCADE;
CREATE TABLE copy_employees_p23 (
    employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk_p23 PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id NUMERIC(4,0),
    email VARCHAR(25),
    CONSTRAINT cdept_dept_id_fk_p23 FOREIGN KEY (department_id) REFERENCES copy_departments_p23 (department_id)
);

DROP TABLE IF EXISTS copy_departments_p24 CASCADE;
CREATE TABLE copy_departments_p24 (
    department_id NUMERIC(4,0) PRIMARY KEY
);

DROP TABLE IF EXISTS copy_employees_p24 CASCADE;
CREATE TABLE copy_employees_p24 (
    employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk_p24 PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id NUMERIC(4,0),
    email VARCHAR(25),
    CONSTRAINT cdept_dept_id_fk_p24 FOREIGN KEY (department_id) REFERENCES copy_departments_p24 (department_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS copy_departments_p25 CASCADE;
CREATE TABLE copy_departments_p25 (
    department_id NUMERIC(4,0) PRIMARY KEY
);

DROP TABLE IF EXISTS copy_employees_p25 CASCADE;
CREATE TABLE copy_employees_p25 (
    employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk_p25 PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id NUMERIC(4,0),
    email VARCHAR(25),
    CONSTRAINT cdept_dept_id_fk_p25 FOREIGN KEY (department_id) REFERENCES copy_departments_p25 (department_id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS copy_job_history_p28 CASCADE;
CREATE TABLE copy_job_history_p28 (
    employee_id NUMERIC(6,0),
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id NUMERIC(4,0),
    CONSTRAINT chist_emp_id_st_date_pk_p28 PRIMARY KEY (employee_id, start_date),
    CONSTRAINT cjhist_end_ck_p28 CHECK (end_date > start_date)
);

DROP TABLE IF EXISTS employees_p31 CASCADE;
CREATE TABLE employees_p31 (
    salary NUMERIC(8,2) CONSTRAINT employees_min_sal_ck_p31 CHECK (salary > 0)
);

DROP TABLE IF EXISTS employees_p8 CASCADE;
DROP TABLE IF EXISTS departments_p11 CASCADE;
DROP TABLE IF EXISTS copy_department_p15 CASCADE;

CREATE TABLE employees_p8 (
    employee_id NUMERIC,
    department_id NUMERIC,
    email VARCHAR(100)
);

CREATE TABLE departments_p11 (
    department_id NUMERIC PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE copy_department_p15 (
    dept_id NUMERIC,
    dept_name VARCHAR(50),
    CONSTRAINT c_dept_dept_id_pk_p15 PRIMARY KEY(dept_id)
);

ALTER TABLE employees_p8
ADD CONSTRAINT emp_id_pk_p8 PRIMARY KEY (employee_id);

ALTER TABLE employees_p8
ADD CONSTRAINT emp_dept_fk_p11 FOREIGN KEY (department_id)
REFERENCES departments_p11 (department_id) ON DELETE CASCADE;

ALTER TABLE employees_p8
ALTER COLUMN email SET NOT NULL;

ALTER TABLE copy_department_p15
DROP CONSTRAINT c_dept_dept_id_pk_p15 CASCADE;

ALTER TABLE employees_p8
ADD COLUMN temp_col_to_drop VARCHAR(10);

ALTER TABLE employees_p8
DROP COLUMN temp_col_to_drop CASCADE;

SELECT constraint_name, table_name, constraint_type, is_deferrable
FROM information_schema.table_constraints
WHERE table_name = 'employees_p8';