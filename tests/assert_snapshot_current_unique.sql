-- This test checks that each subscription has
-- no more than one current record.
-- A subscription can have many old records,
-- but it should not have two current records.
-- If this test fails, revenue may be counted twice
-- and the current subscription plan may be incorrect.

select
    subscription_id,
    count(*) as current_record_count

from {{ ref('subscriptions_snapshot') }}

where dbt_valid_to is null

group by subscription_id

having count(*) > 1
