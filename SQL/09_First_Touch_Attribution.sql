-- FIRST TOUCH ATTRIBUTION


-- --- -- View Marketing Data-- --- --
SELECT *
FROM marketing_touchpoints;

-- --- --First Touch Using ROW_NUMBER()-- --- --
WITH first_touch AS(
SELECT
customer_id,channel,
campaign,touch_date,
ROW_NUMBER()OVER(
PARTITION BY customer_id
ORDER BY touch_date) AS rn
FROM marketing_touchpoints)
SELECT *FROM first_touch
WHERE rn=1;

-- --- --Customer Revenue-- --- --
WITH customer_revenue AS(SELECT
customer_id,SUM(sales) total_revenue
FROM transactions
GROUP BY customer_id)
SELECT *FROM customer_revenue;

-- --- --Revenue by First Touch Channel-- --- --
WITH first_touch AS(SELECT
customer_id,channel,ROW_NUMBER()
OVER(PARTITION BY customer_id
ORDER BY touch_date) rn
FROM marketing_touchpoints),
customer_revenue AS(SELECT
customer_id,
SUM(sales) revenue
FROM transactions
GROUP BY customer_id)
SELECT channel,
COUNT(DISTINCT f.customer_id) total_customers,
ROUND(SUM(revenue),2) total_revenue
FROM first_touch f
JOIN customer_revenue c
ON f.customer_id=c.customer_id
WHERE rn=1 GROUP BY channel
ORDER BY total_revenue DESC;

-- --- --Campaign Performance-- --- --
WITH first_touch AS(SELECT
customer_id,campaign,
ROW_NUMBER()OVER(
PARTITION BY customer_id
ORDER BY touch_date) rn
FROM marketing_touchpoints),
customer_revenue AS(
SELECT customer_id,
SUM(sales) revenue
FROM transactions
GROUP BY customer_id) SELECT campaign,
COUNT(DISTINCT f.customer_id) customers,
ROUND(SUM(revenue),2) revenue
FROM first_touch f
JOIN customer_revenue c
ON f.customer_id=c.customer_id
WHERE rn=1
GROUP BY campaign
ORDER BY revenue DESC;

-- --- --Best Marketing Channel-- --- --
WITH first_touch AS(SELECT
customer_id, channel,
ROW_NUMBER() OVER(
PARTITION BY customer_id
ORDER BY touch_date
) rn FROM marketing_touchpoints
),
customer_revenue AS(
SELECT customer_id,
SUM(sales) revenue
FROM transactions
GROUP BY customer_id)
SELECT channel,
ROUND(SUM(revenue),2) revenue
FROM first_touch f
JOIN customer_revenue c
ON f.customer_id=c.customer_id
WHERE rn=1
GROUP BY channel
ORDER BY revenue DESC
LIMIT 1;

