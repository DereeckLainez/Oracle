/*
--leccion 5

CREATE TABLE Elementos_Formato (
    Elemento VARCHAR(10) PRIMARY KEY,
    Descripcion VARCHAR(255),
    Ejemplo VARCHAR(20),
    Resultado VARCHAR(20)
);

INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('9', 'Posición numérica (el número de 9 determina el ancho)', '999999', '1234');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('0', 'Muestra ceros a la izquierda', '099999', '001234');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('$', 'Signo de dólar flotante', '$999999', '$1234');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('L', 'Símbolo de moneda local flotante', 'L99999', 'FF1234');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('.', 'Punto decimal en la posición especificada', '999999.99', '1234.00');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES (',', 'Coma en la posición especificada', '999,999', '1,234');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('MI', 'Signo de resta a la derecha (para valores negativos)', '999999MI', '1234-');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('PR', 'Encierra los números negativos entre paréntesis angulares', '999999PR', '<1234>');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('EEEE', 'Notación científica (debe tener cuatro E)', '99.999EEEE', '1,23E+03');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('V', 'Multiplica por 10 elevado a n (n es el número de 9 después de V)', '9999V99', '9999V99');
INSERT INTO Elementos_Formato (Elemento, Descripcion, Ejemplo, Resultado) VALUES ('B', 'Muestra los valores cero como espacios en blanco', 'B9999.99', '1234.00');

SELECT TO_CHAR(salary, 
'$99,999') AS "Salary"
 FROM employees;

TO_NUMBER(character string, 'format model')

SELECT TO_NUMBER('5,320', '9,999')
 AS "Number"
 FROM dual;

 SELECT last_name, TO_NUMBER(bonus, 
'999')
 FROM employees
 WHERE department_id = 80;

ALTER TABLE employees
ADD COLUMN bonus NUMERIC(8, 2);

SELECT last_name, TO_NUMBER(bonus, 
'9999')
 AS "Bonus"
 FROM employees
 WHERE department_id = 80;

 SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY') 
AS "Convert"
 FROM DUAL;

 SELECT TO_DATE('27-Oct-95','DD-Mon-YY')
 AS "Date"
 FROM dual;

  SELECT TO_DATE('27-Oct-95','DD-Mon-RR')
 AS "Date"
 FROM dual;

  SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
 FROM employees
 WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY'); 

SELECT
    TO_CHAR(
        CASE
            WHEN date_trunc('week', hire_date + INTERVAL '6 months') + INTERVAL '4 days' > hire_date + INTERVAL '6 months'
            THEN date_trunc('week', hire_date + INTERVAL '6 months') + INTERVAL '4 days'
            ELSE date_trunc('week', hire_date + INTERVAL '6 months') + INTERVAL '11 days'
        END
        , 'Day, Month dd, YYYY') AS "Next Evaluation"
FROM employees
WHERE employee_id = 100;

SELECT
    TO_CHAR(
        CASE
            WHEN date_trunc('week', hire_date + INTERVAL '6 months') + INTERVAL '4 days' > hire_date + INTERVAL '6 months'
            THEN date_trunc('week', hire_date + INTERVAL '6 months') + INTERVAL '4 days'
            ELSE date_trunc('week', hire_date + INTERVAL '6 months') + INTERVAL '11 days'
        END,
        'FMDay, FMMonth FMDD"th", YYYY'
    ) AS "Next Evaluation"
FROM employees
WHERE employee_id = 100;

ALTER TABLE wf_countries
ADD COLUMN internet_extension VARCHAR(5);

UPDATE wf_countries
SET internet_extension = '.za'
WHERE country_name = 'South Africa';

ALTER TABLE wf_countries
ADD COLUMN location VARCHAR(50);

UPDATE wf_countries
SET location = 'Southern Africa'
WHERE country_name = 'South Africa';

UPDATE wf_countries SET location = 'Southern Africa' WHERE country_name = 'Republic of Zimbabwe';
UPDATE wf_countries SET location = 'Southern Africa' WHERE country_name = 'Republic of Zambia';
UPDATE wf_countries SET location = 'Southern Africa' WHERE country_name = 'Juan de Nova Island';
UPDATE wf_countries SET location = 'Southern Africa' WHERE country_name = 'Europa Island';

UPDATE wf_countries SET internet_extension = '.zw' WHERE country_name = 'Republic of Zimbabwe';
UPDATE wf_countries SET internet_extension = '.zm' WHERE country_name = 'Republic of Zambia';

SELECT
    country_name,
    COALESCE(internet_extension, 'None') AS "Internet extn"
FROM
    wf_countries
WHERE
    location = 'Southern Africa'
ORDER BY
    internet_extension DESC;

UPDATE employees SET department_id = 80 WHERE last_name = 'Zlotkey';
UPDATE employees SET department_id = 80 WHERE last_name = 'Abel';
UPDATE employees SET department_id = 80 WHERE last_name = 'Taylor';

UPDATE employees SET department_id = 90 WHERE last_name = 'King';
UPDATE employees SET department_id = 90 WHERE last_name = 'Kochhar';
UPDATE employees SET department_id = 90 WHERE last_name = 'De Haan';

SELECT
    last_name,
    COALESCE(commission_pct, 0) * 250 AS "Commission"
FROM
    employees
WHERE
    department_id IN (80, 90);


SELECT
    last_name,
    salary,
    
    CASE
        WHEN commission_pct IS NOT NULL
        THEN salary + (salary * commission_pct)
        ELSE salary
    END AS "income"

FROM
    employees
WHERE
    department_id IN (80, 90);

UPDATE employees SET first_name = 'Ellen' WHERE last_name = 'Abel';
UPDATE employees SET first_name = 'Curtis' WHERE last_name = 'Davies';

SELECT
    first_name,
    CHAR_LENGTH(first_name) AS "Length FN",
    last_name,
    CHAR_LENGTH(last_name) AS "Length LN",
    NULLIF(CHAR_LENGTH(first_name), CHAR_LENGTH(last_name)) AS "Compare Them"
FROM
    employees
WHERE
    last_name IN ('Abel', 'Davies', 'De Haan');

SELECT last_name,  
COALESCE(commission_pct, salary, 10) 
AS "Comm"
 FROM employees
 ORDER BY commission_pct;

UPDATE employees SET department_id = 90 WHERE last_name = 'King';
UPDATE employees SET department_id = 90 WHERE last_name = 'Kochhar';
UPDATE employees SET department_id = 90 WHERE last_name = 'De Haan';

UPDATE employees SET department_id = 80 WHERE last_name = 'Zlotkey';
UPDATE employees SET department_id = 80 WHERE last_name = 'Abel';
UPDATE employees SET department_id = 80 WHERE last_name = 'Taylor';

UPDATE employees SET department_id = 60 WHERE last_name = 'Hunold';
UPDATE employees SET department_id = 60 WHERE last_name = 'Ernst';
UPDATE employees SET department_id = 60 WHERE last_name = 'Lorentz';

SELECT last_name, 
CASE department_id
 WHEN 90 THEN 'Management'
 WHEN 80 THEN 'Sales'
 WHEN 60 THEN 'It'
 ELSE 'Other dept.'
 END AS "Department"
 FROM employees;



INSERT INTO employees (employee_id, last_name, department_id) VALUES
(100, 'King', 90),
(101, 'Kochhar', 90),
(102, 'De Haan', 90),
(200, 'Whalen', 10),
(203, 'Higgins', 110),
(204, 'Gietz', 110),
(149, 'Zlotkey', 80),
(168, 'Abel', 80),
(174, 'Taylor', 80),
(176, 'Grant', 80),
(162, 'Mourgos', 50),
(163, 'Rajs', 50),
(150, 'Davies', 50),
(151, 'Matos', 50),
(152, 'Vargas', 50),
(103, 'Hunold', 60),
(104, 'Ernst', 60),
(107, 'Lorentz', 60),
(201, 'Hartstein', 20),
(202, 'Fay', 20);

SELECT
    last_name,
    CASE department_id
        WHEN 90 THEN 'Management'
        WHEN 80 THEN 'Sales'
        WHEN 60 THEN 'It'
        ELSE 'Other dept.'
    END AS "Department"
FROM
    employees;
*/