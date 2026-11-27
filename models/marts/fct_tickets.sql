{{ config(materialized='table') }}

select
    ticket_id,
    account_id,
    opened_date as date_key,
    opened_at,
    closed_at,
    priority,
    ticket_category,
    ticket_status,
    resolution_hours,
    is_closed,
    1 as ticket_count

from {{ ref('int_tickets_enriched') }}
