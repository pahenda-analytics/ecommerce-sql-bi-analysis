-- Discount Analysis
-- Excludes credit notes and bad-debt adjustments.

-- Compare Average Revenue and Profit per Transaction Row

SELECT
    CASE
        WHEN discount_applied = 1 THEN 'Discount'
        ELSE 'No Discount'
    END AS discount_group,
    COUNT(*) AS transaction_rows,
    ROUND(AVG(revenue), 2) AS average_revenue_per_row,
    ROUND(AVG(profit), 2) AS average_profit_per_row,
    ROUND(SUM(revenue), 2) AS gross_sales_revenue,
    ROUND(SUM(profit), 2) AS gross_sales_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY discount_group
ORDER BY discount_group;