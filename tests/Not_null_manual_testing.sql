SELECT DISTINCT unique_value
FROM {{ ref('TestUnique') }}
WHERE unique_value IS NULL
