-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'IV'.
-- Sort the result by id in descending order.

SELECT *
FROM points
WHERE quartet = 'IV'
ORDER BY id DESC;
