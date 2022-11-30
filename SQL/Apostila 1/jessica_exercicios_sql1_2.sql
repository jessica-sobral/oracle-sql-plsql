/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 27/09/2022
-- Tópico: 2
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, b) True

--c)

  /* O atributo "sal" não existe, o correto é "salary".
     Para multiplicar o salário por 12 não é utilizado "x", o correto é "*".
     Após o atributo "last_name" é necessário uma vírgula, pois ainda há uma expressão.
     Para o alias da expressão "salary*12" é necessário aspas duplas, pois há um espaço.
  */

  SELECT employee_id,
         last_name,
         salary * 12 "ANNUAL SALARY"
  FROM   employees;

/*Exercício 2*/

--a)

  DESCRIBE departments;

  SELECT *
  FROM   departments;

--b)

  --i)

    DESCRIBE employees;

  --ii)

    SELECT employee_id,
           last_name,
           job_id,
           hire_date startdate
    FROM   employees;

--c)

  SELECT DISTINCT job_id
  FROM   employees;

/*Exercício 3*/

--a)

  SELECT employee_id "Emp #",
         last_name   "Employee",
         job_id      "Job",
         hire_date   "Hire Date"
  FROM   employees;

--b)

  SELECT last_name || ', ' || job_id "Employee and Title"
  FROM   employees;

--c)

  SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' ||
         phone_number || ',' || job_id || ',' || manager_id || ',' ||
         hire_date || ',' || salary || ',' || commission_pct || ',' ||
         department_id the_output
  FROM   employees;
