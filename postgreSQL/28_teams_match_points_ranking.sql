-- PostgreSQL
-- Problem:
-- Given teams and matches tables, return a ranking of all teams with their total
-- number of match points.
-- A win is worth 3 points, a draw is worth 1 point, and a loss is worth 0 points.
-- Teams can appear as either host_team or guest_team in matches.
-- Result columns: team_id, team_name, num_points
-- Sort by num_points descending, then team_id ascending.

-- Attempt 1:
-- SELECT team_id, team_name
-- FROM teams
--
-- UNION ALL
--
-- SELECT host_team, guest_team
-- FROM matches
-- Result: Incorrect
-- Reason:
-- UNION ALL stacks rows with the same column meaning.
-- Here, team_name and guest_team do not mean the same thing, so the result shape
-- becomes invalid for this problem.

-- Attempt 2:
-- SELECT host_team AS team_id,
--   CASE WHEN host_goals > guest_goals THEN 3
--        WHEN host_goals = guest_goals THEN 1
--        ELSE 0 END AS score
-- FROM matches
--
-- UNION ALL
--
-- SELECT guest_team AS team_id,
--   CASE WHEN guest_goals > host_goals THEN 3
--        WHEN guest_goals = host_goals THEN 1
--        ELSE 0 END AS score
-- FROM matches
-- Result: Correct intermediate table
-- Note:
-- This creates one score row per team per match, but it still needs SUM by team_id.

-- Attempt 3:
-- SELECT t.team_id, t.team_name,
--   tm.score AS num_points
-- FROM teams AS t
-- INNER JOIN (
--   ...
-- ) AS tm
--   ON t.team_id = tm.team_id
-- ORDER BY num_points DESC, team_id ASC
-- Result: Incorrect
-- Reason:
-- This returns one row per match score, not one row per team.
-- The scores must be grouped by team and summed.

-- Attempt 4:
-- SELECT t.team_id, t.team_name,
--   SUM(tm.score) AS num_points
-- FROM teams AS t
-- INNER JOIN (
--   ...
-- ) AS tm
--   ON t.team_id = tm.team_id
-- GROUP BY t.team_id, t.team_name
-- ORDER BY num_points DESC, team_id ASC
-- Result: Incomplete
-- Reason:
-- INNER JOIN excludes teams with no matches. The problem asks for all teams.

-- Attempt 5:
-- SELECT t.team_id, t.team_name,
--   SUM(tm.score) AS num_points
-- FROM teams AS t
-- LEFT JOIN (
--   ...
-- ) AS tm
--   ON t.team_id = tm.team_id
-- GROUP BY t.team_id, t.team_name
-- ORDER BY num_points DESC, team_id ASC
-- Result: Incomplete
-- Reason:
-- Teams with no matches get NULL from SUM(tm.score). COALESCE is needed to return 0.

SELECT t.team_id,
  t.team_name,
  COALESCE(SUM(tm.score), 0) AS num_points
FROM teams AS t
LEFT JOIN (
  SELECT host_team AS team_id,
    CASE
      WHEN host_goals > guest_goals THEN 3
      WHEN host_goals = guest_goals THEN 1
      ELSE 0
    END AS score
  FROM matches

  UNION ALL

  SELECT guest_team AS team_id,
    CASE
      WHEN guest_goals > host_goals THEN 3
      WHEN guest_goals = host_goals THEN 1
      ELSE 0
    END AS score
  FROM matches
) AS tm
  ON t.team_id = tm.team_id
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id ASC;
