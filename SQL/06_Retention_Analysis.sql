-- Retention Analysis
WITH first_purchase AS
(
SELECT
customer_id,
MIN(order_date) first_order
FROM transactions
GROUP BY customer_id
),

retention_data AS
(
SELECT
t.customer_id,

TIMESTAMPDIFF(
MONTH,
f.first_order,
t.order_date
)
AS retention_month

FROM transactions t
JOIN first_purchase f
ON t.customer_id=f.customer_id
)

SELECT
retention_month,
COUNT(DISTINCT customer_id)
AS retained_customers

FROM retention_data

GROUP BY retention_month
ORDER BY retention_month;
