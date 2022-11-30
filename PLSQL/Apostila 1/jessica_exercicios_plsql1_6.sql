/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL1
-- Data: 21/11/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

  CREATE TABLE messages (
    results VARCHAR2(255)
  );

--a, b)

  DECLARE
    v_number NUMBER := 0;
  BEGIN
    FOR i IN 1 .. 10
    LOOP
      v_number := v_number + 1;
      CONTINUE WHEN v_number IN(6, 8);
      INSERT INTO messages
      VALUES
        (TO_CHAR(v_number));
    END LOOP;
    COMMIT;
  END;
  /
  
  BEGIN
    FOR i IN 1 .. 10
    LOOP
      CONTINUE WHEN i IN(6, 8);
      INSERT INTO messages
      VALUES
        (TO_CHAR(i));
    END LOOP;
    COMMIT;
  END;
  /

--c)

  SELECT results
  FROM   messages;

/*Exercício 2*/

  CREATE TABLE emp AS
    SELECT *
    FROM employees;

  ALTER TABLE emp
  ADD (stars VARCHAR2(50));

--a, b, c)

  DECLARE
    v_empno    emp.employee_id%TYPE := 176;
    v_asterisk emp.stars%TYPE := NULL;
    v_sal      emp.salary%TYPE;
  BEGIN
    SELECT NVL(salary, 0)
    INTO   v_sal
    FROM   emp
    WHERE  employee_id = v_empno;
    FOR i IN 1 .. (v_sal / 1000)
    LOOP
      v_asterisk := (v_asterisk || '*');
    END LOOP;
    UPDATE emp
    SET    stars = v_asterisk
    WHERE  employee_id = v_empno;
    COMMIT;
  END;

--d, e)

  SELECT employee_id,
         salary,
         stars
  FROM   emp
  WHERE  employee_id = 176;
