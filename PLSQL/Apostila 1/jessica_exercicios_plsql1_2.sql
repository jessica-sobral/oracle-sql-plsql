/*
******************************Exerc�cios Treinamento************************
-- Nome: J�ssica Sobral Silva
-- M�dulo: PLSQL1
-- Data: 08/11/2022
-- T�pico: 2
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exerc�cio 1*/

  -- d.

  DECLARE
    v_amount INTEGER(10);
  BEGIN
    DBMS_OUTPUT.PUT_LINE(v_amount);
  END;

/*Exerc�cio 2*/

  DECLARE
    v_hello VARCHAR2(12);
  BEGIN
    SELECT 'Hello World.'
    INTO   v_hello
    FROM   dual;
    DBMS_OUTPUT.PUT_LINE(v_hello);
  END;
  
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World.');
  END;
