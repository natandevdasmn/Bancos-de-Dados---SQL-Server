CREATE DATABASE Atividade_08012024
GO
USE Atividade_08012024

-- Criando tabela tbl_Cliente
CREATE TABLE tbl_Cliente (
	id_cliente				SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	nome_cliente			VARCHAR(70)	 NOT NULL,
	sobrenome_cliente		VARCHAR(140) NOT NULL,
	cpf_cliente				INT			 NOT NULL,
	datanasc_cliente		DATE		 NOT NULL,
	data_expiracao			DATE		 NULL,
	data_cadastro			DATE		 NULL,
	data_ultimaatulizacao	DATE		 NULL
)

-- Criando tabela tbl_CategoriaProduto
CREATE TABLE tbl_CategoriaProduto (
	id_categoriaproduto		SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	nome_categoria			VARCHAR(100) NOT NULL
)

-- Criando tabela tbl_Produto
CREATE TABLE tbl_Produto (
	id_produto				SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	id_categoriaproduto		SMALLINT	 NOT NULL FOREIGN KEY REFERENCES tbl_CategoriaProduto (id_CategoriaProduto),
	nome_produto			VARCHAR(100) NOT NULL,
	preco_unitario			MONEY		 NOT NULL,
	quantidade_estoque		DECIMAL		 NOT NULL,
	data_cadastro			DATE		 NOT NULL,
	data_ultimaalteracao	DATE		 NULL
)

-- Criando tabela tbl_Tabela_Preco
CREATE TABLE tbl_Tabela_Preco (
	id_tabelapreco			SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	id_produto				SMALLINT	 NOT NULL FOREIGN KEY REFERENCES tbl_Produto(id_produto),
	valor_venda				MONEY		 NOT NULL,
	data_expiracao_valor	DATE		 NULL, -- campo a ser inserido pela trigger
	data_cadastro			DATE		 NOT NULL,
	data_ultimaalteracao	DATE		 NULL

)

-- Criando tabela tbl_Itens_Compra
CREATE TABLE tbl_Itens_Compra (
	id_itenscompra			SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	id_cliente				SMALLINT	 NOT NULL FOREIGN KEY REFERENCES tbl_Cliente(id_cliente),
	id_produto				SMALLINT	 NOT NULL FOREIGN KEY REFERENCES tbl_Produto(id_produto),
	quantidade				DECIMAL		 NOT NULL,
	valor_total				MONEY		 NULL, -- campo a ser inserido pela trigger
	data_compra				DATE		 NOT NULL,
	data_cadastro			DATE		 NOT NULL,
	data_ultimaalteracao	DATE		 NULL
)

-- Criando tabela 
CREATE TABLE tbl_Faturamento_Venda (
	id_faturamentovenda		SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	id_itenscompra			SMALLINT	 NULL FOREIGN KEY REFERENCES tbl_Itens_Compra (id_itenscompra), -- campo a ser inserido pela trigger
	valor_lucro				MONEY		 NULL -- campo a ser inserido pela trigger
)

GO

----------------------------------------------------------------------------------------------------------
------------------------------------- Criando PROCEUDREs -------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- Procedure para inser��o de dados para tabela tbl_Cliente
CREATE OR ALTER PROC sp_InserirCliente (
	@nome_cliente				VARCHAR(70),
	@sobrenome_cliente			VARCHAR(140),
	@cpf_cliente				INT,
	@datanasc_cliente			DATE
)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir novo cliente
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirCliente 'Jos�', 'Silva', 123452, '20000101' -- SELECT * FROM tbl_Cliente
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se n�o existe um cliente cadastrado com o mesmo CPF
		IF NOT EXISTS (SELECT cpf_cliente FROM tbl_Cliente WHERE cpf_cliente = @cpf_cliente) 
			BEGIN
				-- Inserindo o novo cliente
				INSERT INTO tbl_Cliente (nome_cliente, sobrenome_cliente, cpf_cliente, datanasc_cliente, data_cadastro, data_expiracao)
						VALUES (@nome_cliente, @sobrenome_cliente, @cpf_cliente, @datanasc_cliente, GETDATE(), DATEADD(YEAR, 1, GETDATE()))
				-- Retornando que a inser��o foi realizada com sucesso
				RETURN 0
			END
		-- Verificando se n�o existe um cliente cadastrado com o mesmo CPF
		ELSE
			BEGIN
				-- Retornando que a inser��o n�o foi realizada, pois j� existe um cliente cadastrado com o CPF informado
				RETURN 1
			END
	END
GO

-- Procedure para inser��o de dados para tabela tbl_CategoriaProduto
CREATE OR ALTER PROC sp_InserirCategoriaProduto (
	@nome_categoria				VARCHAR(100)
)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir nova categoria de produto
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirCategoriaProduto 'Aliment�cio' -- SELECT * FROM tbl_CategoriaProduto
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se j� n�o existe alguma categoria de produto cadastrado com mesmo nome
		IF NOT EXISTS (SELECT nome_categoria FROM tbl_CategoriaProduto WHERE nome_categoria = @nome_categoria) 
			BEGIN
				-- Inserindo o novo produto
				INSERT INTO tbl_CategoriaProduto (nome_categoria)
						VALUES (@nome_categoria)
				-- Retornando que a inser��o foi realizada com sucesso
				RETURN 0
			END
		-- Verificando se j� n�o existe alguma categoria de produto cadastrado com mesmo nome
		ELSE
			BEGIN
				-- Retornando que a inser��o n�o foi realizada, pois j� existe uma categoria produto cadastrada com o mesmo nome
				RETURN 1
			END
	END
GO

-- Procedure para inser��o de dados para tabela tbl_Produto
CREATE OR ALTER PROC sp_InserirDadosProduto (
	@id_categoriaproduto		SMALLINT,
	@nome_produto				VARCHAR(100),
	@preco_unitario				MONEY,
	@quantidade_estoque			DECIMAL
)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir novo produto
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirDadosProduto 1, 'Feij�o Tio Jo�o 1kg', 8.00, 10 -- SELECT * FROM tbl_Produto
						SELECT	@resultado
	*/
	-- Verificando se j� n�o existe algum produto cadastrado com mesmo nome
	BEGIN
		-- Verificando se j� n�o existe algum produto cadastrado com mesmo nome
		IF NOT EXISTS (SELECT nome_produto FROM tbl_Produto WHERE nome_produto = @nome_produto) 
			-- Verificando se o pre�o inserindo � maior que 0
			IF @preco_unitario >= 0
				-- Verificando se quantidade de estoque inserida � maior que 0
				IF @quantidade_estoque >= 0
					BEGIN
						-- Inserindo o novo produto
						INSERT INTO tbl_Produto (id_categoriaproduto, nome_produto, preco_unitario, quantidade_estoque, data_cadastro)
							 VALUES (@id_categoriaproduto, @nome_produto, @preco_unitario, @quantidade_estoque, getdate()) -- criar trigger oara inserl�ai data_ultimaalteracao
						-- Retornando que a inser��o foi realizada com sucesso
						RETURN 0
					END
				-- Verificando se quantidade de estoque inserida � maior que 0
				ELSE
					BEGIN
						-- Retornando que a inser��o n�o foi realizada, pois a quantidade inserida � abaixo de 0
						RETURN 3
					END
			-- Verificando se o pre�o inserindo � maior que 0
			ELSE
				BEGIN
					-- Retornando que a inser��o n�o foi realizada, pois o pre�o inserido � abaixo de 0
					RETURN 2
				END
		-- Verificando se j� n�o existe algum produto cadastrado com mesmo nome
		ELSE
			BEGIN
				-- Retornando que a inser��o n�o foi realizada, pois j� existe um produto cadastrado com o mesmo nome
				RETURN 1
			END
	END
GO

-- Procedure para inser��o de dados para tabela tbl_Tabela_Preco
CREATE OR ALTER PROC sp_InserirPreco (
	@id_produto					SMALLINT,
	@valor_venda				MONEY
)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir novo preco
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirPreco  -- SELECT * FROM tbl_Tabela_Preco
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se o produto informado est� cadastrado no banco de dados
		IF EXISTS (SELECT id_produto FROM tbl_Produto WHERE id_produto = @id_produto)
			-- Verificando se o pre�o n�o j� foi cadastrado anteriormente
			IF NOT EXISTS (SELECT id_produto FROM tbl_Tabela_Preco WHERE id_produto = @id_produto AND valor_venda = @valor_venda)
				BEGIN
					-- Inserindo o novo produto
					INSERT INTO tbl_Tabela_Preco (id_produto, valor_venda)
							VALUES (@id_produto, @valor_venda) -- criar trigger oara inser�ao data_ultimaalteracao
					-- Retornando que a inser��o foi realizada com sucesso
					RETURN 0
				END
			-- Verificando se o pre�o n�o j� foi cadastrado anteriormente
			ELSE
				BEGIN
					-- Retornando que o valor da venda para o produto j� foi cadastrado 
					RETURN 2
				END
		-- Verificando se o produto informado est� cadastrado no banco de dados
		ELSE
			BEGIN
				-- Retornando que a inser��o n�o foi realizada, pois j� existe um produto cadastrado com o mesmo nome
				RETURN 1
			END
	END
GO

-- Procedure para inser��o de dados para tabela tbl_Itens_Compra
CREATE OR ALTER PROC sp_InserirItensCompra (
	@id_cliente					SMALLINT,
	@id_produto					SMALLINT,
	@quantidade					DECIMAL,
	@data_cadastro				DATE,
	@data_compra				DATE
)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir itens da compra
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirItensCompra 'Aliment�cio' -- SELECT * FROM tbl_Itens_Compra
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se o cliente informado existe
		IF EXISTS (SELECT id_cliente FROM tbl_Cliente WHERE id_cliente = @id_cliente)
			-- Verificando se o produto informado existe
			IF EXISTS (SELECT id_produto FROM tbl_Produto WHERE id_produto = @id_produto) 
				-- Verificando se a quantidade inserida � maior que 0
				IF @quantidade >= 0
					-- Verificando se data da compra � menor do que a data atual
					IF @data_compra <= GETDATE()
						BEGIN
							-- Inserindo o novo produto
							INSERT INTO tbl_Itens_Compra (id_cliente, id_produto, quantidade, data_cadastro, data_compra)
									VALUES (@id_cliente, @id_produto, @quantidade, GETDATE(), @data_compra)
							-- Retornando que a inser��o foi realizada com sucesso
							RETURN 0
						END
					-- Verificando se data da compra � menor do que a data atual
					ELSE
						BEGIN
							-- Retornando que a inser��o n�o foi realizada, pois a data inserida � maior que a data atual
							RETURN 4
						END
				-- Verificando se a quantidade inserida � maior que 0
				ELSE
					BEGIN
						-- Retornando que a inser��o n�o foi realizada, pois a quantidade inserida � menor que 0
						RETURN 3
					END
			-- Verificando se o produto informado existe
			ELSE
				BEGIN
					-- Retornando que a inser��o n�o foi realizada, pois o produto informado n�o existe
					RETURN 2
				END
		-- Verificando se o cliente informado existe
		ELSE
			BEGIN
				-- Retornando que a inser��o n�o foi realizada, pois o cliente informado n�o existe
				RETURN 1
			END
	END
GO


----------------------------------------------------------------------------------------------------------
------------------------------------- Criando FUNCTIONs --------------------------------------------------
----------------------------------------------------------------------------------------------------------






----------------------------------------------------------------------------------------------------------
------------------------------------- Criando TRIGGERs ---------------------------------------------------
----------------------------------------------------------------------------------------------------------


