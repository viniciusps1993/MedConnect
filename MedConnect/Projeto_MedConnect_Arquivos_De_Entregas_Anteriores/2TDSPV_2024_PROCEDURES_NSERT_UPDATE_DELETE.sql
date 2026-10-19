--Procedures T_MDCT_CLIENTE

CREATE OR REPLACE PROCEDURE inserir_cliente(
    p_id_cliente IN NUMBER,
    p_nome_cliente IN VARCHAR2,
    p_nr_cpf IN VARCHAR2,
    p_nm_rg IN VARCHAR2,
    p_lg_cliente IN VARCHAR2,
    p_sh_cliente IN VARCHAR2,
    p_dt_nascimento IN DATE,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_CLIENTE (ID_CLIENTE, NM_CLIENTE, NR_CPF, NM_RG, LG_CLIENTE, SH_CLIENTE, DT_NASCIMENTO, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_cliente, p_nome_cliente, p_nr_cpf, p_nm_rg, p_lg_cliente, p_sh_cliente, p_dt_nascimento, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_cliente;
/

CREATE OR REPLACE PROCEDURE atualizar_cliente(
    p_id_cliente IN NUMBER,
    p_nome_cliente IN VARCHAR2,
    p_nr_cpf IN VARCHAR2,
    p_nm_rg IN VARCHAR2,
    p_lg_cliente IN VARCHAR2,
    p_sh_cliente IN VARCHAR2,
    p_dt_nascimento IN DATE,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_CLIENTE
    SET NM_CLIENTE = p_nome_cliente,
        NR_CPF = p_nr_cpf,
        NM_RG = p_nm_rg,
        LG_CLIENTE = p_lg_cliente,
        SH_CLIENTE = p_sh_cliente,
        DT_NASCIMENTO = p_dt_nascimento,
        NM_USUARIO = p_nm_usuario,
        DT_CADASTRO = SYSDATE
    WHERE ID_CLIENTE = p_id_cliente;
    COMMIT; 
END atualizar_cliente;
/

CREATE OR REPLACE PROCEDURE excluir_cliente(
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_CLIENTE
    WHERE ID_CLIENTE = p_id_cliente;
    COMMIT;
END excluir_cliente;
/

--Procedures T_MDCT_ESTADO

CREATE OR REPLACE PROCEDURE inserir_estado(
    p_id_estado IN NUMBER,
    p_sg_estado IN CHAR,
    p_nm_estado IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_ESTADO (ID_ESTADO, SG_ESTADO, NM_ESTADO, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_estado, p_sg_estado, p_nm_estado, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_estado;
/


CREATE OR REPLACE PROCEDURE atualizar_estado(
    p_id_estado IN NUMBER,
    p_sg_estado IN CHAR,
    p_nm_estado IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_ESTADO
    SET SG_ESTADO = p_sg_estado,
        NM_ESTADO = p_nm_estado,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_ESTADO = p_id_estado;
    COMMIT; 
END atualizar_estado;
/

CREATE OR REPLACE PROCEDURE excluir_estado(
    p_id_estado IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_ESTADO
    WHERE ID_ESTADO = p_id_estado;
    COMMIT;
END excluir_estado;
/


--Procedures T_MDCT_CIDADE

CREATE OR REPLACE PROCEDURE inserir_cidade(
    p_id_cidade IN NUMBER,
    p_id_estado IN NUMBER,
    p_nm_cidade IN VARCHAR2,
    p_cd_ibge IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_CIDADE (ID_CIDADE, ID_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_cidade, p_id_estado, p_nm_cidade, p_cd_ibge, p_nr_ddd, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_cidade;
/


CREATE OR REPLACE PROCEDURE atualizar_cidade(
    p_id_cidade IN NUMBER,
    p_id_estado IN NUMBER,
    p_nm_cidade IN VARCHAR2,
    p_cd_ibge IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_CIDADE
    SET ID_ESTADO = p_id_estado,
        NM_CIDADE = p_nm_cidade,
        CD_IBGE = p_cd_ibge,
        NR_DDD = p_nr_ddd,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_CIDADE = p_id_cidade;
    COMMIT; 
END atualizar_cidade;
/


CREATE OR REPLACE PROCEDURE excluir_cidade(
    p_id_cidade IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_CIDADE
    WHERE ID_CIDADE = p_id_cidade;
    COMMIT;
END excluir_cidade;
/


-- Procedures T_MDCT_BAIRRO


CREATE OR REPLACE PROCEDURE inserir_bairro(
    p_id_bairro IN NUMBER,
    p_id_cidade IN NUMBER,
    p_nm_bairro IN VARCHAR2,
    p_nm_zona_bairro IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_BAIRRO (ID_BAIRRO, ID_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_bairro, p_id_cidade, p_nm_bairro, p_nm_zona_bairro, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_bairro;
/

CREATE OR REPLACE PROCEDURE atualizar_bairro(
    p_id_bairro IN NUMBER,
    p_id_cidade IN NUMBER,
    p_nm_bairro IN VARCHAR2,
    p_nm_zona_bairro IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_BAIRRO
    SET ID_CIDADE = p_id_cidade,
        NM_BAIRRO = p_nm_bairro,
        NM_ZONA_BAIRRO = p_nm_zona_bairro,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_BAIRRO = p_id_bairro;
    COMMIT; 
END atualizar_bairro;
/

CREATE OR REPLACE PROCEDURE excluir_bairro(
    p_id_bairro IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_BAIRRO
    WHERE ID_BAIRRO = p_id_bairro;
    COMMIT;
END excluir_bairro;
/

-- Procedures T_MDCT_LOGRADOURO


CREATE OR REPLACE PROCEDURE inserir_logradouro(
    p_id_logradouro IN NUMBER,
    p_id_end_cliente IN NUMBER,
    p_id_bairro IN NUMBER,
    p_nm_logradouro IN VARCHAR2,
    p_nr_cep IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_LOGRADOURO (ID_LOGRADOURO, ID_END_CLIENTE, ID_BAIRRO, NM_LOGRADOURO, NR_CEP, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_logradouro, p_id_end_cliente, p_id_bairro, p_nm_logradouro, p_nr_cep, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_logradouro;
/

CREATE OR REPLACE PROCEDURE atualizar_logradouro(
    p_id_logradouro IN NUMBER,
    p_id_end_cliente IN NUMBER,
    p_id_bairro IN NUMBER,
    p_nm_logradouro IN VARCHAR2,
    p_nr_cep IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_LOGRADOURO
    SET ID_END_CLIENTE = p_id_end_cliente,
        ID_BAIRRO = p_id_bairro,
        NM_LOGRADOURO = p_nm_logradouro,
        NR_CEP = p_nr_cep,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_LOGRADOURO = p_id_logradouro;
    COMMIT; 
END atualizar_logradouro;
/

CREATE OR REPLACE PROCEDURE excluir_logradouro(
    p_id_logradouro IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_LOGRADOURO
    WHERE ID_LOGRADOURO = p_id_logradouro;
    COMMIT;
END excluir_logradouro;
/


-- Procedures T_MDCT_END_CLIENTE


CREATE OR REPLACE PROCEDURE inserir_end_cliente(
    p_id_end_cliente IN NUMBER,
    p_id_cliente IN NUMBER,
    p_nr_logradouro IN NUMBER,
    p_ds_complemento_numero IN VARCHAR2,
    p_ds_ponto_referencia IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_END_CLIENTE (ID_END_CLIENTE, ID_CLIENTE, NR_LOGRADOURO, DS_COMPLEMENTO_NUMERO, DS_PONTO_REFERENCIA, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_end_cliente, p_id_cliente, p_nr_logradouro, p_ds_complemento_numero, p_ds_ponto_referencia, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_end_cliente;
/

CREATE OR REPLACE PROCEDURE atualizar_end_cliente(
    p_id_end_cliente IN NUMBER,
    p_id_cliente IN NUMBER,
    p_nr_logradouro IN NUMBER,
    p_ds_complemento_numero IN VARCHAR2,
    p_ds_ponto_referencia IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_END_CLIENTE
    SET ID_CLIENTE = p_id_cliente,
        NR_LOGRADOURO = p_nr_logradouro,
        DS_COMPLEMENTO_NUMERO = p_ds_complemento_numero,
        DS_PONTO_REFERENCIA = p_ds_ponto_referencia,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_END_CLIENTE = p_id_end_cliente;
    COMMIT; 
END atualizar_end_cliente;
/

CREATE OR REPLACE PROCEDURE excluir_end_cliente(
    p_id_end_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_END_CLIENTE
    WHERE ID_END_CLIENTE = p_id_end_cliente;
    COMMIT;
END excluir_end_cliente;
/


-- Procedures T_MDCT_CONT_CLIENTE


CREATE OR REPLACE PROCEDURE inserir_cont_cliente(
    p_id_contato IN NUMBER,
    p_id_cliente IN NUMBER,
    p_nr_ddi IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nr_telefone IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_CONT_CLIENTE (ID_CONTATO, ID_CLIENTE, NR_DDI, NR_DDD, NR_TELEFONE, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_contato, p_id_cliente, p_nr_ddi, p_nr_ddd, p_nr_telefone, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_cont_cliente;
/

CREATE OR REPLACE PROCEDURE atualizar_cont_cliente(
    p_id_contato IN NUMBER,
    p_id_cliente IN NUMBER,
    p_nr_ddi IN NUMBER,
    p_nr_ddd IN NUMBER,
    p_nr_telefone IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_CONT_CLIENTE
    SET NR_DDI = p_nr_ddi,
        NR_DDD = p_nr_ddd,
        NR_TELEFONE = p_nr_telefone,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_CONTATO = p_id_contato AND ID_CLIENTE = p_id_cliente;
    COMMIT; 
END atualizar_cont_cliente;
/

CREATE OR REPLACE PROCEDURE excluir_cont_cliente(
    p_id_contato IN NUMBER,
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_CONT_CLIENTE
    WHERE ID_CONTATO = p_id_contato AND ID_CLIENTE = p_id_cliente;
    COMMIT;
END excluir_cont_cliente;
/


-- Procedures T_MDCT_EMAIL_CLIENTE


CREATE OR REPLACE PROCEDURE inserir_email_cliente(
    p_id_email IN NUMBER,
    p_id_cliente IN NUMBER,
    p_ds_email IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_EMAIL_CLIENTE (ID_EMAIL, ID_CLIENTE, DS_EMAIL, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_email, p_id_cliente, p_ds_email, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_email_cliente;
/

CREATE OR REPLACE PROCEDURE atualizar_email_cliente(
    p_id_email IN NUMBER,
    p_id_cliente IN NUMBER,
    p_ds_email IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_EMAIL_CLIENTE
    SET DS_EMAIL = p_ds_email,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_EMAIL = p_id_email AND ID_CLIENTE = p_id_cliente;
    COMMIT; 
END atualizar_email_cliente;
/

CREATE OR REPLACE PROCEDURE excluir_email_cliente(
    p_id_email IN NUMBER,
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_EMAIL_CLIENTE
    WHERE ID_EMAIL = p_id_email AND ID_CLIENTE = p_id_cliente;
    COMMIT;
END excluir_email_cliente;
/


-- Procedures T_MDCT_PRODUTO

CREATE OR REPLACE PROCEDURE inserir_produto(
    p_id_produto IN NUMBER,
    p_nm_produto IN VARCHAR2,
    p_ds_produto IN VARCHAR2,
    p_qt_estoque IN NUMBER,
    p_ct_produto IN VARCHAR2,
    p_vl_produto IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_PRODUTO (ID_PRODUTO, NM_PRODUTO, DS_PRODUTO, QT_ESTOQUE, CT_PRODUTO, VL_PRODUTO, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_produto, p_nm_produto, p_ds_produto, p_qt_estoque, p_ct_produto, p_vl_produto, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_produto;
/


CREATE OR REPLACE PROCEDURE atualizar_produto(
    p_id_produto IN NUMBER,
    p_nm_produto IN VARCHAR2,
    p_ds_produto IN VARCHAR2,
    p_qt_estoque IN NUMBER,
    p_ct_produto IN VARCHAR2,
    p_vl_produto IN NUMBER,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_PRODUTO
    SET NM_PRODUTO = p_nm_produto,
        DS_PRODUTO = p_ds_produto,
        QT_ESTOQUE = p_qt_estoque,
        CT_PRODUTO = p_ct_produto,
        VL_PRODUTO = p_vl_produto,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_PRODUTO = p_id_produto;
    COMMIT; 
END atualizar_produto;
/


CREATE OR REPLACE PROCEDURE excluir_produto(
    p_id_produto IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_PRODUTO
    WHERE ID_PRODUTO = p_id_produto;
    COMMIT;
END excluir_produto;
/

-- Procedures T_MDCT_COMPRA

CREATE OR REPLACE PROCEDURE inserir_compra(
    p_id_compra IN NUMBER,
    p_id_cliente IN NUMBER,
    p_id_produto IN NUMBER,
    p_qt_compra IN NUMBER,
    p_vl_compra IN NUMBER,
    p_end_entrega IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_COMPRA (ID_COMPRA, ID_CLIENTE, ID_PRODUTO, QT_COMPRA, VL_COMPRA, END_ENTREGA, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_compra, p_id_cliente, p_id_produto, p_qt_compra, p_vl_compra, p_end_entrega, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_compra;
/

CREATE OR REPLACE PROCEDURE atualizar_compra(
    p_id_compra IN NUMBER,
    p_id_cliente IN NUMBER,
    p_id_produto IN NUMBER,
    p_qt_compra IN NUMBER,
    p_vl_compra IN NUMBER,
    p_end_entrega IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_COMPRA
    SET ID_CLIENTE = p_id_cliente,
        ID_PRODUTO = p_id_produto,
        QT_COMPRA = p_qt_compra,
        VL_COMPRA = p_vl_compra,
        END_ENTREGA = p_end_entrega,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_COMPRA = p_id_compra;
    COMMIT; 
END atualizar_compra;
/


CREATE OR REPLACE PROCEDURE excluir_compra(
    p_id_compra IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_COMPRA
    WHERE ID_COMPRA = p_id_compra;
    COMMIT;
END excluir_compra;
/


-- Procedures T_MDCT_FORMA_PAGT


CREATE OR REPLACE PROCEDURE inserir_forma_pagt(
    p_id_forma_pagt IN NUMBER,
    p_id_produto IN NUMBER,
    p_nm_forma_pagto IN VARCHAR2,
    p_ds_forma_pagto IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_MDCT_FORMA_PAGT (ID_FORMA_PAGT, ID_PRODUTO, NM_FORMA_PAGTO, DS_FORMA_PAGTO, DT_CADASTRO, NM_USUARIO)
    VALUES (p_id_forma_pagt, p_id_produto, p_nm_forma_pagto, p_ds_forma_pagto, SYSDATE, p_nm_usuario);
    COMMIT; 
END inserir_forma_pagt;
/

CREATE OR REPLACE PROCEDURE atualizar_forma_pagt(
    p_id_forma_pagt IN NUMBER,
    p_id_produto IN NUMBER,
    p_nm_forma_pagto IN VARCHAR2,
    p_ds_forma_pagto IN VARCHAR2,
    p_nm_usuario IN VARCHAR2
) AS
BEGIN
    UPDATE T_MDCT_FORMA_PAGT
    SET ID_PRODUTO = p_id_produto,
        NM_FORMA_PAGTO = p_nm_forma_pagto,
        DS_FORMA_PAGTO = p_ds_forma_pagto,
        DT_CADASTRO = SYSDATE,
        NM_USUARIO = p_nm_usuario
    WHERE ID_FORMA_PAGT = p_id_forma_pagt;
    COMMIT; 
END atualizar_forma_pagt;
/

CREATE OR REPLACE PROCEDURE excluir_forma_pagt(
    p_id_forma_pagt IN NUMBER
) AS
BEGIN
    DELETE FROM T_MDCT_FORMA_PAGT
    WHERE ID_FORMA_PAGT = p_id_forma_pagt;
    COMMIT;
END excluir_forma_pagt;
/