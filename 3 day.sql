aggregation function
--------------------
     > aggregate function multiple rows to one value
     > ex get one single values

 Most common aggregate function
 -------------------------------
   sum()
   avg()
   max()
   min()
   count()
 
  syntax
     select sum(amount) from payment;
     select count(*) from payment;
 
ex:
  select sum(amount) from payment;  

MULTIPLE AGGREGATE FUNCTION 
--------------------------
  SELECT SUM(AMOUNT),COUNT(*),AVG(AMOUNT) FROM PAYMENT; 

wrong
-----
  select sum(amount),payment id from payment;
                     ----------
challange
---------
   your manager wants to get a better understanding of the films
   that's why you are asked to write a quaery to see the

   . Minimum
   . Maxmium
   . Averge(rounded)
   . Sum

   Ans:
      select min(replacement_cost),max(replacement_cost),round(avg(replacement_cost),2)as avg,sum(replacement_cost) from film;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

THIS USE TO AGGREGATE MEATHOD 
-----------------------------
GROUP BY
    .USED TO GROUP AGGREGATION BY SPECIFIC COLUMNS
    EX
     SELECT CUSTOMER_ID,SUM(AMOUNT),MAX(AMOUNT) FROM PAYMENT GROUP BY CUSTOMER_ID ORDER BY SUM(AMOUNT) DESC;
     select CUSTOMER_ID,SUM(AMOUNT),MIN(AMOUNT),MAX(AMOUNT),ROUND(AVG(AMOUNT),2) from payment GROUP BY CUSTOMER_ID  ORDER BY CUSTOMER_ID;
     SELECT CUSTOMER_ID,SUM(AMOUNT),MAX(AMOUNT) FROM PAYMENT GROUP BY CUSTOMER_ID ORDER BY SUM(AMOUNT) DESC;
CHALLENGE
  YOUR MANAGER WANTS TO WHICH OF THE TWO EMPLOYESS(STAFF_ID) IS RESPONSIBLE FOR MORE PAYMENTS;
  WHICH OF THE TWO IS RESPONSIBLE FOR A HIGER OVERALL PAYMENT AMOUNT?
  HOW DO THESE AMOUNTS CHANGE IF WE DON'T CONSIDER AMOUNTS EAUAL TO 0?
ANS:
  SELECT STAFF_ID,SUM(AMOUNT),COUNT(AMOUNT) FROM PAYMENT GROUP BY STAFF_ID ORDER BY SUM(AMOUNT) DESC;

  SELECT STAFF_ID,SUM(AMOUNT),COUNT(*) FROM PAYMENT GROUP BY STAFF_ID ORDER BY SUM(AMOUNT) DESC;
  OR
  SELECT STAFF_ID,SUM(AMOUNT),COUNT(AMOUNT) FROM PAYMENT WHERE AMOUNT!=0  GROUP BY STAFF_ID ORDER BY 2 DESC;

MULTIPLE COLUMN IN GROUP BY
---------------------------
 challange
 ---------
     date()---this date function exequate only date only---ex 12.04.2021;

 There are two competitions betweeen the two employees.
 which employee had the highest sales amount in a single day?
 which employee had the most sales in a single day (not counting payments with amount=0)?
  Ans:
    select staff_id,sum(amount),date(payment_date),count(*) from payment where amount!=0 group by staff_id,date(payment_date) order by 2 desc;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
HAVING
    * USED TO FILTER GROUPINGS BY AGGREGATIONS
                     ---------
    *  HAVING COUNT(*)>400 
 NOTES
   HAVING AN ONLY BE USED WITH GROUP BY!.
   where class not allowing aggregate function
  
SYNTAX
    SELECT CUSTOMER_ID,SUM(AMOUNT) FROM PAYMENT GROUP BY CUSTOMER_ID HAVING SUM(AMOUNT)>200;

 EX: 
  SELECT CUSTOMER_ID,DATE(PAYMENT_DATE),ROUND(AVG(AMOUNT),2)AS AVERAGE_AMOUNT,COUNT(*) FROM PAYMENT WHERE PAYMENT_DATE BETWEEN '2020-04-28' AND '2020-04-30 23:59'
  GROUP BY CUSTOMER_ID,DATE(PAYMENT_DATE) HAVING COUNT(*)>1 ORDER BY 3 DESC;

 SELECT CUSTOMER_ID,DATE(PAYMENT_DATE),ROUND(AVG(AMOUNT),2)AS AVERAGE_AMOUNT,COUNT(*) FROM PAYMENT WHERE DATE(PAYMENT_DATE) IN('2020-04-28','2020-04-29','2020-04-30')
 GROUP BY CUSTOMER_ID,DATE(PAYMENT_DATE) HAVING COUNT(*)>1 ORDER BY 3 DESC;

  WHERE PAYMENT_DATE BETWEEN '2020-04-28' AND '2020-04-30 23:59'
  WHERE DATE(PAYMENT_DATE) IN('2020-04-28','2020-04-29','2020-04-30')
    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
resourse
 \i 'F:/New folder/flight_database/flight_database.sql'
  \i 'C:/Users/WIN/Downloads/flight_database/flight_database.sql'
DOUT
---
   REVENUE




  




