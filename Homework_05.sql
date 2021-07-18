/* Your Name goes below */
/*David Krampert*/
set session sql_safe_updates = off; 

use constructco;

drop table cust_mysql;
drop table invoice;
drop table customer;
drop table emp_1;
drop table emp_2;

/*1*/
/* Your code goes below*/

CREATE TABLE EMP_1(
EMP_NUM VARCHAR(3) PRIMARY KEY,
EMP_LNAME VARCHAR(15) NOT NULL,
EMP_FNAME VARCHAR(15) NOT NULL,
EMP_INITIAL VARCHAR(1),
EMP_HIREDATE DATE,
JOB_CODE VARCHAR(3),
FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE));

describe emp_1; /*for grading*/

/*2*/
/*Your code goes below*/

INSERT INTO EMP_1 VALUES('101', 'News', 'John', 'G', '2000-11-08', '502');
INSERT INTO EMP_1 VALUES('102', 'Senior', 'David', 'H', '1989-12-07', '501');

select * from emp_1;

/*3*/
/* Your code goes below*/

INSERT INTO EMP_1
SELECT DISTINCT EMP_NUM,EMP_LNAME,EMP_FNAME,EMP_INITIAL,EMP_HIREDATE,JOB_CODE FROM employee
WHERE EMP_NUM BETWEEN 103 AND 109;
-- 3 
select * from emp_1;

/*4*/
/* Your code goes below*/
COMMIT;
/*5*/
/* Your code goes below*/
UPDATE EMP_1
SET
	JOB_CODE = '501'
WHERE
	EMP_NUM = '107';

select emp_num, job_code from EMP_1 order by emp_num;
/*6*/
/* Your code goes below*/
DELETE FROM 
	EMP_1 
WHERE 
	EMP_FNAME = "William" AND EMP_LNAME = "Smithfield" AND JOB_CODE = '500';

select * from emp_1;

/*7*/
/* Your code goes below*/
CREATE TABLE 
	EMP_2 
SELECT
	EMP_NUM,EMP_LNAME,EMP_FNAME,EMP_INITIAL,EMP_HIREDATE,JOB_CODE
FROM
	EMP_1;

describe EMP_2;
/*8*/
/* Your code goes below*/
ALTER TABLE EMP_2
ADD EMP_PCT DECIMAL(4,2),
ADD  PROJ_NUM CHAR(3);

describe emp_2;
/*9*/
/* Your code goes below*/
UPDATE EMP_2
SET
	EMP_PCT = '3.85'
WHERE
	EMP_NUM = '103';
    
select emp_num, emp_pct from emp_2 order by emp_num;

/*10*/
/* Your code goes below*/
UPDATE EMP_2
SET
	EMP_PCT = '5.00'
WHERE
	EMP_NUM = '101' OR EMP_NUM = '105' OR EMP_NUM = '107';
select emp_num, emp_pct from emp_2;

/*11*/
/* Your code goes below*/
UPDATE EMP_2
SET
	EMP_PCT = '10.00'
WHERE
	EMP_PCT IS NULL;
select emp_num, emp_pct from emp_2;

/*12*/
/* Your code goes below*/
UPDATE EMP_2
SET
	EMP_PCT = EMP_PCT + '0.15'
WHERE
	EMP_LNAME = 'Alonzo' AND EMP_INITIAL = "D" AND EMP_FNAME ='Maria';

select emp_lname, emp_num, emp_pct from emp_2;

/*13*/
/* Your code goes below*/
UPDATE EMP_2
SET
	PROJ_NUM = '18'
WHERE
	JOB_CODE = '500';
select  * from emp_1;
/*14*/
/* Your code goes below*/
UPDATE EMP_2
SET
	PROJ_NUM = '25'
WHERE
	JOB_CODE >= '502';
select  * from emp_2;

/*15*/
/* Your code goes below*/
UPDATE EMP_2
SET
	PROJ_NUM = '14'
WHERE
	EMP_HIREDATE < '1994-01-01' AND JOB_CODE >= '501';
select  * from emp_2;

/*16*/
/* Your code goes below*/
CREATE TABLE CUSTOMER(
CUST_NUM VARCHAR(4) PRIMARY KEY,
CUST_LNAME VARCHAR(30) NOT NULL,
CUST_FNAME VARCHAR(30) NOT NULL,
CUST_BALANCE DECIMAL(6,2));

describe customer;

/*17*/
/* Your code goes below*/
CREATE TABLE INVOICE(
INV_NUM VARCHAR(4) PRIMARY KEY,
CUST_NUM VARCHAR(4),
FOREIGN KEY (CUST_NUM) REFERENCES CUSTOMER(CUST_NUM),
INV_DATE DATE,
INV_AMOUNT DECIMAL(8,2));
describe invoice;
/*18*/
/* Your code goes below*/
INSERT INTO CUSTOMER VALUES('1000',"Smith","Jeanne",'1050.11');
INSERT INTO CUSTOMER VALUES('1001',"Ortega","Juan",'840.92');
select * from customer;
/*19*/
/* Your code goes below*/
INSERT INTO INVOICE VALUES('8000','1000','2016-03-23','235.89');
INSERT INTO INVOICE VALUES('8001','1001','2016-03-23','312.82');
INSERT INTO INVOICE VALUES('8002','1001','2016-03-30','528.10');
INSERT INTO INVOICE VALUES('8003','1000','2016-03-12','194.78');
INSERT INTO INVOICE VALUES('8004','1000','2016-03-23','619.44');

select * from invoice;
/*20*/
/* Your code goes below*/
CREATE TABLE BACKUPCUST LIKE CUSTOMER;
INSERT BACKUPCUST SELECT * FROM CUSTOMER;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE CUSTOMER;
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE BACKUPCUST DROP CUST_NUM;
ALTER TABLE BACKUPCUST ADD CUST_NUM_SEQ INT PRIMARY KEY AUTO_INCREMENT;
INSERT CUSTOMER (CUST_NUM, CUST_LNAME, CUST_FNAME, CUST_BALANCE) SELECT CUST_NUM_SEQ, CUST_LNAME, CUST_FNAME, CUST_BALANCE FROM BACKUPCUST;
DROP TABLE BACKUPCUST;

select * from cust_mysql;
describe cust_mysql;
