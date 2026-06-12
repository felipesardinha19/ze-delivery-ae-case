--Receita liquida por mês
--1. Qual foi a receita líquida por mês?

create or replace view metrics.monthly_revenue as
select 
	order_month,
	sum(gross_revenue) as gross_revenue,
	sum(refund_events) as refund_events,
	sum(refund_amount) as refund_amount,
	sum(net_revenue) as net_revenue,
	count(distinct order_id) as valid_order
from intermediate.int_order_metrics
where is_valid_order = true
group by order_month
order by order_month
