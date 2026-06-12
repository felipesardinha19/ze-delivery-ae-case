# Ze Delivery - Case Tecnico Analytics Engineer Junior

Solucao SQL-first desenvolvida em PostgreSQL para criar uma camada analitica simples e responder perguntas de negocio sobre receita, clientes, categorias e qualidade dos dados.

## Estrutura

```text
data/              CSVs originais
sql/raw/           criacao dos schemas e tabelas raw
sql/staging/       padronizacao de tipos, datas, textos e categorias
sql/intermediate/  agregacoes por pedido e tabela analitica principal
sql/metrics/       metricas finais de negocio
sql/analysis/      respostas finais e checks de qualidade
```

## Como executar

1. Criar um banco PostgreSQL.
2. Executar `sql/raw/01_create_raw_tables.sql`.
3. Importar os CSVs da pasta `data/` para as tabelas do schema `raw`.
4. Executar os scripts SQL na ordem numerica, de `02` ate `13`.
5. Consultar as views do schema `metrics` ou executar `sql/analysis/12_business_answers.sql`.

## Premissas

- A data de referencia da receita e `order_date`.
- Receita bruta = soma de `quantity * unit_price` dos itens.
- Receita liquida = receita bruta menos reembolsos associados ao pedido.
- Pedido valido = pedido nao cancelado, com status `delivered` ou `paid`, receita bruta positiva e pagamento valido.
- Pagamento valido = evento com `payment_status` igual a `captured` ou `authorized`.
- Itens, pagamentos e reembolsos foram agregados por `order_id` antes do calculo das metricas para evitar duplicidade em joins com granularidades diferentes.

## Tabela final de analise

A principal tabela analitica e `intermediate.int_order_metrics`.

Ela possui granularidade de uma linha por pedido e concentra cliente, data do pedido, mes, status, receita bruta, valor pago, reembolso, receita liquida e indicador de pedido valido.

## Respostas de negocio

### 1. Receita liquida por mes

| Mes | Receita liquida |
|---|---:|
| 2026-01-01 | 610.00 |
| 2026-02-01 | 1090.00 |
| 2026-03-01 | 1635.00 |
| 2026-04-01 | 1195.00 |

### 2. Clientes com primeira compra valida por mes

| Mes | Clientes |
|---|---:|
| 2026-01-01 | 2 |
| 2026-02-01 | 1 |
| 2026-03-01 | 3 |
| 2026-04-01 | 2 |

### 3. Categoria com maior receita bruta em pedidos validos

| Categoria | Receita bruta |
|---|---:|
| monitores | 1780.00 |

### 4. Ticket medio de pedidos validos

| Metrica | Valor |
|---|---:|
| Ticket medio bruto | 377.50 |

## Problemas de qualidade encontrados

- O produto `PRD006` estava sem categoria. Na camada staging, ele foi tratado como `sem_categoria` para manter a analise agrupavel.

## Validacoes realizadas

Foram executados checks para clientes, pedidos, itens, produtos e pagamentos duplicados, alem de verificacoes de pedidos sem cliente, itens sem produto e pedidos validos sem pagamento valido. Esses checks nao retornaram inconsistencias adicionais.

## O que faria com mais tempo

- Refaria a modelagem em dbt para deixar o projeto mais organizado e facil de reproduzir.
- Criaria um star schema simples, com uma tabela fato de pedidos e dimensoes de clientes, produtos e datas.
- Criaria uma documentação explicando a estrutura das tabelas e dados como um dicionario.

## Observacao

Optei por usar views para manter o projeto simples, evitar armazenamento desnecessario e facilitar a leitura da logica das transformacoes. E pelo volume de dados do case ser pequeno.
