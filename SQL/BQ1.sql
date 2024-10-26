SELECT product_name, unit_price
FROM products

WHERE 
	unit_price >= 20 AND unit_price <= 50 AND discontinued = 0
ORDER BY unit_price DESC;

-- (OpenAI, 2023) - Used to control check answer up against business question