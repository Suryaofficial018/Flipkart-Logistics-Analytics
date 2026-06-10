CREATE DATABASE flipkart_logistics;
USE flipkart_logistics;

CREATE TABLE flipkart_data (
    order_id VARCHAR(20),
    order_date DATE,
    order_hour INT,
    order_weekday VARCHAR(20),
    is_weekend INT,
    is_holiday INT,
    is_sale_period INT,
    customer_city VARCHAR(50),
    customer_state VARCHAR(50),
    customer_zone VARCHAR(20),
    customer_tier VARCHAR(10),
    warehouse_id VARCHAR(20),
    warehouse_city VARCHAR(50),
    same_zone_delivery INT,
    product_category VARCHAR(50),
    product_weight_g FLOAT,
    product_price_inr FLOAT,
    discount_percent FLOAT,
    final_price_inr FLOAT,
    shipping_mode VARCHAR(20),
    payment_method VARCHAR(20),
    promised_days INT,
    actual_days INT,
    promised_date DATE,
    actual_date DATE,
    delay_days INT,
    is_delayed INT,
    delay_category VARCHAR(20),
    delivery_attempts INT,
    customer_rating INT,
    return_requested INT,
    delivery_status VARCHAR(20),
    delay_flag VARCHAR(20),
    rating_group VARCHAR(20),
    price_category VARCHAR(20),
    delivery_speed VARCHAR(20),
    order_month_num INT,
    order_month_name VARCHAR(20),
    order_year INT,
    order_quarter VARCHAR(5),
    order_weekday_name VARCHAR(20)
);

SELECT * FROM flipkart_data;

-- 1. What is the total number of orders?
select count(order_id) as Total_Orders FROM flipkart_data;

-- 2. How many orders were delayed?
select count(order_id) as Total_Orders from flipkart_data where is_delayed=1;

-- 3. What is the total revenue generated?
select sum(final_price_inr) as Total_revenue FROM flipkart_data;

-- 4. How many orders were returned?
select count(order_id) as Total_Orders FROM flipkart_data where return_requested=1;

-- 5. What are the distinct shipping modes?
select distinct(shipping_mode) FROM flipkart_data;

-- 6. How many orders per product category?
select product_category,count(order_id) as Total_Orders FROM flipkart_data group by product_category;

-- 7. How many orders per customer zone?
select customer_zone,count(order_id) as Total_Orders from flipkart_data group by customer_zone;

-- 8. How many orders per customer tier?
select customer_tier,count(order_id) as Total_Orders from flipkart_data group by customer_tier;

-- 9. What is the average customer rating?
select avg(customer_rating) as avg_customer_rating FROM flipkart_data;

-- 10. How many orders were placed on weekends?
select is_weekend,count(order_id) as Total_Orders FROM flipkart_data where is_weekend=1;

-- 11. What is the delay rate % by shipping mode?
select avg(is_delayed*100),shipping_mode FROM flipkart_data group by shipping_mode;

-- 12. What is the return rate % by product category?
select product_category,avg(return_requested*100) FROM flipkart_data group by product_category;

-- 13. Which top 5 states have highest delayed orders?
select customer_state,count(is_delayed) as delayed_Orders FROM flipkart_data where is_delayed=1 group by customer_state
order by delayed_Orders desc limit 5;

-- 14. What is average delay days by zone?
select customer_zone,avg(delay_days) FROM flipkart_data group by customer_zone order by avg(delay_days) desc;

-- 15. What is total revenue by product category?
select product_category,sum(final_price_inr) as total_revenue from  flipkart_data group by product_category 
order by total_revenue desc;

-- 16. Which shipping mode has best customer rating?
select shipping_mode,avg(customer_rating) FROM flipkart_data group by shipping_mode order by avg(customer_rating)
 desc limit 1;

-- 17. How many orders delayed during sale period?
SELECT COUNT(order_id) as delayed_orders_saleperiod 
FROM flipkart_data 
WHERE is_sale_period=1 
AND is_delayed=1;

-- 18. What is delay rate by customer tier?
select customer_tier, avg(is_delayed*100) as delay_rate FROM flipkart_data group by customer_tier order by delay_rate desc;

-- 19. Which warehouse has most delayed orders?
SELECT warehouse_id, warehouse_city,
COUNT(order_id) as delayed_orders  
FROM flipkart_data
WHERE is_delayed=1
GROUP BY warehouse_id, warehouse_city
ORDER BY delayed_orders DESC;

-- 20. What is monthly order trend?
select month(order_date) as month_num,monthname(order_date) as month_name,count(order_id) as Total_orders
FROM flipkart_data group by month_num,month_name order by month_num ASC;

