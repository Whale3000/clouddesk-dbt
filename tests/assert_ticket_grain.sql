-- This test checks if the number of tickets stays
-- the same after moving from staging to the fact table.
-- Each support ticket should appear only once.
-- If this test fails, the support reports may count
-- too many or too few tickets.

with source_count as (

    select count(*) as row_count
    from {{ ref('stg_tickets') }}

),

fact_count as (

    select count(*) as row_count
    from {{ ref('fct_tickets') }}

)

select
    s.row_count as staging_count,
    f.row_count as fact_count

from source_count as s
cross join fact_count as f

where s.row_count != f.row_count
