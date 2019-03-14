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
