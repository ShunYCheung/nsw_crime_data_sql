# Sanity check all three tables.
SELECT 'crime_long' AS tbl, 
  COUNT(*) AS n_rows, COUNT(DISTINCT lga_name) AS n_lga, 
  CAST(MIN(month) AS STRING) AS min_period, 
  CAST(MAX(month) AS STRING) AS max_period
FROM crime.crime_long
UNION ALL
SELECT 'abs_population', 
  COUNT(*), 
  COUNT(DISTINCT lga_code),
  CAST(MIN(year) AS STRING), 
  CAST(MAX(year) AS STRING)
FROM crime.abs_population
UNION ALL 
SELECT 'socio_ec', 
  COUNT(*), 
  COUNT(DISTINCT lga_code),
  NULL,
  NULL
FROM crime.socio_ec_2021;

# Check for duplicates to avoid double counting
SELECT lga_name, offence_category, subcategory, month , COUNT(*) as n
FROM crime.crime_long
GROUP BY lga_name, offence_category, subcategory, month HAVING n>1;