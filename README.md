# 🛠️ Projeto SQL - Oficina Mecânica

Este projeto implementa a **modelagem lógica e a implementação de um banco de dados** para uma oficina mecânica, com base em um modelo conceitual (ER).  
O objetivo é simular operações reais de uma oficina: cadastro de clientes e veículos, controle de serviços e peças, ordens de serviço, vendas diretas e pagamentos.

---

## 📂 Estrutura do Repositório
- **estrutura.sql** → criação das tabelas e relacionamentos.
- **insercoes.sql** → inserção de dados de clientes, veículos, mecânicos, serviços, peças e pagamentos.
- **queries.sql** → consultas SQL utilizando `SELECT`, `WHERE`, `ORDER BY`, `HAVING` e `JOIN`.

---

## ⚙️ Funcionalidades
- 👤 **Clientes**: cadastro de PF e PJ.  
- 🚗 **Veículos**: vinculados a clientes.  
- 👨‍🔧 **Mecânicos**: registro de profissionais e especialidades.  
- 🛠️ **Serviços**: catálogo de mão de obra (troca de óleo, revisão, diagnóstico).  
- 🔩 **Peças e acessórios**: controle de estoque e preços.  
- 📑 **Ordens de serviço**: associação de serviços, peças e mecânicos.  
- 🛒 **Vendas diretas**: peças e acessórios vendidos sem ordem de serviço.  
- 💳 **Pagamentos**: diferentes formas (dinheiro, cartão, Pix, transferência, cheque) e status (pendente, confirmado, cancelado).

---

## 🔎 Consultas Exemplos
- 📊 **Faturamento total por cliente** (ordens + vendas).  
- 👨‍🔧 **Mecânico com maior número de ordens atendidas**.  
- 🔩 **Peças mais utilizadas em ordens de serviço**.  
- 🛒 **Produtos mais vendidos diretamente**.  
- ⏳ **Pagamentos pendentes**.  
- 💰 **Clientes que gastaram mais de R$ 500,00 em ordens de serviço**.  
- 📑 **Relatório completo de ordens** (cliente, veículo, serviços, peças, mecânicos).

---

## 🚀 Como executar
1. Crie o banco de dados com `estrutura.sql`.  
2. Popule com dados de teste usando `insercoes.sql`.  
3. Execute as consultas em `queries.sql` para validar cenários reais.  

---

## 📌 Observações
Este projeto foi desenvolvido como parte de um desafio de **modelagem e implementação de banco de dados**.  
Ele demonstra boas práticas de organização, integridade referencial e uso de consultas SQL para análise de dados em um contexto realista de oficina mecânica.
