-- models/account_account.sql

{{ config(materialized='table') }}

select
    deprecated as changed_is_deprecated,
    id as changed_id,
    write_date as changed_write_date,
    name as changed_name,
    internal_group as changed_internal_group,
    internal_type as changed_internal_type,
    code as changed_code,
    note as changed_note,
    write_uid as changed_write_uid,
    create_date as changed_create_date,
    create_uid as changed_create_uid,
    group_id as changed_group_id,
    company_id as changed_company_id,
    reconcile as changed_reconcile,
    last_time_entries_checked as changed_last_time_entries_checked,
    user_type_id as changed_user_type_id,
    currency_id as changed_currency_id
from {{ source('PSQLSOURCE', 'ACCOUNT_ACCOUNT') }}

