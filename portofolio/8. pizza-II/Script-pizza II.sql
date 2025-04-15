SELECT *
FROM order_details od 

SELECT *
FROM orders o 

SELECT *
FROM pizza_types pt 

SELECT *
FROM  pizzas p 

WITH pizza_type_cte AS (
SELECT 
	pt.pizza_type_id AS id_pizza_type,
	pt."name" AS name_pizza,
	pt.category AS category_pizza,
	p.pizza_id AS id_size_pizza,
	p."size" AS size_pizza,
	p.price AS pizza_price
FROM pizza_types pt 
JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id),
pizza_type_cte2 AS (
SELECT
	id_pizza_type,
	name_pizza,
	category_pizza,
	id_size_pizza,
	size_pizza,
	pizza_price,
	od.order_details_id AS detail_order,
	od.order_id AS id_order,
	od.quantity
FROM pizza_type_cte
JOIN order_details od 
ON id_size_pizza = od.pizza_id),
pizza_type_cte3 AS (
SELECT 
	id_pizza_type,
	name_pizza,
	category_pizza,
	id_size_pizza,
	size_pizza,
	pizza_price,
	detail_order,
	id_order,
	quantity,
	o."date",
	o."time"
FROM pizza_type_cte2
JOIN orders o 
ON id_order = o.order_id)
SELECT *
FROM pizza_type_cte3 








WITH pizza_type_cte AS (
SELECT 
	pt.pizza_type_id AS id_pizza_type,
	pt."name" AS name_pizza,
	pt.category AS category_pizza,
	p.pizza_id AS id_size_pizza,
	p."size" AS size_pizza,
	p.price AS pizza_price
FROM pizza_types pt 
JOIN pizzas p 
ON pt.pizza_type_id = p.pizza_type_id ),
pizza_type_cte2 AS (
SELECT
	id_pizza_type,
	name_pizza,
	category_pizza,
	id_size_pizza,
	size_pizza,
	pizza_price,
	od.order_details_id AS detail_order,
	od.order_id AS id_order,
	od.quantity
FROM pizza_type_cte
JOIN order_details od 
ON id_size_pizza = od.pizza_id),
pizza_type_cte3 AS (
SELECT 
	id_pizza_type,
	name_pizza,
	category_pizza,
	id_size_pizza,
	size_pizza,
	pizza_price,
	detail_order,
	id_order,
	quantity,
	o."date",
	o."time"
FROM pizza_type_cte2
JOIN orders o 
ON id_order = o.order_id)
SELECT 	
	detail_order,
	id_order,
	name_pizza,
	size_pizza,
	id_size_pizza,
	"date",
	"time",
	pizza_price,
	quantity,
	round(CAST ("pizza_price" * "quantity" AS decimal),2) AS total_amount,
	category_pizza,
	id_pizza_type
FROM pizza_type_cte3 

ALTER TABLE orders 
ALTER COLUMN  "date" TYPE date 
USING "date"::date;

ALTER TABLE	 orders 
ALTER COLUMN  "time" TYPE time 
USING  "time"::time;




