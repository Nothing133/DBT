{% macro all_columns_not_null(model, exclude_column_list=[]) %}
    {%- if execute -%}
    {%- set model_columns = adapter.get_columns_in_relation(model) -%}

    -- Initialize an empty string to hold the generated SQL
    {%- set sql_string = "" -%}

    {%- for col in model_columns if col.column|upper not in exclude_column_list|map('upper') %}
        -- For each column not excluded, add SQL to check for NULL values
        {%- set sql_string = "SELECT COUNT(*) AS c FROM (SELECT " + col.column + " FROM " + model + " WHERE " + col.column + " IS NULL) HAVING c > 0" -%}
        
        -- Add UNION ALL between different columns' queries unless it's the last column
        {%- if not loop.last %}
        {%- set sql_string = sql_string + " UNION ALL " -%}
        {%- endif %}
    {%- endfor -%}

    -- Return the complete SQL string for the test
    {{ sql_string }}
    {%- endif -%}
{% endmacro %}
