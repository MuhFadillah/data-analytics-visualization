--Data Formating from tables currencyexchange--

SELECT *
FROM currencyexchange c 

ALTER TABLE	currencyexchange 
ALTER COLUMN "Date" TYPE date 
USING "Date":: date;





SELECT 	*
FROM customer c 

SELECT * 
FROM orderrows o 

SELECT *
FROM orders o

SELECT *
FROM  product p 

SELECT *
FROM sales s

SELECT *
FROM  store s 


-----------------------------------------------------------------------
--Data cleansing,formating, Data Standarization from tables customer--

UPDATE customer 
SET "Occupation" = INITCAP("Occupation"),
"Company" = INITCAP("Company")
WHERE "CustomerKey"  BETWEEN 1 AND 3000000;

ALTER TABLE	customer 
ALTER COLUMN "Birthday" TYPE date 
USING "Birthday":: date;

UPDATE customer 
SET "Age" = EXTRACT ( YEAR FROM age(current_date,"Birthday"))
WHERE "CustomerKey" BETWEEN 1 AND 3000000;

ALTER TABLE customer 
DROP COLUMN "Latitude", 
DROP COLUMN "Longitude";

SELECT 
"Vehicle" ,
split_part("Vehicle",' ',1) AS year_vehicle ,
substring("Vehicle" FROM POSITION(' 'IN "Vehicle") + 1 ) AS Vehicle_clean
FROM customer c 

ALTER TABLE customer 
ADD COLUMN year_vehicle TEXT,
ADD COLUMN vehicle_clean TEXT;

UPDATE customer 
SET year_vehicle = split_part("Vehicle",' ',1) ,
vehicle_clean = substring("Vehicle" FROM POSITION(' 'IN "Vehicle") + 1 )
WHERE "CustomerKey" BETWEEN 1 AND 3000000;

ALTER TABLE customer 
DROP COLUMN "Vehicle";

ALTER TABLE	customer 
ALTER COLUMN "EndDT" TYPE date 
USING "EndDT":: date;



-----------------------------------------------------------------------------------------------------
--Data cleansing,formating, Data Standarization from tables orderrows--

SELECT * 
FROM orderrows o 

ALTER TABLE orderrows 
DROP COLUMN "LineNumber";

UPDATE orderrows 
SET "NetPrice" = round(CAST("NetPrice" AS numeric),2)
WHERE "OrderKey" BETWEEN 1 AND 400000;

UPDATE orderrows 
SET "UnitPrice" = round(CAST("UnitPrice" AS numeric),2)
WHERE "OrderKey" BETWEEN 1 AND 400000;

UPDATE orderrows 
SET "UnitCost" = round(CAST("UnitCost" AS numeric),2)
WHERE "OrderKey" BETWEEN 1 AND 400000;


-----------------------------------------------------------------------------------------------------
--Data cleansing,formating, Data Standarization from tables orders--

SELECT *
FROM orders o 

delete 
from orders 
where "StoreKey" ='999999'

ALTER TABLE orders 
ALTER COLUMN "OrderDate" TYPE date
USING "OrderDate":: date;

ALTER TABLE orders 
ALTER COLUMN "DeliveryDate" TYPE date
USING "DeliveryDate":: date;

-----------------------------------------------------------------------------------------------------
--Data cleansing,formating, Data Standarization from tables product--

SELECT *
FROM  product p 

UPDATE product 
SET "WeightUnit" = INITCAP("WeightUnit")
WHERE "ProductKey"  BETWEEN 1 AND 3000;

UPDATE product 
SET "Price" = round(CAST("Price" AS numeric),2)
WHERE "ProductKey" BETWEEN 1 AND 3000;

UPDATE product 
SET "Cost" = round(CAST("Cost" AS numeric),2)
WHERE "ProductKey" BETWEEN 1 AND 3000;

delete 
from product 
where "Weight" IS NULL 

-----------------------------------------------------------------------------------------------------
--Data cleansing,formating, Data Standarization from tables sales--

SELECT *
FROM sales s 

delete 
from sales 
where "StoreKey" ='999999'

ALTER TABLE sales 
DROP COLUMN "LineNumber";

ALTER TABLE sales 
DROP COLUMN "ExchangeRate";

ALTER TABLE	sales 
ALTER COLUMN "DeliveryDate" TYPE date 
USING "DeliveryDate":: date;

ALTER TABLE	sales 
ALTER COLUMN "OrderDate" TYPE date 
USING "OrderDate":: date;

UPDATE sales 
SET "UnitCost" = round(CAST("UnitCost" AS numeric),2)
WHERE "OrderKey" BETWEEN 1 AND 400000;

UPDATE sales 
SET "NetPrice" = round(CAST("NetPrice" AS numeric),2)
WHERE "OrderKey" BETWEEN 1 AND 400000;

UPDATE sales 
SET "UnitPrice" = round(CAST("UnitPrice" AS numeric),2)
WHERE "OrderKey" BETWEEN 1 AND 400000;

-------------------------------------------------------------------------------

SELECT *
FROM  store s 

---------------------------------------------------------------
----------------------Data Transformation----------------------

CREATE MATERIALIZED VIEW baruu AS 
WITH cte AS (
SELECT 
	c."CustomerKey" ,
	c."Continent" ,
	c."Gender" ,
	c."GivenName" ,
	c."StateFull" ,
	c."CountryFull" ,
	c."Age" ,
	c.vehicle_clean ,
	s."OrderKey" ,
	s."OrderDate" ,
	s."DeliveryDate" ,
	s."ProductKey" ,
	s."Quantity" ,
	s."UnitPrice" ,
	s."NetPrice" ,
	s."UnitCost" 
FROM customer c 
JOIN sales s 
ON c."CustomerKey" = s."CustomerKey" 
),
cte2 AS (
SELECT 	
	cte."CustomerKey" ,
	cte."Continent" ,
	cte."Gender" ,
	cte."GivenName" ,
	cte."StateFull" ,
	cte."CountryFull" ,
	cte."Age" ,
	cte.vehicle_clean ,
	cte."OrderKey" ,
	cte."OrderDate" ,
	cte."DeliveryDate" ,
	cte."ProductKey" ,
	cte."Quantity" ,
	cte."UnitPrice" ,
	cte."NetPrice" ,
	cte."UnitCost" 
FROM cte
JOIN orderrows o 
ON cte."OrderKey" = o."OrderKey"
AND	cte."ProductKey" = o."ProductKey"
),
cte3 AS (
SELECT 
	cte2."CustomerKey" ,
	cte2."Continent" ,
	cte2."Gender" ,
	cte2."GivenName" ,
	cte2."StateFull" ,
	cte2."CountryFull" ,
	cte2."Age" ,
	cte2.vehicle_clean ,
	cte2."OrderKey" ,
	cte2."OrderDate" ,
	cte2."DeliveryDate" ,
	cte2."ProductKey" ,
	cte2."Quantity" ,
	cte2."UnitPrice" ,
	cte2."NetPrice" ,
	cte2."UnitCost" ,
	p."ProductName",
	p."CategoryName",
	p."SubCategoryName"
FROM cte2
JOIN product p 
ON cte2."ProductKey" = p."ProductKey"
)
SELECT * 
FROM cte3
ORDER BY "CustomerKey" ASC 


SELECT count(*) 
FROM baruu b 
WHERE "CountryFull" = 'France'

SELECT *
FROM baruu b 
ORDER BY "CustomerKey" ASC 

----highest Total sales in 2023-2024-------

SELECT 
    "CategoryName", 
    round(CAST (SUM("Quantity" * "UnitPrice") AS NUMERIC),2) AS total_sales, 
    "CountryFull"
FROM baruu b 
WHERE "OrderDate" >= DATE '2024-03-13' - integerERVAL '365' DAY
GROUP BY "CategoryName", "CountryFull"
ORDER BY total_sales DESC
LIMIT 5