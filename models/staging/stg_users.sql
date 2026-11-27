with cleaned as (

    select
        cast(user_id as bigint) as user_id,
        cast(account_id as bigint) as account_id,
        lower(trim(email)) as email,
        lower(trim(role)) as user_role,
        cast(created_at as date) as created_date,
        cast(last_login as date) as last_login_date,
        cast(updated_at as timestamp) as updated_at

    from {{ source('raw', 'users') }}

),

ranked as (

    select
        *,
        row_number() over (
            partition by email
            order by user_id
        ) as email_rank

    from cleaned

)

select * exclude (email_rank)
from ranked
where email_rank = 1
