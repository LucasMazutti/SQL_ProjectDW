📊 SQL Data Warehouse from Scratch
📌 Descrição do Projeto

Este projeto consiste na construção de um Data Warehouse do zero utilizando SQL, com foco em modelagem dimensional, processo de ETL e consultas analíticas voltadas para Business Intelligence.

O objetivo é simular um cenário real de Data Engineering, organizando dados transacionais em um modelo analítico otimizado para consultas e geração de insights.

🎯 Objetivos

Construir um Data Warehouse estruturado

Aplicar modelagem dimensional (Star Schema)

Desenvolver um processo de ETL utilizando SQL

Criar consultas analíticas para suporte à decisão

Servir como projeto de portfólio para área de Dados

🏗️ Arquitetura do Projeto
Fonte de Dados (OLTP)
        ↓
    Staging Area
        ↓
Transformações (SQL)
        ↓
 Data Warehouse
        ↓
 Consultas Analíticas / BI

🗂️ Modelagem de Dados
📌 Tabelas Dimensão

dim_customer

dim_product

dim_date

dim_store

📌 Tabela Fato

fact_sales

🔹 O modelo adotado foi o Star Schema, visando melhor desempenho em consultas analíticas.

🔄 Processo ETL
Extract

Extração de dados de tabelas transacionais

Transform

Limpeza e padronização dos dados

Conversão de tipos

Criação de chaves substitutas

Tratamento de valores nulos

Load

Carga dos dados nas tabelas dimensão

Posterior carga da tabela fato

🧠 Consultas Analíticas

Alguns exemplos de análises realizadas:

Total de vendas por período

Faturamento por produto e categoria

Performance de vendas por loja

Análise temporal (dia, mês, ano)

🛠️ Tecnologias Utilizadas

SQL

Banco de Dados Relacional (ex: PostgreSQL / MySQL / SQL Server)

Modelagem Dimensional

ETL com SQL

📁 Estrutura do Repositório
sql-data-warehouse/
│
├── scripts/
│   ├── 01_create_tables.sql
│   ├── 02_insert_dimensions.sql
│   ├── 03_insert_fact.sql
│   └── 04_analytical_queries.sql
│
├── docs/
│   └── data_model.png
│
└── README.md

🚀 Como Executar o Projeto

Clone o repositório:

git clone https://github.com/seu-usuario/sql-data-warehouse.git


Execute os scripts na ordem:

01_create_tables.sql  
02_insert_dimensions.sql  
03_insert_fact.sql  
04_analytical_queries.sql  

📈 Possíveis Evoluções

Integração com Power BI ou Tableau

Automatização do ETL

Implementação de Slowly Changing Dimensions (SCD)

Uso de ferramentas de orquestração

Migração para ambiente cloud

👤 Autor
Lucas Mazutti
Estudante de Ciência da Computação | Dados & BI

🔗 LinkedIn: (https://www.linkedin.com/in/lucas-m-grabarski-3472521b8/)
