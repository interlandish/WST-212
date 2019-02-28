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

* Question 1;
proc sql;
TITLE "Customer Demographics: Gender by Country";
select 	country,
		Count(*) as count "Total",
		count(case when gender = 'M' then 'n' end) as A "Count Male",
		count(case when gender = 'F' then 'n' end) as B "Count Female",
		count(case when gender = 'M' then 'n' end)/count(*) as C "Percent Male" format=percent10.2
		from orion.customer
		group by country 
		order by calculated C ASC;
quit; 

*Question 2;
proc sql;
TITLE "Countries with More Female than Male";
select  country "Country",
		count(case when gender = 'M' then 'n' end) as Male "Male Customers" ,
		count(case when gender = 'F' then 'n' end) as Female "Female Customers"
		from orion.customer
		group by country
		having male < female
		order by Female desc;

quit;

