-- Country Analysis
-- Excludes credit notes and bad-debt adjustments.


-- Revenue and Profit by Country

SELECT
    country,
    COUNT(DISTINCT customer_id) AS identified_customers,
    ROUND(SUM(revenue), 2) AS gross_sales_revenue,
    ROUND(SUM(profit), 2) AS gross_sales_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY country
ORDER BY gross_sales_revenue DESC;


-- Identified Customer Count by Country

SELECT
    country,
    COUNT(DISTINCT customer_id) AS total_customers
FROM v_clean_ecommerce_data
WHERE customer_id IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY country
ORDER BY total_customers DESC;