-- Leccion 17

DROP TABLE IF EXISTS employees_base CASCADE;
DROP USER IF EXISTS scott;
DROP USER IF EXISTS steven_king;

CREATE TABLE employees_base (
    employee_id NUMERIC PRIMARY KEY,
    last_name VARCHAR(100),
    salary NUMERIC(8,2)
);

CREATE USER scott WITH PASSWORD 'ur35scott';
CREATE USER steven_king WITH PASSWORD 'initial_password';

ALTER USER scott WITH PASSWORD 'imscott35';

GRANT CONNECT ON DATABASE postgres TO scott;
GRANT USAGE, CREATE ON SCHEMA public TO scott;

GRANT SELECT ON TABLE employees_base TO scott;

GRANT UPDATE (salary) ON employees_base TO steven_king;

GRANT SELECT ON TABLE employees_base TO PUBLIC;

SELECT
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM
    information_schema.table_privileges
WHERE
    table_name = 'employees_base';


DROP VIEW IF EXISTS clients_synonym;
DROP TABLE IF EXISTS clients_base CASCADE;
DROP ROLE IF EXISTS manager;
DROP ROLE IF EXISTS jennifer_cho;
DROP ROLE IF EXISTS scott_king;

CREATE TABLE clients_base (
    id NUMERIC PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE USER jennifer_cho WITH PASSWORD 'a_password';
CREATE USER scott_king WITH PASSWORD 'a_password';

CREATE ROLE manager;

GRANT CREATE, USAGE ON SCHEMA public TO manager;

GRANT manager TO jennifer_cho;

GRANT SELECT ON clients_base TO PUBLIC;

GRANT UPDATE(first_name, last_name) ON clients_base TO jennifer_cho, manager;

GRANT SELECT, INSERT ON clients_base TO scott_king WITH GRANT OPTION;

REVOKE SELECT, INSERT ON clients_base FROM scott_king;

CREATE VIEW clients_synonym AS
SELECT * FROM clients_base;

DROP TABLE IF EXISTS employees_base CASCADE;
DROP TABLE IF EXISTS wf_countries_base CASCADE;
DROP TABLE IF EXISTS my_contacts CASCADE;

CREATE TABLE employees_base (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE wf_countries_base (
    country_name VARCHAR(100)
);

CREATE TABLE my_contacts (
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    email VARCHAR(30) CHECK(email ~ '.+@.+\..+')
);

INSERT INTO employees_base (first_name, last_name, email) VALUES
('Steven', 'King', 'sking@example.com'),
('Stephen', 'Stiles', 'sstiles@example.com'),
('Higgins', 'Shelley', 'shiggins@example.com'),
('Hartstein', 'Michael', 'mhartstein@example.com');

INSERT INTO wf_countries_base (country_name) VALUES
('Arab Republic of Egypt'),
('Gabonese Republic'),
('Canada');

SELECT first_name, last_name
FROM employees_base
WHERE first_name ~ '^Ste(v|ph)en$';

SELECT last_name, REGEXP_REPLACE(last_name, '^H(a|e|i|o|u)', '**') AS "Name changed"
FROM employees_base;

SELECT
    country_name,
    array_length(regexp_matches(country_name, '(ab)', 'g'), 1) AS "Count of 'ab'"
FROM wf_countries_base
WHERE country_name ~ '(ab)';

ALTER TABLE employees_base
ADD CONSTRAINT email_addr_chk CHECK(email ~ '@');

INSERT INTO wf_countries_base (country_name) VALUES
('Republic of Zimbabwe'),
('Arab Republic of Egypt'),
('Great Socialist Peoples Libyan Arab Jamahiriya'),
('Kingdom of Saudi Arabia'),
('Syrian Arab Republic'),
('Gabonese Republic'),
('United Arab Emirates'),
('Canada');