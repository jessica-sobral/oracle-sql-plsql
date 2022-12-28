/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 19/12/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE OR REPLACE PROCEDURE check_salary(p_job employees.job_id%TYPE,
                                           p_sal employees.salary%TYPE) AS
    v_minsal jobs.min_salary%TYPE;
    v_maxsal jobs.max_salary%TYPE;
  BEGIN
    SELECT min_salary,
           max_salary
    INTO   v_minsal,
           v_maxsal
    FROM   jobs
    WHERE  job_id = UPPER(p_job);
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

--b)

  CREATE OR REPLACE TRIGGER check_salary_trg
    BEFORE INSERT OR UPDATE ON employees
    FOR EACH ROW
  BEGIN
    check_salary(:NEW.job_id, :NEW.salary);
  END check_salary_trg;

/*Exercício 2*/

--a)

  BEGIN
    emp_pkg.add_employee('Eleanor', 'Beh', 30);
  END;

/* O funcionário não é registrado na tabela, pois o salário padrão (1.000) não está entre o salário mínimo e
   máximo permitido para o job ID padrão (SA_REP).
*/

--b) 

  UPDATE employees
  SET    salary = 2000
  WHERE  employee_id = 115;

  UPDATE employees
  SET    job_id = 'HR_REP'
  WHERE  employee_id = 115;

/* Não é permitido atualizar o salário para 2.000, pois ele está abaixo do salário mínimo permitido para o job ID
   atual do funcionário 115. Também não é permitido ataulizar o job ID para HR_REP, pois o salário atual do 
   funcionário 115 está abaixo do salário mínimo permitido para este job ID.
*/

--c)

  UPDATE employees
  SET    salary = 2800
  WHERE  employee_id = 115;

/* O salário é atualizado com sucesso, pois, mesmo diminuindo, o salário ainda está entre o salário mínimo e
   máximo permitido para o job ID atual.
*/

/*Exercício 3*/

--a)

  CREATE OR REPLACE TRIGGER check_salary_trg
    BEFORE INSERT OR UPDATE ON employees
    FOR EACH ROW
    WHEN ((NVL(OLD.job_id, '0') <> NEW.job_id) OR
         (NVL(OLD.salary, 0) <> NEW.salary))
  BEGIN
    check_salary(:NEW.job_id, :NEW.salary);
  END check_salary_trg;

--b)

  BEGIN
    emp_pkg.add_employee(p_fname => 'Eleanor',
                         p_lname => 'Beh',
                         p_email => 'EBEH',
                         p_job   => 'IT_PROG',
                         p_sal   => 5000);
  END;

--c)

  UPDATE employees
  SET    salary = salary + 2000
  WHERE  job_id = 'IT_PROG';

/* Ocorre o erro tratado anteriormente, pois algum registro iria exceder o salário máximo de 10.000 para o job ID
   IT_PROG.
*/

--d)

  UPDATE employees
  SET    salary = 9000
  WHERE  first_name = 'Eleanor'
  AND    last_name = 'Beh';

-- O salário de Eleanor é atualizado, pois está entre o salário mínimo e máximo para o seu job ID atual (IT_PROG).

--e)

  UPDATE employees
  SET    job_id = 'ST_MAN'
  WHERE  first_name = 'Eleanor'
  AND    last_name = 'Beh';

-- Ocorre um erro, pois o salário atual de Eleanor excede o salário máximo permitido para o job ID ST_MAN.

/*Exercício 4*/

--a)

  CREATE OR REPLACE TRIGGER delete_emp_trg
    BEFORE DELETE ON employees
  BEGIN
    IF (TO_CHAR(SYSDATE, 'DY') NOT IN ('SAT', 'SUN')) AND
       (TO_CHAR(SYSDATE, 'HH24:MI') BETWEEN '09:00' AND '18:00') THEN
      RAISE_APPLICATION_ERROR(-20500,
                              'You can delete from the EMPLOYEES table only during ' ||
                              ' weekday business hours.');
    END IF;
  END delete_emp_trg;
  
--b)

  DELETE FROM employees
  WHERE  job_id = 'SA_REP'
  AND    department_id IS NULL;
