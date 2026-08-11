-- PostgreSQL
-- Problem:
-- Given couriers and deliveries tables, return each courier_id and courier_name
-- with the number of delivered requests and the number of late delivered requests.
-- delivered_count counts rows whose status is 'delivered'.
-- late_count counts rows whose status is 'delivered' and whose actual_minutes is
-- greater than estimated_minutes.
-- Result columns: courier_id, courier_name, delivered_count, late_count
-- Sort by late_count descending, then courier_id ascending.

-- Attempt 1:
-- SELECT c.courier_id, c.courier_name,
--   count(case when status = 'delivered' then 1 end) as delivered_count,
--   count(case when status = 'delivered' and actual_minutes > estimated_minutes then 1 end) as late_count
-- FROM couriers as c
-- INNER JOIN deliveries as d
--   ON c.courier_id = d.courier_id
-- GROUP BY c.courier_id
-- ORDER BY late_count DESC, courier_id ASC
-- Result: Incorrect
-- Reason:
-- c.courier_name appears in SELECT as a regular column, so PostgreSQL expects it
-- to be included in GROUP BY.

-- Attempt 2:
-- SELECT c.courier_id, c.courier_name,
--   count(case when status = 'delivered' then 1 end) as delivered_count,
--   count(case when status = 'delivered' and actual_minutes > estimated_minutes then 1 end) as late_count
-- FROM couriers as c
-- INNER JOIN deliveries as d
--   ON c.courier_id = d.courier_id
-- GROUP BY c.courier_id, c.courier_name
-- ORDER BY late_count DESC, courier_id ASC
-- Result: Correct
-- Note:
-- When column names can appear in both joined tables, table aliases make the query
-- easier to read and less ambiguous.

SELECT c.courier_id,
  c.courier_name,
  COUNT(CASE WHEN d.status = 'delivered' THEN 1 END) AS delivered_count,
  COUNT(CASE
    WHEN d.status = 'delivered' AND d.actual_minutes > d.estimated_minutes THEN 1
  END) AS late_count
FROM couriers AS c
INNER JOIN deliveries AS d
  ON c.courier_id = d.courier_id
GROUP BY c.courier_id, c.courier_name
ORDER BY late_count DESC, c.courier_id ASC;
