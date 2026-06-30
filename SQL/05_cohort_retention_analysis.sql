-- Cohort Analysis--

1.-- --- -- First Purchase Date (CTE)-- --- --
WITH first_purchase AS
(SELECT
customer_id,
MIN(order_date) AS first_purchase_date
FROM transactions
GROUP BY customer_id)SELECT *
FROM first_purchase
ORDER BY first_purchase_date;

2.-- --- --Cohort Month -- --- --
WITH first_purchase AS(SELECT
customer_id,
MIN(order_date) AS first_purchase_date
FROM transactions
GROUP BY customer_id)
SELECT
t.customer_id,
DATE_FORMAT(first_purchase_date,'%Y-%m') AS cohort_month,
DATE_FORMAT(order_date,'%Y-%m') AS purchase_month
FROM transactions t
JOIN first_purchase f
ON t.customer_id=f.customer_id
ORDER BY customer_id;

3.-- --- --Retention Month-- --- --
WITH first_purchase AS(SELECT
customer_id,
MIN(order_date) AS first_purchase_date
FROM transactions
GROUP BY customer_id)
SELECT
t.customer_id,
TIMESTAMPDIFF(MONTH,
f.first_purchase_date,
t.order_date
) AS retention_month
FROM transactions t
JOIN first_purchase f
ON t.customer_id=f.customer_id
ORDER BY customer_id;

4.-- --- --Retention Count-- --- --
WITH first_purchase AS(
SELECT
customer_id,
MIN(order_date) AS first_purchase_date
FROM transactions
GROUP BY customer_id),
retention_data AS(
SELECT
t.customer_id,
TIMESTAMPDIFF(MONTH,
f.first_purchase_date,
t.order_date
) retention_month
FROM transactions t
JOIN first_purchase f
ON t.customer_id=f.customer_id)
SELECT
retention_month,
COUNT(DISTINCT customer_id) retained_customers
FROM retention_data
GROUP BY retention_month
ORDER BY retention_month;

5.-- --- --Cohort Retention Matrix-- --- --
WITH first_purchase AS(
SELECT
customer_id,
MIN(order_date) AS first_purchase_date
FROM transactions
GROUP BY customer_id),
cohort AS(
SELECT
DATE_FORMAT(f.first_purchase_date,'%Y-%m') AS cohort_month,
TIMESTAMPDIFF(MONTH,
f.first_purchase_date,
t.order_date
) AS retention_month,
t.customer_id
FROM transactions t
JOIN first_purchase f
ON t.customer_id=f.customer_id)
SELECT
cohort_month,
retention_month,
COUNT(DISTINCT customer_id) AS customers
FROM cohort
GROUP BY cohort_month,retention_month
ORDER BY cohort_month,retention_month;

6.-- --- --One-Time Customers (Drop-off)-- --- --
WITH customer_orders AS(
SELECT
customer_id,
COUNT(*) total_orders
FROM transactions
GROUP BY customer_id)
SELECT
COUNT(*) AS one_time_customers
FROM customer_orders
WHERE total_orders=1;

7.-- --- --Repeat Customers-- --- --
WITH customer_orders AS(
SELECT
customer_id,
COUNT(*) total_orders
FROM transactions
GROUP BY customer_id)
SELECT
COUNT(*) repeat_customers
FROM customer_orders
WHERE total_orders>1;

8.-- --- --Drop-off Percentage-- --- --
WITH customer_orders AS(
SELECT
customer_id,
COUNT(*) total_orders
FROM transactions
GROUP BY customer_id)
SELECT
ROUND(100*
SUM(CASE WHEN total_orders=1 THEN 1 ELSE 0 END)
/COUNT(*),2)
AS dropoff_percentage
FROM customer_orders;

