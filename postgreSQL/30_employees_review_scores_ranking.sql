-- PostgreSQL
-- Problem:
-- Given employees and reviews tables, return a ranking of all employees with their
-- total review score.
-- If an employee's score is higher than the other employee's score, they get 10 points.
-- If both scores are equal, they get 4 points.
-- If an employee's score is lower than the other employee's score, they get 0 points.
-- Employees can appear as either reviewer_id or reviewee_id in reviews.
-- Result columns: employee_id, employee_name, total_score
-- Sort by total_score descending, then employee_id ascending.

-- Attempt 1:
-- SELECT e.employee_id, e.employee_name,
--   COALESCE(SUM(score), 0) AS total_score
-- FROM employees AS e
-- LEFT JOIN (
--   SELECT reviewer_id AS employee_id,
--     CASE WHEN reviewer_score > reviewee_score > 10
--          WHEN reviewer_score > reviewee_score = 10
--          ELSE 0 END AS score
--   FROM reviews
--
--   UNION ALL
--
--   SELECT reviewee_id AS employee_id,
--     CASE WHEN reviewee_score > reviewer_score > 10
--          WHEN reviewee_score > reviewer_score = 10
--          ELSE 0 END AS score
--   FROM reviews
-- ) AS rr
--   ON e.employee_id = rr.employee_id
-- GROUP BY e.employee_id, e.employee_name
-- ORDER BY total_score DESC, e.employee_id ASC
-- Result: Incorrect syntax
-- Reason:
-- CASE WHEN uses the form WHEN condition THEN result.
-- The score value belongs after THEN, not inside the comparison condition.

-- Attempt 2:
-- SELECT e.employee_id, e.employee_name,
--   COALESCE(SUM(score), 0) AS total_score
-- FROM employees AS e
-- LEFT JOIN (
--   SELECT reviewer_id AS employee_id,
--     CASE WHEN reviewer_score > reviewee_score THEN 10
--          WHEN reviewer_score = reviewee_score THEN 4
--          ELSE 0 END AS score
--   FROM reviews
--
--   UNION ALL
--
--   SELECT reviewee_id AS employee_id,
--     CASE WHEN reviewee_score > reviewer_score THEN 10
--          WHEN reviewee_score = reviewer_score THEN 4
--          ELSE 0 END AS score
--   FROM reviews
-- ) AS rr
--   ON e.employee_id = rr.employee_id
-- GROUP BY e.employee_id, e.employee_name
-- ORDER BY total_score DESC, e.employee_id ASC
-- Result: Correct
-- Note:
-- Using rr.score in SUM is clearer in joined queries.

SELECT e.employee_id,
  e.employee_name,
  COALESCE(SUM(rr.score), 0) AS total_score
FROM employees AS e
LEFT JOIN (
  SELECT reviewer_id AS employee_id,
    CASE
      WHEN reviewer_score > reviewee_score THEN 10
      WHEN reviewer_score = reviewee_score THEN 4
      ELSE 0
    END AS score
  FROM reviews

  UNION ALL

  SELECT reviewee_id AS employee_id,
    CASE
      WHEN reviewee_score > reviewer_score THEN 10
      WHEN reviewee_score = reviewer_score THEN 4
      ELSE 0
    END AS score
  FROM reviews
) AS rr
  ON e.employee_id = rr.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY total_score DESC, e.employee_id ASC;
