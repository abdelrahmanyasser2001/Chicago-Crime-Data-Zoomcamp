{{ config(materialized='table') }}

WITH DATE_TIME_DATA AS(
    SELECT
        distinct crime_date,
        CRIME_YEAR,
        CRIME_MONTH,
        CRIME_DAY,
        CRIME_DAY_OF_WEEK,
        CRIME_HOUR
    FROM
        {{ ref('stg_chicago_crime') }})


SELECT
    {{ dbt_utils.generate_surrogate_key(['crime_date']) }} as DATE_ID,
    *
FROM
    DATE_TIME_DATA  
WHERE
    crime_date IS NOT NULL
