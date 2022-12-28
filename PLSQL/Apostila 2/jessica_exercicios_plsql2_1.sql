/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 02/12/2022
-- Tópico: 1
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE OR REPLACE PROCEDURE add_job(p_jobno    jobs.job_id%TYPE,
                                      p_title jobs.job_title%TYPE) IS
  BEGIN
    INSERT INTO jobs
    VALUES
      (p_jobno,
       p_title,
       NULL,
       NULL);
  END add_job;

--b)

  BEGIN
    add_job('IT_DBA', 'Database Administrator');
  END;

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_DBA';

--c)

  EXECUTE add_job('ST_MAN', 'Stock Manager');

-- Ocorre um erro de violação da constraint, pois a coluna job_id deve ser única e 'ST_MAN' já existe no banco.

/*Exercício 2*/

--a)

  CREATE OR REPLACE PROCEDURE upd_job(p_jobno jobs.job_id%TYPE,
                                      p_title jobs.job_title%TYPE) AS
  BEGIN
    UPDATE jobs
    SET    job_title = p_title
    WHERE  job_id = p_jobno;
    IF SQL%NOTFOUND THEN
      RAISE_APPLICATION_ERROR(-20202, 'No job updated.');
    END IF;
  END;

--b)

  BEGIN
    upd_job('IT_DBA', 'Data Administrator');
  END;

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_DBA';

--c)

  BEGIN
    upd_job('IT_WEB', 'Web Master');
  END;

/*Exercício 3*/

--a)

  CREATE OR REPLACE PROCEDURE del_job(p_jobno jobs.job_id%TYPE) IS
  BEGIN
    DELETE FROM jobs
    WHERE  job_id = p_jobno;
    IF SQL%NOTFOUND THEN
      RAISE_APPLICATION_ERROR(-20203, 'No jobs deleted.');
    END IF;
  END;

--b)

  BEGIN
    del_job('IT_DBA');
  END;

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_DBA';

--c)

  BEGIN
    del_job('IT_WEB');
  END;

/*Exercício 4*/

--a)

  CREATE OR REPLACE PROCEDURE get_employee(p_empno IN employees.employee_id%TYPE,
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

--b)

  VARIABLE b_sal NUMBER;
  VARIABLE b_job VARCHAR2(10);
  EXECUTE get_employee(120, :b_sal, :b_job);

--c)

  VARIABLE b_sal NUMBER;
  VARIABLE b_job VARCHAR2(10);
  EXECUTE get_employee(300, :b_sal, :b_job);

-- Ocorre um erro de nenhum dado encontrado, pois não existe um funcionário com employee_id 300.
