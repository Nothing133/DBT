{% macro test_columns_not_null(model, column_list) %}
    {%- if execute -%}
    {%- set sql_string = "" -%}
    
    {%- for col in column_list %}
        -- Add SQL to check for NULL values in each specified column
        {%- set sql_string = sql_string + "SELECT COUNT(*) AS c, '" + col + "' AS column_name FROM " + model + " WHERE " + col + " IS NULL" -%}
        
        -- Add UNION ALL between different columns' queries unless it's the last column
        {%- if not loop.last %}
        {%- set sql_string = sql_string + " UNION ALL " -%}
        {%- endif %}
    {%- endfor -%}

    -- Add a HAVING clause to check if any column has NULL values
    {{ sql_string + " HAVING SUM(c) > 0" }}
    {%- endif -%}
{% endmacro %}
