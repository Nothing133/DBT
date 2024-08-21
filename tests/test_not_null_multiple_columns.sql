-- tests/test_not_null_multiple_columns.sql

{% set columns_to_check = columns %}

WITH null_check AS (
    {{ test_not_null_multiple_columns(model_name, columns_to_check) }}
)

SELECT null_count
FROM null_check
