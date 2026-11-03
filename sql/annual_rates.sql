CREATE OR REPLACE VIEW crime.annual_rates AS
WITH annual AS (
  SELECT l.lga_code,
    c.offence_category,
    EXTRACT(YEAR FROM c.month) AS year,
    SUM(c.incidents) AS incidents
  FROM crime.crime_long as c
  JOIN crime.lga_lookup l ON c.lga_name = l.bocsar_name
  WHERE EXTRACT(YEAR FROM c.month) BETWEEN 2016 AND 2025
  GROUP BY l.lga_code, c.offence_category, year
)

SELECT a.lga_code, p.lga_name, a.offence_category, a.year, a.incidents, p.population,
  100000*a.incidents/p.population AS rate_per_100k
FROM annual a
JOIN crime.abs_population p
ON CAST(a.lga_code AS STRING) = CAST(p.lga_code AS STRING) AND a.year = p.year
WHERE p.population >= 5000;

SELECT *
FROM crime.annual_rates
ORDER BY lga_name, offence_category, year
LIMIT 100;