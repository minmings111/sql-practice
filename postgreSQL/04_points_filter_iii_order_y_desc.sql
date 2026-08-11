-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'III'.
-- Sort the result by y in descending order.

SELECT *
FROM points
WHERE quartet = 'III'
ORDER BY y DESC;
