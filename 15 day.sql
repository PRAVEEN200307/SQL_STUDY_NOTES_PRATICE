User management
----------------
superuser

CREATE USER
-----------

CREATE USER <user_name>
WITH PASSWORD 'pwd123';

CREATE ROLE <role_name>
WITH LOGIN PASSWORD 'pwd123';

DROP USER <user_name>
DROP USER <role_name>

CREATE USER Sarah
with password 'sarah1234';

CREATE ROLE alex
WITH LOGIN PASSWORD 'alex1234';

---------------------------
GRANT & REVOKE
---------------
 privileges
 ----------
  select
  insert 
  update
  delete
  truncate
  EXECUTE
  usage
  all
 
SYNTAX---superuser
-----
 GRANT privilege
 ON database_object
 TO USER| ROLE| PUBLIC

 GRANT SELECT
 ON CUSTOMER
 TO  nikolai

 GRANT SELECT
 ON ALL TABLES IN SCHEMA schema_name
 TO nikolai
-----------
 REVOKE privilege
 ON database_object
 TO USER| ROLE| PUBLIC

 REVOKE GRANT OPTION FOR privilege
 ON database_object
 FROM USER| ROLE | PUBLIC
 GRANTED BY USER|ROLE
 
 Privileges
 ----------
 CREATE USER
 -----------
    CREATE USER amar
    WITH PASSWORD 'amar1234';

  GRANT USAGE on schema
  ----------------------
    GRANT USAGE
    ON SCHEMA name
    TO amar; 

  GRANT SELECT & UPDATE
  -----------------------
     GRANT SELECT,UPDATE
     ON customer
     to amar;

  GRANT all privileges on schema
  ------------------------------
    GRANT ALL
    ON ALL TABLES IN SCHEMA public
    TO amar;

  GRANT all privileges on database
  ---------------------------------
    GRANT ALL
    ON DATABASE greencycles
    TO amar;

  GRANT createdb
 ---------------------
   ALTER USER amar CREATEDB;

  GRANT roles to user
  ----------------------
   GRANT sarah TO amar;

  GRANT roles to user
  -------------------
   GRANT analyst To amar;

  REVOKE INSERT
  -------------
   REVOKE INSERT ON customer FROM amar;
 
  REVOKE ALL PRIVILEGES
  ---------------------
   REVOLE ALL PRIVILEGES ON customer 
   FROM PUBLIC;
     
  REVOKE ROLE
  ------------
    REVOKE analyst FROM amar;

HAND ON
---------
  superuser
  
  CREATE USER ria
  WITH PASSWORD 'ria123';

  CREATE USER mike
  WITH PASSWORD 'mike123';
  
  --create role--
  create role read_only;
  create role read_update;

  --grant usage (already granted)
   GRANT USAGE
   ON SCHEMA public --it not nasasary
   TO read_only;
     
  --grant select on tables
   GRANT SELECT
   ON ALL TABLES IN SCHEMA PUBLIC
   TO read_only;

   GRANT read_only to mike

 hint --it not update and delete
--------------------------------

 Assign read_only to read_update
  GRANT read_only
  TO read_update;

 Additional privileges
-------------------------
 --Grant all privileges on all tables
 -- ih public to role
  
  GRANT ALL
  ON ALL TABLES IN SCHEMA public
  TO  read_updates;

  --revoke some privileges
  REVOKE DELETE,INSERT
  ON ALL TABLES IN SCHMEA PUBLIC
  FROM read_updates;

  --Assign role to users
 GRANT  read_update
 TO ria;
  
  --pratice

 --superuser
 DROP ROLE mike;
 
 DROP role read_update;--some error

 --removing dependancies
 DROP OWNED BY read_updates;
 DROP ROLE  read_update; 

----------------------------------------------------------------------------------------------
INDEXES
-------------
  READ operations
  Write operations

>index help to make data reads
 faster!
>much mcuh faster
>slower data writes
>Additional storage


Different type of indexes
for different situations
-------------------------
B-tree Indexes

>Multi-level tree structure
>Breaks data down into
 pages or blocks


B-tree Indexes
---------------
> Multi-level tree structure

> Breaks data down into pages
  or blocks
  
>Should  be used for high-
 cardinality (unique)columns

>not entire table
 (costy in terms of storage)


Bitmap indexes
---------------
 >particularily good for dataware houses
 >large amount of data + low-cardinality
 >very storage efficient

Guidelines
-----------
 large tables
 B-tree index
----------------
  Default index
  Unique columns
  (surrogate key,names)
 
 Bitmap index
---------------
 slow to update
 storage efficient
 great read perfomance

Creating indexes
----------------
 large tables
  
CREATE INDEX index_name
ON table_name [USING method]
  (
    column_name
    [,...]
  );

select
(select
 avg(amount)
 from
 payment p2
 where
 p2.rental_id=
 p1.rental_id
) from payment p1

CREATE INDEX index_rental_id_payment
on payment
(rental_id)
   
 drop index <index name>   

Execution plan & query performance
-----------------------------------
Execution plan
Query optimizer
EXPLAIN feature

normal
 append
create index
 index scan
index only present like (rental_id)
 seq scan














 


 













