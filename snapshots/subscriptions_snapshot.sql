{% snapshot subscriptions_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='subscription_id',
        strategy='check',
        check_cols=[
            'plan',
            'seats',
            'mrr_raw',
            'subscription_status'
        ]
    )
}}

select *
from {{ ref('stg_subscriptions') }}

{% endsnapshot %}
