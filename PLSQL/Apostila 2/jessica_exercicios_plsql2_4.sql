/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 09/12/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, b)

  CREATE OR REPLACE PACKAGE emp_pkg IS
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
  END emp_pkg;

--c)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
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
    END get_employee;
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
      v_deptid departments.department_id%TYPE;
    BEGIN
      SELECT department_id
      INTO   v_deptid
      FROM   departments
      WHERE  department_id = p_deptid;
      RETURN TRUE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
  
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
  END emp_pkg;

--d)

  EXECUTE emp_pkg.add_employee('Samuel', 'Joplin', 30);

--e)

  SELECT *
  FROM   employees
  WHERE  first_name = 'Samuel'
  AND    last_name = 'Joplin';

/*Exercício 2*/

--a, b)

  CREATE OR REPLACE PACKAGE emp_pkg IS
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
  END emp_pkg;

--c, d)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
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
    END get_employee;
    
    FUNCTION get_employee(p_family_name employees.last_name%TYPE)
      RETURN employees%ROWTYPE AS
      v_emp employees%ROWTYPE;
    BEGIN
      SELECT *
      INTO   v_emp
      FROM   employees
      WHERE  last_name = p_family_name;
      RETURN v_emp;
    END get_employee;
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
      v_deptid departments.department_id%TYPE;
    BEGIN
      SELECT department_id
      INTO   v_deptid
      FROM   departments
      WHERE  department_id = p_deptid;
      RETURN TRUE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
  
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
  END emp_pkg;

--e, f)

  CREATE OR REPLACE PACKAGE emp_pkg IS
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
    PROCEDURE print_employee(p_emp employees%ROWTYPE);
  END emp_pkg;
  
  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
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
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
      v_deptid departments.department_id%TYPE;
    BEGIN
      SELECT department_id
      INTO   v_deptid
      FROM   departments
      WHERE  department_id = p_deptid;
      RETURN TRUE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
  
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
  
    PROCEDURE print_employee(p_emp employees%ROWTYPE) AS
    BEGIN
      DBMS_OUTPUT.PUT_LINE(' ');
      DBMS_OUTPUT.PUT_LINE(p_emp.department_id || ', ' ||
                           p_emp.employee_id || ', ' || p_emp.first_name || ' ' ||
                           p_emp.last_name || ', ' || p_emp.job_id || ', ' ||
                           p_emp.salary);
    END print_employee;
  END emp_pkg;

--g)

  SET SERVEROUTPUT ON
  DECLARE
    v_emp1 employees%ROWTYPE;
    v_emp2 employees%ROWTYPE;
  BEGIN
    v_emp1 := emp_pkg.get_employee(100);
    v_emp2 := emp_pkg.get_employee('Joplin');
    
    emp_pkg.print_employee(v_emp1);
    emp_pkg.print_employee(v_emp2);
  END;
  /

/*Exercício 3*/

--a, b)

  CREATE OR REPLACE PACKAGE emp_pkg IS
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
    PROCEDURE init_departments;
    PROCEDURE print_employee(p_emp employees%ROWTYPE);
  END emp_pkg;

--b, c, d)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
  
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
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
      v_deptid departments.department_id%TYPE;
    BEGIN
      SELECT department_id
      INTO   v_deptid
      FROM   departments
      WHERE  department_id = p_deptid;
      RETURN TRUE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
  
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
    
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

/*Exercício 4*/

--a)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
  
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
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
    BEGIN
      IF valid_departments(p_deptid) THEN
        RETURN TRUE;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
  
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
    
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

--b)

  EXECUTE emp_pkg.add_employee('James', 'Bond', 15);
  
-- O erro tratado é lavantado, pois não existe um departamento com department_id 15.

--c)

  INSERT INTO departments
    (department_id,
     department_name)
  VALUES
    (15,
     'Security');
     
  COMMIT;

  SELECT *
  FROM   departments
  WHERE  department_id = 15;

--d)

  EXECUTE emp_pkg.add_employee('James', 'Bond', 15);

/* O erro tratado é lavantado, pois não existe um departamento com department_id 15 na tabela de departamentos
   válidos.
*/

--e, f)

  EXECUTE emp_pkg.add_employee('James', 'Bond', 15);

/* A inserção é executada com sucesso, pois o departamento com department_id 15 existe na tabela de departamentos
   válidos.
*/

--g)

  DELETE FROM employees
  WHERE  first_name = 'James'
  AND    last_name = 'Bond';

  DELETE FROM departments
  WHERE  department_id = 15;
  
  COMMIT;

  EXECUTE emp_pkg.init_departments;

/*Exercício 5*/

--a)

  CREATE OR REPLACE PACKAGE emp_pkg IS
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
    PROCEDURE init_departments;
    PROCEDURE print_employee(p_emp employees%ROWTYPE);
  END emp_pkg;

-- Não acontece nada, pois os subprogramas já estavam em ordem alfabética.

--b)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
  
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
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
    BEGIN
      IF valid_departments(p_deptid) THEN
        RETURN TRUE;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
  
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

/* O package passa não compilar corretamente; apresenta erros, pois a function valid_deptid é usado na procedure
   add_employee antes de ser implementado, por exemplo.
*/

--c)

  CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN;
    TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
  
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
  
    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
    BEGIN
      IF valid_departments(p_deptid) THEN
        RETURN TRUE;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
    END valid_deptid;
    
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

-- O package é compilado corretamente; sem nenhum erro.
