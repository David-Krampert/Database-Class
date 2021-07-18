/* Problem 1 */
SELECT EMP_NUM, EMP_LNAME, EMP_FNAME, EMP_INITIAL FROM constructco.employee WHERE EMP_LNAME LIKE "Smith%" ORDER BY EMP_NUM ASC; 

/* Problem 2 */
SELECT
	P.PROJ_NAME, P.PROJ_VALUE, P.PROJ_BALANCE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, J.JOB_CODE, J.JOB_DESCRIPTION, J.JOB_CHG_HOUR 
FROM 
	constructco.employee E
INNER JOIN 
	constructco.project P
ON 
	E.EMP_NUM = P.EMP_NUM
INNER JOIN
	constructco.job J
ON
	E.JOB_CODE = J.JOB_CODE;

/* Problem 3 */
SELECT
	P.PROJ_NAME, P.PROJ_VALUE, P.PROJ_BALANCE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, J.JOB_CODE, J.JOB_DESCRIPTION, J.JOB_CHG_HOUR 
FROM 
	constructco.employee E
INNER JOIN 
	constructco.project P
ON 
	E.EMP_NUM = P.EMP_NUM
INNER JOIN
	constructco.job J
ON
	E.JOB_CODE = J.JOB_CODE
ORDER BY
	E.EMP_LNAME ASC;

/* Problem 4 */
SELECT DISTINCT PROJ_NUM FROM constructco.assignment ORDER BY PROJ_NUM ASC;

/* Problem 5 */
SELECT 
	ASSIGN_NUM, EMP_NUM, PROJ_NUM, ASSIGN_CHARGE 
FROM 
	constructco.assignment A
WHERE 
	A.ASSIGN_CHARGE = (A.ASSIGN_CHG_HR * A.ASSIGN_HOURS)
ORDER BY
	A.ASSIGN_NUM ASC;
    
/* Problem 6 */
SELECT 
	A.EMP_NUM, EMP_LNAME, SUM(A.ASSIGN_HOURS) AS SumOfASSIGN_HOURS, SUM(A.ASSIGN_CHARGE) AS SumOfASSIGN_CHARGE 
FROM
	constructco.assignment A, constructco.employee E
WHERE
	A.EMP_NUM = E.EMP_NUM
GROUP BY
	A.EMP_NUM, E.EMP_LNAME
ORDER BY 
	EMP_NUM ASC;
    
/* Problem 9 */
SELECT COUNT(INV_NUMBER) FROM saleco.invoice;

/* Problem 10 */
SELECT COUNT(CUS_CODE) FROM saleco.customer WHERE CUS_BALANCE >= 500;

/* Problem 11 */
SELECT 
	C.CUS_CODE, I.INV_NUMBER, I.INV_DATE, P.P_DESCRIPT, L.LINE_UNITS, L.LINE_PRICE
FROM
	saleco.customer C
INNER JOIN(
	saleco.invoice I 
	INNER JOIN(
		saleco.product P INNER JOIN 
			saleco.line L ON P.P_CODE = L.P_CODE) ON I.INV_NUMBER = L.INV_NUMBER) ON C.CUS_CODE = I.CUS_CODE
ORDER BY
	C.CUS_CODE, I.INV_NUMBER, P.P_DESCRIPT;

/* Problem 12 */
SELECT 
	C.CUS_CODE, I.INV_NUMBER, I.INV_DATE, P.P_DESCRIPT, L.LINE_UNITS, L.LINE_PRICE, (L.LINE_UNITS * L.LINE_PRICE) AS SUBTOTAL
FROM
	saleco.customer C
INNER JOIN(
	saleco.invoice I 
	INNER JOIN(
		saleco.product P INNER JOIN 
			saleco.line L ON P.P_CODE = L.P_CODE) ON I.INV_NUMBER = L.INV_NUMBER) ON C.CUS_CODE = I.CUS_CODE
ORDER BY
	C.CUS_CODE, I.INV_NUMBER, P.P_DESCRIPT;

/* Problem 13 */
SELECT
	C.CUS_CODE, C.CUS_BALANCE, SUM(L.LINE_UNITS * L.LINE_PRICE) AS "Total Purchases"
FROM
	saleco.customer C, saleco.line L, saleco.invoice I
WHERE
	I.INV_NUMBER = L.INV_NUMBER AND C.CUS_CODE = I.CUS_CODE
GROUP BY
	C.CUS_CODE;
    
/* Problem 15 */
SELECT
	C.CUS_CODE, C.CUS_BALANCE, SUM(L.LINE_UNITS * L.LINE_PRICE) AS "Total Purchases", COUNT(L.LINE_UNITS) AS "Number of Purchase", SUM(L.LINE_UNITS * L.LINE_PRICE) / COUNT(L.LINE_UNITS) AS "Average Purchase Amount"
FROM
	saleco.customer C, saleco.line L, saleco.invoice I
WHERE
	I.INV_NUMBER = L.INV_NUMBER AND C.CUS_CODE = I.CUS_CODE
GROUP BY
	C.CUS_CODE;

/* Problem 16 */
SELECT 
	I.INV_NUMBER, SUM(L.LINE_UNITS * L.LINE_PRICE) AS "Invoice Total"
FROM
	saleco.invoice I, saleco.line L
WHERE
	I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.INV_NUMBER;

/* Problem 17 */
SELECT 
	I.CUS_CODE, I.INV_NUMBER, SUM(L.LINE_UNITS * L.LINE_PRICE) AS "Invoice Total"
FROM
	saleco.invoice I, saleco.line L
WHERE
	I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.INV_NUMBER
ORDER BY
	I.CUS_CODE;

/* Problem 18 */
SELECT 
	I.CUS_CODE, COUNT(DISTINCT L.INV_NUMBER) AS "Number of Invoices", SUM(L.LINE_UNITS * L.LINE_PRICE) AS "Total Customer Purchases"
FROM
	saleco.invoice I, saleco.line L
WHERE
	I.INV_NUMBER = L.INV_NUMBER
GROUP BY
	I.CUS_CODE
ORDER BY
	I.CUS_CODE;
    
/* Problem 19 */
SELECT 
	SUM(Invoices) AS "Total Invoices", SUM(Purchases) AS "Total Sales", MIN(Purchases) AS "Minimum Customer Purchases", MAX(Purchases) AS "Largest Customer Purchases", AVG(Purchases) AS "Average Customer Purchases"
FROM(
	SELECT 
		DISTINCT I.CUS_CODE, COUNT(DISTINCT I.INV_NUMBER) AS Invoices, SUM(L.LINE_PRICE * L.LINE_UNITS) AS Purchases 
	FROM
		saleco.customer C, saleco.invoice I, saleco.line L
	WHERE
		C.CUS_CODE = I.CUS_CODE AND I.INV_NUMBER = L.INV_NUMBER
	GROUP BY
		I.CUS_CODE
	ORDER BY
		I.CUS_CODE) AS Customer_Purchases_details;
    
    
/* Problem 20 */
SELECT 
	I.CUS_CODE, C.CUS_BALANCE
FROM
	saleco.invoice I
INNER JOIN
	saleco.customer C ON I.CUS_CODE = C.CUS_CODE
GROUP BY
	I.CUS_CODE
ORDER BY
	I.CUS_CODE;

/* Problem 21 */
SELECT MIN(CUS_BALANCE) AS "Minimum Balance", MAX(CUS_BALANCE) AS "Maximum Balance", AVG(CUS_BALANCE) AS "Average Balance"
FROM(
	SELECT
		C.CUS_CODE, C.CUS_BALANCE
	FROM 
		saleco.customer C
	WHERE 
		C.CUS_CODE 
    IN (
		SELECT 
			CUS_CODE 
		FROM 
			INVOICE
        )
	) 
AS B;

/* Problem 22 */
SELECT 
	SUM(C.CUS_BALANCE) AS "Total Balances", MIN(C.CUS_BALANCE) AS "Minnimum Balance", MAX(C.CUS_BALANCE) AS "Maximum Balance", AVG(C.CUS_BALANCE) AS "Average Balance"
FROM
	saleco.customer C; 


/* Problem 23 */
SELECT 
	C.CUS_CODE, C.CUS_BALANCE
FROM
	saleco.customer C
NATURAL LEFT JOIN
	saleco.invoice I
WHERE
	I.CUS_CODE IS NULL
GROUP BY
	C.CUS_CODE
ORDER BY
	C.CUS_CODE;

