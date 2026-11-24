-- Intermediate SQL Analysis
-- Demonstrates CTEs, window functions and running totals.
-- All sales metrics exclude credit notes and bad-debt adjustments.


-- 1. CTE: Monthly Sales Metrics

WITH MonthlyMetrics AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS sales_month,
        SUM(revenue) AS total_revenue,
        SUM(profit) AS total_profit,
        COUNT(DISTINCT invoice) AS total_orders
    FROM v_clean_ecommerce_data
    WHERE invoice_date IS NOT NULL
      AND invoice NOT LIKE 'C%'
      AND description IS DISTINCT FROM 'Adjust bad debt'
    GROUP BY 1
)

SELECT *
FROM MonthlyMetrics
ORDER BY sales_month;


-- 2. LAG(): Previous Month Revenue

WITH MonthlyMetrics AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS sales_month,
        SUM(revenue) AS total_revenue
    FROM v_clean_ecommerce_data
    WHERE invoice_date IS NOT NULL
      AND invoice NOT LIKE 'C%'
      AND description IS DISTINCT FROM 'Adjust bad debt'
    GROUP BY 1
)

SELECT
    sales_month,
    ROUND(total_revenue, 2) AS current_month_revenue,
    ROUND(
        LAG(total_revenue) OVER (ORDER BY sales_month),
        2
    ) AS previous_month_revenue
FROM MonthlyMetrics
ORDER BY sales_month;


-- 3. ROW_NUMBER(): Customer Revenue Ranking

SELECT
    customer_id,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROW_NUMBER() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS customer_row_number
FROM v_clean_ecommerce_data
WHERE customer_id IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY customer_id
ORDER BY customer_row_number
LIMIT 20;


-- 4. RANK(): Customer Revenue Ranking

SELECT
    customer_id,
    ROUND(SUM(revenue), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM v_clean_ecommerce_data
WHERE customer_id IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY customer_id
ORDER BY revenue_rank
LIMIT 20;


-- 5. DENSE_RANK(): Customer Revenue Ranking

SELECT
    customer_id,
    ROUND(SUM(revenue), 2) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM v_clean_ecommerce_data
WHERE customer_id IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY customer_id
ORDER BY revenue_rank
LIMIT 20;


-- 6. Running Total: Cumulative Monthly Revenue

SELECT
    DATE_TRUNC('month', invoice_date) AS sales_month,
    ROUND(SUM(revenue), 2) AS monthly_revenue,
    ROUND(
        SUM(SUM(revenue)) OVER (
            ORDER BY DATE_TRUNC('month', invoice_date)
        ),
        2
    ) AS cumulative_revenue
FROM v_clean_ecommerce_data
WHERE invoice_date IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY 1
ORDER BY 1;