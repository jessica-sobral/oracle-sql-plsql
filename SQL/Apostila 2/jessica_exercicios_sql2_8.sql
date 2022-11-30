/*
******************************Exerc�cios Treinamento************************
-- Nome: J�ssica Sobral Silva
-- M�dulo: SQL2
-- Data: 27/10/2022
-- T�pico: 8
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exerc�cio 1*/

--a) CREATE SESSION. Se trata de um privil�gio de sistema.

--b) CREATE TABLE.

--c) Apenas os usu�rios que eu conceder acesso � essa tabela junto com a cl�usula WITH GRANT OPTION.

--d) Criar fun��es/papeis atrav�s do comando CREATE ROLE.

--e) ALTER USER.

  ALTER USER jsobrals
  IDENTIFIED BY password;

--f) Apenas o propriet�rio da tabela EMP.

--g)

  GRANT update
  ON departments
  TO scott
  WITH GRANT OPTION;

--h)

  --i)

    GRANT select
    ON regions
    TO msplima
    WITH GRANT OPTION;

  --ii) Feito pelo usu�rio msplima.

    SELECT *
    FROM   jsobrals.regions;

  --iii) Feito pelo usu�rio msplima.

    GRANT select
    ON jsobrals.regions
    TO aferreiras;

  --iv)

    REVOKE select
    ON regions
    FROM msplima;

--i)

  GRANT select, insert, update, delete
  ON countries
  TO msplima;

--j)

  REVOKE select, insert, update, delete
  ON countries
  TO msplima;

--k)

  GRANT select
  ON departments
  TO msplima;

  GRANT select
  ON departments
  TO jsobrals;

--l)

  SELECT *
  FROM   departments;

--m)

  GRANT select
  ON departments
  TO msplima;
  
  GRANT select
  ON departments
  TO jsobrals;

  INSERT INTO departments
    (department_id,
     department_name)
  VALUES
    (500,
     'Education');

  INSERT INTO msplima.departments
    (department_id,
     department_name)
  VALUES
    (510,
     'Human Resources');
     
  COMMIT;

  SELECT *
  FROM msplima.departments;
 
--n)

  CREATE SYNONYM dept
  FOR msplima.departments;

--p)

  SELECT *
  FROM   dept;

--o)

  REVOKE select
  ON departments
  FROM msplima;

--p)

  DELETE FROM departments
  WHERE  department_id = 500;
  
  COMMIT;

--q)

  DROP SYNONYM dept;
  
