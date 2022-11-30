/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 28/10/2022
-- Tópico: 9
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE TABLE sal_history (
    employee_id NUMBER(6),
    hire_date DATE,
    salary NUMBER(8,2)
  );

--b)

  DESC sal_history;

--c)

  CREATE TABLE mgr_history (
    employee_id NUMBER(6),
    manager_id NUMBER(6),
    salary NUMBER(8,2)
  );

--d)

  DESC mgr_history;

--e)

  CREATE TABLE special_sal (
    employee_id NUMBER(6),
    salary NUMBER(8,2)
  );

--f)

  DESC special_sal;

--g)

  --i)

    INSERT ALL
      WHEN salary > 20000 THEN
        INTO special_sal VALUES(employee_id, salary)
      WHEN salary < 20000 THEN
        INTO sal_history VALUES(employee_id, hire_date, salary)
        INTO mgr_history VALUES(employee_id, manager_id, salary)
      SELECT employee_id,
             hire_date,
             salary,
             manager_id
      FROM   employees
      WHERE  employee_id < 125;

  --ii)

    SELECT *
    FROM   special_sal;

  --iii)

    SELECT *
    FROM   sal_history;

  --iv)

    SELECT *
    FROM   mgr_history;

--h)

  --i)

    CREATE TABLE sales_week_data (
      id NUMBER(6),
      week_id NUMBER(2),
      qty_mon NUMBER(8,2),
      qty_tue NUMBER(8,2),
      qty_wed NUMBER(8,2),
      qty_thur NUMBER(8,2),
      qty_fri NUMBER(8,2)
    );

  --ii)

    INSERT INTO sales_week_data
      (id,
       week_id,
       qty_mon,
       qty_tue,
       qty_wed,
       qty_thur,
       qty_fri)
    VALUES
      (200,
       6,
       2050,
       2200,
       1700,
       1200,
       3000);

  --iii)

    DESC sales_week_data;

  --iv)

    SELECT *
    FROM   sales_week_data;

  --v)

    CREATE TABLE emp_sales_info (
      id NUMBER(6),
      week NUMBER(2),
      qty_sales NUMBER(8,2)
    );

  --vi)

    DESC emp_sales_info;

  --vii)

    INSERT ALL
      INTO emp_sales_info VALUES(id, week_id, qty_mon)
      INTO emp_sales_info VALUES(id, week_id, qty_tue)
      INTO emp_sales_info VALUES(id, week_id, qty_wed)
      INTO emp_sales_info VALUES(id, week_id, qty_thur)
      INTO emp_sales_info VALUES(id, week_id, qty_fri)
    SELECT id,
           week_id,
           qty_mon,
           qty_tue,
           qty_wed,
           qty_thur,
           qty_fri
    FROM   sales_week_data;

  --viii)

    SELECT *
    FROM   emp_sales_info;

--k)

  CREATE TABLE emp2 (
    id NUMBER(7),
    last_name VARCHAR2(25),
    first_name VARCHAR2(25),
    dept_id NUMBER(7)
  );

  DESC emp2;

--l)

  DROP TABLE emp2;

--m)

  SELECT original_name,
         operation,
         droptime
  FROM   recyclebin
  WHERE  original_name = 'EMP2';

--n)

  FLASHBACK TABLE emp2
  TO BEFORE DROP;

  SELECT * FROM emp2;

--o)

  CREATE TABLE emp3 AS
  SELECT *
  FROM   employees;

  UPDATE emp3
  SET    department_id = 60
  WHERE  last_name = 'Kochhar';

  COMMIT;

  SELECT employee_id,
         last_name,
         department_id
  FROM   emp3
  WHERE  last_name = 'Kochhar';

  UPDATE emp3
  SET    department_id = 50
  WHERE  last_name = 'Kochhar';

  COMMIT;

  SELECT employee_id,
         last_name,
         department_id
  FROM   emp3
  WHERE  last_name = 'Kochhar';

  SELECT versions_starttime START_DATE,
         versions_endtime   END_DATE,
         department_id
  FROM   employees VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
  WHERE  LAST_NAME = 'Kochhar';

--p)

  DROP TABLE emp2 PURGE;
  
  DROP TABLE emp3 PURGE;

  SELECT original_name,
         operation,
         droptime
  FROM   recyclebin
  WHERE  original_name IN ('EMP2', 'EMP3');

-- Adicionais

  DROP TABLE sal_history;
  
  DROP TABLE mgr_history;
  
  DROP TABLE special_sal;
  
  DROP TABLE sales_week_data;
  
  DROP TABLE emp_sales_info;
