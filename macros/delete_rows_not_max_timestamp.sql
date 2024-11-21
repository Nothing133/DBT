-- macros/delete_rows_not_max_timestamp.sql

{% macro delete_rows_not_max_timestamp(source_name, table_name) %}

    DELETE FROM {{ source(source_name, table_name) }}
    WHERE sf_insert_timestamp != (
        SELECT MAX(sf_insert_timestamp)
        FROM {{ source(source_name, table_name) }}
    )

{% endmacro %}
