{% test all_columns_not_null(model, exclude_column_list) %}
    -- Call the macro to generate the SQL for checking NULL values
    {{ all_columns_not_null(model, exclude_column_list) }}
{% endtest %}
