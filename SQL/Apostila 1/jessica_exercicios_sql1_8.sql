/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 11/10/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT last_name,
         hire_date
  FROM   employees
  WHERE  department_id =
         (SELECT department_id
          FROM   employees
          WHERE  LOWER(last_name) = LOWER('&enter_name'))
  AND    LOWER(last_name) != LOWER('&enter_name');
        
--b)

  SELECT employee_id,
         last_name,
         salary
  FROM   employees
  WHERE  salary > (SELECT AVG(salary)
                   FROM   employees)
  ORDER  BY salary;

--c)

  SELECT employee_id,
         last_name
  FROM   employees
  WHERE  department_id IN (SELECT department_id
                           FROM   employees
                           WHERE  last_name LIKE '%u%');

--d)

  SELECT last_name,
         department_id,
         job_id
  FROM   employees
  WHERE  department_id IN
         (SELECT department_id
          FROM   departments
          WHERE  location_id = TO_NUMBER('&location'));

--e)

  SELECT last_name,
         ROUND(salary) salary
  FROM   employees
  WHERE  manager_id IN (SELECT employee_id
                        FROM   employees
                        WHERE  last_name = 'King');

--f)

  SELECT department_id,
         last_name,
         job_id
  FROM   employees
  WHERE  department_id IN
         (SELECT department_id
          FROM   departments
          WHERE  department_name = 'Executive');

--g)

  SELECT last_name
  FROM   employees
  WHERE  salary > ANY (SELECT salary
          FROM   employees
          WHERE  department_id = 60);

--h)

  SELECT employee_id,
         last_name,
         ROUND(salary) salary
  FROM   employees
  WHERE  salary > (SELECT AVG(salary)
                   FROM   employees)
  AND    department_id IN (SELECT department_id
                           FROM   employees
                           WHERE  last_name LIKE '%u%');



