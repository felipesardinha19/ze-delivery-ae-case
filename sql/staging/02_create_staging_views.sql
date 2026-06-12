create or replace view staging.stg_customers as
select
    nullif(trim(customer_id), '') as customer_id,
    nullif(trim(customer_name), '') as customer_name,
    nullif(trim(signup_date), '')::date as signup_date,
    nullif(trim(country), '') as country
from raw.customers;


create or replace view staging.stg_orders as
select
    nullif(trim(order_id), '') as order_id,
    nullif(trim(customer_id), '') as customer_id,
    nullif(trim(order_date), '')::timestamp as order_date,
    lower(nullif(trim(status), '')) as status,
    nullif(trim(canceled_at), '')::timestamp as canceled_at
from raw.orders;

create or replace view staging.stg_order_items as
select
    nullif(trim(order_item_id::text), '') as order_item_id,
    nullif(trim(order_id::text), '') as order_id,
    nullif(trim(product_id::text), '') as product_id,
    nullif(trim(quantity::text), '')::numeric as quantity,
    nullif(trim(unit_price::text), '')::numeric as unit_price
from raw.order_items;


create or replace view staging.stg_products as
select
    nullif(trim(product_id::text), '') as product_id,
    nullif(trim(product_name::text), '') as product_name,
    coalesce(
        nullif(lower(trim(category::text)), ''),
        'sem_categoria'
    ) as category,
    nullif(trim(list_price::text), '')::numeric as list_price
from raw.products;


create or replace view staging.stg_payments as
select
    nullif(trim(payment_id::text), '') as payment_id,
    nullif(trim(order_id::text), '') as order_id,
    nullif(trim(payment_date::text), '')::timestamp as payment_date,
    nullif(trim(payment_method::text), '') as payment_method,
    lower(nullif(trim(payment_status::text), '')) as payment_status,
    nullif(trim(amount::text), '')::numeric as amount
from raw.payments;


create or replace view staging.stg_refunds as
select
    nullif(trim(refund_id::text), '') as refund_id,
    nullif(trim(order_id::text), '') as order_id,
    nullif(trim(refund_date::text), '')::timestamp as refund_date,
    nullif(trim(amount::text), '')::numeric as amount,
    nullif(trim(reason::text), '') as reason
from raw.refunds;