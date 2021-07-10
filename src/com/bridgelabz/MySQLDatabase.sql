/* Welcome to MySQL Database */

/* UC-1 */
mysql> CREATE database employee_payroll_service;
Query OK, 1 row affected (0.27 sec)

mysql> show databases;
+--------------------------+
| Database                 |
+--------------------------+
| classicmodels            |
| employee_payroll_service |
| information_schema       |
| mysql                    |
| payroll_service          |
| performance_schema       |
| student_personal_details |
| sys                      |
+--------------------------+
8 rows in set (0.00 sec)

mysql> USE employee_payroll_service;
Database changed

/* UC-2 */
mysql> Create table employee_payroll (
    -> id int NOT NULL auto_increment,
    -> name varchar(100) NOT NULL,
    -> salary int NOT NULL,
    -> start date,
    -> primary key (id)
    -> );
Query OK, 0 rows affected (1.72 sec)

mysql> desc employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| name   | varchar(100) | NO   |     | NULL    |                |
| salary | int          | NO   |     | NULL    |                |
| start  | date         | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
4 rows in set (0.09 sec)

/* UC-3 */
mysql> INSERT INTO employee_payroll
    -> (name, salary, start) VALUES
    -> ('Bill',1000000, '2021-07-09');
Query OK, 1 row affected (0.28 sec)

mysql> INSERT INTO employee_payroll
    -> (name, salary, start) VALUES
    -> ('Mark',1200000, '2021-07-09'), ('David',2200000, '2021-07-02'), ('John',5000000, '2021-04-06');
Query OK, 3 rows affected (0.22 sec)
Records: 3  Duplicates: 0  Warnings: 0

/* UC-4 */
mysql> SELECT * FROM employee_payroll;
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  1 | Merrisa | 3200000 | 2021-07-03 |
|  2 | Bill    | 1000000 | 2021-07-09 |
|  3 | Mark    | 1200000 | 2021-07-09 |
|  4 | David   | 2200000 | 2021-07-02 |
|  5 | John    | 5000000 | 2021-04-06 |
+----+---------+---------+------------+
5 rows in set (0.13 sec)

/* UC-5 */
mysql> SELECT salary FROM employee_payroll WHERE name = 'Bill';
+---------+
| salary  |
+---------+
| 1000000 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT salary FROM employee_payroll WHERE start BETWEEN CAST('2021-07-09' AS DATE) AND DATE(NOW());
+---------+
| salary  |
+---------+
| 1000000 |
| 1200000 |
+---------+
2 rows in set (0.00 sec)

/* UC-6 */
mysql> ALTER table employee_payroll
    -> ADD gender CHAR(1);
Query OK, 0 rows affected (1.78 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+---------+------------+--------+
| id | name    | salary  | start      | gender |
+----+---------+---------+------------+--------+
|  1 | Merrisa | 3200000 | 2021-07-03 | NULL   |
|  2 | Bill    | 1000000 | 2021-07-09 | NULL   |
|  3 | Mark    | 1200000 | 2021-07-09 | NULL   |
|  4 | David   | 2200000 | 2021-07-02 | NULL   |
|  5 | John    | 5000000 | 2021-04-06 | NULL   |
+----+---------+---------+------------+--------+
5 rows in set (0.03 sec)

mysql> UPDATE employee_payroll set gender = 'M' WHERE name = 'Bill' or name = 'David' or name = 'John';
Query OK, 3 rows affected (0.18 sec)
Rows matched: 3  Changed: 3  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+---------+------------+--------+
| id | name    | salary  | start      | gender |
+----+---------+---------+------------+--------+
|  1 | Merrisa | 3200000 | 2021-07-03 | NULL   |
|  2 | Bill    | 1000000 | 2021-07-09 | M      |
|  3 | Mark    | 1200000 | 2021-07-09 | NULL   |
|  4 | David   | 2200000 | 2021-07-02 | M      |
|  5 | John    | 5000000 | 2021-04-06 | M      |
+----+---------+---------+------------+--------+
5 rows in set (0.12 sec)

mysql> UPDATE employee_payroll set gender = 'F' WHERE name = 'Merrisa' or name = 'Mary';
Query OK, 2 rows affected (0.20 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+---------+------------+--------+
| id | name    | salary  | start      | gender |
+----+---------+---------+------------+--------+
|  1 | Merrisa | 3200000 | 2021-07-03 | F      |
|  2 | Bill    | 1000000 | 2021-07-09 | M      |
|  3 | Mary    | 1200000 | 2021-07-09 | F      |
|  4 | David   | 2200000 | 2021-07-02 | M      |
|  5 | John    | 5000000 | 2021-04-06 | M      |
+----+---------+---------+------------+--------+
5 rows in set (0.11 sec)

/* UC-7 */
mysql> SELECT SUM(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender;
+-------------+
| SUM(salary) |
+-------------+
|     4400000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender;
+-------------+
| MAX(salary) |
+-------------+
|     3200000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender;
+-------------+
| MIN(salary) |
+-------------+
|     1200000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender;
+--------------+
| AVG(salary)  |
+--------------+
| 2200000.0000 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT gender, count(gender) FROM employee_payroll GROUP BY gender;
+--------+---------------+
| gender | count(gender) |
+--------+---------------+
| F      |             2 |
| M      |             3 |
+--------+---------------+
2 rows in set (0.00 sec)

