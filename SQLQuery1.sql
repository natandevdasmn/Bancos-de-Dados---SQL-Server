CREATE DATABASE Loja
GO
USE Loja
GO
CREATE TABLE Usuario(
id_usuario SMALLINT NOT NULL PRIMARY KEY IDENTITY,
nome_usario VARCHAR(100) NOT NULL
);

CREATE TABLE Produto(
id_produto SMALLINT NOT NULL PRIMARY KEY IDENTITY,
nome_produto VARCHAR(100) NOT NULL,
data_inclusao DATE NOT NULL,
id_usuario SMALLINT FOREIGN KEY REFERENCES Usuario(id_usuario)
);


CREATE OR ALTER [dbo].[tgr_InserirDataInclusaoUsuario]
	ON
	AFTER INSERT
	AS
		BEGIN
			ALTER TABLE Produto (



			DECLARE @DataInclusao

		END
