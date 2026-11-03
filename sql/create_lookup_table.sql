# Link crime and population using lga name
CREATE OR REPLACE TABLE crime.lga_lookup AS
SELECT DISTINCT c.lga_name AS bocsar_name, p.lga_code, p.lga_name AS abs_name
FROM `crime.crime_long` c
JOIN crime.abs_population p
ON c.lga_name = p.lga_name;

# Check linking and if some matches failed.
SELECT c.lga_name
FROM (SELECT DISTINCT lga_name FROM crime.crime_long) c
LEFT JOIN  crime.lga_lookup l on c.lga_name = l.bocsar_name
WHERE l.lga_code IS NULL
ORDER BY c.lga_name;