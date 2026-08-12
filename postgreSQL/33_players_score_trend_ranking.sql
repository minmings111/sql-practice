-- PostgreSQL
-- Problem:
-- Given players and score_logs tables, return a ranking of all players with the
-- difference between their latest score and second latest score.
-- Latest means the most recent row in terms of recorded_at.
-- If a player has fewer than two score records, return 0 as score_diff.
-- Result columns: player_id, player_name, score_diff
-- Sort by score_diff descending, then player_id ascending.

-- Attempt 1:
-- SELECT p.player_id, p.player_name,
--   MAX(CASE WHEN sub.rn = 1 THEN score END)
--   -
--   MAX(CASE WHEN sub.rn = 2 THEN score END) AS score_diff
-- FROM players AS p
-- LEFT JOIN (
--   FROM (
--     SELECT player_id, score, ROW_NUMBER() OVER (
--       PARTITION BY player_id
--       ORDER BY recorded_at DESC
--     ) AS rn
--     FROM score_logs
--   ) AS sub
-- )
-- ON p.player_id = sub.player_id
-- GROUP BY p.player_id, p.player_name
-- Result: Incorrect syntax
-- Reason:
-- LEFT JOIN should be followed directly by a derived table SELECT.
-- The extra FROM (...) wrapper is invalid.

-- Attempt 2:
-- SELECT p.player_id, p.player_name,
--   MAX(CASE WHEN sub.rn = 1 THEN score END)
--   -
--   MAX(CASE WHEN sub.rn = 2 THEN score END) AS score_diff
-- FROM players AS p
-- LEFT JOIN (
--   SELECT player_id, score, ROW_NUMBER() OVER (
--     PARTITION BY player_id
--     ORDER BY recorded_at DESC
--   ) AS rn
--   FROM score_logs
-- ) AS sub
--   ON p.player_id = sub.player_id
-- GROUP BY p.player_id, p.player_name
-- Result: Incomplete
-- Reason:
-- Players with zero or one score record produce NULL instead of 0.
-- The required ORDER BY is also missing.

-- Attempt 3:
-- SELECT p.player_id, p.player_name,
--   caolesce(
--     MAX(CASE WHEN sub.rn = 1 THEN score END)
--     -
--     MAX(CASE WHEN sub.rn = 2 THEN score END),
--     0
--   ) AS score_diff
-- FROM players AS p
-- LEFT JOIN (
--   SELECT player_id, score, ROW_NUMBER() OVER (
--     PARTITION BY player_id
--     ORDER BY recorded_at DESC
--   ) AS rn
--   FROM score_logs
-- ) AS sub
--   ON p.player_id = sub.player_id
-- GROUP BY p.player_id, p.player_name
-- ORDER BY score_diff DESC, player_id ASC;
-- Result: Incorrect syntax
-- Reason:
-- COALESCE was misspelled as caolesce.

-- Attempt 4:
-- SELECT p.player_id, p.player_name,
--   COALESCE(
--     MAX(CASE WHEN sub.rn = 1 THEN sub.score END)
--     -
--     MAX(CASE WHEN sub.rn = 2 THEN sub.score END),
--     0
--   ) AS score_diff
-- FROM players AS p
-- LEFT JOIN (
--   SELECT player_id, score, ROW_NUMBER() OVER (
--     PARTITION BY player_id
--     ORDER BY recorded_at DESC
--   ) AS rn
--   FROM score_logs
-- ) AS sub
--   ON p.player_id = sub.player_id
-- GROUP BY p.player_id, p.player_name
-- ORDER BY score_diff DESC, p.player_id ASC;
-- Result: Correct

SELECT p.player_id,
  p.player_name,
  COALESCE(
    MAX(CASE WHEN sub.rn = 1 THEN sub.score END)
    -
    MAX(CASE WHEN sub.rn = 2 THEN sub.score END),
    0
  ) AS score_diff
FROM players AS p
LEFT JOIN (
  SELECT player_id,
    score,
    ROW_NUMBER() OVER (
      PARTITION BY player_id
      ORDER BY recorded_at DESC
    ) AS rn
  FROM score_logs
) AS sub
  ON p.player_id = sub.player_id
GROUP BY p.player_id, p.player_name
ORDER BY score_diff DESC, p.player_id ASC;
