CREATE DATABASE Atividade_08012024
GO
USE Atividade_08012024
GO

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
	valor_venda				MONEY		 NULL,
	data_expiracao_valor	DATE		 NULL, -- campo a ser inserido pela trigger
	data_cadastro			DATE		 NULL,
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

-- Criando tabela tbl_Faturamento_Venda
CREATE TABLE tbl_Faturamento_Venda (
	id_faturamentovenda		SMALLINT	 NOT NULL PRIMARY KEY IDENTITY,
	id_itenscompra			SMALLINT	 NULL FOREIGN KEY REFERENCES tbl_Itens_Compra (id_itenscompra), -- campo a ser inserido pela trigger
	valor_lucro				MONEY		 NULL -- campo a ser inserido pela trigger
)

GO

----------------------------------------------------------------------------------------------------------
------------------------------------- Criando PROCEUDREs -------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- Procedure para inserção de dados para tabela tbl_Cliente
CREATE OR ALTER PROC sp_InserirCliente (
	@nome_cliente				VARCHAR(70),
	@sobrenome_cliente			VARCHAR(140),
	@cpf_cliente				INT,
	@datanasc_cliente			DATE
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir novo cliente
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirCliente 'José', 'Silva', 123452, '20000101' -- SELECT * FROM tbl_Cliente
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se não existe um cliente cadastrado com o mesmo CPF
		IF NOT EXISTS (SELECT cpf_cliente FROM tbl_Cliente WHERE cpf_cliente = @cpf_cliente) 
			BEGIN
				-- Inserindo o novo cliente
				INSERT INTO tbl_Cliente (nome_cliente, sobrenome_cliente, cpf_cliente, datanasc_cliente, data_cadastro, data_expiracao)
						VALUES (@nome_cliente, @sobrenome_cliente, @cpf_cliente, @datanasc_cliente, GETDATE(), DATEADD(YEAR, 1, GETDATE()))
				-- Retornando que a inserção foi realizada com sucesso
				RETURN 0
			END
		-- Verificando se não existe um cliente cadastrado com o mesmo CPF
		ELSE
			BEGIN
				-- Retornando que a inserção não foi realizada, pois já existe um cliente cadastrado com o CPF informado
				RETURN 1
			END
	END
GO

-- Procedure para inserção de dados para tabela tbl_CategoriaProduto
CREATE OR ALTER PROC sp_InserirCategoriaProduto (
	@nome_categoria				VARCHAR(100)
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir nova categoria de produto
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirCategoriaProduto 'Alimentício' -- SELECT * FROM tbl_CategoriaProduto
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se já não existe alguma categoria de produto cadastrado com mesmo nome
		IF NOT EXISTS (SELECT nome_categoria FROM tbl_CategoriaProduto WHERE nome_categoria = @nome_categoria) 
			BEGIN
				-- Inserindo o novo produto
				INSERT INTO tbl_CategoriaProduto (nome_categoria)
						VALUES (@nome_categoria)
				-- Retornando que a inserção foi realizada com sucesso
				RETURN 0
			END
		-- Verificando se já não existe alguma categoria de produto cadastrado com mesmo nome
		ELSE
			BEGIN
				-- Retornando que a inserção não foi realizada, pois já existe uma categoria produto cadastrada com o mesmo nome
				RETURN 1
			END
	END
GO  

-- Procedure para inserção de dados para tabela tbl_Produto
CREATE OR ALTER PROC sp_InserirDadosProduto (
	@id_categoriaproduto		SMALLINT,
	@nome_produto				VARCHAR(100),
	@preco_unitario				MONEY,
	@quantidade_estoque			DECIMAL
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir novo produto
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirDadosProduto 1, 'Feijão Tio João 1kg', 8.00, 10 -- SELECT * FROM tbl_Produto
						SELECT	@resultado
	*/
	-- Verificando se já não existe algum produto cadastrado com mesmo nome
	BEGIN
		-- Verificando se já não existe algum produto cadastrado com mesmo nome
		IF NOT EXISTS (SELECT nome_produto FROM tbl_Produto WHERE nome_produto = @nome_produto) 
			-- Verificando se o preço inserindo é maior que 0
			IF @preco_unitario >= 0
				-- Verificando se quantidade de estoque inserida é maior que 0
				IF @quantidade_estoque >= 0
					BEGIN
						-- Inserindo o novo produto
						INSERT INTO tbl_Produto (id_categoriaproduto, nome_produto, preco_unitario, quantidade_estoque, data_cadastro)
							 VALUES (@id_categoriaproduto, @nome_produto, @preco_unitario, @quantidade_estoque, getdate()) -- criar trigger oara inserlçai data_ultimaalteracao
						-- Retornando que a inserção foi realizada com sucesso
						RETURN 0
					END
				-- Verificando se quantidade de estoque inserida é maior que 0
				ELSE
					BEGIN
						-- Retornando que a inserção não foi realizada, pois a quantidade inserida é abaixo de 0
						RETURN 3
					END
			-- Verificando se o preço inserindo é maior que 0
			ELSE
				BEGIN
					-- Retornando que a inserção não foi realizada, pois o preço inserido é abaixo de 0
					RETURN 2
				END
		-- Verificando se já não existe algum produto cadastrado com mesmo nome
		ELSE
			BEGIN
				-- Retornando que a inserção não foi realizada, pois já existe um produto cadastrado com o mesmo nome
				RETURN 1
			END
	END
GO

-- Procedure para inserção de dados para tabela tbl_Tabela_Preco
CREATE OR ALTER PROC sp_InserirPreco (
	@id_produto					SMALLINT,
	@data_cadastro				DATE
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir novo preco
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirPreco  -- SELECT * FROM tbl_Tabela_Preco
						SELECT	@resultado
	*/
	BEGIN
		-- Verificando se o produto informado está cadastrado no banco de dados
		IF EXISTS (SELECT id_produto FROM tbl_Produto WHERE id_produto = @id_produto)
			-- Verificando se o preço não já foi cadastrado anteriormente
			BEGIN
				-- Inserindo o novo produto
				INSERT INTO tbl_Tabela_Preco (id_produto, data_cadastro, data_expiracao_valor)
						VALUES (@id_produto, @data_cadastro, GETDATE()) -- criar trigger oara inserçao data_ultimaalteracao
				-- Retornando que a inserção foi realizada com sucesso
				RETURN 0
			END
		-- Verificando se o produto informado está cadastrado no banco de dados
		ELSE
			BEGIN
				-- Retornando que a inserção não foi realizada, pois já existe um produto cadastrado com o mesmo nome
				RETURN 1
			END
	END
GO

-- Procedure para inserção de dados para tabela tbl_Itens_Compra
CREATE OR ALTER PROC sp_InserirItensCompra (
	@id_cliente					SMALLINT,
	@id_produto					SMALLINT,
	@quantidade					DECIMAL,
	@data_compra				DATE
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Inserir itens da compra
	Autor.............: SMN - Natanael
	Data..............: 08/01/2024
	Ex................: DECLARE @resultado	 TINYINT
						EXEC	@resultado = sp_InserirItensCompra 1, 1, 1, '2024-01-01' -- SELECT * FROM tbl_Itens_Compra
						SELECT	@resultado
	*/
	
	BEGIN
		-- Verificando se o cliente informado existe
		IF EXISTS (SELECT id_cliente FROM tbl_Cliente WHERE id_cliente = @id_cliente)
			-- Verificando se o produto informado existe
			IF EXISTS (SELECT id_produto FROM tbl_Produto WHERE id_produto = @id_produto) 
				-- Verificando se a quantidade inserida é maior que 0
				IF @quantidade >= 0
					-- Verificando se data da compra é menor do que a data atual
					IF @data_compra <= GETDATE()
						BEGIN
							-- Inserindo o novo produto
							INSERT INTO tbl_Itens_Compra (id_cliente, id_produto, quantidade, data_cadastro, data_compra)
									VALUES (@id_cliente, @id_produto, @quantidade, GETDATE(), @data_compra)
							-- Retornando que a inserção foi realizada com sucesso
							RETURN 0
						END
					-- Verificando se data da compra é menor do que a data atual
					ELSE
						BEGIN
							-- Retornando que a inserção não foi realizada, pois a data inserida é maior que a data atual
							RETURN 4
						END
				-- Verificando se a quantidade inserida é maior que 0
				ELSE
					BEGIN
						-- Retornando que a inserção não foi realizada, pois a quantidade inserida é menor que 0
						RETURN 3
					END
			-- Verificando se o produto informado existe
			ELSE
				BEGIN
					-- Retornando que a inserção não foi realizada, pois o produto informado não existe
					RETURN 2
				END
		-- Verificando se o cliente informado existe
		ELSE
			BEGIN
				-- Retornando que a inserção não foi realizada, pois o cliente informado não existe
				RETURN 1
			END
	END
GO


----------------------------------------------------------------------------------------------------------
------------------------------------- Criando FUNCTIONs --------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- Function para calcular o acrescimo de  50% no preço unitário no produto de acordo com id
CREATE OR ALTER FUNCTION fnc_AcrescentarPrecoUnitario (
	@id_produto SMALLINT -- TIPO DE PREMIAÇÃO
	)
	RETURNS MONEY
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Realizar o acrescimo de 50% sobre o valor unitário do produto 
	Autor.............: SMN - Natanael
	Data..............: 09/01/2024
	Ex................: SELECT dbo.fnc_AcrescentarPrecoUnitario (1)
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @ValorTotal		MONEY,
				@ValorAntigo	MONEY

		-- Atribuindo o valor da variável @ValorAntigo
		SET @ValorAntigo = (SELECT preco_unitario FROM tbl_Produto WHERE id_produto = (SELECT id_produto FROM tbl_Produto WHERE id_produto = @id_produto))
		
		-- Atribuindo o valor da variável @ValorTotal
		SET @ValorTotal = @ValorAntigo + (@ValorAntigo * 0.5)

		-- Retornando o valor da variável @ValorTotal
		RETURN @ValorTotal
	END
GO

-- Function para gerar o valor faturado e valor do lucro da id_venda informada 
CREATE OR ALTER FUNCTION fnc_FaturarValorVenda (
	@id_itenvenda SMALLINT -- TIPO DE PREMIAÇÃO
	)
	RETURNS MONEY
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Gerar o valor faturado e valor do lucro da id_venda informada
	Autor.............: SMN - Natanael
	Data..............: 09/01/2024
	Ex................: SELECT dbo.fnc_FaturarValorVenda (1)
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @ValorTotal		MONEY,
				@ValorVenda		MONEY,
				@PrecoUnitario	MONEY,
				@Quantidade		INT

		-- Atribuindo o valor da variável @ValorAntigo
		SET @ValorVenda = (SELECT valor_total FROM tbl_Itens_Compra WHERE id_itenscompra = @id_itenvenda)

		-- 
		SET @Quantidade = (SELECT quantidade FROM tbl_Itens_Compra WHERE id_itenscompra = @id_itenvenda)

		--
		SET @PrecoUnitario = (SELECT preco_unitario FROM tbl_Produto AS P INNER JOIN tbl_Itens_Compra AS IC ON IC.id_produto = P.id_produto WHERE IC.id_itenscompra = @id_itenvenda)
		
		-- Atribuindo o valor da variável @ValorTotal
		SET @ValorTotal = (@ValorVenda - @PrecoUnitario) * @Quantidade

		-- Retornando o valor da variável @ValorTotal
		RETURN @ValorTotal
	END
GO

-- Function para gerar o valor total da venda
CREATE OR ALTER FUNCTION fnc_CalcularValorTotalVenda (
	@id_itensvenda		SMALLINT)
	RETURNS MONEY
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_08012024.sql
	Objetivo..........: Gerar o valor faturado e valor do lucro da id_venda informada
	Autor.............: SMN - Natanael
	Data..............: 09/01/2024
	Ex................: SELECT dbo.fnc_CalcularValorTotalVenda (1)
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @ValorTotal		MONEY,
				@ValorVenda		MONEY,
				@Quantidade		INT

		-- Atribuindo o valor da variável @ValorAntigo
		SET @ValorVenda = (SELECT valor_venda FROM tbl_Tabela_Preco WHERE id_produto = (SELECT id_produto FROM tbl_Itens_Compra WHERE id_itenscompra = @id_itensvenda))
		
		-- Atribuindo o valor da variável @Quantidade
		SET @Quantidade = (SELECT quantidade FROM tbl_Itens_Compra WHERE id_itenscompra = (SELECT id_itenscompra FROM tbl_Itens_Compra WHERE id_itenscompra = @id_itensvenda))
		
		-- Atribuindo o valor da variável @ValorTotal
		SET @ValorTotal = @ValorVenda * @Quantidade

		-- Retornando o valor da variável @ValorTotal
		RETURN @ValorTotal
	END
GO
----------------------------------------------------------------------------------------------------------
------------------------------------- Criando TRIGGERs ---------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- Trigger para inserir o valor para venda do produto com o acréscimo de 50% e a data de expiração 1 ano após a data de cadastro
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirAcrescimoeDataExpiracao]
	ON [dbo].[tbl_Tabela_Preco]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_09012024.sql
	Objetivo..........: inserir o valor para venda do produto com o acréscimo de 50% e a data de expiração 1 ano após a data de cadastro
	Autor.............: SMN - Natanael
	Data..............: 09/01/2024
	Ex................: 
	*/

	BEGIN
	-- Declarando variáveis
	DECLARE @id_produtoI			SMALLINT,
			@id_preco_vendaI		SMALLINT,
			@valor_atualizadoI		MONEY,
			@data_expiracao_valorI	DATE

	-- Inserindo valor da variável @id_produto
	SELECT @id_produtoI = id_produto
		FROM inserted

	-- Inserindo valor da variável @id_preco_venda
	SELECT @id_preco_vendaI = id_tabelapreco
		FROM inserted

	-- Inserindo valor da variável @data_expiracao_valor
	SELECT @data_expiracao_valorI = data_expiracao_valor
		FROM inserted

	-- Inserindo valor da variável @valor_atualizado
	SELECT @valor_atualizadoI = (SELECT dbo.fnc_AcrescentarPrecoUnitario (@id_produtoI))

	--Atualizando a data de expiração e o valor da venda na tabela tbl_Tabela_Preco
	BEGIN		
		UPDATE tbl_Tabela_Preco
			SET data_expiracao_valor = DATEADD(year, 1, @data_expiracao_valorI), valor_venda = @valor_atualizadoI
				WHERE  id_tabelapreco = @id_preco_vendaI
	END
	END
GO

-- Trigger para inserir o valor do lucro na tabela tbl_Faturamento_Venda
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirValorLucro]
	ON [dbo].[tbl_Itens_Compra]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_09012024.sql
	Objetivo..........: inserir o valor do lucro na tabela tbl_Faturamento_Venda
	Autor.............: SMN - Natanael
	Data..............: 09/01/2024
	Ex................: 
	*/

	BEGIN
	-- Declarando variáveis
	DECLARE @id_itenscompra			SMALLINT,
			@valor_atualizado		MONEY

	-- Inserindo valor da variável @id_produto
	SET @id_itenscompra = (SELECT TOP 1 id_itenscompra FROM tbl_Itens_Compra)

	-- Inserindo valor da variável @valor_atualizado
	SELECT @valor_atualizado = (SELECT dbo.fnc_FaturarValorVenda (@id_itenscompra))

	-- Inserindo um novo faturamento na tabela tbl_Faturamento_Venda
	BEGIN
		INSERT INTO tbl_Faturamento_Venda (id_itenscompra, valor_lucro)
		VALUES (@id_itenscompra, @valor_atualizado)
	END
	
	END
GO

-- Trigger para inserir o valor total da venda na tbl_Itens_Compra
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirValorTotalCompra]
	ON [dbo].[tbl_Itens_Compra]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_09012024.sql
	Objetivo..........: inserir o valor total da venda na tbl_Itens_Compra
	Autor.............: SMN - Natanael
	Data..............: 09/01/2024
	Ex................: 
	*/

	BEGIN
	-- Declarando variáveis
	DECLARE @id_itenscompraI		SMALLINT,
			@valor_atualizado		MONEY

	-- Inserindo valor da variável @id_produto
	SET @id_itenscompraI = (SELECT id_itenscompra FROM inserted)

	-- Inserindo valor da variável @valor_atualizado
	SELECT @valor_atualizado = (SELECT dbo.fnc_CalcularValorTotalVenda (@id_itenscompraI))

	-- Atualizando o valor total das vendas da tabela tbl_Itens_Compra
	BEGIN
		UPDATE tbl_Itens_Compra
			SET valor_total = @valor_atualizado
				WHERE id_itenscompra = @id_itenscompraI
	END
	
	END
GO

----------------------------------------------------------------------------------------------------------
------------------------------------- Criando CONSULTAS --------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- 7. Selecione os produtos com valor para venda maior que R$ 100,00

SELECT PRO.nome_produto, PRE.valor_venda
	FROM tbl_Produto AS PRO
		INNER JOIN tbl_Tabela_Preco AS PRE
			ON PRE.id_produto = PRO.id_produto
				WHERE PRE.valor_venda >= 100
				
-- 8. Selecionar os produtos com maior estoque

SELECT nome_produto, quantidade_estoque 
	FROM tbl_Produto
		ORDER BY quantidade_estoque DESC

-- 9. Selecionar o valor total lucrado nos últimos 6 meses
SELECT FV.valor_lucro, IC.data_compra
	FROM tbl_Faturamento_Venda AS FV
		INNER JOIN tbl_Itens_Compra AS IC
			ON IC.id_itenscompra = FV.id_itenscompra
				WHERE IC.data_compra BETWEEN DATEADD(month, -6, GETDATE()) AND GETDATE()

-- 10. Selecionar os clientes que realizaram mais compras em menos de um ano

SELECT C.nome_cliente, IC.data_compra
	FROM tbl_Itens_Compra AS IC
		INNER JOIN tbl_Cliente AS C
			ON C.id_cliente = IC.id_cliente
				WHERE IC.data_compra BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()