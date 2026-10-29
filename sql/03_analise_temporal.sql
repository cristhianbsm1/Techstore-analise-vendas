-- 01. Faturamento mensal

select month(v.data_venda) as mes, year(v.data_venda) as ano, sum(v.quantidade * v.valor_unitario) as faturamento_mes
from vendas v
group by ano, mes
order by ano, mes ;

-- 02. Faturamento anual

select year(data_venda) as ano, sum(quantidade * valor_unitario) as faturamento
from vendas
group by ano
order by faturamento desc;

-- 03. Crescimento mensal do faturamento

select mes, ano, faturamento, faturamento_anterior, round(((faturamento - faturamento_anterior) / faturamento_anterior) * 100, 2) as variacao_percentual
from (select month(data_venda) as mes, year(data_venda) as ano, sum(quantidade * valor_unitario) as faturamento, lag(sum(quantidade * valor_unitario)) over(order by year(data_venda), month(data_venda)) as faturamento_anterior 
from vendas 
group by mes, ano) as fat
order by ano, mes;

-- 04. Quantidade de vendas e ticket médio por mês

select mes, ano, quantidade_vendas, ticket_medio, faturamento
from (select year(data_venda) as ano, month(data_venda) as mes, count(*) as quantidade_vendas, sum(quantidade * valor_unitario) as faturamento, round(avg(quantidade * valor_unitario), 2) as ticket_medio from vendas group by ano, mes) as fat
order by ano, mes


