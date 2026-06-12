-- 1. Qual foi a receita liquida por mes?
select *
from metrics.monthly_revenue;

-- 2. Quantos clientes fizeram a primeira compra valida em cada mes?
select *
from metrics.monthly_new_customers;

-- 3. Qual categoria teve maior receita bruta em pedidos validos?
select *
from metrics.category_gross_revenue
limit 1;

-- 4. Qual foi o ticket medio de pedidos validos?
select average_gross_ticket
from metrics.valid_orders_kpis;