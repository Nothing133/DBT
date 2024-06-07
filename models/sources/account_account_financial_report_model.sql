-- models/account_account_financial_report_model.sql

{{ config(materialized='table') }}

select
    REPORT_LINE_ID as changed_report_line_id,
    ACCOUNT_ID as changed_account_id
from {{ source('PSQLSOURCE', 'ACCOUNT_ACCOUNT_FINANCIAL_REPORT') }}
