WITH CategoryStats AS (
    SELECT
        p.category_id,
        ROUND(AVG(p.unit_price)::numeric, 2) AS avg_price,
        ROUND(
            PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY p.unit_price)::numeric, 
            2
        ) AS median_price
    FROM products p
    WHERE p.discontinued = 0
    GROUP BY p.category_id
)

SELECT
    c.category_name,
    p.product_name,
    p.unit_price,
    cs.avg_price AS category_avg_price,
    cs.median_price AS category_median_price,
    CASE
        WHEN p.unit_price < cs.avg_price THEN 'Below Average'
        WHEN p.unit_price = cs.avg_price THEN 'Equal Average'
        ELSE 'Over Average'
    END AS position_against_avg,
    CASE
        WHEN p.unit_price < cs.median_price THEN 'Below Median'
        WHEN p.unit_price = cs.median_price THEN 'Equal Median'
        ELSE 'Over Median'
    END AS position_against_median
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN CategoryStats cs ON p.category_id = cs.category_id
WHERE p.discontinued = 0
ORDER BY c.category_name, p.product_name;

-- (OpenAI, 2023) - Used to fix errors, get suggestions and control check answer up against business question



