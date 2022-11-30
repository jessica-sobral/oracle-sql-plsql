/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 24/10/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT last_name,
         department_id,
         salary
  FROM   employees
  WHERE  (department_id, salary) IN
         (SELECT department_id,
                 salary
          FROM   employees
          WHERE  commission_pct IS NOT NULL)
  ORDER  BY salary DESC;

--b)

  SELECT e.last_name,
         d.department_name,
         e.salary
  FROM   employees   e,
         departments d
  WHERE  e.department_id = d.department_id
  AND    (e.salary, e.job_id) IN
         (SELECT salary,
                  job_id
           FROM   employees   emp,
                  departments d
           WHERE  emp.department_id = d.department_id
           AND    location_id = 1700);

--c)

  SELECT last_name,
         hire_date,
         salary
  FROM   employees
  WHERE  (salary, manager_id) IN
         (SELECT salary,
                 manager_id
          FROM   employees
          WHERE  last_name = 'Kochhar')
  AND    last_name <> 'Kochhar';

--d)

  SELECT last_name,
         job_id,
         salary
  FROM   employees
  WHERE  salary > ALL (SELECT salary
                       FROM   employees
                       WHERE  job_id = 'SA_MAN')
  ORDER  BY salary DESC;

--e)

  SELECT employee_id,
         last_name,
         department_id
  FROM   (SELECT e.employee_id,
                 e.last_name,
                 e.department_id
          FROM   employees   e,
                 departments d,
                 locations   l
          WHERE  e.department_id = d.department_id
          AND    d.location_id = l.location_id
          AND    l.city LIKE 'T%')
  ORDER  BY employee_id DESC;

--f)

  SELECT e.last_name ename,
         e.salary,
         e.department_id deptno,
         TO_CHAR(d.dept_avg, 'fm99999D00') dept_avg
  FROM   employees e,
         (SELECT department_id,
                 AVG(salary) dept_avg
          FROM   employees
          GROUP  BY department_id) d
  WHERE  e.salary > d.dept_avg
  AND    e.department_id = d.department_id
  ORDER  BY dept_avg;

--g)

  --i)

    SELECT last_name
    FROM   employees e
    WHERE  NOT EXISTS (SELECT 'X'
                       FROM   employees
                       WHERE  manager_id = e.employee_id);

  --ii)

    SELECT last_name
    FROM   employees e
    WHERE  employee_id NOT IN (SELECT manager_id
                               FROM   employees
                               WHERE  manager_id = e.employee_id);
         
    SELECT last_name
    FROM   employees
    WHERE  employee_id != ALL (SELECT DISTINCT e.employee_id
                               FROM   employees e,
                                      employees m
                               WHERE  e.employee_id = m.manager_id);

--h)

  SELECT e.last_name
  FROM   employees e
  WHERE  e.salary < (SELECT AVG(salary)
                     FROM   employees
                     WHERE  e.department_id = department_id);
--i)

  SELECT e.last_name
  FROM   employees e
  WHERE  1 <= (SELECT COUNT(*)
               FROM   employees
               WHERE  e.department_id = department_id
               AND    hire_date > e.hire_date
               AND    salary > e.salary);

--j)

  SELECT employee_id,
         last_name,
         (SELECT department_name
          FROM   departments
          WHERE  department_id = e.department_id) department
  FROM   employees e;

--k)

  SELECT d.department_name,
         SUM(e.salary) dept_total
  FROM   employees e
  JOIN   departments d
  ON     e.department_id = d.department_id
  GROUP  BY e.department_id,
            d.department_name
  HAVING SUM(salary) > (SELECT SUM(salary) / 8
                        FROM   employees);
