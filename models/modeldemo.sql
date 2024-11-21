{{
    config(
        post_hook="purge_full_load_staging(
            'staging', 
            'STG_ES_AESOP_REF_WASTE_TYPE'
        )"
    )
}}

-- Model logic
select *
from {{ source('staging', 'STG_ES_AESOP_REF_WASTE_TYPE') }}
