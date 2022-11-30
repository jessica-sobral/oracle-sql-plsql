/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 20/10/2022
-- Tópico: 2
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT table_name
  FROM   user_tables;

--b)

  SELECT table_name,
         owner
  FROM   all_tables
  WHERE  owner <> 'JSOBRALS';

--c)

  SELECT column_name,
         data_type,
         data_length,
         data_precision PRECISION,
         data_scale     scale,
         nullable
  FROM   user_tab_columns
  WHERE  table_name = UPPER('&tab_name');

--d)

  SELECT col.column_name,
         col.constraint_name,
         con.constraint_type,
         con.search_condition,
         con.status
  FROM   user_constraints  con,
         user_cons_columns col
  WHERE  con.constraint_name = col.constraint_name
  AND    con.table_name = UPPER('&tab_name');

--e)

  COMMENT ON TABLE departments
  IS 'Company department information including name, code, and location.';

  SELECT table_name,
         comments
  FROM   user_tab_comments
  WHERE  table_name = 'DEPARTMENTS';

--f) não há script. foi utilizado a tabela employees e departments para os próximos exercícios.

--g)
  
  SELECT table_name
  FROM   user_tables
  WHERE  table_name IN ('EMPLOYEES', 'DEPARTMENTS');

--h)

  SELECT constraint_name,
         constraint_type
  FROM   user_constraints
  WHERE  table_name IN ('EMPLOYEES', 'DEPARTMENTS');

--i)

  SELECT object_name,
         object_type
  FROM   user_objects
  WHERE  object_name IN ('EMPLOYEES', 'DEPARTMENTS');
