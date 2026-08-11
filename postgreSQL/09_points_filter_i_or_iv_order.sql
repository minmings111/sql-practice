-- PostgreSQL
-- Problem:
-- Select all rows from points where quartet is 'I' or 'IV'.
-- Sort by quartet in ascending order, then by id in ascending order.

SELECT *
FROM points
WHERE quartet = 'I'
   OR quartet = 'IV'
ORDER BY quartet ASC, id ASC;
