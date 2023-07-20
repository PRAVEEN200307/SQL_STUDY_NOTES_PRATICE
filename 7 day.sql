UNION and UNION ALL
-------------------
union--union is remove the duplicate from rows
union all--excuted all the rows 

  combining rows
  combining multiple select statements

RULES
-----
   THE ORDER MATCHES THE COLUMN!
   DATA TYPES MUST MATCH!
   DUPLICATES ARE DECOUPLED

SYNTAX
------
  SELECT first_name,sales FROM vancouver
  union  -----------------------------------------DUPLICATES ARE DECOUPLED
  SELECT first_name,sales FROM DELHI

UNION ALL
---------
  SELECT first_name,sales FROM vancouver
  UNION ALL
  SELECT first_name,sales FROM DELHI

select first_name,'customer' from customer
union
select first_name,'actor'as orgin   from actor
union
select first_name,'staff' from staff 
order by 2 desc 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SUB-QUERIES IN WHERE
-------------------
   select * from payment where amount>(select avg(amount) from payment);
   select * from payment where  customer_id  =(select  customer_id   from customer where first_name='ADAM' );
   select * from payment where  customer_id in (select customer_id from customer where first_name like ('A%'));

CHALLENGE
---------
  1. SELECT ALL OF THE FILMS WHERE THE LENGHT IS LONGER THAN THE AVERAGE OF ALL FILMS.
   ANS:
    SELECT FILM_ID,TITLE FROM FILM WHERE  LENGTH>(SELECT AVG(LENGTH) FROM FILM);
 
  2. RETURN ALL THE FILMS THAT ARE AVALIABLE INVENTARY  IN STORE 2 MORE THEN 3 TIMES
   ANS:
    SELECT FILM_ID,TITLE  FROMN FILM WHERE FILM_ID IN (SELECT FILM_ID FROM INVENTORY WHERE STORE_ID=2 GROUP BY FILM_ID HAVING COUNT(*)>3);
MORE CHALLENGE
--------------
 1.RETURN ALL CUSTOMERS 'FIRST_NAME' AND 'LAST_NAME' THAT HAVE MADE A PAYEMNT ON 2020-01-25
     SELECT FIRST_NAME ,LAST_NAME FROM CUSTOMER WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM PAYMENT WHERE DATE(PAYMENT_DATE)='2020-01-25');

 2.RETURN ALL CUSTOMER FIRST_NAME AND EMAIL ADDRESS THAT HAE SPEND A MORE THAN $30
      SELECT FIRST_NAME,EMAIL FROM CUSTOMER WHERE CUSTOMER_ID  IN (SELECT CUSTOMER_ID FROM PAYMENT GROUP BY CUSTOMER_ID  HAVING SUM(AMOUNT)>30) 

 3.RETURN ALL THE CUSTOMER FIRST_NAME AND LAST NAME THAT ARE FROM CALIFORNIUA AND HAVE SPEND MORE THAN 100 IN TOTAL

     select first_name,last_name from customer where customer_id in 
    (select customer_id from payment group by customer_id having sum(amount)>100)
    and customer_id in  (select customer_id from customer c inner join  address a on c.address_id=a.address_id where district='California')
  or
   select first_name,last_name from customer where customer_id in 
   (select customer_id  from payment
   where customer_id in (SELECT customer_id FROM ADDRESS A INNER JOIN CUSTOMER C ON A.ADDRESS_ID=C.ADDRESS_ID  WHERE DISTRICT='California')
   group by customer_id having sum(amount)>100)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SUB-QUERIES IN FROM 
-------------------
   select ROUND(avg(total_amount),2) AS AVG_LIFE_TIME_AMOUNT
   FROM
   (select customer_id,sum(amount) as total_amount from payment
    group by customer_id) AS SUBQUERY

CHALLENGE
---------
 1. WHAT IS THE AVERAGE TOTAL AMOUNT SPEND PER DAY (AVERAGE DAILY REVENUE)?
    ANS:
     SELECT ROUND(AVG(TOTAL_AMOUNT),2) AS AVG_DIALY_REVENUE FROM  
     SELECT DATE(PAYMENT_DATE),SUM(AMOUNT) AS TOTAL_AMOUNT FROM PAYMENT GROUP BY DATE(PAYMENT_DATE) AS PER_DAY

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SUB_QUERIES IN SELECT
---------------------
    SELECT * ,(SELECT AVG(AMOUNT) FROM PAYMENT) FROM PAYMENT;
    SELECT * ,(SELECT AMOUNT FROM PAYMENT LIMIT 1) FROM PAYMENT;
CHALLENGE
---------
 SHOW ALL THE PAYMENT TOGETHER WITH HOW MUCH  THE PAYMENT AMOUNT IS BELOW THE MAXIMUM PAYMEN AMOUNT.
   SELECT *,(SELECT MAX(AMOUNT) FROM PAYMENT)-AMOUNT FROM PAYMENT;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CORRELATED SUBQUERIES IN WHERE
------------------------------
 >subquery does not work independently 
 >subquery gets evaluated for every single row!

 >correlated subquery in where
 >show only those payments that have the
 >highest amount per customer.

  select * from payment p1 where amount =
  (select max(amount) from payment p2 where p1.customer_id=p2.customer_id)
  order by customer_id;

CHALLENGE
---------
  SHOW ONLY THOSE MOVIE TITLES,THEIR ASSOCIATED FILM_ID AND AND REPLACEMENT_COST WITH THE LOWEST REPLACEMENT_COSTS FOR IN EACH RATING CATEGORY - ALSO SHOW THE RATING
   SELECT FILM_ID,TITLE,REPLACEMENT_COST,RATING FROM FILM F1 WHERE 
   REPLACEMENT_COST = (SELECT MIN(REPLACEMENT_COST) FROM FILM F2 WHERE F1.RATING=F2.RATING) 

  SHOW ONLY THOSE MOVIE TITLE,THEIR ASSOCIATED FILM_ID AND THE LENGHT THAT HACE THE HIGHEST LENGRH IN EACH RATING CATEGORY - ALSO HSOW THE RATING
    SELECT TITLE,FILM_id,length,rating from film f1 where length=
    (select MAX(length) from film f2 where f1.RATING=f2.RATING)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CORRELATED SUBQUERIES
---------------------
   SELECT FIRST_NAME,SALES,
   (SELECT MIN(SALES) FROM EMPLOYEES E3 WHERE E1.CITY=E3.CITY )
   FROM EMPLOYEES E1
   WHERE SALES>
       (SELECT AVG(SALES) FROM EMPLOYEES E2 WHERE E1.CITY=E2.CITY)

---------------------------------------------------------------------------------------------
MORE CHALLENGE
--------------  
 1. SHOW ALL THE PAYMENT PLUS THE TOTAL AMOUNT FOR EVERY CUSTOMER AS WELL ASTHE NUMER OF PAYMENT OF EACH CUSTOMER

     SELECT *,(SELECT SUM(AMOUNT) FROM PAYMENT P2 WHERE P1.CUSTOMER_ID=P2.CUSTOMER_ID),
     (SELECT COUNT(AMOUNT) FROM PAYMENT P3 WHERE P3.CUSTOMER_ID=P1.CUSTOMER_ID)
     FROM PAYMENT P1 ORDER BY CUSTOMER_ID;
   
2. SHOW ONLY THOWE FILMS WITH THE HIGHEST REPLACEMNET COSTS IN THEIR RATING CATEGORY PLUS SHOW THE AVERAGE REPLACEMNT COST IN THEIR RATING CATEGORY
   
     SELECT TITLE,REPLACEMENT_COST,RATING,(SELECT AVG(REPLACEMENT_COST) FROM FILM F3  WHERE F3.RATING=F1.RATING) FROM FILM F1
     WHERE REPLACEMENT_COST=
     (SELECT MAX(REPLACEMENT_COST) FROM FILM F2 WHERE F1.RATING=F2.RATING )  

3.  SHOW ONLY THOSE PAYMENTS WITH THE HIGHREST PAYMENT FOR EACH CUSTOMER'S FIRST NAME-INCLUDING THE PAYMENT_ID OF THE PAYMENT.
     HOW WOULD UOU SOLVE IT IF YOU WOULD NOT NEED TO SEE THE PAYMENT_ID
     
     SELECT FIRST_NAME,AMOUNT,PAYMENT_ID FROM PAYMENT P INNER JOIN CUSTOMER C ON P.CUSTOMER_ID=C.CUSTOMER_ID WHERE AMOUNT=
     (SELECT MAX(AMOUNT) FROM PAYMENT P1 WHERE P1.CUSTOMER_ID=P.CUSTOMER_ID )

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





