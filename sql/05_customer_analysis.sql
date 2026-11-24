-- Top 10 Customers by Gross Sales Revenue
-- Excludes credit notes and bad-debt adjustments.
-- Excludes transactions without an identified customer.

SELECT
    customer_id,
    ROUND(SUM(revenue), 2) AS customer_revenue
FROM v_clean_ecommerce_data
WHERE customer_id IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY customer_id
ORDER BY customer_revenue DESC
LIMIT 10;


-- Rank Customers by Gross Sales Revenue

SELECT
    customer_id,
    ROUND(SUM(revenue), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS customer_rank
FROM v_clean_ecommerce_data
WHERE customer_id IS NOT NULL
  AND invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
GROUP BY customer_id
ORDER BY customer_rank
LIMIT 10;