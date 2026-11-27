{{ config(materialized='table') }}

with dates as (

    select distinct
        opened_date as date_key

    from {{ ref('int_tickets_enriched') }}

    where opened_date is not null

)

select
    date_key,
    year(date_key) as year,
    quarter(date_key) as quarter,
    month(date_key) as month,
    monthname(date_key) as month_name,
    day(date_key) as day_of_month,
    dayname(date_key) as day_name,
    week(date_key) as week_of_year,

    case
        when dayofweek(date_key) in (0, 6)
        then true
        else false
    end as is_weekend

from dates
