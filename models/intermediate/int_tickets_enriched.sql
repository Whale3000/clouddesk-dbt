with tickets as (

    select *
    from {{ ref('stg_tickets') }}

),

accounts as (

    select *
    from {{ ref('stg_accounts') }}

)

select
    t.ticket_id,
    t.account_id,
    a.account_name,
    a.industry,
    a.region,
    t.opened_at,
    t.closed_at,
    cast(t.opened_at as date) as opened_date,
    t.priority,
    t.ticket_category,
    t.ticket_status,

    case
        when t.closed_at is not null
        then round(
            datediff('second', t.opened_at, t.closed_at)
            / 3600.0, 2
        )
        else null
    end as resolution_hours,

    case
        when t.closed_at is not null then true
        else false
    end as is_closed,

    t.updated_at

from tickets as t

left join accounts as a
    on t.account_id = a.account_id
