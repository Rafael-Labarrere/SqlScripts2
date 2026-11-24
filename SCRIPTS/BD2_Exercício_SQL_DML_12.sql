
/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DML - Select - Queries dificuldade média -
3
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
Selecionar dados em tabelas do projeto PEDIDO, em conformidade com os enunciados a
seguir:
*/



-- a. Inserir uma prateleira de código 390, descrição 'Prateleira de
-- teste' e número de seções 2.
-- RESOLUÇÃO:

INSERT INTO PRATELEIRA 
VALUES (
    390,
    'Prateleira de teste',
    2
);

-- b. Listar as prateleiras e os respectivos produtos que podem
-- armazenar. Mostrando a frase 'sem produto' quando não se relaciona
-- com nenhum. Mostrar: Prateleira (CODIGO, DESCRICAO), descrição
-- (PRODUTO) e quantidade distinta de produtos, ordenados pela quantidade
-- de produtos decrescente.
-- RESOLUÇÃO:

SELECT PRA.CODIGO AS PRATELEIRA, PRA.DESCRICAO AS DESCRICAO_PRATELEIRA, NVL(PRO.DESCRICAO, 'sem produto') AS DESCRICAO_PRODUTO, COUNT(DISTINCT PRO.CODIGO) AS DISTINTOS
FROM PRATELEIRA PRA
LEFT JOIN ESTOQUE E ON PRA.CODIGO = E.CODIGO_PRA
LEFT JOIN PRODUTO PRO ON E.CODIGO_PRO = PRO.CODIGO
GROUP BY PRA.CODIGO, PRA.DESCRICAO, PRO.DESCRICAO
ORDER BY DISTINTOS DESC;

-- c. Selecionar todos os clientes da view VIEW_CLIENTE que são PF.
-- Mostrar: CODIGO, NOME e CNPF, ordenado decrescente pelo nome do
-- cliente.
-- RESOLUÇÃO:

SELECT CODIGO, NOME, CNPF
FROM VIEW_CLIENTE
WHERE CNPF IS NOT NULL
ORDER BY NOME DESC;

-- d. Listar os pedidos e seus respectivos produtos. Mostrar: numero do
-- pedido (PEDIDO), DATA do pedido, descrição do produto (PRODUTO) e
-- QUANTIDADE de produtos no pedido. Ordenado pela DATA do pedido
-- crescente e, dentro das datas, pelo produto decrescente.
-- RESOLUÇÃO:

SELECT P.NUMERO, P.DATA, PR.DESCRICAO, IP.QUANTIDADE
FROM PEDIDO P
INNER JOIN ITEM_PRODUTO IP ON P.NUMERO = IP.NUMERO_PED
INNER JOIN PRODUTO PR ON IP.CODIGO_PRO = PR.CODIGO
ORDER BY P.DATA, PR.DESCRICAO DESC;
