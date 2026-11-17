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