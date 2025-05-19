
WITH CTE1 AS (
    SELECT 
        b.plan_id,
        a.owner_id,
        CASE 
			WHEN a.is_a_fund = 1 THEN 'Investment'
            WHEN a.is_regular_savings = 1 THEN 'Savings'
            ELSE 'Other'
        END AS 'type',
        MAX(b.transaction_date) AS last_transaction_date,
        DATEDIFF(CURRENT_DATE(), MAX(b.transaction_date)) AS inactivity_days
    FROM 
        plans_plan a
    JOIN 
        savings_savingsaccount b ON a.id = b.plan_id
    WHERE 
         (a.is_regular_savings = 1 OR a.is_a_fund = 1)  
    GROUP BY 
        b.plan_id, a.owner_id
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    inactivity_days
FROM 
    CTE1
WHERE 
    inactivity_days >= 365  
    AND type != 'Other'
ORDER BY 
    inactivity_days DESC