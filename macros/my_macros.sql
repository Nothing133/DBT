{% macro check_null_columns(columns) %}
  {% for column in columns %}
    {{ column }} IS NOT NULL
    {% if not loop.last %}
      AND
    {% endif %}
  {% endfor %}
{% endmacro %}
