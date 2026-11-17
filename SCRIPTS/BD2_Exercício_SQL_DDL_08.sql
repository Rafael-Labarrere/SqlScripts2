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
-- 1) Receba o email para a atualização garantindo (crítica) que possui:
-- um-e-somente-um @
-- pelo menos um ponto depois do @
-- pelo menos um carácter antes e um depois do @
-- Com tratamento de exceção
-- 2) O procedimento será acionado por uma função com o nome
-- FUNC_ATUALZ_EMAIL_ALUNO que terá como retorno uma mensagem
-- ‘Atualizado com sucesso’ OU ‘Não atualizado pelo motivo ...'
-- 3) Crie pelo menos um exemplo de uso da função com o procedimento.
-- RESOLUÇÃO: