CREATE DATABASE Atividade_Nota2
GO
USE Atividade_Nota2
GO
-- CRIANDO TABELA ALUNO
CREATE TABLE tbl_Aluno(
	id_aluno	SMALLINT NOT NULL PRIMARY KEY IDENTITY,
	nome_aluno	VARCHAR(50) NOT NULL,
	aprovado	BIT
);
-- CIRANDO TABELA NOTAS
CREATE TABLE tbl_Notas(
	id_notas	SMALLINT NOT NULL PRIMARY KEY IDENTITY,
	id_aluno	SMALLINT NOT NULL FOREIGN KEY REFERENCES tbl_Aluno(id_aluno),
	nota1		DECIMAL,
	nota2		DECIMAL,
	nota3		DECIMAL,
	nota4		DECIMAL
);
GO

-- INSERINDO ALUNO
CREATE OR ALTER PROCEDURE sp_InserirAluno (
	@NomeAluno	VARCHAR(50)
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Nota.sql
	Objetivo..........: Inserir um novo aluno na tbl_Aluno
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 14/12/2023
	Ex................: EXEC sp_InserirAluno Daniel
	*/
	BEGIN
		INSERT INTO tbl_Aluno(nome_aluno)
			VALUES	(@NomeAluno)
	END
GO

-- INSERINDO NOTAS
CREATE OR ALTER PROCEDURE sp_InserirNota1 (
	@IdAluno	SMALLINT,
	@Nota1		DECIMAL = 0,
	@Nota2		DECIMAL = 0,
	@Nota3		DECIMAL = 0,
	@Nota4		DECIMAL = 0
)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Nota.sql
	Objetivo..........: Inserir notas do aluno na tbl_Notas
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 14/12/2023
	Ex................: EXEC sp_InserirNotasAluno 3, 28
	*/
	BEGIN
	-- VERIFICANDO A EXISTÊNCIA DO ALUNO
		IF EXISTS (SELECT id_aluno FROM tbl_Aluno)
			BEGIN
			-- VALIDANDO A NOTA INSERIDA
				IF (@Nota1 <= 10) AND (@Nota2 <= 10) AND (@Nota3 <= 10) AND (@Nota4 <= 10)
					-- INSERINDO A NOTA 1
					BEGIN
						INSERT INTO tbl_Notas (id_aluno, nota1, nota2, nota3, nota4)
							VALUES	(@IdAluno, @Nota1, @Nota2, @Nota3, @Nota4)
					END
			END
	END
GO

-- VERIFICANDO APROVAÇÃO DO ALUNO
CREATE OR ALTER TRIGGER [dbo].[AprovarAluno]
	ON [dbo].[tbl_Notas]
	AFTER INSERT
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Nota.sql
	Objetivo..........: Verificar se o aluno foi aprovado
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 14/12/2023
	Ex................: 
	*/

	BEGIN
		IF EXISTS (SELECT nota4 FROM tbl_Notas)
		-- DECLARANDO VARIÁVEIS
		DECLARE	@IdAlunoI	SMALLINT,
				@TotalI		DECIMAL

		-- INFORMANDO OS VALORES DAS VARIÁVEIS
		SELECT @TotalI = (nota1 + nota2 + nota3 + nota4) FROM tbl_Notas
		SELECT @IdAlunoI = id_aluno FROM inserted

			-- VERIFICANDO SE ALUNO EXISTE
			IF EXISTS (SELECT id_aluno FROM tbl_Aluno)
				BEGIN
					-- INFORMANDO QUE O ALUNO FOI APROVADO
					IF (@TotalI >= 24)
						BEGIN
							UPDATE tbl_Aluno
								SET aprovado = 1
									WHERE id_aluno = @IdAlunoI
							PRINT 'Aluno foi aprovado'
							END

					-- INFORMANDO QUE O ALUNO FOI REPROVADO
					ELSE
						BEGIN
							UPDATE tbl_Aluno
								SET aprovado = 0
									WHERE id_aluno = @IdAlunoI
						PRINT 'Aluno foi reprovado'
						END
				END
	END
GO

-- Trigger de insert informando se o aluano será aprovado ou não (fazer uma função OVG). Médio mínina 6. 1 aprovado e 0 aprovado