create or replace view intermediate.int_refunds_by_order as
select
    order_id,
    count(*) as refund_events,
    sum(amount) as refund_amount
from staging.stg_refunds
group by order_id;