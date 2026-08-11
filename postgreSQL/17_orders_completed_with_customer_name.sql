-- PostgreSQL
-- Problem:
-- Given orders and customers, return order_id, customer name, and amount
-- for every order whose status is 'completed'.
-- Result columns: order_id, name, amount
-- Sort by amount descending, then order_id ascending.

-- Attempt 1:
-- SELECT order_id, name, amount
-- FROM orders
-- INNER JOIN customers
--   ON customer_id
-- WHERE status = 'completed'
-- ORDER BY amount DESC, order_id ASC
-- Result: Incorrect
-- Reason:
-- The ON clause must explicitly compare the matching columns from both tables.
-- ON customer_id does not say how orders and customers should be connected.

-- Attempt 2:
-- SELECT order_id, name, amount
-- FROM orders
-- INNER JOIN customers
--   ON orders.customer_id = customers.customer_id
-- WHERE status = 'completed'
-- ORDER BY amount DESC, order_id ASC
-- Result: Correct
-- Note:
-- This works because order_id, name, amount, and status are not ambiguous here.
-- The final answer uses table aliases to make the table source explicit.

SELECT o.order_id, c.name, o.amount
FROM orders AS o
INNER JOIN customers AS c
  ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
ORDER BY o.amount DESC, o.order_id ASC;
