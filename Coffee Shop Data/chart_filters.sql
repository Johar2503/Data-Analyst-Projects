#Problem Statement 
#Chart Requirements

#1) Calender Heat Map
select transaction_date, concat(round(sum(transaction_qty*unit_price)/1000,1),'K') total_sales,
concat(round(count(*)/1000,1),'K') total_orders,
concat(round(sum(transaction_qty)/1000,1),'K') total_quantities
from coffee_shop_sales
where transaction_date='2023-05-18';

#Total sales in Weekdays and Weekends
select case when dayofweek(transaction_date) in (1,7) then "Weekends"
else "Weekdays" end day_type,
concat(round(sum(transaction_qty*unit_price)/1000,1),'K') total_sales
from coffee_shop_sales
where month(transaction_date)=2
group by case when dayofweek(transaction_date) in (1,7) then "Weekends"
else "Weekdays" end;

#3) Month to Month sales difference based on store location
select concat(round(sum(transaction_qty*unit_price)/1000,2),'K') total_sales, store_location,
(sum(transaction_qty*unit_price)-lag(sum(transaction_qty*unit_price),1) 
over (order by month(transaction_date)))/lag(sum(transaction_qty*unit_price),1) 
over (order by month(transaction_date)) *100 mom_increase
from coffee_shop_sales
where month(transaction_date)=6
group by month(transaction_date),store_location
order by sum(transaction_qty*unit_price) desc;

#average of each month and average of each day and labelling above and below average
#average sales of month(i.e. average of 31 days)
select avg(total_sales) avg_sales
from (select sum(transaction_qty*unit_price) total_sales 
from coffee_shop_sales where month(transaction_date)=5 group by transaction_date) as i ;

#sales each day in month
select day(transaction_date) day_of_month,sum(transaction_qty*unit_price) total_sales 
from coffee_shop_sales where month(transaction_date)=5 group by day(transaction_date);

#calculating total_sales and average sales and labelling them wether they are above or below or average
select day_of_month,total_sales,case when total_sales>avg_sales then "Above Average"
when total_sales<avg_sales then "Below Average" 
else "Average"
end sales_status
from (select day(transaction_date) day_of_month,
concat(round(sum(transaction_qty*unit_price)/1000,2),'K') total_sales,
avg(sum(transaction_qty*unit_price)) over() avg_sales 
from coffee_shop_sales where month(transaction_date)=5 
group by transaction_date) as I;

#sales by different categories
select product_category,concat(round(sum(transaction_qty*unit_price),1),'K') total_sales from coffee_shop_sales where month(transaction_date)=5 group by product_category;

#sales top 10 products
select product_type, sum(transaction_qty*unit_price) total_sales 
from coffee_shop_sales 
where month(transaction_date)=5 
group by product_type 
order by sum(transaction_qty*unit_price) desc 
limit 10;

#Total sales ,orders,quantities at particular month and hour and day of week
select 
concat(round(sum(transaction_qty*unit_price)),"K") total_sales, -- total sales
count(*) total_orders, -- total orders
sum(transaction_qty) total_quantity -- total quantity
from coffee_shop_sales 
where month(transaction_date)=5 
and dayofweek(transaction_date)=1 -- Monday
and hour(transaction_time)=14;

#top sales in a particular hour in whole month
select 
hour(transaction_time) hour,
concat(round(sum(transaction_qty*unit_price)),"K") total_sales -- total sales
from coffee_shop_sales 
where month(transaction_date)=5 
group by hour(transaction_time)
order by hour(transaction_time);

#top sales in a particular week day in a month
select 
case 
when dayofweek(transaction_date)=2 then "Monday" 
when dayofweek(transaction_date)=3 then "Tuesday" 
when dayofweek(transaction_date)=4 then "Wednesday" 
when dayofweek(transaction_date)=5 then "Thursday" 
when dayofweek(transaction_date)=6 then "Friday" 
when dayofweek(transaction_date)=7 then "Saturday" 
else "Sunday"
end day_name, 
concat(round(sum(transaction_qty*unit_price)),"K") total_sales -- total sales
from coffee_shop_sales 
where month(transaction_date)=5 
group by case 
when dayofweek(transaction_date)=2 then "Monday" 
when dayofweek(transaction_date)=3 then "Tuesday" 
when dayofweek(transaction_date)=4 then "Wednesday" 
when dayofweek(transaction_date)=5 then "Thursday" 
when dayofweek(transaction_date)=6 then "Friday" 
when dayofweek(transaction_date)=7 then "Saturday" 
else "Sunday"
end;
