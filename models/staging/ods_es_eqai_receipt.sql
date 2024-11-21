{{ config(
    materialized='table',
    post_hook="{{ purge_full_load_staging('stg_es_eqai_receipt') }}"  
) }}

select * 
from {{ ref('stg_es_eqai_receipt') }} 
