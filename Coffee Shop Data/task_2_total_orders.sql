#2) Total orders analysis
# Total order for each month
select month(transaction_date) month, -- number of month
count(*) total_orders -- total orders
from coffee_shop_sales 
#where month(transaction_date) in (4,5) -- for months april and may
group by month(transaction_date); -- group by each month


#MOM -> month to month increase or decrease and difference b/w orders of current month & previous month
select month(transaction_date) month,  -- number of month
count(*) total_orders, -- total orders
(count(*)-lag(count(*),1)  -- current month - previous month orders 
over(order by month(transaction_date)))/lag(count(*),1) -- division by previous month orders
over(order by month(transaction_date))*100 mom_increase -- percentage
from coffee_shop_sales 
#where month(transaction_date) in (4,5) -- for months april and may
group by month(transaction_date);