#1) Total sales analysis
# Total sales for each month
select month(transaction_date) month, -- number of month
concat(round(sum(transaction_qty*unit_price)),"K") total_sales -- total sales
from coffee_shop_sales 
#where month(transaction_date) in (4,5) -- for months april and may
group by month(transaction_date); -- group by each month

#MOM increase or decrease and difference b/w sales of current month & previous month
select month(transaction_date) month,  -- number of month
round(sum(transaction_qty*unit_price)) total_sales, -- total sales
(sum(transaction_qty*unit_price)-lag(sum(transaction_qty*unit_price),1)  -- current month - previous month sales 
over(order by month(transaction_date)))/lag(sum(transaction_qty*unit_price),1) -- division by previous month sales
over(order by month(transaction_date))*100 mom_increase -- percentage
from coffee_shop_sales 
#where month(transaction_date) in (4,5) -- for months april and may
group by month(transaction_date);