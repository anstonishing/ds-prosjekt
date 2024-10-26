SELECT ship_country,
	AVG(shipped_date - order_date)::decimal(10,2) AS avg_days,
	COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE 
	EXTRACT(YEAR FROM order_date) = 1998
GROUP BY ship_country
HAVING 
	AVG(shipped_date - order_date) >= 5 AND COUNT(DISTINCT order_id) > 10
ORDER BY ship_country ASC 