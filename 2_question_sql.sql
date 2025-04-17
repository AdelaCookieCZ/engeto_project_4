SELECT
  year,
  category_name,
  ROUND(AVG(avg_yearly_category_price), 2) AS avg_category_price, 
  ROUND(AVG(avg_yearly_gross_wage), 2) AS avg_gross_wage,  
  ROUND(AVG(avg_yearly_gross_wage) / AVG(avg_yearly_category_price), 2) AS liters_or_kg_available 
FROM
  t_adela_michl_project_SQL_primary_final
WHERE
  year IN (2007, 2015)
  AND (category_name LIKE 'Mléko%' OR category_name LIKE 'Chléb%')
GROUP BY
  year, category_name
ORDER BY
  year, category_name;