--INICIO DE LA LECCION 1

-- -- Script para crear la tabla de países (COUNTRIES)

-- CREATE TABLE countries (
--     COUNTRY_ID   CHAR(2)       PRIMARY KEY, -- Llave primaria para el código de país
--     COUNTRY_NAME VARCHAR(40),               -- Nombre del país
--     REGION_ID    INT                        -- ID de la región a la que pertenece
-- );


-- -- Inserción de los datos en la tabla

-- INSERT INTO countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('CA', 'Canada', 2);
-- INSERT INTO countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('DE', 'Germany', 1);
-- INSERT INTO countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('UK', 'United Kingdom', 1);

--  SELECT <column_name(s)>
--  FROM <table_name>;
 
--  SELECT salary
--  FROM employees
--  WHERE last_name LIKE
--  'Smith'
 
--  SELECT * 
-- FROM countries;

-- SELECT country_id, country_name, region_id
--  FROM countries;

-- Script para crear la tabla de ubicaciones (LOCATIONS)

-- CREATE TABLE locations (
--     LOCATION_ID     INT           PRIMARY KEY, -- Llave primaria para el ID de la ubicación
--     CITY            VARCHAR(30),               -- Nombre de la ciudad
--     STATE_PROVINCE  VARCHAR(25)                -- Nombre del estado o provincia
-- );

-- Inserción de los datos en la tabla

-- INSERT INTO locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES (1800, 'Toronto', 'Ontario');
-- INSERT INTO locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES (2500, 'Oxford', 'Oxford');
-- INSERT INTO locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES (1400, 'Southlake', 'Texas');
-- INSERT INTO locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES (1500, 'South San Francisco', 'California');
-- INSERT INTO locations (LOCATION_ID, CITY, STATE_PROVINCE) VALUES (1700, 'Seattle', 'Washington');

--  SELECT location_id, city, state_province
--  FROM locations;

-- 1. Creación de la tabla base para almacenar los datos de empleados
-- Nota: En una base de datos real, se añadiría un ID único (llave primaria) a esta tabla.

-- CREATE TABLE employees (
--     LAST_NAME VARCHAR(25),
--     SALARY    INT
-- );

-- -- 2. Inserción de los datos en la tabla 'employees'

-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('King', 24000);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Kochhar', 17000);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('De Haan', 17000);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Whalen', 4400);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Higgins', 12000);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Gietz', 8300);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Zlotkey', 10500);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Abel', 11000);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Taylor', 8600);
-- INSERT INTO employees (LAST_NAME, SALARY) VALUES ('Grant', 7000);


-- -- 3. Consulta para obtener el resultado que se muestra en la imagen
-- -- Se selecciona el apellido, el salario y una nueva columna calculada sumando 300 al salario.

-- SELECT
--     LAST_NAME,
--     SALARY,
--     SALARY + 300 AS "SALARY+300"
-- FROM
--     employees;

--  SELECT last_name, salary, 
-- 12*salary +100
--  FROM employees;

-- SELECT last_name, salary, 
-- 12*(salary +100)
--  FROM employees;

-- 1. Creación de la tabla 'employees'
-- CREATE TABLE employees (
--     LAST_NAME      VARCHAR(25),
--     JOB_ID         VARCHAR(10),
--     SALARY         INT,
--     COMMISSION_PCT DECIMAL(2, 1) -- Permite decimales como 0.2
-- );
-- -- 2. Inserción de los datos, incluyendo los valores NULL
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('King', 'AD_PRES', 24000, NULL);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Kochhar', 'AD_VP', 17000, NULL);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('De Haan', 'AD_VP', 17000, NULL);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Whalen', 'AD_ASST', 4400, NULL);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Higgins', 'AC_MGR', 12000, NULL);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Gietz', 'AC_ACCOUNT', 8300, NULL);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Zlotkey', 'SA_MAN', 10500, 0.2);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Abel', 'SA_REP', 11000, 0.3);
-- INSERT INTO employees (LAST_NAME, JOB_ID, SALARY, COMMISSION_PCT) VALUES ('Taylor', 'SA_REP', 8600, 0.2);

--  SELECT last_name, job_id, salary, commission_pct, 
-- salary*commission_pct
--  FROM employees;


--SELECT last_name AS name,
  --     commission_pct AS comm
--FROM employees;

--SELECT last_name "Name",
  --     salary * 12 "Annual Salary"
--FROM employees;

--FIN DE LA LECCION 1

