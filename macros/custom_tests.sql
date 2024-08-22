{% macro check_columns_not_null(model) %}
  {% set column_list = metadata.get('column_list', []) %}
  
  {% if column_list|length == 0 %}
    {% do log("No columns defined in schema.yml", info=True) %}
    SELECT 1 AS status WHERE FALSE
  {% else %}
    SELECT *
    FROM {{ ref(model) }}
    WHERE NOT (
      {% for column in column_list %}
        {{ column }} IS NOT NULL
        {% if not loop.last %}
          AND
        {% endif %}
      {% endfor %}
    )
  {% endif %}
{% endmacro %}
