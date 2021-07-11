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

/* UC-8 */
mysql> ALTER TABLE employee_payroll ADD phone_number VARCHAR(250) AFTER name;
Query OK, 0 rows affected (2.73 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD address VARCHAR(250) AFTER phone_number;
Query OK, 0 rows affected (1.34 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD department VARCHAR(150) NOT NULL AFTER address;
Query OK, 0 rows affected (1.80 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ALTER address SET DEFAULT 'TBD';
Query OK, 0 rows affected (0.30 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int          | NO   | PRI | NULL    | auto_increment |
| name         | varchar(100) | NO   |     | NULL    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | TBD     |                |
| department   | varchar(150) | NO   |     | NULL    |                |
| salary       | int          | NO   |     | NULL    |                |
| start        | date         | YES  |     | NULL    |                |
| gender       | char(1)      | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
8 rows in set (0.02 sec)

/* UC-9 */
mysql> ALTER TABLE employee_payroll RENAME COLUMN salary TO basic_pay;
Query OK, 0 rows affected (0.22 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD deductions Double NOT NULL AFTER basic_pay;
Query OK, 0 rows affected (2.15 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD taxable_pay Double NOT NULL AFTER deductions;
Query OK, 0 rows affected (1.46 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD tax Double NOT NULL AFTER taxable_pay;
Query OK, 0 rows affected (2.27 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD net_pay Double NOT NULL AFTER tax;
Query OK, 0 rows affected (1.47 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
| id | name    | phone_number | address | department | basic_pay | deductions | taxable_pay | tax | net_pay | start      | gender |
+----+---------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
|  1 | Merrisa | NULL         | NULL    |            |   3200000 |          0 |           0 |   0 |       0 | 2021-07-03 | F      |
|  2 | Bill    | NULL         | NULL    |            |   1000000 |          0 |           0 |   0 |       0 | 2021-07-09 | M      |
|  3 | Mary    | NULL         | NULL    |            |   1200000 |          0 |           0 |   0 |       0 | 2021-07-09 | F      |
|  4 | David   | NULL         | NULL    |            |   2200000 |          0 |           0 |   0 |       0 | 2021-07-02 | M      |
|  5 | John    | NULL         | NULL    |            |   5000000 |          0 |           0 |   0 |       0 | 2021-04-06 | M      |
+----+---------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
5 rows in set (0.00 sec)

/* UC-10 */
mysql> UPDATE employee_payroll
    -> SET department = 'Sales' WHERE name = 'Merrisa';
Query OK, 1 row affected (0.09 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
| id | name    | phone_number | address | department | basic_pay | deductions | taxable_pay | tax | net_pay | start      | gender |
+----+---------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
|  1 | Merrisa | NULL         | NULL    | Sales      |   3200000 |          0 |           0 |   0 |       0 | 2021-07-03 | F      |
|  2 | Bill    | NULL         | NULL    |            |   1000000 |          0 |           0 |   0 |       0 | 2021-07-09 | M      |
|  3 | Mary    | NULL         | NULL    |            |   1200000 |          0 |           0 |   0 |       0 | 2021-07-09 | F      |
|  4 | David   | NULL         | NULL    |            |   2200000 |          0 |           0 |   0 |       0 | 2021-07-02 | M      |
|  5 | John    | NULL         | NULL    |            |   5000000 |          0 |           0 |   0 |       0 | 2021-04-06 | M      |
+----+---------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
5 rows in set (0.03 sec)

mysql> INSERT INTO employee_payroll
    -> (name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) VALUES
    -> ('Merrisa', 'Marketing', 'F', 300000.00, 100000.00, 200000.00, 500000.00, 150000.00, '2021-03-01');
Query OK, 1 row affected (0.07 sec)

mysql> SELECT * FROM employee_payroll WHERE name = 'Merrisa';
+----+---------+--------------+---------+------------+-----------+------------+-------------+--------+---------+------------+--------+
| id | name    | phone_number | address | department | basic_pay | deductions | taxable_pay | tax    | net_pay | start      | gender |
+----+---------+--------------+---------+------------+-----------+------------+-------------+--------+---------+------------+--------+
|  1 | Merrisa | NULL         | NULL    | Sales      |   3200000 |          0 |           0 |      0 |       0 | 2021-07-03 | F      |
|  6 | Merrisa | NULL         | TBD     | Marketing  |    300000 |     100000 |      200000 | 500000 |  150000 | 2021-03-01 | F      |
+----+---------+--------------+---------+------------+-----------+------------+-------------+--------+---------+------------+--------+
2 rows in set (0.10 sec)
