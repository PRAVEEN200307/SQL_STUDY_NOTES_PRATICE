
UPDATE
------
 UPDATE <table>
 SET <column>=value

 UPDATE customer 
 SET last_name='BROWN'
 WHERE customer_id=1;

 UPDATE CUSTOMER
 SET EMAIL=LOWER(EMAIL);
  
CHALLENGE
---------
   UPDATE ALL RENTAL PRICES THAT ARE 0.99 TO 1.99

   THE customer table needs to be altered as well:
   1.Add the column initals(data type varchar(10))
   2.Update the values to the actual initials for example Frank Smith should be F.S
Ans:
    update FILM set RENTAL_RATE=1.99 where RENTAL_RATE=0.99
   
    ALTER TABLE customer ADD COULMN  initial varchar(10);
    UPDATE customer SET initial=left(first_name,1)||'.'||left(last_name)||'.'

--------------------------------------------------------------------------- 
DELECT
------
  DELETE FROM <TABLE>
  WHERE condition

  delete from songs where song_id=4
  delete from songs where song_id in (3,4)

  delete from songs where song_id in (3,4) returning song_id;
  delete from songs where song_id in (3,4) returning *;
 
 CHALLENGE
 -----------
   Delete the rows in the payment_id 17064 and 17067.
      DELECT FROM paymemt WHERE payment_id in (17064,17067) returning *
   
---------------------------------------------------------------------------
 CREATE TABLE AS
------------------
     CREATE TABLE CUSTOMER_TEST
     AS
     SELECT * FROM CUSTOMER;

     CREATE TABLE CUSTOMER_ADDRESS 
     AS
     SELECT FIRST_NAME,LAST_NAME,EMAIL,ADDRESS,CITY  FROM CUSTOMER C 
     LEFT JOIN ADDRESS A ON C.ADDRESS_ID=A.ADDRESS_ID
     LEFT JOIN CITY CI ON A.CITY_ID=CI.CITY_ID

    SELECT * FROM CUSTOMER_SPENDING;

------------------------------------------------------------------------------
  CREATE MATERIALIZED VIEW
 ---------------------------
       CREATE MATERIALIZED VIEW <view_name>
       as query
   
       REFRESH MATERIALIZED VIEW <view_name>
       
      
       CREATE MATERIALIZED VIEW FILM_INFORMATION
       AS
       SELECT TITLE,LENGTH,NAME FROM FILM F 
       LEFT JOIN FILM_CATEGORY C ON F.FILM_ID=C.FILM_ID 
       LEFT JOIN CATEGORY CA ON  CA.CATEGORY_ID=C.CATEGORY_ID
       WHERE NAME IN ('Action','Comedy') order by title;

       UPDATE FILM SET LENGTH=70 WHERE TITLE='AIRPLANE SIERRA';

       REFRESH MATERIALIZED VIEW FILM_INFORMATION;
       REFRESH MATERIALIZED VIEW MV_FILM_INFORMATION;
     
----------------------------------------------------------------------------
MANAGING VIEWS
---------------
    ALTER VIEW    -- ALTER MATERIALIZED VIEW
    DROP VIEW     --- DROP MATERIALIZED VIEW
   
 DROP VIEW customer_anonymous
 DROP MATERIALIZED VIEW  customer_anonymous

  ALTER VIEW
  ------------
     ALTER VIEW customer_anonymous        ALTER MATERIALIZED VIEW [ IF EXISTS ] name           -------RENAME THE VIEW
     RENAME TO v_custoemr_info            RENAME TO new_name     
                                        
    ALTER VIEW v_customer_info             ALTER MATERIALIZED VIEW [ IF EXISTS ] name          ------RENAME THE COLUMN VIEW
    RENAME COLUMN name to customer_name    RENAME [ COLUMN ] column_name TO new_column_name
                                      

    
  REPLACE VIEW
  -------------
      CREATE OR REPLACE VIEW v_customer_info
      as new_query
 ----------------------------------------------------------------------------------------
 IMPORT
 ------
   IMPORT external data into an existing table.
    
  problem:UTF8
  DELIMIRTER:,

 EXPORT
  ----
    EXPORT data from a table into a csv file
        






  
 








