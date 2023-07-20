what are joins? 
   combine information from multiple tables in one query

INNER JOIN
OUTER JOIN
LEFT  JOIN
RIGHT JOIN

VERY IMPORTANT TECHNIQUE IN SQL

INNER JOIN
---------
   INNER JOIN:ONLY ROWS APPEAR IN BOTH TABLES
   ONLY THE ROWS WHERE THE VALUE IN THE JOIN COLUMN OCCURS IN BOTH TABLES
   INNER JOIN: ONLY ROWS WHERE REFERENCE COLUMN VALUES IS IN BOTH TABLE

   
SYNTAX
-----
  SELECT * FROM TABLE_A INNER JOIN TABLE_B ON TABLE_A.EMPLOYEE= TABLE_B.EMPLOYEE
  USING ALLIAS MAKE TO EASY TO WRITE A CODE
  
 SELECT PA.CUSTOMER_ID,PAYMENT_ID,AMOUNT,FIRST_NAME,LAST_NAME 
 FROM PAYMENT PA INNER JOIN CUSTOMER CU ON PA.CUSTOMER_ID=CU.CUSTOMER_ID;

 SELECT TIC.FARE_CONDITIONS,COUNT(*) FROM TICKET_FLIGHTS TIC INNER JOIN BOARDING_PASSES BO ON TIC.TICKET_NO=BO.TICKET_NO
 GROUP BY TIC.FARE_CONDITIONS;

 select fare_conditions,count(*) from seats s inner join boarding_passes b 
 on s.seat_no=b.seat_no group by fare_conditions  

 SQL Inner Join is a type of join that is used to combine records from two related tables, based on the common columns
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

FULL OUTER JOIN
---------------
   EXECUTED ALL OF THE ROWS FROM TABLE
SYNTAX
  SELECT * FROM tableA FULL OUTER JOIN taleB on tableA.employee =  tableB.employee

Challenge
  Find the ticket that don't have a boarding pass related to it!
      SELECT count(*) FROM BOARDING_PASSES B FULL OUTER JOIN TICKETS T ON B.TICKET_NO=T.TICKET_NO
      WHERE T.TICKET_NO IS NUL
---------------------------------------------------------------------------------------------------------------------------------------------------
LEFT OUTER JOIN
---------
    all of the rows  from table A
  syntax
  ------
    select * from tableA left outer join tableB on tableA.employee = tableB.employee
 example
     select * from aircrafts_data A left outer join flights f on A.aircraft_code =f.aircraft_code
     where f.flight_id is null

   CHALLENGE
   --------
  1.THE FLIGHT COMPANY IS TRYING TO FIND OUT WHAT THEIR MOST POPULAR SEATS ARE
   TRY TO FIND OUT WHICH SEAT HAS BEEN CHOSEN MOST FREQUENTLY MAKE SURE ALL SEATS ARE INCLUDED EVEN IF THEY HAVE NEVER BEEN BOOKED
   ARE THERE SEATS THAT HAVE NEVER BEEN BOOKED ?
  ANS:
  SELECT s.seat_no,count(*) from seats s left join boarding_passes b on s.seat_no=b.seat_no
  group by s.seat_no order by count(*) desc

 2.TRY TO FIND OUT WHICH LINE (A,B,...H) HAS BEEN CHOSEN MOST FREQUENTLY?
   ANS:
  SELECT RIGHT(S.SEAT_NO,1),COUNT(*) FROM SEATS S LEFT JOIN BOARDING_PASSES B ON S.SEAT_NO=B.SEAT_NO
  GROUP BY RIGHT(S.SEAT_NO,1) ORDER BY COUNT(*) DESC
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RIGHT OUTER JOIN
----------------
 RIGHT OUTER JOIN IS EXCUTED THE ALL THE ROW FROM RIGHT TABLE INLUCDE INNNER JOIN

CHALLENGE
   THE COMPANY WANT TO RUN A PHONE CALL COM PAINPAING ON ALL CUSTOMERS IN TEXAS(=DISTRICT)
   WHAT ARE THE CUSTOMERS (FIRST_NAME,LAST_NAME,PHONE NUMBER,DISTRICT) FROM TEXAS?
   ARE THERE ANY (OLD) ADDRESS THAT ARE NOT RELATED TO ANY CUSTOMER?
ANS
  SELECT C.FIRST_NAME,C.LAST_NAME,A.PHONE_NUBER,A.DISTRICT FROM CUSTOMER C INNER JOIN ADDRESS A ON C.ADDRESS_ID=A.ADDRESS_ID WHERE A.ADDRESS='TEXAS'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
JOIN ON MULTIPLE CONDITION
------------------------------
   SYNTAX
------------
   SELECT * FROM TABLEA INNER JOIN TABLEB ON TICKET_ID=TICKE_IDT AND FLIGHT_ID=FLIGHT_ID ;
    AND -----IS MORE EASY TO GET THE ANSWER QUICKLY

 CHALLENGE
   FIND THE AVERGE AMONT OF SEATS
      select b.seat_no,sum(amount) from ticket_flights t inner join boarding_passes b on t.ticket_no=b.ticket_no and t.flight_id=b.flight_id
      group by b.seat_no order by 2 desc;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
JOINNING MULTIPLE TABLES
------------------------
    
 CHALLENGE
    THE COMPANY WANT CUSTOMIZE THERI COMPAIGN THEIR COMPAIGNS TO CUSTOMERS DEPENDINF ON THE COUNTRY THEY ARE FROM 
    WHICN CUSTOMER ARE FROM BRAZIL
    WRITE A QUERY TO GET FIRST_NAME,LAST_NAME,EMAIL AND THE COUNTRY FROM ALL CUSTOMER FROM BRAZIL
 ans
   select first_name,last_name,email,country from customer c inner join address a on c.address_id=a.address_id inner join city ci
   on a.city_id=ci.city_id inner join country co on co.country_id=ci.country_id where country='Brazil' ; 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MORE CHALLENGE
--------------
  WHICH PASSENGER (PASSENGER_NAME) HAS SPEND MOST AMOUNT IN THEIR BOOKINGS (TOTAL_AMOUNT)?
 
   select passenger_name,sum(total_amount) from tickets  left join bookings  on tickets.book_ref=bookings.book_ref 
   group by passenger_name  order by sum(total_amount) desc;
   ANS : ALEKSANDR IVANOV	    80964000.00

  WHICH FARE_CONTION HAS ALEKSANDR IVANOV USED THE MOST ?

  SELECT T.PASSENGER_NAME,TF.FARE_CONDITIONS,COUNT(*)  FROM TICKETS T INNER JOIN TICKET_FLIGHTS TF ON T.TICKET_NO=TF.TICKET_NO
  WHERE T.PASSENGER_NAME='ALEKSANDR IVANOV' GROUP BY T.PASSENGER_NAME,TF.FARE_CONDITIONS ORDER BY COUNT(*) DESC ;
 '"ALEKSANDR IVANOV"	"Economy"	2131'

  WHICH TITLE HAS GEORGE LINTON RENTED THE MOST OFTEN?

      SELECT * FROM CUSTOMER;--CUS_ID,STO_ID
      SELECT * FROM RENTAL;--RENTAL_ID,INVENTARY_ID,CUSTOMER_ID,STAFF_ID
      SELECT * FROM FILM; ---FILM_ID,
      SELECT * FROM INVENTORY;--FILM_ID,STORE_ID,INVENTORY_ID


      SELECT FIRST_NAME,LAST_NAME,TITLE,COUNT(*) FROM CUSTOMER C INNER JOIN RENTAL R ON C.CUSTOMER_ID=R.CUSTOMER_ID 
      INNER JOIN INVENTORY I ON   R.INVENTORY_ID=I.INVENTORY_ID
      INNER JOIN FILM F ON F.FILM_ID=I.FILM_ID WHERE FIRST_NAME='GEORGE'  GROUP BY FIRST_NAME,LAST_NAME,TITLE ORDER BY 4 DESC LIMIT 1;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------




 




   





