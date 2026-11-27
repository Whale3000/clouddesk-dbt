select
    cast(subscription_id as bigint) as subscription_id,
    cast(account_id as bigint) as account_id,
    lower(trim(plan)) as plan,
    cast(seats as integer) as seats,
    cast(mrr as decimal(12,2)) as mrr_raw,

    case
        when mrr between 0 and 4999
        then cast(mrr as decimal(12,2))
    end as monthly_recurring_revenue,

    case
        when mrr not between 0 and 4999 then true
        else false
    end as is_mrr_outlier,

    lower(trim(status)) as subscription_status,
    cast(started_at as date) as started_date,
    cast(updated_at as timestamp) as updated_at

from {{ source('raw', 'subscriptions') }}
