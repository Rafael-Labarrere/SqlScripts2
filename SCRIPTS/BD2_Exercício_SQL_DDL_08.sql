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
