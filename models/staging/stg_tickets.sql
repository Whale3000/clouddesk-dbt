select
    cast(ticket_id as bigint) as ticket_id,
    cast(account_id as bigint) as account_id,
    cast(opened_at as timestamp) as opened_at,
    cast(closed_at as timestamp) as closed_at,
    lower(trim(priority)) as priority,
    lower(trim(category)) as ticket_category,
    lower(trim(status)) as ticket_status,
    cast(updated_at as timestamp) as updated_at

from {{ source('raw', 'tickets') }}
