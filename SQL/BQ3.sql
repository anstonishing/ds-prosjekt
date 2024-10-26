SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name, 
	e.title AS employee_title,
	EXTRACT(YEAR FROM e.hire_date) - EXTRACT(YEAR FROM e.birth_date) AS age_at_hire,
	CONCAT(m.first_name, ' ', m.last_name) AS manager_full_name, 
    m.title AS manager_title
FROM employees e
LEFT JOIN employees m ON e.reports_to = m.employee_id
ORDER BY age_at_hire, employee_full_name;

-- (OpenAI, 2023) - Used to control check answer up against business question