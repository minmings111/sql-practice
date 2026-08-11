-- PostgreSQL
-- Problem:
-- Given an orders table, return each customer_id with the total number of orders
-- and the number of completed orders.
-- Result columns: customer_id, total_count, completed_count
-- Sort by completed_count descending, then customer_id ascending.

-- Attempt 1:
-- SELECT customer_id,
--   count(amount) as total_count,
--   count(case when status = 'completed' then amount else null end) as completed_count
-- FROM orders
-- GROUP BY customer_id
-- ORDER BY completed_count DESC, customer_id ASC
-- Result: Correct
-- Note:
-- COUNT(column) counts only non-NULL values.
-- The CASE expression returns amount for completed rows and NULL otherwise,
-- so only completed rows are counted.
-- For total rows, COUNT(*) is clearer than COUNT(amount).
-- ELSE NULL can be omitted because CASE returns NULL when no condition matches.

SELECT customer_id,
  COUNT(*) AS total_count,
  COUNT(CASE WHEN status = 'completed' THEN 1 END) AS completed_count
FROM orders
GROUP BY customer_id
ORDER BY completed_count DESC, customer_id ASC;
