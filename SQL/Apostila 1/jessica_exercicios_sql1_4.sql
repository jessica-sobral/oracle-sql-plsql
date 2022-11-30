/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1 
-- Data: 29/09/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT SYSDATE "Date"
  FROM   dual;

--b, c)
  
  SELECT employee_id,
         last_name,
         ROUND(salary, 0) salary,
         ROUND(salary + ((1.555 * salary), 0) "New Salary"
  FROM   employees;

--d)

  SELECT employee_id,
         last_name,
         ROUND(salary, 0) salary,
         ROUND(salary + ((0.155 * salary), 0) "New Salary",
         (salary + (0.155 * salary)) - salary "Increase"
  FROM   employees;

--e)

  --i)

    SELECT INITCAP(last_name) "Name",
           LENGTH(last_name) "Length"
    FROM   employees
    WHERE  last_name LIKE 'J%'
    OR     last_name LIKE 'A%'
    OR     last_name LIKE 'M%'
    ORDER  BY last_name;

  --ii)

    SELECT INITCAP(last_name) "Name",
           LENGTH(last_name) "Length"
    FROM   employees
    WHERE  INITCAP(last_name) LIKE '&start_letter%';

  --iii)

    SELECT INITCAP(last_name) "Name",
           LENGTH(last_name) "Length"
    FROM   employees
    WHERE  INITCAP(last_name) LIKE UPPER('&start_letter%');

--f)

  SELECT last_name,
         ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) months_worked
  FROM   employees
  ORDER  BY months_worked;

--g)

  SELECT last_name,
         LPAD(salary, 15, '$') salary
  FROM   employees;

--h)

  SELECT CONCAT(RPAD(SUBSTR(last_name, 1, 8), 8, ' '),
                RPAD(' ', TRUNC(salary / 1000) + 1, '*')) employees_and_their_salaries
  FROM   employees
  ORDER  BY salary DESC;

--i)

  SELECT last_name,
         TRUNC((SYSDATE - hire_date) / 7) tenure
  FROM   employees
  WHERE  department_id = 90
  ORDER  BY tenure DESC;
