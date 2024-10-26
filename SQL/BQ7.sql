WITH RegionalSuppliers AS (
    SELECT 
        supplier_id,
        CASE
            WHEN country IN ('USA', 'Brazil', 'Canada') THEN 'America'
            WHEN country IN ('UK', 'Spain', 'Sweden', 'Germany', 'Italy', 'Norway', 'France', 'Denmark', 'Netherlands') THEN 'Europe'
            ELSE 'Asia-Pacific'
        END AS supplier_region
    FROM suppliers
)

SELECT
    rs.supplier_region,
    c.category_name,
    SUM(p.unit_in_stock) AS total_units_in_stock,
    SUM(p.unit_on_order) AS total_units_on_order,
    SUM(p.reorder_level) AS total_reorder_level
FROM RegionalSuppliers rs
JOIN products p ON rs.supplier_id = p.supplier_id
JOIN categories c ON c.category_id = p.category_id
GROUP BY rs.supplier_region, c.category_name
ORDER BY c.category_name ASC, rs.supplier_region ASC, SUM(p.reorder_level) ASC;


-- (OpenAI, 2023) - Used to fix errors, get suggestions and control check answer up against business question

