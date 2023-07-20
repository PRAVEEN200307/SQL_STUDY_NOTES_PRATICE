 


        NOT NULL      Ensures that a column cannot have a null values.
        UNIQUE        Ensures that all values in a column are different.
        DEFAULT       sets a default values for a column if no values is specified/

        PRIMARY KEY   A combination of a NOT NULL AND UNIQUE.Uniquely.
                      identifies each row in a table.
        REFERENCES    Ensures referential integrity(only values of aother column can be used ).
        CHECK         Ensures that the values in a column satisfies a specific condition.


      NOT NULL AND DEFAULT
     --------------------
          ALTER TABLE <TABLE_NAME> ALTER COLUMN <COLUMN_NAME>  SET NOT NULL OR DEFAULT <VALUE>
          
            DROP 
            ----
              ALTER TABLE <table_name> drop constraint <column_name>
     
      UNIQUE AND PRIMARY KEY AND REFERNCES
      -------------------------------------
    
            UNIQUE
           --------
                ALTER TABLE <table_name> ADD CONSTRAINT <constraint_name> unique(column_name1,column_name2);
                                  alter table demo
                                  add constraint demo_unique unique(address)
            PRIMARY KEY
            -----------
               ALTER TABLE <table_name> ADD CONSTRAINT <constraint_name> unique(column_name1,column_name2);
                        alter table demo
                        add constraint employee_id primary key(employee_id)
            
           FOREIGN KEY
           -----------
              ALTER TABLE <table_name> ADD CONSTRAINT <constraint_name> FOREIGN KEY(column_name1,column_name2) REFERENCES(TABLE_NAME(COLUMN_NAME))
                      alter table demo add constraint  fk_demo foreign key(address_id)
                      references address(address_id)