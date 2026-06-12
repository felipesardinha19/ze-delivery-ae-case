--3. Qual categoria teve maior receita bruta em pedidos válidos?

create or replace view metrics.category_gross_revenue as
select 
	p.category,
	sum(oi.quantity * oi.unit_price) gross_revenue,
	count(distinct oi.order_id) valid_orders,
	sum(oi.quantity) total_quantity
from staging.stg_order_items oi
inner join intermediate.int_order_metrics om
	on om.order_id = oi.order_id
left join staging.stg_products p
	on p.product_id = oi.product_id
where om.is_valid_order = true
group by p.category
order by gross_revenue desc;
