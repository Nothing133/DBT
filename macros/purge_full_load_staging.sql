-- macros/purge_full_load_staging.sql
{% macro purge_full_load_staging(source_name, table_name, dedup_keys) %}
    {% set dedup_columns_sql = dedup_keys | join(', ') %}
    delete from {{ source(source_name, table_name) }}
    where ({{ dedup_columns_sql }}, SF_INSERT_TIMESTAMP) in 
    (
        select {{ dedup_columns_sql }}, SF_INSERT_TIMESTAMP
        from 
        (
            select *, 
                   row_number() over (partition by {{ dedup_columns_sql }} 
                                      order by SF_INSERT_TIMESTAMP desc) as row_num
            from {{ source(source_name, table_name) }}
        ) t
        where t.row_num > 1
    );
{% endmacro %}
