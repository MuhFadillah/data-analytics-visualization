select *
from car_prices cp 

select count(*) 
from car_prices cp 


select "condition"
from  car_prices cp 
group by "condition" ~

select state
from  car_prices cp 
group by state ~

select color
from  car_prices cp 
group by color ~

select integererior
from  car_prices cp 
group by integererior ~

select seller
from  car_prices cp 
group by seller ~

select sellingprice
from  car_prices cp 
group by sellingprice ~

select saledate
from  car_prices cp 
group by saledate 

select odometer
from  car_prices cp 
group by odometer ~

select transmission
from  car_prices cp 
group by transmission ~

select body, count(*) 
from  car_prices cp 
group by body 

select trim
from  car_prices cp 
group by trim

select model
from  car_prices cp 
group by model 

select make
from  car_prices cp 
group by make 

select "year"
from  car_prices cp 
group by "year" 

select vin
from  car_prices cp 
group by vin


delete 
from car_prices cp 
where color ='—'
or color =''
or color = '1167' 
or color = '11034' 
or color = '12655' 
or color = '14872'
or color = '14872'
or color = '15719'
or color = '16633'
or color = '18384'
or color = '18561'
or color = '20379'
or color = '20627'
or color = '2172'
or color = '2711'
or color = '2817'
or color = '2846'
or color = '339'
or color = '4802'
or color = '5001'
or color = '5705'
or color = '6158'
or color = '6388'
or color = '6864'
or color = '721'
or color = '9410'
or color = '9562'
or color = '9837'
or color = '9887'

delete 
from car_prices cp 
where integererior ='—'

delete 
from car_prices cp 
where "condition" is null 

delete 
from car_prices cp 
where sellingprice is null 

delete 
from car_prices cp 
where odometer is null 

delete 
from car_prices cp 
where transmission =''

delete 
from car_prices cp 
where body =''

delete 
from car_prices cp 
where trim ='!' or trim = '+'

delete 
from car_prices cp 
where model =''

UPDATE car_prices 
SET saledate = REPLACE(saledate, 'GMT-0700 (PST)', '')
where "year" between 1 and 438644


ALTER TABLE car_prices 
ALTER COLUMN saledate 
SET DATA TYPE TIMESTAMP WITHOUT TIME ZONE 
USING to_timestamp(saledate, 'Dy Mon DD YYYY HH24:MI:SS');

with duplicate_cte as (
select *,
	row_number () over(partition by "year",
	make,
	model,
	trim,
	body,
	transmission,
	vin,
	state,
	"condition",
	odometer,
	color,
	integererior,
	seller,
	mmr,
	sellingprice,
	saledate) as row_num
from car_prices cp
)
select *
from duplicate_cte
where row_num >1;

delete 
from car_prices 
where sellingprice between 1 and 9999

delete 
from car_prices 
where "year" between 1 and 2009

alter table car_prices 
drop column 'Vin'

alter table  car_prices 
add column car_image text;

alter table  car_prices 
add column logo_image text;

update car_prices 
set logo_image = 'https://i.ibb.co.com/k2hzxvr6/BMW.png'
where make = 'BMW'

update car_prices 
set car_image = 'https://i.ibb.co.com/TxVmZ443/bmw.png'
where make = 'BMW'

select *
from car_prices cp 
order by "year" desc 




