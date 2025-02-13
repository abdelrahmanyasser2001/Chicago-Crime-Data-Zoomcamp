{{ config(materialized='table') }}

WITH LOCATION_DATA AS(
    SELECT
        location,
        Latitude,
        Longitude,
        Community_Area,
        Ward
    FROM
        {{ ref('stg_chicago_crime') }}
)


SELECT
    DISTINCT {{ dbt_utils.generate_surrogate_key(['location','Community_Area','Ward']) }} as Location_id,
    *
FROM
    LOCATION_DATA  
WHERE
    Location IS NOT NULL
    AND Latitude IS NOT NULL
    AND Longitude IS NOT NULL

