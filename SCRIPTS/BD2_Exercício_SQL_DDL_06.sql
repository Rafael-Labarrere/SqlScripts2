--BD2 - 2o Bim - Atividade de SQL - Exercícios de DDL - Tabela_Trigger_Sequence
--Programar executar o script DDL para a seguinte tabela expressa no MER Físico.

--referência: ./log_alteracoes.png

/*
Detalhes complementares:
- O script DDL deve ter compatibilidade com o SGBDR Oracle 10g.
- Todas as colunas são obrigatórias.
- A chave primária (PK) da tabela (LOG_ALTERACOES.ID_LOG) deve ser gerado
automaticamente quando das inserções de dados (utilizar SEQUENCE e TRIGGER
BEFORE INSERT).
- A sequence será básica (incremento de um, começando com 1,com o seguinte
nome: SEQ_ID_LOG_ALTERACOES.
- A trigger (BEFORE INSERT) terá o seguinte nome: TRG_LOG_ALTR_BI. E não
pode permitir a inserção manual de valores para o ID_LOG, emitindo a seguinte
mensagem caso haja a tentativa: 'Não é permitido inserir manualmente o ID'
*/

CREATE TABLE LOG_ALTERACOES (
    ID_LOG          NUMBER,
    ACAO            VARCHAR(12),
    TABELA          VARCHAR2(30),
    DATA_EVENTO     DATE,

    CONSTRAINT LOG_ALTERACOES_PK 
        PRIMARY KEY (ID_LOG)
)

-- sequência 
CREATE SEQUENCE SEQ_ID_LOG_ALTERACOES
    START WITH 1
    INCREMENT BY 1;

-- TRIGGER

CREATE TRIGGER TRG_LOG_ALTR_BI
BEFORE INSERT ON LOG_ALTERACOES FOR EACH ROW
BEGIN 
    IF :NEW.ID_LOG IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'não é permitido inserir manualmente o ID');
    END IF;
    SELECT SEQ_ID_LOG_ALTERACOES.NEXTVAL INTO :NEW.ID_LOG FROM DUAL;
END;
