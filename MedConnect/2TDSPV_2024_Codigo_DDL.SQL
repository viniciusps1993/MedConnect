CREATE TABLE t_mdct_bairro (
    id_bairro       NUMBER(8) NOT NULL,
    id_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45) NOT NULL,
    nm_zona_bairro  VARCHAR2(20) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

ALTER TABLE t_mdct_bairro
    ADD CONSTRAINT chk_nm_zona_bairro CHECK ( nm_zona_bairro IN (
        'CENTRO',
        'ZONA LESTE',
        'ZONA NORTE',
        'ZONA OESTE',
        'ZONA SUL'
    ) );

COMMENT ON COLUMN t_mdct_bairro.id_bairro IS
    'Esta coluna ir� receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_mdct_bairro.id_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio e ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_mdct_bairro.nm_bairro IS
    'Esta coluna ir� receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_mdct_bairro.nm_zona_bairro IS
    'Esta coluna ir� receber a localiza��o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

COMMENT ON COLUMN t_mdct_bairro.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_mdct_bairro.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_mdct_bairro ADD CONSTRAINT pk_mdct_bairro PRIMARY KEY ( id_bairro );

CREATE TABLE t_mdct_cidade (
    id_cidade    NUMBER(8) NOT NULL,
    id_estado    NUMBER(2) NOT NULL,
    nm_cidade    VARCHAR2(60) NOT NULL,
    cd_ibge      NUMBER(8) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_cidade.id_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio e ser� preenchido automaticamente pelo sistema.

';

COMMENT ON COLUMN t_mdct_cidade.id_estado IS
    'Esta coluna ir� receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_mdct_cidade.nm_cidade IS
    'Esta coluna ir� receber o nome do Cidade pertencente ao Estado Brasileiro. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_mdct_cidade.cd_ibge IS
    'Esta coluna ir� receber o c�digo do IBGE que fornece informa��es para gera��o da NFe.';

COMMENT ON COLUMN t_mdct_cidade.nr_ddd IS
    'ESSE ATRIBUTO RECEBER� DADOS DO NUMERO DO DDD, SENDO OBRIGAT�RIO';

COMMENT ON COLUMN t_mdct_cidade.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_mdct_cidade.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_mdct_cidade ADD CONSTRAINT pk_mdct_cidade PRIMARY KEY ( id_cidade );

CREATE TABLE t_mdct_cliente (
    id_cliente     NUMBER(8) NOT NULL,
    nm_cliente     VARCHAR2(80) NOT NULL,
    nr_cpf         NUMBER(12) NOT NULL,
    nm_rg          VARCHAR2(15),
    lg_cliente     VARCHAR2(10) NOT NULL,
    sh_cliente     VARCHAR2(10) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    dt_cadastro    DATE NOT NULL,
    nm_usuario     VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_cliente.id_cliente IS
    'Esse atributo contem o id do cliente ';

COMMENT ON COLUMN t_mdct_cliente.nm_cliente IS
    'Esse atributo receber�  o nome  do cliente, seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_cliente.nr_cpf IS
    'Esse atributo ir� receber o n�mero do  CPF cliente.  Seu conte�do � obrigat�rio e ser� validado de acordo com regras de neg�cio.';

COMMENT ON COLUMN t_mdct_cliente.nm_rg IS
    'Esse atributo ir� receber o n�mero do  RG  cliente.  Seu conte�do � obrigat�rio e ser� validado de acordo com regras de neg�cio.';

COMMENT ON COLUMN t_mdct_cliente.lg_cliente IS
    'Esse atributo recebera o Login do cliente, o seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_cliente.sh_cliente IS
    'Esse atributo recebera  a senha  do cliente, o seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_cliente.dt_nascimento IS
    'Esse atributo ir� receber a data de nascimento do  cliente.  Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mdct_cliente.dt_cadastro IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE A DATA DE CADASTRO DA TABELA, SENDO OBRIGATORIO';

COMMENT ON COLUMN t_mdct_cliente.nm_usuario IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE O NOME DO USU�RIO QUE REALIZOU O CADASTRO NA TABELA';

ALTER TABLE t_mdct_cliente ADD CONSTRAINT pk_mdct_cliente PRIMARY KEY ( id_cliente );

CREATE TABLE t_mdct_compra (
    id_compra    NUMBER(8) NOT NULL,
    id_cliente   NUMBER(8) NOT NULL,
    id_produto   NUMBER(8) NOT NULL,
    qt_compra    NUMBER(4) NOT NULL,
    vl_compra    NUMBER(4, 2) NOT NULL,
    end_entrega  VARCHAR2(100),
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_compra.id_compra IS
    'Esse atributo cont�m o id da compra';

COMMENT ON COLUMN t_mdct_compra.qt_compra IS
    'Esse atributo ira receber a quantidade de produtos comprados. ';

COMMENT ON COLUMN t_mdct_compra.vl_compra IS
    'Esse atributo recebe o valor da compra, seu conte�do � obrigatorio. ';

COMMENT ON COLUMN t_mdct_compra.end_entrega IS
    'Esse atributo ira receber o endere�o de entrega da compra, seu conte�do � opcional. ';

COMMENT ON COLUMN t_mdct_compra.dt_cadastro IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE A DATA DE CADASTRO DA TABELA, SENDO OBRIGATORIO';

COMMENT ON COLUMN t_mdct_compra.nm_usuario IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE O NOME DO USU�RIO QUE REALIZOU O CADASTRO NA TABELA';

ALTER TABLE t_mdct_compra ADD CONSTRAINT pk_mdct_compra PRIMARY KEY ( id_compra );

CREATE TABLE t_mdct_cont_cliente (
    id_contato   NUMBER(9) NOT NULL,
    id_cliente   NUMBER(8) NOT NULL,
    nr_ddi       NUMBER(3),
    nr_ddd       NUMBER(3),
    nr_telefone  NUMBER(10),
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_cont_cliente.id_contato IS
    'Esse atributo ir� receber a chave prim�ria do contato do cliente.';

COMMENT ON COLUMN t_mdct_cont_cliente.nr_ddi IS
    'Este atributo ir� receber o n�mero do DDI do telefone do contato do cliente. Seu conteudo � opcional.';

COMMENT ON COLUMN t_mdct_cont_cliente.nr_ddd IS
    'Este atributo ir� receber o n�mero do DDD  do telefone do cliente do paciente. Seu conteudo � opcional.';

COMMENT ON COLUMN t_mdct_cont_cliente.nr_telefone IS
    'Este atributo ir� receber o n�mero do telefone do contato do cliente. Seu conteudo � opcional.';

COMMENT ON COLUMN t_mdct_cont_cliente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_mdct_cont_cliente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_mdct_cont_cliente ADD CONSTRAINT pk_mdct_clientev1 PRIMARY KEY ( id_contato,
                                                                               id_cliente );

CREATE TABLE t_mdct_email_cliente (
    id_email     NUMBER(8) NOT NULL,
    id_cliente   NUMBER(8) NOT NULL,
    ds_email     VARCHAR2(80) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_email_cliente.id_email IS
    'Esse atributo cont�m o id do email do cliente';

COMMENT ON COLUMN t_mdct_email_cliente.ds_email IS
    'Esse atributo cont�m a descri��o do email. ';

COMMENT ON COLUMN t_mdct_email_cliente.dt_cadastro IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE A DATA DE CADASTRO DA TABELA, SENDO OBRIGATORIO';

COMMENT ON COLUMN t_mdct_email_cliente.nm_usuario IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE O NOME DO USU�RIO QUE REALIZOU O CADASTRO NA TABELA';

ALTER TABLE t_mdct_email_cliente ADD CONSTRAINT pk_mdct_email PRIMARY KEY ( id_email,
                                                                            id_cliente );

CREATE TABLE t_mdct_end_cliente (
    id_end_cliente         NUMBER(8) NOT NULL,
    id_cliente             NUMBER(8) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_cadastro            DATE NOT NULL,
    nm_usuario             VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_end_cliente.id_end_cliente IS
    'Esse atributo cont�m o id do endere�o do cliente';

COMMENT ON COLUMN t_mdct_end_cliente.nr_logradouro IS
    'Esse atributo ir� receber o n�mero do logradouro do endereco do cliente.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_mdct_end_cliente.ds_complemento_numero IS
    'Esse atributo ir� receber o complemeneto  do logradouro do endereco do cliente caso ele exista. Seu conte�do � opcional.';

COMMENT ON COLUMN t_mdct_end_cliente.ds_ponto_referencia IS
    'Esse atributo ir� receber o ponto de refer�ncia  do logradouro do endereco do cliente.  Seu conte�do � opcional.';

COMMENT ON COLUMN t_mdct_end_cliente.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_mdct_end_cliente.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_mdct_end_cliente ADD CONSTRAINT pk_mdct_end_cliente PRIMARY KEY ( id_end_cliente );

CREATE TABLE t_mdct_estado (
    id_estado    NUMBER(2) NOT NULL,
    sg_estado    CHAR(2) NOT NULL,
    nm_estado    VARCHAR2(30) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_estado.id_estado IS
    'Esta coluna ir� receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_mdct_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN t_mdct_estado.nm_estado IS
    'Esta coluna ir� receber o nome do estado. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_mdct_estado.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_mdct_estado.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_mdct_estado ADD CONSTRAINT pk_mdct_estado PRIMARY KEY ( id_estado );

CREATE TABLE t_mdct_forma_pagt (
    id_forma_pagt   NUMBER(8) NOT NULL,
    id_produto      NUMBER(8) NOT NULL,
    nm_forma_pagto  VARCHAR2(80) NOT NULL,
    ds_forma_pagto  VARCHAR2(80) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_forma_pagt.id_forma_pagt IS
    'Esse atributo contem o id da forma de pagamento';

COMMENT ON COLUMN t_mdct_forma_pagt.nm_forma_pagto IS
    'Esse conte�do recebe o nome da forma de pagamento, seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_forma_pagt.ds_forma_pagto IS
    'Esse atributo recebe a descri��o da forma de pagamento, seu conte�do � opcional. ';

COMMENT ON COLUMN t_mdct_forma_pagt.dt_cadastro IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE A DATA DE CADASTRO DA TABELA, SENDO OBRIGATORIO';

COMMENT ON COLUMN t_mdct_forma_pagt.nm_usuario IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE O NOME DO USU�RIO QUE REALIZOU O CADASTRO NA TABELA';

ALTER TABLE t_mdct_forma_pagt ADD CONSTRAINT pk_mdct_forma_pagt PRIMARY KEY ( id_forma_pagt );

CREATE TABLE t_mdct_logradouro (
    id_logradouro   NUMBER(10) NOT NULL,
    id_end_cliente  NUMBER(8) NOT NULL,
    id_bairro       NUMBER(8) NOT NULL,
    nm_logradouro   VARCHAR2(100) NOT NULL,
    nr_cep          NUMBER(8) NOT NULL,
    dt_cadastro     DATE NOT NULL,
    nm_usuario      VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_logradouro.id_logradouro IS
    'Esta coluna ir� receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte�do � obrigat�rio e �nico ser� preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_mdct_logradouro.nm_logradouro IS
    'Esta coluna ir� receber o nome do lograoduro. O padr�o de armazenmento �  InitCap e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_mdct_logradouro.nr_cep IS
    'Esta coluna ir� receber o n�mero do CEP do lograoduro. O padr�o de armazenmento �  num�rico  e seu conte�do � obrigat�rio. Essa tabela j� ser� preenchida pela �rea respons�vel. Novas inse��es necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_mdct_logradouro.dt_cadastro IS
    'esse atributo receber� informa��es sobre a data de cadastro da tabela, sendo obrigatorio
';

COMMENT ON COLUMN t_mdct_logradouro.nm_usuario IS
    'esse atributo receber� informa��es sobre o nome do usu�rio que realizou o cadastro na tabela, sendo obrigat�rio, contendo 30 caracteres';

ALTER TABLE t_mdct_logradouro ADD CONSTRAINT pk_mdct_logradouro PRIMARY KEY ( id_logradouro );

CREATE TABLE t_mdct_produto (
    id_produto   NUMBER(8) NOT NULL,
    nm_produto   VARCHAR2(80) NOT NULL,
    ds_produto   VARCHAR2(100) NOT NULL,
    qt_estoque   NUMBER(10) NOT NULL,
    ct_produto   VARCHAR2(80) NOT NULL,
    vl_produto   NUMBER(6) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    nm_usuario   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_mdct_produto.id_produto IS
    'Esse atributo contem o id do produto ';

COMMENT ON COLUMN t_mdct_produto.nm_produto IS
    'Esse conte�do cont�m o nome do produto, o seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_produto.ds_produto IS
    'Esse atributo recebe a descri��o do produto, o seu conte�do � obrigat�rio ';

COMMENT ON COLUMN t_mdct_produto.qt_estoque IS
    'Esse item cont�m a quantidade do produto em estoque, seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_produto.ct_produto IS
    'Esse atributo recebe informa��es sobre a categoria do produto. ';

COMMENT ON COLUMN t_mdct_produto.vl_produto IS
    'Esse atributo recebe o valor do produto, o seu conte�do � obrigat�rio. ';

COMMENT ON COLUMN t_mdct_produto.dt_cadastro IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE A DATA DE CADASTRO DA TABELA, SENDO OBRIGATORIO';

COMMENT ON COLUMN t_mdct_produto.nm_usuario IS
    'ESSE ATRIBUTO RECEBER� INFORMA��ES SOBRE O NOME DO USU�RIO QUE REALIZOU O CADASTRO NA TABELA';

ALTER TABLE t_mdct_produto ADD CONSTRAINT pk_mdct_produto PRIMARY KEY ( id_produto );

ALTER TABLE t_mdct_logradouro
    ADD CONSTRAINT fk_mdct_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES t_mdct_bairro ( id_bairro );

ALTER TABLE t_mdct_bairro
    ADD CONSTRAINT fk_mdct_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES t_mdct_cidade ( id_cidade );

ALTER TABLE t_mdct_compra
    ADD CONSTRAINT fk_mdct_cliente_compra FOREIGN KEY ( id_cliente )
        REFERENCES t_mdct_cliente ( id_cliente );

ALTER TABLE t_mdct_cont_cliente
    ADD CONSTRAINT fk_mdct_cliente_cont FOREIGN KEY ( id_cliente )
        REFERENCES t_mdct_cliente ( id_cliente );

ALTER TABLE t_mdct_email_cliente
    ADD CONSTRAINT fk_mdct_cliente_email FOREIGN KEY ( id_cliente )
        REFERENCES t_mdct_cliente ( id_cliente );

ALTER TABLE t_mdct_end_cliente
    ADD CONSTRAINT fk_mdct_cliente_end FOREIGN KEY ( id_cliente )
        REFERENCES t_mdct_cliente ( id_cliente );

ALTER TABLE t_mdct_logradouro
    ADD CONSTRAINT fk_mdct_end_log FOREIGN KEY ( id_end_cliente )
        REFERENCES t_mdct_end_cliente ( id_end_cliente );

ALTER TABLE t_mdct_cidade
    ADD CONSTRAINT fk_mdct_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES t_mdct_estado ( id_estado );

ALTER TABLE t_mdct_compra
    ADD CONSTRAINT fk_mdct_prod_compra FOREIGN KEY ( id_produto )
        REFERENCES t_mdct_produto ( id_produto );

ALTER TABLE t_mdct_forma_pagt
    ADD CONSTRAINT fk_mdct_prod_pag FOREIGN KEY ( id_produto )
        REFERENCES t_mdct_produto ( id_produto );



-- Relat�rio do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

--ESTADO