/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 05/12/2022
-- Tópico: 2
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE OR REPLACE FUNCTION get_job(p_id jobs.job_id%TYPE)
    RETURN jobs.job_title%TYPE IS
    v_title jobs.job_title%TYPE;
  BEGIN
    SELECT job_title
    INTO   v_title
    FROM   jobs
    WHERE  job_id = p_id;
    RETURN v_title;
  END get_job;

--b)

  VARIABLE b_title VARCHAR2(35);
  EXECUTE :b_title := get_job('SA_REP');

/*Exercício 2*/

--a)

  CREATE OR REPLACE FUNCTION get_annual_comp(p_mon_sal employees.salary%TYPE,
                                             p_comm    employees.commission_pct%TYPE)
    RETURN NUMBER IS
    v_ann_sal employees.salary%TYPE;
  BEGIN
    v_ann_sal := (NVL(p_mon_sal, 0) * 12) +
                 (NVL(p_comm, 0) * NVL(p_mon_sal, 0) * 12);
    RETURN v_ann_sal;
  END;

--b)

  SELECT employee_id,
         last_name,
         get_annual_comp(salary, commission_pct) "Annual Compensation"
  FROM   employees
  WHERE  department_id = 30;

/*Exercício 3*/

--a)

  CREATE OR REPLACE FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
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

--b)

  CREATE OR REPLACE PROCEDURE add_employee(p_fname  employees.first_name%TYPE,
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
  END;

--c)

  BEGIN
    add_employee(p_fname  => 'Jane',
                 p_lname  => 'Harris',
                 p_email  => 'JAHARRIS',
                 p_deptid => 15);
  END;

-- O erro tratado é lavantado, pois não existe um departamento com department_id 15.

--d)

  BEGIN
    add_employee(p_fname  => 'Joe',
                 p_lname  => 'Harris',
                 p_email  => 'JOHARRIS',
                 p_deptid => 80);
  END;

-- A inserção é executada com sucesso, pois o departamento com department_id 80 existe.
