USE Atividade_Veiculos
-- CONSULTA TABELA VE�CULO
SELECT * FROM tbl_Veiculo

-- CONSULTA VE�CUO PELO ID
SELECT * FROM fnc_CriarTabelaVeiculo (1)

-- INSERINDO NOVOS VE�CULOS
EXEC sp_InserirNovosVeiculos
@TipVeiculo = 1,
@Categoria = 1,
@Cor = 1,
@IdEstoque = 1,
@AnoFabricacao = 2010,
@ValorVeiculo = 10.000
GO

-- DELETANDO VE�CULOS
EXEC sp_DeletarVeiculoi
@IdVeiculo = 9
GO

-- CONSULTA ESTOQUE
SELECT * FROM tbl_Estoque

TRUNCATE TABLE tbl_Veiculo