{{ config(materialized='table') }}

select
    account_id,
    account_name,
    industry,
    region,
    signup_date,
    total_subscriptions,
    active_subscriptions,
    total_mrr,
    total_users,
    total_tickets,
    closed_tickets,
    avg_resolution_hours

from {{ ref('int_account_summary') }}
