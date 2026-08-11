-- PostgreSQL
-- Problem:
-- Select id, x, and y from points where quartet is 'III' and y is less than 7.
-- Sort the result by id in ascending order.

SELECT id, x, y
FROM points
WHERE quartet = 'III'
  AND y < 7
ORDER BY id ASC;
