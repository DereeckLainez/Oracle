--Leccion 18

DROP TABLE IF EXISTS copy_departments CASCADE;

CREATE TABLE copy_departments (
    department_id NUMERIC,
    department_name VARCHAR(100),
    manager_id NUMERIC,
    location_id NUMERIC
);

INSERT INTO copy_departments (department_id, department_name, manager_id, location_id)
VALUES (60, 'IT', 205, 1400);

BEGIN;

UPDATE copy_departments
SET manager_id = 101
WHERE department_id = 60;

SAVEPOINT one;

INSERT INTO copy_departments (department_id, department_name, manager_id, location_id)
VALUES (130, 'Estate Management', 102, 1500);

UPDATE copy_departments
SET department_id = 140;

ROLLBACK TO SAVEPOINT one;

COMMIT;

SELECT * FROM copy_departments;