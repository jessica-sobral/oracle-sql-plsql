/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 21/10/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE VIEW employees_vu AS
    SELECT employee_id,
           last_name employee,
           department_id
    FROM   employees;

--b)

  SELECT *
  FROM   employees_vu;

--c)

  SELECT employee,
         department_id
  FROM   employees_vu;

--d)

  CREATE VIEW dept50(empno, employee, deptno) AS
    SELECT employee_id,
           last_name,
           department_id
    FROM   employees
    WHERE  department_id = 50
  WITH CHECK OPTION CONSTRAINT deptvu20_ck;

--e)

  DESC dept50;

  SELECT *
  FROM   dept50;

--f)

  UPDATE dept50
  SET    deptno = 80
  WHERE  employee = 'Mikkilineni';

--g)

  SELECT *
  FROM   user_views;

  SELECT view_name,
         text
  FROM   user_views;

--h)

  DROP VIEW employees_vu;

  DROP VIEW dept50;
