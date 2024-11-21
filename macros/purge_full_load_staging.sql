{% macro purge_full_load_staging(source_name, table_name) %}
    -- Metadata column to be excluded 
    {% set metadata_column = ['SF_INSERT_TIMESTAMP'] %}

    -- Get all columns from the table
    {% set all_columns = adapter.get_columns_in_relation(source(source_name, table_name)) %}

    -- Empty list to store columns for deduplication
    {% set dedup_columns = [] %}

    -- Looping all columns and adding columns that are not in metadata_column
    {% for col in all_columns %}
        {% if col.name not in metadata_column %}
            {% do dedup_columns.append(col.name) %}
        {% endif %}
    {% endfor %}

    {% set dedup_columns = dedup_columns | join(', ') %}

    delete from {{ source(source_name, table_name) }}
    where ({{ dedup_columns }}, SF_INSERT_TIMESTAMP) in 
    (
        select {{ dedup_columns }}, SF_INSERT_TIMESTAMP
        from 
        (
            select *,
            row_number() over (partition by {{ dedup_columns }} order by SF_INSERT_TIMESTAMP desc) as row_num
            from {{ source(source_name, table_name) }}
        ) t
        where t.row_num > 1
    )
{% endmacro %}
