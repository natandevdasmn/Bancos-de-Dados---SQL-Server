-----------------------------------------------------------------------------------------
--CONSULTAR DADOS DA TABELA CNAE
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_ConsultarCNAE (
	@IDCNEA				SMALLINT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Consultar dados da tabela CNEA
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_ConsultarCNAE 2
						SELECT @resultado
	*/
	BEGIN
		-- VERIFICANDO SE O CNAE INFORMADO EXISTE
		IF EXISTS (SELECT ID_CNAE FROM CNAE WHERE ID_CNAE = @IDCNEA)
			BEGIN
				-- CONSULTANDO O CNAE SOLICITADO
				SELECT * FROM CNAE
					WHERE ID_CNAE = @IDCNEA
				-- RETORNANDO QUE A CONSULTADA FOI REALIZADA COM SUCESSO
				RETURN 0
			END
		-- SE O ID INFORMANDO NÃO EXISTIR
		ELSE
			BEGIN
				-- RETORNANDO QUE A CONSULTADA NÃO FOI REALIZADA, POIS ID INFORMANDO NÃ ESTÁ CADASTRADO
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--CONSULTAR DADOS DA TABELA TIPO PREMIAÇÃO
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_ConsultarTipoPremiacao (
	@ID_TIPO_PREMIACAO	TINYINT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Consultar dados da tabela TIPO_PREMIACAO
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_ConsultarTipoPremiacao 30
						SELECT @resultado
	*/
	BEGIN
		-- VERIFICANDO SE O TIPO PREMIACAO INFORMADO EXISTE
		IF EXISTS (SELECT ID_TIPO_PREMIACAO FROM TIPO_PREMIACAO WHERE ID_TIPO_PREMIACAO = @ID_TIPO_PREMIACAO)
			BEGIN
				-- CONSULTANDO O TIPO PREMIAÇÃO SOLICITADO
				SELECT * FROM TIPO_PREMIACAO
					WHERE ID_TIPO_PREMIACAO = @ID_TIPO_PREMIACAO
				-- RETORNANDO QUE A CONSULTADA FOI REALIZADA COM SUCESSO
				RETURN 0
			END
		-- SE O ID INFORMANDO NÃO EXISTIR
		ELSE
			BEGIN
				-- RETORNANDO QUE A CONSULTADA NÃO FOI REALIZADA, POIS ID INFORMANDO NÃ ESTÁ CADASTRADO
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--CONSULTAR DADOS DA TABELA EMPRESA
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_ConsultarEmpresa (
	@ID_EMPRESA			INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Consultar dados da tabela empresa
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_ConsultarEmpresa 30
						SELECT @resultado
	*/
	BEGIN
		-- VERIFICANDO SE A EMPRESA INFORMADA EXISTE
		IF EXISTS (SELECT ID_EMPRESA FROM EMPRESA WHERE ID_EMPRESA = @ID_EMPRESA)
			BEGIN
				-- CONSULTANDO A EMPRESA SOLICITADA
				SELECT * FROM EMPRESA
					WHERE ID_EMPRESA = @ID_EMPRESA
				-- RETORNANDO QUE A CONSULTADA FOI REALIZADA COM SUCESSO
				RETURN 0
			END
		-- SE O ID INFORMANDO NÃO EXISTIR
		ELSE
			BEGIN
				-- RETORNANDO QUE A CONSULTADA NÃO FOI REALIZADA, POIS ID INFORMANDO NÃ ESTÁ CADASTRADO
				RETURN 1
			END
		END
GO

-----------------------------------------------------------------------------------------
--CONSULTAR DADOS DA TABELA PARAMETRO
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_ConsultarParametro (
	@ID_PARAMETRO		TINYINT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Consultar dados da tabela parametro
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_ConsultarParametro 30
						SELECT @resultado
	*/
	BEGIN
		-- VERIFICANDO SE O PARAMETRO INFORMADO EXISTE
		IF EXISTS (SELECT ID_PARAMETRO FROM PARAMETRO WHERE ID_PARAMETRO = @ID_PARAMETRO)
			BEGIN
				-- CONSULTANDO O PARAMETRO INFORMADO
				SELECT * FROM PARAMETRO
					WHERE ID_PARAMETRO = @ID_PARAMETRO
				-- RETORNANDO QUE A CONSULTADA FOI REALIZADA COM SUCESSO
				RETURN 0
			END
		-- SE O ID INFORMANDO NÃO EXISTIR
		ELSE
			BEGIN
				-- RETORNANDO QUE A CONSULTADA NÃO FOI REALIZADA, POIS ID INFORMANDO NÃ ESTÁ CADASTRADO
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--CONSULTAR DADOS DA TABELA PREMIAÇÃO
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_ConsultarPremiacao (
	@ID_PREMIACAO			INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Consultar dados da tabela premicao
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_ConsultarPremiacao 30
						SELECT @resultado
	*/
	BEGIN
		-- VERIFICANDO SE O PRÊMIO INFORMADO EXISTE
		IF EXISTS (SELECT ID_PREMIACAO FROM PREMIACAO WHERE ID_PREMIACAO = @ID_PREMIACAO)
			BEGIN
				-- CONSULTANDO O PRÊMIO INFORMADO
				SELECT * FROM PREMIACAO
					WHERE ID_PREMIACAO = @ID_PREMIACAO
				-- RETORNANDO QUE A CONSULTADA FOI REALIZADA COM SUCESSO
				RETURN 0
			END
		-- SE O ID INFORMANDO NÃO EXISTIR
		ELSE
			BEGIN
				-- RETORNANDO QUE A CONSULTADA NÃO FOI REALIZADA, POIS ID INFORMANDO NÃ ESTÁ CADASTRADO
				RETURN 1
			END
	END
GO

-----------------------------------------------------------------------------------------
--CONSULTAR DADOS DA TABELA EMPRESA_CNEA
-----------------------------------------------------------------------------------------

CREATE OR ALTER PROC sp_ConsultarEmpresa_CNEA (
	@ID_EMPRESA_CNAE		INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_03012024.sql
	Objetivo..........: Consultar dados da tabela Empresa_CNEA
	Autor.............: SMN - Natanael
	Data..............: 04/01/2024
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = sp_ConsultarEmpresa_CNEA 30
						SELECT @resultado
	*/
	BEGIN
		-- VERIFICANDO SE A EMPRESA_CNEA INFORMADA EXISTE
		IF EXISTS (SELECT ID_EMPRESA_CNAE FROM EMPRESA_CNAE WHERE ID_EMPRESA_CNAE = @ID_EMPRESA_CNAE)
			BEGIN
				-- CONSULTANDO A EMPRESA_CNEA INFORMADA
				SELECT * FROM EMPRESA_CNAE
					WHERE ID_EMPRESA_CNAE = @ID_EMPRESA_CNAE
				-- RETORNANDO QUE A CONSULTADA FOI REALIZADA COM SUCESSO
				RETURN 0
			END
		-- SE O ID INFORMANDO NÃO EXISTIR
		ELSE
			BEGIN
				-- RETORNANDO QUE A CONSULTADA NÃO FOI REALIZADA, POIS ID INFORMANDO NÃ ESTÁ CADASTRADO
				RETURN 1
			END
	END
GO