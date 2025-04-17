WITH wage_growth AS (
  SELECT
    industry_name,
    year,
    AVG(avg_yearly_gross_wage) AS avg_yearly_gross_wage
  FROM t_adela_michl_project_SQL_primary_final
  GROUP BY industry_name, year
)
SELECT
  wg.industry_name,
  wg.year,
  wg.avg_yearly_gross_wage,
  LAG(wg.avg_yearly_gross_wage) OVER (PARTITION BY wg.industry_name ORDER BY wg.year) AS previous_year,
  wg.avg_yearly_gross_wage - LAG(wg.avg_yearly_gross_wage) OVER (PARTITION BY wg.industry_name ORDER BY wg.year) AS difference,
  CASE 
    WHEN wg.avg_yearly_gross_wage - LAG(wg.avg_yearly_gross_wage) OVER (PARTITION BY wg.industry_name ORDER BY wg.year) < 0 THEN 'DECREASE'
    WHEN wg.avg_yearly_gross_wage - LAG(wg.avg_yearly_gross_wage) OVER (PARTITION BY wg.industry_name ORDER BY wg.year) > 0 THEN  'ok'
    ELSE NULL
  END AS wage_change
FROM wage_growth wg
WHERE industry_name IS NOT NULL
ORDER BY wg.industry_name, wg.year;