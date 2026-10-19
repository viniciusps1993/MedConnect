--1°

--Essa Função verifica se o CPF cadastrado possui 11 dígitos e valida se todos os caracteres são númericos.

CREATE OR REPLACE FUNCTION validar_cpf(p_cpf IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
    IF LENGTH(p_cpf) != 11 THEN
        RETURN FALSE;
    END IF;

    FOR i IN 1..LENGTH(p_cpf) LOOP
        IF NOT REGEXP_LIKE(SUBSTR(p_cpf, i, 1), '[0-9]') THEN
            RETURN FALSE;
        END IF;
    END LOOP;

    RETURN TRUE;
END validar_cpf;
/

--2

--Essa Função valida a data de nascimento e verifica se a data de nascimento é anterior a data atual.

CREATE OR REPLACE FUNCTION validar_data_nascimento(p_data_nascimento IN DATE) RETURN BOOLEAN IS
BEGIN
    -- Verifica se a data de nascimento é anterior à data atual
    IF p_data_nascimento > SYSDATE THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END validar_data_nascimento;
/

