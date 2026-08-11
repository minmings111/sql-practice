-- PostgreSQL
-- Problem:
-- In payments, consider only rows where amount is greater than or equal to 10000.
-- Return each user's payment count and total payment amount.
-- Result columns: user_id, payment_count, total_amount
-- Sort by payment_count descending, then total_amount descending, then user_id ascending.

-- Attempt 1:
-- SELECT user_id, count(user_id) as payment_count, sum(amount) as total_amount
-- FROM payments
-- WHERE amount  >= 10000
-- GROUP BY user_id
-- ORDER BY payment_count DESC, total_amount DESC, user_id ASC
-- Result: Correct
-- Note:
-- COUNT(user_id) works when user_id is present on every payment row.
-- COUNT(*) is commonly used when the intent is to count rows.

SELECT user_id, COUNT(*) AS payment_count, SUM(amount) AS total_amount
FROM payments
WHERE amount >= 10000
GROUP BY user_id
ORDER BY payment_count DESC, total_amount DESC, user_id ASC;
