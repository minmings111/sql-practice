-- PostgreSQL
-- Problem:
-- Given orders and order_items, return each customer_id and the total charged amount
-- of their completed orders.
-- tax_rate is an integer percentage.
-- The charged amount of one item is calculated by multiplying quantity by unit_price
-- and then adding tax according to tax_rate.
-- Only orders whose status is 'completed' should be included.
-- Only customers whose total charged amount is greater than 200000 should be returned.
-- Result columns: customer_id, total_charged
-- Sort by total_charged descending, then customer_id ascending.

-- Attempt 1:
-- SELECT customer_id, sum(quantity * unit_price + tax_rate) as total_charged
-- FROM orders
-- INNER JOIN order_items
--   ON  orders.order_id = order_items.order_id
-- WHERE orders.status = 'completed'
-- GROUP BY customer_id
-- HAVING sum(quantity * unit_price + tax_rate) > 200000
-- ORDER BY total_charged DESC, customer_id ASC
-- Result: Incorrect
-- Reason:
-- tax_rate is a percentage, not a fixed amount to add.
-- For example, tax_rate = 10 means adding 10% of the base amount.

-- Attempt 2:
-- SELECT customer_id, sum(quantity * unit_price + (quantity * unit_price)/100 * tax_rate) as total_charged
-- FROM orders
-- INNER JOIN order_items
--   ON  orders.order_id = order_items.order_id
-- WHERE orders.status = 'completed'
-- GROUP BY customer_id
-- HAVING sum(quantity * unit_price + (quantity * unit_price)/100 * tax_rate ) > 200000
-- ORDER BY total_charged DESC, customer_id ASC
-- Result: Correct direction
-- Note:
-- This captures the percentage-tax idea.
-- The final answer multiplies before dividing to avoid early integer truncation.

SELECT o.customer_id,
  SUM(oi.quantity * oi.unit_price * (100 + oi.tax_rate) / 100) AS total_charged
FROM orders AS o
INNER JOIN order_items AS oi
  ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY o.customer_id
HAVING SUM(oi.quantity * oi.unit_price * (100 + oi.tax_rate) / 100) > 200000
ORDER BY total_charged DESC, o.customer_id ASC;
