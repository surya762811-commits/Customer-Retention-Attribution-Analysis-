-- customer_revenue ----- 
1.-- --- --Total Revenue -- --- --
SELECT
SUM(sales) AS total_revenue
FROM transactions;

2.-- --- --Average Order Value -- --- --
SELECT
ROUND(AVG(sales),2) AS average_order_value
FROM transactions;

3.-- --- --Revenue by Product Category -- --- -- 
SELECT
product_category,
SUM(sales) AS total_revenue
FROM transactions
GROUP BY product_category
ORDER BY total_revenue DESC;

4.-- --- --Revenue by Country -- --- --
SELECT
country,
SUM(sales) total_revenue
FROM transactions
GROUP BY country
ORDER BY total_revenue DESC;

5.-- --- --Customer Lifetime Revenue (Using CTE) -- --- -- 
WITH customer_revenue AS(
SELECT
customer_id,
SUM(sales) total_revenue
FROM transactions
GROUP BY customer_id)
SELECT *
FROM customer_revenue
ORDER BY total_revenue DESC;

6.-- --- --Top 10 Customers -- --- --
WITH customer_revenue AS
(SELECT
customer_id,
SUM(sales) total_revenue
FROM transactions
GROUP BY customer_id)
SELECT *
FROM customer_revenue
ORDER BY total_revenue DESC
LIMIT 10;

7.-- --- --Customer Ranking (RANK) -- --- --
SELECT
customer_id,
SUM(sales) total_revenue,
RANK()
OVER(ORDER BY SUM(sales) DESC) revenue_rank
FROM transactions
GROUP BY customer_id;

8.-- --- --Customer Ranking (DENSE_RANK) -- --- -- 
WITH customer_country AS(
SELECT
country,
customer_id,
SUM(sales) revenue,
RANK()
OVER(PARTITION BY country
ORDER BY SUM(sales) DESC) rnk
FROM transactions
GROUP BY country,customer_id)
SELECT *
FROM customer_country
WHERE rnk=1;

9.-- --- --Top Customer in Every Country (CTE + RANK) -- --- --
WITH customer_country AS
(SELECT
country,
customer_id,
SUM(sales) revenue,
RANK()
OVER(
PARTITION BY country
ORDER BY SUM(sales) DESC) rnk
FROM transactions
GROUP BY country,customer_id)
SELECT *
FROM customer_country
WHERE rnk=1;


