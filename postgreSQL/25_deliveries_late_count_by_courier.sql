-- PostgreSQL
-- Problem:
-- Given a deliveries table, return each courier_id with the number of delivered
-- requests and the number of late delivered requests.
-- delivered_count counts rows whose status is 'delivered'.
-- late_count counts rows whose status is 'delivered' and whose actual_minutes is
-- greater than estimated_minutes.
-- Result columns: courier_id, delivered_count, late_count
-- Sort by late_count descending, then courier_id ascending.

-- Attempt 1:
-- SELECT courier_id,
--   count(case when status = 'delivered) then (*) END) as delivered_count,
--   count(case when status = 'delivered' and actual_minutes > estimated_minutes then (*) END) as late_count
-- FROM deliveries
-- GROUP BY courier_id
-- ORDER BY late_count DESC, courier_id ASC;
-- Result: Incorrect syntax
-- Reason:
-- The string 'delivered' must be closed with a quote.
-- CASE returns a value for each row, so THEN (*) is not valid.
-- For conditional counts, return a non-NULL value such as 1.

-- Attempt 2:
-- SELECT courier_id,
--   count(case when status = 'delivered' then (1) END) as delivered_count,
--   count(case when status = 'delivered' and actual_minutes > estimated_minutes then (1) END) as late_count
-- FROM deliveries
-- GROUP BY courier_id
-- ORDER BY late_count DESC, courier_id ASC;
-- Result: Correct
-- Note:
-- THEN (1) works, but THEN 1 is the more common style.

SELECT courier_id,
  COUNT(CASE WHEN status = 'delivered' THEN 1 END) AS delivered_count,
  COUNT(CASE
    WHEN status = 'delivered' AND actual_minutes > estimated_minutes THEN 1
  END) AS late_count
FROM deliveries
GROUP BY courier_id
ORDER BY late_count DESC, courier_id ASC;
