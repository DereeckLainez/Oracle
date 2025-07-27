--Leccion 8
/*
SELECT MAX(salary) 
  FROM employees; 

 UPDATE employees SET salary = 24000 WHERE last_name = 'King'; 

 UPDATE employees SET salary = 17000 WHERE last_name = 'Kochhar'; 
 UPDATE employees SET salary = 17000 WHERE last_name = 'De Haan'; 
 UPDATE employees SET salary = 9000 WHERE last_name = 'Hunold'; 

 SELECT 
     department_id, 
     AVG(salary) AS "Salario Promedio" 
 FROM 
     employees 
 GROUP BY 
     department_id 
 ORDER BY 
     department_id; 

 SELECT MIN(salary) FROM employees; 

  -- Asignar las comisiones a los empleados del ejemplo 
 UPDATE employees SET commission_pct = 0.20 WHERE last_name = 'Zlotkey'; 
 UPDATE employees SET commission_pct = 0.30 WHERE last_name = 'Abel'; 
 UPDATE employees SET commission_pct = 0.20 WHERE last_name = 'Taylor'; 
 UPDATE employees SET commission_pct = 0.15 WHERE last_name = 'Grant'; 

 -- Asegurarse de que los demás no tengan comisión (valor nulo) 
 UPDATE employees SET commission_pct = NULL WHERE last_name IN ('King', 'Kochhar', 'De Haan', 'Mourgos'); 

 SELECT AVG(commission_pct) 
 FROM employees; 

 SELECT MAX(salary), MIN(salary), MIN(employee_id) 
  FROM employees 
  WHERE department_id = 60; 


 INSERT INTO jobs (job_id, job_title) VALUES 
 ('ST_CLERK', 'Stock Clerk'), 
 ('MK_REP', 'Marketing Representative') 
 ON CONFLICT (job_id) DO NOTHING; 

 UPDATE employees SET job_id = 'SA_REP' WHERE last_name = 'Grant'; 
 UPDATE employees SET job_id = 'ST_CLERK' WHERE last_name = 'Mourgos'; 
 UPDATE employees SET job_id = 'ST_CLERK' WHERE last_name = 'Rajs'; 
 UPDATE employees SET job_id = 'ST_CLERK' WHERE last_name = 'Davies'; 
 UPDATE employees SET job_id = 'ST_CLERK' WHERE last_name = 'Matos'; 
 UPDATE employees SET job_id = 'ST_CLERK' WHERE last_name = 'Vargas'; 
 UPDATE employees SET job_id = 'IT_PROG' WHERE last_name = 'Hunold'; 
 UPDATE employees SET job_id = 'IT_PROG' WHERE last_name = 'Ernst'; 
 UPDATE employees SET job_id = 'IT_PROG' WHERE last_name = 'Lorentz'; 
 UPDATE employees SET job_id = 'MK_REP' WHERE last_name = 'Hartstein'; 
 UPDATE employees SET job_id = 'MK_REP' WHERE last_name = 'Fay'; 

 SELECT COUNT(job_id) 
  FROM employees; 

 SELECT commission_pct 
  FROM employees; 

 SELECT COUNT(commission_pct) 
  FROM employees; 

 UPDATE employees SET hire_date = '1987-06-17' WHERE last_name = 'King'; 
 UPDATE employees SET hire_date = '1989-09-21' WHERE last_name = 'Kochhar'; 
 UPDATE employees SET hire_date = '1993-01-13' WHERE last_name = 'De Haan'; 
 UPDATE employees SET hire_date = '1987-09-17' WHERE last_name = 'Whalen'; 
 UPDATE employees SET hire_date = '1994-06-07' WHERE last_name = 'Higgins'; 
 UPDATE employees SET hire_date = '1994-06-07' WHERE last_name = 'Gietz'; 
 UPDATE employees SET hire_date = '1990-01-03' WHERE last_name = 'Hunold'; 
 UPDATE employees SET hire_date = '1991-05-21' WHERE last_name = 'Ernst'; 
 UPDATE employees SET hire_date = '1995-11-16' WHERE last_name = 'Mourgos'; 

  SELECT COUNT(*)  
 FROM employees 
  WHERE hire_date < '01-Jan-1996'; 

 SELECT job_id 
  FROM employees; 

 SELECT DISTINCT job_id 
  FROM employees; 

  SELECT DISTINCT job_id,    
 department_id 
  FROM employees; 

 SELECT SUM(salary) 
  FROM employees 
  WHERE department_id = 90; 

 SELECT SUM(DISTINCT salary) 
  FROM employees 
  WHERE department_id = 90; 

 SELECT COUNT (DISTINCT  
 job_id) 
  FROM employees; 

  SELECT COUNT (DISTINCT salary) 
  FROM employees; 

 SELECT AVG(commission_pct) 
  FROM employees; 

 SELECT AVG(COALESCE(commission_pct, 0)) 
 FROM employees;
*/