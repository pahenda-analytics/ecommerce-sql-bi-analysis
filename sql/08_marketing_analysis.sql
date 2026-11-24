-- Marketing Channel Analysis
-- Excludes credit notes and bad-debt adjustments.

-- Revenue, Profit and Identified Customers by Marketing Channel

SELECT
    marketing_channel,
    COUNT(DISTINCT customer_id) AS identified_customers,
    ROUND(SUM(revenue), 2) AS gross_sales_revenue,
    ROUND(SUM(profit), 2) AS gross_sales_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY marketing_channel
ORDER BY gross_sales_revenue DESC;


-- Profit Ranking by Marketing Channel

SELECT
    marketing_channel,
    ROUND(SUM(profit), 2) AS gross_sales_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY marketing_channel
ORDER BY gross_sales_profit DESC;