/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 08/12/2022
-- Tópico: 3
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE OR REPLACE PACKAGE job_pkg IS
    PROCEDURE add_job(p_jobno jobs.job_id%TYPE, p_title jobs.job_title%TYPE);
    PROCEDURE upd_job(p_jobno jobs.job_id%TYPE, p_title jobs.job_title%TYPE);
    PROCEDURE del_job(p_jobno jobs.job_id%TYPE);
    FUNCTION  get_job(p_jobno jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
  END job_pkg;

--b)

  CREATE OR REPLACE PACKAGE BODY job_pkg IS
    PROCEDURE add_job(p_jobno jobs.job_id%TYPE,
                      p_title jobs.job_title%TYPE) AS
    BEGIN
      INSERT INTO jobs
      VALUES
        (p_jobno,
         p_title,
         NULL,
         NULL);
    END add_job;
    
    PROCEDURE upd_job(p_jobno jobs.job_id%TYPE,
                      p_title jobs.job_title%TYPE) AS
    BEGIN
      UPDATE jobs
      SET    job_title = p_title
      WHERE  job_id = p_jobno;
      IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'No job updated.');
      END IF;
    END upd_job;
    
    PROCEDURE del_job(p_jobno jobs.job_id%TYPE) IS
    BEGIN
      DELETE FROM jobs
      WHERE  job_id = p_jobno;
      IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20203, 'No jobs deleted.');
      END IF;
    END del_job;
    
    FUNCTION get_job(p_jobno jobs.job_id%TYPE) RETURN jobs.job_title%TYPE IS
      v_title jobs.job_title%TYPE;
    BEGIN
      SELECT job_title
      INTO   v_title
      FROM   jobs
      WHERE  job_id = p_jobno;
      RETURN v_title;
    END get_job;
  END job_pkg;

--c)

  --i)

    DROP PROCEDURE add_job;

    DROP PROCEDURE upd_job;

    DROP PROCEDURE del_job;

  --ii)

    DROP FUNCTION get_job;

--d)

  EXECUTE job_pkg.add_job('IT_SYSAN', 'Systems Analyst');

--e)

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_SYSAN';

/*Exercício 2*/

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
    PROCEDURE get_employee(p_empno IN employees.employee_id%TYPE,
                           p_sal   OUT employees.salary%TYPE,
                           p_jobno OUT employees.job_id%TYPE);
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
  END emp_pkg;

--b)

  EXECUTE emp_pkg.add_employee(p_fname => 'Jane', p_lname => 'Harris', p_email => 'JAHARRIS', p_deptid => 15);

--c)

  BEGIN
    emp_pkg.add_employee(p_fname  => 'David',
                         p_lname  => 'Smith',
                         p_email  => 'DASMITH',
                         p_deptid => 80);
  END;

--d)

  SELECT *
  FROM   employees
  WHERE  first_name = 'David'
  AND    last_name = 'Smith';
