{{
    config(
        materialized='incremental',
        unique_key='fact_subscriber_history_id'
    )
}}

SELECT
    *
FROM {{ source('dssor-dev', 'fact_subscriber_history_audit') }}
    {% if is_incremental() %}
        where version_eff_ts > (select max(version_eff_ts) from {{ this }})
    {% endif %}