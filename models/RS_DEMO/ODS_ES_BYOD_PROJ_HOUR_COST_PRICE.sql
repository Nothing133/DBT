{{
    config(
        materialized='table'
    )
}}


SELECT * 
FROM {{ source('STG', 'STG_ES_BYOD_PROJ_HOUR_COST_PRICE') }}



