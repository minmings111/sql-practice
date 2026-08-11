-- PostgreSQL
-- Problem:
-- Given orders and customers, return each customer's name and the total amount
-- of their completed orders.
-- Include only orders whose status is 'completed'.
-- Include only customers whose total completed order amount is greater than or equal to 100000.
-- Result columns: name, total_amount
-- Sort by total_amount descending, then name ascending.

-- Attempt 1:
-- SELECT name, sum(amount) as total_amount
-- FROM orders
--   INNER JOIN customers
--   ON orders.customer_id = customers.customer_id
-- WHERE status = 'completed'
-- GROUP BY name
-- HAVING sum(amount) >= 100000
-- ORDER BY total_amount DESC, name ASC;
-- Result: Correct
-- Note:
-- The final answer uses table aliases so each column's source is clear.

SELECT c.name, SUM(o.amount) AS total_amount
FROM orders AS o
INNER JOIN customers AS c
  ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.name
HAVING SUM(o.amount) >= 100000
ORDER BY total_amount DESC, c.name ASC;
