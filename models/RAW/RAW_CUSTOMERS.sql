{{
    config(
        materialized='table'
    )
}}

select * from DBT_SOURCE.PUBLIC.CUSTOMERS
