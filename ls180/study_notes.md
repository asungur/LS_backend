# SQL

* SQL(Structure Query Language) is a declerative programming language used Relational Database Management Systems (RDBMS).
* Being declerative, a SQL statement does not specify how to do execute the operations, it only declares what needs to be done. Details of the operation is handles by RDBMSs.
* Statement vs Query:
    * SQL statement is the command we use to access a database(schema) or the data contained within the database.
    * SQL Query is a subset of SQL statement. It allows us to search a database.
* Relational database refers to a structured set of data in the same relational model.
* **Schema** refers to the organisational blueprint of how database is constructed. Table names, column's data types and their constraints are all components of *schema*.
* **Data** is the actual information stored in the database in form of columns/rows.

* ### Explain the difference between INNER, LEFT OUTER, and RIGHT OUTER joins.
* Join is .....
* `INNER JOIN`
* `LEFT OUTER JOIN`
* `FULL JOIN`


* ### Name and define the three sublanguages of SQL.
    * SQL consists of three sub-languages **DDL, DML, DCL**. Each sub-language operates a different aspect of database interaction/manipulation. 
    * DDL(Data Definition Language) is used to set the underlying structure of a database including the tables contained in that database and columns inside it. (Ex: `CREATE`, `ALTER`, `DROP`)
    * DML(Data Manipulation Language) contains commands that allows us to retrieve or modify the data stored within a database.
    (Ex: `INSERT`, `SELECT`, `UPDATE`, `DELETE`)
    * DCL(Data Control Language) is concerned with permission of different users when interacting with the database.
    
* ### Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.
* Insertion synthax
     ```sql
    INSERT INTO table_name (column1, column2)
    VALUES(value1, value2),
          (value3, value4);
     ```
* Update synthax
    ```sql
    UPDATE table_name
    SET column1 = value1
        column2 = value2
    WHERE condition;
    ```
* Deletion synthax
    ```sql
    DELETE FROM table_name
    WHERE condition;          # => not including this row result removing the entire data
    ```
* Creation synthax
    ```sql
    CREATE TABLE table_name(
    column1_name column1_data_type CONSTRAINTS,
    column1_name column1_data_type CONSTRAINTS
    );
    ```
* Alteration synthax
    ```sql
>    ALTER TABLE table_name
    RENAME TO new_table_name                               # => changing table name
    RENAME COLUMN column1 TO column_new_name               # => changing column name
    ALTER COLUMN column1 TYPE new_data_type                # => changing column data type
    ALTER COLUMN column1 SET constraint clause             # => setting column constraint
    ADD CONSTRAINT constraint_name constraint_clause       # => setting table constraint
    ADD COLUMN column1_name column1_data_type CONSTRAINT   # => adding a column
    DROP COLUMN column_name                                # => removing a column
    ```
* Drop synthax
    ```sql
    DROP TABLE table_name
    ```
    
* ### Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.
* `ORDER BY` allows us to visualise data according to the value(s) of one or more columns. By default it sorts the data in ascending order. This can be specified using `ASC` and `DESC` keywords. We can also sort using data from multiple columns. In this case, values  will be sorted in the given order
```sql
SELECT * FROM table_name
ORDER BY column1 DESC column 2 ASC; 
```
* `GROUP BY` allows us to combine data results to extract relevant information. For instance we can group rows that contain same information in one of their columns and count how many rows we have in each group
* `WHERE` vs `HAVING`: Former is used as a filtering clause that has more common use in statements such as `SELECT`, `UPDATE` and `DELETE`. The main difference between two is their use together with a `GROUP BY` clause. We use `WHERE` to filter relevant rows whereas we can use `HAVING` to identify the rows after grouping.`WHERE` clause can not contain aggregate functions (`COUNT`, `STR_AGG`, etc.) since it is not used after `GROUP BY`

# PostgreSQL

* PostgreSQL is a RDBMS(an application for managing relational databases).
* It has client-server architecture

* ### Describe what a sequence is and what they are used for.
* ### Create an auto-incrementing column.
* ### Define a default value for a column.
* ### Be able to describe what primary, foreign, natural, and surrogate keys are.
* ### Create and remove CHECK constraints from a column.
* ### Create and remove foreign key constraints from a column.
# Database Diagrams
* ### Define cardinality and modality.
* ### Be able to draw database diagrams using crow's foot notation.
