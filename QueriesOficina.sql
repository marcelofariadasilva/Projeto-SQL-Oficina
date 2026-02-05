USE oficina;

-- 1. Listar todos os clientes cadastrados
SELECT idCliente, nome, tipo, telefone, email
FROM clientes;

-- 2. Listar veículos de cada cliente
SELECT c.nome AS Cliente, v.placa, v.marca, v.modelo, v.ano
FROM veiculos v
JOIN clientes c ON v.idCliente = c.idCliente;

-- 3. Consultar ordens de serviço em andamento
SELECT o.idOrdem, c.nome AS Cliente, v.modelo, o.data_abertura, o.status
FROM ordens_servico o
JOIN clientes c ON o.idCliente = c.idCliente
JOIN veiculos v ON o.idVeiculo = v.idVeiculo
WHERE o.status = 'Em andamento';

-- 4. Calcular o valor total de serviços em cada ordem
SELECT o.idOrdem, SUM(s.preco * oss.quantidade) AS TotalServicos
FROM ordens_servico o
JOIN ordem_servico_servicos oss ON o.idOrdem = oss.idOrdem
JOIN servicos s ON oss.idServico = s.idServico
GROUP BY o.idOrdem;

-- 5. Calcular o valor total de peças utilizadas em cada ordem
SELECT o.idOrdem, SUM(p.preco * osp.quantidade) AS TotalPecas
FROM ordens_servico o
JOIN ordem_servico_pecas osp ON o.idOrdem = osp.idOrdem
JOIN pecas p ON osp.idPeca = p.idPeca
GROUP BY o.idOrdem;

-- 6. Faturamento total por cliente (ordens + vendas)
SELECT c.nome AS Cliente, SUM(pg.valor) AS FaturamentoTotal
FROM clientes c
LEFT JOIN ordens_servico o ON c.idCliente = o.idCliente
LEFT JOIN pagamentos pg ON pg.idOrdem = o.idOrdem OR pg.idVenda IN (
    SELECT v.idVenda FROM vendas v WHERE v.idCliente = c.idCliente
)
GROUP BY c.nome;

-- 7. Mecânico com maior número de ordens atendidas
SELECT m.nome AS Mecanico, COUNT(osm.idOrdem) AS TotalOrdens
FROM mecanicos m
JOIN ordem_servico_mecanicos osm ON m.idMecanico = osm.idMecanico
GROUP BY m.nome
ORDER BY TotalOrdens DESC;

-- 8. Peças mais utilizadas em ordens de serviço
SELECT p.nome AS Peca, SUM(osp.quantidade) AS TotalUsada
FROM pecas p
JOIN ordem_servico_pecas osp ON p.idPeca = osp.idPeca
GROUP BY p.nome
ORDER BY TotalUsada DESC;

-- 9. Peças/acessórios mais vendidos diretamente
SELECT p.nome AS Produto, SUM(vp.quantidade) AS TotalVendido
FROM pecas p
JOIN venda_pecas vp ON p.idPeca = vp.idPeca
GROUP BY p.nome
ORDER BY TotalVendido DESC;

-- 10. Pagamentos pendentes
SELECT pg.idPagamento, c.nome AS Cliente, pg.valor, pg.forma_pagamento, pg.status
FROM pagamentos pg
LEFT JOIN ordens_servico o ON pg.idOrdem = o.idOrdem
LEFT JOIN clientes c ON o.idCliente = c.idCliente
WHERE pg.status = 'Pendente';

-- 11. Clientes que gastaram mais de 500 reais em ordens de serviço
SELECT c.nome AS Cliente, SUM(pg.valor) AS TotalGasto
FROM clientes c
JOIN ordens_servico o ON c.idCliente = o.idCliente
JOIN pagamentos pg ON pg.idOrdem = o.idOrdem
GROUP BY c.nome
HAVING SUM(pg.valor) > 500;

-- 12. Relatório completo de ordens (cliente, veículo, serviços, peças, mecânicos)
SELECT o.idOrdem, c.nome AS Cliente, v.modelo AS Veiculo,
       GROUP_CONCAT(DISTINCT s.descricao) AS Servicos,
       GROUP_CONCAT(DISTINCT p.nome) AS Pecas,
       GROUP_CONCAT(DISTINCT m.nome) AS Mecanicos
FROM ordens_servico o
JOIN clientes c ON o.idCliente = c.idCliente
JOIN veiculos v ON o.idVeiculo = v.idVeiculo
LEFT JOIN ordem_servico_servicos oss ON o.idOrdem = oss.idOrdem
LEFT JOIN servicos s ON oss.idServico = s.idServico
LEFT JOIN ordem_servico_pecas osp ON o.idOrdem = osp.idOrdem
LEFT JOIN pecas p ON osp.idPeca = p.idPeca
LEFT JOIN ordem_servico_mecanicos osm ON o.idOrdem = osm.idOrdem
LEFT JOIN mecanicos m ON osm.idMecanico = m.idMecanico
GROUP BY o.idOrdem;
