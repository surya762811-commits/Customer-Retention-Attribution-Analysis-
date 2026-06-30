-- drop_off--

1.-- --- --Total Orders per Customer-- --- -- 
WITH customer_orders AS(
SELECT
customer_id,
COUNT(*) AS total_orders
FROM transactions
GROUP BY customer_id)
SELECT *
FROM customer_orders
ORDER BY total_orders DESC;

2.-- --- -- Customer Segmentation-- --- -- 
WITH customer_orders AS(
SELECT
customer_id,
COUNT(*) total_orders
FROM transactions
GROUP BY customer_id)
SELECT
customer_id,
CASE
WHEN total_orders=1 THEN 'One-Time Customer'
WHEN total_orders BETWEEN 2 AND 5 THEN 'Repeat Customer'
ELSE 'Loyal Customer'
END customer_type
FROM customer_orders;

3.-- --- --Previous Purchase (LAG)-- --- -- 
SELECT
customer_id,
order_date,
LAG(order_date)
OVER(
PARTITION BY customer_id
ORDER BY order_date
) previous_purchase
FROM transactions;

4.-- --- -- Next Purchase (LEAD)-- --- --
SELECT
customer_id,
order_date,
LEAD(order_date)
OVER(
PARTITION BY customer_id
ORDER BY order_date
) next_purchase
FROM transactions;

5.-- --- --Days Between Purchases-- --- --
WITH purchase_gap AS(SELECT
customer_id,
order_date,
LAG(order_date)
OVER(
PARTITION BY customer_id
ORDER BY order_date
) previous_purchase
FROM transactions)SELECT
customer_id,
order_date,
previous_purchase,
DATEDIFF(order_date,previous_purchase) AS days_between_orders
FROM purchase_gap;

6.-- --- --Average Purchase Gap-- --- --
WITH purchase_gap AS(
SELECT
customer_id,
order_date,
LAG(order_date)
OVER(PARTITION BY customer_id
ORDER BY order_date
) previous_purchase
FROM transactions)
SELECT
ROUND(
AVG(DATEDIFF(order_date,previous_purchase)),2)
AS average_days_between_orders
FROM purchase_gap;

7.-- --- --Active Customers-- --- --
SELECT
COUNT(DISTINCT customer_id)
AS active_customers
FROM transactions
WHERE order_date >= DATE_SUB(
(SELECT MAX(order_date) FROM transactions),
INTERVAL 90 DAY);

8.-- --- --Inactive Customers-- --- --
SELECT COUNT(DISTINCT customer_id)
AS inactive_customers
FROM transactions
WHERE customer_id NOT IN(
SELECT DISTINCT customer_id
FROM transactions
WHERE order_date >= DATE_SUB(
(SELECT MAX(order_date) FROM transactions),
INTERVAL 90 DAY));

