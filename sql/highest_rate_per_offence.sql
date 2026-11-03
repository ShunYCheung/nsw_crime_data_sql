SELECT *
FROM (
  SELECT lga_name, 
    offence_category, 
    ROUND(rate_per_100k, 1) AS rate_per_100k, incidents, population,
    RANK() OVER (PARTITION BY offence_category ORDER BY rate_per_100k DESC) AS rnk
  FROM crime.annual_rates
  WHERE year = 2025
)
WHERE rnk <= 10
ORDER BY offence_category, rnk;