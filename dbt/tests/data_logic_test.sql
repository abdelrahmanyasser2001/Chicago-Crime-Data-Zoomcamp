WITH invalid_data AS (
    SELECT *
    FROM {{ ref('stg_chicago_crime') }}
    WHERE
        latitude NOT BETWEEN 41.6 AND 42.1
        OR longitude NOT BETWEEN -87.9 AND -87.5
)

SELECT *
FROM invalid_data