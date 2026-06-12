--2. Quantos clientes fizeram a primeira compra válida em cada mês?

create or replace view metrics.monthly_new_customers as
select 
	first_valid_order_month,
	count(distinct customer_id) as neew_customers
from intermediate.int_customer_first_valid_order
group by first_valid_order_month
order by first_valid_order_month;
