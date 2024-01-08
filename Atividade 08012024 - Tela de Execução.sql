------------------------------------------------------------------------------------------------------------
------------------------------- TELA DE EXECUÇÃO DA ATIVIDADE 08012024 -------------------------------------
------------------------------------------------------------------------------------------------------------

--------------------------------- EXECUÇÃO DAS PROCEDURES DE INSERT ----------------------------------------

-- Inserir novo cliente
EXEC sp_InserirCliente
@nome_cliente = '',
@sobrenome_cliente = '',
@cpf_cliente = 0,
@datanasc_cliente = '20010101'
GO

-- Inserir nova categoria do produto
EXEC sp_InserirCategoriaProduto
@nome_categoria = ''
GO

-- Inserir novo produto
EXEC sp_InserirDadosProduto
@id_categoriaproduto = 0,
@nome_produto = '',
@preco_unitario = 0,
@quantidade_estoque = 0
GO

-- 

-- Inserir novo registro na tabela tbl_Tabela_Preco
EXEC sp_InserirItensCompra
@id_cliente = 0,
@id_produto = 0,
@quantidade = 0,
@data_compra = ''
GO
