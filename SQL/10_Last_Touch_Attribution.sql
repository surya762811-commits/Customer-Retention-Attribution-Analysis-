-- LAST TOUCH ATTRIBUTION---

WITH last_touch AS (
  SELECT
    customer_id,
    channel,
    ROW_NUMBER() OVER(
      PARTITION BY customer_id
      ORDER BY touch_date DESC
    ) AS rn
  FROM marketing_touchpoints
)
SELECT *
FROM last_touch
WHERE rn = 1;
