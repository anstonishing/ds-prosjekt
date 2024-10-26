SELECT 
    DATE_TRUNC('MONTH', order_date)::DATE AS year_month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(freight::decimal), 0) AS total_freight
FROM orders
WHERE 
    EXTRACT(YEAR FROM order_date) BETWEEN 1997 AND 1998
GROUP BY DATE_TRUNC('MONTH', order_date)
HAVING COUNT(order_id) > 35
ORDER BY SUM(freight) DESC;

-- (OpenAI, 2023) - Used to control check answer up against business question
  