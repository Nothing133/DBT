{% test test_columns_not_null(model, column_list) %}
{%- if execute -%}
{%- set model_columns = adapter.get_columns_in_relation(model) -%}

{%- for col in model_columns if col.column|upper in column_list|upper %}
    select count(*) as c from (
        select {{ col.column }}
        from {{ model }}
        where {{ col.column }} is null
    )
    having c > 0
    {%- if not loop.last %}
    union all
    {%- endif %}
{%- endfor -%}
{%- endif -%}
{% endtest %}