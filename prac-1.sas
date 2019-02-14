Proc sql;
Select Employee_ID,
Case scan(Job_Title, -1,' ')
	when 'Manager' then 'Manager'
	when 'Director' then 'Director'
	when 'President' then 'Executive'
	when 'Officer' then 'Executive'
	Else 'Not Applicable'
End as Level, Salary,
case 
	when salary < 52000 and calculated Level = 'Manager'  then 'Low'
	when salary < 108000 and calculated Level = 'Director'  then 'Low'
	when salary < 240000 and calculated Level = 'Executive'  then 'Low'
	when salary between 52000 and 72000 and  calculated Level = 'Manager'  then 'Medium'
	when salary between 108000 and 135000 and calculated Level = 'Director'  then 'Medium'
	when salary between 240000 and 300000 and calculated Level = 'Executive'  then 'Medium'
	when salary > 72000 and calculated Level = 'Manager'  then 'High'
	when salary > 135000 and calculated Level = 'Director'  then 'High'
	when salary > 300000 and calculated Level = 'Executive'  then 'High'
	else 'Do not include in report'
end
From orion.staff where 0<= salary <=4 ;
Quit;
