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