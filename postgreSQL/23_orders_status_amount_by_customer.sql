-- PostgreSQL
-- Problem:
-- Given an orders table, return each customer_id with the total amount of completed
-- orders and the total amount of canceled orders.
-- If a customer has no completed orders or no canceled orders, return 0 for that amount.
-- Result columns: customer_id, completed_amount, canceled_amount
-- Sort by customer_id ascending.

-- Attempt 1:
-- SELECT customer_id, count(amount) as completed_amount
--
-- count( over(
--
-- partition by amount = 0
-- )
-- as
-- order by customer_id ASC
-- Result: Incorrect
-- Reason:
-- COUNT counts rows, not money. This problem asks for status-based amount totals,
-- so it needs conditional SUM with CASE WHEN.
-- A window function is not needed because the final result has one row per customer.

-- Attempt 2:
-- SELECT customer_id,
--   sum(case when status = 'completed' then amount else 0) as completed_amount,
--   sum(case when status = 'canceled' then amount else 0) as canceled_amount
-- FROM orders
-- GROUP BY customer_id
-- ORDER BY customer_id ASC;
-- Result: Incorrect syntax
-- Reason:
-- CASE expressions must be closed with END before the aggregate function can sum them.

SELECT customer_id,
  SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) AS completed_amount,
  SUM(CASE WHEN status = 'canceled' THEN amount ELSE 0 END) AS canceled_amount
FROM orders
GROUP BY customer_id
ORDER BY customer_id ASC;
