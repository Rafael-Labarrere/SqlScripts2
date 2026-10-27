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