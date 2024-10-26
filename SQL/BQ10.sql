WITH EmployeeSalesPerCategory AS (
    SELECT
        e.employee_id,
        c.category_id,
        c.category_name,
        e.first_name,
        e.last_name,
        SUM(od.unit_price * od.quantity * (1 - od.discount)) AS TotalSalesAmount
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    JOIN order_details od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
    JOIN employees e ON o.employee_id = e.employee_id
    GROUP BY e.employee_id, c.category_id, c.category_name, e.first_name, e.last_name
),

EmployeeTotalSales AS (
    SELECT
        employee_id,
        SUM(TotalSalesAmount) AS EmployeeTotalSalesAmount
    FROM EmployeeSalesPerCategory
    GROUP BY employee_id
),

TotalSales AS (
    SELECT SUM(TotalSalesAmount) AS OverallTotalSalesAmount
    FROM EmployeeSalesPerCategory
)

SELECT
    esp.category_name,
    esp.first_name || ' ' || esp.last_name AS FullName,
    ROUND(esp.TotalSalesAmount::numeric, 2) AS TotalSalesAmountFormatted,
    ROUND((esp.TotalSalesAmount / ets.EmployeeTotalSalesAmount)::numeric, 5) AS PercentageOfEmployeeTotal,
    ROUND((esp.TotalSalesAmount / ts.OverallTotalSalesAmount)::numeric, 5) AS PercentageOfOverallTotal
FROM EmployeeSalesPerCategory esp
JOIN EmployeeTotalSales ets ON esp.employee_id = ets.employee_id
CROSS JOIN TotalSales ts
ORDER BY esp.category_name ASC, esp.TotalSalesAmount DESC;

-- (OpenAI, 2023) - Used to fix errors, get suggestions and control check answer up against business question