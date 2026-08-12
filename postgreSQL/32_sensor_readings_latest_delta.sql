-- PostgreSQL
-- Problem:
-- Given a sensor_readings table, for each sensor_id that has been recorded more
-- than once, return the difference between the latest reading and the second
-- latest reading.
-- Latest means the most recent row in terms of recorded_at.
-- Result column order: sensor_id, reading_delta
-- Sort by sensor_id ascending.

-- Attempt 1:
-- SELECT sensor_id,
--   MAX(CASE WHEN rn = 1 THEN reading END)
--   -
--   MAX(CASE WHEN rn = 2 THEN reading END) AS reading_delta
-- FROM (
--   SELECT sensor_id, reading, ROW_NUMBER() OVER (
--     PARTITION BY sensor_id
--     ORDER BY recorded_at DESC
--   ) AS rn
--   FROM sensor_readings
-- ) AS sub
-- GROUP BY sensor_id
-- HAVING COUNT(*) > 1
-- ORDER BY sensor_id ASC
-- Result: Correct

SELECT sensor_id,
  MAX(CASE WHEN rn = 1 THEN reading END)
  -
  MAX(CASE WHEN rn = 2 THEN reading END) AS reading_delta
FROM (
  SELECT sensor_id,
    reading,
    ROW_NUMBER() OVER (
      PARTITION BY sensor_id
      ORDER BY recorded_at DESC
    ) AS rn
  FROM sensor_readings
) AS sub
GROUP BY sensor_id
HAVING COUNT(*) > 1
ORDER BY sensor_id ASC;
