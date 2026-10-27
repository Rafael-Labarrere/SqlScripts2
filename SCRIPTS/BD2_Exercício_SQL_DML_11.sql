/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Select - Queries médias - Join e
View - 1
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Selecionar dados em tabelas do projeto PEDIDO, em conformidade com os enunciados a
seguir:
*/

-- a. Selecionar as constraints criadas da tabela ITEM_PRODUTO. Mostrar:
-- constraint_name (CONSTRAINT), constraint_type (TIPO) e
-- search_condition (CONDICAO). Ordenado pelo nome da constraint.
-- RESOLUÇÃO:

SELECT CONSTRAINT_NAME AS CONTRAINT,
       CONSTRAINT_TYPE AS TIPO,
       SEARCH_CONDITION AS CONDICAO
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'ITEM_PRODUTO'
ORDER BY CONSTRAINT_NAME;

-- b. Criar a view de clientes constante do BD Pedidos (VIEW_CLIENTE)
-- contendo os dados das tabelas CLIENTE, PF e PJ. Em conformidade com a
-- estrutura disponível no MER físico do projeto BD de Pedido.
-- RESOLUÇÃO:

DROP VIEW VIEW_CLIENTE;

CREATE VIEW VIEW_CLIENTE AS
SELECT C.CODIGO, C.NOME, C.RUA, C.NR, C.BAIRRO, C.COMPLEMENTO, C.CIDADE, C.UF, C.CEP, PF.CNPF, PF.RG, PF.DATA_NASCIMENTO, PJ.CNPJ, PJ.IE, PJ.NOME_FANTASIA
FROM CLIENTE C
LEFT JOIN PF ON C.CODIGO = PF.CODIGO_CLI
LEFT JOIN PJ ON C.CODIGO = PJ.CODIGO_CLI;