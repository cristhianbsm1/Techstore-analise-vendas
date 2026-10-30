use techstore; 

-- 1. Indicadores gerais
SELECT
    COUNT(*) AS quantidade_vendas,
    SUM(quantidade) AS unidades_vendidas,
    SUM(quantidade * valor_unitario) AS faturamento_total,
    AVG(quantidade * valor_unitario) AS ticket_medio
FROM vendas;

-- 2. Faturamento por categoria

select p.categoria, sum(v.quantidade * v.valor_unitario) as faturamento
from vendas v
join produtos p
on p.id_produto = v.id_produto
group by p.categoria
order by faturamento desc;

-- 3. Desempenho dos produtos

select p.nome, sum(v.quantidade * v.valor_unitario) as faturamento, sum(v.quantidade) as unidades_vendidas
from vendas v
join produtos p
on v.id_produto = p.id_produto
group by p.id_produto
order by faturamento desc;

-- 4. Desempenho dos vendedores

select f.nome, sum(v.quantidade * v.valor_unitario) as faturamento, count(v.quantidade) as quantidade_vendas
from vendas v
join vendedores f
on v.id_vendedor = f.id_vendedor
group by f.id_vendedor
order by faturamento desc;

-- 5. Desempenho dos clientes

select c.nome, count(v.quantidade) as quantidade_compras, sum(v.quantidade * v.valor_unitario) as faturamento
from vendas v
join clientes c
on v.id_cliente = c.id_cliente
group by v.id_cliente
order by faturamento desc;

-- 6. Faturamento por região

select f.regiao, sum(v.quantidade * v.valor_unitario) as faturamento
from vendas v
join vendedores f
on v.id_vendedor = f.id_vendedor
group by f.regiao
order by faturamento desc;





