-- Criação do banco de dados
DROP DATABASE IF EXISTS oficina;
CREATE DATABASE oficina;
USE oficina;

-- Tabela de clientes (sem CHECK problemático)
CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PF','PJ') NOT NULL,
    cpf CHAR(11) UNIQUE,
    cnpj CHAR(14) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela de veículos
CREATE TABLE veiculos (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    placa CHAR(7) UNIQUE NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    ano INT,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de mecânicos
CREATE TABLE mecanicos (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela de serviços (mão de obra)
CREATE TABLE servicos (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de peças e acessórios
CREATE TABLE pecas (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria ENUM('Peça','Acessório') NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Tabela de ordens de serviço
CREATE TABLE ordens_servico (
    idOrdem INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    idVeiculo INT NOT NULL,
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    status ENUM('Aberta','Em andamento','Concluída','Cancelada') DEFAULT 'Aberta',
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
    FOREIGN KEY (idVeiculo) REFERENCES veiculos(idVeiculo)
);

-- Relação entre ordens de serviço e serviços
CREATE TABLE ordem_servico_servicos (
    idOrdem INT NOT NULL,
    idServico INT NOT NULL,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idOrdem, idServico),
    FOREIGN KEY (idOrdem) REFERENCES ordens_servico(idOrdem),
    FOREIGN KEY (idServico) REFERENCES servicos(idServico)
);

-- Relação entre ordens de serviço e mecânicos
CREATE TABLE ordem_servico_mecanicos (
    idOrdem INT NOT NULL,
    idMecanico INT NOT NULL,
    PRIMARY KEY (idOrdem, idMecanico),
    FOREIGN KEY (idOrdem) REFERENCES ordens_servico(idOrdem),
    FOREIGN KEY (idMecanico) REFERENCES mecanicos(idMecanico)
);

-- Relação entre ordens de serviço e peças utilizadas
CREATE TABLE ordem_servico_pecas (
    idOrdem INT NOT NULL,
    idPeca INT NOT NULL,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idOrdem, idPeca),
    FOREIGN KEY (idOrdem) REFERENCES ordens_servico(idOrdem),
    FOREIGN KEY (idPeca) REFERENCES pecas(idPeca)
);

-- Tabela de vendas diretas
CREATE TABLE vendas (
    idVenda INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    data_venda DATE NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Relação entre vendas e peças/acessórios
CREATE TABLE venda_pecas (
    idVenda INT NOT NULL,
    idPeca INT NOT NULL,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idVenda, idPeca),
    FOREIGN KEY (idVenda) REFERENCES vendas(idVenda),
    FOREIGN KEY (idPeca) REFERENCES pecas(idPeca)
);

-- Tabela de pagamentos detalhada
CREATE TABLE pagamentos (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idOrdem INT,
    idVenda INT,
    forma_pagamento ENUM('Dinheiro','Cartão Débito','Cartão Crédito','Pix','Transferência','Cheque') NOT NULL,
    parcelas INT DEFAULT 1,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    status ENUM('Pendente','Confirmado','Cancelado') DEFAULT 'Confirmado',
    FOREIGN KEY (idOrdem) REFERENCES ordens_servico(idOrdem),
    FOREIGN KEY (idVenda) REFERENCES vendas(idVenda)
);
