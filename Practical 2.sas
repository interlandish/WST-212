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
quit;
/* Question 5 */
proc sql;
