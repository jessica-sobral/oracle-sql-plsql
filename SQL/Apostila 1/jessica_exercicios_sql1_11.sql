/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 17/10/2022
-- Tópico: 11
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE TABLE dept (
    id   NUMBER(7) CONSTRAINT dept_dept_id_pk PRIMARY KEY,
    name VARCHAR2(25)
  );

  DESC dept;

--b)

  CREATE TABLE emp (
    id NUMBER(7),
    last_name VARCHAR2(25),
    first_name VARCHAR(25),
    dept_id NUMBER(7) CONSTRAINT emp_dept_id_fk REFERENCES dept(id)
  );

  DESC emp;

--c)

  ALTER TABLE emp
  ADD (commission NUMBER(2,2));

  DESC emp;

--d)

  ALTER TABLE emp
  MODIFY last_name VARCHAR2(50);

  DESC emp;

--e)

  ALTER TABLE emp
  DROP (first_name);

  DESC emp;

--f)

  ALTER TABLE emp
  SET UNUSED (dept_id);

  DESC emp;

--g)

  ALTER TABLE emp
  DROP UNUSED COLUMNS;

--h)

  CREATE TABLE employees2
    (id, first_name, last_name, salary, dept_id)
    AS SELECT employee_id, first_name, last_name, salary, department_id
       FROM employees;

  DESC employees2;

--i)

  ALTER TABLE employees2 READ ONLY;

--j)

  ALTER TABLE employees2
  ADD (job_id VARCHAR2(9));

--k)

  ALTER TABLE employees2 READ WRITE;
  
  ALTER TABLE employees2
  ADD (job_id VARCHAR2(9));

--l)

  DROP TABLE emp;

  DROP TABLE dept;

  DROP TABLE employees2;
