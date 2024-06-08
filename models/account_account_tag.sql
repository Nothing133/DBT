-- models/account_account_tag_model.sql

{{ config(materialized='table') }}

select
    ID as changed_id,
    NAME as changed_name,
    APPLICABILITY as changed_applicability,
    COLOR as changed_color,
    ACTIVE as changed_active,
    CREATE_UID as changed_create_uid,
    CREATE_DATE as changed_create_date,
    WRITE_UID as changed_write_uid,
    WRITE_DATE as changed_write_date
from {{ source('PSQLSOURCE', 'ACCOUNT_ACCOUNT_TAG') }}
