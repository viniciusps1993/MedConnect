--1° A Procedure listar_compras_cliente recebe o ID de um cliente como entrada e lista todas as compras associadas a esse cliente com o endereço de entrega. 

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
    listar_compras_cliente(5000);
END;
/
