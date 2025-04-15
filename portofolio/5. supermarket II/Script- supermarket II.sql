select *
from supermarket_sales ss 

select "City" 
from supermarket_sales ss 
group by "City" 

alter table supermarket_sales 
alter column "Date" type date using "Date"::date;

alter table supermarket_sales 
alter column "Time" type time using "Time"::time;

alter table supermarket_sales 
rename column "Total" to Total_after_Tax

---------------------------------------------------------------------------------------------------------------

with sales_cte as (
select "Invoice ID" ,
		"Branch" ,
		"City" ,
		"Customer type" ,
		"Gender" ,
		"Product line" ,
		"Date" ,
		"Time",
		"Unit price" ,
		"Quantity" ,
		"Tax 5%" ,
		round(cast("Unit price" * "Quantity" as numeric),2) as total_before_tax,
		"total_after_tax" ,
		"Payment" ,
		"Rating" 
from supermarket_sales ss )
select *
from sales_cte
order by "Date" asc 

---------------------------------------------------------------------------------------------------------------------------------------

select avg("Rating")
from supermarket_sales ss 

select *
from supermarket_sales ss 

-----------------------------------------------------------------------------------------------------------------------------

round(cast("Unit price" * "Quantity" as numeric),2) as total_before_tax,

"Invoice ID" ,
"Branch" ,
"City" ,
"Customer type" ,
"Gender" ,
"Product line" ,
"Date" ,
"Time",
"Unit price" ,
"Quantity" ,
"Tax 5%" ,
"total_before_tax",
"total_after_tax" ,


------------------------------------------- CARA BIKIN WITH CTE--------------------------------------------------------

with sales_cte as (
select "Invoice ID" ,
		"Branch" ,
		"City" ,
		"Customer type" ,
		"Gender" ,
		"Product line" ,
		"Date" ,
		"Time",
		"Unit price" ,
		"Quantity" ,
		"Tax 5%" ,
		round(cast("Unit price" * "Quantity" as numeric),2) as total_before_tax,
		"total_after_tax" ,
		"Payment" ,
		"Rating" 
from supermarket_sales ss ),  
sales_cte2 as (
select 	*,
	"total_before_tax" / "Quantity" as total_cost
from sales_cte
),
sales_cte3 as(
select *,
	blablablabla * blablablablabla as gross_income
from sales_cte2
)
select 
	"Invoice ID" ,
	"Branch" ,
	"City" ,
	"Customer type" ,
	"Gender" ,
	"Product line" ,
	"Date" ,
	"Time",
	"Unit price" ,
	"Quantity" ,
	"Tax 5%",
	"total_before_tax",
	"total_after_tax",
	"total_cost",
	round(cast("total_cost" * "Tax 5%" as numeric),2) as total_tax,
	"Payment" ,
	"Rating"
from sales_cte3;

-------------------------------------------------------------------------------------------