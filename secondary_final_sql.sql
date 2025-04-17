CREATE TABLE t_adela_michl_project_sql_secondary_final AS
SELECT
	e.year, 
	e.country, 
	e.GDP,
	e.gini,
	e.population,
	c.continent
FROM
	economies e
JOIN 
	countries c
ON
	e.country = c.country 
WHERE
	year BETWEEN 2007 AND 2015
AND 
	continent = 'Europe'
ORDER BY 
	year
;




