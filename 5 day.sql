 MATHEMATICAL FUNCTION AND OPERATORS
------------------------------------
 +     addition                                            4+3=7
 -     subtraction                                         5-2=3
 *     multiplication                                      4*2=8
 /     division (integer division truncates the result)    8/4=2
 %     modulo                                              10%4=2
 ^     exponentiation                                       2^3=8

synax
-----
   sum(replacement_cost)*2
   sum(replacement_cost)+1
   sum(replacement_cost)/sum(rental_rate)*100

function          description                   example          result
abs(x)            absolut value                  abs(-7)           7
round(x,d)        round x to d decimal places    round(4.3543)     4.35
ceiling(x)        round up to integer            ceiling(4.3543)   5
floor(x)          round down to integer          floor(4.3543)     4

EXAMPLE
-------
   SELECT 9.0/4;
   select film_id,rental_rate as old_rental_rate,rental_rate+1 as new_renal_rate  from film;
   SELECT FILM_ID,ROUND(rental_rate*1.1,2) as new_renal_rate FROM FILM;
   SELECT FILM_ID,Rental_rate*1.1,CEILING(rental_rate*1.1) as CEILING FROM FILM;
   SELECT FILM_ID,Rental_rate*1.1,FLOOR(rental_rate*1.1) as FLOOR FROM FILM;

challenge
    your manager is thinking about increasing the prices for  films that are more expensive to replace
    that are more expensive to replace.
    for that reason,you should create a list of the films including the relation of rental rate/replacement cost where the rental rate is less than
    4% of the replacement cost
    create a list of that film_ids together with the percentage rounded to 2 decimal places. for example 3.54=(3.54%).
   ANS
     select film_id,round(rental_rate/replacement_cost*100,2) as percentage from film where round(rental_rate/replacement_cost*100,2)<4
     order by 2 asc;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CASE& WHEN
----------
  like if/then statement
 goes through a set of conditions returns a value if a condition is met

syntax
------
   case
   when condition1 then result1
   when condition2 then reuslt2
   when condition3 then result3
   else result
   end
   -------------- 
   select amount,
   case 
   when amount<2 then 'low amount'
   when amount<5 then  'medium amount'
   else 'high amount'
   end
   ----------------
   select
   to_char(book_date,'Dy'),
   to_char(book_date,'Mon'),
   case
   when to_char(book_date,'Dy')='Mon' then 'monday special'
   when to_char(bookA_date,'Mon')='july' then 'july special'
   else 'no special to all'
   end from booking
  ------------------------------
 select 
 case
    when actual_departure-scheduled_departure is null then 'no departure time'
    when actual_departure-scheduled_departure<'00:05' then 'on time'
    when actual_departure-scheduled_departure<'01:00' then 'little bit late'
    else ' very late'
 end as it_late, 
 count(*) from flights group by it_late;
-------------------------------------------------------------------------------------------
challenge
----------
1.you need to find out how many tickets you hace sold in the following cetefories
  .low price ticket:total_amount<20,000
  .mid price ticket : total_amount between 20,000 and 150,000
  . high price ticket total_amount>=150,000
ANS:
 select
   case 
     when total_amount<'20000' then 'low price ticket'
     when total_amount between 20000 and 150000 then 'mid price ticket'
     when total_amount>='150000'  then 'high price ticket' 
   end as ticket,count(*) from bookings group by ticket


2. you  need to find out how many flights hace departed in the following seasons:
   . winter   December,january,februr
   .spring    March,April,May
   .Summer    june,july,Augest
   .Fall      September,Ocotober,November
ANS:

SELECT 
CASE
 WHEN EXTRACT(MONTH from SCHEDULED_DEPARTURE) IN (1,2,12) THEN 'WINTER'
 WHEN EXTRACT(MONTH from SCHEDULED_DEPARTURE) IN  (3,4,5) THEN 'SPRING'
 WHEN EXTRACT(MONTH from SCHEDULED_DEPARTURE) IN  (6,7,8) THEN 'SUMMER'
 ELSE 'FALL'
END AS SEASON,COUNT(*)
 FROM FLIGHTS GROUP BY SEASON;

3.you want to create a tier list in the following way.
  1. Rating  is Pg or 'PG-13' or length is more then 210 min:
     greate rating or long(tier 1)
  2. Description contain 'Drama' and length is more than 90 min:
     'Long drama(tier 2)'
  3. Description contain 'Drama' and length is not more than 90 min:
     'Short drama (tier 3)'
  4. Rental_rate less then $1:
     'Very cheap (tier 4)'
     if,one movie can be in multiple categories it gets the higher tier assigned.

 ANS:
SELECT title,
 CASE
  WHEN RATING='PG'OR RATING='PG-13' OR LENGTH>210  THEN 'GREAT RATING OR LONG (TIER 1)'
  WHEN DESCRIPTION LIKE ('%Drama%')and length>90 then 'Long drama (tier 2)'
  WHEN DESCRIPTION LIKE ('%Drama%') AND LENGTH<90 THEN 'SHORT drama (tier 3)'
  when rental_rate<1 then 'VERY CHEAP' 
END as review
FROM FILM where CASE
  WHEN RATING='PG'OR RATING='PG-13' OR LENGTH>210  THEN 'GREAT RATING OR LONG (TIER 1)'
  WHEN DESCRIPTION LIKE ('%Drama%')and length>90 then 'Long drama (tier 2)'
  WHEN DESCRIPTION LIKE ('%Drama%') AND LENGTH<90 THEN 'SHORT drama (tier 3)'
  when rental_rate<1 then 'very cheap' 
END  is not null ;
---------------------------------------------------------------------------------------------------
select rating,count(*) from film group by rating;
select sum(
case
  when rating in ('PG','G') then 1 else 0
end 
)AS COUNTING_THE_PG,G from film;

select 
 SUM(CASE when rating in ('PG') THEN 1 ELSE 0 END) AS "PG",
 SUM(CASE when rating in ('G') THEN 1 ELSE 0 END) AS "G",
 SUM(CASE when  rating in ('NC-17') THEN 1 ELSE 0 END) AS "NC-17",
 SUM(CASE when  rating in ('PG-13') THEN 1 ELSE 0 END) AS "PG-13",
 SUM(CASE when  rating in ('R') THEN 1 ELSE 0 END) AS "R"
from film;
------------------------------------------------------------------------------------------------------------------------------------
COALESCE
---------
   ^ return first value of a list of values which is not null
  example
  SELECT ACTUAL_ARRIVAL-SCHEDULED_ARRIVAL,coalesce(ACTUAL_ARRIVAL-SCHEDULED_ARRIVAL,'0:00') FROM FLIGHTS;

CAST
----
 >CHANGES THE DATE TYPE OF A VALUE

SYNTAX
  CAST (VALUE/COLUMN AS data type)
  CAST (SCHEDULED_ARRIVAL AS varchar)
  SELECT ACTUAL_ARRIVAL-SCHEDULED_ARRIVAL,coalesce(CAST(ACTUAL_ARRIVAL-SCHEDULED_ARRIVAL AS VARCHAR),'NOT ARRIVED') FROM FLIGHTS;
  select rental_date,coalesce(cast(return_date as varchar),'not arrived') from rental order by return_date desc;
-----------------------------------------------------------8:19 PM 5/26/2023--------------------------------------------------------------------------------------------------------
REPLACE
-------
 > REPALCES TEXT FROM A STRING IN A COLUMN WITH ANOTHER TEXT
REPLACE
  REPLACE(COLUMN,OLD_TEXT,NEW_TEXT);
  REPLACE(FLIGHT_NO,'PG','FL');
EXAMPLE
  SELECT CAST(REPLACE(PASSENGER_ID,' ','') AS BIGINT) FROM TICKETS;
  SELECT CAST(REPLACE(FLIGHT_NO,'PG','')AS BIGINT) FROM FLIGHTS;



