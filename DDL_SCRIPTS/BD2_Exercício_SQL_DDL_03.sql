/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DDL - Tabelas, Constraints, Indices e
Sequences do Projeto Pedido - Parte 3
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
1) Criar uma constraint que garanta que o valor do NUMERO da tabela PEDIDO esteja
entre, inclusive, 1 e 99999. O nome da constraint (regra) está no modelo físico de
dados.
2) Criar os indexes das tabelas PF e PJ. Estes indexes serão únicos e utilizados como
listas invertidas. Nomes para os índices estão no modelo físico. Nomes para as
constraints(regras) de unicidade: UK_PF_CNPF e UK_PJ_CNPJ.
3) Criar uma sequence de nome SEQ_ITEM_ID para o campo CODIGO de
ITEM_PRODUTO, com incremento de 2. 
*/

-- Constraint da tabela PEDIDO

ALTER TABLE PEDIDO
ADD CONSTRAINT CK_NUMERO_PEDIDO
CHECK (NUMERO BETWEEN 1 AND 99999);

-- INDEXAÇÃO DE PF E PJ
CREATE UNIQUE INDEX IND_CNPF_PF
ON PF (CNPF);

CREATE UNIQUE INDEX IND_CNPJ_PJ
ON PJ (CNPJ);

-- CONSTRAINTS
ALTER TABLE PF
ADD CONSTRAINT UK_PF_CNPF UNIQUE (CNPF);

ALTER TABLE PJ
ADD CONSTRAINT UK_PJ_CNPJ UNIQUE (CNPJ);

--SEQUENCIA PARA CODIGO DE ITEM_PRODUTO 
CREATE SEQUENCE SEQ_ITEM_ID
    INCREMENT BY 2;








--Comment to add new commit message