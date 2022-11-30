/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL1 
-- Data: 05/10/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a) True

--b) False

--c) True

--d)
  
  SELECT ROUND(MAX(salary)) "Maximum",
         ROUND(MIN(salary)) "Minimum",
         ROUND(SUM(salary)) "Sum",
         ROUND(AVG(salary)) "Average"
  FROM   employees;

--e)
  
  SELECT job_id,
         ROUND(MAX(salary)) "Maximum",
         ROUND(MIN(salary)) "Minimum",
         ROUND(SUM(salary)) "Sum",
         ROUND(AVG(salary)) "Average"
  FROM   employees
  GROUP  BY job_id;

--f)
  
  SELECT job_id,
         COUNT(*)
  FROM   employees
  WHERE  UPPER(job_id) LIKE UPPER('&job_title')
  GROUP  BY job_id;

--g)
  
  SELECT COUNT(DISTINCT manager_id) "Number of Managers"
  FROM   employees;

--h)

  SELECT MAX(salary) - MIN(salary) difference
  FROM   employees;

--i)

  SELECT manager_id,
         MIN(salary)
  FROM   employees
  WHERE  manager_id IS NOT NULL
  GROUP  BY manager_id
  HAVING MIN(salary) > 6000
  ORDER  BY MIN(salary) DESC;

--j)

 SELECT COUNT(employee_id) total,
        COUNT(CASE
                WHEN TO_CHAR(hire_date, 'YYYY') LIKE '2005' THEN
                 employee_id
              END) "2005",
        COUNT(CASE
                WHEN TO_CHAR(hire_date, 'YYYY') LIKE '2006' THEN
                 employee_id
              END) "2006",
        COUNT(CASE
                WHEN TO_CHAR(hire_date, 'YYYY') LIKE '2007' THEN
                 employee_id
              END) "2007",
        COUNT(CASE
                WHEN TO_CHAR(hire_date, 'YYYY') LIKE '2008' THEN
                 employee_id
              END) "2008"
 FROM   employees;
 
 SELECT COUNT(employee_id) total,
        COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2005', employee_id, NULL)) "2005",
        COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2006', employee_id, NULL)) "2006",
        COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2007', employee_id, NULL)) "2007",
        COUNT(DECODE(TO_CHAR(hire_date, 'YYYY'), '2008', employee_id, NULL)) "2008"
 FROM   employees;

--k)

  SELECT job_id "Job",
         SUM(CASE
               WHEN department_id = 20 THEN
                salary
               ELSE
                NULL
             END) "Dept 20",
         SUM(CASE
               WHEN department_id = 50 THEN
                salary
               ELSE
                NULL
             END) "Dept 50",
         SUM(CASE
               WHEN department_id = 80 THEN
                salary
               ELSE
                NULL
             END) "Dept 80",
         SUM(CASE
               WHEN department_id = 90 THEN
                salary
               ELSE
                NULL
             END) "Dept 90",
         SUM(salary) "Total"
  FROM   employees
  GROUP  BY job_id;
  
  SELECT job_id "Job",
         SUM(DECODE(department_id, 20, salary, NULL)) "Dept 20",
         SUM(DECODE(department_id, 50, salary, NULL)) "Dept 50",
         SUM(DECODE(department_id, 80, salary, NULL)) "Dept 80",
         SUM(DECODE(department_id, 90, salary, NULL)) "Dept 90",
         SUM(salary) "Total"
  FROM   employees
  GROUP  BY job_id;
