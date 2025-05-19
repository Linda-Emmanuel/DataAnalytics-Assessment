
WITH months_trans AS (
    SELECT 
        owner_id,
        COUNT(DISTINCT DATE_FORMAT(transaction_date, '%Y-%m')) AS active_months,
        COUNT(*) / COUNT(DISTINCT DATE_FORMAT(transaction_date, '%Y-%m')) AS avg_monthly_transactions
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id
)
SELECT 
    CASE 
        WHEN avg_monthly_transactions >= 10 THEN 'High Frequency'
        WHEN avg_monthly_transactions BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_monthly_transactions), 2) AS avg_transactions_per_month
FROM 
    months_trans
GROUP BY 
    frequency_category
ORDER BY
  CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END
