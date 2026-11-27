select
    cast(account_id as bigint) as account_id,
    trim(company_name) as account_name,
    coalesce(nullif(trim(industry), ''), 'Unknown') as industry,
    coalesce(nullif(trim(region), ''), 'Unknown') as region,
    cast(signup_date as date) as signup_date,
    cast(updated_at as timestamp) as updated_at

from {{ source('raw', 'accounts') }}
