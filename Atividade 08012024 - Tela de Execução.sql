------------------------------------------------------------------------------------------------------------
------------------------------- TELA DE EXECUÇÃO DA ATIVIDADE 08012024 -------------------------------------
------------------------------------------------------------------------------------------------------------

--------------------------------- EXECUÇÃO DAS PROCEDURES DE INSERT ----------------------------------------

-- Inserir novo cliente
EXEC sp_InserirCliente -- SELECT * FROM tbl_Cliente
@nome_cliente = 'José',
@sobrenome_cliente = 'Santos',
@cpf_cliente = 11223344,
@datanasc_cliente = '20010101'
GO

-- Inserir nova categoria do produto
EXEC sp_InserirCategoriaProduto -- SELECT * FROM tbl_CategoriaProduto
@nome_categoria = 'Alimentícios'
GO

-- Inserir novo produto
EXEC sp_InserirDadosProduto -- SELECT * FROM tbl_Produto -- TRUNCATE TABLE tbl_Produto
@id_categoriaproduto = 1,
@nome_produto = 'Carne Bovina Nobre',
@preco_unitario = 100,
@quantidade_estoque = 20
GO

-- Inserir preço do produto
EXEC sp_InserirPreco -- SELECT * FROM tbl_Tabela_Preco
@id_produto = 3,
@data_cadastro = '2024-01-01'
GO

-- Inserir novo registro na tabela tbl_Itens_Compra
EXEC sp_InserirItensCompra -- SELECT * FROM tbl_Itens_Compra
@id_cliente = 1,
@id_produto = 1,
@quantidade = 10,
@data_compra = '2024-01-09'
GO

-- SELECT * FROM tbl_Faturamento_Venda

