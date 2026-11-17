/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DDL e DML - trigger e Select - Queries
dificuldade média/alta
Implementar trigger e queries com a linguagem SQL aplicadas no SGBDR Oracle 10g,
apoiadas no SqlDeveloper.
Utilizando as tabelas criadas no exercício BD2_Exercício_SQL_DDL_06, com solução
disponibilizada, realizar o que se pede:
*/

-- a. Fazer uma trigger para manter o log de alterações no banco de dados.
-- com o nome TRG_LOG_ALTERACOES_BD_nome_tabela.
-- Ao realizar uma alteração na tabela escolhida do projeto pedido.
-- A trigger irá fazer uma inclusão na tabela LOG_ALTERACOES, onde a
-- ação será em conformidade com o tipo de alteração (INSERÇÃO, ALTERAÇÃO
-- e/ou DELEÇÃO), incluindo o nome da tabela e a data alteração.
-- RESOLUÇÃO:

-- DROP TRIGGER TRG_LOG_ALTERACOES_BD_PRODUTO;

CREATE TRIGGER TRG_LOG_ALTERACOES_BD_PRODUTO
AFTER INSERT OR DELETE OR UPDATE ON PRODUTO 
FOR EACH ROW DECLARE
    V_ACAO VARCHAR2(20);
BEGIN
    IF INSERTING THEN
        V_ACAO := 'INSERÇÃO';
    ELSIF UPDATING THEN
        V_ACAO := 'ALTERAÇÃO';
    ELSIF DELETING THEN
        V_ACAO := 'DELEÇÃO';
    END IF;

    INSERT INTO LOG_ALTERACOES (
        ACAO,
        TABELA,
        DATA_EVENTO
    ) VALUES (
        V_ACAO,
        'PRODUTO',
        SYSDATE
    );
END;
/

-- b. Fazer queries, pelo menos uma para cada ação (INSERÇÃO, ALTERAÇÃO
-- e/ou DELEÇÃO) na tabela escolhida.
-- RESOLUÇÃO:

-- Teste de Inserção
INSERT INTO PRODUTO (CODIGO, DESCRICAO, UNID_MEDIDA) 
VALUES (999, 'Tijolo Baiano', 'Unidade');

-- Teste de Alteração
UPDATE PRODUTO 
SET DESCRICAO = 'Tijolo Cerâmico 8 Furos' 
WHERE CODIGO = 999;

-- Teste de Deleção
DELETE FROM PRODUTO 
WHERE CODIGO = 999;

COMMIT;

-- C. Fazer uma query para verificar os logs registrados nas ações do item b.
-- RESOLUÇÃO:

SELECT * FROM LOG_ALTERACOES;