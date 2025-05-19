# DataAnalytics-Assessment
This is a repo created for Cowrywise Assesments

Assessment Questions and Explanations

Q1: High-Value Customers with Multiple Products
Scenario: Identify customers with at least one funded savings plan AND one funded investment plan.
Approach:
-Joined users_customuser, savings_savingsaccount, and plans_plan tables.
-Filtered for customers with both savings and investment plans.
-Calculated total deposits while keeping in mind that the amount is in kobo so tghere's a need to convert to naira.

Q2: Transaction Frequency Analysis
Scenario: Categorize customers based on transaction frequency.
Approach:
Common table expression (CTE) was used
Calculated average transactions per month for each customer.
Categorized customers using a CASE statement (High, Medium, Low).

Q3: Account Inactivity Alert
Scenario: Detect accounts with no inflow transactions for over a year.
Approach:
Used a CTE for the latest transaction date.
Filtered accounts with inactivity over 365 days.

Customer Lifetime Value (CLV) Estimation
Scenario: Estimate CLV using account tenure and transaction volume.
Approach:
Calculated tenure in months and total transactions.
Used the formula:
CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction


Challenges Faced
Optimizing queries for performance: I used Common Table Expressions (CTE) to optimize my query.

Linda Emmanuel 
