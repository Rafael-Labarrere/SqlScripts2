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
