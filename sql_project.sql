create database sql_project;
use sql_project;

drop table if exists retail_sales;
 create table retail_sales(
 transactions_id	integer primary key,
 sale_date date,
 sale_time  time,
 customer_id	integer,
 gender	varchar(10),
 age	integer,
 category varchar(20),
 quantity  integer, 
 price_per_unit float,
 cogs float,
 total_sale float);
 
 select * from retail_sales limit 10;
 
 SELECT 
    COUNT(*) 
FROM retail_sales

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_store 
where sale_date="2022-11-5";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select transactions_id,total_sale from retail_sales
 where category = "Clothing" 
 and quantity=4  and 
 sale_date between "2022-11-1" and "2022-11-30";

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

 select sum(total_sale) as total_sales,category from retail_sales
 group by category;
 
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

 select avg(age) as average_age from retail_sales
 where category="Beauty";
 
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

 select * from retail_sales
 where total_sale>1000;
 
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

 select count(transactions_id) as num_of_trans,gender,category from retail_sales
 group by gender,category 
 order by num_of_trans desc;
 
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

 select Years,Months,average
 from 
 (select year(sale_date) as Years,month(sale_date) as Months,round(avg(total_sale),2) as average,
 rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk  from retail_sales group by 1,2) 
 as x
 where rnk =1;
 
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

 select customer_id,sum(total_sale) as total_sales from retail_sales
 group by 1 
 order by 2 desc limit 5;
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

 select count( distinct customer_id),category from retail_sales group by 2;
 
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale as 
(select *,
case when hour(sale_time)<12 then "Morning" 
when hour(sale_time) between 12 and 17 then "Afternoon" 
else "Evening" end
as shift from retail_sales)
select shift,count(*) as total_orders from hourly_sale 
group by shift;


 
 
 
 
