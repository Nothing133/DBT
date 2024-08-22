{% macro test_simple_not_null(model) %}
{%- if execute -%}

SELECT COUNT(*) AS c
FROM {{ model }}
WHERE 1 = 0

{%- endif -%}
{% endmacro %}
