-- CONSULTADO TABLE TIME
SELECT * FROM tbl_Time ORDER BY pontuacao DESC

-- INSERINDO TIME E PONTUAÇÃO
EXEC sp_InserirTimePontuacao
@time = 'Goias',
@pontuacao = 90
GO

-- CLASSIFICANDO TIME INFORMANDO SUA SITUAÇÃO
SELECT 

SELECT * FROM ClassificarTimes ()


TRUNCATE TABLE tbl_Time

