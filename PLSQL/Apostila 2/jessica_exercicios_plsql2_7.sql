/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 19/12/2022
-- Tópico: 7
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, c)

  CREATE OR REPLACE PACKAGE emp_pkg IS
    TYPE emp_tab_type IS TABLE OF employees%ROWTYPE;
    PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
                           p_lname  employees.last_name%TYPE,
                           p_email  employees.email%TYPE,
                           p_job    employees.job_id%TYPE DEFAULT 'SA_REP',
                           p_mgr    employees.manager_id%TYPE DEFAULT 145,
                           p_sal    employees.salary%TYPE DEFAULT 1000,
                           p_comm   employees.commission_pct%TYPE DEFAULT 0,
                           p_deptid employees.department_id%TYPE DEFAULT 30);
    PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
                           p_lname  employees.last_name%TYPE,
                           p_deptid employees.department_id%TYPE DEFAULT 30);
    PROCEDURE get_employee(p_empno IN employees.employee_id%TYPE,
                           p_sal   OUT employees.salary%TYPE,
                           p_jobno OUT employees.job_id%TYPE);
    FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
      RETURN employees%ROWTYPE;
    FUNCTION get_employee(p_family_name employees.last_name%TYPE)
      RETURN employees%ROWTYPE;
    PROCEDURE get_employees(p_dept_id employees.department_id%TYPE);
    PROCEDURE show_employees;
    PROCEDURE init_departments;
    PROCEDURE print_employee(p_emp employees%ROWTYPE);
  END emp_pkg;

--b, c)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN;
  
    TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
    v_emp_table       emp_tab_type;
  
    PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
                           p_lname  employees.last_name%TYPE,
                           p_email  employees.email%TYPE,
                           p_job    employees.job_id%TYPE DEFAULT 'SA_REP',
                           p_mgr    employees.manager_id%TYPE DEFAULT 145,
                           p_sal    employees.salary%TYPE DEFAULT 1000,
                           p_comm   employees.commission_pct%TYPE DEFAULT 0,
                           p_deptid employees.department_id%TYPE DEFAULT 30) AS
    BEGIN
      IF NOT valid_deptid(p_deptid) THEN
        RAISE_APPLICATION_ERROR(-20202, 'Department does not exists.');
      ELSE
        INSERT INTO employees
          (employee_id,
           first_name,
           last_name,
           email,
           hire_date,
           job_id,
           manager_id,
           salary,
           commission_pct,
           department_id)
        VALUES
          (employees_seq.NEXTVAL,
           p_fname,
           p_lname,
           p_email,
           TRUNC(SYSDATE),
           p_job,
           p_mgr,
           p_sal,
           p_comm,
           p_deptid);
      END IF;
    END add_employee;
  
    PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
                           p_lname  employees.last_name%TYPE,
                           p_deptid employees.department_id%TYPE DEFAULT 30) AS
    BEGIN
      add_employee(p_fname  => p_fname,
                   p_lname  => p_lname,
                   p_email  => UPPER(SUBSTR(p_fname, 1, 1) ||
                                     SUBSTR(p_lname, 1, 7)),
                   p_deptid => p_deptid);
    END add_employee;
  
    PROCEDURE get_employee(p_empno IN employees.employee_id%TYPE,
                           p_sal   OUT employees.salary%TYPE,
                           p_jobno OUT employees.job_id%TYPE) AS
    BEGIN
      SELECT salary,
             job_id
      INTO   p_sal,
             p_jobno
      FROM   employees
      WHERE  employee_id = p_empno;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'Employee does not exists.');
    END get_employee;
  
    FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
      RETURN employees%ROWTYPE AS
      v_emp employees%ROWTYPE;
    BEGIN
      SELECT *
      INTO   v_emp
      FROM   employees
      WHERE  employee_id = p_emp_id;
      RETURN v_emp;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'Employee does not exists.');
    END get_employee;
  
    FUNCTION get_employee(p_family_name employees.last_name%TYPE)
      RETURN employees%ROWTYPE AS
      v_emp employees%ROWTYPE;
    BEGIN
      SELECT *
      INTO   v_emp
      FROM   employees
      WHERE  UPPER(last_name) = UPPER(p_family_name);
      RETURN v_emp;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'Employee does not exists.');
    END get_employee;
  
    PROCEDURE get_employees(p_dept_id employees.department_id%TYPE) AS
    BEGIN
      SELECT *
      BULK   COLLECT
      INTO   v_emp_table
      FROM   employees
      WHERE  department_id = p_dept_id;
    END get_employees;
  
    PROCEDURE init_departments AS
    BEGIN
      FOR rec IN (SELECT department_id
                  FROM   departments)
      LOOP
        valid_departments(rec.department_id) := TRUE;
      END LOOP;
    END init_departments;
  
    PROCEDURE print_employee(p_emp employees%ROWTYPE) AS
    BEGIN
      DBMS_OUTPUT.PUT_LINE(' ');
      DBMS_OUTPUT.PUT_LINE(p_emp.department_id || ', ' ||
                           p_emp.employee_id || ', ' || p_emp.first_name || ' ' ||
                           p_emp.last_name || ', ' || p_emp.job_id || ', ' ||
                           p_emp.salary);
    END print_employee;
  
    PROCEDURE show_employees AS
    BEGIN
      FOR i IN 1 .. v_emp_table.COUNT
      LOOP
        print_employee(v_emp_table(i));
      END LOOP;
    END show_employees;
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
    BEGIN
      RETURN valid_departments.exists(p_deptid);
    END valid_deptid;
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

--d)

  SET SERVEROUTPUT ON
  BEGIN
    emp_pkg.get_employees(30);
    emp_pkg.show_employees;
  END;
  /

  SET SERVEROUTPUT ON
  BEGIN
    emp_pkg.get_employees(60);
    emp_pkg.show_employees;
  END;
  /

/*Exercício 2*/

--a)

  CREATE TABLE log_newemp (
    entry_id NUMBER(6) CONSTRAINT log_newemp_pk PRIMARY KEY, 
    user_id VARCHAR2(30), 
    log_time DATE, 
    name VARCHAR2(60) 
  ); 

  CREATE SEQUENCE log_newemp_seq;
  
--b, c)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN;
  
    TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
    v_emp_table       emp_tab_type;
  
    PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
                           p_lname  employees.last_name%TYPE,
                           p_email  employees.email%TYPE,
                           p_job    employees.job_id%TYPE DEFAULT 'SA_REP',
                           p_mgr    employees.manager_id%TYPE DEFAULT 145,
                           p_sal    employees.salary%TYPE DEFAULT 1000,
                           p_comm   employees.commission_pct%TYPE DEFAULT 0,
                           p_deptid employees.department_id%TYPE DEFAULT 30) AS
      PROCEDURE audit_newemp(p_name VARCHAR2) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN
        INSERT INTO log_newemp
        VALUES
          (log_newemp_seq.NEXTVAL,
           USER,
           SYSDATE,
           p_name);
        COMMIT;
      END audit_newemp;
    BEGIN
      audit_newemp(p_fname || ' ' || p_lname);
      IF NOT valid_deptid(p_deptid) THEN
        RAISE_APPLICATION_ERROR(-20202, 'Department does not exists.');
      ELSE
        INSERT INTO employees
          (employee_id,
           first_name,
           last_name,
           email,
           hire_date,
           job_id,
           manager_id,
           salary,
           commission_pct,
           department_id)
        VALUES
          (employees_seq.NEXTVAL,
           p_fname,
           p_lname,
           p_email,
           TRUNC(SYSDATE),
           p_job,
           p_mgr,
           p_sal,
           p_comm,
           p_deptid);
      END IF;
    END add_employee;
  
    PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
                           p_lname  employees.last_name%TYPE,
                           p_deptid employees.department_id%TYPE DEFAULT 30) AS
    BEGIN
      add_employee(p_fname  => p_fname,
                   p_lname  => p_lname,
                   p_email  => UPPER(SUBSTR(p_fname, 1, 1) ||
                                     SUBSTR(p_lname, 1, 7)),
                   p_deptid => p_deptid);
    END add_employee;
  
    PROCEDURE get_employee(p_empno IN employees.employee_id%TYPE,
                           p_sal   OUT employees.salary%TYPE,
                           p_jobno OUT employees.job_id%TYPE) AS
    BEGIN
      SELECT salary,
             job_id
      INTO   p_sal,
             p_jobno
      FROM   employees
      WHERE  employee_id = p_empno;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'Employee does not exists.');
    END get_employee;
  
    FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
      RETURN employees%ROWTYPE AS
      v_emp employees%ROWTYPE;
    BEGIN
      SELECT *
      INTO   v_emp
      FROM   employees
      WHERE  employee_id = p_emp_id;
      RETURN v_emp;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'Employee does not exists.');
    END get_employee;
  
    FUNCTION get_employee(p_family_name employees.last_name%TYPE)
      RETURN employees%ROWTYPE AS
      v_emp employees%ROWTYPE;
    BEGIN
      SELECT *
      INTO   v_emp
      FROM   employees
      WHERE  UPPER(last_name) = UPPER(p_family_name);
      RETURN v_emp;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'Employee does not exists.');
    END get_employee;
  
    PROCEDURE get_employees(p_dept_id employees.department_id%TYPE) AS
    BEGIN
      SELECT *
      BULK   COLLECT
      INTO   v_emp_table
      FROM   employees
      WHERE  department_id = p_dept_id;
    END get_employees;
  
    PROCEDURE init_departments AS
    BEGIN
      FOR rec IN (SELECT department_id
                  FROM   departments)
      LOOP
        valid_departments(rec.department_id) := TRUE;
      END LOOP;
    END init_departments;
  
    PROCEDURE print_employee(p_emp employees%ROWTYPE) AS
    BEGIN
      DBMS_OUTPUT.PUT_LINE(' ');
      DBMS_OUTPUT.PUT_LINE(p_emp.department_id || ', ' ||
                           p_emp.employee_id || ', ' || p_emp.first_name || ' ' ||
                           p_emp.last_name || ', ' || p_emp.job_id || ', ' ||
                           p_emp.salary);
    END print_employee;
  
    PROCEDURE show_employees AS
    BEGIN
      FOR i IN 1 .. v_emp_table.COUNT
      LOOP
        print_employee(v_emp_table(i));
      END LOOP;
    END show_employees;
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
    BEGIN
      RETURN valid_departments.exists(p_deptid);
    END valid_deptid;
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

--d)

  EXECUTE emp_pkg.add_employee('Max', 'Smart', 20);

  EXECUTE emp_pkg.add_employee('Clark', 'Kent', 10);

-- Os dois funcionários são inseridos na tabela employees com sucesso.

--e)

  SELECT *
  FROM   employees
  WHERE  first_name IN ('Max', 'Clark')
  AND    last_name IN ('Smart', 'Kent');

  SELECT *
  FROM   log_newemp;

-- Estão presentes 2 registros de log - um para cada funcionário adicionado.

--f)

  DELETE FROM employees
  WHERE  first_name IN ('Max', 'Clark')
  AND    last_name IN ('Smart', 'Kent');

  COMMIT;

  --i)

    SELECT *
    FROM   employees
    WHERE  first_name IN ('Max', 'Clark')
    AND    last_name IN ('Smart', 'Kent');

  --ii)

    SELECT *
    FROM   log_newemp;

/* Ainda estão presentes 2 registros de log. Isso acontece porque a procedure que adiciona os registros de log usa
   uma transação autônoma - com um commit após finalizar a inserção na tabela não é possível dar um ROLLBACK.
*/
