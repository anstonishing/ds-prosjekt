SELECT
    e.first_name || ' ' || e.last_name AS FullName,
    e.title AS JobTitle,

    -- Total sales amount excluding discount
    ROUND(SUM(od.unit_price * od.quantity)::numeric, 2) AS TotalSalesAmountWithoutDiscount,
    
    -- Total number of unique orders
    COUNT(DISTINCT o.order_id) AS TotalUniqueOrders,
    
    -- Total number of orders
    COUNT(o.order_id) AS TotalOrders,
    
    -- Average product amount excluding discount
    ROUND((SUM(od.unit_price * od.quantity) / COUNT(o.order_id))::numeric, 2) AS AverageProductAmountWithoutDiscount,
    
    -- Average order amount excluding discount
    ROUND((SUM(od.unit_price * od.quantity) / COUNT(DISTINCT o.order_id))::numeric, 2) AS AverageOrderAmountWithoutDiscount,
    
    -- Total discount amount
    ROUND(SUM(od.unit_price * od.quantity * od.discount)::numeric, 2) AS TotalDiscountAmount,
    
    -- Total sales amount including discount
    ROUND((SUM(od.unit_price * od.quantity) - SUM(od.unit_price * od.quantity * od.discount))::numeric, 2) AS TotalSalesAmountWithDiscount,

    -- Total discount percentage
    ROUND((SUM(od.unit_price * od.quantity * od.discount) / SUM(od.unit_price * od.quantity) * 100)::numeric, 2) AS TotalDiscountPercentage

FROM
    employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY
    e.first_name, e.last_name, e.title
ORDER BY
    TotalSalesAmountWithDiscount DESC;

   -- (OpenAI, 2023) - Used to fix errors, get suggestions and control check answer up against business question