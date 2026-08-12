-- PostgreSQL
-- Problem:
-- Given a price_logs table, for each product_id that has been changed more than once,
-- return the difference between the latest price and the second latest price.
-- Latest means the most recent row in terms of changed_at.
-- Result column order: product_id, price_change
-- Sort by product_id ascending.

-- Attempt 1:
-- SELECT product_id,
--   MAX(CASE WHEN rn = 1 THEN price END)
--   -
--   MAX(CASE WHEN rn = 2 THEN price END) AS price_change
-- FROM (
--   SELECT product_id, price, ROW_NUMBER() OVER (
--     PARTITION BY product_id
--     ORDER BY changed_at DESC
--   ) AS rn
--   FROM price_logs
-- ) AS sub
-- GROUP BY product_id
-- HAVING COUNT(*) > 1
-- ORDER BY product_id ASC
-- Result: Correct

SELECT product_id,
  MAX(CASE WHEN rn = 1 THEN price END)
  -
  MAX(CASE WHEN rn = 2 THEN price END) AS price_change
FROM (
  SELECT product_id,
    price,
    ROW_NUMBER() OVER (
      PARTITION BY product_id
      ORDER BY changed_at DESC
    ) AS rn
  FROM price_logs
) AS sub
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY product_id ASC;
