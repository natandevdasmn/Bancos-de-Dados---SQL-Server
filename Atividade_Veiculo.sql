CREATE DATABASE Atividade_Veiculos
GO
USE Atividade_Veiculos
GO

-- CRIANDO A TABELA TIPO DE V�ICULO
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

-- CRIANDO A TABELA VE�CULO
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
('Caminh�o'),
('�nibus'),
('Avi�o')

-- INSERINDO CATEGORIA DOS VE�CULOS
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

-- INSERINDO CORES VE�CULOS
INSERT INTO tbl_Cor VALUES
('Branco'),
('Prata'),
('Cinza'),
('Preto')

-- INSERINDO CORES VE�CULOS
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
	Documenta��o
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Inserir um novo veiculo na tbl_Veiculo
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 18/12/2023
	Ex................: EXEC sp_InserirNovosVeiculos
	*/
	BEGIN
	DECLARE @QtdEstoque		INT
	-- DECLARANDO A VARI�VEL @QtdEstoque
	SELECT @QtdEstoque = quantidade FROM tbl_Estoque WHERE id_estoque = @IdEstoque
		-- VERIFICANDO ANO DO VE�CULO
		IF @AnoFabricacao < YEAR(GETDATE())
			-- VERIFICANDO ESTOQUES DOS VE�CULOS
				IF (@QtdEstoque < 10)
					-- INSERINDO UM NOVO VE�CULO
					BEGIN
						INSERT INTO tbl_Veiculo (id_tipo, id_categoria, id_cor, id_estoque, ano_fabricacao, valor_veiculo)
							VALUES (@TipVeiculo, @Categoria, @Cor, @IdEstoque, @AnoFabricacao, @ValorVeiculo)
					END
				-- ESTOQUE DE M�XIMO DE ESTOQUE ATINGIDO
				ELSE
					PRINT 'O estoque m�ximo atingido, n�o � mais poss�vel adicionar novos ve�culos'
		-- INSER��O DE ANO DE VE�CULO INV�LIDO
		ELSE
			PRINT 'Ano de fabri��o inserido � inv�lido'
	END

GO

CREATE OR ALTER FUNCTION fnc_CriarTabelaVeiculo (@veiculo INT)
	RETURNS Table
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Exibir tabela com as caracter�sticas do ve�culo informado
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 18/12/2023
	Ex................: SELECT * FROM fnc_CriarTabelaVeiculo (1)
	*/
	RETURN (SELECT id_tipo AS 'Tipo', id_categoria AS 'Categoria', id_cor AS 'Cor', ano_fabricacao AS 'Ano de Fabrica��o'
				FROM tbl_Veiculo 
					WHERE id_veiculo = @veiculo
			)

GO


CREATE OR ALTER TRIGGER [dbo].[InserirEEstoque]
	ON tbl_veiculo
	AFTER INSERT, DELETE
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Inserir estoque do ve�culo
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 18/12/2023
	Ex................: 
	*/
	-- DECLARANDO VARI�VEL
	DECLARE @IdEstoqueI	INT,
			@IdEstoqueD INT
	-- INFORMANDO O VALOR DA VARI�VEL @idEstoqueI
	SELECT @IdEstoqueI = id_estoque FROM inserted
	-- INFORMANDO O VALOR DA VARI�VEL @idEstoqueD
	SELECT @IdEstoqueD = id_estoque FROM deleted
	-- VERIFICANDO SE VEICULO EXISTE
	IF @IdEstoqueI IS NOT NULL
		-- REALIZANDO ADI��O NO ESTOQUE
		BEGIN
			UPDATE tbl_Estoque
				SET quantidade = quantidade+1
					WHERE id_estoque = @IdEstoqueI
		END
	ELSE
	-- VERIFICANDO SE VEICULO EXISTE
	IF @IdEstoqueD IS NOT NULL
		BEGIN
			-- REALIZANDO ADI��O NO ESTOQUE
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
	Documenta��o
	Arquivo Fonte.....: Atividade_Veiculo.sql
	Objetivo..........: Excluir um veiculo na tbl_Veiculo
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 19/12/2023
	Ex................: EXEC sp_ExcluirVeiculos
	*/
	BEGIN
		-- VERIFICANDO SE O VE�CULO EXISTE
		IF EXISTS (SELECT id_veiculo FROM tbl_Veiculo WHERE id_veiculo = @IdVeiculo)
			DELETE FROM tbl_Veiculo 
				WHERE id_veiculo = @IdVeiculo
		-- INFORMANDO QUE O VE�CULO N�O EXISTE
		ELSE
			PRINT 'Ve�culo informado n�o existe'
	END
GO