create or replace view intermediate.int_items_by_order as
select
    order_id,
    count(*) as total_items,
    sum(quantity) as total_quantity,
    sum(quantity * unit_price) as gross_revenue
from staging.stg_order_items
group by order_id;