{{ config(materialized='view') }}

SELECT
    id AS crime_id,
    {{ dbt_utils.generate_surrogate_key(['Primary_Type', 'Description']) }} as CRIME_TYPE_ID,
    {{ dbt_utils.generate_surrogate_key(['date']) }} as DATE_ID,
    {{ dbt_utils.generate_surrogate_key(['COALESCE(location, \'Unknown\')','Community_Area','Ward']) }} as Location_id,
    date AS crime_date,
    EXTRACT(YEAR FROM DATE) AS CRIME_YEAR,
    EXTRACT(MONTH FROM DATE) AS CRIME_MONTH,
    EXTRACT(DAY FROM DATE) AS CRIME_DAY,
    TO_CHAR(DATE, 'Dy') AS CRIME_DAY_OF_WEEK,
    EXTRACT(HOUR from DATE) as CRIME_HOUR,
    COALESCE(latitude, 0) AS latitude,
    COALESCE(longitude, 0) AS longitude,
    COALESCE(location, 'Unknown') AS location,
    community_area,
    ward,
    primary_type,
    description,
    arrest,
    domestic
FROM
    {{ source('CRIME_DATA', 'SRC_CRIME') }}
