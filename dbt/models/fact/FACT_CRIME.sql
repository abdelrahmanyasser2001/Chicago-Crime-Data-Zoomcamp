{{ config(materialized='incremental') }}

WITH crime_facts AS (
    SELECT
        c.crime_id,
        t.date_id,
        l.location_id,
        ct.crime_type_id,
        c.arrest,
        c.domestic
    FROM
        {{ ref('stg_chicago_crime') }} c
    LEFT JOIN
        {{ ref('DATE_TIME_DIM') }} t ON c.DATE_ID = t.DATE_ID
    LEFT JOIN
        {{ ref('LOCATION_DIM') }} l ON c.Location_id = l.Location_id
    LEFT JOIN
        {{ ref('CRIME_TYPE_DIM') }} ct ON c.CRIME_TYPE_ID = ct.CRIME_TYPE_ID
)

SELECT
    distinct crime_id,
    date_id,
    location_id,
    crime_type_id,
    arrest,
    domestic
FROM
    crime_facts
