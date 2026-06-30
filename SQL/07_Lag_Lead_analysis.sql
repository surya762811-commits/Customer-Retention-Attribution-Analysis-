-- LAG FUNCTION
-- use: to calculate time gapas b/w customer purchases.
SELECT
  customer_id,
  order_date,
  LAG(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
  ) AS previous_order
FROM transactions;


-- LEAD FUNCTION
-- use: to identify upcoming customer purchase patterns.
SELECT
  customer_id,
  order_date,
  LEAD(order_date) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
  ) AS next_order
FROM transactions;
