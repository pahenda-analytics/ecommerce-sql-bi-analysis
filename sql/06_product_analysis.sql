-- Product Analysis
-- Excludes credit notes and bad-debt adjustments.
-- Excludes records without a product description.


-- Revenue and Profit by Category

SELECT
    category,
    ROUND(SUM(revenue), 2) AS gross_sales_revenue,
    ROUND(SUM(profit), 2) AS gross_sales_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
  AND description IS NOT NULL
GROUP BY category
ORDER BY gross_sales_revenue DESC;


-- Revenue and Profit by Subcategory

SELECT
    subcategory,
    ROUND(SUM(revenue), 2) AS gross_sales_revenue,
    ROUND(SUM(profit), 2) AS gross_sales_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
  AND description IS NOT NULL
GROUP BY subcategory
ORDER BY gross_sales_revenue DESC;


-- Top 20 Most Profitable Products

SELECT
    description,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
  AND description IS NOT NULL
GROUP BY description
ORDER BY total_profit DESC
LIMIT 20;


-- Top 20 Products by Revenue

SELECT
    description,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
  AND description IS NOT NULL
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 20;


-- Product Revenue Ranking

SELECT
    description,
    ROUND(SUM(revenue), 2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS product_rank
FROM v_clean_ecommerce_data
WHERE invoice NOT LIKE 'C%'
  AND description IS DISTINCT FROM 'Adjust bad debt'
  AND description IS NOT NULL
GROUP BY description
ORDER BY product_rank;