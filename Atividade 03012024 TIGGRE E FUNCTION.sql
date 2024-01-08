-----------------------------------------------------------------------------------------
--FUN��O PARA CALCULAR O VALOR DA PREMIA��O
-----------------------------------------------------------------------------------------

CREATE OR ALTER FUNCTION fnc_CalcularValoresPremiacao (
	@IdPremiacao SMALLINT -- TIPO DE PREMIA��O
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
	DECLARE @IdPremiI	INT
	DECLARE @ValorAtu	DECIMAL

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @IdPremiI = ID_PREMIACAO
		FROM inserted

	-- Inserindo valor da vari�vel @IdVenda
	SELECT @ValorAtu = (SELECT DBO.fnc_CalcularValoresPremiacao (@IdPremiI))
	
	-- Atualizando o valor atual da premiacao da tabela premia��o
	UPDATE PREMIACAO
		SET VALOR_PREMIACAO_ATUAL = @ValorAtu
			WHERE  ID_PREMIACAO = @IdPremiI
	END
GO