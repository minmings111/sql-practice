-- PostgreSQL
-- Problem:
-- In products, consider only rows where the product is active.
-- Return each category's average price.
-- Include only categories whose average price is greater than or equal to 50000.
-- Result columns: category, avg_price
-- Sort by avg_price descending, then category ascending.

-- Attempt 1:
-- SELECT category, AVG(price) as avg_price
-- FROM products
-- WHERE is_active = 1
-- GROUP BY category
-- ORDER BY avg_price DESC, category ASC
-- Result: Incorrect
-- Reason:
-- is_active is a boolean column in PostgreSQL, so compare it as a boolean value.
-- The query also missed the grouped condition for average price >= 50000.

-- Attempt 2:
-- Result: Correct

SELECT category, AVG(price) AS avg_price
FROM products
WHERE is_active IS TRUE
GROUP BY category
HAVING AVG(price) >= 50000
ORDER BY avg_price DESC, category ASC;
