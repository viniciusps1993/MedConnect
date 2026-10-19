import cx_Oracle

# Conectar-se ao banco de dados
conn = cx_Oracle.connect(user='', password='', dsn="oracle.fiap.com.br/orcl")

# Criar um cursor
cur = conn.cursor()

# Definir os dados para inserção
dados_cliente = [
    (1, 'João', '123.456.789-01', '1234567-8', 'São Paulo', 'senha123', '01/01/1990', 'joao123'),
    (2, 'Maria', '987.654.321-09', '9876543-2', 'Rio de Janeiro', 'senha456', '02/02/1985', 'maria456'),
    (3, 'Pedro', '456.789.012-34', '4567890-1', 'Salvador', 'senha789', '03/03/1980', 'pedro789'),
    (4, 'Ana', '321.654.987-76', '3216549-0', 'Brasília', 'senha012', '04/04/1975', 'ana012'),
    (5, 'Carlos', '789.012.345-67', '7890123-4', 'Fortaleza', 'senha345', '05/05/1970', 'carlos345')
]

# Executar a procedure para cada conjunto de dados
for dados in dados_cliente:
    cur.callproc('inserir_cliente', dados)

# Commit para salvar as alterações
conn.commit()

# Fechar o cursor e a conexão
cur.close()
conn.close()

print("Inserções realizadas com sucesso.")
