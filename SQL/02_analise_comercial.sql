use techstore;

-- 01. Top 5 produtos por faturamento

select p.nome, sum(v.quantidade * v.valor_unitario) as faturamento, sum(v.quantidade) as qnt_vendidas
from vendas v
join produtos p
on p.id_produto = v.id_produto
group by p.nome, p.id_produto
order by faturamento desc
limit 5;

-- 02. Participação de cada cliente no faturamento

select c.nome, sum(v.quantidade * v.valor_unitario) as faturamento, round(sum(v.quantidade * v.valor_unitario) / (select sum(quantidade * valor_unitario) as faturamento_total from vendas) * 100, 2) as percentual_faturamento
from vendas v
join clientes c
on v.id_cliente = c.id_cliente
group by c.nome, c.id_cliente
order by percentual_faturamento desc;

-- 03 Participação dos 5 maiores clientes

select round(sum(fat_cliente) / (select sum(quantidade * valor_unitario) from vendas) * 100, 2) as participacao_top5_clientes
from (select c.nome as nome, sum(v.quantidade * v.valor_unitario) as fat_cliente
from vendas v
join clientes c
on v.id_cliente = c.id_cliente
group by c.nome, c.id_cliente
order by fat_cliente desc
limit 5) as fat;

-- 04 Produtos com faturamento acima da média

select p.nome, sum(v.quantidade * v.valor_unitario) as faturamento_produto
from vendas v
join produtos p
on v.id_produto = p.id_produto
group by p.nome, p.id_produto
having faturamento_produto > (select avg(faturamento_p) from (select p.nome, sum(v.quantidade * v.valor_unitario) as faturamento_p from vendas v join produtos p on v.id_produto = p.id_produto group by p.nome, p.id_produto) as media_p)
order by faturamento_produto desc;

-- 05  Ranking de vendedores

select f.nome, sum(v.quantidade * v.valor_unitario) as faturamento_vendedor, rank() over(order by sum(v.quantidade * v.valor_unitario) desc) as ranking_faturamento
from vendas v
join vendedores f
on v.id_vendedor = f.id_vendedor
group by f.nome, f.id_vendedor
order by faturamento_vendedor desc;



