{% test all_columns_not_null(model, exclude_column_list) %}
{%- if execute -%}
{%- set model_columns = adapter.get_columns_in_relation(model) -%}

{%- set column_conditions = [] -%}
{%- for col in model_columns if col.column|upper not in exclude_column_list|upper %}
    {%- set _ = column_conditions.append("select count(*) as c from {{ model }} where {{ col.column }} is null") -%}
{%- endfor -%}

select count(*) as c from (
    {%- for condition in column_conditions %}
        {{ condition }}
        {%- if not loop.last %}
        union all
        {%- endif %}
    {%- endfor -%}
)
having c > 0
{%- endif -%}
{% endtest %}
