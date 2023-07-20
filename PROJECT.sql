1.
QUESTION 1
LEVEL: SIMPLE
TOPIC:DISTINCT
TASK:CREATE A LIST OF ALL THE DIFFERENT(DISTINCT)
REPALCEMENT COSTS OF THE FILMS

select distinct replacement_cost as lowest_replacement_cost from film order by lowest_replacement_cost asc limit 1;
answer:9.99
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
2.
 LEVEL:MODERATE
 TOPIC:CASE+GROUP BY
 TASK: WRITE A QUERY THAT GIVES AN OVERVIEW OF HOW MANY FILMS HAVE REPLACEMENTS COSTS IN THE FOLLOWINGWS
  COST RANGES
  
  1.LOW :9.99-19.99
  2.medium:20.00-24.99
  3.high :25.00-29.99

question: How many films have a repalcement cost in the 'low' group?

select 
case 
  when replacement_cost between 9.99 and 19.99 then 'low replacement cost'
  when replacement_cost between 20.00 and 24.99 then 'medium'
  when replacement_cost between 25.00 and 29.99 then 'high'
end as overview_replacement_cost,count(*)
from film group by overview_replacement_cost 

answer:514

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
question 3:

level:Moderate
Topic:join
Task: create a lsit of the film titles including their title ,length, 
and category name ordered descendingly by length.filter the results to only the movies inthe category 'Drama' or 'sports'.

3.
SELECT title,length,name FROM FILM F INNER JOIN FILM_CATEGORY FC ON F.FILM_ID=FC.FILM_ID INNER JOIN CATEGORY CA ON FC.CATEGORY_ID=CA.CATEGORY_ID
WHERE NAME IN ('Drama','Sports')  order by 2 desc

"SMOOCHY CONTROL"	184	"Sports"
"RECORDS ZORRO"	       182	"Sports"
---------------------------------------------------------------------------------------------------------------------------------------------------------------
4.
level:Moderate
topic:join& group by
task:create an overview of the how many movies (title) there are in each category(name)


SELECT name,count(title)||' titles' FROM FILM F INNER JOIN FILM_CATEGORY FC ON F.FILM_ID=FC.FILM_ID INNER JOIN CATEGORY CA ON FC.CATEGORY_ID=CA.CATEGORY_ID
group by name order by 2 desc;

"Sports"	"74 titles"
"Foreign"	"73 titles"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
5.
level:Moderate
topic:join& group by  
task: Create an overview of the acotors first and last names and in how many movies they appear in.

select first_name,last_name,count(title)  as movie from actor a inner join film_actor fc on a.actor_id=fc.actor_id inner join film f on
f.film_id=fc.film_id group by first_name,last_name order by 3 desc
 
   "SUSAN"	"DAVIS"	        54
    "GINA"	"DEGENERES"	42
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
6.
level:moderate
topic:left join & filtering
task:Create an overview of the addresses that are not associated to any customer.

SELECT COUNT(*) FROM ADDRESS LEFT JOIN CUSTOMER ON CUSTOMER.ADDRESS_ID=ADDRESS.ADDRESS_ID WHERE CUSTOMER_ID IS NULL
answer:4
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
7.
level:Moderate
topic:join & group by 
task:create an overview of the cites and how much sales(sum of amount)have occurred there.
Question:Which city has the most sales?
Answer :Cape coral with a total amount of 221.55

select city,sum(amount) from city inner join address 
on city.city_id=address.city_id 
inner join customer 
on customer.address_id=address.address_id
inner join payment
on customer.customer_id=payment.customer_id group by city order by 2 desc
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

8.select * from city;--city_id,country_id;
select * from  country;--country_id
select  * from payment;--payment_id,customer_id,rental_id,staff_id
select * from address;--address_id,city_id
select * from customer;--customer_id,store_id,address_id

Level:moderate to diffcult
topic:join & group by
task:create an overview of the revenue(sum of
amount) grouuped by a column inthe format "country,city"

Question:Which country,city has the last sales?

select country,city,sum(amount) from city inner join country on city.country_id=country.country_id inner join address on city.city_id=address.city_id
inner join customer on address.address_id=customer.address_id inner join payment on customer.customer_id=payment.customer_id
group by country,city order by 3 asc;

"United States"	"Tallahassee"	50.85
"China"	"Fuzhou"	50.86

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
9.level:Difficult
Topic:Uncorrelated subquery
task:create a list with the average of the sales amount each staff_id has per customer

SELECT STAFF_ID,AVG(TOTAL) FROM 
(SELECT STAFF_ID,CUSTOMER_ID,SUM(AMOUNT) AS TOTAL FROM PAYMENT GROUP BY STAFF_ID,CUSTOMER_ID) AS A GROUP BY STAFF_ID

2	56.6394657762938230
1	55.9089649415692821
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
10.
  level:Difficult to very difficult
  Topic:Extract +Uncorrelated subquery
  task:Create a query that show average daily revenue of all sunday

SELECT ROUND(AVG(TOTAL),2) FROM
(SELECT DATE(PAYMENT_DATE),EXTRACT(DOW FROM PAYMENT_DATE),SUM(AMOUNT) AS TOTAL FROM PAYMENT WHERE EXTRACT(DOW FROM PAYMENT_DATE)=0
GROUP BY DATE(PAYMENT_DATE),EXTRACT(DOW FROM PAYMENT_DATE)) AS A

answer: staff_id 2 with average revenue of 56.64 per customer
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

11.
  level:Difficult to very difficult
  Topic:Correlated subquery
  Task: Create a list of movies- with their length and their replacement cost - that are longer than the average
  length in each replacemnt cost grouup
  
  Question:Which two movies are the shortest on tha list and how long are they?

SELECT TITLE,LENGTH FROM FILM F1 WHERE LENGTH>
(SELECT AVG(LENGTH) FROM FILM F2 WHERE F1.REPLACEMENT_COST=F2.REPLACEMENT_COST) ORDER BY 2 ASC

"CELEBRITY HORN"	110
"SEATTLE EXPECATIONS"	110
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
12.
 level:very diffiult
  topic: Uncorrelated subquery 
  task: create a list that show the "average customer lifetime value" grouped by the different districts

  Question:Which district has the highest average customer lifetime value?

select district,avg(total_amount) from
(select customer.customer_id,district,sum(amount)as total_amount from customer inner join payment on customer.customer_id=payment.customer_id inner join address on 
address.address_id=customer.address_id group by district,customer.customer_id order by 2 ) as A group by district order by 2 desc

answer:Saint-Denis withan average customer lifetime values of 216.54
-----------------------------------------------------------------------------------------------------------------------------------------------
13. 
 level:Very difficult
 Topic:Uncorrelated subquery  
 Task:Create a list that shows all payment including the payment_id,amount, and the film category(name) plus the total amount  that was made in this category.
  Order the result ascendingly by the category(name) and  as secound order criterion by the payment_id ascendingly
  
Question : which is the total revenue of the category "Action" and what is the lowest payment_id in that category 'Action'?

Answer : Total averge in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055.


SELECT * FROM RENTAL;--RENTAL_ID,INVENTORY_ID,CUSTOMER_ID,STAFF_ID
SELECT * FROM INVENTORY;--INVENTORY_ID,FILM_ID,STORE_ID
SELECT * FROM FILM;---FILM_ID
SELECT * FROM FILM_CATEGORY;--FILM_ID,CATEGORY_ID
SELECT * FROM CATEGORY;--CATEGORY_ID,NAME
SELECT * FROM PAYMENT;--PAYMENT_ID,CUSTOMER_ID,STAFF_ID,RENTAL_ID;


SELECT
TITLE,
AMOUNT,
NAME,
PAYMENT_ID,
(SELECT SUM(AMOUNT) FROM PAYMENT P
LEFT JOIN RENTAL R
ON R.RENTAL_ID=P.RENTAL_ID
LEFT JOIN INVENTORY I
ON I.INVENTORY_ID=R.INVENTORY_ID
LEFT JOIN  FILM F
ON F.FILM_ID=I.FILM_ID
LEFT JOIN FILM_CATEGORY FC
ON FC.FILM_ID=F.FILM_ID
LEFT JOIN CATEGORY CI
ON CI.CATEGORY_ID=FC.CATEGORY_ID
WHERE CI.NAME=C.NAME)
FROM PAYMENT P
LEFT JOIN RENTAL R
ON R.RENTAL_ID=P.RENTAL_ID
LEFT JOIN INVENTORY I
ON I.INVENTORY_ID=R.INVENTORY_ID
LEFT JOIN FILM F
ON F.FILM_ID=I.FILM_ID
LEFT JOIN FILM_CATEGORY FC
ON FC.FILM_ID=F.FILM_ID
LEFT JOIN CATEGORY C
ON C.CATEGORY_ID=FC.CATEGORY_ID
ORDER BY NAME,PAYMENT_ID ASC 


---------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from payment;--payment_id,customer_id,staff_id,rental_id
select * from category;--category_id,name
select * from film_category;--film_id,category_id
select * from inventory;--inventory_id,film_id,store_id;
select * from rental;--rental_id,inventory_id,customer_id


select * from film;--film_id,lanuage_id
select * from customer;--customer_id,store_id,adddress_id
select * from staff;--staff_id,address_id;
select * from store;--store_id,address_id


14.
 CREATE A LIST WITH THE TOP OVERALL REVENUE OF A FILM TITLE (SUM OF AMOUNT PER TITLE) FOR EACH CATEGORY(NAME)
 QUESTION: WHICH IS THE TOP-PERFORMING FILM IN THE ANIMATION CATEGORY?

   ANSWER :  DOGMA FAMILY WITH 178.70

  SELECT
  TITLE,
  SUM(AMOUNT),
  NAME
  FROM PAYMENT P
  LEFT JOIN RENTAL R
  ON R.RENTAL_ID=P.RENTAL_ID
  LEFT JOIN INVENTORY I
  ON I.INVENTORY_ID=R.INVENTORY_ID
  LEFT JOIN FILM F
  ON F.FILM_ID=I.FILM_ID
  LEFT JOIN FILM_CATEGORY FC
  ON FC.FILM_ID=F.FILM_ID
  LEFT JOIN CATEGORY C
  ON C.CATEGORY_ID=FC.CATEGORY_ID
  GROUP BY TITLE,NAME ORDER BY 2 DESC

---------------------------------------------------------------------------------------------------------------------------------------------------------------------










