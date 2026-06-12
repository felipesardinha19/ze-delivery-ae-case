create or replace view metrics.valid_orders_kpis as
select
    count(distinct order_id) as valid_orders,
    sum(gross_revenue) as gross_revenue,
    sum(refund_amount) as refund_amount,
    sum(net_revenue) as net_revenue,
    sum(gross_revenue) / nullif(count(distinct order_id), 0) as average_gross_ticket,
    sum(net_revenue) / nullif(count(distinct order_id), 0) as average_net_ticket
from intermediate.int_order_metrics
where is_valid_order = true;