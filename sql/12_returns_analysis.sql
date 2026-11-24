-- Returns and Credit Note Analysis
-- Uses credit-note invoices as a proxy for return activity.
-- Credit notes may include adjustments other than physical product returns.

-- Overall Credit Note Metrics

SELECT
    COUNT(DISTINCT invoice) AS credit_note_invoices,
    COUNT(*) AS credit_note_transaction_rows,
    ROUND(SUM(revenue), 2) AS net_credit_note_value,
    ROUND(SUM(profit), 2) AS net_credit_note_profit_impact
FROM v_clean_ecommerce_data
WHERE invoice LIKE 'C%';


-- Credit Note Activity by Category

SELECT
    category,
    COUNT(*) AS credit_note_transaction_rows,
    ROUND(SUM(revenue), 2) AS net_credit_note_value,
    ROUND(SUM(profit), 2) AS net_credit_note_profit_impact
FROM v_clean_ecommerce_data
WHERE invoice LIKE 'C%'
GROUP BY category
ORDER BY net_credit_note_value;