CREATE DATABASE Aula02_Ricardo
GO 
USE Aula02_Ricardo

CREATE TABLE Conta(
	id_conta INT PRIMARY KEY IDENTITY NOT NULL,
	vlr_saldo DECIMAL (15,2) NOT NULL,
	vlr_credito DECIMAL (15,2) NOT NULL,
	vlr_debito DECIMAL (15,2) NOT NULL
);

CREATE TABLE Landamento(
	id_lanc INT PRIMARY KEY IDENTITY NOT NULL,
	id_conta INT NOT NULL,
	tipo_name CHAR(1) NOT NULL,
	historico VARCHAR(200) NOT NULL,
	vlr_lance DECIMAL (15,2) NOT NULL
);


INSERT INTO Conta(vlr_saldo, vlr_credito, vlr_debito) VALUES
(1500, 100, 200),
(1800, 100, 200),
(2000, 100, 200),
(2200, 100, 200),
(2300, 100, 200),
(3000, 100, 200);

GO
ALTER FUNCTION FNC_RetornarSaldo (@conta INT)
	RETURNS DECIMAL(15,2)
	AS
	/*
	Documentação
	Arquivo Fonte.....: Aula02_Ricardo.sql
	Objetivo..........: Retornar saldo conta pelo id_conta
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 06/12/2023
	Ex................: EXEC FNC_RetornarSaldo 1
	*/
	BEGIN
	RETURN (
		SELECT (vlr_saldo + vlr_credito - vlr_debito) AS SaldoAtual
			FROM Conta 
				WHERE id_conta = @conta);
	END
GO

Recebe id, tipo, vlr

INSERT se conta exister (se debito, se existe e valor depósito for maior que saldo atual)