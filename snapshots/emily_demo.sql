{% snapshot emily_demo_snapshot %}

{{
    config(
      target_database='nyt-dssor-dev',
      target_schema='dbt_poc',
      unique_key='fact_subscriber_history_id',

      strategy='timestamp',
      updated_at='current_timestamp',
    )
}}

select * from {{ ref('emily_demo') }}

    {% endsnapshot %}