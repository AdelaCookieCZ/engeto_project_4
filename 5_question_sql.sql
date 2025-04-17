WITH aggregated_gdp AS (
  SELECT
    year,
    ROUND(AVG(gdp)::NUMERIC, 2) AS avg_gdp
  FROM t_adela_michl_project_sql_secondary_final
  WHERE country = 'Czech Republic'
  GROUP BY year
),
aggregated_main AS (
  SELECT
    year,
    ROUND(AVG(avg_yearly_gross_wage)::NUMERIC, 2) AS avg_wage,
    ROUND(AVG(avg_yearly_category_price)::NUMERIC, 2) AS avg_price
  FROM t_adela_michl_project_SQL_primary_final
  GROUP BY year
),
combined AS (
  SELECT
    g.year,
    ROUND(((g.avg_gdp - LAG(g.avg_gdp) OVER (ORDER BY g.year)) / NULLIF(LAG(g.avg_gdp) OVER (ORDER BY g.year), 0)) * 100, 2) AS gdp_growth,
    ROUND(((m.avg_wage - LAG(m.avg_wage) OVER (ORDER BY g.year)) / NULLIF(LAG(m.avg_wage) OVER (ORDER BY g.year), 0)) * 100, 2) AS wage_growth,
    ROUND(((m.avg_price - LAG(m.avg_price) OVER (ORDER BY g.year)) / NULLIF(LAG(m.avg_price) OVER (ORDER BY g.year), 0)) * 100, 2) AS price_growth
  FROM aggregated_gdp g
  JOIN aggregated_main m ON g.year = m.year
)
SELECT *
FROM combined
ORDER BY year;
