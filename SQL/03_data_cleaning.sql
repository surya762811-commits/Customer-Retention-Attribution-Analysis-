-- --- -- Check Null Customer -- --- --
SELECT COUNT(*)
FROM transactions
WHERE customer_id IS NULL;

-- --- -- Check Invalid Sales -- --- -- 
SELECT COUNT(*)
FROM transactions
WHERE sales <= 0;
