# SQL

   * SQL(Structure Query Language) is a declerative programming language used in Relational Database Management Systems (RDBMS).
   * By being declerative, a SQL statement does not specify how to do execute the operations, it only declares what needs to be done.
   Details of the operation is handled by RDBMSs.
   * Statement vs Query:
      * *SQL statement* is the command we use to access a database(schema) or the data contained within the database.
      * *SQL Query* is a subset of SQL statement. It allows us to search a database.
   * Relational database refers to a structured set of data in the same relational model. They persist data in a set of relations
      * **Relation** is a table consist of columns and rows
      * **Relationship** is the link between the rows of data(entity). This is the result of the data type of the entity and how it is related to other entities.
   * **Schema** refers to the organisational blueprint of how database is constructed. Table names, column's data types and their
   constraints are all components of *schema*.
   * **Data** is the actual information stored in the database in form of columns/rows.
   * Increasing the number of columns could make the table harder to read and could increase data duplication. **normalization** is the    process of distributing data into multiple tables and defining relationships between them to *improve data integrity*  and *reduce/eliminate duplication*
   * **Keys** are types of constraints used to define *relationships* and *uniqueness*. They are used to *identify a specific row in the current table* and *to refer to a specific row in another table*.
   * Explaining basic components of a sql statement:
     ```sql
     school=# CREATE TABLE students (
     id serial UNIQUE NOT NULL,
     first_name varchar(25)
     );
     ```
     * `school=#` demonstrates that we are connected to `school` database
     * `CREATE TABLE` is a SQL keyword that used to create a new table
     * `students` is the name of the table to be created
     * `id` and `first_name` are the names of the columns
     * `serial` and `varchar()` are the data type for each column
     * `UNIQUE` and `NOT NULL` are two constraints for the `id` column.
     * `;` semicolon is the end of the SQL statement

* ### Explain the difference between INNER, LEFT OUTER, and RIGHT OUTER joins.
   * `JOIN` clauses link two tables together. This is usually done by using the keys that define the relationship. Different `JOIN` types allow us to query the information in different ways
   * `INNER JOIN` returns the intersection of the two tables on the given condition. If certain rows of one table are not represented in the other table they will not be included in the join table. If we dont specify the join type in our clause and use `JOIN` clause only, it will execute an inner join.
   * `LEFT OUTER JOIN` or `LEFT JOIN` it will take all the rows from the `LEFT` table regardless of data matching with the other table. 
     ```sql
     SELECT table1.*, table2.*
     FROM table1
     LEFT JOIN table2
     ON (table1.id = table2.data_id);
     ```
     In the above example table1 is the left table of the join and its all rows will be included.
     
   * `RIGHT OUTER JOIN` or `RIGHT JOIN` is the same as `LEFT JOIN` except the roles of the tables are swapped.
     ```sql
     SELECT table1.*, table2.*
     FROM table1
     RIGHT JOIN table2
     ON (table1.id = table2.data_id);
     ```
     All rows of the table2 will included.
     
   * `FULL JOIN` or `FULL OUTER JOIN` is the combination of both. All rows of both tables will return. Unmatching data will be represented as `NULL`

* ### Name and define the three sublanguages of SQL.
    * SQL consists of three sub-languages **DDL, DML, DCL**. Each sub-language operates a different aspect of database              interaction/manipulation. 
    * DDL(Data Definition Language) is used to set the underlying structure of a database including the tables contained in that database and columns inside it. (Ex: `CREATE`, `ALTER`, `DROP`)
    * DML(Data Manipulation Language) contains commands that allows us to retrieve or modify the data stored within a database table.
    (Ex: `INSERT`, `SELECT`, `UPDATE`, `DELETE`). These also known as CRUD operations(Create, Read, Update, Delete). There are certain web application that interfaces to perform such operations. These type of applications are named *CRUD apps*.
    * DCL(Data Control Language) is concerned with the permissions of different users when interacting with the database.
    
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
   *  Deletion synthax
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
   * Addition/Alteration synthax
    ```sql
    ALTER TABLE table_name
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
   * `ORDER BY` allows us to visualise data according to the value(s) of one or more columns. By default it sorts the data in ascending   order. This can be specified by using `ASC` and `DESC` keywords. We can also sort using the data from multiple columns. In this case, values will be sorted in the given order
   ```sql
   SELECT * FROM table_name
   ORDER BY column1 DESC column 2 ASC; 
   ```
   * `GROUP BY` allows us to combine data results to extract relevant information. For instance we can group rows that contain same       information in one of their columns and count how many rows we have in each group
   * `WHERE` vs `HAVING`: Former is used as a filtering clause that has more common use in statements such as `SELECT`, `UPDATE` and        `DELETE`. The main difference between two is their use together with a `GROUP BY` clause. We use `WHERE` to filter relevant rows        whereas we can use `HAVING` to identify the rows after grouping.`WHERE` clause can not contain aggregate functions (`COUNT`,            `STR_AGG`, etc.) since it is not used after `GROUP BY`

# PostgreSQL

  * PostgreSQL is a RDBMS(an application for managing relational databases).
  * It has client-server architecture
  * There are 3 ways to restrict data in a column using schema.
    1. Data type
    2. `NOT NULL` constraint
    3. `CHECK` constraint
  * A Subquery or Nested query refers to a query placed within another query
    ```sql
    SELECT *.col1 FROM table_1
    WHERE table_1.id IN (SELECT table_2.id FROM table_2);
    ```
  It is quite common that instead of `JOIN`s we can use subqueries. Keeping the computational cost in mind, there are multiple ways to query the same information since SQL is a declerative language where we specify what operations needs to be done, not how to do it.

* ### Describe what a sequence is and what they are used for.
  * **Sequence** is a relation that generates auto-incrementing numbers. It achieves this by remembering the last number that it is generated.
  It is commonly created as part of *serial* columns:
  ```sql
  CREATE TABLE table_name(
    id serial
    );
  ```
  the line with `id serial` actually functions as
  ```sql
    id integer NOT NULL DEFAULT nextval('table_name_id_seq`);
  ```
  * An example on how to extract year for a date data type.
  ```sql
  SELECT extract( year FROM CURRENT_DATE )::int;
  ```
  * Other useful commands to to look at, `CAST`, `STR_AGG`, `substring( "string", from 1 to 2)`
  
* ### Create an auto-incrementing column.
  ```sql
  CREATE SEQUENCE table_name_sample_seq;
  CREATE TABLE table_name (
    sample integer DEFAULT nextval('table_name_sample_seq')
    );
  ```
  
* ### Define a default value for a column.
  ```sql
  CREATE TABLE table_name (
    column_name integer DEFAULT 0
    );
  ```
  ```sql
  ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT 0;
  ```

* ### Be able to describe what primary, foreign, natural, and surrogate keys are.
* ### Create and remove foreign key constraints from a column.
  * A **primary key** is a unique identifier for a row of data. It also enforces `NOT NULL` and `UNIQUE` constraints. Having a primary key column in every table is a common convention in certain software communities. However, this decision might differ to the project team.
    * ```sql
      ALTER TABLE table_name
      ADD PRIMARY KEY(column_name);
      ```
    * ```sql
      CREATE TABLE table_name(
      column_name data_type PRIMARY KEY
      );
      ```
  * **Foreign keys** used to relate a row in a table to another row in a different table. We achieve this by setting up a column as a foreign key and referencing this to another tables primary key column.
    * ```sql
      ALTER TABLE table_name 
      ADD FOREIGN_KEY(column_name)
      REFERENCES target_table_name(column2_name);
      ```
    * ```sql
      CREATE TABKE table_name(
      column_name FOREIGN KEY REFERENCES target_table_name(column2_name) ON DELETE CASCADE
      );
      ```
  * `ON DELETE CASCADE` is an important implementation detail for maintaining referential integrity. In case the reference row(with primary key - `column2_name` above) gets deleted, the referencing row(`column_name`) will be deleted too.
  * Where a *key* is a broader term used for unique identifiers of a single row in a database table. There are two types of keys
  * **Natural keys** are the existing values in a table that can be used to identify a specific row. For instance, let's assume we a table contains different information for individuals. In such a table, "national ID number" column can be used as a natural key since it is unique to every individual.
  * **Surrogate keys** are values specifically defined to identify different rows in a database table. This type of keys have certain advantages over natural keys. A good example to surrogate key is the `id` column that we commonly use. During table creation we usually ensure that this column is auto-incrementing, not null and unique. By using *surrogate keys* in our queries we ensure that data we are getting is coming from the column we specify. Also, using more than one value to identify a row is called *composite key*.
  
* ### Create and remove CHECK constraints from a column.
  * ```sql
    ALTER TABLE table_name
    ADD CONSTRAINT constraint_name
    CHECK (length(column_name) >= 5);
    ```
  * ```sql
    ALTER TABLE table_name
    DROP CONSTRAINT constraint_name;
    ```
    
# Database Diagrams
  * **Conceptual**, logical and **Physical** schema
  * ERD(Entity-Relationship diagram)
  * **Update anomaly** vs **Insertion anomaly** and **Normalization** (and *denormalization*).

* ### Define cardinality and modality.
  * **Referential Integrity** is a database concept on relational data idealises that table relationships must be consistent. Different RDBMS'es implement different methods to enforce referential integrity. It is one of the key aspects to look after in database design.
  * **Cardinality** is the number of items on each side of the relationship. Shown as (1:1, 1:M, M:M). For instance, in a one-to-many relationship, the cardinality of this relationship is going to be 1 and many. Cardinality sets the upper limit of the connections for each side.
  * **Modality** is the indication that if the relationship is required or not. Shown as (1) - required / (0) - optional. We can also think this as the minimum number of connections for each side.
* ### Be able to draw database diagrams using crow's foot notation.
  * Crow's foor notation is an approach used in drawing Entity Relationship Diagrams(ERD). It is concerned with the conceptual schema and demonstrates *cardinality* and *modality* of the relationships between different tables.
