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
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirCNAE 'CNEA Teste5' -- SELECT * FROM CNAE
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE NÃO CNAE NÃO EXISTE
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
			-- RETORNANDO QUE CNAE NÃO FOI CADASTRADO, POIS JÁ ESTÁ CADASTRADO
			BEGIN
				RETURN 1
			END
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
	Objetivo..........: Inserir novo tipo de premiação
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirTipoPremiacao 'Tipo-Prêmio TESTE5'
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE NÃO TIPO DE PREMIAÇÃO NÃO EXISTE
		IF NOT EXISTS (SELECT NOME FROM TIPO_PREMIACAO WHERE NOME = @NOME)
			BEGIN
				-- INSERINDO UM NOVO TIPO DE PREMIAÇÃO
				INSERT INTO TIPO_PREMIACAO (NOME)
					VALUES (@NOME)
				-- RETORNANDO QUE O TIPO DE PREMIAÇÃO FOI CADASTRADO COM SUCESSO
				RETURN 0
			END
		-- SE O TIPO DE PREMIAÇÃO JÁ EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE TIPO DE PREMIAÇÃO NÃO FOI CADASTRADO, POIS JÁ ESTÁ CADASTRADO
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
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir nova empresa
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirEmpresa 'Nome Empresa TESTE5', '55555', '55555', 55, 5555555
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE A EMPRESA NÃO EXISTE
		IF NOT EXISTS (SELECT CNPJ FROM EMPRESA WHERE CNPJ = @CNPJ)
			BEGIN
				-- INSERINDO UMA NOVA EMPRESA
				INSERT INTO EMPRESA (NOME, CNPJ, INSCRI_MUNI, DDD, TELEFONE)
					VALUES (@NomeEmpresa, @CNPJ, @INSCRI_MUNI, @DDD, @TELEFONE)
				-- RETORNANDO QUE A EMPRESA FOI CADASTRADA COM SUCESSO
				RETURN 0
			END
		-- SE A EMPRESA JÁ EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE A EMPRESA NÃO FOI CADASTRADA, POIS JÁ ESTÁ CADASTRADA
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
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Inserir CNAE da empresa
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirEmpresaCNAE 1, 3, 9
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE NÃO EXISTE CADASTRO O CNAE VINCULADO A EMPRESA
		IF NOT EXISTS (SELECT ID_EMPRESA FROM EMPRESA_CNAE WHERE ID_EMPRESA = @ID_EMPRESA) AND NOT EXISTS (SELECT ID_EMPRESA FROM EMPRESA_CNAE WHERE ID_CNAE = @ID_CNAE)
			BEGIN
				-- INSERINDO UMA NOVA EMPRESA_CNAE
				INSERT INTO EMPRESA_CNAE (CNAE_PRINCIPAL, ID_EMPRESA, ID_CNAE)
					VALUES (@CNAE_PRINCIPAL, @ID_EMPRESA, @ID_CNAE)
				-- RETORNANDO QUE A EMPRESA FOI CADASTRADA COM SUCESSO
				RETURN 0
			END
		-- SE A EMPRESA JÁ EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE A EMPRESA_CNAE NÃO FOI CADASTRADA, POIS JÁ ESTÁ CADASTRADA
				RETURN 1
			END
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
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirParametro 3, 'Excelência', 500
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE O PARAMETRO NÃO EXISTE
		IF NOT EXISTS (SELECT NOME FROM PARAMETRO WHERE NOME = @Nome)
			BEGIN
				-- INSERINDO UMA NOVO PARAMETRO
				INSERT INTO PARAMETRO (ID_PARAMETRO, NOME, VALOR)
					VALUES (@IdParametro, @Nome, @Valor)
				-- RETORNANDO QUE O PARAMETRO FOI CADASTRADO COM SUCESSO
				RETURN 0
			END
		-- SE A EMPRESA JÁ EXISTIR RETORNA 1
		ELSE
			BEGIN
				-- RETORNANDO QUE O PARAMETRO NÃO FOI CADASTRADO, POIS JÁ ESTÁ CADASTRADO
				RETURN 1
			END
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
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_InserirPremiacao 2, 3, 3, 01, 2024
						SELECT @resultado 
	*/
	BEGIN
		-- VERIFICANDO SE O PREMÊS NÃO FOI ATRIBUIDO A NENHUMA EMPRESA
		IF NOT EXISTS (SELECT ID_PREMIACAO FROM PREMIACAO WHERE ID_PREMIACAO = @IdTiPremiacao) AND
		NOT EXISTS (SELECT ID_PARAMETRO FROM PREMIACAO WHERE ID_PARAMETRO = @IdParametro) AND
		NOT EXISTS (SELECT DATA_MES FROM PREMIACAO WHERE DATA_MES = @MesPremio) AND
		NOT EXISTS (SELECT DATA_ANO FROM PREMIACAO WHERE DATA_ANO = @AnoPremio)
			BEGIN
				-- INSERINDO A PREMIAÇÃO DEVIDA
				INSERT INTO PREMIACAO (ID_EMPRESA, ID_TIPO_PREMIACAO, ID_PARAMETRO, DATA_MES, DATA_ANO)
					VALUES (@IdEmpresa, @IdTiPremiacao, @IdParametro, @MesPremio, @AnoPremio)
			END
		-- SE A EMPREMIAÇÃO JÁ FOI ATRIBUIDA A ALGUMA EMPRESA
		ELSE
			BEGIN
				-- RETORNANDO QUE A PREMIAÇÃO NÃO FOI CADASTRA, POIS JÁ ESTÁ REGISTRADA
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--FUNÇÃO PARA CALCULAR O VALOR DA PREMIAÇÃO
-----------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION fnc_CalcularValoresPremiacao (
	@IdPremiacao SMALLINT -- TIPO DE PREMIAÇÃO
	)
	RETURNS DECIMAL(10, 3)
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
		DECLARE @ValorTotal		DECIMAL(10, 3),
				@ValorAntigo	DECIMAL (10, 3),
				@Acrescimo		INT


		-- Atribuindo o valor da variável @Acrescimo
		SET @Acrescimo = (SELECT TOP 1 VALOR FROM PARAMETRO WHERE ID_PARAMETRO = (SELECT ID_PARAMETRO FROM PREMIACAO WHERE ID_PREMIACAO = @IdPremiacao))

		-- Atribuindo o valor da variável @ValorAntigo
		SET @ValorAntigo = (SELECT TOP 1 VALOR_PREMIACAO_ATUAL FROM PREMIACAO WHERE ID_PARAMETRO = (SELECT ID_PARAMETRO FROM PREMIACAO WHERE ID_PREMIACAO = 3))

		IF @ValorAntigo IS NULL
			SET @ValorTotal = @Acrescimo 
		-- Atribuindo o valor da variável @ValorTotal
		ELSE
			SELECT @ValorTotal = (@Acrescimo + @ValorAntigo)

		-- Retornando o valor da variável @ValorTotal
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
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Insere na tabela premiação o valor total da premiação
	Autor.............: SMN - Natanael
	Data..............: 03/01/2024
	Ex................: 
	*/

	BEGIN
	-- Declarando variáveis
	DECLARE @Empresa	INT,
	 @IdParametro	INT,
	 @ValorAtualizado	DECIMAL (10, 3)

	-- Inserindo valor da variável @IdVenda
	SELECT @Empresa = ID_EMPRESA
		FROM inserted

	-- Inserindo valor da variável @IdVenda
	SELECT @IdParametro = ID_PARAMETRO
		FROM inserted

	-- Inserindo valor da variável @IdVenda
	SELECT @ValorAtualizado = (SELECT DBO.fnc_CalcularValoresPremiacao (@Empresa, @IdParametro))

	-- Validando o indíce de pagamento
			-- Inserindo o id da venda na tabela VendaPagamento
			BEGIN
				UPDATE PREMIACAO
					SET VALOR_PREMIACAO_ATUAL = @ValorAtualizado
						WHERE  ID_PREMIACAO = @Empresa
			END
	END
GO