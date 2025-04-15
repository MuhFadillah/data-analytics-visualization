SELECT *
FROM  details d 

SELECT *
FROM orders o 

ALTER TABLE orders 
ALTER COLUMN "Order Date" TYPE date
USING TO_DATE("Order Date", 'DD/MM/YYYY');

CREATE MATERIALIZED VIEW baru AS
WITH 
mixed_cte AS (
	SELECT 
		d."Order ID" ,
		d."Amount" ,
		d."Quantity" ,
		d."Category" ,
		d."Sub-Category" ,
		d."PaymentMode" ,
		o."Order Date" ,
		o."CustomerName" ,
		o."State" ,
		o."City" 
	FROM details d 
	JOIN orders o 
	ON d."Order ID" = o."Order ID" 
),
mixed_cte2 AS (
	SELECT *,
		round(CAST ("Amount" AS numeric) / CAST("Quantity" AS NUMERIC ),2) AS unit_price
	FROM  mixed_cte
),
mixed_cte3 AS (
	SELECT *,
		round((unit_price * 0.7 ),2) AS estimated_unit_cost
	FROM mixed_cte2
),
mixed_cte4 AS (
	SELECT *,
		round((unit_price - estimated_unit_cost),2) AS profit_per_unit
	FROM  mixed_cte3
),
mixed_cte5 AS (
	SELECT *,
		CAST("Quantity" AS NUMERIC) * CAST (profit_per_unit AS NUMERIC) AS estimated_profit_amount
	FROM mixed_cte4 
)
SELECT * FROM mixed_cte5;

-----------------------------------------------------------------------------
WITH 
mixed_cte AS (
	SELECT 
		d."Order ID" ,
		d."Amount" ,
		d."Quantity" ,
		d."Category" ,
		d."Sub-Category" ,
		d."PaymentMode" ,
		o."Order Date" ,
		o."CustomerName" ,
		o."State" ,
		o."City" 
	FROM details d 
	JOIN orders o 
	ON d."Order ID" = o."Order ID" 
),
mixed_cte2 AS (
	SELECT *,
		round(CAST ("Amount" AS numeric) / CAST("Quantity" AS NUMERIC ),2) AS unit_price
	FROM  mixed_cte
),
mixed_cte3 AS (
	SELECT *,
		round((unit_price * 0.7 ),2) AS estimated_unit_cost
	FROM mixed_cte2
),
mixed_cte4 AS (
	SELECT *,
		round((unit_price - estimated_unit_cost),2) AS profit_per_unit
	FROM  mixed_cte3
),
mixed_cte5 AS (
	SELECT *,
		CAST("Quantity" AS NUMERIC) * CAST (profit_per_unit AS NUMERIC) AS estimated_profit_amount
	FROM mixed_cte4 
)
SELECT * FROM mixed_cte5;

----------------------------------
SELECT
	"Category" ,
	("Quantity" * unit_price) AS total_saless,
	"City" ,
	"Order Date" 
FROM baru b 
WHERE "City" = 'Pune'
GROUP BY 1,2,3,4 
ORDER BY total_saless DESC 


-----------------
SELECT 
    "Category", 
    SUM("Quantity" * unit_price) AS total_sales, 
    "City"
FROM baru b
WHERE "City" = 'Mumbai' 
AND "Order Date" >= DATE '2018-12-29' - integerERVAL '30' DAY
GROUP BY "Category", "City"
ORDER BY total_sales DESC

SELECT CURRENT_DATE;