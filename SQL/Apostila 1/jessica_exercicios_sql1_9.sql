/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 13/10/2022
-- Tópico: 9
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT department_id
  FROM   employees
  MINUS
  SELECT department_id
  FROM   employees
  WHERE  job_id = 'ST_CLERK';

--b)

-- Primeira tentativa usando SUBQUERIES

  SELECT country_id,
         country_name
  FROM   countries
  MINUS
  SELECT country_id,
         country_name
  FROM   countries
  WHERE  country_id IN
         (SELECT country_id
          FROM   locations
          WHERE  location_id IN
                 (SELECT location_id
                  FROM   departments
                  WHERE  department_id IS NOT NULL));

-- Segunda tentativa usando JOINS

  SELECT country_id,
         country_name
  FROM   countries
  MINUS
  SELECT c.country_id,
         c.country_name
  FROM   countries c
  JOIN   locations l
  ON     c.country_id = l.country_id
  JOIN   departments d
  ON     l.location_id = d.location_id;

--c)

  SELECT DISTINCT job_id,
                  department_id
  FROM   employees
  WHERE  department_id = 10
  UNION ALL
  SELECT DISTINCT job_id,
                  department_id
  FROM   employees
  WHERE  department_id = 50
  UNION ALL
  SELECT DISTINCT job_id,
                  department_id
  FROM   employees
  WHERE  department_id = 20;

--d)

  SELECT employee_id,
         job_id
  FROM   employees
  INTERSECT
  SELECT employee_id,
         job_id
  FROM   job_history;

--e)

  SELECT last_name,
         department_id,
         TO_CHAR(NULL) dept_name
  FROM   employees
  UNION ALL
  SELECT TO_CHAR(NULL),
         department_id,
         department_name
  FROM   departments;
