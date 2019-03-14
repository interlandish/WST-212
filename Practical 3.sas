*Question 1;


*Question 2;
proc sql;
TITLE "Employees with phone numbers, without addresses";
SELECT  employee_id "Employee ID"
		FROM orion.employee_phones
		EXCEPT
		SELECT employee_id
		FROM orion.employee_addresses

TITLE;
quit; 

*Question 3;
proc sql;
TITLE   "Customers who have placed orders";
SELECT  customer_id "Customer ID"
		FROM orion.customer
		INTERSECT 
		SELECT customer_id 
		FROM orion.order_fact;
TITLE;
quit;

*Question 4;
proc sql;
SELECT  "Total Paid to All Female Sales Representatives",
		sum(Salary) format=dollar15.2 "Total Salary",
		Count(*) "Number"
		FROM orion.salesstaff 
		WHERE upcase(Gender) = 'F'
		AND Job_title LIKE '%Rep%'
		UNION
		SELECT  "Total Paid to All Male Sales Representatives",
		sum(Salary) format=dollar15.2,
		Count(*)
		FROM orion.salesstaff 
		WHERE upcase(Gender) = 'M'
		AND Job_title LIKE '%Rep%';
quit;
