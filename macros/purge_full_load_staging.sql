{% macro purge_full_load_staging(table_name) %}
    -- Metadata column to be excluded 
    {% set metadata_column = ['SF_INSERT_TIMESTAMP'] %}

    -- Get all columns from the table
    {% set all_columns = adapter.get_columns_in_relation(ref(table_name)) %}

    -- Empty list to store columns for deduplication
    {% set dedup_columns = [] %}

    -- Looping all columns and adding columns that is not in metadata_column
    {% for col in all_columns %}
        {% if col.name not in metadata_column %}
            {% do dedup_columns.append(col.name) %}
        {% endif %}
    {% endfor %}

    {% set dedup_columns = dedup_columns | join(', ') %}

    -- CTE to assign row numbers
    with numbered_records as (
        select *,
            row_number() over (partition by {{ dedup_columns }} order by SF_INSERT_TIMESTAMP desc) as row_num
        from demo.staging.{{ table_name}}
    )

    -- Delete rows where row number is greater than 1
    delete from demo.staging.{{ table_name}}
    where ({{ dedup_columns }},SF_INSERT_TIMESTAMP) in (
        select {{ dedup_columns }},SF_INSERT_TIMESTAMP
        from numbered_records
        where row_num > 1
    );
{% endmacro %}