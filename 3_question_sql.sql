SELECT DISTINCT 
  t1.category_name,
  t1.avg_yearly_category_price AS avg_price_2007,
  t2.avg_yearly_category_price AS avg_price_2015,
  ROUND(((t2.avg_yearly_category_price / t1.avg_yearly_category_price) - 1) * 100,2) AS percentage_change
FROM
  t_adela_michl_project_SQL_primary_final t1
JOIN
  t_adela_michl_project_SQL_primary_final t2
ON
  t1.category_name = t2.category_name
WHERE
  t1.year = 2007
  AND t2.year = 2015
  AND t2.avg_yearly_category_price > t1.avg_yearly_category_price
ORDER BY
  percentage_change asc;

