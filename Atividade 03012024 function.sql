-----------------------------------------------------------------------------------------
--FUN��O PARA CALCULAR O VALOR DA PREMIA��O
-----------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION fnc_CalcularValoresPremiacao (
	@Empresa INT,
	@IdParametro TINYINT
	)
	RETURNS DECIMAL(10, 3)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Calcular o valor total das premia��es
	Autor.............: SMN - Natanael
	Data..............: 05/01/2024
	Ex................: SELECT DBO.fnc_CalcularValoresPremiacao (3, 2)
	*/
	BEGIN
		-- Declarando vari�veis
		DECLARE @ValorTotal		DECIMAL(10, 3),
				@ValorPremio	DECIMAL(10, 3),
				@ValorAtual		DECIMAL(10, 3)
 
		-- Buscando o valor atual da empresa no raking
		SET @ValorAtual = (SELECT TOP 1 VALOR_PREMIACAO_ATUAL FROM PREMIACAO WHERE ID_EMPRESA = @Empresa AND 
		DATA_MES <= (SELECT MAX(DATA_MES) FROM PREMIACAO WHERE ID_EMPRESA = @Empresa) AND 
		DATA_ANO = (SELECT MAX(DATA_ANO) FROM PREMIACAO WHERE ID_EMPRESA = @Empresa) AND VALOR_PREMIACAO_ATUAL IS NOT NULL ORDER BY ID_PREMIACAO DESC)
	
		-- Buscando o valor do pr�mio
		SET @ValorPremio = (SELECT VALOR FROM PARAMETRO WHERE ID_PARAMETRO = @IdParametro)
		
		-- Verificando se o valor atual da premia��o � nulo
		IF @ValorAtual IS NULL
			BEGIN
				-- Se valor for nulo, ou seja, n�o existir valor ainda inserido, vai setar o valor do pr�mio
				SET @ValorTotal = @ValorPremio
			END
		-- Se o valor atual da premia��o n�o for nulo
		ELSE
			BEGIN
				-- Realizando o c�lculo e atualizando o valor
				SET @ValorTotal = (@ValorPremio + @ValorAtual)
			END
		-- Retornando o valor da vari�vel @ValorTotal
		RETURN @ValorTotal
	END
GO

INSERT INTO PREMIACAO (ID_EMPRESA, ID_PARAMETRO, ID_TIPO_PREMIACAO, DATA_MES, DATA_ANO)
VALUES (2, 2, 2, 01, 2025)

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
	DECLARE @Empresa			INT,
			@IdParametro		INT,
			@IdPremiacao		INT,
			@ValorAtualizado	DECIMAL (10, 3)

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @IdPremiacao = ID_PREMIACAO
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @Empresa = ID_EMPRESA
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @IdParametro = ID_PARAMETRO
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @ValorAtualizado = (SELECT DBO.fnc_CalcularValoresPremiacao (@Empresa, @IdParametro))

	-- Atualizando o valor atual da premiacao da tabela premia��o
	UPDATE PREMIACAO
		SET VALOR_PREMIACAO_ATUAL = @ValorAtualizado
			WHERE  ID_PREMIACAO = @IdPremiacao
	END
GO