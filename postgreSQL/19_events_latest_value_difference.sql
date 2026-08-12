-- PostgreSQL
-- Problem:
-- Given an events table, for each event_type that has been registered more than once,
-- return the difference between the latest value and the second latest value.
-- Latest means the most recent row in terms of time.
-- Result column order: event_type, value
-- Sort by event_type ascending.
-- Column names do not matter, but their order does.

-- Attempt 1:
-- SELECT event_type, max(value)-large(2, value) as value
-- FROM events
-- GROUP BY event_type
-- Result: Incorrect
-- Reason:
-- This compares the maximum value with a non-existent large(...) function.
-- The task is not asking for the largest and second largest values.
-- It asks for the latest and second latest values by time.

-- Attempt 2:
-- SELECT event_type, value
-- FROM (
--     SELECT *
--     FROM events
--     GROUP BY event_type
--     ORDER BY event_type ASC, time DESC
-- )
-- Result: Incorrect
-- Reason:
-- GROUP BY event_type collapses rows before the latest and second latest rows are identified.
-- SELECT * with GROUP BY event_type is also invalid in PostgreSQL because value and time
-- are neither grouped nor aggregated.

-- Attempt 3:
-- SELECT event_type, value
-- FROM (
--     SELECT event_type, value, ROW_NUMBER() OVER (
--       PARTITION BY event_type
--       ORDER BY time DESC
--     )
--     FROM events
-- )
-- GROUP BY event_type
-- Result: Incorrect
-- Reason:
-- ROW_NUMBER needs an alias so the outer query can reference it.
-- The outer query also needs a way to turn rn = 1 and rn = 2 into values on the same row.

-- Attempt 4:
-- SELECT event_type,
--   (
--     MAX(CASE WHEN rn = 1 THEN value END)
--     -
--     MAX(CASE WHEN rn = 2 THEN value END)
--   ) AS value
-- FROM (
--   SELECT event_type, value, ROW_NUMBER() OVER (
--     PARTITION BY event_type
--     ORDER BY time DESC
--   ) AS rn
--   FROM events
-- )
-- GROUP BY event_type
-- ORDER BY event_type ASC
-- Result: Incorrect
-- Reason:
-- PostgreSQL requires a derived table alias after FROM (...).
-- The query also needs to exclude event_type values that appear only once.

-- Attempt 5:
-- Result: Correct

-- Repractice attempt 1:
-- SELECT event_type, value, ROW_NUMBER() OVER (
--   PARTITION BY event_type
--   ORDER BY time DESC
-- ) AS rn
-- FROM events
-- Result: Correct intermediate step
-- Note:
-- This correctly assigns rn = 1 to the latest row and rn = 2 to the second latest
-- row within each event_type.

-- Repractice attempt 2:
-- SELECT event_type,
--   (CASE WHEN rn = 1 THEN value END) - (CASE WHEN rn = 2 THEN value END) AS value
-- FROM (
--   SELECT event_type, value, ROW_NUMBER() OVER (
--     PARTITION BY event_type
--     ORDER BY time DESC
--   ) AS rn
--   FROM events
-- )
-- GROUP BY event_type
-- ORDER BY event_type ASC;
-- Result: Incorrect
-- Reason:
-- rn = 1 and rn = 2 are different rows. A single row cannot be both rn = 1 and rn = 2,
-- so the direct subtraction produces NULL-like row-level expressions instead of one
-- group-level difference.
-- PostgreSQL also requires a derived table alias after FROM (...).

-- Repractice attempt 3:
-- SELECT event_type,
--   MAX(CASE WHEN rn = 1 THEN value END)
--   -
--   MAX(CASE WHEN rn = 2 THEN value END) AS value
-- FROM (
--   SELECT event_type, value, ROW_NUMBER() OVER (
--     PARTITION BY event_type
--     ORDER BY time DESC
--   ) AS rn
--   FROM events
-- ) AS sub
-- GROUP BY event_type
-- ORDER BY event_type ASC;
-- Result: Almost correct
-- Reason:
-- This extracts rn = 1 and rn = 2 values correctly, but it still includes event_type
-- values registered only once. The problem asks for event_type values registered
-- more than once.

-- Repractice attempt 4:
-- SELECT event_type,
--   MAX(CASE WHEN rn = 1 THEN value END)
--   -
--   MAX(CASE WHEN rn = 2 THEN value END) AS value
-- FROM (
--   SELECT event_type, value, ROW_NUMBER() OVER (
--     PARTITION BY event_type
--     ORDER BY time DESC
--   ) AS rn
--   FROM events
-- ) AS sub
-- GROUP BY event_type
-- HAVING COUNT(*) >= 2
-- ORDER BY event_type ASC;
-- Result: Correct
-- Note:
-- HAVING COUNT(*) >= 2 matches the condition "registered more than once".

SELECT event_type,
  (
    MAX(CASE WHEN rn = 1 THEN value END)
    -
    MAX(CASE WHEN rn = 2 THEN value END)
  ) AS value
FROM (
  SELECT
    event_type,
    value,
    ROW_NUMBER() OVER (
      PARTITION BY event_type
      ORDER BY time DESC
    ) AS rn
  FROM events
) AS ranked
GROUP BY event_type
HAVING COUNT(*) >= 2
ORDER BY event_type ASC;
