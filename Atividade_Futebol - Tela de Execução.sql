-- CONSULTADO TABLE TIME
SELECT * FROM tbl_Time ORDER BY pontuacao DESC

-- INSERINDO TIME E PONTUA��O
EXEC sp_InserirTimePontuacao
@time = 'Goias',
@pontuacao = 90
GO

-- CLASSIFICANDO TIME INFORMANDO SUA SITUA��O
SELECT 

SELECT * FROM ClassificarTimes ()


TRUNCATE TABLE tbl_Time

