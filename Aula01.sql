CREATE PROCEDURE SP_DARBOATARDE
	AS 
	/*
	Documentação
	Arquivo Fonte.....:
	Objetivo..........:
	Autor.............:
	Data..............:
	Ex................:

	*/
	BEGIN
	-- DAR B BOA TRDE
		PRINT 'BOA TARDE'
	END
GO

ALTER PROC SP_DARBOATARDE (@HORA)
	AS
		/*
	Documentação
	Arquivo Fonte.....: Aula01.sql
	Objetivo..........: Dobrar um número de entrada
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularODobro]

	*/
	-- CHEGANDO A HORA
	IF @HORA >= 12 AND
		BEGIN
			
		END
	IF ELSE
		BEGIN

		END
GO

CREATE PROCEDURE SP_CalcularODobro (@numeroentrada int, @resultado int output)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Aula01.sql
	Objetivo..........: Dobrar um número de entrada
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularODobro]

	*/
	BEGIN
		SET @resultado = @numeroentrada * 2
	END
GO

DECLARE @resultado int
EXEC SP_CalcularODobro 5, @resultado output
SELECT @resultado


criar uma tabela chamada cliente (nome, id, data de nascimento), com arquivo sql com 4 procedures (insert, delete, select e update)