-- Headline Sales KPIs
-- Excludes credit notes and bad-debt adjustments from sales metrics.

WITH invoice_totals AS (
    SELECT
        invoice,
        SUM(revenue) AS invoice_revenue,
        SUM(profit) AS invoice_profit
    FROM v_clean_ecommerce_data
    WHERE invoice NOT LIKE 'C%'
      AND description IS DISTINCT FROM 'Adjust bad debt'
    GROUP BY invoice
)

SELECT
    ROUND(SUM(invoice_revenue), 2) AS gross_sales_revenue,
    ROUND(SUM(invoice_profit), 2) AS gross_sales_profit,
    COUNT(*) AS total_sales_orders,
    ROUND(AVG(invoice_revenue), 2) AS average_order_value
FROM invoice_totals;