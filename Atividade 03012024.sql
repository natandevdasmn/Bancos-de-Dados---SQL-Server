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

CREATE TABLE EMPRESA_CNAE(
	CNAE_PRINCIPAL BIT NOT NULL,
	ID_EMPRESA INT FOREIGN KEY REFERENCES EMPRESA(ID_EMPRESA),
	ID_CNAE SMALLINT FOREIGN KEY REFERENCES CNAE(ID_CNAE)
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
	Ex................: EXEC sp_InserirCNAE
	*/
	BEGIN
		INSERT INTO CNAE (NOME)
			VALUES (@NOME)
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
	Objetivo..........: Inserir nova CNAE
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: EXEC sp_InserirCNAE
	*/
	BEGIN
		INSERT INTO TIPO_PREMIACAO (NOME)
			VALUES (@NOME)
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
	Data..............: 03/01/2024
	Ex................: EXEC sp_InserirEmpresa 'SMN JO�O PASSOS', '475821', '365881', 11, 78146521
	*/
	BEGIN
		INSERT INTO EMPRESA (NOME, CNPJ, INSCRI_MUNI, DDD, TELEFONE)
			VALUES (@NomeEmpresa, @CNPJ, @INSCRI_MUNI, @DDD, @TELEFONE)
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
	Data..............: 03/01/2024
	Ex................: EXEC sp_InserirParametro 3, 'Excel�ncia', 500
	*/
	BEGIN
		INSERT INTO PARAMETRO (ID_PARAMETRO, NOME, VALOR)
			VALUES (@IdParametro, @Nome, @Valor)
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
	Data..............: 03/01/2024
	Ex................: EXEC sp_InserirPremiacao 1, 2, 2, 01, 2024
	*/
	BEGIN
		INSERT INTO PREMIACAO (ID_EMPRESA, ID_TIPO_PREMIACAO, ID_PARAMETRO, DATA_MES, DATA_ANO)
			VALUES (@IdEmpresa, @IdTiPremiacao, @IdParametro, @MesPremio, @AnoPremio)
	END
GO

-----------------------------------------------------------------------------------------
--FUN��O PARA CALCULAR O VALOR DA PREMIA��O
-----------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION fnc_CalcularValoresPremiacao (
	@IdPremiacao SMALLINT 
	)
	RETURNS DECIMAL
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
		DECLARE @ValorTotal DECIMAL(10, 3),
				@ValorAntig	DECIMAL (10, 3),
				@Acrescimo	INT

		-- Atribuindo o valor da vari�vel @QuantEqui
		SELECT @Acrescimo = PAR.valor, @ValorAntig = PRE.valor_premiacao_atual
			FROM PARAMETRO AS PAR
				INNER JOIN PREMIACAO AS PRE
					ON PAR.ID_PARAMETRO = PRE.ID_PARAMETRO
						WHERE ID_PREMIACAO = @IdPremiacao

		-- Atribuindo o valor da vari�vel @ValorTotal
		SELECT @ValorTotal = (@Acrescimo + @ValorAntig)

		-- Retornando o valor da vari�vel @ValorTotal
		RETURN @ValorTotal
	END
GO

SELECT * FROM PREMIACAO

-- Trigger para inserir a venda na tabela vendas pagamentos se o status ind_pag tiver 1, status pendente na tabela vendas pagamentos
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
	DECLARE @IdPremiI	INT
	DECLARE @ValorAtu	DECIMAL

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @IdPremiI = ID_PREMIACAO
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @ValorAtu = (SELECT DBO.fnc_CalcularValoresPremiacao (@IdPremiI))

	-- Validando o ind�ce de pagamento
			-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN
				UPDATE PREMIACAO
					SET VALOR_PREMIACAO_ATUAL = @ValorAtu
						WHERE  ID_PREMIACAO = @IdPremiI
			END
	END
GO