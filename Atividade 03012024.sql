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
('Desenvolvimento e licenciamento de programas de computador customizáveis'),
('Desenvolvimento e licenciamento de programas de computador não-customizáveis'),
('Tratamento de dados, provedores de serviços de aplicação e serviços de hospedagem na internet'),
('Consultoria em tecnologia da informação'),
('Web design'),
('Suporte técnico, manutenção e outros serviços em tecnologia da informação'),
('Fabricação de equipamentos de informática e periféricos'),
('Comércio atacadista de equipamentos e produtos de tecnologias de informação e comunicação'),
('Comércio varejista de equipamentos de informática e comunicação; equipamentos e artigos de uso doméstico')
go

-- Inserindo dados na tabela
INSERT INTO TIPO_PREMIACAO (nome)
VALUES
('Organização'),
('Produtividade'),
('Desempenho'),
('Presteza'),
('Criatividade'),
('Eficiência'),
('Inovação'),
('Educação'),
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
	Documentação
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
--INSERIR DADOS NA TABELA TIPO PREMIAÇÃO
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirTipoPremiacao (
	@NOME				VARCHAR(100)
	)
	AS
	/*
	Documentação
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
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova empresa
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: EXEC sp_InserirEmpresa 'SMN JOÃO PASSOS', '475821', '365881', 11, 78146521
	*/
	BEGIN
		INSERT INTO EMPRESA (NOME, CNPJ, INSCRI_MUNI, DDD, TELEFONE)
			VALUES (@NomeEmpresa, @CNPJ, @INSCRI_MUNI, @DDD, @TELEFONE)
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA PARAMÊTRO
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_InserirParametro (
	@IdParametro		SMALLINT,
	@Nome				VARCHAR(45),
	@Valor				DECIMAL(10, 3)
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova parâmetro
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: EXEC sp_InserirParametro 3, 'Excelência', 500
	*/
	BEGIN
		INSERT INTO PARAMETRO (ID_PARAMETRO, NOME, VALOR)
			VALUES (@IdParametro, @Nome, @Valor)
	END
GO

-----------------------------------------------------------------------------------------
--INSERIR DADOS NA TABELA PREMIAÇÃO
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
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova premiação
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
--FUNÇÃO PARA CALCULAR O VALOR DA PREMIAÇÃO
-----------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION fnc_CalcularValoresPremiacao (
	@IdPremiacao SMALLINT 
	)
	RETURNS DECIMAL
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Calcular o valor total das premiações
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: SELECT DBO.fnc_CalcularValoresPremiacao (1)
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @ValorTotal DECIMAL(10, 3),
				@ValorAntig	DECIMAL (10, 3),
				@Acrescimo	INT

		-- Atribuindo o valor da variável @QuantEqui
		SELECT @Acrescimo = PAR.valor, @ValorAntig = PRE.valor_premiacao_atual
			FROM PARAMETRO AS PAR
				INNER JOIN PREMIACAO AS PRE
					ON PAR.ID_PARAMETRO = PRE.ID_PARAMETRO
						WHERE ID_PREMIACAO = @IdPremiacao

		-- Atribuindo o valor da variável @ValorTotal
		SELECT @ValorTotal = (@Acrescimo + @ValorAntig)

		-- Retornando o valor da variável @ValorTotal
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
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Insere na tabela premiação o valor total da premiação
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: 
	*/

	BEGIN
	-- Declarando variáveis
	DECLARE @IdPremiI	INT
	DECLARE @ValorAtu	DECIMAL

	-- Inserindo valor da variável @IdVenda
	SELECT @IdPremiI = ID_PREMIACAO
		FROM inserted

	-- Inserindo valor da variável @IdVenda
	SELECT @ValorAtu = (SELECT DBO.fnc_CalcularValoresPremiacao (@IdPremiI))

	-- Validando o indíce de pagamento
			-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN
				UPDATE PREMIACAO
					SET VALOR_PREMIACAO_ATUAL = @ValorAtu
						WHERE  ID_PREMIACAO = @IdPremiI
			END
	END
GO