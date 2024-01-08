CREATE DATABASE Atividade_03012024
GO
USE Atividade_03012024

CREATE TABLE CNAE(
	ID_CNAE SMALLINT NOT NULL PRIMARY KEY IDENTITY,
	NOME VARCHAR(250) NOT NULL
)

CREATE TABLE EMPRESA(
	ID_EMPRESA INT NOT NULL PRIMARY KEY IDENTITY,
	NOME VARCHAR(150),
	CNPJ BIGINT UNIQUE NOT NULL,
	INSCRI_MUNI VARCHAR(45) NOT NULL,
	DDD SMALLINT NOT NULL,
	TELEFONE INT NOT NULL,
	INSCRI_ESTAD VARCHAR(45) NULL
)

	ALTER TABLE EMPRESA_CNAE (
		ID_EMPRESA_CNAE TINYINT NOT NULL PRIMARY KEY IDENTITY,
		CNAE_PRINCIPAL BIT NULL,
		ID_EMPRESA INT,
		FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA (ID_EMPRESA),
		ID_CNAE SMALLINT,
		FOREIGN KEY (ID_CNAE) REFERENCES CNAE (ID_CNAE)
		)

CREATE TABLE PARAMETRO(
	ID_PARAMETRO TINYINT NOT NULL PRIMARY KEY,
	NOME VARCHAR(45) NOT NULL,
	VALOR DECIMAL(10,3) NOT NULL
)

CREATE TABLE TIPO_PREMIACAO(
	ID_TIPO_PREMIACAO TINYINT NOT NULL PRIMARY KEY IDENTITY,
	NOME VARCHAR (60) NOT NULL
)

CREATE TABLE PREMIACAO(
	ID_PREMIACAO SMALLINT NOT NULL PRIMARY KEY IDENTITY,
	ID_EMPRESA INT,
	FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA (ID_EMPRESA),
	ID_TIPO_PREMIACAO TINYINT,
	FOREIGN KEY (ID_TIPO_PREMIACAO) REFERENCES TIPO_PREMIACAO (ID_TIPO_PREMIACAO),
	ID_PARAMETRO TINYINT,
	FOREIGN KEY (ID_PARAMETRO) REFERENCES PARAMETRO(ID_PARAMETRO),
	DATA_ANO SMALLINT NOT NULL,
	DATA_MES TINYINT NOT NULL,
	VALOR_PREMIACAO_ATUAL DECIMAL(10,3) NULL
)
go

-- Inserindo dados na tabela
INSERT INTO CNAE(nome)
VALUES
('Desenvolvimento de programas de computador sob encomenda'),
('Desenvolvimento e licenciamento de programas de computador customiz�veis'),
('Desenvolvimento e licenciamento de programas de computador n�o-customiz�veis'),
('Tratamento de dados, provedores de servi�os de aplica��o e servi�os de hospedagem na internet'),
('Consultoria em tecnologia da informa��o'),
('Web design'),
('Suporte t�cnico, manuten��o e outros servi�os em tecnologia da informa��o'),
('Fabrica��o de equipamentos de inform�tica e perif�ricos'),
('Com�rcio atacadista de equipamentos e produtos de tecnologias de informa��o e comunica��o'),
('Com�rcio varejista de equipamentos de inform�tica e comunica��o; equipamentos e artigos de uso dom�stico')
go

-- Inserindo dados na tabela
INSERT INTO TIPO_PREMIACAO (nome)
VALUES
('Organiza��o'),
('Produtividade'),
('Desempenho'),
('Presteza'),
('Criatividade'),
('Efici�ncia'),
('Inova��o'),
('Educa��o'),
('Vendas'),
('Outros')
go

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA CNAE
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirCNAE (
	@NOME				VARCHAR(100)
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova CNAE
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirCNAE 'CNEA Teste5' -- SELECT * FROM CNAE
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE N�O CNAE N�O EXISTE
		IF NOT EXISTS (SELECT NOME FROM CNAE WHERE NOME = @NOME)
			BEGIN
				-- INSERINDO UM NOVO CNEA
				INSERT INTO CNAE (NOME)
					VALUES (@NOME)
				-- RETORNANDO QUE O CNEA FOI CADASTRADO COM SUCESSO
				RETURN 0
			END
		-- SE O CNAE EXISTER RETORNA 1
		ELSE
			-- RETORNANDO QUE CNAE N�O FOI CADASTRADO, POIS J� EST� CADASTRADO
			BEGIN
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA TIPO PREMIA��O
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirTipoPremiacao (
	@NOME				VARCHAR(100)
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir novo tipo de premia��o
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirTipoPremiacao 'Tipo-Pr�mio TESTE5'
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE N�O TIPO DE PREMIA��O N�O EXISTE
		IF NOT EXISTS (SELECT NOME FROM TIPO_PREMIACAO WHERE NOME = @NOME)
			BEGIN
				-- INSERINDO UM NOVO TIPO DE PREMIA��O
				INSERT INTO TIPO_PREMIACAO (NOME)
					VALUES (@NOME)
				-- RETORNANDO QUE O TIPO DE PREMIA��O FOI CADASTRADO COM SUCESSO
				RETURN 0
			END
		-- SE O TIPO DE PREMIA��O J� EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE TIPO DE PREMIA��O N�O FOI CADASTRADO, POIS J� EST� CADASTRADO
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA EMPRESA
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirEmpresa (
	@NomeEmpresa		VARCHAR(100),
	@CNPJ				BIGINT,
	@INSCRI_MUNI		VARCHAR(45),
	@DDD				SMALLINT,
	@TELEFONE			INT
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova empresa
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirEmpresa 'Nome Empresa TESTE5', '55555', '55555', 55, 5555555
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE A EMPRESA N�O EXISTE
		IF NOT EXISTS (SELECT CNPJ FROM EMPRESA WHERE CNPJ = @CNPJ)
			BEGIN
				-- INSERINDO UMA NOVA EMPRESA
				INSERT INTO EMPRESA (NOME, CNPJ, INSCRI_MUNI, DDD, TELEFONE)
					VALUES (@NomeEmpresa, @CNPJ, @INSCRI_MUNI, @DDD, @TELEFONE)
				-- RETORNANDO QUE A EMPRESA FOI CADASTRADA COM SUCESSO
				RETURN 0
			END
		-- SE A EMPRESA J� EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE A EMPRESA N�O FOI CADASTRADA, POIS J� EST� CADASTRADA
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA EMPRESA_CNAE
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirEmpresaCNAE (
	@CNAE_PRINCIPAL		BIT,
	@ID_EMPRESA			INT,
	@ID_CNAE			SMALLINT
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir CNAE da empresa
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirEmpresaCNAE 1, 3, 9
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE N�O EXISTE CADASTRO O CNAE VINCULADO A EMPRESA
		IF NOT EXISTS (SELECT ID_EMPRESA FROM EMPRESA_CNAE WHERE ID_EMPRESA = @ID_EMPRESA) AND NOT EXISTS (SELECT ID_EMPRESA FROM EMPRESA_CNAE WHERE ID_CNAE = @ID_CNAE)
			BEGIN
				-- INSERINDO UMA NOVA EMPRESA_CNAE
				INSERT INTO EMPRESA_CNAE (CNAE_PRINCIPAL, ID_EMPRESA, ID_CNAE)
					VALUES (@CNAE_PRINCIPAL, @ID_EMPRESA, @ID_CNAE)
				-- RETORNANDO QUE A EMPRESA FOI CADASTRADA COM SUCESSO
				RETURN 0
			END
		-- SE A EMPRESA J� EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE A EMPRESA_CNAE N�O FOI CADASTRADA, POIS J� EST� CADASTRADA
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA PARAM�TRO
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirParametro (
	@IdParametro		SMALLINT,
	@Nome				VARCHAR(45),
	@Valor				DECIMAL(10, 3)
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova par�metro
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirParametro 3, 'Excel�ncia', 500
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE O PARAMETRO N�O EXISTE
		IF NOT EXISTS (SELECT NOME FROM PARAMETRO WHERE NOME = @Nome)
			BEGIN
				-- INSERINDO UMA NOVO PARAMETRO
				INSERT INTO PARAMETRO (ID_PARAMETRO, NOME, VALOR)
					VALUES (@IdParametro, @Nome, @Valor)
				-- RETORNANDO QUE O PARAMETRO FOI CADASTRADO COM SUCESSO
				RETURN 0
			END
		-- SE A EMPRESA J� EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE O PARAMETRO N�O FOI CADASTRADO, POIS J� EST� CADASTRADO
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA PREMIA��O
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirPremiacao (
	@IdEmpresa			INT,
	@IdTiPremiacao		TINYINT,
	@IdParametro		TINYINT,
	@MesPremio			SMALLINT,
	@AnoPremio			INT
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova premia��o
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirPremiacao 2, 3, 3, 01, 2024
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE O PREM�S N�O FOI ATRIBUIDO A NENHUMA EMPRESA
		IF NOT EXISTS (SELECT ID_PREMIACAO FROM PREMIACAO WHERE ID_PREMIACAO = @IdTiPremiacao) AND
		NOT EXISTS (SELECT ID_PARAMETRO FROM PREMIACAO WHERE ID_PARAMETRO = @IdParametro) AND
		NOT EXISTS (SELECT DATA_MES FROM PREMIACAO WHERE DATA_MES = @MesPremio) AND
		NOT EXISTS (SELECT DATA_ANO FROM PREMIACAO WHERE DATA_ANO = @AnoPremio)
			BEGIN
				-- INSERINDO A PREMIA��O DEVIDA
				INSERT INTO PREMIACAO (ID_EMPRESA, ID_TIPO_PREMIACAO, ID_PARAMETRO, DATA_MES, DATA_ANO)
					VALUES (@IdEmpresa, @IdTiPremiacao, @IdParametro, @MesPremio, @AnoPremio)
			END
		-- SE A EMPREMIA��O J� FOI ATRIBUIDA A ALGUMA EMPRESA
		ELSE
			BEGIN
				-- RETORNANDO QUE A PREMIA��O N�O FOI CADASTRA, POIS J� EST� REGISTRADA
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--FUN��O PARA CALCULAR O VALOR DA PREMIA��O
-----------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION fnc_CalcularValoresPremiacao (
	@IdPremiacao SMALLINT -- TIPO DE PREMIA��O
	)
	RETURNS DECIMAL(10, 3)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Calcular o valor total das premia��es
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: SELECT DBO.fnc_CalcularValoresPremiacao (1)
	*/
	BEGIN
		-- Declarando vari�veis
		DECLARE @ValorTotal		DECIMAL(10, 3),
				@ValorAntigo	DECIMAL (10, 3),
				@Acrescimo		INT


		-- Atribuindo o valor da vari�vel @Acrescimo
		SET @Acrescimo = (SELECT TOP 1 VALOR FROM PARAMETRO WHERE ID_PARAMETRO = (SELECT ID_PARAMETRO FROM PREMIACAO WHERE ID_PREMIACAO = @IdPremiacao))

		-- Atribuindo o valor da vari�vel @ValorAntigo
		SET @ValorAntigo = (SELECT TOP 1 VALOR_PREMIACAO_ATUAL FROM PREMIACAO WHERE ID_PARAMETRO = (SELECT ID_PARAMETRO FROM PREMIACAO WHERE ID_PREMIACAO = 3))

		IF @ValorAntigo IS NULL
			SET @ValorTotal = @Acrescimo 
		-- Atribuindo o valor da vari�vel @ValorTotal
		ELSE
			SELECT @ValorTotal = (@Acrescimo + @ValorAntigo)

		-- Retornando o valor da vari�vel @ValorTotal
		RETURN @ValorTotal
	END
GO

INSERT INTO PREMIACAO (ID_EMPRESA, ID_PARAMETRO, ID_TIPO_PREMIACAO, DATA_MES, DATA_ANO)
VALUES (3, 2, 2, 05, 2024)

SELECT * FROM PARAMETRO
SELECT * FROM PREMIACAO

TRUNCATE TABLE PREMIACAO

-----------------------------------------------------------------------------------------
--TIGGRE 
-----------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER [dbo].[tgr_InserirValorTotalPremiacao]
	ON [dbo].[premiacao]
	AFTER INSERT
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Insere na tabela premia��o o valor total da premia��o
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: 
	*/

	BEGIN
	-- Declarando vari�veis
	DECLARE @Empresa	INT,
	 @IdParametro	INT,
	 @ValorAtualizado	DECIMAL (10, 3)

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @Empresa = ID_EMPRESA
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @IdParametro = ID_PARAMETRO
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @ValorAtualizado = (SELECT DBO.fnc_CalcularValoresPremiacao (@Empresa, @IdParametro))

	-- Validando o ind�ce de pagamento
			-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN
				UPDATE PREMIACAO
					SET VALOR_PREMIACAO_ATUAL = @ValorAtualizado
						WHERE  ID_PREMIACAO = @Empresa
			END
	END
GO