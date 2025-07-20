--leccion 2
/*
-- Crea la tabla 'departments'
CREATE TABLE departments (
    DEPARTMENT_ID   INTEGER      PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(30)  NOT NULL,
    MANAGER_ID      INTEGER,
    LOCATION_ID     INTEGER
);

-- Inserta los datos que se ven en la imagen y algunos más
INSERT INTO departments (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES
(10, 'Administration'),
(20, 'Marketing'),
(50, 'Shipping'),
(60, 'IT'),
(80, 'Sales'),
(90, 'Executive'),
(110, 'Accounting'),
(190, 'Contracting');
*/

/*
-- SELECT department_id || 
--department_name  
--FROM departments;

--SELECT department_id ||' '||department_name
-- FROM departments;

--SELECT department_id ||' '|| 
--department_name  AS " Department Info "
 --FROM departments;

--SELECT last_name ||' '|| 
--last_name AS "Employee Name"
--FROM employees;

 SELECT last_name || ' has a monthly  
salary of ' || salary || ' 
dollars.' AS Pay 
FROM employees;
*/

--SELECT last_name ||' has a '|| 1 ||' year salary of '|| 
--salary*12 || ' dollars.' AS Pay
--FROM employees;

--SELECT department_id
--FROM employees;

--SELECT DISTINCT department_id
--FROM employees;

