-- PostgreSQL
-- Problem:
-- Given customers and orders tables, return each customer_id and customer_name
-- with the total amount of completed orders and the total amount of canceled orders.
-- completed_amount sums order amounts whose status is 'completed'.
-- canceled_amount sums order amounts whose status is 'canceled'.
-- Result columns: customer_id, customer_name, completed_amount, canceled_amount
-- Sort by completed_amount descending, then customer_id ascending.

-- Attempt 1:
-- SELECT c.customer_id, c.customer_name,
--   sum(case when o.status = 'completed' then o.amount else 0 end) as completed_amount,
--   sum(case when o.status = 'canceled' then o.amount else 0 end) as canceled_amount
-- FROM customers as c
-- INNER JOIN orders as o
--   ON c.customer_id = o.customer_id
-- GROUP BY c.customer_id, c.customer_name
-- ORDER BY completed_amount DESC, customer_id ASC
-- Result: Correct
-- Note:
-- This is the right conditional SUM pattern.
-- In joined queries, using c.customer_id in ORDER BY is safer because customer_id
-- exists in both tables.

SELECT c.customer_id,
  c.customer_name,
  SUM(CASE WHEN o.status = 'completed' THEN o.amount ELSE 0 END) AS completed_amount,
  SUM(CASE WHEN o.status = 'canceled' THEN o.amount ELSE 0 END) AS canceled_amount
FROM customers AS c
INNER JOIN orders AS o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY completed_amount DESC, c.customer_id ASC;
