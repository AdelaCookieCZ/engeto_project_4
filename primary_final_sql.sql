CREATE TABLE t_adela_michl_project_SQL_primary_final AS
WITH quarterly_data AS (
  SELECT 
    pyr.payroll_year AS year,
    pyr.industry_name,
    pyr.avg_gross_wage,
    prc.category_name,
    prc.category_price,
    prc.price_unit
  FROM (
    SELECT
      cpib.name AS industry_name,
      ROUND(AVG(cp.value)::NUMERIC, 2) AS avg_gross_wage,
      cp.payroll_year,
      cp.payroll_quarter
    FROM
      czechia_payroll cp
    LEFT JOIN czechia_payroll_industry_branch cpib 
      ON cp.industry_branch_code = cpib.code
    WHERE
      cp.value_type_code = 5958
      AND cp.payroll_year BETWEEN 2007 AND 2015
    GROUP BY cpib.name, cp.payroll_year, cp.payroll_quarter
  ) pyr
  JOIN (
    SELECT
      cpc.name AS category_name,
      ROUND(AVG(cpr.value)::NUMERIC, 2) AS category_price,
      cpc.price_unit,
      EXTRACT(YEAR FROM cpr.date_from) AS price_year,
      EXTRACT(QUARTER FROM cpr.date_from) AS price_quarter
    FROM
      czechia_price cpr
    LEFT JOIN czechia_region cr 
      ON cpr.region_code = cr.code
    LEFT JOIN czechia_price_category cpc 
      ON cpr.category_code = cpc.code
    WHERE
      cr.code IS NULL
      AND EXTRACT(YEAR FROM cpr.date_from) BETWEEN 2007 AND 2015
    GROUP BY price_year, price_quarter, category_name, cpc.price_unit
  ) prc
  ON pyr.payroll_year = prc.price_year AND pyr.payroll_quarter = prc.price_quarter
)
SELECT
  year,
  industry_name,
  category_name,
  price_unit,
  ROUND(AVG(avg_gross_wage)::NUMERIC, 2) AS avg_yearly_gross_wage,
  ROUND(AVG(category_price)::NUMERIC, 2) AS avg_yearly_category_price
FROM
  quarterly_data
GROUP BY
  year,
  industry_name,
  category_name,
  price_unit
ORDER BY
  industry_name, category_name, year;