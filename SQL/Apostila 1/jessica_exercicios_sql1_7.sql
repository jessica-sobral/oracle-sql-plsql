/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1
-- Data: 10/10/2022
-- Tópico: 7
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT location_id,
         street_address,
         city,
         state_province,
         country_name
  FROM   locations l NATURAL
  JOIN   countries;

--b)

  SELECT last_name,
         department_id,
         department_name
  FROM   employees
  JOIN   departments
  USING  (department_id)
  ORDER  BY last_name;

--c)

  SELECT e.last_name,
         e.job_id,
         e.department_id,
         d.department_name
  FROM   employees e
  JOIN   departments d
  ON     e.department_id = d.department_id
  JOIN   locations l
  ON     d.location_id = l.location_id
  WHERE  LOWER(city) = LOWER('Toronto');

--d)

  SELECT emp.last_name   "Employee",
         emp.employee_id emp#,
         mgr.last_name   "Manager",
         emp.manager_id  "Mgr#"
  FROM   employees emp
  JOIN   employees mgr
  ON     emp.manager_id = mgr.employee_id;

--e)

  SELECT emp.last_name   "Employee",
         emp.employee_id emp#,
         mgr.last_name   "Manager",
         emp.manager_id  "Mgr#"
  FROM   employees emp
  LEFT   JOIN employees mgr
  ON     emp.manager_id = mgr.employee_id
  ORDER  BY emp.employee_id;

--f)

  SELECT emp.department_id department,
         emp.last_name     employee,
         col.last_name     colleague
  FROM   employees emp
  LEFT   JOIN employees col
  ON     emp.department_id = col.department_id
  WHERE  emp.last_name != col.last_name
  ORDER  BY emp.department_id;

--g)

  DESC job_grades;

  SELECT e.last_name,
         e.job_id,
         d.department_name,
         ROUND(e.salary) salary,
         j.grade_level
  FROM   employees e
  JOIN   departments d
  USING  (department_id)
  JOIN   job_grades j
  ON     e.salary BETWEEN j.lowest_sal AND j.highest_sal;

--h)

  SELECT e.last_name,
         e.hire_date
  FROM   employees e
  JOIN   employees davies
  ON     davies.last_name = 'Davies'
  WHERE  e.hire_date > davies.hire_date;

--i)

  SELECT emp.last_name,
         emp.hire_date,
         mgr.last_name,
         mgr.hire_date
  FROM   employees emp
  JOIN   employees mgr
  ON     emp.manager_id = mgr.employee_id
  WHERE  emp.hire_date < mgr.hire_date;
