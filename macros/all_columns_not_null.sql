{% macro all_columns_not_null(model, exclude_column_list) %}
    {%- if execute -%}
    {%- set model_columns = adapter.get_columns_in_relation(model) -%}

    -- Initialize an empty string to hold the generated SQL
    {%- set sql_string = "" -%}

    {%- for col in model_columns if col.column|upper not in exclude_column_list|map('upper') %}
        -- Add SQL for checking null values in the current column
        {%- set sql_string = "select count(*) as c from (select " + col.column + " from " + model + " where " + col.column + " is null) having c > 0" -%}
        
        -- Add UNION ALL unless it's the last column
        {%- if not loop.last %}
        {%- set sql_string = sql_string + " union all " -%}
        {%- endif %}
    {%- endfor -%}

    -- Return the complete SQL string
    {{ sql_string }}
    {%- endif -%}
{% endmacro %}