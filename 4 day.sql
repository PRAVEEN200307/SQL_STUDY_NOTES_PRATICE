TODAY
  TEXT RELATED FUNCTION
  . STRING FUCTION
  . DATE/TIME FUNCTIONS 
  . MATHEMATICAL FUNCTIONS/OPERATORS.

STRING FUNCTION
---------------
  UPPER()--- UPPER FUNCTION TO PRODUCE THE OUTPUT UPPER
  LOWER()--- LOWER FUNCTION TO PRODUCE THE OUTPUT LOWER
  LENGTH()---- LENGTH FUNCTION TO PRODUCE THE OUTPUT LENGTH LIKE NUMBER 29,35

 EXAMPLE:
 -------
   SELECT
   EMAIL,
   UPPER(EMAIL)AS EMIL_UPPER,
   LOWER(EMAIL) AS LOWER_EMAIL,
   LENGTH(EMAIL) 
   FROM CUSTOMER WHERE LENGTH(EMAIL)<30;

 CHALLENGE
---------
 IN THE EMAIL SYSTEM THERE WAS A PROBLEM WITH NAMES WHERE EITHER THE FIRST NAME OR LAST NAME IS MORE THAN 10 CHARACTERS LONG
 FIND THESE CUSTOMERS AND OUTPUT THE LIST OF THESE FIRST AND LAST NAMES IN ALL LOWER CASE?

SELECT LOWER(FIRST_NAME) AS FIRST_NAME,
LOWER(LAST_NAME) AS LAST_NAME,
LOWER(EMAIL),
LENGTH(FIRST_NAME) AS FIRST_NAME_LENGTH,
LENGTH(LAST_NAME)AS LAST_NAME_LENGTH 
FROM CUSTOMER WHERE  LENGTH(FIRST_NAME)>10 OR LENGTH(LAST_NAME)>10;
-----------------------------------------------------------------------------------------------------------------------------------------------------
LEFT AND RIGHT
--------------
   SELECT LEFT(FIRST_NAME,1),FIRST_NAME FROM CUSTOMER;
   SELECT right(FIRST_NAME,1),FIRST_NAME FROM CUSTOMER;
   SELECT RIGHT(LEFT(FIRST_NAME,2),1),FIRST_NAME FROM CUSTOMER;

CHALLENGE
  EXTRACT THE LAST 5 CHARATERS OF THE EMAIL ADDRESS FIRST 
  THE EMAIL ADDRESS ALEAYS END WITH '.ORG';
  HOW CAN YOU EXTRACT JUST THE DOT  '.'  FROM THYE EMAIL ADDRESS?

  select LEFT(Right(email,4),1) from customer;
  SELECT RIGHT(LEFT(RIGHT(EMAIL,5),2),1) FROM CUSTOMER
    OUTPUT 
    ------  =.
----------------------------------------------------------------------------------------------------------------------------------------------------------------
  CONCATENATE
-------------
   
   SELECT LEFT(FIRST_NAME,1) || LEFT(LAST_NAME,1),first_name,LAST_NAME FROM CUSTOMER;
   SELECT LEFT(FIRST_NAME,1)||' .' || LEFT(LAST_NAME,1),first_name,LAST_NAME FROM CUSTOMER;
   

  YOU NEEED TO CREATE AN ANONYMIZED VERSION OF THE EMAIL ADDRESSES
     "M***@sakilacustomer.org"     "MARY.SMITH@sakilacustomer.org"
  IT SHOULD BE THE FIRST CHARACTER FOLLOWED BY '***' AND THEN THE LAST PART STARTING WITH '@'.
  ANS
 ----
   select left(email,1)||'***'||right(email,19) from customer 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
POSITION
     select position('@' in email) from customer;
     select left(email,postision('@' in email)) from customer
     select left(email,postion(last_name in email)-2) from customer;
     select position('.org' in email),email from customer
CHALLENGE
    IN THIS CHALLLENGE YOU HAVE ONLY THE EMAIL ADDRESS AND THE LAST NAME OF THE CUSTOMERS.
         
    YOU NEED TO EXTRACT THE FIRST NAME FROM THE EMAIL ADDRESSS AND CONCATENATE IT WITH THE LAST NAME , IT SHOULD BE IN THE FORM:
    "LAST NAME,FIRST NAME" 
    
    ANS:
    --- 
      SELECT LEFT_NAME,LEFT(EMAIL,POSTION('.' IN EMAIL)-1) AS FIRST_NAME, EMAIL FROM CUSTOMER;
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
SUBSTRING
---------
   > USED TO EXTRACT A  SUBSTRING   FROM A STRING
  SYNTAX
     SUBSTRING (STRING FROM START [FOR LENGTH])
                | COLUMN/STRING THAT WE WANT TO EXTRACT FROM
      START
        POSITION WHERE TO START FROM?

      LENGTH  
        LENGTH HOW MANY CHARATERS?
        THIS IS FOR OPTIONAL
       
     SELECT SUBSTRING (EMAIL FROM POSITION ('.' IN EMAIL)+1 FOR 3),EMAIL FROM  CUSTOMER;  
     SELECT SUBSTRING(EMAIL FROM POSITION('.' IN EMAIL)+1) FOR LENGTH(LAST_NAME) FROM CUSTOMER;
     SELECT EMAIL,SUBSTRING(EMAIL FROM 3 FOR 2) FROM CUSTOMER;
     SELECT SUBSTRING(EMAIL FROM POSITION('.' IN EMAIL)+1 FOR POSITION('@' IN EMAIL)-POSITION('.' in email)-1),email FROM CUSTOMER;

     - --11-5=6 -1;
     select substring(email from position('.' in email)),email,position('.' in email) as dot_position, position('@' in email)as last_position,
     position('.' in email)-position('@' in email) from customer;

  select left(email,1)||'***.'||substring(email from position('.' in email)+1 for 1) ||'***'||substring(email from position('@' in email))as anonymized,email from customer
 CHALLENGE
  YOU NEED TO CREATE AN ANONYMIZED FORM OFTHE EMAIL ADDRESSSES IN THE FOLLLOWING WAY:
     SELECT LEFT(EMAIL,1)||'***'||SUBSTRING(EMAIL FROM POSITION('.' IN EMAIL) FOR 2)||'***'||
     SUBSTRING(EMAIL FROM POSITION('@' IN EMAIL)) FROM CUSTOMER;
  
"MARY.SMITH@sakilacustomer.org"        "M***.S***@sakilacustomer.org"
"PATRICIA.JOHNSON@sakilacustomer.org"  "P***.J***@sakilacustomer.org"
"LINDA.WILLIAMS@sakilacustomer.org"    "L***.W***@sakilacustomer.org"
  
   
  IN A SECOUND QUERY CREATE AN ANONMIZED FORM OF THE EMAIL ADDDRESSES IN THE FOLLLOWING WAY

SELECT 
'***'
||SUBSTRING(EMAIL FROM POSITION('.' IN EMAIL)-1 FOR 3 )
||'***'
||substring(email from position('@' in email))  from customer;

"MARY.SMITH@sakilacustomer.org"      "***Y.S***@sakilacustomer.org"
"PATRICIA.JOHNSON@sakilacustomer.org" "***A.J***@sakilacustomer.org"
"LINDA.WILLIAMS@sakilacustomer.org"   "***A.W***@sakilacustomer.org"
"BARBARA.JONES@sakilacustomer.org"    "***A.J***@sakilacustomer.org"   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
EXTRACT
-------
   > used to EXTRACT PARTS OF TIMESTAMP/DATE
   STANDDOT FORMAT--YYYY-MM-DD
   SYNTAX
   ------
     EXTRACT (FIELD FROM DATE/TIME/INTERVAL)

                     DATE/TIME TYPES
                     ----------------
date                                 just date without time       '2020-11-28'
TIME(WITH/WITHOUT TIME ZONE)         just time without date       '01:02:03.678+02'
timestamp(with/without time zone)    date and time                '2022-11-28  01:02:03.678+02'
interval                             time interval                '01:02:03.678+02'

  day,dow--day of week,doy,hour,minute,month,quarter,second,timezone,week,year

 EX :
   DAY
    SELECT EXTRACT(DAY from RENTAL_DATE),COUNT(*) FROM RENTAL GROUP BY EXTRACT(DAY from RENTAL_DATE)  ORDER BY COUNT(*) DESC;
   MONTH
    SELECT EXTRACT(MONTH from RENTAL_DATE),COUNT(*) FROM RENTAL GROUP BY EXTRACT(MONTH from RENTAL_DATE)  ORDER BY COUNT(*) DESC;
 
CHALLENGE
---------
 YOU NEED TO ANALYZE THE PAYMENTS AND FIND OUT THE FOLLLOWING
  . WHAT'S THE MONTH WIH THE HIGHEST TOTAL PAYMENT AMOUNT?
       select extract(month from payment_date),sum(payment_amount) FROM payment order by sum(payment_amount) desc;
  . WHAT'S  THE DAY OF WEEK WIH THE HIGHEST TOAL PAYMENT AMOUNT? (0 IS SUNDAY)
       SELECT EXTRACT(DOW from PAYMENT),SUM(PAYMENT_AMOUNT) FROM PAYMENT ORDER BY PAYMENT_AMOUNT;
  . WHAT'S THE HIGHEST AMOUNT ONE CUSTOMER HAS SPEND IN WEEK
      SELECT CUSTOMER_ID,EXTRACT(DOW FROM PAYMENT),sum(amount) FROM payment group by CUSTOMER_ID,EXTRACT(DOW FROM PAYMENT) order by sum(amount) desc;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
TO_CHAR
 > Used to get custom formats timestamp/date/numbers
 SYNTAX
    TO_CHAR(date/time/interval,format)
    TO_CHAR(RENTAL_DATE,'MM-YYYY')
DATE TYPE FORMATE FUNCTION
   
    select TO_CHAR(PAYMENT_DATE,'YYYY-MM-DD') FROM PAYMENT;
    select TO_CHAR(PAYMENT_DATE,'DAY') FROM PAYMENT;
    select TO_CHAR(PAYMENT_DATE,'YY') FROM PAYMENT;
    select TO_CHAR(PAYMENT_DATE,'DAY,MONTH,YYYY') FROM PAYMENT;
    select TO_CHAR(PAYMENT_DATE,'DY,MONTH,YYYY') FROM PAYMENT;
    select SUM(AMOUNT)AS TOTAL_AMOUNT,TO_CHAR(PAYMENT_DATE,'DY,hh:MM') AS "DAY" FROM PAYMENT GROUP BY 2 ORDER BY 2 DESC;

   DY-sun,mon,tue,wed,dd/mm/yyyy--23/23/2020,mon-month,hh:mi
   HH--HOUR OF DAY(01-12)
   MI--MINUTE(00-59)
   SS--SECOND(00-59)
   YYYY--YEAR,YYY-LAST THREE,YY-LAST TWO,Y-LAST DIGIT OF YEAR
   MONTH--MONTH.,month---lower case,mon--3 char
   DAY--FULL UPPPER CASE,day--full lowercase,DY,dy
   WW-WEEK NUMBER OF YEAR
CHALLENGE
   YOU NEED TO SUM PAYMENTS AND GROUP IN THE FOLLOWING FORMATS:
     select SUM(AMOUNT)AS TOTAL_AMOUNT,TO_CHAR(PAYMENT_DATE,'DY,DD/MM/YYYY')AS DAY FROM PAYMENT GROUP BY  2;
     select SUM(AMOUNT)AS TOTAL_AMOUNT,TO_CHAR(PAYMENT_DATE,'MON,YYYY') FROM PAYMENT GROUP BY 2 ORDER BY TOTAL_AMOUNT ASC ;
     select SUM(AMOUNT)AS TOTAL_AMOUNT,TO_CHAR(PAYMENT_DATE,'DY,hh:MI') AS "DAY" FROM PAYMENT GROUP BY 2 ORDER BY 2 DESC;
-----------------------------------------------------------------------------------------------------------------------------------------------------
INTERVALS &TIMESTAMPS
---------------------
     SELECT CURRENT_DATE
     SELECT CURRENT_TIMESTAMP                 INTERVALS
                                                |
     SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP-RENTAL_DATE FROM RENTAL;
     SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP-RENTAL_DATE FROM RENTAL;
     select extract(day from return_date -rental_date)*24+extract(hour from return_date -rental_date ),return_date -rental_date from rental

YOU NEED TO CREATE A LIST FOR THE SUPPORT TEAM OF ALL RENTAL DURATIOS OF CUSTOMER WITH CUSTOMER_ID =35
  SELECT CUSTOMER_ID,RENTAL_DATE-RETURN_DATE FROM RENTAL WHERE CUSTOMER_ID=35
ALSO YOU NEED TO FIND OUT FOR THE SUPPORT TEAM WHICH CUSTOEMR HAS THE LONGEST AVERAGE RENTAL DURATION
      SELECT CUSTOMER_ID,AVG(RETURN_DATE-RENTAL_DATE) FROM RENTAL GROUP BY CUSTOMER_ID ORDER  BY 2;



 