/*
******************************Exercícios Treinamento************************
-- Nome: Jéssica Sobral Silva
-- Módulo: SQL2
-- Data: 28/10/2022
-- Tópico: 10
-- Instrutor: Gabriel Kazuki
****************************************************************************
*/

/*Exercício 1*/

--a)

  ALTER SESSION
  SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
  
--b)

  --i)

    SELECT TZ_OFFSET('US/Pacific-New')
    FROM   dual;

    SELECT TZ_OFFSET('Singapore')
    FROM   dual;

    SELECT TZ_OFFSET('Egypt')
    FROM   dual;

  --ii)

    ALTER SESSION
    SET TIME_ZONE = '-07:00';

    ALTER SESSION
    SET TIME_ZONE = 'US/Pacific-New';

  --iii)

    SELECT CURRENT_DATE,
           CURRENT_TIMESTAMP,
           LOCALTIMESTAMP
    FROM   dual;

  --iv)

    ALTER SESSION
    SET TIME_ZONE = '+08:00';

    ALTER SESSION
    SET TIME_ZONE = 'Singapore';

  --v)

    SELECT CURRENT_DATE,
           CURRENT_TIMESTAMP,
           LOCALTIMESTAMP
    FROM   dual;

--c)

  SELECT DBTIMEZONE,
         SESSIONTIMEZONE
  FROM   dual;

--d)

  SELECT last_name,
         EXTRACT(YEAR FROM hire_date)
  FROM   employees
  WHERE  department_id = 80;

--e)

  ALTER SESSION
  SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

--f)

  CREATE TABLE sample_dates (
    date_col DATE
  );

  INSERT INTO sample_dates
  VALUES
    (SYSDATE);

  --i)

    SELECT *
    FROM   sample_dates;

  --ii)

    ALTER TABLE sample_dates
    MODIFY date_col TIMESTAMP(9);
        
    SELECT *
    FROM   sample_dates;

/*  iii) Não é possível alterar o tipo de dado da coluna de DATE ou TIMESTAMP para TIMESTAMP WITH TIME
        ZONE, a menos que a coluna esteja vazia. Como não é o caso, um erro é retornado. */

    ALTER TABLE sample_dates
    MODIFY date_col TIMESTAMP WITH TIME ZONE;

--g)

  SELECT last_name,
         CASE EXTRACT(YEAR FROM hire_date)
           WHEN 2008 THEN
            'Needs Review!'
           ELSE
            'not this year!'
         END "Review"
  FROM   employees
  ORDER  BY hire_date;

  SELECT last_name,
         DECODE(EXTRACT(YEAR FROM hire_date),
                2008,
                'Needs Review!',
                'not this year!') "Review"
  FROM   employees
  ORDER  BY hire_date;

--h)

SELECT last_name,
       hire_date,
       SYSDATE,
       CASE
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) >= 15 THEN
          '15 years of service'
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) >= 10 THEN
          '10 years of service'
         WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date) >= 5 THEN
          '5 years of service'
         ELSE
          'maybe next year!'
       END "Awards"
FROM   employees
ORDER  BY hire_date;
