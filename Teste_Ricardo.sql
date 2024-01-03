CREATE DATABASE Teste_Ricardo

GO

USE Teste_Ricardo

-- Criação da tabela cliente
CREATE TABLE cliente (
  id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  data_nasc DATE NOT NULL
);
GO
-- SP de inserção
CREATE PROCEDURE sp_inserir_cliente (
	@nome VARCHAR(100),
	@data_nasc DATE)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Inserir dados do cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		INSERT INTO cliente (nome, data_nasc)
			VALUES (@nome, @data_nasc);
	END;
GO
-- SP de exclusão
CREATE PROCEDURE sp_excluir_cliente(
	@id INT)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Excluir cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		DELETE FROM cliente
			WHERE id = @id;
	END;
GO

-- SP de seleção
CREATE PROCEDURE sp_selecionar_cliente (
	@id INT)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Selecionar cliente
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 29/11/2023
	Ex................: EXEC [dbo].[SP_CalcularNumeros]

	*/
	BEGIN
		SELECT * FROM cliente
			WHERE id = @id;
	END;
GO
-- SP de atualização
CREATE PROCEDURE sp_atualizar_cliente
	@id INT,
	@nome VARCHAR(100),
	@data_nasc DATE
	/*
	Documentação
	Arquivo Fonte.....: Teste_Ricardo.sql
	Objetivo..........: Atualizar dados do cliente
	Autor.............: SMN - Natanael de Araújo Sousa
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
-- Inserção de um cliente
EXEC sp_inserir_cliente @nome = 'João da Silva', @data_nasc = '1980-01-01';

-- Exclusão de um cliente
EXEC sp_excluir_cliente @id = 1;

-- Seleção de um cliente
EXEC sp_selecionar_cliente @id = 1;

-- Atualização de um cliente
EXEC sp_atualizar_cliente @id = 1, @nome = 'Maria da Silva', @data_nasc = '1985-02-02';