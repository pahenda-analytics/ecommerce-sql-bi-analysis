-- Monthly Sales Performance and Month-on-Month Growth
-- Excludes credit notes and bad-debt adjustments.
-- Uses gross sales revenue and profit for consistent reporting.

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
),

MonthlyComparisons AS (
    SELECT 
        sales_month,
        total_revenue,
        total_profit,
        total_orders,
        LAG(total_revenue) OVER (ORDER BY sales_month) AS prev_month_revenue
    FROM MonthlyMetrics
)

SELECT 
    sales_month,
    ROUND(total_revenue, 2) AS current_month_revenue,
    ROUND(prev_month_revenue, 2) AS prev_month_revenue,
    ROUND(
        ((total_revenue - prev_month_revenue) / NULLIF(prev_month_revenue, 0)) * 100,
        2
    ) AS mom_growth_pct,
    ROUND(total_profit, 2) AS total_profit,
    total_orders
FROM MonthlyComparisons
ORDER BY sales_month;