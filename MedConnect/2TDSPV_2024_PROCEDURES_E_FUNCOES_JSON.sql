SET SERVEROUTPUT ON

--Procedure
--O procedimento relatorio_valores_id_produto exibe para cada ID_FORMA_PAGT o ID_PRODUTO atual, o valor da linha anterior e o valor da próxima linha, substituindo valores ausentes por "Vazio".

CREATE OR REPLACE PROCEDURE relatorio_valores_id_produto IS
    CURSOR cur_dados IS
        SELECT ID_FORMA_PAGT, ID_PRODUTO
        FROM T_MDCT_FORMA_PAGT
        ORDER BY ID_FORMA_PAGT;

    v_id_forma_pagt_atual T_MDCT_FORMA_PAGT.ID_FORMA_PAGT%TYPE;
    v_id_produto_atual T_MDCT_FORMA_PAGT.ID_PRODUTO%TYPE;
    v_id_produto_anterior T_MDCT_FORMA_PAGT.ID_PRODUTO%TYPE;
    v_id_produto_proximo T_MDCT_FORMA_PAGT.ID_PRODUTO%TYPE;
BEGIN
    FOR rec IN cur_dados LOOP
        v_id_forma_pagt_atual := rec.ID_FORMA_PAGT;
        v_id_produto_atual := rec.ID_PRODUTO;
        v_id_produto_anterior := NULL;
        v_id_produto_proximo := NULL;

        BEGIN
            SELECT ID_PRODUTO
            INTO v_id_produto_anterior
            FROM T_MDCT_FORMA_PAGT
            WHERE ID_FORMA_PAGT = (
                SELECT MAX(ID_FORMA_PAGT)
                FROM T_MDCT_FORMA_PAGT
                WHERE ID_FORMA_PAGT < v_id_forma_pagt_atual
            );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_produto_anterior := NULL;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erro ao buscar valor anterior: ' || SQLERRM);
        END;

        BEGIN
            SELECT ID_PRODUTO
            INTO v_id_produto_proximo
            FROM T_MDCT_FORMA_PAGT
            WHERE ID_FORMA_PAGT = (
                SELECT MIN(ID_FORMA_PAGT)
                FROM T_MDCT_FORMA_PAGT
                WHERE ID_FORMA_PAGT > v_id_forma_pagt_atual
            );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_produto_proximo := NULL;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erro ao buscar valor próximo: ' || SQLERRM);
        END;

        DBMS_OUTPUT.PUT_LINE(
            v_id_forma_pagt_atual || ' ' ||
            NVL(TO_CHAR(v_id_produto_anterior), 'Vazio') || ' ' ||
            TO_CHAR(v_id_produto_atual) || ' ' ||
            NVL(TO_CHAR(v_id_produto_proximo), 'Vazio')
        );
    END LOOP;
END relatorio_valores_id_produto;
/

-- Testar o procedimento relatorio_valores_id_produto
BEGIN
    relatorio_valores_id_produto;
END;
/

--Function
--Para transformar os dados da tabela T_MDCT_CLIENTE de formato relacional para JSON:

CREATE OR REPLACE FUNCTION transformar_para_json(p_id_cliente IN NUMBER) RETURN CLOB IS
    v_json CLOB := '{ "compras": [';
BEGIN
    FOR compra_rec IN (
        SELECT
            C.NM_CLIENTE,
            CP.ID_COMPRA,
            CP.QT_COMPRA,
            CP.VL_COMPRA,
            CP.END_ENTREGA
        FROM
            T_MDCT_CLIENTE C
        INNER JOIN
            T_MDCT_COMPRA CP ON C.ID_CLIENTE = CP.ID_CLIENTE
        WHERE
            C.ID_CLIENTE = p_id_cliente
        ORDER BY
            C.NM_CLIENTE
    ) LOOP
        v_json := v_json || '{"cliente": "' || compra_rec.NM_CLIENTE || '", ' ||
                  '"id_compra": ' || compra_rec.ID_COMPRA || ', ' ||
                  '"quantidade": ' || compra_rec.QT_COMPRA || ', ' ||
                  '"valor": ' || compra_rec.VL_COMPRA || ', ' ||
                  '"endereco_entrega": "' || compra_rec.END_ENTREGA || '"}, ';
    END LOOP;

    v_json := RTRIM(v_json, ', ') || ']}';

    RETURN v_json;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '{"error": "Cliente não encontrado ou não possui compras."}';
    WHEN VALUE_ERROR THEN
        RETURN '{"error": "Valor inválido fornecido."}';
    WHEN TOO_MANY_ROWS THEN
        RETURN '{"error": "A consulta retornou mais de um resultado inesperadamente."}';
    WHEN OTHERS THEN
        RETURN '{"error": "Erro desconhecido: ' || SQLERRM || '"}';
END transformar_para_json;
/

--Procedure
--Para Gerar e Exibir a função transformar_para_json

CREATE OR REPLACE PROCEDURE DETALHES_COMPRAS_CLIENTE_JSON(
    p_id_cliente IN NUMBER
) IS
    v_json CLOB;
BEGIN
    v_json := transformar_para_json(p_id_cliente);

    DBMS_OUTPUT.PUT_LINE(v_json);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro desconhecido: ' || SQLERRM);
END DETALHES_COMPRAS_CLIENTE_JSON;
/

--Exibição da procedure transformar_para_json

DECLARE
    v_json CLOB;
BEGIN
    v_json := transformar_para_json(5040); -- ID do Cliente 5040
    DBMS_OUTPUT.PUT_LINE(v_json);
END;
/

--Function
--A função relatorio_valores_vl_produtos gera um JSON com os valores de ID_PRODUTO e VL_PRODUTO da tabela T_MDCT_PRODUTO, formatado como um array de objetos.

CREATE OR REPLACE FUNCTION relatorio_valores_vl_produtos RETURN CLOB IS
    CURSOR cur_dados IS
        SELECT ID_PRODUTO, VL_PRODUTO
        FROM T_MDCT_PRODUTO
        ORDER BY ID_PRODUTO;

    v_json CLOB := '{ "produtos": [';
    v_first BOOLEAN := TRUE;
    v_id_produto T_MDCT_PRODUTO.ID_PRODUTO%TYPE;
    v_valor T_MDCT_PRODUTO.VL_PRODUTO%TYPE;
BEGIN
    FOR rec IN cur_dados LOOP
        IF NOT v_first THEN
            v_json := v_json || ', ';
        ELSE
            v_first := FALSE;
        END IF;

        v_id_produto := rec.ID_PRODUTO;
        v_valor := rec.VL_PRODUTO;

        v_json := v_json || '{' ||
                  '"id_produto": ' || v_id_produto || ', ' ||
                  '"valor": ' || v_valor ||
                  '}';
    END LOOP;

    v_json := v_json || ']}';

    RETURN v_json;

EXCEPTION
    WHEN OTHERS THEN
        RETURN '{"error": "Erro desconhecido: ' || SQLERRM || '"}';
END relatorio_valores_vl_produtos;

--Exibição da Função

DECLARE
    v_json CLOB;
BEGIN
    v_json := relatorio_valores_vl_produtos; 
    DBMS_OUTPUT.PUT_LINE(v_json); 
END;
/

--Procedure
--O procedimento listar_compras_cliente realiza a tarefa de buscar e formatar as informações de compras de um cliente específico em formato JSON. 

CREATE OR REPLACE PROCEDURE listar_compras_cliente(
    p_id_cliente IN NUMBER
) AS
    CURSOR compras_cursor IS
        SELECT
            C.NM_CLIENTE,
            CP.ID_COMPRA,
            CP.QT_COMPRA,
            CP.VL_COMPRA,
            CP.END_ENTREGA
        FROM
            T_MDCT_CLIENTE C
        INNER JOIN
            T_MDCT_COMPRA CP ON C.ID_CLIENTE = CP.ID_CLIENTE
        WHERE
            C.ID_CLIENTE = p_id_cliente;

    v_json CLOB := '{ "compras": [';
    v_first BOOLEAN := TRUE;
    v_nm_cliente           T_MDCT_CLIENTE.NM_CLIENTE%TYPE;
    v_id_compra            T_MDCT_COMPRA.ID_COMPRA%TYPE;
    v_qt_compra            T_MDCT_COMPRA.QT_COMPRA%TYPE;
    v_vl_compra            T_MDCT_COMPRA.VL_COMPRA%TYPE;
    v_end_entrega          T_MDCT_COMPRA.END_ENTREGA%TYPE;
BEGIN
    FOR rec IN compras_cursor LOOP
        IF NOT v_first THEN
            v_json := v_json || ', ';
        ELSE
            v_first := FALSE;
        END IF;

        v_nm_cliente := rec.NM_CLIENTE;
        v_id_compra := rec.ID_COMPRA;
        v_qt_compra := rec.QT_COMPRA;
        v_vl_compra := rec.VL_COMPRA;
        v_end_entrega := rec.END_ENTREGA;

        v_json := v_json || '{' ||
                  '"cliente": "' || v_nm_cliente || '", ' ||
                  '"id_compra": ' || v_id_compra || ', ' ||
                  '"quantidade": ' || v_qt_compra || ', ' ||
                  '"valor": ' || v_vl_compra || ', ' ||
                  '"endereco_entrega": "' || v_end_entrega || '"' ||
                  '}';
    END LOOP;

    v_json := v_json || ']}';

    DBMS_OUTPUT.PUT_LINE(v_json);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('{"error": "Erro desconhecido: ' || SQLERRM || '"}');
END listar_compras_cliente;
/

--EXECUÇÃO listar_compras_cliente

BEGIN
    listar_compras_cliente(5020); --Id do Cliente
END;
/

--Procedure
--A Procedure EXIBIR_EMAIL recebe o ID de um cliente e exibe o email do cliente cadastro no sistema. 

CREATE OR REPLACE PROCEDURE EXIBIR_EMAIL(
    p_id_cliente IN NUMBER
) AS
    CURSOR cliente_cursor IS
        SELECT
            C.NM_CLIENTE,
            C.ID_CLIENTE,
            EC.DS_EMAIL
        FROM
            T_MDCT_CLIENTE C
        LEFT JOIN
            T_MDCT_EMAIL_CLIENTE EC ON C.ID_CLIENTE = EC.ID_CLIENTE
        WHERE
            C.ID_CLIENTE = p_id_cliente
        ORDER BY
            C.ID_CLIENTE;

    v_json CLOB := '{ "clientes": [';
    v_first BOOLEAN := TRUE;
    v_nm_cliente T_MDCT_CLIENTE.NM_CLIENTE%TYPE;
    v_id_cliente T_MDCT_CLIENTE.ID_CLIENTE%TYPE;
    v_email T_MDCT_EMAIL_CLIENTE.DS_EMAIL%TYPE;
BEGIN
    FOR rec IN cliente_cursor LOOP
        IF NOT v_first THEN
            v_json := v_json || ', ';
        ELSE
            v_first := FALSE;
        END IF;

        v_nm_cliente := rec.NM_CLIENTE;
        v_id_cliente := rec.ID_CLIENTE;
        v_email := rec.DS_EMAIL;

        v_json := v_json || '{' ||
                  '"cliente": "' || v_nm_cliente || '", ' ||
                  '"id_cliente": ' || v_id_cliente || ', ' ||
                  '"email": "' || NVL(v_email, 'Nenhum email cadastrado') || '"' ||
                  '}';
    END LOOP;

    v_json := v_json || ']}';

    DBMS_OUTPUT.PUT_LINE(v_json);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('{"error": "Erro desconhecido: ' || SQLERRM || '"}');
END EXIBIR_EMAIL;
/

--EXECUÇÃO EXIBIR_EMAIL

BEGIN
    EXIBIR_EMAIL(5020); --Id do Cliente
END;
/

