-- models/my_model.sql

{{ delete_rows_not_max_timestamp('staging', 'STG_ES_AESOP_REF_WASTE_TYPE') }}
