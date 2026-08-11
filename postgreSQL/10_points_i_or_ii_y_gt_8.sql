-- PostgreSQL
-- Problem:
-- Select id, quartet, and y from points where quartet is 'I' or 'II'
-- and y is greater than 8.
-- Sort by quartet in ascending order, then by y in descending order.

-- Attempt 1:
-- Result: Correct

SELECT id, quartet, y
FROM points
WHERE (quartet = 'I' OR quartet = 'II')
  AND y > 8
ORDER BY quartet ASC, y DESC;
