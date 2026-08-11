-- PostgreSQL
-- Problem:
-- In orders, consider only rows where status is 'completed'.
-- Return the number of orders for each customer.
-- Result columns: customer_id, order_count
-- Sort by order_count descending, then customer_id ascending.

SELECT customer_id, COUNT(*) AS order_count
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
ORDER BY order_count DESC, customer_id ASC;
