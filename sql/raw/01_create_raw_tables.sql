drop schema if exists raw cascade;
drop schema if exists staging cascade;
drop schema if exists intermediate cascade;
drop schema if exists metrics cascade;

create schema raw;
create schema staging;
create schema intermediate;
create schema metrics;


create table if not exists raw.customers (
    customer_id text,
    customer_name text,
    signup_date text,
    country text
);

create table if not exists raw.orders (
    order_id text,
    customer_id text,
    order_date text,
    status text,
    canceled_at text
);

create table if not exists raw.order_items (
    order_item_id text,
    order_id text,
    product_id text,
    quantity integer,
    unit_price real
);

create table if not exists raw.products (
    product_id text,
    product_name text,
    category text,
    list_price real
);

create table if not exists raw.payments (
    payment_id text,
    order_id text,
    payment_date text,
    payment_method text,
    payment_status text,
    amount real
);

create table if not exists raw.refunds (
    refund_id text,
    order_id text,
    refund_date text,
    amount real,
    reason text
);
