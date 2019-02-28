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

*Question 3;
proc sql;

TITLE "Where orion star emplyees reside";
select  distinct upcase(country), 
		propcase(city),  
		count(*) as Count from orion.employee_addresses
group by city;
quit;

*Question 4;
proc sql;
TITLE "US and Australian
Catalogue and Internet Customers Purchasing Foreign Manufactured Products";

select customer_table.customer_name,
	count(*) as bought "Purchases"
	from orion.customer as customer_table 
	LEFT JOIN orion.order_fact as order_table
	ON customer_table.customer_id = order_table.customer_id 
	LEFT JOIN orion.product_dim as product_table
	On order_table.product_id = product_table.product_id
	where ((upcase(customer_table.country) = 'US' AND upcase(product_table.supplier_country) <> 'US') 
		OR (upcase(customer_table.country) = 'AU' AND upcase(product_table.supplier_country) <> 'AU'))
		AND order_table.employee_id = 99999999
	group by customer_table.customer_name
	order by calculated bought desc,
			customer_table.customer_name ASC
	;
quit; 

proc sql;
TITLE "US and Australian
Catalogue and Internet Customers Purchasing Foreign Manufactured Products";

select customer_table.customer_name,
	count(*) as bought "Purchases"
	from orion.product_dim as product_table 
	INNER JOIN orion.order_fact as order_table
	On order_table.product_id = product_table.product_id
	INNER JOIN orion.customer as customer_table
	ON customer_table.customer_id = order_table.customer_id 
	
	where ((upcase(customer_table.country) = 'US' AND upcase(product_table.supplier_country) <> 'US') 
		OR (upcase(customer_table.country) = 'AU' AND upcase(product_table.supplier_country) <> 'AU'))
		AND order_table.employee_id = 99999999
	group by customer_table.customer_name
	order by calculated bought desc,
			customer_table.customer_name ASC
	;
quit; 
