create or replace view intermediate.payments_by_order as
select
    order_id,
    count(*) as payment_events,
    sum(
        case 
            when payment_status = 'captured'
                then amount
            else 0 
        end
    ) as captured_amount,
    sum(
        case
            when payment_status = 'failed'
                then amount
            else 0 	
        end
    ) as non_captured_amount,
    max(
        case
            when payment_status in ('captured', 'authorized')
                then 1
            else 0
        end
    ) as has_valid_payment
from staging.stg_payments
group by order_id;