-- PostgreSQL
-- Problem:
-- In payments, consider only rows where method is 'card'.
-- Return the total payment amount for each user.
-- Result columns: user_id, total_amount
-- Sort by total_amount descending, then user_id ascending.

SELECT user_id, SUM(amount) AS total_amount
FROM payments
WHERE method = 'card'
GROUP BY user_id
ORDER BY total_amount DESC, user_id ASC;
