/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 27/10/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a) CREATE SESSION. Se trata de um privilégio de sistema.

--b) CREATE TABLE.

--c) Apenas os usuários que eu conceder acesso à essa tabela junto com a cláusula WITH GRANT OPTION.

--d) Criar funções/papeis através do comando CREATE ROLE.

--e) ALTER USER.

  ALTER USER jsobrals
  IDENTIFIED BY password;

--f) Apenas o proprietário da tabela EMP.

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

  --ii) Feito pelo usuário msplima.

    SELECT *
    FROM   jsobrals.regions;

  --iii) Feito pelo usuário msplima.

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
  
