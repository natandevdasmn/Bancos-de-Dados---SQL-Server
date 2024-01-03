-- CONSULTAR tbl_Aluno
SELECT * FROM tbl_Aluno

-- COSULTAR tbl_Notas
SELECT * FROM tbl_Notas

-- INSERINDO NOVO ALUNO
EXEC sp_InserirAluno
@NomeAluno = 'Ana'
GO

-- INSERINDO NOTAS
EXEC sp_InserirNota1
@IdAluno = 2,
@Nota1 = 6
@Nota2 = 
@Nota3 = 
@Nota4 = 
GO