-- Data Cleaning ----

1.-- --- -- Total Records -- --- --
SELECT COUNT(*) AS total_records
FROM transactions;

2.-- --- -- NULL Customer IDs -- --- --
SELECT COUNT(*) AS null_customer_ids
FROM transactions
WHERE customer_id IS NULL;

3.-- --- -- NULL Sales -- --- -- 
SELECT COUNT(*) AS null_sales
FROM transactions
WHERE sales IS NULL;

4.-- --- -- Invalid Sales -- --- --
SELECT COUNT(*) AS invalid_sales
FROM transactions
WHERE sales<=0;

5.-- --- -- Invalid Quantity -- --- --
SELECT COUNT(*) AS invalid_quantity
FROM transactions
WHERE quantity<=0;

6.-- --- -- Duplicate Transactions -- --- --
SELECT
transaction_id,
COUNT(*) total
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*)>1;

7.-- --- -- Missing Marketing Channel -- --- --
SELECT COUNT(*) AS missing_channel
FROM marketing_touchpoints
WHERE channel IS NULL;

8.-- --- -- Missing Campaign -- --- --
SELECT COUNT(*) AS missing_campaign
FROM marketing_touchpoints
WHERE campaign IS NULL;

9.-- --- -- Missing Touch Date -- --- --
SELECT COUNT(*) AS missing_touch_date
FROM marketing_touchpoints
WHERE touch_date IS NULL;

10.-- --- -- Customer Validation -- --- --
SELECT COUNT(DISTINCT customer_id)
FROM transactions;

SELECT COUNT(DISTINCT customer_id)
FROM marketing_touchpoints;

11.-- --- -- Common Customers -- --- --
SELECT COUNT(DISTINCT t.customer_id)
FROM transactions t
INNER JOIN marketing_touchpoints m
ON t.customer_id=m.customer_id;

12.-- --- -- Summary -- --- --
SELECT
COUNT(*) AS total_transactions,
COUNT(DISTINCT customer_id) AS unique_customers,
SUM(sales) AS total_sales,
AVG(sales) AS average_sales
FROM transactions;


