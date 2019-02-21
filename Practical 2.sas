/* Question 1 */
proc sql;
title "Single Male Employee Salaries";
select  Employee_ID "Employee ID",
		Salary format=COMMA10.2 "Annual Salary", 
		Salary / 3 as Tax format=COMMA10.2 "Federal Tax Withdrawn"
from orion.employee_payroll
where Marital_Status = "S"
and Employee_Gender = "M"
and Employee_Term_Date is missing
order by Salary desc
;
title;
quit;
/* Question 2 */
proc sql;
title "Australian Clothing Products";
select  Supplier_name format=$18. "Supplier", 
		product_Group format=$12. "Group", 
		product_name format=$30. "Product"
from orion.product_dim
where Product_category ="Clothes"
	and Supplier_Country="AU"
order by product_name;
title;
quit;

/* Question 3 */
proc sql;
title "Cities Where Employees Live";
Select city, count(*) as Count
	from orion.employee_addresses
	group by city;
	quit;

/* Question 4 */
proc sql;
title "Age at Employment";
select  Employee_Id "Employee ID",
		Birth_date "Birth Date" format=MMDDYY10.,
		employee_hire_date "Hire Date" format=MMDDYY10.,
		int((Employee_Hire_Date - Birth_Date)/365.25) as Age

	from orion.employee_payroll;
	title;
quit;
/* Question 5 */

proc sql;
title "Number of Items Sold since 1 January 2010";
select 	a.Product_id,
		a.product_name,
		sum(b.quantity) as n "Number Sold"
from orion.product_dim as a join orion.order_fact as b 
	on a.Product_id = b.Product_id
	WHERE int(Order_date-'01JAN2010'd) > 0
	group by a.product_name, a.product_id
	order by calculated n desc, a.product_name;
quit; 

/* Question 6 */
proc sql;
title;
select  a.employee_name,
		a.city,
		b.job_title "Job Title"
	from orion.employee_addresses as a 
	left join orion.sales as b on a.employee_id = b.employee_id
	order by a.city asc, b.job_title, a.employee_name;
quit;

/* Question  7 */
proc sql;
select b.quantity,
		a.product_name,
		a.product_id
		from orion.product_dim as a join orion.order_fact as b
		on a.product_id = b.product_id
		where b.quantity = 0
	;
quit;
