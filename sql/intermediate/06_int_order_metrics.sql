create or replace view intermediate.int_order_metrics as
select
    o.order_id,
    o.customer_id,
    o.order_date,
    date_trunc('month', o.order_date)::date as order_month,
    o.status,
    o.canceled_at,
    coalesce(i.total_items, 0) as total_ites,
    coalesce(i.total_quantity, 0) as total_quantity,
    coalesce(i.gross_revenue, 0) as gross_revenue,
    coalesce(p.payment_events, 0) as payment_events,
    coalesce(p.paid_amount, 0) as captured_amount,
    coalesce(p.has_valid_payment, 0) as has_valid_payment,
    coalesce(r.refund_events, 0) as refund_events,
    coalesce(r.refund_amount, 0) as refund_amount,
    coalesce(i.gross_revenue, 0) - coalesce(r.refund_amount, 0) as net_revenue,
    case
    	when o.canceled_at is null
     	and o.status in ('delivered', 'paid')
     	and coalesce(i.gross_revenue, 0) > 0
     	and coalesce(p.has_valid_payment, 0) = 1
        	then true
    else false
end as is_valid_order
from staging.stg_orders o
left join intermediate.int_items_by_order i
    on o.order_id = i.order_id
left join intermediate.payments_by_order p
    on o.order_id = p.order_id
left join intermediate.int_refunds_by_order r
    on o.order_id = r.order_id;