
MANAGING TABLES
---------------
  DATE DEFINITION
 ------------------
  CREATE 
    DATABASE
    TABLE
    SCHEMAS
  ALTER
    date definition

  DATE STRUTURES
-----------------------------------------------------------------------------------------
 DATE MANIPULATION
------------------
  DROP
  INSERT 
  UPDATE 
  DELECT

DATA ITSELF
--------------
  DATA TYPES
  CONSTRAINTS
  PRIMARY & FOREIGN KEY
  VIEWS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATING DATABASE
----------------
   CREATE DATABBASE <DATABASE NAME>;

    CREATE DATABASE "COMPANY_Y ";

    CREATE DATABASE COMPANY;

    CREATE DATABASE "COMPANY_E "
    WITH  ENCODING='UTF-8'
  
   CREATE DATABASE X
    COMMENT ON DATABASE X IS 'THIS IS A X DATABASE';
EXAMPLE
-------
   CREATE DATABASE Y_UNION
	   WITH ENCODING='UTF-8'

    COMMENT ON DATABASE Y_UNION IS 'COMPANY UNION RELATED DETAIL '
---------------------------------------------------------------------------------------------------------------------------------------------------------
DATA TYPES
----------
    IMPORTANT WHEN CREATING TABLES
    UNDERSTANDING DATA TYPES
 NUMERIC 
   INT 4 BYTES
   SMALL INT 2 BYTES 
   BIG INT 8 BYTES 
   numeric orDECIMAL(PRECISION,SCALE)--floatpoint,user_defined_precision
        PRECISION:TOTAL COUNT OF DIGITS
        Scale: count of decimal places 
          Ex: decimal(4,2);


   SERIAL auto_increment_integer
mallserial	2 bytes	  small autoincrementing integer	1 to 32767
serial	       4 bytes	      autoincrementing integer	        1 to 2147483647
bigserial	8 bytes	   large autoincrementing integer	1 to 9223372036854775807
-------------------------------------------------------
   STRINGS
        *1.character varying(n)  variable-length with limit 
          varchar(n)
        2.charater(n)        fixed-length,blank padded  ex: m or f
          char(n)
        *3.text              variable unlimited length
 
 DATE/TIME
      date           just date without time   
      time           just time without date
      timestamp      date and time
      intervals      time interval
 OTHERS
      boolean        state of true or false                 is_in_stack      true,false,null

      enum           A values of a list of ordered values   movie_rating     User-defined
      -----
         Enumerated (enum) types are data types that comprise a static, ordered set of values. 
         They are equivalent to the enum types supported in a number of programming languages.
          An example of an enum type might be the days of the week, or a set of status values for a piece of data.
       Ex:CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');

             
      array          Stores a list of values                text[] or int[]  Dpending on type
array
   maya {'+42-66764453','+434567651234','+43123676514'} 
   select name,phone[1] from customers where '+42-66764453= any (phones)
 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CONSTRAINTS
-----------
  column name
  Data type

  Constraints
       Defined when table is created
       Used to define rules for the data in a table

  COLUMN NAME CONSTRAINTS
  ------------------------
        NOT NULL      Ensures that a column cannot have a null values
        UNIQUE        Ensures that all values in a column are different 
        DEFAULT       sets a default values for a column if no values is specified

        PRIMARY KEY   A combination of a NOT NULL AND UNIQUE.Uniquely
                      identifies each row in a table
        REFERENCES    Ensures referential integrity(only values of aother column can be used )
        CHECK         Ensures that the values in a column satisfies a specific condition
        create index
            Indexes are used to retrieve data from the database more quickly than otherwise. 
            The users cannot see the indexes, they are just used to speed up searches/queries.
              CREATE INDEX idx_lastname
              ON Persons (LastName);\

---------------------------------------------------
PRIMARY KEY AND FOREIGN KEY 
---------------------------

  PRIMARY KEY
  ---------------
    one or multiple column that uniquely identify each row in a table

  FOREIGN KEY
  -----------
   1. A column(or multiple)that refers to the primary in another table.
           notes: 
             1. foreign key does not need to be unique.
             2. Primary key and foregin keys are usualy the columns to join tables. 
             3. can be created also in table creation process.
----------------------------------------------------------------------------------------------------------
CREATE TABLE
------------
     CREATE TABLE <TABLE_NAEM>(
        COULMN_NAME1 TYPE[CONSTRAINTS],
        COLUMN_NAME1 TYPE[CONSTRAINTS]
     )
   Ex:
     CREATE TABLE STAFF(
            STAFF_ID SERIAL  PRIMARY KEY
            NAME VARCHAR(50) NOT NULL 
            UNIQUE(NAME,STAFF_ID)
     )

    CREATE TABLE director(
        director_id SERIAL PRIMARY KEY
        direcotor_accound_name varchar( 20) UNIQUE,
        first_name VARCHAR(50),
        Last_name  varchar(50) default 'Not specified',
        address_id int references address(address_id)
     )

QUESTION
---------

Create a table called online_sales with the following columns:

transaction_id

customer_id

film_id

amount

promotion_code

Transaction_id shoul be the primary key.
The columns customer_id and film_id should be foreign keys to the relevant tables.
The amount column can contain values from 0.00 to 999.99 - nulls should not be allowed.
The column promotion_code contains a promotion code of at maximum 10 characters. If there is no value you should set the default value 'None'.

ANS:
  CREATE TABLE ONLINE_SALES (
	transaction_id serial primary key,
	customer_id  int references customer(customer_id),
	film_id    int references film(film_id),
	amount    decimal(5,2) not null,
	promotion_code varchar(10) default 'None'
  )
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO
-------------
   INSERT INTO <table> values(values1,values);
   INSERT INTO online_sales values(1,269,13,10.99,'BUNDLE2022');
   INSERT INTO online_sales(customer_id,film_id,amount) values (269,13,10.99);
   INSERT INTO online_sales(customer_id,film_id,amount) values (269,13,10.99),(270,12,22.99);


--------------------------------------------------------------------------------------------------------
ALTER TABLE
------------
    ADD,DELECT COLUMNS
    ADD,DROP constraints
    RENAME columns
    ALTER data types 

 SYNTAX   DROP ,ADD, TYPE, RENAME ,DEFAULT



   DROP 
   ----
     ALTER TABLE <TABLE_NAME>
     DROP COLUMN <COLUMN_NAME>

     ALTER TABLE staff
     DROP COLUMN IF EXISTS FIRST_NAME	

   ADD
   ---
     ALTER TABLE STAFF
     ADD COLUMN date_of_birth DATE 

     ALTER TABLE staff
     ADD COLUMN IF NOT EXISTS  date_of_birth DATE 
    
  TYPE 
  ----
     ALTER TABLE STAFF 
     ALTER COLUMN address_id TYPE SMALLINT ;

  RENAME
  ------
     ALTER TABLE STAFF RENAME COLUMN  first_name to name 
 
     ALTER TABLE DIRECTOR RENAME DIRECTOR_TABLE
   
   
  DEFAULT
  -------
     ALTER TABLE <table_name>
     ALTER COLUMN <column_name> SET DEFAULT <VALUE>
            ALTER TABLE  staff
            ALTER COLUMN  store_id SET DEFAULT 1
            ALTER TABLE <table_name>
           ALTER COLUMN <column_name> DROP DEFAULT
          
    TABLE CONSTRAINT
  --------------------

     ALTER TABLE<TABLE_NAME>
     ALTER COLUMN <COLUMN_NAME> UNIQUE(column1);
     
     CONSTRAINTS
    ----------------
       ALTER TALE <TABLE_NAME>
       ADD CONSTRAINT <CONSTRAINT_NAME>  
      UNIQUE(COLUMN1,COLUNM2[,...])     
   
     ALTER TABLE supplier
     ADD CONSTRAINT supplier_unique UNIQUE (supplier_id);

     ALTER TABLE supplier
     DROP CONSTRAINT supplier_unique;

 
   PRIMARY KEY
   --------------
      ALTER TABLEE <table_name>
      ADD CONSTRAINT <CONSTRAINT_NAME>
      ADD PRIMARY KEY(column1,column2[,..])

       ALTER TABLE director
       ALTER COLUMN director_accound_name set default 3,
       ALTER COLUMN  first_name TYPE TEXT,
       ALTER COLUMN  last_name TYPE  TEXT,
       ADD COLUMN  middle_name TEXT,
       ADD CONSTRAINT  constraint_1 UNIQUE(account_name)

   CHALLENGE
  -----------
   /* 
      ALTER TABLE steps

     1.director_account_name to varchar(30)
     2.drop the default on last_name
     3. add the constraints not null to last name
     4.add the column email of data type varchar(40)
     5. rename the director_account_name to account_name
     6. rename the table from direcotor to directors
  */

   select * from directors;
     1. alter table director alter column director_account_name type varchar(30);
     2. alter table director  alter column last_name drop default;
     3. alter table directors  alter column last_name set  not null
     4. alter table director add column email  varchar(40) 
     5. alter table director rename column director_account_name to account_name;
     6. alter table director rename to directors;

-----------------------------------------------------------------
DROP & TRUNCATE
------------------
    DROP TABLE <table_name>  --deletes table
    DROP SCHEMA <Schema_name>---delects object 
    TRUNCATE <table_name>-----deletes all data in table

--------------------------------------------------------------------------------------------------------------------------------------------
CHECK
-----
   limit the value range that can be placed in column

   CREATE TABLE <TABLE_NAME>(
     <COLUMN_NAME> TYPE CHECK(CONDITION)
   )

   CREATE TABLE director(
    name text check(length(name)>1)
   )
   
    CREATE TABLE director(
       name TEXT CONSTRAINT name_length check(length(name)>1)
    )
   
    default name:<table>_<column>_check
    default name:director_name_check

    create table director(
     name text,
     date_of_birth DATE,
     start_date DATE,
     end_date DATE check(start_date > date_of_birth);
    )
    defult name : data_ check  -- more than one condition
       insert into director(date_of_birth,start_date) 
       values('01-01-1902','01-01-1900');
   
    ALTER TABLE director
    ADD CONSTRAINTS date_check check(start_date<end_date);

    ALTER TABLE director drop constraint data_check

    alter table rename constraint data_check to data_chinking

challenge
---------
   alter table songs add constraint date_check check(relase_date between '01-01-1950' and current_date)												

   create table song(
	song_id serial primary key  , 
	song_name varchar(30) not null,
	genre varchar(30) default 'Not defined',
	price numeric(4,2) check(price>=1.99) ,
	relase_date date constraint data_check check(relase_date between '01-01-1950' and current_date)
   ) 

  alter table song
  drop constraint song_price_check ,
  add constraint song_price_check check(price>=0.99)
  
  insert into song(song_id,song_name,price,relase_date) 
  values(4,'sql song',0.99,'2022-01-07');


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------















Involved in writing PL/SQL Stored Procedures, Functions, Cursors, Triggers and Package.
Written complex SQL (Sub queries and Join conditions), in PL/SQL







   
   
