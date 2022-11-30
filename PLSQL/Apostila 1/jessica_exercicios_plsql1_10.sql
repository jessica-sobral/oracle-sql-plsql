/*
******************************Exerc�cios Treinamento************************
-- Nome: J�ssica Sobral Silva
-- M�dulo: PLSQL1
-- Data: 29/11/2022
-- T�pico: 10
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exerc�cio 1*/

  SET SERVEROUTPUT ON
  DECLARE
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello World ');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || V_tomorrow);
  END;
  /

--a, b, c, d)

  CREATE PROCEDURE greet IS
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello World ');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || V_tomorrow);
  END;

--e)

  SET SERVEROUTPUT ON
  BEGIN
    greet;
  END;
  /

/*Exerc�cio 2*/

--a)

  DROP PROCEDURE greet;

--b, c, d, r)

  CREATE PROCEDURE greet(p_name VARCHAR2) IS
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello ' || p_name);
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || V_tomorrow);
  END;

--f)

  SET SERVEROUTPUT ON
  BEGIN
    greet('Nancy');
  END;
  /
