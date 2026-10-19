--1°

--Essa consulta busca o nome do cliente, nome do produto, data da última compra desse produto feita pelo cliente,
--o número total de compras desse produto feitas pelo cliente e o total gasto pelo cliente nesse produto.
--Os resultados são agrupados pelo nome do cliente e do produto e ordenados primeiro pelo nome do cliente e depois pelo nome do produto. 


SELECT C.NM_CLIENTE,
       P.NM_PRODUTO,
       MAX(CP.DT_CADASTRO) AS ULTIMA_COMPRA,
       COUNT(*) AS NUMERO_COMPRAS,
       SUM(CP.VL_COMPRA) AS TOTAL_GASTO
FROM T_MDCT_COMPRA CP
JOIN T_MDCT_CLIENTE C ON CP.ID_CLIENTE = C.ID_CLIENTE
JOIN T_MDCT_PRODUTO P ON CP.ID_PRODUTO = P.ID_PRODUTO
GROUP BY C.NM_CLIENTE, P.NM_PRODUTO
ORDER BY C.NM_CLIENTE, P.NM_PRODUTO;


--2°

--Essa consulta irá mostrar o nome do cliente, o número do CPF, o número total de compras realizadas por cada cliente e a média de valor das compras. 


DECLARE
    CURSOR CLIENTE_CURSOR IS
        SELECT
            C.NM_CLIENTE,
            C.NR_CPF,
            COUNT(CP.ID_COMPRA) AS NUMERO_COMPRAS,
            AVG(CP.VL_COMPRA) AS MEDIA_VALOR_COMPRA
        FROM
            T_MDCT_CLIENTE C
        LEFT JOIN
            T_MDCT_COMPRA CP ON C.ID_CLIENTE = CP.ID_CLIENTE
        GROUP BY
            C.NM_CLIENTE, C.NR_CPF
        ORDER BY
            C.NM_CLIENTE;

    V_NM_CLIENTE    T_MDCT_CLIENTE.NM_CLIENTE%TYPE;
    V_NR_CPF        T_MDCT_CLIENTE.NR_CPF%TYPE;
    V_NUM_COMPRAS   NUMBER;
    V_MEDIA_VALOR   NUMBER;
BEGIN
    OPEN CLIENTE_CURSOR;
    LOOP
        FETCH CLIENTE_CURSOR INTO V_NM_CLIENTE, V_NR_CPF, V_NUM_COMPRAS, V_MEDIA_VALOR;
        EXIT WHEN CLIENTE_CURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome do Cliente: ' || V_NM_CLIENTE);
        DBMS_OUTPUT.PUT_LINE('Número do CPF: ' || V_NR_CPF);
        DBMS_OUTPUT.PUT_LINE('Número de Compras: ' || V_NUM_COMPRAS);
        DBMS_OUTPUT.PUT_LINE('Média de Valor das Compras: ' || V_MEDIA_VALOR);
        DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    END LOOP;
    CLOSE CLIENTE_CURSOR;
END;
/

--3°

--Este bloco declara um cursor que seleciona informações específicas de um cliente e seu endereço associado, com base no ID do cliente fornecido.
--OBS. Feita a correão do bloco conforme o feedback da entrega anterior. 

DECLARE
    CURSOR CLIENTE_CURSOR IS
        SELECT
            C.NM_CLIENTE,
            C.NR_CPF,
            C.NM_RG,
            C.LG_CLIENTE,
            C.SH_CLIENTE,
            C.DT_NASCIMENTO,
            EC.NR_LOGRADOURO,
            EC.DS_COMPLEMENTO_NUMERO,
            EC.DS_PONTO_REFERENCIA
        FROM
            T_MDCT_CLIENTE C
        INNER JOIN
            T_MDCT_END_CLIENTE EC ON C.ID_CLIENTE = EC.ID_CLIENTE
        WHERE
            C.ID_CLIENTE = 5000; -- ID DO CLIENTE 

    V_NM_CLIENTE            T_MDCT_CLIENTE.NM_CLIENTE%TYPE;
    V_NR_CPF                T_MDCT_CLIENTE.NR_CPF%TYPE;
    V_NM_RG                 T_MDCT_CLIENTE.NM_RG%TYPE;
    V_LG_CLIENTE            T_MDCT_CLIENTE.LG_CLIENTE%TYPE;
    V_SH_CLIENTE            T_MDCT_CLIENTE.SH_CLIENTE%TYPE;
    V_DT_NASCIMENTO         T_MDCT_CLIENTE.DT_NASCIMENTO%TYPE;
    V_NR_LOGRADOURO         T_MDCT_END_CLIENTE.NR_LOGRADOURO%TYPE;
    V_DS_COMPLEMENTO_NUMERO T_MDCT_END_CLIENTE.DS_COMPLEMENTO_NUMERO%TYPE;
    V_DS_PONTO_REFERENCIA   T_MDCT_END_CLIENTE.DS_PONTO_REFERENCIA%TYPE;
BEGIN
    OPEN CLIENTE_CURSOR;
    FETCH CLIENTE_CURSOR INTO
        V_NM_CLIENTE,
        V_NR_CPF,
        V_NM_RG,
        V_LG_CLIENTE,
        V_SH_CLIENTE,
        V_DT_NASCIMENTO,
        V_NR_LOGRADOURO,
        V_DS_COMPLEMENTO_NUMERO,
        V_DS_PONTO_REFERENCIA;
    CLOSE CLIENTE_CURSOR;

    -- Exibir os dados
    DBMS_OUTPUT.PUT_LINE('Nome do Cliente: ' || V_NM_CLIENTE);
    DBMS_OUTPUT.PUT_LINE('Número do CPF: ' || V_NR_CPF);
    DBMS_OUTPUT.PUT_LINE('Número do RG: ' || V_NM_RG);
    DBMS_OUTPUT.PUT_LINE('Logradouro: ' || V_NR_LOGRADOURO);
    DBMS_OUTPUT.PUT_LINE('Complemento/Número: ' || V_DS_COMPLEMENTO_NUMERO);
    DBMS_OUTPUT.PUT_LINE('Ponto de Referência: ' || V_DS_PONTO_REFERENCIA);
END;
/