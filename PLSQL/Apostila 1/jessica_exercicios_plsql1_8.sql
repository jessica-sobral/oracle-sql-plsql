/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL1
-- Data: 23/11/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, b, c, d)

SET SERVEROUTPUT ON
DECLARE
  v_deptno NUMBER := 10; -- ou 10, 20, 50, 80
  CURSOR c_emp_cursor IS
    SELECT last_name, salary, manager_id
    FROM employees
    WHERE department_id = v_deptno;
BEGIN
  FOR emp_record IN c_emp_cursor
  LOOP
    IF emp_record.salary < 5000 AND emp_record.manager_id IN (101, 124) THEN -- ou 10, 20, 50, 80
      DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ' Due for a raise.');
    ELSE
      DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ' Not Due for a raise.');
    END IF;
  END LOOP;
END;
/

/*Exercício 2*/

--a, b, c, d, e)

SET SERVEROUTPUT ON
DECLARE
  CURSOR c_dept_cursor IS
    SELECT department_id,
           department_name
    FROM   departments
    WHERE  department_id < 100
    ORDER  BY department_id;
  CURSOR c_emp_cursor(deptno NUMBER) IS
    SELECT last_name,
           job_id,
           hire_date,
           salary
    FROM   employees
    WHERE  department_id = deptno
    AND    employee_id < 120;
  v_dept_id       departments.department_id%TYPE;
  v_dept_name     departments.department_name%TYPE;
  v_emp_name      employees.last_name%TYPE;
  v_emp_job       employees.job_id%TYPE;
  v_emp_hire_date employees.hire_date%TYPE;
  v_emp_sal       employees.salary%TYPE;
BEGIN
  OPEN c_dept_cursor;
  LOOP
    FETCH c_dept_cursor
      INTO v_dept_id,
           v_dept_name;
    EXIT WHEN c_dept_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Department Number : ' || v_dept_id ||
                         ' Department Name : ' || v_dept_name);
    IF c_emp_cursor%ISOPEN THEN
      CLOSE c_emp_cursor;
    END IF;
    OPEN c_emp_cursor(v_dept_id);
    LOOP
      FETCH c_emp_cursor
        INTO v_emp_name,
             v_emp_job,
             v_emp_hire_date,
             v_emp_sal;
      EXIT WHEN c_emp_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_emp_name || ' ' || v_emp_job || ' ' ||
                           v_emp_hire_date || ' ' || v_emp_sal);
    END LOOP;
    CLOSE c_emp_cursor;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
  END LOOP;
  CLOSE c_dept_cursor;
END;
/
