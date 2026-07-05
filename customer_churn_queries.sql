CREATE TABLE telecom_churn (
    state VARCHAR(5),
    account_length INT,
    area_code INT,
    international_plan VARCHAR(5),
    voice_mail_plan VARCHAR(5),
    number_vmail_messages INT,
    total_day_minutes FLOAT,
    total_day_calls INT,
    total_day_charge FLOAT,
    total_eve_minutes FLOAT,
    total_eve_calls INT,
    total_eve_charge FLOAT,
    total_night_minutes FLOAT,
    total_night_calls INT,
    total_night_charge FLOAT,
    total_intl_minutes FLOAT,
    total_intl_calls INT,
    total_intl_charge FLOAT,
    customer_service_calls INT,
    churn BOOLEAN
);
SELECT * FROM telecom_churn;


-- CUSTOMER CHURN ANALYSIS FOR TELECOM INDUSTRY
-- PostgreSQL SQL Queries

-- 1. Total Customers
SELECT COUNT(*) AS total_customers
FROM telecom_churn;

-- 2. Total Churned Customers
SELECT COUNT(*) AS churned_customers
FROM telecom_churn
WHERE churn = TRUE;

-- 3. Churn Rate (%)
SELECT
ROUND(
COUNT(*) FILTER (WHERE churn = TRUE) * 100.0 / COUNT(*),
2
) AS churn_rate
FROM telecom_churn;

-- 4. Average Account Length
SELECT
ROUND(AVG(account_length),2) AS average_account_length
FROM telecom_churn;

-- 5. Average Total Day Minutes
SELECT
ROUND(AVG(total_day_minutes),2) AS average_day_minutes
FROM telecom_churn;

-- 6. Average Total Evening Minutes
SELECT
ROUND(AVG(total_eve_minutes),2) AS average_evening_minutes
FROM telecom_churn;

-- 7. Average Total Night Minutes
SELECT
ROUND(AVG(total_night_minutes),2) AS average_night_minutes
FROM telecom_churn;

-- 8. Average International Minutes
SELECT
ROUND(AVG(total_intl_minutes),2) AS average_international_minutes
FROM telecom_churn;

-- 9. Churn by State
SELECT
state,
COUNT(*) AS customers,
SUM(CASE WHEN churn = TRUE THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY state
ORDER BY churned_customers DESC;

-- 10. Churn by Area Code
SELECT
area_code,
COUNT(*) AS customers,
SUM(CASE WHEN churn = TRUE THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY area_code
ORDER BY churned_customers DESC;

-- 11. International Plan vs Churn
SELECT
international_plan,
COUNT(*) AS customers,
SUM(CASE WHEN churn = TRUE THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY international_plan;

-- 12. Voice Mail Plan vs Churn
SELECT
voice_mail_plan,
COUNT(*) AS customers,
SUM(CASE WHEN churn = TRUE THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY voice_mail_plan;

-- 13. Average Customer Service Calls
SELECT
ROUND(AVG(customer_service_calls),2) AS average_service_calls
FROM telecom_churn;

-- 14. Customers with More Than 3 Customer Service Calls
SELECT *
FROM telecom_churn
WHERE customer_service_calls > 3;

-- 15. Top 10 Customers by Total Day Minutes
SELECT *
FROM telecom_churn
ORDER BY total_day_minutes DESC
LIMIT 10;

-- 16. Top 10 Customers by International Minutes
SELECT *
FROM telecom_churn
ORDER BY total_intl_minutes DESC
LIMIT 10;

-- 17. Average Charges
SELECT
ROUND(AVG(total_day_charge),2) AS avg_day_charge,
ROUND(AVG(total_eve_charge),2) AS avg_evening_charge,
ROUND(AVG(total_night_charge),2) AS avg_night_charge,
ROUND(AVG(total_intl_charge),2) AS avg_intl_charge
FROM telecom_churn;

-- 18. High Risk Customers
SELECT *
FROM telecom_churn
WHERE customer_service_calls >= 4
AND international_plan = 'Yes';

-- 19. Top 10 States with Highest Churn Rate
SELECT
state,
ROUND(
SUM(CASE WHEN churn = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS churn_rate
FROM telecom_churn
GROUP BY state
ORDER BY churn_rate DESC
LIMIT 10;

-- 20. Customer Segmentation
SELECT
CASE
    WHEN customer_service_calls >= 4 THEN 'At Risk'
    WHEN customer_service_calls BETWEEN 2 AND 3 THEN 'Dormant'
    ELSE 'Loyal'
END AS customer_segment,
COUNT(*) AS total_customers
FROM telecom_churn
GROUP BY customer_segment;

-- 21. Churn by Customer Service Calls
SELECT
customer_service_calls,
COUNT(*) AS customers,
SUM(CASE WHEN churn = TRUE THEN 1 ELSE 0 END) AS churned_customers
FROM telecom_churn
GROUP BY customer_service_calls
ORDER BY customer_service_calls;

-- 22. International Plan Usage
SELECT
international_plan,
ROUND(AVG(total_intl_minutes),2) AS avg_international_minutes
FROM telecom_churn
GROUP BY international_plan;

-- 23. Voice Mail Usage
SELECT
voice_mail_plan,
ROUND(AVG(number_vmail_messages),2) AS avg_voice_messages
FROM telecom_churn
GROUP BY voice_mail_plan;

-- 24. Average Usage by Churn Status
SELECT
churn,
ROUND(AVG(total_day_minutes),2) AS avg_day_minutes,
ROUND(AVG(total_eve_minutes),2) AS avg_evening_minutes,
ROUND(AVG(total_night_minutes),2) AS avg_night_minutes
FROM telecom_churn
GROUP BY churn;

-- 25. Top 20 Customers by Total Usage
SELECT *,
(total_day_minutes + total_eve_minutes + total_night_minutes + total_intl_minutes) AS total_usage
FROM telecom_churn
ORDER BY total_usage DESC
LIMIT 20;