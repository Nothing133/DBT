{% macro delete_duplicates() %}
    delete from STAGING.STG_ES_AESOP_REF_WASTE_TYPE
    where (WASTE_TYPE, SF_INSERT_TIMESTAMP) in 
    (
    select WASTE_TYPE, SF_INSERT_TIMESTAMP
    from (
        select *,
        row_number() over (partition by WASTE_TYPE order by SF_INSERT_TIMESTAMP desc) as row_num
        from STAGING.STG_ES_AESOP_REF_WASTE_TYPE
    ) t
    where t.row_num > 1
    );
{% endmacro %}
