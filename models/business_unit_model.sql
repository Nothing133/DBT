-- models/business_unit_model.sql

{{ config(materialized='table') }}

select
    ID as changed_id,
    BU_NAME as changed_bu_name,
    HEAD_ID as changed_head_id,
    EMP_NO_HEAD as changed_emp_no_head,
    DELETE_FLAG as changed_delete_flag,
    ODOO_ID as changed_odoo_id,
    IS_NEW as changed_is_new,
    CREATED_AT as changed_created_at,
    UPDATED_AT as changed_updated_at
from {{ source('MYSQLSOURCE', 'BUSINESS_UNIT') }}
