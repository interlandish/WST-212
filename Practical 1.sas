/* Question 1 */
proc sql;
SELECT Employee_ID, Employee_Gender, Marital_Status, Salary FROM orion.employee_payroll;
quit;

/* Question 2 */
proc SQL;
SELECT Employee_ID, Employee_Gender, Marital_Status, Salary, Salary * (1/3) AS Tax FROM orion.employee_payroll;
quit;

/* Question 3 */
proc sql;
CREATE TABLE WORK.Bonus AS 
SELECT Employee_ID, Salary, Salary * 0.04 AS Bonus FROM orion.employee_payroll;
SELECT * FROM WORK.Bonus;
quit;

/* Question 4 */
proc sql;
SELECT Employee_ID,
CASE scan (Job_Title, -1,' ')
	WHEN 'Manager' THEN 'Manager'
	WHEN 'Director' THEN 'Director'
	WHEN 'President' THEN 'Executive'
	WHEN 'Officer' THEN 'Executive'
	ELSE 'Not Applicable'
END AS Level, Salary,
CASE
	WHEN salary < 52000 AND calculated Level = 'Manager' THEN 'Low'
	WHEN salary < 108000 AND calculated Level = 'Director' THEN 'Low'
	WHEN salary < 240000 AND calculated Level = 'Executive' THEN 'Low'
	WHEN salary between 52000 AND 72000 AND calculated Level = 'Manager' THEN 'Medium'
	WHEN salary between 108000 AND 135000 AND calculated Level = 'Director' THEN 'Medium'
	WHEN salary between 240000 AND 300000 AND calculated Level = 'Executive' THEN 'Medium'
	WHEN salary > 72000 AND calculated Level = 'Manager' THEN 'High'
	WHEN salary > 135000 AND calculated Level = 'Director' THEN 'High'
	WHEN salary > 300000 AND calculated Level = 'Executive' THEN 'High'
	ELSE 'Do not include in report'
END AS Salary_Range
FROM orion.staff WHERE calculated Level <> 'Not Applicable';
Quit;

/* Question 5 */
PROC SQL;
SELECT DISTINCT City FROM orion.employee_addresses;
quit;

/* Question 6 */
proc sql;
SELECT Employee_ID, Recipients, (Qtr1 + Qtr2 + Qtr3 + Qtr4) AS Total FROM orion.employee_donations
WHERE calculated Total > 90;
quit;
