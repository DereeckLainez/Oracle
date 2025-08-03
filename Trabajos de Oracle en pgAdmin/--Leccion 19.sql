--Leccion 19

DROP TABLE IF EXISTS jobs_base CASCADE;

CREATE TABLE jobs_base (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary NUMERIC(6),
    max_salary NUMERIC(6)
);

INSERT INTO jobs_base (job_id, job_title, min_salary, max_salary)
VALUES ('TEST_JOB', NULL, 100, 200);


-- Limpiar la base de datos (opcional, para poder ejecutar el script varias veces)
DROP VIEW IF EXISTS V_CLIENTE_PEDIDOS;
DROP VIEW IF EXISTS CLIENTES_SINONIMO;
DROP TABLE IF EXISTS PEDIDOS;
DROP TABLE IF EXISTS CLIENTES;
DROP SEQUENCE IF EXISTS seq_cliente_id;
DROP SEQUENCE IF EXISTS seq_pedido_id;

----------------------------------------------------
-- PASO 1: CREAR TABLAS Y RESTRICCIONES
----------------------------------------------------

CREATE TABLE CLIENTES (
    cliente_id      NUMERIC(6)
        CONSTRAINT pk_clientes PRIMARY KEY,
    nombre_cliente  VARCHAR(100)
        CONSTRAINT nn_clientes_nombre NOT NULL,
    email           VARCHAR(100)
        CONSTRAINT uk_clientes_email UNIQUE
);

CREATE TABLE PEDIDOS (
    pedido_id       NUMERIC(10)
        CONSTRAINT pk_pedidos PRIMARY KEY,
    cliente_id      NUMERIC(6)
        CONSTRAINT fk_pedidos_clientes REFERENCES CLIENTES(cliente_id),
    fecha_pedido    DATE
        CONSTRAINT nn_pedidos_fecha NOT NULL,
    monto           NUMERIC(10, 2)
        CONSTRAINT chk_pedidos_monto CHECK (monto >= 0)
);

----------------------------------------------------
-- PASO 2: CREAR SECUENCIAS
----------------------------------------------------

CREATE SEQUENCE seq_cliente_id
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_pedido_id
    START WITH 1
    INCREMENT BY 1;

----------------------------------------------------
-- PASO 3: AGREGAR DATOS A LAS TABLAS
----------------------------------------------------

INSERT INTO CLIENTES (cliente_id, nombre_cliente, email)
VALUES
    (nextval('seq_cliente_id'), 'Juan Pérez', 'juan.perez@example.com'),
    (nextval('seq_cliente_id'), 'Ana López', 'ana.lopez@example.com');

INSERT INTO PEDIDOS (pedido_id, cliente_id, fecha_pedido, monto)
VALUES
    (nextval('seq_pedido_id'), 1, '2025-07-20', 150.75),
    (nextval('seq_pedido_id'), 2, '2025-07-21', 99.50),
    (nextval('seq_pedido_id'), 1, '2025-07-22', 210.00);

----------------------------------------------------
-- PASO 4: CREAR ÍNDICES
----------------------------------------------------

-- Es buena práctica crear índices en las claves foráneas (Foreign Keys)
CREATE INDEX idx_pedidos_cliente_id ON PEDIDOS(cliente_id);

----------------------------------------------------
-- PASO 5: CREAR VISTAS
----------------------------------------------------

CREATE VIEW V_CLIENTE_PEDIDOS AS
SELECT
    c.nombre_cliente,
    p.pedido_id,
    p.fecha_pedido,
    p.monto
FROM
    CLIENTES c
JOIN
    PEDIDOS p ON c.cliente_id = p.cliente_id;

----------------------------------------------------
-- PASO 6: CREAR SINÓNIMOS (Simulado con una Vista)
----------------------------------------------------

CREATE VIEW CLIENTES_SINONIMO AS
SELECT * FROM CLIENTES;

----------------------------------------------------
-- PASO 7: PROBAR LA BASE DE DATOS
----------------------------------------------------

-- Prueba 1: Intentar insertar un email duplicado (debe fallar)
INSERT INTO CLIENTES (cliente_id, nombre_cliente, email)
VALUES (nextval('seq_cliente_id'), 'Otro Juan', 'juan.perez@example.com');

-- Prueba 2: Consultar la vista
SELECT * FROM V_CLIENTE_PEDIDOS;

-- Prueba 3: Consultar el "sinónimo"
SELECT * FROM CLIENTES_SINONIMO;



DROP TABLE IF EXISTS employees_base CASCADE;
DROP TABLE IF EXISTS departments_base CASCADE;
DROP TABLE IF EXISTS job_grades_base CASCADE;
DROP TABLE IF EXISTS new_employees_table CASCADE;
DROP TABLE IF EXISTS merge_target CASCADE;

CREATE TABLE departments_base (
    department_id   NUMERIC PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees_base (
    employee_id     NUMERIC PRIMARY KEY,
    last_name       VARCHAR(100),
    salary          NUMERIC(8,2),
    department_id   NUMERIC REFERENCES departments_base(department_id)
);

CREATE TABLE job_grades_base (
    grade_level     VARCHAR(3),
    lowest_sal      NUMERIC,
    highest_sal     NUMERIC
);

CREATE TABLE merge_target (
    employee_id     NUMERIC PRIMARY KEY,
    last_name       VARCHAR(100),
    salary          NUMERIC(8,2)
);

INSERT INTO departments_base (department_id, department_name) VALUES
(10, 'Administration'),
(20, 'Marketing'),
(90, 'Executive');

INSERT INTO employees_base (employee_id, last_name, salary, department_id) VALUES
(100, 'King', 24000, 90),
(101, 'Kochhar', 17000, 90),
(102, 'De Haan', 17000, 90),
(201, 'Hartstein', 13000, 20),
(205, 'Higgins', 12000, NULL);

INSERT INTO job_grades_base (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 14999),
('E', 15000, 24999),
('F', 25000, 40000);

INSERT INTO merge_target (employee_id, last_name, salary) VALUES
(100, 'King_Old', 20000),
(201, 'Hartstein_Old', 10000);

SELECT e.last_name, d.department_name FROM employees_base e CROSS JOIN departments_base d;

SELECT employee_id, last_name, department_name FROM employees_base NATURAL JOIN departments_base;

SELECT e.last_name, e.salary, j.grade_level
FROM employees_base e JOIN job_grades_base j ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

SELECT e.last_name, d.department_name
FROM employees_base e LEFT JOIN departments_base d ON e.department_id = d.department_id;

SELECT department_id, COUNT(employee_id), AVG(salary)
FROM employees_base
GROUP BY department_id
HAVING COUNT(employee_id) > 1;

SELECT last_name, salary
FROM employees_base
WHERE salary > (SELECT AVG(salary) FROM employees_base);

INSERT INTO merge_target (employee_id, last_name, salary)
VALUES (101, 'Kochhar', 17000)
ON CONFLICT (employee_id) DO UPDATE
SET last_name = EXCLUDED.last_name, salary = EXCLUDED.salary;

INSERT INTO merge_target (employee_id, last_name, salary)
VALUES (100, 'King', 24000)
ON CONFLICT (employee_id) DO UPDATE
SET last_name = EXCLUDED.last_name, salary = EXCLUDED.salary;

CREATE TABLE new_employees_table AS
SELECT employee_id, last_name, salary
FROM employees_base
WHERE department_id = 90;

ALTER TABLE new_employees_table ADD COLUMN status VARCHAR(10) DEFAULT 'Active';
ALTER TABLE new_employees_table RENAME COLUMN status TO employee_status;
ALTER TABLE new_employees_table ALTER COLUMN last_name TYPE VARCHAR(150);
ALTER TABLE new_employees_table DROP COLUMN employee_status;