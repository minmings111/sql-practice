-- PostgreSQL
-- Problem:
-- Given players and games tables, return a ranking of all players with their total
-- number of game points.
-- A win is worth 5 points, a draw is worth 2 points, and a loss is worth 0 points.
-- Players can appear as either player_a or player_b in games.
-- Result columns: player_id, player_name, total_points
-- Sort by total_points descending, then player_id ascending.

-- Attempt 1:
-- SELECT p.player_id, p.player_name,
--   COALESCE(SUM(ps.point), 0) AS total_points
-- FROM players
-- LEFT JOIN (
--   SELECT player_a,
--     CASE WHEN score_a > score_b THEN 5
--          WHEN score_a = score_b THEN 2
--          ELSE 0 END AS point
--   FROM games
--
--   UNION ALL
--
--   SELECT player_b,
--     CASE WHEN score_b > score_a THEN 5
--          WHEN score_b = score_a THEN 2
--          ELSE 0 END AS point
--   FROM games
-- ) AS ps
-- GROUP BY p.player_id, p.player_name
-- ORDER BY total_points DESC, player_id ASC
-- Result: Incorrect syntax
-- Reason:
-- The players table was referenced as p, but no alias was declared in FROM.
-- The LEFT JOIN also needs an ON condition.
-- The UNION ALL result should expose player_id so the outer query can join on it.

-- Attempt 2:
-- SELECT p.player_id, p.player_name,
--   COALESCE(SUM(ps.point), 0) AS total_points
-- FROM players AS p
-- LEFT JOIN (
--   SELECT player_a AS player_id,
--     CASE WHEN score_a > score_b THEN 5
--          WHEN score_a = score_b THEN 2
--          ELSE 0 END AS point
--   FROM games
--
--   UNION ALL
--
--   SELECT player_b AS player_id,
--     CASE WHEN score_b > score_a THEN 5
--          WHEN score_b = score_a THEN 2
--          ELSE 0 END AS point
--   FROM games
-- ) AS ps
--   ON p.player_id = ps.player_id
-- GROUP BY p.player_id, p.player_name
-- ORDER BY total_points DESC, player_id ASC
-- Result: Correct
-- Note:
-- Using p.player_id in ORDER BY is safer because player_id also exists in ps.

SELECT p.player_id,
  p.player_name,
  COALESCE(SUM(ps.point), 0) AS total_points
FROM players AS p
LEFT JOIN (
  SELECT player_a AS player_id,
    CASE
      WHEN score_a > score_b THEN 5
      WHEN score_a = score_b THEN 2
      ELSE 0
    END AS point
  FROM games

  UNION ALL

  SELECT player_b AS player_id,
    CASE
      WHEN score_b > score_a THEN 5
      WHEN score_b = score_a THEN 2
      ELSE 0
    END AS point
  FROM games
) AS ps
  ON p.player_id = ps.player_id
GROUP BY p.player_id, p.player_name
ORDER BY total_points DESC, p.player_id ASC;
