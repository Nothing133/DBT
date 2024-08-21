{% macro test_not_null_multiple_columns(model, columns) %}
  {% for column in columns %}
    {{ dbt_utils.not_null(model, column) }}
  {% endfor %}
{% endmacro %}
