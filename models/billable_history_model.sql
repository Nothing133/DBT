-- models/billable_history_model.sql

{{ config(materialized='table') }}

select
    ID as changed_id,
    USER_ID as changed_user_id,
    IS_BILLABLE as changed_is_billable,
    EFFECTIVE_FROM as changed_effective_from,
    CREATED_AT as changed_created_at,
    UPDATED_AT as changed_updated_at,
    OLD_USERTYPE as changed_old_usertype
from {{ source('MYSQLSOURCE', 'BILLABLE_HISTORY') }}
