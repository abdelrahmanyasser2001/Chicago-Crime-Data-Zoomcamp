{{ config(materialized='table') }}

WITH CRIME_TYPE_DATA AS(
    SELECT
        Primary_Type,
        Description
    FROM
        {{ ref('stg_chicago_crime') }}
)


SELECT
    DISTINCT {{ dbt_utils.generate_surrogate_key(['Primary_Type', 'Description']) }} as CRIME_TYPE_ID,
    Primary_Type,
    Description
FROM
    CRIME_TYPE_DATA  
WHERE
    Primary_Type IS NOT NULL
    AND Description IS NOT NULL
