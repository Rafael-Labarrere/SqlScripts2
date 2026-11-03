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

