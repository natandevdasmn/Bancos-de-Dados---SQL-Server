CREATE DATABASE Atividade_Futebol
GO
USE Atividade_Futebol

-- CRIANDO TABELA TIME
CREATE TABLE tbl_Time (
	id_time				INT NOT NULL PRIMARY KEY IDENTITY,
	nome_time			VARCHAR(50) NOT NULL,
	pontuacao			INT NOT NULL,
	classificacao		VARCHAR(50)
);
GO
-- INSERINDO TIME
CREATE OR ALTER PROC sp_InserirTimePontuacao (
	@time		VARCHAR(50),
	@pontuacao	INT
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Futebol.sql
	Objetivo..........: Inserir time de futebol e pontuação
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 15/12/2023
	Ex................: EXEC sp_InserirTimePontuacao
	*/
	BEGIN
		-- VERIFICANDO SE O TIME NÃO EXISTE
		IF NOT EXISTS (SELECT nome_time FROM tbl_Time WHERE nome_time = @time)
			BEGIN
			-- VERIFICANDO SE PONTUAÇÃO INSERIDA É VÁLIDA
			IF @pontuacao < 114
				BEGIN
					-- INSERINDO TIME E PONTUAÇÃO
					INSERT INTO tbl_Time (nome_time, pontuacao)
						VALUES (@time, @pontuacao)
				END
			ELSE
				PRINT 'Pontuação inserida é inválida'
			END
		ELSE
			PRINT 'Time já está inserido'
	END
GO

CREATE OR ALTER FUNCTION ClassificarTimes ()
	RETURNS Table
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Futebol.sql
	Objetivo..........: Realizando a classificação dos times de acordo com sua pontuação
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 15/12/2023
	Ex................: SELECT * FROM ClassificarTimes ()
	*/
	RETURN (SELECT TOP 12 classificacao AS 'Classificação', nome_time AS 'Time', pontuacao AS 'Pontuação' 
		FROM tbl_Time ORDER BY pontuacao DESC)
GO

CREATE OR ALTER TRIGGER [dbo].[InserirClassificacao]
	ON [dbo].[tbl_Time]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Futebol.sql
	Objetivo..........: Inseridno a classificação do time
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 15/12/2023
	Ex................: 
	*/
	BEGIN
		-- DECLARANDO VARIÁVEIS
		DECLARE @pontuacaoI	INT,
				@idtimeI	INT
		SELECT @idtimeI =(id_time) FROM inserted 
		-- INSERINDO O VALOR DA VARIÁVEL @pontuacao
		SELECT @pontuacaoI = pontuacao FROM inserted
		-- INFORMANDO QUE O TIME FOI CLASSIFICADO PARA LIBERTADORES
		IF (@pontuacaoI > 70)
			UPDATE tbl_Time
				SET classificacao = 'LIBERTADORES'
					WHERE id_time = @idtimeI
		ELSE
			IF (@pontuacaoI < 50)
				UPDATE tbl_Time
					SET classificacao = 'REBAIXADO'
						WHERE id_time = @idtimeI
				ELSE
					UPDATE tbl_Time
						SET classificacao = 'NÃO REBAIXADO'
							WHERE id_time = @idtimeI
	END
GO

