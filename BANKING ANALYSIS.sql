USE banking_analysis;
SELECT * FROM customers;               #Data Check
SELECT * FROM transactions;            #Data Check
SELECT * FROM loans;                   #Data Check

SELECT COUNT(*) AS total_customers FROM customers;                     #Basic Understanding (Total Customers)
SELECT COUNT(*) AS total_transactions FROM transactions;               #Basic Understanding (Total Transactions)
SELECT SUM(loan_amount) AS total_loan FROM loans;                      #Basic Understanding (Total Loan Amount)

SELECT *
FROM transactions
WHERE amount > 15000
AND location NOT IN ('Mumbai','Delhi','Kolkata','Bangalore','Ahmedabad','Noida','Chennai');   #Fraud Detection (Suspicious Transactions)

SELECT 
    c.customer_id,
    c.name,
    c.income,
    SUM(t.amount) AS total_spending
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.name, c.income;           #Customer Risk Profiling

SELECT 
    loan_status,
    COUNT(*) AS total_loans,
    AVG(loan_amount) AS avg_loan
FROM loans
GROUP BY loan_status;                              #Loan Risk Analysis

SELECT 
    c.name,
    c.income,
    SUM(t.amount) AS spending
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.name, c.income
HAVING spending > c.income;                      #High-Risk Customers Identify

SELECT 
    customer_id,
    amount,
    RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS txn_rank
FROM transactions;                                       #Top Transactions per Customer (Window Function)

WITH customer_spending AS (
    SELECT customer_id, SUM(amount) AS total
    FROM transactions
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total > 30000;                                    #High Value Customers (CTE)           


