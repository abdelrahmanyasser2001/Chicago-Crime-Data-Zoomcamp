

-- 1.Crime Count by year
SELECT
  count(x.crime_id) AS COUNT,
  z.crime_year
FROM
  data_zoomcamp.dev.fact_crime x
  INNER JOIN data_zoomcamp.dev.date_time_dim z ON x.date_id = z.date_id
GROUP BY
  z.crime_year;


-- 2.Crime distrubution by day_of_week
SELECT
  count(x.crime_id) AS COUNT,
  z.CRIME_DAY_OF_WEEK
FROM
  data_zoomcamp.dev.fact_crime x
  INNER JOIN data_zoomcamp.dev.date_time_dim z ON x.date_id = z.date_id
GROUP BY
  z.CRIME_DAY_OF_WEEK
ORDER BY
  CASE
    WHEN Crime_day_of_week = 'Sun' THEN 1
    WHEN Crime_day_of_week = 'Mon' THEN 2
    WHEN Crime_day_of_week = 'Tue' THEN 3
    WHEN Crime_day_of_week = 'Wed' THEN 4
    WHEN Crime_day_of_week = 'Thu' THEN 5
    WHEN Crime_day_of_week = 'Fri' THEN 6
    WHEN Crime_day_of_week = 'Sat' THEN 7
  END;


-- 3.Crime Occurrence by Hour
SELECT
  count(x.crime_id) AS COUNT,
  y.crime_hour
FROM
  data_zoomcamp.dev.fact_crime x
  INNER JOIN data_zoomcamp.dev.date_time_dim y ON x.date_id = y.date_id
GROUP BY
  y.crime_hour
ORDER BY
  y.crime_hour asc;

  
-- 4.Top 10 Crime Types
SELECT
  y.Primary_type,
  COUNT(*) AS Crime_Count
FROM
  data_zoomcamp.dev.fact_crime x
  JOIN data_zoomcamp.dev.crime_type_dim y ON x.Crime_type_id = y.Crime_type_id
GROUP BY
  y.Primary_type
ORDER BY
  Crime_Count DESC
LIMIT
  10;


-- 5. Crime Type vs. Arrest Rate
SELECT
  y.Primary_type,
  SUM(
    CASE
      WHEN x.Arrest = TRUE THEN 1
      ELSE 0
    END
  ) AS Arrested_Count,
  SUM(
    CASE
      WHEN x.Arrest = FALSE THEN 1
      ELSE 0
    END
  ) AS Not_Arrested_Count
FROM
  data_zoomcamp.dev.fact_crime x
  JOIN data_zoomcamp.dev.Crime_Type_Dim y ON x.Crime_type_id = y.Crime_type_id
GROUP BY
  y.Primary_type
ORDER BY
  Arrested_Count DESC
LIMIT
  10;

  
-- 6.Domestic vs. Non-Domestic Incidents
SELECT
  CASE
    WHEN x.Domestic = TRUE THEN 'Domestic'
    ELSE 'Non-Domestic'
  END AS Crime_Type,
  COUNT(*) AS Crime_Count
FROM
  data_zoomcamp.dev.fact_crime x
GROUP BY
  Crime_Type;

  
-- 7.Arrest vs. Non-Arrest Ratio by Crime Type
SELECT
  CT.Primary_type,
  SUM(
    CASE
      WHEN FC.Arrest = TRUE THEN 1
      ELSE 0
    END
  ) AS Arrested_Count,
  SUM(
    CASE
      WHEN FC.Arrest = FALSE THEN 1
      ELSE 0
    END
  ) AS Not_Arrested_Count
FROM
  data_zoomcamp.dev.fact_crime FC
  JOIN data_zoomcamp.dev.Crime_Type_Dim CT ON FC.Crime_type_id = CT.Crime_type_id
GROUP BY
  CT.Primary_type
ORDER BY
  Arrested_Count DESC
LIMIT
  10;
