/* BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Insert - Incluindo dados no Projeto
Pedido - Parte 1
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
1) Copiar os dados do projeto pedido cujo o owner seja o DEMO. Todas as tabelas do
usuário DEMO estão compartilhadas para leitura, exceto ITEM_PRODUTO.
*/


/* Vizualizando TABLES DEMO 
SELECT TABLE_NAME
FROM ALL_TABLES
WHERE OWNER = 'DEMO'
ORDER BY TABLE_NAME;

SELECT TABLE_NAME
FROM ALL_TABLES
WHERE OWNER = 'BD22309389'
ORDER BY TABLE_NAME

SELECT * FROM DEMO.CLIENTE;

SELECT * FROM BD22309389.CLIENTE
*/

-- APAGANDO RESGISTROS

/*
DELETE FROM PEDIDO;
DELETE FROM CLIENTE;
DELETE FROM VENDEDOR;

COMMIT;
*/

INSERT INTO CLIENTE SELECT * FROM DEMO.CLIENTE;
INSERT INTO VENDEDOR SELECT * FROM DEMO.VENDEDOR;
INSERT INTO PRODUTO SELECT * FROM DEMO.PRODUTO;
INSERT INTO PRATELEIRA SELECT * FROM DEMO.PRATELEIRA;

INSERT INTO PF SELECT * FROM DEMO.PF;
INSERT INTO PJ SELECT * FROM DEMO.PJ;
INSERT INTO FONE_CLIENTE SELECT * FROM DEMO.FONE_CLIENTE;
INSERT INTO FONE_VENDEDOR SELECT * FROM DEMO.FONE_VENDEDOR;

INSERT INTO PEDIDO SELECT * FROM DEMO.PEDIDO;
INSERT INTO ESTOQUE SELECT * FROM DEMO.ESTOQUE;
INSERT INTO CAPACIDADE_ESTOQUE SELECT * FROM DEMO.CAPACIDADE_ESTOQUE;

COMMIT;

-- Visualizando mudanças

/*
SELECT * FROM CLIENTE;
SELECT * FROM VENDEDOR;
SELECT * FROM PRODUTO;
SELECT * FROM  PRATELEIRA;

SELECT * FROM PF;
SELECT * FROM PJ;
SELECT * FROM FONE_CLIENTE;
SELECT * FROM FONE_VENDEDOR;

SELECT * FROM PEDIDO;
SELECT * FROM ESTOQUE;
SELECT * FROM CAPACIDADE_ESTOQUE;
*/

/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Insert - Incluindo dados na tabela
ITEM_PRODUTO do Projeto Pedido - Inserção parte 2
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Inserir dados na tabela ITEM_PRODUTO em conformidade com os enunciados a seguir:
*/

SELECT * FROM ITEM_PRODUTO;
DESC ITEM_PRODUTO;

SELECT * FROM PEDIDO;
SELECT * FROM PRODUTO;

-- 1. Produto 207 para todos os pedidos pares e ano menor 2018, com a quantidade 100 e
-- preço unitário R$ 10.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    207,
    NUMERO,
    100,
    10
    FROM PEDIDO WHERE MOD(NUMERO, 2) = 0 AND EXTRACT (YEAR FROM DATA) < 2018;


-- SELECT * FROM ITEM_PRODUTO;

-- 2. Produto 206 para todos os pedidos ímpares e ano igual 2018, com a quantidade 50 e
-- preço unitário R$ 12.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    206,
    NUMERO,
    50,
    12
    FROM PEDIDO WHERE MOD(NUMERO, 2) = 1 AND EXTRACT (YEAR FROM DATA) = 2018;

-- SELECT * FROM ITEM_PRODUTO;

-- 3. Produto 207 para todos os pedidos pares e ano igual 2018, com a quantidade 150 e
-- preço unitário R$ 14.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    207,
    NUMERO,
    150,
    14
    FROM PEDIDO WHERE MOD(NUMERO, 2) = 0 AND EXTRACT (YEAR FROM DATA) = 2018;

-- SELECT * FROM ITEM_PRODUTO;

-- 4. Produto 206 para todos os pedidos ímpares e ano menor 2018, com a quantidade 200 e
-- preço unitário R$ 8.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    206,
    NUMERO,
    200,
    8
    FROM PEDIDO WHERE MOD(NUMERO, 2) = 1 AND EXTRACT (YEAR FROM DATA) < 2018;

-- SELECT * FROM ITEM_PRODUTO;

-- 5. Produto 208 para todos sem endereço de entrega e ano igual 2017, com a quantidade 80 e
-- preço unitário R$ 18.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    208,
    NUMERO,
    80,
    18
    FROM PEDIDO WHERE RUA IS NULL AND EXTRACT (YEAR FROM DATA) = 2017;

-- SELECT * FROM ITEM_PRODUTO;

-- 6. Produto 208 para todos sem endereço de entrega e ano igual 2018, com a quantidade 70 e
-- preço unitário R$ 20.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    208,
    NUMERO,
    70,
    20
    FROM PEDIDO WHERE RUA IS NULL AND EXTRACT (YEAR FROM DATA) = 2018;

-- SELECT * FROM ITEM_PRODUTO;

-- 7. Produto 202 para todos pedidos com endereço de entrega e dia ímpar de entrega, com a
-- quantidade 60 e preço unitário R$ 15.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    202,
    NUMERO,
    60,
    15
    FROM PEDIDO WHERE RUA IS NOT NULL AND MOD(EXTRACT (DAY FROM DATA), 2) = 1;


-- SELECT * FROM ITEM_PRODUTO;

-- 8. Produto 205 para todos pedidos com endereço de entrega e dia par da data do pedido, com a
-- quantidade 90 e preço unitário R$ 11.50
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    205,
    NUMERO,
    90,
    11.5
    FROM PEDIDO WHERE RUA IS NOT NULL AND MOD(EXTRACT (DAY FROM DATA), 2) = 0;

-- SELECT * FROM ITEM_PRODUTO;

-- 9. Produto 203 para todos pedidos com endereço de entrega e dia ímpar da data de pedido, com a
-- quantidade 550 e preço unitário R$ 21.35
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    203,
    NUMERO,
    550,
    21.35
    FROM PEDIDO WHERE RUA IS NOT NULL AND MOD(EXTRACT (DAY FROM DATA), 2) = 1;

-- SELECT * FROM ITEM_PRODUTO;

-- 10. Produto 204 para todos pedidos sem endereço de entrega e dia par da data do pedido, com a
-- quantidade 150 e preço unitário R$ 25.85
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO (
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) SELECT 
    204,
    NUMERO,
    150,
    25.85
    FROM PEDIDO WHERE RUA IS NULL AND MOD(EXTRACT (DAY FROM DATA), 2) = 0;

-- SELECT * FROM ITEM_PRODUTO;

/*
BD2 - 2o Bim -Atividade de SQL - Exerc�cios de DML - Update - Alterando dados na tabela
ITEM_PRODUTO do Projeto Pedido
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER F�sico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Alterar dados na tabela ITEM_PRODUTO em conformidade com os enunciados a seguir:
*/

DESC ITEM_PRODUTO
SELECT * FROM ITEM_PRODUTO;
DESC PRODUTO

-- a. Para os itens dos pedidos de NUMERO menor que 20 e maior que 50, com
-- e produtos com c�digo de 203 a 205, inclusive: Multiplicar a
-- QUANTIDADE por 2
-- RESOLU��O:

UPDATE ITEM_PRODUTO
SET QUANTIDADE = QUANTIDADE*2
WHERE (NUMERO_PED < 20 OR NUMERO_PED > 50) AND (CODIGO_PRO BETWEEN 203 AND 205);

-- b. Para o cliente de CODIGO �mpar com vendedor de MATRICULA par: somar
-- 15 na QUANTIDADE.
-- RESOLU��O:

--??????????????????

-- c. Para pedidos com NUMERO m�ltiplo de 3: Retirar R$ 0.50 no valor de
-- cada pre�o unit�rio.
-- RESOLU��O:

UPDATE ITEM_PRODUTO 
SET PRECO_UNITARIO = PRECO_UNITARIO - 0.5
WHERE MOD(NUMERO_PED,3) = 0; 

-- d. Ajustar o valor total de cada item de produto no pedido (VALOR_ITEM),
-- em conformidade com a quantidade e pre�o unit�rio.
-- RESOLU��O:

UPDATE ITEM_PRODUTO 
SET VALOR_ITEM = PRECO_UNITARIO*QUANTIDADE;

-- e. Ajustar o total da fatura de todos os pedidos, em conformidade com os
-- valores dos itens inclu�dos em cada pedido.
-- RESOLU��O:

UPDATE PEDIDO P
SET P.TOTAL_FATURA = (
    SELECT NVL(SUM(I.VALOR_ITEM), 0)
    FROM ITEM_PRODUTO I
    WHERE I.NUMERO_PED = P.NUMERO
);

/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Delete - Excluindo dados em
tabelas do Projeto Pedido
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Deletar (excluir) dados em tabelas do projeto pedido, em conformidade com os enunciados a
seguir:
*/

DESC PEDIDO;
DESC ITEM_PRODUTO;

-- a. Excluir os registros de PEDIDO em que o número seja ímpar, a
-- matrícula do vendedor 102 e o endereço de entrega não seja nulo.
-- Observação: Realizar a exclusão e verificar que os registros foram
-- excluídos apenas na transação.
-- RESOLUÇÃO:

-- DELETANDO DA TEBELA ITEM_PRODUTO OS ITENS QUE IMPEDE DELETAR VENDEDOR COM MATRICULA 102
DELETE FROM ITEM_PRODUTO
WHERE NUMERO_PED IN ( SELECT NUMERO FROM PEDIDO
WHERE MOD(NUMERO,2)=1 AND MATRICULA_VEN=102 AND RUA IS NOT NULL
);

-- EXCLUSÃO
DELETE FROM PEDIDO
WHERE MOD(NUMERO,2)=1 AND MATRICULA_VEN=102 AND RUA IS NOT NULL;


SELECT * FROM PEDIDO
WHERE MOD(NUMERO,2)=1 AND MATRICULA_VEN=102 AND RUA IS NOT NULL;

SELECT * FROM ITEM_PRODUTO
WHERE NUMERO_PED IN ( SELECT NUMERO
FROM PEDIDO
WHERE MOD(NUMERO,2)=1
AND MATRICULA_VEN=102
AND RUA IS NOT NULL
);

-- b. Excluir os itens de produtos do menor número de pedido na última data

-- de inclusão de pedido (a data mais recente).
-- Observação: Realizar a exclusão e verificar que os registros foram
-- excluídos apenas na transação.
-- RESOLUÇÃO:

DELETE FROM ITEM_PRODUTO
WHERE NUMERO_PED IN (

-- menor número de pedido entre os pedidos da data mais recente.
SELECT MIN(NUMERO)
	FROM PEDIDO
 WHERE DATA = (
			 SELECT MAX(DATA)
				 FROM PEDIDO
			 )
	);


-- Confere se foram excluídos.
SELECT *
	FROM ITEM_PRODUTO
 WHERE NUMERO_PED IN (
			 SELECT MIN(NUMERO)
				 FROM PEDIDO
				WHERE DATA = (
							SELECT MAX(DATA)
								FROM PEDIDO
							)
			 );

-- c. Desfazer as exclusões dos itens a. e b. da questão 4) acima.
-- Observação: Verificar que os registros estão nas respectivas tabelas.
-- RESOLUÇÃO: 

ROLLBACK;

/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Select - Queries médias - Join - 1
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Selecionar dados em tabela simples do projeto PEDIDO, em conformidade com os enunciados
a seguir:
*/

-- a. Listar os vendedores . Mostrar: Vendedor (MATRICULA e NOME).
-- Ordenados pelo nome decrescente.
-- RESOLUÇÃO:

SELECT MATRICULA, NOME
FROM VENDEDOR
ORDER BY NOME DESC;

-- b. Listar distintamente os clientes PJ. Mostrar: Nome do cliente
-- (CLIENTE), CNPJ e CIDADE onde reside. Ordenados pelo nome do cliente
-- ascendente e, dentro deste, pela cidade descendente.
-- RESOLUÇÃO:

SELECT DISTINCT C.NOME AS CLIENTE, 
                PJ.CNPJ, 
                C.CIDADE
FROM PJ
JOIN CLIENTE C ON PJ.CODIGO_CLI = C.CODIGO
ORDER BY C.NOME ASC, C.CIDADE DESC;

-- c. Listar os vendedores e seus pedidos já realizados com total de
-- fatura entre R$ 1000,00 e R$ 5000,00, inclusive.. Mostrar: Nome do
-- vendedor (VENDEDOR), número do pedido (PEDIDO),data do pedido (DATA)
-- com a formatação 'dd/mm/yyyy'. Ordenados pelo nome do vendedor
-- descendente e, dentro deste, pela data ascendente.
-- RESOLUÇÃO:

SELECT V.NOME AS VENDEDOR,
        P.NUMERO AS PEDIDO,
        P.DATA AS DATA
FROM VENDEDOR V
JOIN PEDIDO P ON V.MATRICULA = P.MATRICULA_VEN
WHERE P.TOTAL_FATURA BETWEEN 1000 AND 5000
ORDER BY NOME ASC, DATA ASC;

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

/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Select - Queries dificuldade alta
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Fazer um plano de execução estimado para a query apresentada a seguir:
SELECT NUMERO,
DATA,
TOTAL_FATURA AS TOTAL,
NOME AS CLIENTE,
CNPF,
CNPJ
FROM PEDIDO JOIN
VIEW_CLIENTE ON CODIGO_CLI=CODIGO
WHERE TOTAL_FATURA < 10000;
*/

-- a. Executar e apresentar a análise do plano de execução da query.
-- RESOLUÇÃO:
EXPLAIN PLAN SET STATEMENT_ID = 'Query_pedido_view_cliente' FOR
SELECT P.NUMERO,
       P.DATA,
       P.TOTAL_FATURA AS TOTAL,
       V.NOME AS CLIENTE,
       V.CNPF,
       V.CNPJ
FROM PEDIDO P
JOIN VIEW_CLIENTE V ON P.CODIGO_CLI = V.CODIGO
WHERE P.TOTAL_FATURA < 10000;

SELECT PLAN_TABLE_OUTPUT
FROM TABLE(DBMS_XPLAN.DISPLAY('PLAN_TABLE', 'Query_pedido_view_cliente', 'TYPICAL'));

/* A análise detalhada (operações, estimativas de linhas e custo) deve ser feita
com a saída do DBMS_XPLAN no Oracle. VIEW_CLIENTE expande para CLIENTE,
PF e PJ; o caminho de acesso depende das estatísticas e da seletividade. */

-- b. Apresente uma proposta para otimizar a execução query.
-- RESPOSTA:

/* Criar um índice para a coluna usada no filtro de faixa. O otimizador poderá
escolher um INDEX RANGE SCAN quando o filtro for seletivo; caso contrário,
um FULL TABLE SCAN pode continuar sendo mais barato. */

CREATE INDEX IND_PEDIDO_TOTAL_FATURA
    ON PEDIDO (TOTAL_FATURA);

-- c. Executar e apresentar a análise do plano de execução com a proposta apresentada no item b.
-- RESOLUÇÃO:
EXPLAIN PLAN SET STATEMENT_ID = 'Query_pedido_view_cliente_otimizada' FOR
SELECT P.NUMERO,
       P.DATA,
       P.TOTAL_FATURA AS TOTAL,
       V.NOME AS CLIENTE,
       V.CNPF,
       V.CNPJ
FROM PEDIDO P
JOIN VIEW_CLIENTE V ON P.CODIGO_CLI = V.CODIGO
WHERE P.TOTAL_FATURA < 10000;

SELECT PLAN_TABLE_OUTPUT
FROM TABLE(DBMS_XPLAN.DISPLAY('PLAN_TABLE', 'Query_pedido_view_cliente_otimizada', 'TYPICAL'));

/* Compare esta saída com Query_pedido_view_cliente, especialmente o acesso a PEDIDO e o custo
estimado. O uso do índice e o custo efetivo só podem ser confirmados no Oracle. */

-- d. Em termos de custos, qual foi o ganho obtido com sua estratégia de otimização.
-- RESPOSTA:

/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Select - Queries dificuldade alta - 1
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Selecionar dados em tabelas do projeto PEDIDO, em conformidade com os enunciados a
seguir:
*/

-- a. Criar a view que mostra estoque constante no BD Pedidos.
-- (VIEW_ESTOQUE) contendo os dados indicados no modelo apresentado.
-- Analise os dados gerados na view. Faça os ajustes na view para não
-- mostrar dados inconsistentes, do tipo ter saído mais do que
-- foi adquirido, bem como não mostrar valores nulos.
-- RESOLUÇÃO:

CREATE OR REPLACE VIEW VIEW_ESTOQUE AS
SELECT 
    P.DESCRICAO AS PRODUTO,
    NVL(E.QTD_ENTRADA, 0) AS QUANTIDADE_ADQUIRIDA,
    NVL(I.QTD_SAIDA, 0) AS QUANTIDADE_SAIDA,
    (NVL(E.QTD_ENTRADA, 0) - NVL(I.QTD_SAIDA, 0)) AS DISPONIVEL,
    P.UNID_MEDIDA
FROM PRODUTO P
LEFT JOIN (
    SELECT CODIGO_PRO, SUM(QUANTIDADE) AS QTD_ENTRADA
    FROM ESTOQUE
    GROUP BY CODIGO_PRO
) E ON P.CODIGO = E.CODIGO_PRO
LEFT JOIN (
    SELECT CODIGO_PRO, SUM(QUANTIDADE) AS QTD_SAIDA
    FROM ITEM_PRODUTO
    GROUP BY CODIGO_PRO
) I ON P.CODIGO = I.CODIGO_PRO;


--VISUALIZANDO:
SELECT * FROM VIEW_ESTOQUE;

-- Das 11 linhas retornadas, 6 apresnetaram valores negativos na colina disponivel pois QUANTIDADE_SAIDA > QUANTIDADE_ADQUIRIDA. 

--AJUSTANDO:
CREATE OR REPLACE VIEW VIEW_ESTOQUE (
    PRODUTO,
    QUANTIDADE_ADQUIRIDA,
    QUANTIDADE_SAIDA,
    DISPONIVEL,
    UNID_MEDIDA
) AS
SELECT 
    P.DESCRICAO,
    NVL(E.TOTAL_ADQUIRIDO, 0),
    NVL(I.TOTAL_SAIDA, 0),
    NVL(E.TOTAL_ADQUIRIDO, 0) - NVL(I.TOTAL_SAIDA, 0),
    P.UNID_MEDIDA
FROM PRODUTO P
LEFT JOIN (
    SELECT CODIGO_PRO, SUM(QUANTIDADE) AS TOTAL_ADQUIRIDO
    FROM ESTOQUE
    GROUP BY CODIGO_PRO
) E ON P.CODIGO = E.CODIGO_PRO
LEFT JOIN (
    SELECT CODIGO_PRO, SUM(QUANTIDADE) AS TOTAL_SAIDA
    FROM ITEM_PRODUTO
    GROUP BY CODIGO_PRO
) I ON P.CODIGO = I.CODIGO_PRO
WHERE NVL(E.TOTAL_ADQUIRIDO, 0) >= NVL(I.TOTAL_SAIDA, 0);

-- Elimina da visualização qualquer produto com dados inconsistentes (onde a QUANTIDADE_SAIDA seja maior que a QUANTIDADE_ADQUIRIDA, o que geraria estoque negativo).

SELECT * FROM VIEW_ESTOQUE;