-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'II' and x is greater than 10.
-- Sort the result by y in descending order.

SELECT *
FROM points
WHERE quartet = 'II'
  AND x > 10
ORDER BY y DESC;
