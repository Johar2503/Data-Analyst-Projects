SELECT * FROM coffee_shop_sales_db.coffee_shop_sales;

describe coffee_shop_sales;

#str_to_date() is used to convert both date and time from text to date and time
#changing the format of transaction_date column using update and changing data type of column to date

#str_to_date --> tranforms string(text data type to specified date format)
update coffee_shop_sales
set transaction_date=str_to_date(transaction_date,'%d-%m-%Y');

alter table coffee_shop_sales modify column transaction_date date;

#changing the format of transaction_time column using update and changing data type of column to time
# for minutes "i" is used
#str_to_date --> tranforms string(text data type to specified time format)
update coffee_shop_sales
set transaction_time=str_to_date(transaction_time,'%H.%i.%s');

alter table coffee_shop_sales modify column transaction_time time;

#changing column name
alter table coffee_shop_sales change column ï»¿transaction_id transaction_id int;


