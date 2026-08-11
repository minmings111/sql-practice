-- PostgreSQL
-- Problem:
-- Given orders and order_items, return each customer_id and the total paid amount
-- of their completed orders.
-- The paid amount of one item is calculated as:
-- quantity * unit_price * (100 - discount_rate) / 100
-- Only orders whose status is 'completed' should be included.
-- Only customers whose total paid amount is greater than or equal to 150000 should be returned.
-- Result columns: customer_id, total_paid
-- Sort by total_paid descending, then customer_id ascending.

-- Attempt 1:
-- SELECT customer_id, sum(quantity * unit_price * (100 - discount_rate) / 100) as total_paid
-- FROM orders
-- INNER JOIN order_items
--   ON orders.order_id = order_items.order_id
-- WHERE orders.status = 'completed'
-- GROUP BY customer_id
-- HAVING sum(quantity * unit_price * (100 - discount_rate) / 100) >= 150000
-- ORDER BY total_paid DESC, customer_id ASC
-- Result: Correct
-- Note:
-- The final answer uses table aliases so the source of each column is clear.

SELECT o.customer_id,
  SUM(oi.quantity * oi.unit_price * (100 - oi.discount_rate) / 100) AS total_paid
FROM orders AS o
INNER JOIN order_items AS oi
  ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY o.customer_id
HAVING SUM(oi.quantity * oi.unit_price * (100 - oi.discount_rate) / 100) >= 150000
ORDER BY total_paid DESC, o.customer_id ASC;
