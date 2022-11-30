/*
******************************Exerc�cios Treinamento************************
-- Nome: J�ssica Sobral Silva
-- M�dulo: SQL1
-- Data: 27/09/2022
-- T�pico: 2
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exerc�cio 1*/

--a, b) True

--c)

  /* O atributo "sal" n�o existe, o correto � "salary".
     Para multiplicar o sal�rio por 12 n�o � utilizado "x", o correto � "*".
     Ap�s o atributo "last_name" � necess�rio uma v�rgula, pois ainda h� uma express�o.
     Para o alias da express�o "salary*12" � necess�rio aspas duplas, pois h� um espa�o.
  */

  SELECT employee_id,
         last_name,
         salary * 12 "ANNUAL SALARY"
  FROM   employees;

/*Exerc�cio 2*/

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

/*Exerc�cio 3*/

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
