GROUP SET
---------
 
SELECT                         ---month,total_amount
   TO_CHAR(payment_date,'month') as month,
   null as staff_id,
   sum(amount)as total_amount
   FROM  payment
   GROUP BY  TO_CHAR(payment_date,'month')
   
   UNION
   
 SELECT    ----staff_id,total_amount
   null as month,
   staff_id,
   sum(amount)as total_amount
 FROM payment
   group by 
   staff_id
   
   UNION
   
  select   ---STAFF_ID,MONTH,TOTAL_AMOUNT
   to_char(payment_date,'month'),
   staff_id,
   sum(amount)
  FROM payment 
  group  by 
   to_char(payment_date,'month'),
   staff_id
	
MAIN CONCEPT   --MUCH MUCH EASY
____________ 
    SELECT
      STAFF_ID,
      TO_CHAR(PAYMENT_DATE,'MONTH') AS MONTH,
      SUM(AMOUNT)
    FROM PAYMENT
      GROUP BY
        GROUPING SETS(
                       (STAFF_ID),
                       (MONTH),
                       (STAFF_ID,MONTH)
                      );

CHALLENGE
-----------
1.  WRITE A QUERY THAT RETURN THE SUM OF THE AMOUNT FOR EACH CUSTOMER(
   first name,last name) an each staff_id Also add the overall revenue per customer

   SELECT FIRST_NAME,LAST_NAME,STAFF_ID,SUM(AMOUNT) 
   FROM CUSTOMER C 
   LEFT JOIN PAYMENT P 
   ON C.CUSTOMER_ID=P.CUSTOMER_ID 
   GROUP BY
      GROUPING SETS(
		  (FIRST_NAME,LAST_NAME),
		  (FIRST_NAME,LAST_NAME,STAFF_ID)
	  ); 

2. write a query that calculates now the share of revenue each staff_id makes per
   customer. the result should look like this.  

  SELECT FIRST_NAME,
       LAST_NAME,
	   STAFF_ID,
	   SUM(AMOUNT) as total_amount, 
	   round(100*sum(amount)/
	   first_value(sum(amount)) over(partition by first_name,last_name order by sum(amount) desc),2) as percentage  
   FROM CUSTOMER C 
   LEFT JOIN PAYMENT P 
   ON C.CUSTOMER_ID=P.CUSTOMER_ID 
   GROUP BY
      GROUPING SETS(
		  (FIRST_NAME,LAST_NAME),
		  (FIRST_NAME,LAST_NAME,STAFF_ID)
	           ); 
---------------------------------------------------------------------------------------------------------
 ROLLUP
---------------
    
   GROUP BY                          
   ROLLUP (column1,column2,column3)

   GROUP BY                          
   GROUPING SETS(
   (column1,column2,column3)
   (column1,column2),
   (column1) ,  - hierachy
   ()
   )  

SELECT
    'Q'|| TO_CHAR(payment_date,'Q') as quater,
     EXTRACT(MONTH FROM payment_date) as month,
     DATE(payment_date),
     SUM(amount)
FROM payment 
     GROUP BY 
       ROLLUP(
          'Q'|| TO_CHAR(payment_date,'Q'),
          EXTRACT(MONTH FROM payment_date) ,
          DATE(payment_date)   
       ) ORDER BY 1,2,3

CHALLENGE
---------
  wirte a query that calculates a bookings amount rollup for the hierarchy
  of quater ,month ,week in month and day.
 

 SELECT TO_CHAR(BOOK_DATE,'Q') AS QUATER,
       EXTRACT(MONTH FROM BOOK_DATE) AS MONTH,
	   TO_CHAR(BOOK_DATE,'W') AS WEEK_IN_MONTH,
	   DATE(BOOK_DATE)AS DAY,
	   SUM(TOTAL_AMOUNT)AS TOTAL_AMOUNT 
	   FROM BOOKINGS
     GROUP BY
	    ROLLUP(
			TO_CHAR(BOOK_DATE,'Q'),
			EXTRACT(MONTH FROM BOOK_DATE),
			TO_CHAR(BOOK_DATE,'W'),
			DATE(BOOK_DATE)
		)
		ORDER BY 1,2,3,4 ;
		
----------------------------------------------------------------------------
CUBE--- berlif informatrion
----
  GROUP BY
  CUBE (column1,column2,column3)
  
  
   select
     customer_id,
     staff_id,
     date(payment_date),
     sum(amount)
   from payment
      group by 
             cube(
	          customer_id,
                  staff_id,
                  date(payment_date)  
                  )order by 1,2,3
  
challenge
---------
   Write a query that returns all grouping sets in all combinations of customer_id
   date and title  with aggregation of the payment amount

select * from film;--film_id
select * from payment;--payment_id,customer_id,staff_id,rental_id
select * from rental;--rental_id,inventory_id,customer_id,staff_id;
select * from inventory;---inventory_id,film_id,store_id

select 
p.customer_id,
date(payment_date),
title,sum(amount)
from payment p 
inner join rental r 
on p.customer_id=r.customer_id 
inner join inventory i 
on r.inventory_id=i.inventory_id
inner join film f
on f.film_id=i.film_id
group by
  cube(
	  p.customer_id,
     date(payment_date),
      title
  )

-------------------------------------------------------------------------------------
SELF JOIN
---------
   standard join with itself

  SELECT 
    emp.employee_id,
    emp.name as employee,
    mng.name as manager
   FROM
     employee emp
   left join employee mng
   on  emp.manager_id=mng.employee_id 
 

  SELECT 
    emp.employee_id,
    emp.name as employee,
    mng.name as manager,
    mng2.name as manager_of_manager
   FROM
    employee emp
    left join employee mng
     on  emp.manager_id=mng.employee_id
    left join employee mn2
     on mng.manager_id=mng2.employee_id

CHALLENGE
---------
   WHAT TITLE ARE SAME LENGTH
    ANS:
     SELECT 
        F1.TITLE,
        F2.TITLE,
        F1.LENGTH
     FROM FILM F1
      LEFT JOIN FILM F2
      ON F1.LENGTH=F2.LENGTH
      WHERE
      F1.TITLE!=F2.TITLE ORDER BY LENGTH DESC

-------------------------------------------------------------------------------------------------------------------------------------
CROSS JOIN
----------- 
  IT A COMINATION OF ROW (NOT A COMNINATION OF  VALUE)
  SELECT 
      STAFF_ID,
      STORE.MANAGER_STAFF_ID 
  FROM STAFF CROSS JOIN STORE

  1 1
  2 2
 
  1  1
  1  2
  2  1
  2  2

-----------------------------------------------------------
NATURAL JOIN
-------------
    JUST LIKE A NOTMAL JION

  * Automatically joins using columns
    with the same column name
 
  SELECT
  *
  from payment
  NATURAL LEFT JOIN customer
          --CUSTOMER_ID [PRESENT IN BOTH TABLES]

-----------------------------------------------------
NATURAL JOIN
-------------
   hint-- this sql quary to handle be carefully

  select * from payment natural
  inner join customer
  
  select * from customer natural inner join
  address -- they not a result because this is a  two column same line


------------------------------------------------------------------------------



















