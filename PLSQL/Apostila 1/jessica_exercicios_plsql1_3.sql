/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL1
-- Data: 09/11/2022
-- Tópico: 3
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

-- VALID: a, b, e, g, h
-- INVALID: c, d, f

/*Exercício 2*/

-- VALID: a, d
-- INVALID: b, c

/*Exercício 3*/

-- a

/*Exercício 4*/

--a, b, c, d)

  DECLARE
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello World');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
  END;

/*Exercício 5*/

--a, b, c, d)

  VARIABLE b_basic_percent NUMBER
  VARIABLE b_pf_percent NUMBER
  DECLARE
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello World');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
    :b_basic_percent := 45;
    :b_pf_percent := 12;
  END;
  /
  PRINT
