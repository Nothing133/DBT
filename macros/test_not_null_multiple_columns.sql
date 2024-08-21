{% macro test_not_null_multiple_columns(model, columns) %}
  {%- if execute -%}
    {%- set column_tests = [] -%}
    
    {%- for column in columns %}
      {%- set column_test = 
        "select count(*) as invalid_count from {{ model }} where {{ column }} is null" %}
      {%- do column_tests.append(column_test) -%}
    {%- endfor -%}
    
    {%- if column_tests | length > 0 -%}
      {{ column_tests | join(' union all ') }}
    {%- else -%}
      select 0
    {%- endif -%}
  {%- endif -%}
{% endmacro %}
