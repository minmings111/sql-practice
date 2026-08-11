-- PostgreSQL
-- Problem:
-- In reviews, return the average rating for each product.
-- Result columns: product_id, avg_rating
-- Sort by avg_rating descending, then product_id ascending.

-- Attempt 1:
-- Result: Correct

SELECT product_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY product_id
ORDER BY avg_rating DESC, product_id ASC;
