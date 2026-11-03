WITH state AS (   # CTE of state-wide incidents and pop
  SELECT offence_category, 
    year,
    SUM(incidents) AS incidents,
    SUM(population) AS population,
  FROM crime.annual_rates
  GROUP BY offence_category, year
),
rates AS (        # CTE of rates to get statewide rate/100k
  SELECT offence_category, 
    year, 
    100000 * SAFE_DIVIDE(incidents, population) AS rate_per_100k
    FROM state
)
SELECT offence_category, 
  year,
  ROUND(rate_per_100k, 1) AS rate_per_100k,
  ROUND(100 * (SAFE_DIVIDE(rate_per_100k, FIRST_VALUE(rate_per_100k) OVER (PARTITION BY offence_category ORDER BY year)))) AS pct_change_since_2016
FROM rates
ORDER BY offence_category, year;