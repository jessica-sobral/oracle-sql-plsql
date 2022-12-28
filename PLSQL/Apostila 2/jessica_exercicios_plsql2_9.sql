/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 21/12/2022
-- Tópico: 9
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

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
    PROCEDURE set_salary(p_job     jobs.job_id%TYPE,
                         p_min_sal jobs.min_salary%TYPE);
    PROCEDURE init_departments;
    PROCEDURE print_employee(p_emp employees%ROWTYPE);
  END emp_pkg;

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
      DBMS_OUTPUT.PUT_LINE(p_emp.department_id || ', ' || p_emp.employee_id || ', ' ||
                           p_emp.first_name || ' ' || p_emp.last_name || ', ' ||
                           p_emp.job_id || ', ' || p_emp.salary);
    END print_employee;

    PROCEDURE show_employees AS
    BEGIN
      FOR i IN 1 .. v_emp_table.COUNT
      LOOP
        print_employee(v_emp_table(i));
      END LOOP;
    END show_employees;
    
    PROCEDURE set_salary(p_job     jobs.job_id%TYPE,
                         p_min_sal jobs.min_salary%TYPE) AS
    BEGIN
      UPDATE employees
      SET    salary = p_min_sal
      WHERE  job_id = p_job
      AND    salary < p_min_sal;
    END set_salary;

    FUNCTION valid_deptid(p_deptid departments.department_id%TYPE)
      RETURN BOOLEAN IS
    BEGIN
      RETURN valid_departments.exists(p_deptid);
    END valid_deptid;
  BEGIN
    emp_pkg.init_departments;
  END emp_pkg;

--b)

  CREATE OR REPLACE TRIGGER upd_minsalary_trg
    BEFORE UPDATE OF min_salary ON jobs
    FOR EACH ROW
    CALL emp_pkg.set_salary(:NEW.job_id, :NEW.min_salary)

--c)

  SELECT e.employee_id,
         e.last_name,
         e.job_id,
         e.salary,
         j.min_salary
  FROM   employees e,
         jobs      j
  WHERE  e.job_id = j.job_id
  AND    e.job_id = 'IT_PROG';

  UPDATE jobs
  SET    min_salary = min_salary + 1000
  WHERE  job_id = 'IT_PROG';

/* Ao tentar atualizar o salário mínimo do job ID IT_PROG, ele dispara a trigger upd_minsalary_trg que chama a
   procedure set_salary do pacote emp_pkg. Essa procedure, ao tentar atualizar os salários desses funcionários
   que pertencem ao job ID IT_PROG, dispara a trigger check_salary que faz uma consulta na tabela jobs. Por isso,
   ocorre o erro de tabela mutante - a tabela jobs está sendo consultada ao mesmo tempo que está sendo atualizada.
*/

/*Exercício 2*/

--a)

  CREATE OR REPLACE PACKAGE job_pkg IS
    PROCEDURE initialize;
    FUNCTION get_minsalary(p_jobid jobs.job_id%TYPE)
      RETURN jobs.min_salary%TYPE;
    FUNCTION get_maxsalary(p_jobid jobs.job_id%TYPE)
      RETURN jobs.max_salary%TYPE;
    PROCEDURE set_minsalary(p_jobid      jobs.job_id%TYPE,
                            p_min_salary jobs.min_salary%TYPE);
    PROCEDURE set_maxsalary(p_jobid      jobs.job_id%TYPE,
                            p_max_salary jobs.max_salary%TYPE);
    PROCEDURE add_job(p_jobno jobs.job_id%TYPE,
                      p_title jobs.job_title%TYPE);
    PROCEDURE upd_job(p_jobno jobs.job_id%TYPE,
                      p_title jobs.job_title%TYPE);
    PROCEDURE del_job(p_jobno jobs.job_id%TYPE);
    FUNCTION get_job(p_jobno jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
  END job_pkg;

--b)

  CREATE OR REPLACE PACKAGE BODY job_pkg IS
    TYPE jobs_tab_type IS TABLE OF jobs%ROWTYPE INDEX BY jobs.job_id%TYPE;
    jobstab jobs_tab_type;

    PROCEDURE initialize AS
      CURSOR cur_jobs IS
        SELECT *
        FROM   jobs;
    BEGIN
      FOR job_rec IN cur_jobs
      LOOP
        jobstab(job_rec.job_id) := job_rec;
      END LOOP;
    END initialize;

    FUNCTION get_minsalary(p_jobid jobs.job_id%TYPE)
      RETURN jobs.min_salary%TYPE IS
    BEGIN
      RETURN jobstab(p_jobid).min_salary;
    END get_minsalary;

    FUNCTION get_maxsalary(p_jobid jobs.job_id%TYPE)
      RETURN jobs.max_salary%TYPE IS
    BEGIN
      RETURN jobstab(p_jobid).max_salary;
    END get_maxsalary;

    PROCEDURE set_minsalary(p_jobid      jobs.job_id%TYPE,
                            p_min_salary jobs.min_salary%TYPE) AS
    BEGIN
      jobstab(p_jobid).min_salary := p_min_salary;
    END set_minsalary;

    PROCEDURE set_maxsalary(p_jobid      jobs.job_id%TYPE,
                            p_max_salary jobs.max_salary%TYPE) AS
    BEGIN
      jobstab(p_jobid).max_salary := p_max_salary;
    END set_maxsalary;

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

  CREATE OR REPLACE PROCEDURE check_salary(p_job employees.job_id%TYPE,
                                           p_sal employees.salary%TYPE) AS
    v_minsal jobs.min_salary%TYPE := job_pkg.get_minsalary(p_job);
    v_maxsal jobs.max_salary%TYPE := job_pkg.get_maxsalary(p_job);
  BEGIN
    IF p_sal NOT BETWEEN v_minsal AND v_maxsal THEN
      RAISE_APPLICATION_ERROR(-20202,
                              'Invalid salary ' || p_sal || '.
                                        Salaries for job ' ||
                              UPPER(p_job) || ' must be between ' || v_minsal ||
                              ' and ' || v_maxsal || '.');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20203, 'Job ID does not exists.');
  END check_salary;

--d)

  CREATE OR REPLACE TRIGGER init_jobpkg_trg
    BEFORE INSERT OR UPDATE ON jobs
    CALL job_pkg.initialize

--e)

  SELECT e.employee_id,
         e.last_name,
         e.job_id,
         e.salary,
         j.min_salary
  FROM   employees e,
         jobs      j
  WHERE  e.job_id = j.job_id
  AND    e.job_id = 'IT_PROG';

  UPDATE jobs
  SET    min_salary = min_salary + 1000
  WHERE  job_id = 'IT_PROG';

-- Foi atualizado apenas o salário dos funcionários que tinham o salário abaixo do salário mínimo para o seu cargo.

/*Exercício 3*/

--a)

  BEGIN
    emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', p_sal => 6500);
  END;

-- Ocorre o erro no data found, pois a tabela jobstab não foi inicializada.

--b)

  CREATE OR REPLACE TRIGGER employee_initjobs_trg
    BEFORE INSERT OR UPDATE ON employees
    CALL job_pkg.initialize

--c)

  BEGIN
    emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', p_sal => 6500);
  END;
  
  SELECT employee_id,
         first_name,
         last_name,
         salary,
         job_id,
         department_id
  FROM   employees
  WHERE  email = 'SMORSE';
