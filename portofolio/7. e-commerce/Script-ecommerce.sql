select *
from  ecommerce_product_sales eps 

select "Product Name" 
from ecommerce_product_sales eps 
group by "Product Name" 

select "Category" 
from ecommerce_product_sales eps 
group by "Category" 

select "Price" 
from ecommerce_product_sales eps 
group by "Price" 

select "Price" 
from ecommerce_product_sales eps 
where "Price" is null 

select "Quantity" 
from ecommerce_product_sales eps 
where "Quantity" is null 

select "Customer Age"
from ecommerce_product_sales eps 
where "Customer Age" is null 

select "Customer Gender"
from ecommerce_product_sales eps 
group by "Customer Gender"

select "Discount"
from ecommerce_product_sales eps 
where "Discount" is null 

select "Payment Method"
from ecommerce_product_sales eps 
group by "Payment Method"

select "Region"
from ecommerce_product_sales eps 
group by "Region"

alter table ecommerce_product_sales 
alter column "Sale Date" type date
using "Sale Date"::date;

with duplicate_cte as (
select *,
row_number () over (partition by "Sale ID") as row_num 
from ecommerce_product_sales eps 
)
select *
from duplicate_cte
where row_num >1;


select "Region","Product Name",
"Price", 
"Quantity",
round(cast ("Price" / "Quantity" as decimal),2) as harga_satuan
from ecommerce_product_sales eps 
group by "Region","Product Name" ,"Price" ,"Quantity" 


