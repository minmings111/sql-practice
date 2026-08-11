-- PostgreSQL
-- Problem:
-- In orders, consider only rows where status is 'completed'.
-- Return each customer's total order amount.
-- Include only customers whose total order amount is greater than or equal to 100000.
-- Result columns: customer_id, total_amount
-- Sort by total_amount descending, then customer_id ascending.

-- Attempt 1:
-- SELECT customer_id, sum(amount) as total_amount
-- FROM orders
-- WHERE status = 'completed'
-- AND total_amount >= 100000
-- GROUP BY customer_id
-- ORDER BY total_amount DESC, customer_id ASC
-- Result: Incorrect
-- Reason:
-- total_amount is an aggregate alias created after grouping.
-- WHERE filters rows before GROUP BY, so it cannot filter grouped aggregate results.

-- Attempt 2:
-- SELECT customer_id, sum(amount) as total_amount
-- FROM orders
-- WHERE status = 'completed'
-- GROUP BY customer_id
-- HAVING total_amount >= 100000
-- ORDER BY total_amount DESC, customer_id ASC
-- Result: Incorrect
-- Reason:
-- HAVING is the right clause, but PostgreSQL usually does not allow
-- SELECT aliases such as total_amount to be referenced in HAVING.

-- Attempt 3:
-- SELECT customer_id, sum(amount) as total_amount
-- FROM orders
-- WHERE status = 'completed'
-- GROUP BY customer_id
-- HAVING amount >= 100000
-- ORDER BY total_amount DESC, customer_id ASC
-- Result: Incorrect
-- Reason:
-- The condition must filter each customer's total amount, not a single row's amount.
-- Use the aggregate expression SUM(amount) in HAVING.

-- Attempt 4:
-- Result: Correct

SELECT customer_id, SUM(amount) AS total_amount
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
HAVING SUM(amount) >= 100000
ORDER BY total_amount DESC, customer_id ASC;
