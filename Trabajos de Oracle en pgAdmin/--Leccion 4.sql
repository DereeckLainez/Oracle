--Leccion 4

-- SELECT (319/29) + 12;

-- SELECT last_name
-- FROM employees
-- WHERE LOWER(last_name) = 'abel';

-- SELECT last_name
-- FROM employees
-- WHERE UPPER(last_name) = 'ABEL';

-- SELECT last_name
-- FROM employees
-- WHERE INITCAP(last_name) = 'Abel';

-- REPLACE (string1, string_to_replace, [replacement_string] )

-- SELECT LOWER(last_name)|| 
-- LOWER(SUBSTR(first_name,1,1))
-- AS "User Name"
-- FROM employees;

-- SELECT first_name, last_name, salary, department_id
-- FROM employees
-- WHERE department_id= 10;

-- SELECT first_name, last_name, salary, department_id
-- FROM employees
-- WHERE department_id=:enter_dept_id;

-- SELECT *
-- FROM  employees
-- WHERE last_name = :l_name;

-- CREATE TABLE wf_countries (
--     country_name VARCHAR(50),
--     airports     INTEGER
-- );

-- -- Paso 3: Insertar los datos de ejemplo
-- -- Nota: Se asignó un número de aeropuertos par o impar para que coincida con el resultado de la imagen.
-- INSERT INTO wf_countries (country_name, airports) VALUES
-- ('Canada', 247),                         -- Impar
-- ('Republic of Costa Rica', 4),           -- Par
-- ('Republic of Cape Verde', 7),           -- Impar
-- ('Greenland', 14),                       -- Par
-- ('Dominican Republic', 8),               -- Par
-- ('State of Eritrea', 3);                  -- Impar

-- -- Paso 4: Ejecutar la consulta del ejemplo para ver el resultado
-- SELECT
--     country_name,
--     MOD(airports, 2) AS "Mod Demo"
-- FROM
--     wf_countries;

-- CREATE TABLE dual (
--     sysdate VARCHAR(100)
-- );

--ALTER TABLE dual
--ADD COLUMN sysdate DATE;

--INSERT INTO dual (sysdate)
--VALUES ('2017-07-01');

-- SELECT SYSDATE
-- FROM dual;

-- SELECT employee_id, hire_date, 
-- ROUND(MONTHS_BETWEEN(sysdate, hire_date)) AS TENURE,
-- ADD_MONTHS (hire_date, 6) AS REVIEW, 
-- NEXT_DAY(hire_date, 'FRIDAY'), LAST_DAY(hire_date)
-- FROM employees
-- WHERE MONTHS_BETWEEN (sysdate, hire_date) > 36;


