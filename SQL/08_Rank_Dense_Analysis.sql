-- RANK FUNCTION --
SELECT
  customer_id,
  SUM(sales) revenue,
  RANK() OVER(
    ORDER BY SUM(sales) DESC
  ) AS revenue_rank
FROM transactions
GROUP BY customer_id;

-- DENSE RANK
SELECT
  customer_id,
  SUM(sales) revenue,
  DENSE_RANK() OVER(
    ORDER BY SUM(sales) DESC
  ) AS `dense_rank`
FROM transactions
GROUP BY customer_id;
