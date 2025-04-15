select *
from pizza_sales ps 
where quantity >1
order by pizza_id asc 

select sum(unit_price * quantity) as total_revenue 
from pizza_sales ps 

select pizza_id,
order_id,
pizza_name_id,
order_date,
order_time,
pizza_size,
pizza_category,
pizza_ingredients,
pizza_name,
quantity,
unit_price,
round(cast (quantity * unit_price as numeric) , 2)as total_revenue,
total_price 
from pizza_sales ps ;

select pizza_name_id 
from pizza_sales ps 
group by pizza_name_id 
order by pizza_name_id asc 

select *
from pizza_sales ps 
order by pizza_id asc 

select pizza_id, count(*) 
from pizza_sales ps 
group by pizza_id 
order by pizza_id desc ;


with duplicate_cte as (
select *,
row_number () over(
partition by pizza_id,
pizza_name_id,
quantity,
order_date,
order_time,
unit_price,
total_price,
pizza_size,
pizza_category,
pizza_ingredients,
pizza_name) as row_num
from pizza_sales
)
select *
from duplicate_cte
where row_num >1;

-- another script
SELECT name_pizza , gambar_pizza
FROM pizza_type_cte3 ptc 

ALTER TABLE	pizza_type_cte3 
ADD COLUMN gambar_pizza TEXT;

update pizza_type_cte3 
set gambar_pizza = 'https://i.ibb.co.com/VcMPXv1r/big-meat-pizza-removebg-preview.png'
where name_pizza = 'The Big Meat Pizza'