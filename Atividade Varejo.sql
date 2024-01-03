CREATE DATABASE Atividade_Varejo
GO
USE Atividade_Varejo
GO

-- Criando tabela Tipo de Equipamento
CREATE TABLE tbl_TipoEquipamento (
	id_tipo_equi				INT NOT NULL PRIMARY KEY IDENTITY,
	nome_tipo					VARCHAR(100) NOT NULL
	);

-- Criando tabela Equipamento
CREATE TABLE tbl_Equipamento (
	id_equipamento				INT NOT NULL PRIMARY KEY IDENTITY,
	id_tipo_equi				INT NOT NULL FOREIGN KEY REFERENCES tbl_TipoEquipamento(id_tipo_equi),
	nome_equipamento			VARCHAR(100) NOT NULL,
	preco_atual_equi			MONEY NOT NULL,
	);

-- Criando tablea cliente
CREATE TABLE tbl_Cliente (
	id_cliente					INT NOT NULL PRIMARY KEY IDENTITY,
	nome_cliente				VARCHAR(100) NOT NULL,
	cpf_cliente					INT NOT NULL,
	data_nasc_cliente			DATE NOT NULL
	);

-- Criando tabela venda
CREATE TABLE tbl_Venda (
	id_venda					INT NOT NULL PRIMARY KEY IDENTITY,
	id_cliente					INT NOT NULL FOREIGN KEY REFERENCES tbl_Cliente(id_cliente),
	id_equipamento				INT NOT NULL FOREIGN KEY REFERENCES tbl_Equipamento(id_equipamento),
	indice_pagamento			BIT NULL,
	quantidade					INT NOT NULL,
	valor_total					MONEY NULL
	);

-- Criando tabela Status do Pagamento da Venda
CREATE TABLE tbl_StatusVendaPagamento (
	id_status_venda_pag			INT NOT NULL PRIMARY KEY IDENTITY,
	nome_status_venda			VARCHAR(100) NOT NULL
	);

-- Criando tabela Venda Pagamento
CREATE TABLE tbl_VendaPagamento (
	id_venda_pagamento			INT NOT NULL PRIMARY KEY IDENTITY,
	id_venda					INT NOT NULL FOREIGN KEY REFERENCES tbl_Venda(id_venda),
	id_status_venda_pag			INT NOT NULL FOREIGN KEY REFERENCES tbl_StatusVendaPagamento(id_status_venda_pag)
	);

-- Inserindo dados na tabela tipo equipamento
INSERT INTO tbl_TipoEquipamento (nome_tipo)
	VALUES
		('Informática'),
		('Telefonia'),
		('Eletrodoméstico'),
		('Automotivo'),
		('Brinquedo')

-- Inserindo dados na tabela Equipamento
INSERT INTO tbl_StatusVendaPagamento (nome_status_venda)
	VALUES
		('Em processamento'),
		('Pago'),
		('Pagamento negado'),
		('Pagamento cancelado')
GO

-- Procedure para inserção de dados na tabela tbl_Equipamento
CREATE OR ALTER PROC sp_InserirEquipamento (
	@IdTipEqui			INT,
	@NomeEqui			VARCHAR(50),
	@PrecoEqui			MONEY
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Inserir equipamento
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_InserirEquipamento 1,'COMPUTADOR', 100.00
	*/
	BEGIN
		INSERT INTO tbl_Equipamento (id_tipo_equi, nome_equipamento, preco_atual_equi)
			VALUES (@IdTipEqui, @NomeEqui, @PrecoEqui)
	END
GO

-- Procedure para inserção de dados na tabela tbl_Cliente
CREATE OR ALTER PROC sp_InserirCliente (
	@NomeCliente		VARCHAR(100),
	@Cpf				INT,
	@DataNasc			DATE
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Inserir cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_InserirCliente 'CAYO', 1316956557, '20000302'
	*/
	BEGIN
		INSERT INTO tbl_Cliente (nome_cliente, cpf_cliente, data_nasc_cliente)
			VALUES (@NomeCliente, @Cpf, @DataNasc)
	END
GO

-- Procedure para inserção de dados na tabela tbl_Venda
CREATE OR ALTER PROC sp_InserirVenda (
	@IdCliente		VARCHAR(100),
	@IdEquipamento	INT,
	@IndPag			BIT,
	@Quant			INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Inserir venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_InserirVenda 1,3,0,10
	*/
	BEGIN
		INSERT INTO tbl_Venda (id_cliente, id_equipamento, indice_pagamento, quantidade)
			VALUES (@IdCliente, @IdEquipamento, @IndPag, @Quant)
	END
GO

-- Procedure para consultar Equipamento
CREATE OR ALTER PROC sp_ConsultarEquipamento (
	@IdEquipamento	INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Consultar equipamento
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_ConsultarEquipamento
	*/
	BEGIN
		IF EXISTS (SELECT id_Equipamento FROM tbl_Equipamento WHERE id_equipamento = @IdEquipamento)
			BEGIN
				SELECT *
					FROM tbl_Equipamento
						WHERE id_equipamento = @IdEquipamento
			END
		ELSE
			PRINT 'Infelizmente, o ID de equipamento fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para consultar Cliente
CREATE OR ALTER PROC sp_ConsultarCliente (
	@IdCliente		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Consultar cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_ConsultarCliente
	*/
	BEGIN
		IF EXISTS (SELECT id_Cliente FROM tbl_Cliente WHERE id_cliente = @IdCliente)
			BEGIN
				SELECT *
					FROM tbl_Cliente
						WHERE id_cliente = @IdCliente
			END
		ELSE
			PRINT 'Infelizmente, o ID de cliente fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para consultar Venda
CREATE OR ALTER PROC sp_ConsultarVenda (
	@IdVenda		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Consultar venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_ConsultarVenda
	*/
	BEGIN
		IF EXISTS (SELECT id_Venda FROM tbl_Venda WHERE id_venda = @IdVenda)
			BEGIN
				SELECT *
					FROM tbl_Venda
						WHERE id_venda = @IdVenda
			END
		ELSE
			PRINT 'Infelizmente, o ID de venda fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para atualizar Equipamento
CREATE OR ALTER PROC sp_AtualizarEquipamento (
	@IdEquipamento	INT,
	@TipoEqui		INT,
	@NomeEqui		VARCHAR(100),
	@PrecoEqui		MONEY
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Atualizar equipamento
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_AtualizarEquipamento
	*/
	BEGIN
		IF EXISTS (SELECT id_equipamento FROM tbl_Equipamento WHERE id_equipamento = @IdEquipamento)
			BEGIN
				UPDATE tbl_Equipamento
					SET id_tipo_equi = @TipoEqui, nome_equipamento = @NomeEqui, preco_atual_equi = @PrecoEqui
						WHERE id_equipamento = @IdEquipamento
			END
		ELSE
			PRINT 'Infelizmente, o ID de equipamento fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para atualizar Cliente
CREATE OR ALTER PROC sp_AtualizarCliente (
	@IdCliente		INT,
	@NomeCliente	VARCHAR(100),
	@CpfCliente		INT,
	@DataNasc		DATE
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Atualizar Cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_AtualizarCliente
	*/
	BEGIN
		IF EXISTS (SELECT id_cliente FROM tbl_Cliente WHERE id_cliente = @IdCliente)
			BEGIN
				UPDATE tbl_Cliente
					SET nome_cliente = @NomeCliente, cpf_cliente = @CpfCliente, data_nasc_cliente = @DataNasc
						WHERE id_cliente = @IdCliente
			END
		ELSE
			PRINT 'Infelizmente, o ID de cliente fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para atualizar Venda
CREATE OR ALTER PROC sp_AtualizarVenda (
	@IdVenda		INT,
	@IdCliente		INT,
	@IdEquipamento	INT,
	@IndPagamento	BIT,
	@Quantidade		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Atualizar Venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_AtualizarVenda
	*/
	BEGIN
		IF EXISTS (SELECT id_venda FROM tbl_Venda WHERE id_venda = @IdVenda)
			BEGIN
				UPDATE tbl_Venda
					SET id_cliente = @IdCliente, id_equipamento = @IdEquipamento, indice_pagamento = @IndPagamento, quantidade = @Quantidade
						WHERE id_venda = @IdVenda
			END
		ELSE
			PRINT 'Infelizmente, o ID de cliente fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para exluir Equipamento
CREATE OR ALTER PROC sp_ExcluirEquipamento (
	@IdEquipamento		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Excluir Venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_ExcluirEquipamento
	*/
	BEGIN
		IF EXISTS (SELECT id_equipamento FROM tbl_Equipamento WHERE id_equipamento = @IdEquipamento)
			BEGIN
				DELETE FROM tbl_Venda
					WHERE id_equipamento = @IdEquipamento
				DELETE FROM tbl_Equipamento
					WHERE id_equipamento = @IdEquipamento
			END
		ELSE
			PRINT 'Infelizmente, o ID de Equipamento fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para exluir Cliente
CREATE OR ALTER PROC sp_ExcluirCliente (
	@IdCliente		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Excluir Cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_ExcluirCliente
	*/
	BEGIN
		IF EXISTS (SELECT id_cliente FROM tbl_Cliente WHERE id_cliente = @IdCliente)
			BEGIN
				DELETE FROM tbl_Venda
					WHERE id_cliente = @IdCliente
				DELETE FROM tbl_Cliente
					WHERE id_cliente = @IdCliente
			END
		ELSE
			PRINT 'Infelizmente, o ID de Cliente fornecido não existe. Por favor, informe outro'
	END
GO

-- Procedure para exluir Venda
CREATE OR ALTER PROC sp_ExcluirVenda (
	@IdVenda		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Excluir Venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: EXEC sp_ExcluirVenda
	*/
	BEGIN
		IF EXISTS (SELECT id_venda FROM tbl_Venda WHERE id_venda = @IdVenda)
			BEGIN
				DELETE FROM tbl_VendaPagamento
					WHERE id_venda = @IdVenda
				DELETE FROM tbl_Venda
					WHERE id_venda = @IdVenda
			END
		ELSE
			PRINT 'Infelizmente, o ID de Venda fornecido não existe. Por favor, informe outro'
	END
GO

-- Função responsável por calcular o valor total da venda
CREATE OR ALTER FUNCTION fnc_CalcularValorTotalVenda (
	@IdVenda		INT)
	RETURNS MONEY
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Calcular o valor total da venda Venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: SELECT DBO.fnc_CalcularValorTotalVenda (2)
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @ValorTotal MONEY,
				@PrecoEqui	MONEY,
				@QuantEqui	INT

		-- Atribuindo o valor da variável @QuantEqui
		SELECT @QuantEqui = V.quantidade, @PrecoEqui = E.preco_atual_equi 
			FROM tbl_Venda AS V 
				INNER JOIN tbl_Equipamento AS E
					ON V.id_equipamento = E.id_equipamento
						WHERE id_venda = @IdVenda

		-- Atribuindo o valor da variável @ValorTotal
		SELECT @ValorTotal = (@PrecoEqui * @QuantEqui)
		-- Retornando o valor da variável @ValorTotal
		RETURN @ValorTotal
	END
GO

SELECT * FROM tbl_Equipamento
SELECT * FROM tbl_Venda

-- Trigger para inserir o valor total da venda
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirValorTotalVenda]
	ON [dbo].[tbl_Venda]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Insere o valor total da venda
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 21/12/2023
	Ex................: 
	*/
	BEGIN
		-- Declarando
		DECLARE @ValorTotal		MONEY,
				@IdEquipamentoI	INT,
				@IdVendaI		INT
		SELECT @IdVendaI = id_venda FROM inserted
		SELECT @IdEquipamentoI = id_equipamento FROM inserted
			IF @IdVendaI IS NOT NULL 
				BEGIN
					SET @ValorTotal = (SELECT dbo.fnc_CalcularValorTotalVenda(@IdEquipamentoI))
					UPDATE tbl_Venda
						SET valor_total = @ValorTotal
							WHERE id_venda = @IdVendaI
				END
	END
GO

-- Trigger para inserir a venda na tabela vendas pagamentos e se o status ind_pag tiver 0, status pendente na tabela vendas pagamentos
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirVendaPendendte]
	ON [dbo].[tbl_Venda]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Insere na tabela vendas pagamentos a venda pendente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 02/01/2024
	Ex................: 
	*/
	BEGIN
	-- Declarando variáveis
	DECLARE @IdVendaI	INT,
			@IdStatus	INT,
			@IdPagI		BIT

	-- Inserindo valor da variável @IdVenda
	SELECT @IdVendaI = id_venda 
		FROM inserted

	-- Inserindo valor da viriável @IdPag
	SELECT @IdPagI = indice_pagamento 
		FROM inserted

		-- Validando o indíce de pagamento
		IF @IdPagI = 0 and @IdVendaI IS NOT NULL 

			-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN

				-- Inserindo informações
				INSERT INTO tbl_VendaPagamento (id_venda, id_status_venda_pag)
					VALUES (@IdVendaI, 1)
			END
		ELSE
		IF @IdPagI = 1 and @IdVendaI IS NOT NULL 
					-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN

				-- Inserindo informações
				INSERT INTO tbl_VendaPagamento (id_venda, id_status_venda_pag)
					VALUES (@IdVendaI, 2)
			END
	END
GO

-- Trigger para inserir a venda na tabela vendas pagamentos se o status ind_pag tiver 1, status pendente na tabela vendas pagamentos
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirVendaPendendte]
	ON [dbo].[tbl_Venda]
	AFTER UPDATE
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Varejo.sql
	Objetivo..........: Insere na tabela vendas pagamentos a venda paga
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 02/01/2024
	Ex................: 
	*/
	BEGIN
	-- Declarando variáveis
	DECLARE @IdVendaI	INT,
			@IdStatus	INT,
			@IdPagI		BIT,
			@IdVendaD	INT

	-- Inserindo valor da variável @IdVenda
	SELECT @IdVendaI = id_venda 
		FROM inserted

	-- Inserindo valor da variável @IdVenda
	SELECT @IdVendaD = id_venda 
		FROM deleted

	-- Inserindo valor da viriável @IdPag
	SELECT @IdPagI = indice_pagamento 
		FROM inserted

	-- Validando o indíce de pagamento
		IF @IdPagI = 1 AND @IdVendaI IS NOT NULL AND @IdVendaD IS NOT NULL

			-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN
				UPDATE tbl_VendaPagamento 
					SET id_status_venda_pag = 2
						WHERE id_venda = @IdVendaI
			END
		ELSE
		IF @IdPagI = 0 AND @IdVendaI IS NOT NULL AND @IdVendaD IS NOT NULL
			BEGIN
				UPDATE tbl_VendaPagamento 
					SET id_status_venda_pag = 1
						WHERE id_venda = @IdVendaI
			END
	END
GO