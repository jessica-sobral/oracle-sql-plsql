/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL1
-- Data: 10/11/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

  DECLARE
    v_weight  NUMBER(3) := 600;
    v_message VARCHAR2(255) := 'Product 10012';
  BEGIN
    DECLARE
      v_weight   NUMBER(3) := 1;
      v_message  VARCHAR2(255) := 'Product 11001';
      v_new_locn VARCHAR2(50) := 'Europe';
    BEGIN
      v_weight   := v_weight + 1;
      v_new_locn := 'Western ' || v_new_locn;
    END;
    v_weight   := v_weight + 1;
    v_message  := v_message || ' is in stock';
    v_new_locn := 'Western ' || v_new_locn;
  END;
  /

/*Exercício 1*/

--a) 2 - NUMBER

--b) 'Western Europe' - VARCHAR2

--c) 601 - NUMBER

--d) 'Product 10012 is in stock' - VARCHAR2

--e) Erro, pois é uma variável local do bloco aninhado (interno, filho).

  DECLARE
    v_customer      VARCHAR2(50) := 'Womansport';
    v_credit_rating VARCHAR2(50) := 'EXCELLENT';
  BEGIN
    DECLARE
      v_customer NUMBER(7) := 201;
      v_name     VARCHAR2(25) := 'Unisports';
    BEGIN
      v_credit_rating := 'GOOD';
      ...
    END;
    ...
  END;

/*Exercício 2*/

--a) 201 - NUMBER

--b) 'Unisports' - VARCHAR2

--c) 'GOOD' - VARCHAR2

--d) 'Womansport' - VARCHAR2

--e) Erro, pois é uma variável local do bloco aninhado (interno, filho).

--f) 'EXCELLENT' - VARCHAR2

/*Exercício 3*/

--a, b, c, d, e, f, g)

  SET SERVEROUTPUT ON
  -- VARIABLE b_basic_percent NUMBER
  -- VARIABLE b_pf_percent NUMBER
  DECLARE
    /* v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE; */
    v_fname   VARCHAR2(15);
    v_emp_sal NUMBER(10);
  BEGIN
    SELECT first_name,
           salary
    INTO   v_fname,
           v_emp_sal
    FROM   employees
    WHERE  employee_id = 110;
    -- v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE('Hello ' || v_fname);
    /* DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
    :b_basic_percent := 45;
    :b_pf_percent := 12; */
    DBMS_OUTPUT.PUT_LINE('YOUR SALARY IS : ' || v_emp_sal);
    -- Não é necessário um bloco aninhado para o cálculo, fiz apenas para praticar o conteúdo do tópico
    DECLARE
      v_pf_sal NUMBER(10, 2);
    BEGIN
      v_pf_sal := (v_emp_sal * 0.45) * 0.12;
      DBMS_OUTPUT.PUT_LINE('YOUR CONTRIBUTION TOWARDS PF : ' || v_pf_sal);
    END;
  END;
  /
  PRINT
