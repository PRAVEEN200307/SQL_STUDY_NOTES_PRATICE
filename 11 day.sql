WINDOW FUNCTIONS
--------------
   No.of rows not affected
   Aggregated by

  select sum(price_in_transaction) OVER(PARTITION BY CUSTOMER_ID);

  SUM()
  COUNT()
  Rank() ,DENSE_RANK()
  FIRST_VALUE()
  LEAD()
  LAG()
  
  SYNTAX
  -----
  AGG(agg_column) OVER(PARTITION BY partition_column);

  select count(*)as no_of_transactions_by_type
  OVER(PARTITION BY customer_id);
 
 CHALLENGE
 ---------
  
   write a query that returns the list of movies including
    -film_id
    -title
    -length
    -category
    -average length of moves in that cateogory
   order the result by film_id

ANS:

    SELECT 
    F.FILM_ID,
    TITLE,
    NAME,
    length,
    round(avg(length) over(partition by name) as average_length)
    FROM FILM F 
    INNER JOIN FILM_CATEGORY FC ON F.FILM_ID=FC.FILM_ID 
    INNER JOIN CATEGORY C ON C.CATEGORY_ID=FC.CATEGORY_ID  order by film_id 

  write a query that returns all payment details including
  the number of payments that were made by this customer and the amount
  ANS:
  select *,count(*) over(partition by  amount,customer_id)as numer_of_payment_amount from payment
  order by 2


------------------------------------------------------------------------------------------------------------------------------------------------------------
OVER() WITH ORDER BY 
-------------------
   
  SELECT *,SUM(AMOUNT) OVER(ORDER BY payment_date)
  FROM  payment;

  SELECT *,SUM(AMOUNT) OVER(ORDER BY payment_id)
  FROM  payment;

  select *,sum(amount)
            OVER(PARTITION BY customer_id)
                 ORDER BY payment_date,payment_id)
   from payment;

   CHALLENGE
   --------
   1. write a query that returns the running total of how late the flights are
      (difference between acutual_arrival and scheduled_arrival) ordered by flight_id
      including the departure airport.
  
      As a second query,calculate the same running total but PARTITION also by the
      departure airport
      
    RESULT:
       SELECT flight_id,departure_airport,
       sum(actual_arrival-scheduled_arrival) OVER(order by flight_id) from flights;

       SELECT flight_id,departure_airport,
       sum(actual_arrival-scheduled_arrival) 
           OVER( PARTITION BY departure_airport order by flight_id) 
           from flights;

------------------------------------------------------------------------------------------------------------------------------------------
 RANK()
-------
    
    SELECT 
    F.FILM_ID,
    TITLE,
    NAME,
    length,
    RANK() over(PARTITION BY NAME  ORDER  by LENGTH DESC) as RANK
    FROM FILM F 
    INNER JOIN FILM_CATEGORY FC ON F.FILM_ID=FC.FILM_ID 
    INNER JOIN CATEGORY C ON C.CATEGORY_ID=FC.CATEGORY_ID  

CHALLENGE
---------
   Write a query that returns the customers' name, the country and how many
   payment they have.For that use the existing view customer_list

   Afterwards create a ranking of the top customers with 
   most sales for each country,filter the result only the top3
   customers per country.
Ans:
   create table top_customer
   as
   select * from 
   (SELECT NAME,COUNTRY,
   COUNT(*),
   DENSE_RANK() OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) DESC) as rank
   FROM CUSTOMER_LIST C LEFT JOIN PAYMENT P ON C.ID=P.CUSTOMER_ID
   group by name,country) as A where rank in (1,2,3) ;
  
   select * from top_customer order by count desc;
   
---------------------------------------------------------------------------------------------------------------------------------------
FIRST VALUE
-----------
   SELECT NAME,COUNTRY,
   COUNT(*),
   first_value(name) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) DESC )
   FROM CUSTOMER_LIST C LEFT JOIN PAYMENT P ON C.ID=P.CUSTOMER_ID
   group by name,country
   
   SELECT NAME,COUNTRY,
   COUNT(*),
   first_value(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) DESC )
   FROM CUSTOMER_LIST C LEFT JOIN PAYMENT P ON C.ID=P.CUSTOMER_ID
   group by name,country
   
   SELECT NAME,COUNTRY,
   COUNT(*),
   first_value(count(*)) OVER(PARTITION BY COUNTRY ORDER BY  COUNT(*) asc    ) 
   FROM CUSTOMER_LIST C LEFT JOIN PAYMENT P ON C.ID=P.CUSTOMER_ID
   group by name,country
   
   SELECT NAME,COUNTRY,
   COUNT(*) ,
   first_value(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) DESC ),
    first_value(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) DESC )-count(*)
   FROM CUSTOMER_LIST C LEFT JOIN PAYMENT P ON C.ID=P.CUSTOMER_ID
   group by name,country
  -----------------------------------------------------------------------------------------------------
 LEAD/LAG
 --------
 
 LEAD ----ex lead before payment,lag--after payment
 -----
   SELECT NAME,COUNTRY,
   COUNT(*),
   Lead(name) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) asc )
   FROM CUSTOMER_LIST C 
   LEFT JOIN PAYMENT P
   ON C.ID=P.CUSTOMER_ID
   group by name,country
   

   SELECT NAME,COUNTRY,
   COUNT(*),
   Lead(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) asc ),
   Lead(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) asc )-count(*)
   FROM CUSTOMER_LIST C 
 
 LAG
----
   SELECT NAME,COUNTRY,
   COUNT(*),
   lag(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) asc ),
   lag(count(*)) OVER(PARTITION BY COUNTRY ORDER BY COUNT(*) asc )-count(*)
   FROM CUSTOMER_LIST C 
   LEFT JOIN PAYMENT P
   ON C.ID=P.CUSTOMER_ID
   group by name,country

CHALLNEGE
---------
  write a query the returns the revenue of the day and the revenue of the previous day
  afterwards calculate also the percentage growth compared to the previous day

  SELECT 
  SUM(AMOUNT),
  DATE(PAYMENT_DATE),
  LAG(SUM(AMOUNT)) OVER(ORDER BY DATE(payment_date)) AS PAYMENT_PREVIOUS,
  SUM(AMOUNT)-LAG(SUM(AMOUNT)) OVER(ORDER BY DATE(payment_date))AS DIFFERNCE,
  ROUND((SUM(AMOUNT)-LAG(SUM(AMOUNT)) OVER(ORDER BY DATE(payment_date)))
  /
  LAG(SUM(AMOUNT)) OVER(ORDER BY DATE(payment_date))*100,2) AS AVERAGE
  FROM payment group by date(payment_date)
  Ans:
  sum              date       previous_payment  differnce   percentage  
 2760.60	"2020-03-18"	2081.91	        678.69	     32.60
 2546.88	"2020-03-19"	2760.60	       -213.72      -7.74
 2735.60	"2020-03-20"	2546.88	       188.72	     7.41
 2727.54	"2020-03-21"	2735.60	       -8.06	    -0.29
 

--------------------------------------------------------------------------------------------------------------------------------------------------------




















  