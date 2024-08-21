-- macros/not_null_test.sql

{% macro test_not_null_multiple_columns(model_name, columns) %}
  {% set column_conditions = columns | map('~ {} IS NULL'.format) | join(' OR ') %}
  SELECT
    COUNT(*) AS null_count
  FROM {{ ref(model_name) }}
  WHERE {{ column_conditions }}
{% endmacro %}
