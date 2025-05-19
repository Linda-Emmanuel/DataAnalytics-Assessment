-- ==========================================================
-- Customer Lifetime Value (CLV) Estimation
-- This script calculates the estimated CLV for each customer 
-- based on their transaction history and profit per transaction.
-- ==========================================================

SELECT 
    owner_id AS customer_id,
    CONCAT(a.first_name, ' ', a.last_name) AS name,
    TIMESTAMPDIFF(MONTH, a.date_joined, CURRENT_DATE()) AS tenure_months,
    COUNT(a.id) AS total_transactions,
    ROUND(
        (COUNT(b.id) / GREATEST(TIMESTAMPDIFF(MONTH, a.date_joined, CURRENT_DATE()), 1)) * 12 * 
        (SUM(b.confirmed_amount) / COUNT(a.id)) * 0.001, 
        2
    ) AS estimated_clv
FROM 
    users_customuser a
LEFT JOIN 
    savings_savingsaccount b ON a.id = b.owner_id
    AND b.confirmed_amount > 0  
WHERE 
    a.is_active = 1  
    AND a.is_account_deleted = 0  
GROUP BY 
    a.id, a.first_name, a.last_name, a.date_joined
HAVING 
    tenure_months > 0  
ORDER BY 
    estimated_clv DESC