create or replace view intermediate.int_customer_first_valid_order as
select
	customer_id,
	min(order_date) first_valid_order_date,
	date_trunc('month', min(order_date))::date first_valid_order_month
from intermediate.int_order_metrics
where is_valid_order = true
group by customer_id