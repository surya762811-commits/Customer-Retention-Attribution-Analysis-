WITH customer_revenue AS
(
SELECT
customer_id,
SUM(sales) total_revenue
FROM transactions
GROUP BY customer_id
)

SELECT *
FROM customer_revenue
ORDER BY total_revenue DESC;
