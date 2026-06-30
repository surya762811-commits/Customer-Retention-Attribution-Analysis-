-- FIRST TOUCH ATTRIBUTION

WITH first_touch AS (
  SELECT
    customer_id,
    channel,
    ROW_NUMBER() OVER(
      PARTITION BY customer_id
      ORDER BY touch_date
    ) AS rn
  FROM marketing_touchpoints
)
SELECT *
FROM first_touch
WHERE rn = 1;
