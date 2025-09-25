CREATE TABLE pizza_sales (
    pizza_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_name_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    pizza_size VARCHAR(10) NOT NULL,
    pizza_category VARCHAR(50) NOT NULL,
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100) NOT NULL
);

--IMPORT CSV
COPY 
pizza_sales(pizza_id, order_id, pizza_name_id, quantity, order_date, order_time,
        unit_price, total_price, pizza_size, pizza_category, 
        pizza_ingredients, pizza_name)
FROM 'D:\power bi project data\pizza_sales.csv.csv'
CSV HEADER;

select* from pizza_sales;

1)-- total revenue
select sum(total_price) as total_revenue from pizza_sales;

2)--average order value
SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS average_order_value
FROM pizza_sales;

3)--total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;

4)-- total orders
select count(distinct order_id) as total_orders from pizza_sales;

5)-- average pizza's per order
select cast (sum(quantity) as decimal(10,2))/
cast (count(distinct order_id)as decimal(10,2)) as avg_pizza_per_order from pizza_sales;

6)--daily trend for total orders
select DATE_PART('DOW', order_date)as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATE_PART('DOW', order_date);

7)--MONTHLY TREND FOR TOTAL ORDERS
select DATE_PART('MONTHS', ORDER_DATE) AS ORDER_MONTH, count(distinct order_id) as total_orders
from pizza_sales
GROUP BY DATE_PART('MONTHS', ORDER_DATE)
ORDER BY total_orders desc;

8)--percentage of sales by pizza category
 SELECT 
    pizza_category,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_category;

9)--percentage of sales by pizza size
 SELECT 
    pizza_size,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_size;

10)--total pizza sold by pizza category
select pizza_category, sum(quantity)as total_pizza_sales from pizza_sales
group by pizza_category;

11)--top 5 best seller by revenue, quantity and orders
select pizza_name, sum(total_price)as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc limit 5;

select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc limit 5;

select pizza_name, count(distinct order_id) as total_order from pizza_sales
group by pizza_name
order by total_order desc limit 5;


12)--bottom 5 best seller
select pizza_name, sum(total_price)as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc limit 5;

select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity asc limit 5;

select pizza_name, count(distinct order_id) as total_order from pizza_sales
group by pizza_name
order by total_order asc limit 5;
































































