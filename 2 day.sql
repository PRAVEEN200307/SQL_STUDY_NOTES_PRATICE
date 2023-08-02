										    second day
    									          -----------

  WHERE
  -----	
   where class is used filter the data in the output
   always after from

   syntax
     select column_name1,column_name2 from table_name where condition;
      	
  ex
   select * from actor where first_name='ADAM';

 challege
   
   how many payment were made by the customer with customer_id=100
   
     select count(*) from payment where customer_id=100   
     --24--
   
   what is lastname of our customer with first_name='ERICA'
   
    select first_name,last_name from customer where first_name='ERICA'
    "ERICA"	"MATTHEWS"

   SELECT * FROM PAYMENT  WHERE AMOUNT>10.99;
   SELECT * FROM PAYMENT WHERE AMOUNT<10.99;
   SELECT * FROM PAYMENT WHERE AMOUNT<10.99 ORDER BY AMOUNT DESC;

   CONDITION
     <=,
     >=,
    != OR <>B ---BOTH ARE SAME
    IS NULL
    IS NOT NULL
  
    SELECT FIRST_NAME,LAST_NAME FROM CUSTOMER WHERE FIRST_NAME IS NULL;
                                                                         ----> THIS IS HELP TO FIND THE NULL COLUMN
    SELECT FIRST_NAME,LAST_NAME FROM CUSTOMER WHERE FIRST_NAME IS NOT NULL;

    question
       the inventary manager asks you who rentals have not been returned yet(return_date is null)

          SELECT COUNT(*)FROM RENTAL WHERE RETURN_DATE IS NULL; --183--

      the sales manager ask you how for a list of all the payment_ids with an amount less than equal to 2 include payment_id and the amount
      
         select payment_id,amount from payment where amount<=2;

------------------------------------------------------------------------------------------------------------------------------------------------------------------ 
AND/OR

   ^ USED TO CONNECT TWO CONDITION
   
   SYNTAX
       SELECT COLUMN_NAME1,COLUMN_NAME2 FROM TABLE_NAME WHERE CONTION1 AND CONTION2;
   
   EX:
     SELECT * FROM PAYMENT WHERE AMOUNT=10.99 AND CUSTOMER_ID=426;
     SELECT * FROM PAYMENT WHERE AMOUNT<10 and amount>5;

     SELECT * FROM PAYMENT WHERE AMOUNT=10.99 OR AMOUNT=9.99 ORDER BY AMOUNT DESC ;----OR OPERATOR USED TO EXCUTING TWO CONTION SAME TIME BUT IT IS TRUE
     SELECT * FROM PAYMENT WHERE AMOUNT=10.99 OR 9.99

    SELECT * FROM PAYMENT WHERE (AMOUNT<=10.99 AND AMOUNT>=9.99) AND CUSTOMER_ID=426;
    SELECT * FROM PAYMENT WHERE (AMOUNT=10.99 OR AMOUNT=9.99) AND CUSTOMER_ID=426;
    SELECT * FROM PAYMENT WHERE (CUSTOMER_ID=322 OR CUSTOMER_ID=346 OR CUSTOMER_ID=354) AND (AMOUNT>10 OR AMOUNT<2)
    ORDER BY CUSTOMER_ID ASC,AMOUNT DESC
    SELECT * FROM PAYMENT WHERE (AMOUNT=2.99 OR AMOUNT=3.99) AND CUSTOMER_ID=288

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

between--- and
    select * from payment where payment_id>=17000 and payment_id<=18000;
    select * from payment where payment_id between 17000 and 18000;
    select payment_id,payment_date,amount from payment where amount between 1.99 and 6.99 order by amount desc;
    select * from actor where actor_id between 1 and 5;
    


   select payment_id,payment_date,amount from payment where amount between 1.99 and 6.99 order by amount desc;
   NOT BETWEEN
  ------------
     select payment_id,payment_date,amount from payment where amount not between  1.99 and 6.99 order by amount desc;
   
    yyyy-mm-dd
    -----------
    select payment_id,amount from payment where payment_date between '2020-01-24' and '2020-01-26';

challenge
--------
  they have been some fault payments and you need to help to found out how many payments have been afftected.
  how many payments have been been made on january 26th and 27th 2020 with an amount between 1.99 and 3.99 


 select count(*) from payment where amount between 1.99 and 3.99 and payment_date  between '2020-01-26'and '2020-01-27 23:59' ;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
IN  
NOT IN  
 select * from customer where customer_id=123 or customer_id=212 or customer_id=323 or customer_id=243 or customer_id=353 
 or customer_id=432;
  
 select * from customer where customer_id IN(123,212,323,243,353,422);

 select * from customer where first_name in('SHANNON','WILMA','LYDIA');
                                                                         ----IN FIND THE EASY TO LEARN THIS
 select * from customer where first_name NOT in('SHANNON','WILMA','LYDIA');

 CHALLENGE
 
 THERE HAVE BEEN 6 COMPLAINTS OF CUSTOMJERS ABOUT THEIR PAYMENTS
 CUSTOMER_ID:12,25,67,93,124,234

 THE CONCERNED PAYMENTS ARE ALL THE PAYENTS OF THESE CUSTOMERS WITH AMOUNTS 4.99,7.99 AND 9.99 IN JANUARY 2020;
    
 SELECT * FROM PAYMENT WHERE CUSTOMER_ID IN(12,25,67,93,124,234) AND AMOUNT IN(4.99,7.99,9.99)
 ND PAYMENT_DATE BETWEEN '2020-01-01' AND '2020-02-01;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
LIKE --- case sensitive uppercase to lowercase
NOT LIKE
   USED TO FILTER BY MATCHING AGAINST A PATTERN 
    USE WILDCARDS: _ ANY SINGLE CHARATER
    USE WILDCARDS: % ANY SEQUENCE OF CHARACTERS

   note
     a%----  the output the starting letter easy to get
     %a---  the output last letter
 --A% OR _a% ---  this is help to find SECOUND POSITION AND THIRD POSITION
     %A%---  THIS IS HELP TO FIND PRESENTING LITTER TO THE OUTPUT
    SYNTAX
      SELECT * FROM ACTOR WHERE FIRST_NAME LIKE 'A%';
      SELECT * FROM ACTOR WHERE FIRST_NAME NOT LIKE '%A%';
      SELECT * FROM FILM WHERE DESCRIPTION LIKE '%Drama%' and title like '_T%'

challenge
---------
   you need to help the inventory managerto find out
   how many movies are there that contain the "Documentary" in the description
   
  select count(*) from film where description like '%Documentary%'; --101--
  
  how many customers are there with a firstname that is 3 letters long and either an 'X' or a 'Y' as the last letter in the last name

    select count(*) from customer where first_name like '_ _ _' and (last_name like('%X') or last_name like('%Y'));---most of quary is interreupted end
    ---3--
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Alias,comment
   comment to make code more readable to understandable
     . use  --  single line comment
     .use /* [...] */     --- multiple lines comment 
            Ex
             /* comment like keyword use to more readble and understandable 
             comment like keyword use to more readble and understandable */
 notes
   use comments to explain your code

  example
     select title,description as description_Of_movie,release_year from film where description like '%Documentary%';
     select count(*)as total_documantary from film where description like '%Documentary%';

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
today summery
   
   select * from payment where amount=10.99 ,amount<10.99,amount!=10.99 or amount<>=10.99,select fist_name,last_name from customer where first_name is null ,not null


challenge
   1. how many movies are there that contain 'Saga' in the description and where the tite starts either with 'A' or end with 'R'?
      use the alias 'no_of_movies'
      ans
        select count(*) from film where description like '%Saga%' and (title like 'A%' or title like '%R')

  2.create a list of all customers where the first name contains 'ER'and has an 'A' as the second letter Order the results by the last name desendingly
       select count(*) from customer where first_name like '%ER%' or first_name '_A%' ;

  3.how many payments are there where the amount is either 0 or is between 3.99 and 7.99 and in the same time has happend on 2020-05-01

         select COUNT(*) from payment where (amount=0 or amount betwen 3.99 and 7.99) and payment_date between 2020-05-01 ON 2020-05-02;        
 
