/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL1
-- Data: 18/11/2022
-- Tópico: 5
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, b, c, d)

  SET SERVEROUTPUT ON
  DECLARE
    v_max_deptno NUMBER;
  BEGIN
    SELECT MAX(department_id)
    INTO   v_max_deptno
    FROM   departments;
    DBMS_OUTPUT.PUT_LINE('The maximum department_id is : ' || v_max_deptno);
  END;
  /

/*Exercício 2*/

--a, b, c, d, e, f)

  SET SERVEROUTPUT ON
  DECLARE
    v_dept_name departments.department_name%TYPE := 'Education';
    v_dept_id NUMBER;
  BEGIN
    SELECT MAX(department_id)
    INTO   v_dept_id
    FROM   departments;
    DBMS_OUTPUT.PUT_LINE('The maximum department_id is : ' || v_dept_id);
    v_dept_id := v_dept_id + 10;
    INSERT INTO departments
    VALUES
      (v_dept_id,
       v_dept_name,
       NULL,
       NULL);
    DBMS_OUTPUT.PUT_LINE(' SQL%ROWCOUNT gives ' || SQL%ROWCOUNT);
  END;
  /

  SELECT *
  FROM   departments
  WHERE  department_id = (SELECT MAX(department_id)
                          FROM   departments);

/*Exercício 3*/

--a, b, c, d)

  BEGIN
    UPDATE departments
    SET    location_id = 3000
    WHERE  department_id = 290;
  END;
  /

  SELECT *
  FROM   departments
  WHERE  department_id = 290;

  DELETE FROM departments
  WHERE  department_id = 290;
