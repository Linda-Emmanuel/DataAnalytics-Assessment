-- ==========================================================
-- Customer Savings and Investment Analysis
-- This script calculates the number of savings and investment plans 
-- for each customer and the total amount deposited.
-- ==========================================================

SELECT 
    a.ID AS OWNER_ID,
    CONCAT(a.first_name, ' ', a.last_name) AS name,
    COUNT(DISTINCT CASE
            WHEN c.is_regular_savings = 1 THEN c.id
        END) AS savings_count,
    COUNT(DISTINCT CASE
            WHEN c.is_a_fund = 1 THEN c.id
        END) investment_count,
    ROUND(SUM(confirmed_amount / 100),2) total_deposits
FROM
    users_customuser a
        JOIN
    savings_savingsaccount b ON a.id = b.owner_id
        JOIN
    plans_plan c ON b.plan_id = c.id
WHERE
    confirmed_amount > 0
GROUP BY a.ID , CONCAT(a.first_name, ' ', a.last_name)
HAVING COUNT(DISTINCT CASE
        WHEN c.is_regular_savings = 1 THEN c.id
    END) > 0
    AND COUNT(DISTINCT CASE
        WHEN c.is_a_fund = 1 THEN c.id
    END) > 0
ORDER BY total_deposits DESC


