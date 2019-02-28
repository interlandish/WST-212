proc sql;
select 'Total Number of Customers', 
		count(*) as Count
		from orion.customer
		union 
select 'Total Number of Male Customers',
			 count(*) as Count from orion.customer
			 where gender = 'M'
		union 
select 'Total Number of Female Customers',
			 count(*) as Count from orion.customer
			 where gender = 'F'
		union 
select 'Total Percent of Male Customers',
			 count(case when gender = 'M' then 'n' end)/count(*) as Count
		from orion.customer

;
quit;
