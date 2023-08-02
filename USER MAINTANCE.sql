CREATE USER praveen
WITH PASSWORD 'praveen1234';

CREATE USER dhinesh
with password 'dhinesh1234';

create role read_only;
create role read_update;

grant usage
on  schema public to
read_only;

GRANT SELECT
ON ALL TABLES IN SCHEMA PUBLIC
TO read_only;

GRANT read_only to praveen

grant read_only to read_update;

GRANT ALL
ON ALL TABLES IN SCHEMA PUBLIC TO read_update;

GRANT  read_update to dhinesh ;

revoke insert,delete 
on all tables in schema public from read_update

drop role praveen;
drop role read_only;

drop owned by read_only;

