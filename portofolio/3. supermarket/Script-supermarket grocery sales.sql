select *
from supermart_grocery_sales sgs 

with duplicate_cte as (
select *,
row_number ()over(partition by "Order ID",
"Customer Name",
"Category",
"Sub Category",
"City",
"Order Date",
"Region",
"Sales",
"Discount",
"Profit",
"State") as row_num
from supermart_grocery_sales sgs)
select *
from duplicate_cte
where row_num >1;


select * 
from supermart_grocery_sales sgs 
where "Order ID" IS NULL OR "Order ID" = ''
OR "Customer Name" IS NULL OR "Customer Name" = ''
OR "Category" IS NULL OR "Category" = ''
OR "Sub Category" IS NULL OR "Sub Category" = ''
OR "City" IS NULL OR "City" = ''
OR "Order Date" IS NULL
OR "Region" IS NULL OR "Region"= ''
OR "Sales" IS NULL
OR "Discount" IS NULL
OR "Profit" IS NULL 
OR "State" IS NULL OR "State" = '';