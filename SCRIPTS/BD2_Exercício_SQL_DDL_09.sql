/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DDL e DML - trigger, function e Select -
Queries dificuldade alta
Implementar trigger, function, procedure e queries com a linguagem SQL aplicadas no SGBDR
Oracle 10g, apoiadas no SqlDeveloper.
Utilizando as tabelas do projeto pedido, realizar o que se pede:
*/

-- a. Implementar uma solução para não permitir que sejam incluídos mais
-- produtos em item_produto de pedidos do que a disponibilidade
-- existente no Estoque.
-- Fazer tratamento com mensagem de informação para o usuário indicando
-- o motivo para a não inclusão de produtos em itens dos pedidos.
-- RESOLUÇÃO:

CREATE TRIGGER TRG_IMPEDIR_INCLUSAO
BEFORE INSERT ON ITEM_PRODUTO BEGIN
    SELECT IP.CODIGO_PRO, E.CODIGO_PRO, E.QUANTIDADE AS QUANTIDADE_NO_ESTOQUE
    FROM ITEM_PRODUTO IP
    LEFT JOIN ESTOQUE E ON E.CODIGO_PRO = IP.CODIGO_PRO;
    

-- b. Fazer uma query para verificação da existência do produto no estoque, 
--passando como parâmetro o código do produto a ser verificado.
-- RESOLUÇÃO: