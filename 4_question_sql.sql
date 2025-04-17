SELECT 
	year,
	AVG(avg_yearly_category_price) AS AVG_price,
	LAG(AVG(avg_yearly_category_price)) OVER (ORDER BY year) AS AVG_price_previous_year,
	CONCAT(ROUND((ROUND(AVG(avg_yearly_category_price), 2) / ROUND(LAG(AVG(avg_yearly_category_price)) OVER (ORDER BY year), 2) -1) *100, 2), '%') AS annual_growth_PRICE,
	AVG(avg_yearly_gross_wage) AS AVG_wage,
	LAG(AVG(avg_yearly_gross_wage)) OVER (ORDER BY year) AS AVG_wage_previous_year,
	CONCAT(ROUND((ROUND(AVG(avg_yearly_gross_wage), 2) / ROUND(LAG(AVG(avg_yearly_gross_wage)) OVER (ORDER BY year), 2) -1) *100, 2), '%') AS annual_growth_WAGE,
	ROUND((ROUND(AVG(avg_yearly_category_price), 2) / ROUND(LAG(AVG(avg_yearly_category_price)) OVER (ORDER BY year), 2) -1) *100, 2)
	 - 
	ROUND((ROUND(AVG(avg_yearly_gross_wage), 2) / ROUND(LAG(AVG(avg_yearly_gross_wage)) OVER (ORDER BY year), 2) -1) *100, 2) 
	AS difference
FROM 
	t_adela_michl_project_SQL_primary_final
GROUP BY 
	year 
ORDER BY
	year;