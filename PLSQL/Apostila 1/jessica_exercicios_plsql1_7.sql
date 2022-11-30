/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL1
-- Data: 22/11/2022
-- Tópico: 7
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, b, c, d, e)

  SET SERVEROUTPUT ON
  DECLARE
    v_country_record countries%ROWTYPE;
    v_countryid countries.country_id%TYPE := 'CA'; -- CA, DE, UK, US
  BEGIN
    SELECT *
    INTO v_country_record
    FROM countries
    WHERE country_id = v_countryid;
    DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id || ' Country Name: ' ||
                         v_country_record.country_name || ' Region: ' || v_country_record.region_id);
  END;
  /

/*Exercício 2*/

--a, b, c, d, e)

  SET SERVEROUTPUT ON
  DECLARE
    TYPE dept_table_type IS TABLE OF departments.department_name%TYPE INDEX BY PLS_INTEGER;
    my_dept_table dept_table_type;
    f_loop_count  NUMBER := 10;
    v_deptno      NUMBER := 0;
  BEGIN
    FOR i IN 1 .. f_loop_count
    LOOP
      v_deptno := v_deptno + 10;
      SELECT department_name
      INTO   my_dept_table(i)
      FROM   departments
      WHERE  department_id = v_deptno;
    END LOOP;
    FOR i IN my_dept_table.FIRST .. my_dept_table.LAST
    LOOP
      DBMS_OUTPUT.PUT_LINE(my_dept_table(i));
    END LOOP;
  END;
  /

/*Exercício 3*/

--a, b, c, d)

  SET SERVEROUTPUT ON
  DECLARE
    TYPE dept_table_type IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
    my_dept_table dept_table_type;
    f_loop_count  NUMBER := 10;
    v_deptno      NUMBER := 0;
  BEGIN
    FOR i IN 1 .. f_loop_count
    LOOP
      v_deptno := v_deptno + 10;
      SELECT *
      INTO   my_dept_table(i)
      FROM   departments
      WHERE  department_id = v_deptno;
    END LOOP;
    FOR i IN my_dept_table.FIRST .. my_dept_table.LAST
    LOOP
      DBMS_OUTPUT.PUT_LINE('Department Number: ' ||
                           my_dept_table(i).department_id ||
                           ' Department Name: ' ||
                           my_dept_table(i).department_name ||
                           ' Manager Id: ' || my_dept_table(i).manager_id ||
                           ' Location Id: ' || my_dept_table(i).location_id);
    END LOOP;
  END;
  /
