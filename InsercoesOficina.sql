USE oficina;

-- Inserindo clientes (PF e PJ)
INSERT INTO clientes (nome, tipo, cpf, telefone, email) VALUES
('João Silva', 'PF', '12345678901', '21999999999', 'joao@email.com'),
('Maria Oliveira', 'PF', '98765432100', '21988888888', 'maria@email.com');

INSERT INTO clientes (nome, tipo, cnpj, telefone, email) VALUES
('Auto Peças Rio Ltda', 'PJ', '12345678000199', '2133333333', 'contato@autorio.com'),
('Oficina Mecânica São Jorge', 'PJ', '98765432000188', '2134444444', 'contato@sjoficina.com');

-- Inserindo veículos
INSERT INTO veiculos (idCliente, placa, marca, modelo, ano) VALUES
(1, 'ABC1234', 'Fiat', 'Uno', 2010),
(2, 'XYZ9876', 'Toyota', 'Corolla', 2018),
(1, 'JKL4567', 'Honda', 'Civic', 2020);

-- Inserindo mecânicos
INSERT INTO mecanicos (nome, especialidade, telefone) VALUES
('Carlos Mendes', 'Motor e transmissão', '21977777777'),
('Fernanda Souza', 'Suspensão e freios', '21966666666'),
('Pedro Santos', 'Elétrica e eletrônica', '21955555555');

-- Inserindo serviços (mão de obra)
INSERT INTO servicos (descricao, preco) VALUES
('Troca de óleo', 120.00),
('Alinhamento e balanceamento', 150.00),
('Revisão completa', 500.00),
('Troca de pastilhas de freio', 200.00),
('Diagnóstico eletrônico', 180.00);

-- Inserindo peças e acessórios
INSERT INTO pecas (nome, categoria, preco, estoque) VALUES
('Pastilha de freio', 'Peça', 150.00, 50),
('Filtro de óleo', 'Peça', 40.00, 100),
('Bateria 60Ah', 'Peça', 400.00, 20),
('Tapete automotivo', 'Acessório', 80.00, 30),
('Lâmpada LED farol', 'Acessório', 120.00, 40);

-- Inserindo ordens de serviço
INSERT INTO ordens_servico (idCliente, idVeiculo, data_abertura, status) VALUES
(1, 1, '2026-02-01', 'Em andamento'),
(2, 2, '2026-02-02', 'Concluída'),
(1, 3, '2026-02-03', 'Aberta');

-- Relacionando serviços às ordens
INSERT INTO ordem_servico_servicos (idOrdem, idServico, quantidade) VALUES
(1, 1, 1), -- Troca de óleo
(1, 2, 1), -- Alinhamento
(2, 3, 1), -- Revisão completa
(2, 4, 1), -- Troca de pastilhas
(3, 5, 1); -- Diagnóstico eletrônico

-- Relacionando mecânicos às ordens
INSERT INTO ordem_servico_mecanicos (idOrdem, idMecanico) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3);

-- Relacionando peças utilizadas nas ordens
INSERT INTO ordem_servico_pecas (idOrdem, idPeca, quantidade) VALUES
(1, 2, 1), -- Filtro de óleo
(2, 1, 1), -- Pastilha de freio
(2, 3, 1); -- Bateria

-- Inserindo vendas diretas de peças/acessórios
INSERT INTO vendas (idCliente, data_venda) VALUES
(2, '2026-02-04'),
(3, '2026-02-05');

INSERT INTO venda_pecas (idVenda, idPeca, quantidade) VALUES
(1, 4, 2), -- Tapete automotivo
(1, 5, 2), -- Lâmpada LED
(2, 3, 1); -- Bateria

-- Inserindo pagamentos (ordens e vendas)
INSERT INTO pagamentos (idOrdem, forma_pagamento, parcelas, valor, data_pagamento, status) VALUES
(2, 'Cartão Crédito', 2, 700.00, '2026-02-02', 'Confirmado'),
(1, 'Pix', 1, 270.00, '2026-02-01', 'Pendente');

INSERT INTO pagamentos (idVenda, forma_pagamento, parcelas, valor, data_pagamento, status) VALUES
(1, 'Dinheiro', 1, 400.00, '2026-02-04', 'Confirmado'),
(2, 'Transferência', 1, 400.00, '2026-02-05', 'Confirmado');
