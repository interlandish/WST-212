proc sql;
TITLE "Single Male Employee Salaries";
select Employee_ID "Employee ID",
 	Salary format=COMMA10.2 ,
 	Salary/3 as Tax format=COMMA10.2
 	from orion.employee_payroll
 	where Marital_Status="S"
 	and Employee_Gender ="M"
	and Employee_Term_Date is missing
	ORDER BY Salary desc
	;
quit;
