-- models/account_account_account_tag_model.sql

{{ config(materialized='table') }}

select
    ACCOUNT_ACCOUNT_TAG_ID as changed_account_account_tag_id,
    ACCOUNT_ACCOUNT_ID as changed_account_account_id
from {{ source('PSQLSOURCE', 'ACCOUNT_ACCOUNT_ACCOUNT_TAG') }}
