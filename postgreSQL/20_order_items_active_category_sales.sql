-- PostgreSQL
-- Problem:
-- Given order_items and products, return each product category and the total sales amount.
-- The sales amount of one row is calculated as quantity * unit_price.
-- Only active products should be included.
-- Only categories whose total sales amount is greater than 200000 should be returned.
-- Result columns: category, total_sales
-- Sort by total_sales descending, then category ascending.

-- Attempt 1:
-- SELECT category, (quantity * unit_price) as total_sales
-- FROM order_items
-- INNER JOIN products
--   ON order_items.product_id = products.product_id
-- GROUP BY category
-- HAVING (quantity * unit_price) > 200000
-- ORDER BY total_sales DESC, category ASC;
-- Result: Incorrect
-- Reason:
-- The query calculates the sales amount for one row, not the total sales amount by category.
-- It also misses the active product filter.
-- The grouped filter must use SUM(quantity * unit_price).

-- Attempt 2:
-- SELECT category, sum(quantity * unit_price) as total_sales
-- FROM order_items
-- INNER JOIN products
--   ON order_items.product_id = products.product_id
-- WHERE products.is_active IS TRUE
-- GROUP BY category
-- HAVING sum(quantity * unit_price) > 200000
-- ORDER BY total_sales DESC, category ASC;
-- Result: Correct
-- Note:
-- The final answer uses table aliases so the source of each column is clear.

SELECT p.category, SUM(oi.quantity * oi.unit_price) AS total_sales
FROM order_items AS oi
INNER JOIN products AS p
  ON oi.product_id = p.product_id
WHERE p.is_active IS TRUE
GROUP BY p.category
HAVING SUM(oi.quantity * oi.unit_price) > 200000
ORDER BY total_sales DESC, p.category ASC;
