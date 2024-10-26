SELECT
    c.category_name,
    CASE
        WHEN od.unit_price < 20 THEN '1. Below $20'
        WHEN od.unit_price BETWEEN 20 AND 50 THEN '2. $20 - $50'
        ELSE '3. Over $50'
    END AS price_range,
    
    -- Calculating total amount
    SUM((od.unit_price * od.quantity) * (1 - od.discount))::integer AS total_amount,
    
    -- Count of orders
    COUNT(DISTINCT od.order_id) AS order_volume
    
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN categories c ON c.category_id = p.category_id

GROUP BY c.category_name, price_range
ORDER BY c.category_name, price_range;

-- (OpenAI, 2023) - Used to fix errors, get suggestions and control check answer up against business question