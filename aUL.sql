CREATE DATABASE Aula03_Ricardo
GO 
USE Aula03_Ricardo

CREATE TABLE Conta(
	id_conta INT PRIMARY KEY IDENTITY NOT NULL,
	vlr_saldo DECIMAL (15,2) NOT NULL,
	vlr_credito DECIMAL (15,2) NOT NULL,
	vlr_debito DECIMAL (15,2) NOT NULL
);

CREATE TABLE Lancamento(
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


CREATE OR ALTER PROCEDURE sp_insertLaunch(
    @id_conta INT,
    @tip_lanc CHAR(1),
    @historico VARCHAR(200),
    @vlr_lanc DECIMAL(15,2)
)

    AS
    /*
    Documentação
    Arquivo fonte.....: aula2.sql
    Objetivo..........: Novo lançamento
    Autor.............: SMN - Natanael de Araújo Sousa
    Data..............: 06/12/2023
    Ex................: EXEC [dbo].[sp_insertLaunch] 2, 'D', 'Compra realizada na magalu', 123265
    Retornos..........: 0 - Processamento OK
                        1 - Conta inexistente
                        2 - Sem saldo para débito
                        3 - Tipo de operação inválido
                        4 - Falha na inclusão do registro
    */
    BEGIN
        -- Declarando variáveis
        DECLARE @Vlr_Saldo decimal(15,2)

        -- Checando tipo
        IF @tip_lanc NOT IN('C', 'D') 
            RETURN 3

        -- Buscando saldo da conta
        SELECT @Vlr_Saldo = [dbo].[fnc_getCurrentBalance](@id_conta)

        -- Validando conta
        IF @Vlr_Saldo IS NULL RETURN 1

        -- Validando saldo
        IF @tip_lanc = 'D' AND @Vlr_Saldo < @vlr_lanc RETURN 2

        -- Inserindo registro
        INSERT INTO [dbo].[Lancamento](id_conta, tipo_name, historico, vlr_lance)
            VALUES(@id_conta, @tip_lanc, @historico, @vlr_lanc)

        IF @@ERROR <> 0 return 4

        RETURN 0
    END


GO
CREATE OR ALTER TRIGGER [dbo].[trg_AtualizarSaldo]
	ON [dbo].[Lancamento]
	AFTER INSERT, DELETE, UPDATE
	AS
	/*
	Documentação
	Arquivo Fonte.....: Aula03_Ricardo.sql
	Objetivo..........: Esta trg vai atualizar o saldo atual
	Autor.............: SMN - Natanael de Araújo Sousa
	Data..............: 13/12/2023
	Ex................: EXEC FNC_RetornarSaldo 1
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @id_contai INT,
				@id_contad INT,
				@tip_lanci CHAR(1),
				@tip_lancd CHAR(1),
				@vlr_lanci DECIMAL(15,2),
				@vlr_lancd DECIMAL(15,2)

		-- Recuperada inserted
		SELECT	@id_contai = id_conta, 
				@tip_lanci = tipo_name,
				@vlr_lanci = vlr_lance
			FROM inserted

		-- Recuperada deleted
		SELECT	@id_contad = id_conta,
				@tip_lancd = tipo_name,
				@vlr_lancd = vlr_lance
			FROM deleted

		-- Atualização deleted
		IF @id_contad IS NOT NULL 
			BEGIN
				UPDATE Conta
					SET vlr_credito = vlr_credito - (CASE WHEN @tip_lancd = 'C' THEN @vlr_lancd ELSE 0 END),
						vlr_debito = vlr_debito - (CASE WHEN @tip_lancd = 'D' THEN @vlr_lancd ELSE 0 END)
						WHERE id_conta = @id_contad
			END

		BEGIN
			UPDATE Conta
				SET vlr_credito = vlr_credito + (CASE WHEN @tip_lanci = 'C' THEN @vlr_lanci ELSE 0 END),
					vlr_debito = vlr_debito + (CASE WHEN @tip_lanci = 'D' THEN @vlr_lanci ELSE 0 END)
					WHERE id_conta = @id_contai
		END
	END
GO

SELECT * FROM Conta
DELETE FROM Lancamento WHERE id_lanc = 10
INSERT INTO Lancamento (id_conta, historico, tipo_name, vlr_lance)
	VALUES (5, 'Aprendendo trigger', 'D', 10)



EXEC sp_helptrigger