-- CONSULTAR TABELA ALUNO
SELECT * FROM tbl_Aluno
GO

-- CONSULTA TABELA NOTAS
SELECT * FROM tbl_Notas
GO

-- INSERINDO ALUNO
EXEC sp_InserirAluno
@NomeAluno = 'Felipe'
GO

-- INSERINDO NOTA ALUNO
EXEC sp_InserirNotasAluno
@IdAluno = 3 ,
@Nota = 35.5
GO