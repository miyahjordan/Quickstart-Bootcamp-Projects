-- looking at a sample of the data to see what we're working with
SELECT *
FROM customer_data
LIMIT 10;

-- looking at statistical distributions for the numerical data
SELECT 
	MIN(age) AS min_age,
	MAX(age) AS max_age,
  	ROUND(AVG(age), 2) AS avg_age,
  	ROUND(STDDEV(age), 2) AS stdev_age,
  	MIN(avg_order_value) AS min_avg_order_value, 
  	MAX(avg_order_value) AS max_avg_order_value,
	SUM(avg_order_value) AS sum_avg_order_value,
  	ROUND(STDDEV(avg_order_value), 2) AS stdev_avg_order_value,
  	MIN(total_orders) AS min_total_orders,
  	MAX(total_orders) AS max_total_orders,
  	SUM(total_orders) AS sum_total_orders,
  	ROUND(AVG(total_orders), 2) AS avg_total_orders,
  	ROUND(STDDEV(total_orders), 2) AS stdev_total_orders,
  	MIN(last_purchase) AS min_days_since_last_purchase,
  	MAX(last_purchase) AS max_days_since_last_purchase,
	ROUND(AVG(last_purchase), 2) AS avg_days_since_last_purchase,
	ROUND(STDDEV(last_purchase), 2) AS stdev_days_since_last_purchase, 
	MIN(email_open_rate) AS min_email_open_rate,
	MAX(email_open_rate) AS max_email_open_rate,
	ROUND(AVG(email_open_rate), 2) AS avg_email_open_rate,
	ROUND(STDDEV(email_open_rate), 2) AS stdev_email_open_rate,
	MIN(loyalty_score) AS min_loyalty_score,
	MAX(loyalty_score) AS max_loyalty_score,
	ROUND(AVG(loyalty_score), 2) AS avg_loyalty_score,
	ROUND(STDDEV(loyalty_score), 2) AS stdev_loyalty_score
FROM customer_data;

-- looking for null values in the data
SELECT *
FROM customer_data
WHERE avg_order_value = ''
    OR total_orders = ''
    OR last_purchase = ''
    OR email_open_rate = ''
ORDER BY customer_id;

-- changing data types for certain columns
-- email_open rate should be a double value and customer_since should be formatted as dates
UPDATE customer_data
SET email_open_rate = 0.0
WHERE email_open_rate = '';

ALTER TABLE customer_data
MODIFY COLUMN email_open_rate DECIMAL(10,1);

ALTER TABLE customer_data
MODIFY COLUMN customer_since DATE;

-- looking at text columns to standardize formatting 
SELECT DISTINCT gender
FROM customer_data;

SELECT DISTINCT country
FROM customer_data;

SELECT DISTINCT preferred_category
FROM customer_data;

-- none of the values in the columns need to be standardized so we can move on to removing potential duplicates
SELECT DISTINCT *
FROM customer_data;

-- This query looks at the most popular categories all customers by from
SELECT preferred_category, SUM(total_orders) AS total_orders
FROM customer_data
GROUP BY preferred_category
ORDER BY total_orders DESC;

-- which customer age range spends the most?
SELECT
	CASE
		WHEN age < 18 THEN 'under 18'
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
		WHEN age BETWEEN 25 AND 31 THEN '25-31'
		WHEN age BETWEEN 32 AND 38 THEN '32-38'
		WHEN age BETWEEN 39 AND 45 THEN '39-45'
		WHEN age BETWEEN 46 AND 49 THEN '46-49'
		ELSE '50+' 
	END AS age_range,
    SUM(total_orders) AS orders_by_age
FROM customer_data
GROUP BY age_range
ORDER BY orders_by_age DESC;

-- This query looks at spending based on gender
SELECT
	gender,
    SUM(total_orders) AS orders_by_gender
FROM customer_data
GROUP BY gender
ORDER BY orders_by_gender DESC;

-- This query is to find where majority of customers live
SELECT
	country,
    SUM(total_orders) AS sales_by_country
FROM customer_data
GROUP BY country
ORDER BY sales_by_country DESC;

-- Now, I want to look at how much each gender, age group, and country spent in each department/category
SELECT 
	preferred_category, 
    country,
    gender,
    CASE
		WHEN age < 18 THEN 'under 18'
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
		WHEN age BETWEEN 25 AND 31 THEN '25-31'
		WHEN age BETWEEN 32 AND 38 THEN '32-38'
		WHEN age BETWEEN 39 AND 45 THEN '39-45'
		WHEN age BETWEEN 46 AND 49 THEN '46-49'
		ELSE '50+' 
	END AS age_range,
    SUM(total_orders) AS sales_by_gender
FROM customer_data
GROUP BY preferred_category, gender, age_range, country
ORDER BY preferred_category, country, age_range, sales_by_gender DESC;

-- There is a fraud component to the data, I want to see how many customers have been flagged for fraud
SELECT *
FROM customer_data
WHERE is_fraudulent = 1;

-- Now that we know there are 124 customers flagged for fraud, I want to break the data down further
-- How long were these customers shopping with the company? How much did they spend?
SELECT 
	customer_id,
    TIMESTAMPDIFF(YEAR, customer_since, CURDATE()) years_since_fraudulent_customers_joined,
    avg_order_value
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY years_since_fraudulent_customers_joined, customer_id, avg_order_value
ORDER BY years_since_fraudulent_customers_joined, avg_order_value DESC;

-- Now I want to know if the customers who commited fraud longer contribute more to the revenue loss compared to their counterparts
SELECT 
    TIMESTAMPDIFF(YEAR, customer_since, CURDATE()) years_since_fraudulent_customers_joined,
    ROUND(SUM(avg_order_value), 2) AS total_avg_fraudulent_order_value_by_year
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY years_since_fraudulent_customers_joined
ORDER BY total_avg_fraudulent_order_value_by_year DESC, years_since_fraudulent_customers_joined;

-- How much money was lost on these orders and how many were made in total?
SELECT 
	ROUND(SUM(avg_order_value), 2) AS avg_money_lost,
	SUM(total_orders) AS total_fradulent_orders
FROM customer_data
WHERE is_fraudulent = 1;

-- Which department experiences the most revenue loss?
SELECT 
	preferred_category,
	ROUND(SUM(avg_order_value), 2) AS avg_money_lost_by_department
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY preferred_category
ORDER BY avg_money_lost_by_department DESC;

-- Where do these customers typically reside? How much money was lost?
SELECT 
	country,
    COUNT(is_fraudulent) AS num_fraudulent_customers,
    ROUND(SUM(avg_order_value)) AS avg_revenue_lost_by_country
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY country
ORDER BY num_fraudulent_customers DESC, avg_revenue_lost_by_country DESC;

-- I'm going to see how many fraudulent purchases were made by gender and how much was lost
SELECT 
	gender, 
	SUM(total_orders) AS total_fradualent_orders_by_gender,
    ROUND(SUM(avg_order_value)) AS avg_revenue_lost_by_gender
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY gender
ORDER BY total_fradualent_orders_by_gender DESC, avg_revenue_lost_by_gender DESC;

-- How did the fraudlent orders breakdown by age? How much did they spend?
SELECT 
	CASE
		WHEN age < 18 THEN 'under 18'
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
		WHEN age BETWEEN 25 AND 31 THEN '25-31'
		WHEN age BETWEEN 32 AND 38 THEN '32-38'
		WHEN age BETWEEN 39 AND 45 THEN '39-45'
		WHEN age BETWEEN 46 AND 49 THEN '46-49'
		ELSE '50+' 
	END AS age_range,
    SUM(total_orders) total_fraudulent_orders_by_age,
    ROUND(SUM(avg_order_value)) AS avg_revenue_lost_by_age
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY age_range
ORDER BY total_fraudulent_orders_by_age DESC, avg_revenue_lost_by_age DESC;

-- How does revenue loss break down by department, country, age range, and gender?
SELECT 
	preferred_category,
    country,
    gender,
    CASE
		WHEN age < 18 THEN 'under 18'
		WHEN age BETWEEN 18 AND 24 THEN '18-24'
		WHEN age BETWEEN 25 AND 31 THEN '25-31'
		WHEN age BETWEEN 32 AND 38 THEN '32-38'
		WHEN age BETWEEN 39 AND 45 THEN '39-45'
		WHEN age BETWEEN 46 AND 49 THEN '46-49'
		ELSE '50+' 
	END AS age_range,
    SUM(total_orders) total_fraudulent_orders,
    ROUND(SUM(avg_order_value)) AS avg_revenue_lost
FROM customer_data
WHERE is_fraudulent = 1
GROUP BY preferred_category, country, gender, age_range
ORDER BY preferred_category, total_fraudulent_orders DESC, avg_revenue_lost DESC;
