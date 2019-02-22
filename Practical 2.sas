/* Question 1 */
proc sql;
TITLE "Single Male Employee Salaries";
SELECT  Employee_ID "Employee ID",
		Salary "Annual Salary" format=COMMA10.2, 
		Salary / 3 AS Tax "Federal Tax Withdrawn" format=COMMA10.2
FROM orion.employee_payroll
WHERE Marital_Status = "S"
	AND Employee_Gender = "M"
	AND Employee_Term_Date is missing
ORDER BY Salary DESC;
TITLE;
quit;
/* Question 2 */
proc sql;
TITLE "Australian Clothing Products";
SELECT  Supplier_name "Supplier" FORMAT=$18., 
		product_Group "Group" FORMAT=$12., 
		product_name "Product" FORMAT=$30.
FROM orion.product_dim
WHERE Product_category = "Clothes"
	AND Supplier_Country = "AU"
ORDER BY product_name;
TITLE;
quit;

/* Question 3 */
proc sql;
TITLE "Cities Where Orion Star Employees Live";
SELECT City, count(*) AS Number
	FROM orion.employee_addresses
	GROUP BY City
	ORDER BY City;
TITLE;
quit;


/* Question 4 */
proc sql;
TITLE "Age at Employment";
SELECT  Employee_Id "Employee ID",
		Birth_date "Birth Date" FORMAT=MMDDYY10.,
		employee_hire_date "Hire Date" FORMAT=MMDDYY10.,
		int((Employee_Hire_Date - Birth_Date)/365.25) AS Age
		FROM orion.employee_payroll;
TITLE;
quit;
/* Question 5 */

proc sql;
TITLE "Number of Units Sold Since 1 January 2010";
SELECT 	product_table.Product_id "Product ID",
		product_table.product_name "Prodcut Name",
		sum(order_table.quantity) AS number_sold "Number of Units Sold"
	FROM orion.product_dim AS product_table 
	INNER JOIN orion.order_fact AS order_table 
	ON product_table.Product_id = order_table.Product_id
	WHERE int(Order_date-'01JAN2010'd) > 0
	GROUP BY product_table.product_name, product_table.product_id
	ORDER BY calculated number_sold DESC,
			product_table.product_name;
quit; 

/* Question 6 */
proc sql;
TITLE "Cities where Orion Star Employees Live";
SELECT  address_table.Employee_Name "Employee Name",
		address_table.City "City of Residence",
		sales_table.Job_Title "Job Title"
		FROM orion.employee_addresses AS address_table 
		LEFT JOIN orion.sales AS sales_table on address_table.employee_id = sales_table.employee_id
		ORDER BY address_table.City ASC, sales_table.job_title ASC, address_table.employee_name ASC;
TITLE;
quit;

/* Question  7 */
proc sql;
TITLE "Number of Product with Zero Sales";
SELECT 	"Number of Products",
		count(CASE WHEN order_table.Quantity = 0 THEN "None" END) AS Number
		FROM orion.product_dim AS product_table 
		JOIN orion.order_fact AS order_table
		ON product_table.Product_ID = order_table.Product_ID;
TITLE;
quit;
