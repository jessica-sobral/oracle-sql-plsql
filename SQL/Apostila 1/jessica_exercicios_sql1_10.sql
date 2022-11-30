/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 14/10/2022
-- Tópico: 10
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE TABLE my_employee (
    id NUMBER(4) PRIMARY KEY, 
    last_name VARCHAR(25), 
    first_name VARCHAR(25), 
    userid VARCHAR(8), 
    salary NUMBER(9,2)
  );
  
--b)

  DESC my_employee;

--c)

  INSERT INTO my_employee
  VALUES
    (1,
     'Patel',
     'Ralph',
     'rpatel',
     895);

--d)

  INSERT INTO my_employee
    (id,
     last_name,
     first_name,
     userid,
     salary)
  VALUES
    (2,
     'Dancs',
     'Betty',
     'bdancs',
     860);

--e)

  SELECT *
  FROM   my_employee;

--f, g)

  INSERT INTO my_employee
    (id,
     last_name,
     first_name,
     userid,
     salary)
  VALUES
    (&id,
     '&last_name',
     '&first_name',
     '&userid',
     &salary);

--h)

  SELECT *
  FROM   my_employee;

--i)

  COMMIT;

--j)

  UPDATE my_employee
  SET    last_name = 'Drexler'
  WHERE  id = 3;

--k)

  UPDATE my_employee
  SET    salary = 1000
  WHERE  salary < 900;

--l)

  SELECT *
  FROM   my_employee;

--m)

  DELETE FROM my_employee
  WHERE  id = 2;

--n)

  SELECT *
  FROM   my_employee;

--o)

  COMMIT;

--p)

  INSERT INTO my_employee
    (id,
     last_name,
     first_name,
     userid,
     salary)
  VALUES
    (&id,
     '&last_name',
     '&first_name',
     '&userid',
     &salary);

--q)

  SELECT *
  FROM   my_employee;

--r)

  SAVEPOINT a;

--s)

  DELETE FROM my_employee;

--t)

  SELECT *
  FROM   my_employee;

--u)

  ROLLBACK TO SAVEPOINT a;

--v)

  SELECT *
  FROM   my_employee;

--w)

  COMMIT;

--x, y)

  INSERT INTO my_employee
    (id,
     last_name,
     first_name,
     userid,
     salary)
  VALUES
    (&id,
     '&last_name',
     '&first_name',
     CONCAT(LOWER(SUBSTR('&first_name', 0, 1)),
            LOWER(SUBSTR('&last_name', 1, 7))),
     &salary);

--z)
  
  SELECT *
  FROM   my_employee
  WHERE  id = 6;
