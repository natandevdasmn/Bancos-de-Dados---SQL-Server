CREATE DATABASE Teste_Ricardo

GO

USE Teste_Ricardo

-- Cria��o da tabela cliente
CREATE TABLE cliente (
  id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  data_nasc DATE NOT NULL
);
GO
-- SP de inser��o
CREATE PROCEDURE sp_inserir_colaborador (
	@nome VARCHAR(200),
	@Email VARCHAR(100),
	@Empresa VARCHAR(150),
	@cargo VARCHAR(150),
	@UF CHAR(2),
	@cidade VARCHAR(150),
	@DDD TINYINT,
	@Telefone BIGINT,
	@Whatsapp BIT
	)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Inserir dados do cliente
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		INSERT INTO colaborador (nome, data_nasc)
			VALUES (@nome VARCHAR(200), @Email VARCHAR(100), @Empresa VARCHAR(150), @cargo VARCHAR(150),
					@UF CHAR(2), @cidade VARCHAR(150), @DDD TINYINT, @Telefone BIGINT, @Whatsapp BIT);
	END;
GO
-- SP de exclus�o
CREATE PROCEDURE sp_excluir_cliente(
	@id INT)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Excluir cliente
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		DELETE FROM cliente
			WHERE id = @id;
	END;
GO

-- SP de sele��o
CREATE PROCEDURE sp_selecionar_cliente (
	@id INT)
	AS
	/*
	Documenta��o
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Selecionar cliente
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		SELECT * FROM cliente
			WHERE id = @id;
	END;
GO
-- SP de atualiza��o
CREATE PROCEDURE sp_atualizar_cliente
	@id INT,
	@nome VARCHAR(100),
	@data_nasc DATE
	/*
	Documenta��o
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Atualizar dados do cliente
	Autor.............: SMN - Natanael de Ara�jo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	AS
	BEGIN
		UPDATE cliente
			SET nome = @nome, data_nasc = @data_nasc
				WHERE id = @id;
	END;
GO
-- Inser��o de um cliente
EXEC sp_inserir_cliente @nome = 'Jo�o da Silva', @data_nasc = '1980-01-01';

-- Exclus�o de um cliente
EXEC sp_excluir_cliente @id = 1;

-- Sele��o de um cliente
EXEC sp_selecionar_cliente @id = 1;

-- Atualiza��o de um cliente
EXEC sp_atualizar_cliente @id = 1, @nome = 'Maria da Silva', @data_nasc = '1985-02-02';