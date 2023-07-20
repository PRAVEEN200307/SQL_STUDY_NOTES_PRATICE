select
------

 select 
 * 
 from
 actor;                                                                                                                                                                                                select * from actor;  
select first_name,last_name from actor;
select address,district from address;
select first_name,last_name,email from customer;
-----------------------------------------------------------------
order by
--------
   used to order results based on columns
   alphabetically ,numerically,chronologically etc....
     text		    NUMBER	    date or time

ORDER BY
    SYNTAX
       SELECT COLUMN_NAME FROM TABLE_NAME ORDER BY COLUMN_NAME ASC/DESC;
       ASC-->ascending a defult 
    EXAMPLE
       select first_name,last_name,email from customer ORDER BY LAST_NAME DESC;
       SELECT * FROM CUSTOMER ORDER BY LAST_NAME DESC;
       select * from payment order by customer_id,amount desc;
      
     USING NUMBER--TO ORDER THE TABLE
      select first_name,last_name,email
      from customer order by 2 desc,1 desc;
---------------------------------------------------------------
DISTINCT
     remove the dupulicat values
     SELECT DISTINCT COLUMN_NAME FROM TABLE_NAME;

     select first_name  from actor ;---200 member

     after using distinct keyword
    -----------------------------
   
     select distinct first_name from actor;---128
	
     select distinct rating from film; 
            "R"
            "PG"
            "NC-17"
            "PG-13"
            "G"
     select distinct rental_duration from film
    
pratice session
   select distinct amount from payment order by amount desc;
--------------------------------------------------------------------------------------
limit
-----
    limit keyword used to limit the number of rows in the output  
    always very end of the quary

   syntax
      select column_name1,column_name2 from table_name limit n;
-----------------------------------------------------------------------------------------------
count
-----    
 used to count number of rows in a output
    used to often in combination with grouping & filtering
    like to example grouping

    notes
      null won't be counted in that case
syntax
   select count(*) from table_name
    select count(column_name) from table_name
example
   select count(first_name) from actor;
   select count(distinct first_name) from actor;
   select count( distinct first_name) from customer;--591
   select count (distinct last_name) from customer;--599
   select * from actor;--- count the row
-----------------------------------------------------------------------------------------------------------------------------------------------
today summery
-------------
   
 what is sql
    sql=structuer quary lanuage
     intract the databases
 -------------------------------
 why learn sql
    date is everywhere and mostly in databases
 may be most important skill
   * data analyst
   * data science
   * bussiness analyst
   
 learn sql is east & intuitive
-----------------------------------------------
 what is databases
    database store in a structure  table  format


-----------------------------------------------------------------------------------------------------------------------------------------------------

   