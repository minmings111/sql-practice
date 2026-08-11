-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'I' and y is greater than or equal to 8.
-- Sort the result by x in ascending order.

SELECT *
FROM points
WHERE quartet = 'I'
  AND y >= 8
ORDER BY x ASC;
