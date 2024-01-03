CREATE DATABASE Atividade_Veiculos
GO
USE Atividade_Veiculos
GO

-- CRIANDO A TABELA TIPO DE VÉICULO
CREATE TABLE tbl_Tipo_Veiculo (
	id_tipo			INT NOT NULL PRIMARY KEY IDENTITY,
	nome_tipo		VARCHAR(50) NOT NULL
	);

-- CRIANDO A TABELA ESTOQUE
CREATE TABLE tbl_Estoque (
	id_estoque		INT NOT NULL PRIMARY KEY IDENTITY,
	quantidade		INT NOT NULL
	);

-- CRIANDO A TABELA CATEGORIA 
CREATE TABLE tbl_Categoria (
	id_categoria	INT NOT NULL PRIMARY KEY IDENTITY,
	nome_categoria	VARCHAR(50) NOT NULL
	);

-- CRIANDO A TABELA COR
CREATE TABLE tbl_Cor (
	id_cor			INT NOT NULL PRIMARY KEY IDENTITY,
	nome_cor		VARCHAR(50) NOT NULL
	);

-- CRIANDO A TABELA VEÍCULO
CREATE TABLE tbl_Veiculo (
	id_veiculo		INT NOT NULL PRIMARY KEY IDENTITY,
	id_tipo			INT NOT NULL FOREIGN KEY REFERENCES tbl_Tipo_Veiculo(id_tipo),
	id_categoria	INT NOT NULL FOREIGN KEY REFERENCES tbl_Categoria(id_categoria),
	id_cor			INT NOT NULL FOREIGN KEY REFERENCES tbl_Cor(id_cor),
	id_estoque		INT NOT NULL FOREIGN KEY REFERENCES tbl_Estoque(id_estoque),
	ano_fabricacao	SMALLINT NOT NULL,
	valor_veiculo	MONEY NOT NULL
	);

-- INSERINDO TIPOS DE VEICULOS
INSERT INTO tbl_Tipo_Veiculo VALUES
('Carro'),
('Moto'),
('Caminhão'),
('Ônibus'),
('Avião')

-- INSERINDO CATEGORIA DOS VEÍCULOS
INSERT INTO tbl_Categoria VALUES
('Volkswagen - Gol'),
('Volkswagen - Nivus'),
('Volkswagen - Polo'),
('Fiat - Argo'),
('Fiat - Mobi'),
('Chevrolet - Onix'),
('Chevrolet - S10'),
('Honda - XRE'),
('Honda - CG 150'),
('Volvo - FH 540'),
('Volkswagen - 11.180'),
('Mercedes - OF 1721'),
('Boeing - 737')

-- INSERINDO CORES VEÍCULOS
INSERT INTO tbl_Cor VALUES
('Branco'),
('Prata'),
('Cinza'),
('Preto')

-- INSERINDO CORES VEÍCULOS
INSERT INTO tbl_Estoque VALUES
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0),
(0)

GO

-- INSERINDO NOVOS VEICULOS
CREATE OR ALTER PROC sp_InserirNovosVeiculos (
	@TipVeiculo			INT,
	@Categoria			INT,
	@Cor				INT,
	@IdEstoque			INT,
	@AnoFabricacao		INT,
	@ValorVeiculo		MONEY
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Inserir um novo veiculo na tbl_Veiculo
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 18/12/2023
	Ex................: EXEC sp_InserirNovosVeiculos
	*/
	BEGIN
	DECLARE @QtdEstoque		INT
	-- DECLARANDO A VARIÁVEL @QtdEstoque
	SELECT @QtdEstoque = quantidade FROM tbl_Estoque WHERE id_estoque = @IdEstoque
		-- VERIFICANDO ANO DO VEÍCULO
		IF @AnoFabricacao < YEAR(GETDATE())
			-- VERIFICANDO ESTOQUES DOS VEÍCULOS
				IF (@QtdEstoque < 10)
					-- INSERINDO UM NOVO VEÍCULO
					BEGIN
						INSERT INTO tbl_Veiculo (id_tipo, id_categoria, id_cor, id_estoque, ano_fabricacao, valor_veiculo)
							VALUES (@TipVeiculo, @Categoria, @Cor, @IdEstoque, @AnoFabricacao, @ValorVeiculo)
					END
				-- ESTOQUE DE MÁXIMO DE ESTOQUE ATINGIDO
				ELSE
					PRINT 'O estoque máximo atingido, não é mais possível adicionar novos veículos'
		-- INSERÇÃO DE ANO DE VEÍCULO INVÁLIDO
		ELSE
			PRINT 'Ano de fabrição inserido é inválido'
	END

GO

CREATE OR ALTER FUNCTION fnc_CriarTabelaVeiculo (@veiculo INT)
	RETURNS Table
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Exibir tabela com as características do veículo informado
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 18/12/2023
	Ex................: SELECT * FROM fnc_CriarTabelaVeiculo (1)
	*/
	RETURN (SELECT id_tipo AS 'Tipo', id_categoria AS 'Categoria', id_cor AS 'Cor', ano_fabricacao AS 'Ano de Fabricação'
				FROM tbl_Veiculo 
					WHERE id_veiculo = @veiculo
			)

GO


CREATE OR ALTER TRIGGER [dbo].[InserirEEstoque]
	ON tbl_veiculo
	AFTER INSERT, DELETE
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Inserir estoque do veículo
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 18/12/2023
	Ex................: 
	*/
	-- DECLARANDO VARIÁVEL
	DECLARE @IdEstoqueI	INT,
			@IdEstoqueD INT
	-- INFORMANDO O VALOR DA VARIÁVEL @idEstoqueI
	SELECT @IdEstoqueI = id_estoque FROM inserted
	-- INFORMANDO O VALOR DA VARIÁVEL @idEstoqueD
	SELECT @IdEstoqueD = id_estoque FROM deleted
	-- VERIFICANDO SE VEICULO EXISTE
	IF @IdEstoqueI IS NOT NULL
		-- REALIZANDO ADIÇÃO NO ESTOQUE
		BEGIN
			UPDATE tbl_Estoque
				SET quantidade = quantidade+1
					WHERE id_estoque = @IdEstoqueI
		END
	ELSE
	-- VERIFICANDO SE VEICULO EXISTE
	IF @IdEstoqueD IS NOT NULL
		BEGIN
			-- REALIZANDO ADIÇÃO NO ESTOQUE
			UPDATE tbl_Estoque
				SET quantidade = quantidade-1
					WHERE id_estoque = @IdEstoqueD
		END
GO

CREATE OR ALTER PROC sp_DeletarVeiculoi (
	@IdVeiculo	INT
	)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Excluir um veiculo na tbl_Veiculo
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 19/12/2023
	Ex................: EXEC sp_ExcluirVeiculos
	*/
	BEGIN
		-- VERIFICANDO SE O VEÍCULO EXISTE
		IF EXISTS (SELECT id_veiculo FROM tbl_Veiculo WHERE id_veiculo = @IdVeiculo)
			DELETE FROM tbl_Veiculo 
				WHERE id_veiculo = @IdVeiculo
		-- INFORMANDO QUE O VEÍCULO NÃO EXISTE
		ELSE
			PRINT 'Veículo informado não existe'
	END
GO