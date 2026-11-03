DECLARE month_cols STRING;

SET month_cols = (
  SELECT STRING_AGG(FORMAT('`%s`', column_name), ' ,' ORDER BY ordinal_position)
  FROM crime.INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = "crime_raw"
  AND column_name not in ('LGA', 'Offence category', 'Subcategory')
);

EXECUTE IMMEDIATE FORMAT(
  """
  CREATE OR REPLACE TABLE crime.crime_long AS
  SELECT LGA AS lga_name, 
    `Offence category` AS offence_category,
    Subcategory as subcategory,
    PARSE_DATE('%%Y-%%m-%%d', LEFT(period, 10)) AS month,
    SAFE_CAST(incidents as INT64) as incidents 
  FROM crime.crime_raw
  UNPIVOT (incidents FOR period IN (%s))
  """
  , month_cols
);