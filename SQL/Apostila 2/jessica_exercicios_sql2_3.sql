/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 20/10/2022
-- Tópico: 3
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE TABLE dept (
    id NUMBER(7) CONSTRAINT dep_id_pk PRIMARY KEY,
    name VARCHAR2(25)
  );

  SELECT table_name
  FROM   tabs
  WHERE  table_name = 'DEPT';

--b)

  CREATE SEQUENCE dept_id_seq
         INCREMENT BY 10
         START WITH 200
         MAXVALUE 1000
         NOCACHE
         NOCYCLE;

--c)

  INSERT INTO dept
  VALUES
    (dept_id_seq.NEXTVAL,
     'Education');

  INSERT INTO dept
  VALUES
    (dept_id_seq.NEXTVAL,
     'Administration');

  SELECT *
  FROM   dept;

--d)

  SELECT sequence_name,
         max_value,
         increment_by,
         last_number
  FROM   user_sequences;

--e)

  CREATE SYNONYM emp1
  FOR employees;

  SELECT synonym_name,
         table_owner,
         table_name,
         db_link
  FROM   user_synonyms;

--f)

  DROP SYNONYM emp1;

--g)

  CREATE INDEX dept_name_idx
  ON dept(name);

--h)

  CREATE TABLE sales_dept (
    team_id NUMBER(3) PRIMARY KEY USING INDEX
               (CREATE INDEX sales_pk_idx ON
                sales_dept(team_id)),
    location VARCHAR2(30)
  );

  SELECT index_name,
         table_name,
         uniqueness
  FROM   user_indexes
  WHERE  index_name = 'SALES_PK_IDX';

--i)

  DROP SEQUENCE dept_id_seq;

  DROP TABLE dept;

  DROP TABLE sales_dept;
