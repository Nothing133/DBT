{% macro test_not_null_custom(model, column_names) %}
    {% for column_name in column_names %}
        select 
            '{{ column_name }}' as column_name, 
            count(*) as null_count
        from {{ model }}
        where {{ column_name }} is null
        having count(*) > 0
    {% endfor %}
{% endmacro %}
