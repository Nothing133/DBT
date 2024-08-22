-- tests/test_not_null_custom.sql

{% set model = ref('ODS_ES_BYOD_PROJ_HOUR_COST_PRICE') %}
{% set columns = [
    'DEFINITIONGROUP',
    'EXECUTIONID',
    'ISSELECTED',
    'TRANSFERSTATUS',
    'CATEGORYID',
    'COSTPRICE',
    'EFFECTIVELABORRATE',
    'ISRESOURCERATE',
    'PROJECTID',
    'CUSTOMERACCOUNT',
    'PRICEGROUPID',
    'PROJECTCONTRACTID',
    'RESOURCECATEGORY',
    'TRANSDATE',
    'RESOURCEID',
    'RESOURCECATEGORYID',
    'RESOURCECOMPANYID',
    'PARTITION',
    'DATAAREAID',
    'SYNCSTARTDATETIME',
    'RECID',
    'SF_INSERT_TIMESTAMP'
] %}

{% for column_name in columns %}
    {% set result = run_query(test_not_null_custom(model, [column_name])) %}
    {% if result.rowcount > 0 %}
        select '{{ column_name }}' as column_name, 'FAIL' as result
    {% else %}
        select '{{ column_name }}' as column_name, 'PASS' as result
    {% endif %}
{% endfor %}
