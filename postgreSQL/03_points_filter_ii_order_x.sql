-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'II'.
-- Sort the result by x in ascending order.

SELECT *
FROM points
WHERE quartet = 'II'
ORDER BY x ASC;
