-- REVENUE ATTRIBUTION

WITH first_touch AS (
  SELECT
    customer_id,
    channel,
    ROW_NUMBER() OVER(
      PARTITION BY customer_id
      ORDER BY touch_date
    ) AS rn
  FROM marketing_touchpoints
),
customer_revenue AS (
  SELECT
    customer_id,
    SUM(sales) revenue
  FROM transactions
  GROUP BY customer_id
)
SELECT 
  ft.customer_id,
  ft.channel,
  cr.revenue
FROM first_touch ft
JOIN customer_revenue cr 
  ON ft.customer_id = cr.customer_id
WHERE ft.rn = 1;
