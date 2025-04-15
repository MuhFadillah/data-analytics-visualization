select *
from "index" i 

alter table "index" 
rename column "card" to NO_CARD

update "index" 
set no_card = 'Cash'
where no_card = '' 

alter table "index" 
alter column "date" type date using "date"::date;

select *
from "index" i 
order by "date" asc 

alter table "index" 
alter column datetime type TIMESTAMP using datetime::TIMESTAMP;

select *
from "index" i 
order by "date" asc


select *,
ROW_NUMBER()OVER(
partition by "date",datetime,no_card,"money",coffee_name) as row_num
from "index" i ;

with duplicate_cte as 
	(
	select *,
	ROW_NUMBER()OVER(
	partition by "date",datetime,cash_type,no_card,"money",coffee_name) as row_num
	from "index" i 
	)
select *
from duplicate_cte
where row_num > 1;



select *,
coffee_name ,
ROUND(SUM("money")::NUMERIC, 5) AS revenue
from "index" i 
group by "date" ,datetime ,cash_type ,no_card,"money" ,coffee_name 


select coffee_name ,cash_type, ROUND(SUM("money")::NUMERIC, 0) AS revenue
from "index" i 
group by coffee_name ,cash_type 
order by revenue desc 

select coffee_name , ROUND(SUM("money")::NUMERIC, 0) AS revenue
from "index" i 
group by coffee_name  
order by revenue desc 


select coffee_name ,count(*)
from "index" i 
group by coffee_name 

select coffee_name ,cash_type, count(*)
from "index" i 
group by coffee_name ,cash_type 

