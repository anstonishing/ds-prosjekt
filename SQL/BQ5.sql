SELECT
    p.product_name,
    ROUND(sub.initial_price::numeric, 2) AS initial_price,
    ROUND(sub.last_price::numeric, 2) AS current_price,
    CAST((sub.last_price - sub.initial_price) / sub.initial_price * 100 AS INTEGER) AS percentage_increase
FROM products p
JOIN 
    (
        SELECT 
            od.product_id,
            (SELECT od1.unit_price FROM order_details od1 JOIN orders o1 ON o1.order_id = od1.order_id WHERE od1.product_id = od.product_id ORDER BY o1.order_date ASC LIMIT 1) AS initial_price,
            (SELECT od2.unit_price FROM order_details od2 JOIN orders o2 ON o2.order_id = od2.order_id WHERE od2.product_id = od.product_id ORDER BY o2.order_date DESC LIMIT 1) AS last_price
        FROM order_details od
        GROUP BY 
            od.product_id
    ) AS sub ON p.product_id = sub.product_id
WHERE 
    CAST((sub.last_price - sub.initial_price) / sub.initial_price * 100 AS INTEGER) NOT BETWEEN 20 AND 30
AND
    sub.last_price != sub.initial_price
ORDER BY percentage_increase ASC;

-- (OpenAI, 2023) - Used to fix errors, get suggestions and control check answer up against business question