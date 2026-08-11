-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'I'.
-- Sort the result by y in ascending order.

SELECT *
FROM points
WHERE quartet = 'I'
ORDER BY y ASC;
