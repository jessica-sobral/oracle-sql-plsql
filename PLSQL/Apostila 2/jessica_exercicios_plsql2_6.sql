/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 14/12/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE OR REPLACE PACKAGE table_pkg AUTHID CURRENT_USER IS
    PROCEDURE make(p_table_name VARCHAR2,
                   p_col_specs  VARCHAR2);
    PROCEDURE add_row(p_table_name VARCHAR2,
                      p_col_values VARCHAR2,
                      p_cols       VARCHAR2 := NULL);
    PROCEDURE upd_row(p_table_name VARCHAR2,
                      p_set_values VARCHAR2,
                      p_conditions VARCHAR2 := NULL);
    PROCEDURE del_row(p_table_name VARCHAR2,
                      p_conditions VARCHAR2 := NULL);
    PROCEDURE remove(p_table_name VARCHAR2);
  END table_pkg;

--b)

  CREATE OR REPLACE PACKAGE BODY table_pkg IS
    PROCEDURE make(p_table_name VARCHAR2,
                   p_col_specs  VARCHAR2) AS
    BEGIN
      EXECUTE IMMEDIATE 'CREATE TABLE ' || p_table_name || ' (' ||
                        p_col_specs || ')';
    END make;
  
    PROCEDURE add_row(p_table_name VARCHAR2,
                      p_col_values VARCHAR2,
                      p_cols       VARCHAR2 := NULL) AS
    BEGIN
      IF p_cols IS NOT NULL THEN
        EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || '(' || p_cols ||
                          ') VALUES (' || p_col_values || ') ';
      ELSE
        EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || ' VALUES (' ||
                          p_col_values || ') ';
      END IF;
    END add_row;
  
    PROCEDURE upd_row(p_table_name VARCHAR2,
                      p_set_values VARCHAR2,
                      p_conditions VARCHAR2 := NULL) AS
    BEGIN
      IF p_conditions IS NOT NULL THEN
        EXECUTE IMMEDIATE 'UPDATE ' || p_table_name || ' SET ' ||
                          p_set_values || ' WHERE ' || p_conditions;
      ELSE
        EXECUTE IMMEDIATE 'UPDATE ' || p_table_name || ' SET ' ||
                          p_set_values;
      END IF;
    END upd_row;
  
    PROCEDURE del_row(p_table_name VARCHAR2,
                      p_conditions VARCHAR2 := NULL) AS
    BEGIN
      IF p_conditions IS NOT NULL THEN
        EXECUTE IMMEDIATE 'DELETE FROM ' || p_table_name || ' WHERE ' ||
                          p_conditions;
      ELSE
        EXECUTE IMMEDIATE 'DELETE FROM ' || p_table_name;
      END IF;
    END del_row;
  
    PROCEDURE remove(p_table_name VARCHAR2) AS
      v_cur_id   INTEGER;
    BEGIN
      v_cur_id := DBMS_SQL.OPEN_CURSOR;
      DBMS_SQL.PARSE(v_cur_id,
                     'DROP TABLE ' || p_table_name,
                     DBMS_SQL.NATIVE);
      DBMS_SQL.CLOSE_CURSOR(v_cur_id);
    END remove;
  END table_pkg;

--c)

  EXECUTE table_pkg.make('my_contacts', 'id NUMBER(4), name VARCHAR2(40)');

--d)

  DESC my_contacts;

--e)

  BEGIN
    table_pkg.add_row('my_contacts', '1,''Lauran Serhal''', 'id, name');
    table_pkg.add_row('my_contacts', '2,''Nancy''', 'id, name');
    table_pkg.add_row('my_contacts', '3,''Sunitha Patel''', 'id,name');
    table_pkg.add_row('my_contacts', '4,''Valli Pataballa''', 'id,name');
  END;

--f)

  SELECT *
  FROM   my_contacts;

--g)

  EXECUTE table_pkg.del_row('my_contacts', 'id = 3');

--h)

  EXECUTE table_pkg.upd_row('my_contacts','name = ''Nancy Greenberg''','id = 2');

--i)

  SELECT *
  FROM   my_contacts;

--j)

  EXECUTE table_pkg.remove('my_contacts');

  DESC my_contacts;

/*Exercício 2*/

--a)

  CREATE OR REPLACE PACKAGE compile_pkg AUTHID CURRENT_USER IS
    PROCEDURE make(p_name user_objects.object_name%TYPE);
  END compile_pkg;

--b)

  CREATE OR REPLACE PACKAGE BODY compile_pkg IS
    FUNCTION get_type(p_name user_objects.object_name%TYPE)
      RETURN user_objects.object_type%TYPE AS
      v_object_type user_objects.object_type%TYPE;
    BEGIN
      SELECT *
      INTO   v_object_type
      FROM   (SELECT object_type
              FROM   user_objects
              WHERE  object_name = UPPER(p_name)
              ORDER  BY object_type)
      WHERE  rownum = 1;
      RETURN v_object_type;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202,
                                'Object does not exists in user_objects dictionary.');
    END get_type;
  
    PROCEDURE make(p_name user_objects.object_name%TYPE) AS
      v_type user_objects.object_type%TYPE := get_type(p_name);
    BEGIN
      EXECUTE IMMEDIATE 'ALTER ' || v_type || ' ' || p_name || ' COMPILE';
    END make;
  END compile_pkg;

--c)

  EXECUTE compile_pkg.make('employee_report');

  EXECUTE compile_pkg.make('emp_pkg');

  EXECUTE compile_pkg.make('emp_data');
