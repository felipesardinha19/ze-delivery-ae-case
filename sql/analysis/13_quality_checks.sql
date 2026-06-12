-- Produto sem categoria
select *, 'produto sem categoria' as descricao
from staging.stg_products
where category = 'sem_categoria'
   or category is null;

-- Pedidos sem cliente correspondente
select
    o.order_id,
    o.customer_id
from staging.stg_orders o
left join staging.stg_customers c
    on o.customer_id = c.customer_id
where c.customer_id is null;

-- Itens sem produto correspondente
select
    oi.order_item_id,
    oi.product_id
from staging.stg_order_items oi
left join staging.stg_products p
    on oi.product_id = p.product_id
where p.product_id is null;

-- Pedidos válidos sem pagamento válido
select
    order_id,
    status,
    gross_revenue,
    paid_amount,
    has_valid_payment
from intermediate.int_order_metrics
where status in ('delivered', 'paid')
  and has_valid_payment = 0;

  -----------------------------------------------------------
  --Verificar duplicidade
  -----------------------------------------------------------
-- customers duplicidades
select
    customer_id,
    count(*) as total
from staging.stg_customers
group by customer_id
having count(*) > 1;

-- orders duplicados
select
    order_id,
    count(*) as total
from staging.stg_orders
group by order_id
having count(*) > 1;

-- order_items duplicados
select
    order_item_id,
    count(*) as total
from staging.stg_order_items
group by order_item_id
having count(*) > 1;

-- products duplicados
select
    product_id,
    count(*) as total
from staging.stg_products
group by product_id
having count(*) > 1;

-- payments duplicados
select
    payment_id,
    count(*) as total
from staging.stg_payments
group by payment_id
having count(*) > 1;
