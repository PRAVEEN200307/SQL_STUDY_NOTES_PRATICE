USER-DEFINED FUNCTIONS
-----------------------
---CREATE OR REPLACE
CREATE FUNCTION <function_name>
(param1,param2,...)
RETURNS  renturn_datatype
LANGUAGE  plpgsql [sql|c|...]
As
$$
   DECLARE
   <variable declaration>;
   BEGIN
    <function_defination>;
    returns;
   END;
      
$$   
call the function
select function_name();

CREATE FUNCTION first_function(c1 INT,c2 INT)
       RETURNS INT
       LANGUAGE plpgsql
As
$$
DECLARE
c3 INT;
BEGIN 
SELECT 	C1+C2+C3
INTO C3;
RETURN c3;
END;
$$

PRATICAL EXAMPLE
----------------

CREATE FUNCTION count_rr
(min_r deciaml(4,2),max_r decimal(4,2))
RETURNS int
LANGUAGE plpgsql
AS
$$
DECLARE
MOVIE_COUNT INT;
BEGIN
 SELECT COUNT(*)
 INTO movie_count
 FROM film
 WHERE rental_rate BETWEEN min_r AND max_r ;
 RETURN movie_count;
END;
$$ 


create function name_search(first_n text,last_n text)
returns decimal(5,2)
language plpgsql
as
$$
declare
  total decimal(5,2);
begin
 select sum(amount)
 into total
 from customer c left join payment p on c.customer_id=p.customer_id
 where first_name=first_n  and last_name=last_n  group by first_name,last_name;
 return total;
end;
$$
-----------------------------------------------------
TRANSACTIONS
------------
  unit of work
  one or more operations

BEGIN TRANSACTION;
BEGIN WORK;

BEGIN;
 OPERATION1;
 OPERATION2;

NOTE: you forget to commit 
      not visible in other sessions 

commit;

pratice example
---------------

BEGIN;

 UPDATE acc_balance 
 SET amount= amount -100
 where id=1 ;

 UPDATE acc_balance 
 SET amount= amount +100
 where id=2 ;

COMMIT;

CHALLENGE:
---------
2 Miller      Head of BI       14614.00 
3 Christalle  Head of Sales    12587.00

BEGIN:
 
update employees set salary=14614.00 
where emp_id=3;

update employees set salary=12587.00
where emp_id=2;

update employees set position_title='Head of Sales'
 where emp_id=2;
update employees set position_title='Head of BI' 
where emp_id=3;

COMMIT;
------------------------------------------------------------------------------------------
ROLLBACK:
---------
Undo everything in the current 
transaction that has not been commited yet

begin;
update acc_balance set amount=amount+100 where id=2;
savepoint s1
delete from  acc_balance where id=1;
savepoint s2
rollback to savepoint s1;
rollback
commit

RELEASE SAVEPOINT op3;
			
-----------------------------------------
STORED PROCEDURES
------------------

CREATE PROCEDURE <procedure_name>
(parm1,param2,...)
LANUAGE pgplsql
As
$$
DECLARE
<variable declaratrion>
BEGIN
<procedure_definition>
END;
$$

CALL <store_procedure_name> (param1,param2,...)

------------------------------
CREATE PROCEDURE 
sp_transfer( tr_amount INT,sendar INT,recipient INT )
  LANGUAGE plpgsql
As
$$
BEGIN
 --- substract from sendder 's balance
update acc_balance
set amount=amount-tr_amount
where id=sendar;

----add the recipient balance
update acc_balance
set amount=amount+tr_amount
where id=recipient;

COMMIT;
END;
$$

challenge
----------


create procedure sp_swape(e_id int,s decimal(7,2),position_t text )
language plpgsql
as
$$
begin
--- change salary
update employees set salary=s
where emp_id=e_id;
--change position
update employees set position_title=position_t
where emp_id=e_id;
commit;
end;
$
---------------------------
create or replace procedure emp_swap(emp1 int, emp int)
LANGUAGE plpgsql
AS
$$
DECLARE
 salary1 decimal(8,2);
 salary2 decimal(8,2);
 position1 TEXT;
 position2 TEXT;
BEGIN

SELECT salary
into salary1
FROM employees where emp_id=1;

SELECT salary
into salary2
FROM employees where emp_id=2;

SELECT position_title
into  position1
FROM employees where emp_id=1;

SELECT position_title
into position2
FROM employees where emp_id=2;

----update salary
UPDATE employees
set salary=salary2
where emp_id=1;

UPDATE employees
set salary=salary1
where emp_id=2;

---position title
UPDATE employees
set position_title=position2
where emp_id=1;

UPDATE employees
set position_title=position1
where emp_id=2;

 commit;
 END;
$$



------------------------------------------------------------------------------------------------------------







