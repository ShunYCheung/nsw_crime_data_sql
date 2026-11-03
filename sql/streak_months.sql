WITH monthly AS (
  SELECT l.lga_code, 
  c.lga_name, 
  c.offence_category, 
  c.month,
  SUM(c.incidents) AS incidents
  FROM crime.crime_long as c
  JOIN crime.lga_lookup l ON c.lga_name = l.bocsar_name
  WHERE c.month >= '2016-01-01'
  GROUP BY l.lga_code, c.lga_name, c.offence_category, c.month
),
flagged AS (
  SELECT *,
  incidents > LAG(incidents) OVER w AS rising
  FROM monthly
  WINDOW w AS (PARTITION BY lga_code, offence_category ORDER BY month)
),
grouped AS (
  SELECT *, 
  COUNT(CASE WHEN rising IS NOT TRUE THEN 1 END) OVER (PARTITION BY lga_code, offence_category ORDER BY month)
  AS grp
  FROM flagged
)
SELECT lga_name, 
  offence_category,
  COUNT(CASE WHEN rising IS TRUE THEN 1 END) AS streak_months,
  MIN(month) AS streak_start, MAX(month) AS streak_end
FROM grouped
GROUP BY lga_name, offence_category, grp
HAVING streak_months >= 5
ORDER BY streak_months DESC
LIMIT 20;