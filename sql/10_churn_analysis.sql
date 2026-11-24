-- Churn Flag Data Quality Analysis
-- Investigates whether churn_flag is reliable at customer level.

-- Distribution of Churn Flags Across Transactions

SELECT
    churn_flag,
    COUNT(*) AS transaction_rows,
    COUNT(DISTINCT customer_id) AS identified_customers,
    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS anonymous_rows
FROM v_clean_ecommerce_data
GROUP BY churn_flag
ORDER BY churn_flag;


-- Customer-Level Churn Flag Consistency

SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE churn_flag_count = 1
    ) AS customers_with_consistent_churn_flag,
    COUNT(*) FILTER (
        WHERE churn_flag_count > 1
    ) AS customers_with_multiple_churn_flags,
    ROUND(
        COUNT(*) FILTER (
            WHERE churn_flag_count = 1
        ) * 100.0 / COUNT(*),
        2
    ) AS consistent_customer_percentage
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT churn_flag) AS churn_flag_count
    FROM v_clean_ecommerce_data
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
) AS customer_churn;