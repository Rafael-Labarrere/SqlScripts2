/* BD2 - 2o Bim -Atividade de SQL - Exerc�cios de DDL - Tabelas do Projeto Pedido - Parte 1
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER F�sico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
1) Implementar o script DDL para criar as tabelas do BD de pedidos: CLIENTE, PF, PJ,
PRODUTO, VENDEDOR, FONE_CLIENTE, FONE_VENDEDOR e PRATELEIRA.
Colocar as regras de integridade b�sica no script de cria��o. Substituir todos os tipos de
dados INTEGER que est�o no modelo por NUMBER.
*/



DROP TABLE FONE_CLIENTE CASCADE CONSTRAINTS;
DROP TABLE FONE_VENDEDOR CASCADE CONSTRAINTS;
DROP TABLE PF CASCADE CONSTRAINTS;
DROP TABLE PJ CASCADE CONSTRAINTS;
DROP TABLE CLIENTE CASCADE CONSTRAINTS;
DROP TABLE VENDEDOR CASCADE CONSTRAINTS;
DROP TABLE PRODUTO CASCADE CONSTRAINTS;
DROP TABLE PRATELEIRA CASCADE CONSTRAINTS;

CREATE TABLE CLIENTE (
    CODIGO NUMBER NOT NULL,
    NOME VARCHAR2(60) NOT NULL,
    RUA VARCHAR2(80) NOT NULL,
    NR NUMBER(4) NOT NULL,
    BAIRRO VARCHAR2(50) NOT NULL,
    COMPLEMENTO VARCHAR2(100),
    CIDADE VARCHAR2(50) NOT NULL,
    UF VARCHAR2(2) NOT NULL,
    CEP VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (CODIGO)
);

CREATE TABLE VENDEDOR (
    MATRICULA NUMBER NOT NULL,
    NOME VARCHAR2(60) NOT NULL,
    CNPF VARCHAR2(14) NOT NULL,
    CONSTRAINT PK_VENDEDOR PRIMARY KEY (MATRICULA)
);

CREATE TABLE PRODUTO (
    CODIGO NUMBER NOT NULL,
    DESCRICAO VARCHAR2(80) NOT NULL,
    UNID_MEDIDA VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_PRODUTO PRIMARY KEY (CODIGO)
);

CREATE TABLE PRATELEIRA (
    CODIGO NUMBER(3) NOT NULL,
    DESCRICAO VARCHAR2(50) NOT NULL,
    NUMERO_SECOES NUMBER(2) NOT NULL,
    CONSTRAINT PK_PRATELEIRA PRIMARY KEY (CODIGO)
);

CREATE TABLE PF (
    CODIGO_CLI NUMBER NOT NULL,
    CNPF VARCHAR2(14) NOT NULL,
    RG VARCHAR2(10) NOT NULL,
    DATA_NASCIMENTO DATE NOT NULL,
    CONSTRAINT PK_CLIENTE_PF PRIMARY KEY (CODIGO_CLI),
    CONSTRAINT FK_PF_CLIENTE
        FOREIGN KEY (CODIGO_CLI)
        REFERENCES CLIENTE (CODIGO)
);

CREATE TABLE PJ (
    CODIGO_CLI NUMBER NOT NULL,
    CNPJ VARCHAR2(19) NOT NULL,
    IE VARCHAR2(10) NOT NULL,
    NOME_FANTASIA VARCHAR2(60) NOT NULL,
    CONSTRAINT PK_CLIENTE_PJ PRIMARY KEY (CODIGO_CLI),
    CONSTRAINT FK_PJ_CLIENTE
        FOREIGN KEY (CODIGO_CLI)
        REFERENCES CLIENTE (CODIGO)
);

CREATE TABLE FONE_CLIENTE (
    NUMERO VARCHAR2(14) NOT NULL,
    CODIGO_CLI NUMBER NOT NULL,
    CONSTRAINT PK_FONE_CLIENTE PRIMARY KEY (NUMERO, CODIGO_CLI),
    CONSTRAINT FK_FONE_CLIENTE
        FOREIGN KEY (CODIGO_CLI)
        REFERENCES CLIENTE (CODIGO)
);

CREATE TABLE FONE_VENDEDOR (
    NUMERO VARCHAR2(14) NOT NULL,
    MATRICULA_VEN NUMBER NOT NULL,
    CONSTRAINT PK_FONE_VENDEDOR PRIMARY KEY (NUMERO, MATRICULA_VEN),
    CONSTRAINT FK_FONE_VENDEDOR
        FOREIGN KEY (MATRICULA_VEN)
        REFERENCES VENDEDOR (MATRICULA)
); 



/*
SELECT * FROM CLIENTE;
SELECT * FROM VENDEDOR;
SELECT * FROM PRODUTO;
SELECT * FROM PRATELEIRA;
SELECT * FROM PF;
SELECT * FROM PJ;
SELECT * FROM FONE_CLIENTE;
SELECT * FROM FONE_VENDEDOR;
*/

/* BD2 - 2o Bim -Atividade de SQL - Exerc�cios de DDL - Tabelas do Projeto Pedido - Parte 2
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER F�sico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
1) Criar as tabelas associativas: PEDIDO, ESTOQUE, CAPACIDADE_ESTOQUE e
ITEM_PRODUTO. N�o incluir na cria��o destas tabelas as chaves prim�ria (PK) e
chaves estrangeiras (FK). Substituir todos os tipos de dados INTEGER do modelo por
NUMBER.
2) Criar as constraints de chave prim�ria (primary key) para as tabelas associativas.
3) Criar as constraints das chaves estrangeiras (foreing key) para as tabelas associativas. */



DROP TABLE ITEM_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE CAPACIDADE_ESTOQUE CASCADE CONSTRAINTS;
DROP TABLE ESTOQUE CASCADE CONSTRAINTS;
DROP TABLE PEDIDO CASCADE CONSTRAINTS;

----------------------------------------------------------------------------------

CREATE TABLE PEDIDO (
    NUMERO NUMBER(6) NOT NULL,
    DATA DATE NOT NULL,
    PRAZO_ENTREGA DATE,
    RUA VARCHAR2(80),
    NR NUMBER(4),
    BAIRRO VARCHAR2(50),
    COMPLEMENTO VARCHAR2(100),
    CIDADE VARCHAR2(50),
    UF VARCHAR2(2),
    CEP VARCHAR2(10),
    TOTAL_FATURA NUMBER(8,2),
    CODIGO_CLI NUMBER NOT NULL,
    MATRICULA_VEN NUMBER NOT NULL
);

CREATE TABLE ESTOQUE (
    DATA_ENTRADA DATE NOT NULL,
    CODIGO_PRO NUMBER NOT NULL,
    CODIGO_PRA NUMBER(3) NOT NULL,
    QUANTIDADE NUMBER(5) NOT NULL,
    DATA_VALIDADE DATE
);

CREATE TABLE CAPACIDADE_ESTOQUE (
    CODIGO_PRO NUMBER NOT NULL,
    CODIGO_PRA NUMBER(3) NOT NULL,
    QUANTIDADE NUMBER(5) NOT NULL
);

CREATE TABLE ITEM_PRODUTO (
    CODIGO_PRO NUMBER NOT NULL,
    NUMERO_PED NUMBER(6) NOT NULL,
    QUANTIDADE NUMBER(5) NOT NULL,
    PRECO_UNITARIO NUMBER(5,2) NOT NULL,
    VALOR_ITEM NUMBER(7,2)
);



-- Chaves pim�rias 



ALTER TABLE PEDIDO
ADD CONSTRAINT PK_PEDIDO
PRIMARY KEY (NUMERO);

ALTER TABLE ESTOQUE
ADD CONSTRAINT PK_ESTOQUE
PRIMARY KEY (CODIGO_PRO, CODIGO_PRA, DATA_ENTRADA);

ALTER TABLE CAPACIDADE_ESTOQUE
ADD CONSTRAINT PK_CAPACIDADE_ESTOQUE
PRIMARY KEY (CODIGO_PRO, CODIGO_PRA);

ALTER TABLE ITEM_PRODUTO
ADD CONSTRAINT PK_ITEM_PRODUTO
PRIMARY KEY (CODIGO_PRO, NUMERO_PED);



-- CHAVES ESTRANGEIRAS 



ALTER TABLE PEDIDO
ADD CONSTRAINT FK_PED_CLIENTE
FOREIGN KEY (CODIGO_CLI)
REFERENCES CLIENTE (CODIGO);

ALTER TABLE PEDIDO
ADD CONSTRAINT FK_PED_VENDEDOR
FOREIGN KEY (MATRICULA_VEN)
REFERENCES VENDEDOR (MATRICULA);

ALTER TABLE ESTOQUE
ADD CONSTRAINT FK_EST_PRODUTO
FOREIGN KEY (CODIGO_PRO)
REFERENCES PRODUTO (CODIGO);

ALTER TABLE ESTOQUE
ADD CONSTRAINT FK_EST_PRATELEIRA
FOREIGN KEY (CODIGO_PRA)
REFERENCES PRATELEIRA (CODIGO);

ALTER TABLE CAPACIDADE_ESTOQUE
ADD CONSTRAINT FK_CAP_EST_PRODUTO
FOREIGN KEY (CODIGO_PRO)
REFERENCES PRODUTO (CODIGO);

ALTER TABLE CAPACIDADE_ESTOQUE
ADD CONSTRAINT FK_CAP_EST_PRATELEIRA
FOREIGN KEY (CODIGO_PRA)
REFERENCES PRATELEIRA (CODIGO);

ALTER TABLE ITEM_PRODUTO
ADD CONSTRAINT FK_ITEM_PEDIDO
FOREIGN KEY (NUMERO_PED)
REFERENCES PEDIDO (NUMERO);

ALTER TABLE ITEM_PRODUTO
ADD CONSTRAINT FK_ITEM_PRODUTO
FOREIGN KEY (CODIGO_PRO)
REFERENCES PRODUTO (CODIGO);



/* TESTANDO CONSTRAISTS 



SELECT * FROM PEDIDO;
DESC PEDIDO;

DESC VENDEDOR;

INSERT INTO VENDEDOR (
    MATRICULA,
    NOME,
    CNPF
) VALUES (
    67,
    'PEDRO',
    '123.456.789'
)

SELECT * FROM VENDEDOR;

DESC CLIENTE;

INSERT INTO CLIENTE (
    CODIGO,
    NOME,
    RUA,
    NR,
    BAIRRO,
    CIDADE,
    UF,
    CEP
) VALUES (
    69,
    'VANDERSSON',
    'RUA DE LA',
    7,
    'BAIRRO DE CA',
    'GOIANIA',
    'GO',
    '80033020'
);

SELECT * FROM CLIENTE;

INSERT INTO PEDIDO (
    NUMERO,
    DATA,
    CODIGO_CLI,
    MATRICULA_VEN
) VALUES (
    1,
    TO_DATE('29/09/2026', 'DD/MM/YYYY'),
    69,
    67
);

*/

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
    
--TESTANDO SEQUENCIA:

DESC ITEM_PRODUTO

INSERT INTO ITEM_PRODUTO(
    CODIGO_PRO,
    NUMERO_PED,
    QUANTIDADE,
    PRECO_UNITARIO
) VALUES (
    123,
    1,
    10,
    20
);

SELECT * FROM PEDIDO;
SELECT * FROM PRODUTO;

DESC PRODUTO

INSERT INTO PRODUTO (
    CODIGO,
    DESCRICAO,
    UNID_MEDIDA
) VALUES (
    123,
    'PRODUTO BOM',
    'METROS'
);

/*
BD2 - 2o Bim - Atividade de SQL - Exercícios de DDL - Comentários em tabelas - Parte 5
Queries implementadas na linguagem SQL aplicadas no SGBDR Oracle, apoiadas no
SqlDeveloper. Utilizar o MER Físico e BD Pedido disponibilizado para treinamento da disciplina
de Banco de Dados.
1) Criar comentários para a tabela ITEM_PRODUTO e suas respectivas colunas.
*/

COMMENT ON TABLE ITEM_PRODUTO IS
'Itens dos pedidos realizados';

COMMENT ON COLUMN ITEM_PRODUTO.CODIGO_PRO IS
'Código do produto';

COMMENT ON COLUMN ITEM_PRODUTO.NUMERO_PED IS
'Número do pedido';

COMMENT ON COLUMN ITEM_PRODUTO.QUANTIDADE IS
'Quantidade do produto no pedido';

COMMENT ON COLUMN ITEM_PRODUTO.PRECO_UNITARIO IS
'Preço unitário do produto';

COMMENT ON COLUMN ITEM_PRODUTO.VALOR_ITEM IS
'Valor total do item';

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
);

-- sequência 
CREATE SEQUENCE SEQ_ID_LOG_ALTERACOES
    START WITH 1
    INCREMENT BY 1;

-- TRIGGER

CREATE TRIGGER TRG_LOG_ALTR_BI
BEFORE INSERT ON LOG_ALTERACOES FOR EACH ROW
BEGIN 
    IF :NEW.ID_LOG IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Não é permitido inserir manualmente o ID');
    END IF;
    SELECT SEQ_ID_LOG_ALTERACOES.NEXTVAL INTO :NEW.ID_LOG FROM DUAL;
END;
/

/*
BD2 - 2o Bim -Atividade de SQL - Exercícios de DDL e DML - Function, Procedure e Query
- dificuldade alta.
Implementar funções, procedimentos e queries com a linguagem SQL aplicadas no SGBDR
Oracle 10g, apoiadas no SqlDeveloper.
Utilizando as tabelas criadas no exercício BD2_Exercício_SQL_DDL_06, com solução
disponibilizada, realizar o que se pede:
*/

-- a. Fazer um procedimento armazenado com o nome PROC_ATUALZ_EMAIL_ALUNO
-- em conformidade com:

CREATE TABLE ALUNO (
    MATRICULA NUMBER        NOT NULL,
    NOME      VARCHAR2(60)  NOT NULL,
    EMAIL     VARCHAR2(100),
    CONSTRAINT PK_ALUNO PRIMARY KEY (MATRICULA)
);

-- 1) Receba o email para a atualização garantindo (crítica) que possui:
-- um-e-somente-um @
-- pelo menos um ponto depois do @
-- pelo menos um carácter antes e um depois do @
-- Com tratamento de exceção

CREATE OR REPLACE PROCEDURE PROC_ATUALZ_EMAIL_ALUNO (
    p_matricula IN ALUNO.MATRICULA%TYPE,
    p_email     IN ALUNO.EMAIL%TYPE
) IS
    e_email_nulo     EXCEPTION;
    e_arroba         EXCEPTION;
    e_antes_depois   EXCEPTION;
    e_sem_ponto      EXCEPTION;
    e_aluno_inexist  EXCEPTION;

    v_email   VARCHAR2(200) := TRIM(p_email);
    v_qtd_at  NUMBER;
    v_pos_at  NUMBER;
BEGIN
    -- e-mail informado?
    IF v_email IS NULL THEN
        RAISE e_email_nulo;
    END IF;

    -- um-e-somente-um @
    v_qtd_at := LENGTH(v_email) - LENGTH(REPLACE(v_email, '@', ''));
    IF v_qtd_at <> 1 THEN
        RAISE e_arroba;
    END IF;

    v_pos_at := INSTR(v_email, '@');

    -- pelo menos um caractere antes e um depois do @
    IF v_pos_at < 2 OR v_pos_at = LENGTH(v_email) THEN
        RAISE e_antes_depois;
    END IF;

    -- pelo menos um ponto depois do @
    IF INSTR(v_email, '.', v_pos_at + 1) = 0 THEN
        RAISE e_sem_ponto;
    END IF;

    UPDATE ALUNO
       SET EMAIL = v_email
     WHERE MATRICULA = p_matricula;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_aluno_inexist;
    END IF;

    -- registra na tabela do DDL_06 (ID_LOG é gerado pela trigger: não informar)
    INSERT INTO LOG_ALTERACOES (ACAO, TABELA, DATA_EVENTO)
    VALUES ('UPDATE', 'ALUNO', SYSDATE);

    COMMIT;

EXCEPTION
    WHEN e_email_nulo THEN
        RAISE_APPLICATION_ERROR(-20001, 'e-mail não informado');
    WHEN e_arroba THEN
        RAISE_APPLICATION_ERROR(-20002, 'o e-mail deve ter um e somente um @');
    WHEN e_antes_depois THEN
        RAISE_APPLICATION_ERROR(-20003, 'deve haver ao menos um caractere antes e um depois do @');
    WHEN e_sem_ponto THEN
        RAISE_APPLICATION_ERROR(-20004, 'deve haver ao menos um ponto depois do @');
    WHEN e_aluno_inexist THEN
        RAISE_APPLICATION_ERROR(-20005, 'cadastro não encontrado para a matrícula ' || p_matricula);
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999, 'erro inesperado: ' || SQLERRM);
END PROC_ATUALZ_EMAIL_ALUNO;
/
SHOW ERRORS PROCEDURE PROC_ATUALZ_EMAIL_ALUNO;

-- 2) O procedimento será acionado por uma função com o nome
-- FUNC_ATUALZ_EMAIL_ALUNO que terá como retorno uma mensagem
-- ‘Atualizado com sucesso’ OU ‘Não atualizado pelo motivo ...'

CREATE OR REPLACE FUNCTION FUNC_ATUALZ_EMAIL_ALUNO (
    p_matricula IN ALUNO.MATRICULA%TYPE,
    p_email     IN ALUNO.EMAIL%TYPE
) RETURN VARCHAR2 IS
    v_msg VARCHAR2(4000);
BEGIN
    PROC_ATUALZ_EMAIL_ALUNO(p_matricula, p_email);
    RETURN 'Atualizado com sucesso';
EXCEPTION
    WHEN OTHERS THEN
        v_msg := SQLERRM;
        v_msg := SUBSTR(v_msg, INSTR(v_msg, ': ') + 2);
        RETURN 'Não atualizado pelo motivo ' || v_msg;
END FUNC_ATUALZ_EMAIL_ALUNO;
/
SHOW ERRORS FUNCTION FUNC_ATUALZ_EMAIL_ALUNO;

-- 3) Crie pelo menos um exemplo de uso da função com o procedimento.
-- RESOLUÇÃO:

INSERT INTO ALUNO (MATRICULA, NOME, EMAIL)
VALUES (1, 'Aluno Teste', NULL);
COMMIT;

SET SERVEROUTPUT ON

DECLARE
    v_ret VARCHAR2(4000);
BEGIN
    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(1, 'joao.silva@empresa.com.br');
    DBMS_OUTPUT.PUT_LINE('1) ' || v_ret);   -- sucesso

    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(1, 'joao.silva.empresa.com');
    DBMS_OUTPUT.PUT_LINE('2) ' || v_ret);   -- sem @

    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(1, 'joao@@empresa.com');
    DBMS_OUTPUT.PUT_LINE('3) ' || v_ret);   -- dois @

    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(1, '@empresa.com');
    DBMS_OUTPUT.PUT_LINE('4) ' || v_ret);   -- nada antes

    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(1, 'joao@');
    DBMS_OUTPUT.PUT_LINE('5) ' || v_ret);   -- nada depois

    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(1, 'joao@empresa');
    DBMS_OUTPUT.PUT_LINE('6) ' || v_ret);   -- sem ponto depois do @

    v_ret := FUNC_ATUALZ_EMAIL_ALUNO(99999, 'ok@empresa.com');
    DBMS_OUTPUT.PUT_LINE('7) ' || v_ret);   -- código inexistente
END;
/

SELECT MATRICULA, NOME, EMAIL FROM ALUNO WHERE MATRICULA = 1;
SELECT * FROM LOG_ALTERACOES;
