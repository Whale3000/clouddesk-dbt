-- This test checks if the cleaned MRR is valid.
-- The original data has an unusually high MRR of 99999.
-- We use 4999 as the maximum valid MRR for this project.
-- If this test fails, the revenue reports may show
-- more money than the company actually earns.

select
    subscription_id,
    mrr_raw,
    monthly_recurring_revenue,
    is_mrr_outlier

from {{ ref('stg_subscriptions') }}

where monthly_recurring_revenue < 0
   or monthly_recurring_revenue > 4999
   or (
       is_mrr_outlier = true
       and monthly_recurring_revenue is not null
   )
