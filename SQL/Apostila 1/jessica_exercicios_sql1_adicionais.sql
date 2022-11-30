/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 18/10/2022
-- Tópico: Exercícios Adicionais
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT employee_id,
         first_name,
         last_name,
         email,
         phone_number,
         hire_date,
         job_id,
         ROUND(salary) salary
  FROM   employees
  WHERE  TO_NUMBER(TO_CHAR(hire_date, 'YYYY')) > 1997
  AND    LOWER(job_id) LIKE '%clerk';

--b)

  SELECT last_name,
         job_id,
         ROUND(salary) salary,
         commission_pct
  FROM   employees
  WHERE  commission_pct IS NOT NULL
  ORDER  BY salary DESC;

--c)
  
  SELECT 'The salary of ' || last_name || ' after a 10% raise is ' ||
         ROUND(salary * 1.10) "Newsalary"
  FROM   employees
  WHERE  commission_pct IS NULL;

--d)
  
  SELECT last_name,
         TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) years,
         TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hire_date), 12)) months
  FROM   employees
  ORDER  BY years  DESC,
            months DESC;

--e)
  
  SELECT last_name
  FROM   employees
  WHERE  UPPER(last_name) LIKE 'J%'
  OR     UPPER(last_name) LIKE 'K%'
  OR     UPPER(last_name) LIKE 'L%'
  OR     UPPER(last_name) LIKE 'M%';
  
  SELECT last_name
  FROM   employees
  WHERE  SUBSTR(last_name, 1, 1) IN ('J', 'K', 'L', 'M');

--f)
  
  SELECT last_name,
         ROUND(salary) salary,
         DECODE(commission_pct, NULL, 'No', 'Yes') commission
  FROM   employees;

--g)
  
  SELECT d.department_name,
         d.location_id,
         e.last_name,
         e.job_id,
         ROUND(e.salary) salary
  FROM   employees   e,
         departments d
  WHERE  e.department_id = d.department_id
  AND    d.location_id = &location_id;

--h)

  SELECT COUNT(*)
  FROM   employees
  WHERE  last_name LIKE '%n';
  
  SELECT COUNT(*)
  FROM   employees
  WHERE  SUBSTR(last_name, -1) = 'n';

--i)

  SELECT e.department_id,
         d.department_name,
         d.location_id,
         COUNT(e.employee_id)
  FROM   employees e
  RIGHT  JOIN departments d
  ON     e.department_id = d.department_id
  GROUP  BY e.department_id,
            d.department_name,
            d.location_id;
  
  SELECT e.department_id,
         d.department_name,
         d.location_id,
         COUNT(e.employee_id)
  FROM   employees   e,
         departments d
  WHERE  d.department_id = e.department_id(+)
  GROUP  BY e.department_id,
            d.department_name,
            d.location_id;

--j)

  SELECT DISTINCT job_id
  FROM   employees
  WHERE  department_id IN (10, 20);

--k)

  SELECT e.job_id,
         COUNT(e.employee_id) frequency
  FROM   employees e
  JOIN   departments d
  ON     e.department_id = d.department_id
  WHERE  d.department_name IN ('Administration', 'Executive')
  GROUP  BY job_id
  ORDER  BY frequency DESC;
  
  SELECT e.job_id,
         COUNT(e.employee_id) frequency
  FROM   employees   e,
         departments d
  WHERE  e.department_id = d.department_id
  AND    d.department_name IN ('Administration', 'Executive')
  GROUP  BY job_id
  ORDER  BY frequency DESC;

--l)
  
  SELECT last_name,
         hire_date
  FROM   employees
  WHERE  TO_NUMBER(TO_CHAR(hire_date, 'DD')) < 16;

--m)

  SELECT last_name,
         ROUND(salary) salary,
         TRUNC(salary / 1000) thousands
  FROM   employees;

--n)

  SELECT emp.last_name,
         mgr.last_name manager,
         ROUND(mgr.salary) salary,
         job.grade_level
  FROM   employees emp
  JOIN   employees mgr
  ON     emp.manager_id = mgr.employee_id
  JOIN   job_grades job
  ON     mgr.salary BETWEEN lowest_sal AND highest_sal
  WHERE  mgr.salary > 15000;
  
  SELECT emp.last_name,
         mgr.last_name manager,
         ROUND(mgr.salary) salary,
         job.grade_level
  FROM   employees  emp,
         employees  mgr,
         job_grades job
  WHERE  emp.manager_id = mgr.employee_id
  AND    mgr.salary BETWEEN lowest_sal AND highest_sal
  AND    mgr.salary > 15000;

--o)

  SELECT e.department_id,
         d.department_name,
         (SELECT COUNT(employee_id)
          FROM   employees
          WHERE  department_id = e.department_id
          GROUP  BY department_id) employees,
         (SELECT TO_CHAR(AVG(salary), 'fm999999999D00')
          FROM   employees
          WHERE  department_id = e.department_id
          GROUP  BY department_id) avg_sal,
         e.last_name,
         ROUND(e.salary) salary,
         e.job_id
  FROM   employees   e,
         departments d
  WHERE  e.department_id = d.department_id;
  
  SELECT e.department_id,
         d.department_name,
         c.employees,
         c.avg_sal,
         e.last_name,
         ROUND(e.salary) salary,
         e.job_id
  FROM   employees e,
         (SELECT COUNT(employee_id) employees,
                 TO_CHAR(AVG(salary), 'fm999999999D00') avg_sal,
                 department_id
          FROM   employees
          GROUP  BY department_id) c,
         departments d
  WHERE  e.department_id = d.department_id
  AND    c.department_id = e.department_id;
  
  SELECT c.department_id,
         d.department_name,
         COUNT(c.employee_id) employees,
         TO_CHAR(AVG(c.salary), 'fm999999999D00') avg_sal,
         e.last_name,
         ROUND(e.salary) salary,
         e.job_id
  FROM   employees e
  JOIN   employees c
  ON     e.department_id = c.department_id
  JOIN   departments d
  ON     e.department_id = d.department_id
  GROUP  BY c.department_id,
            d.department_name,
            e.last_name,
            e.salary,
            e.job_id;
  
  SELECT c.department_id,
         d.department_name,
         COUNT(c.employee_id) employees,
         TO_CHAR(AVG(c.salary), 'fm999999999D00') avg_sal,
         e.last_name,
         ROUND(e.salary) salary,
         e.job_id
  FROM   employees   e,
         employees   c,
         departments d
  WHERE  e.department_id = c.department_id
  AND    e.department_id = d.department_id
  GROUP  BY c.department_id,
            d.department_name,
            e.last_name,
            e.salary,
            e.job_id;

--p)
  
  SELECT department_id,
         MIN(salary)
  FROM   employees
  HAVING AVG(salary) = (SELECT MAX(AVG(salary))
                        FROM   employees
                        GROUP  BY department_id)
  GROUP  BY department_id;

--q)

  SELECT department_id,
         department_name,
         manager_id,
         location_id
  FROM   departments d
  WHERE  department_id != ALL (SELECT DISTINCT department_id
                               FROM   employees
                               WHERE  job_id = 'SA_REP'
                               AND    department_id IS NOT NULL);
  
  SELECT department_id,
         department_name,
         manager_id,
         location_id
  FROM   departments
  MINUS
  SELECT d.department_id,
         d.department_name,
         d.manager_id,
         d.location_id
  FROM   departments d,
         employees   e
  WHERE  d.department_id = e.department_id
  AND    e.job_id = 'SA_REP';

--r)

  --i)
    
    SELECT d.department_id,
           d.department_name,
           COUNT(*)
    FROM   employees   e,
           departments d
    WHERE  e.department_id = d.department_id
    GROUP  BY d.department_id,
              d.department_name
    HAVING COUNT(*) < 3;

  --ii)

    SELECT d.department_id,
           d.department_name,
           COUNT(*)
    FROM   employees   e,
           departments d
    WHERE  e.department_id = d.department_id
    GROUP  BY d.department_id,
              d.department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM   employees
                       GROUP  BY department_id);

  --iii)
    
    SELECT d.department_id,
           d.department_name,
           COUNT(*)
    FROM   employees   e,
           departments d
    WHERE  e.department_id = d.department_id
    GROUP  BY d.department_id,
              d.department_name
    HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                       FROM   employees
                       GROUP  BY department_id);

--s)

  SELECT e.employee_id,
         e.last_name,
         s.department_id,
         e.salary,
         AVG(s.salary)
  FROM   employees e,
         employees s
  WHERE  e.department_id = s.department_id
  GROUP  BY e.employee_id,
            e.last_name,
            s.department_id,
            e.salary;

--t)
  
  SELECT last_name,
         TO_CHAR(hire_date, 'Month DD') birthday
  FROM   employees
  ORDER  BY TO_CHAR(hire_date, 'MM DD');
  
