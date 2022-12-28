/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: PLSQL2
-- Data: 12/12/2022
-- Tópico: 5
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a, b)

  CREATE OR REPLACE PROCEDURE employee_report(p_dir      IN VARCHAR2,
                                              p_filename IN VARCHAR2) AS
    f_file UTL_FILE.FILE_TYPE;
    CURSOR cur_emp IS
      SELECT *
      FROM   employees e
      WHERE  salary > (SELECT AVG(salary)
                       FROM   employees
                       WHERE  department_id = e.department_id);
  BEGIN
    f_file := UTL_FILE.FOPEN(p_dir, p_filename, 'W');
    FOR emp_rec IN cur_emp
    LOOP
      UTL_FILE.PUT_LINE(f_file,
                        'Employee ' || emp_rec.last_name || ' with Salary ' ||
                        emp_rec.salary || ' from Department ' ||
                        emp_rec.department_id);
    END LOOP;
    UTL_FILE.FCLOSE(f_file);
  EXCEPTION
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      RAISE_APPLICATION_ERROR(-20001, 'Invalid File.');
    WHEN UTL_FILE.WRITE_ERROR THEN
      RAISE_APPLICATION_ERROR(-20002, 'Unable to write to file.');
  END employee_report;

/*Exercício 2*/

--a, b)

  EXECUTE employee_report('KIPREV_SIDE_DIR', 'JSOBRALS_EMPLOYEE_REPORT.txt');
