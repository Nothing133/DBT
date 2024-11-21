{% macro purge_full_load_staging(table_name, dedup_keys) %}
    -- Join dedup_keys for use in SQL
    {% set dedup_columns_sql = dedup_keys | join(', ') %}

    -- Perform deduplication
    delete from {{ source('demo_staging', table_name) }}  -- Use the new source name
    where ({{ dedup_columns_sql }}, SF_INSERT_TIMESTAMP) in 
    (
        select {{ dedup_columns_sql }}, SF_INSERT_TIMESTAMP
        from 
        (
            select *, 
                   row_number() over (partition by {{ dedup_columns_sql }} 
                                      order by SF_INSERT_TIMESTAMP desc) as row_num
            from {{ source('demo_staging', table_name) }}  -- Updated source name
        ) t
        where t.row_num > 1
    );
{% endmacro %}
