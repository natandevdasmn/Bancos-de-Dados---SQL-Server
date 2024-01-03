CREATE PROC SP_CalcularNumeros (
	@num1 int, 
	@num2 int, 
	@operacao CHAR, 
	@res VARCHAR(20) output
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Aula01.sql
	Objetivo..........: Calcular Numeros
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		IF @operacao = '+'
			SET @res = @num1 + @num2
		ELSE IF @operacao = '*'
			SET @res = @num1 * @num2
		ELSE IF @operacao = '-'
			SET @res = @num1 - @num2
		ELSE IF @operacao = '/'
			SET @res = @num1 / @num2
		ELSE
			SET @res = 'Opera��o inv�lida'

	END
GO

DECLARE @res VARCHAR(20)
EXEC SP_CalcularNumeros
25, 
55, 
'/',
@res output
SELECT @res



DROP PROCEDURE SP_CalcularNumeros