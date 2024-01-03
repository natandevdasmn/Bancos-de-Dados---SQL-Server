CREATE PROC SP_SomarNumeros (
	@num1 int, 
	@num2 int, 
	@res int output)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Aula01.sql
	Objetivo..........: Somar Numeros
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_SomarNumeros]

	*/
	BEGIN
		SET @res = @num1 + @num2
	END
GO

DECLARE @res int
EXEC SP_SomarNumeros 5, 2, @res output
SELECT @res

somando dois n�meros
GO

CREATE PROC SP_CalcularNumeros (
	@num1 int, 
	@num2 int, 
	@operacao CHAR, 
	@ret VARCHAR output,
	@res float output
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
		ELSE IF @operacao <> '+', '-', '*', '/'
			THEN PRINT 'Opera��o inv�lida'

	END
GO

DECLARE @res float
EXEC SP_CalcularNumeros
5, 
2, 
'-',
'Opera��o inv�lida',
@res output
SELECT @res