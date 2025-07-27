--Leccion 11

SELECT SUBSTR(first_name,1,1)||' '||last_name AS "Employee Name",
       salary AS "Salary",
       CASE
           WHEN commission_pct IS NOT NULL THEN 'Yes'
           ELSE 'No'
       END AS "Commission"
FROM employees;