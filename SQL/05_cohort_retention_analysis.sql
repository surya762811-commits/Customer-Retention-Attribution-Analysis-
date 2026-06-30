WITH first_purchase AS
(
SELECT
customer_id,
MIN(order_date) first_order
FROM transactions
GROUP BY customer_id
)

SELECT *
FROM first_purchase;
