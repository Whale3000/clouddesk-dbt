with accounts as (

    select *
    from {{ ref('stg_accounts') }}

),

subscriptions as (

    select
        account_id,
        count(*) as total_subscriptions,
        sum(
            case
                when subscription_status = 'active'
                then 1 else 0
            end
        ) as active_subscriptions,
        sum(
            case
                when subscription_status = 'active'
                then monthly_recurring_revenue
            end
        ) as total_mrr
    from {{ ref('stg_subscriptions') }}
    group by account_id

),

users as (

    select
        account_id,
        count(*) as total_users
    from {{ ref('stg_users') }}
    group by account_id

),

tickets as (

    select
        account_id,
        count(*) as total_tickets,
        sum(
            case
                when is_closed then 1
                else 0
            end
        ) as closed_tickets,
        avg(resolution_hours) as avg_resolution_hours
    from {{ ref('int_tickets_enriched') }}
    group by account_id

)

select
    a.account_id,
    a.account_name,
    a.industry,
    a.region,
    a.signup_date,
    coalesce(s.total_subscriptions, 0) as total_subscriptions,
    coalesce(s.active_subscriptions, 0) as active_subscriptions,
    coalesce(s.total_mrr, 0) as total_mrr,
    coalesce(u.total_users, 0) as total_users,
    coalesce(t.total_tickets, 0) as total_tickets,
    coalesce(t.closed_tickets, 0) as closed_tickets,
    round(t.avg_resolution_hours, 2) as avg_resolution_hours

from accounts as a

left join subscriptions as s
    on a.account_id = s.account_id

left join users as u
    on a.account_id = u.account_id

left join tickets as t
    on a.account_id = t.account_id
