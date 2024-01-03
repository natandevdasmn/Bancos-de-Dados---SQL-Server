CREATE DATABASE Atividade_Loja3
GO
USE Atividade_Loja3
GO

CREATE TABLE tbl_Cliente(
	id_cliente			INT NOT NULL PRIMARY KEY IDENTITY,
	nome_cliente		VARCHAR(75) NOT NULL,
	email_cliente		VARCHAR(75) NOT NULL,
	dataregistro		DATE NOT NULL
	);

CREATE TABLE tbl_Pedido(
	id_pedido			INT NOT NULL PRIMARY KEY IDENTITY,
	id_cliente			INT NOT NULL FOREIGN KEY REFERENCES tbl_Cliente(id_cliente),
	preco_total			MONEY NOT NULL,
	data_pedido			DATE
	);

CREATE TABLE tbl_TipoProduto(
	id_tipo				INT NOT NULL PRIMARY KEY IDENTITY,
	nome_tip			VARCHAR(150)
	);

CREATE TABLE tbl_Produto(
	id_produto			INT NOT NULL PRIMARY KEY IDENTITY,
	id_tipo				INT NOT NULL FOREIGN KEY REFERENCES tbl_TipoProduto(id_tipo),
	nome_produto		VARCHAR(75) NOT NULL,
	preco_unitario		MONEY NOT NULL
	);

CREATE TABLE tbl_ItensPedido(
	id_itens			INT NOT NULL PRIMARY KEY IDENTITY,
	id_pedido			INT NOT NULL FOREIGN KEY REFERENCES tbl_Pedido(id_pedido),
	id_produto			INT NOT NULL FOREIGN KEY REFERENCES tbl_Produto(id_produto)
	);




INSERT INTO tbl_Cliente (nome_cliente, email_cliente, dataregistro)
VALUES
('Carlos Bacalhau', 'teste@123.com', '2023-12-06')

INSERT INTO tbl_Cliente (nome_cliente, email_cliente, dataregistro)
VALUES
('Maria da Silva', 'maria.silva@email.com', GETDATE()),
('João Santos', 'joao.santos@email.com', GETDATE() - 1),
('Ana Souza', 'ana.souza@email.com', GETDATE() - 2),
('Pedro Oliveira', 'pedro.oliveira@email.com', GETDATE() - 3),
('Carla Costa', 'carla.costa@email.com', GETDATE() - 4),
('Rafael Dias', 'rafael.dias@email.com', GETDATE() - 5),
('Bianca Mendes', 'bianca.mendes@email.com', GETDATE() - 6),
('Felipe Pereira', 'felipe.pereira@email.com', GETDATE() - 7),
('Gabriela Gomes', 'gabriela.gomes@email.com', GETDATE() - 8),
('Victor Araújo', 'victor.araujo@email.com', GETDATE() - 9),
('Lucas Silva', 'lucas.silva@email.com', GETDATE() - 10),
('Sofia Santos', 'sofia.santos@email.com', GETDATE() - 11),
('Matheus Oliveira', 'matheus.oliveira@email.com', GETDATE() - 12),
('Camila Costa', 'camila.costa@email.com', GETDATE() - 13),
('Bruno Dias', 'bruno.dias@email.com', GETDATE() - 14),
('Larissa Mendes', 'larissa.mendes@email.com', GETDATE() - 15),
('Eduardo Pereira', 'eduardo.pereira@email.com', GETDATE() - 16),
('Isabela Gomes', 'isabela.gomes@email.com', GETDATE() - 17),
('Leonardo Araújo', 'leonardo.araujo@email.com', GETDATE() - 18),
('Letícia Silva', 'leticia.silva@email.com', GETDATE() - 19);

INSERT INTO tbl_TipoProduto (nome_tip)
VALUES
('Alimentício'),
('Eletrônico'),
('Vestuário'),
('Casa e Decoração'),
('Esporte e Lazer'),
('Livros e Papelaria'),
('Saúde e Beleza'),
('Automotivo'),
('Construção e Reforma'),
('Informática'),
('Telefonia e Internet'),
('Serviços'),
('Educação'),
('Turismo e Viagens'),
('Imóveis'),
('Agropecuária'),
('Indústria'),
('Presentes'),
('Outros');

-- Inserir 20 dados fictícios na tabela tbl_Produto
INSERT INTO tbl_Produto (id_tipo, nome_produto, preco_unitario)
VALUES
  (1, 'Produto_A', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (1, 'Produto_B', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (2, 'Produto_C', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (2, 'Produto_D', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (2, 'Produto_E', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (3, 'Produto_F', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (3, 'Produto_G', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (4,'Produto_H', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (5, 'Produto_I', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (5, 'Produto_J', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (6, 'Produto_K', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (7,'Produto_L', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (8,'Produto_M', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (9, 'Produto_N', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (10, 'Produto_O', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (10, 'Produto_P', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (11, 'Produto_Q', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (11, 'Produto_R', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (12, 'Produto_S', CAST(RAND() * (1000 - 10) + 10 AS MONEY)),
  (13, 'Produto_T', CAST(RAND() * (1000 - 10) + 10 AS MONEY));

-- Inserir 20 dados fictícios na tabela tbl_Pedido
INSERT INTO tbl_Pedido (id_cliente, preco_total, data_pedido)
VALUES
  (1, 456.78, '2023-01-01'),
  (2, 789.12, '2023-02-15'),
  (3, 234.56, '2023-03-30'),
  (4, 567.89, '2023-04-12'),
  (5, 123.45, '2023-05-25'),
  (1, 890.12, '2023-06-08'),
  (2, 321.09, '2023-07-21'),
  (3, 678.90, '2023-08-04'),
  (4, 90.12, '2023-09-17'),
  (5, 345.67, '2023-10-30'),
  (1, 12.34, '2023-11-12'),
  (2, 567.89, '2023-12-25'),
  (3, 890.12, '2023-01-07'),
  (4, 234.56, '2023-02-20'),
  (5, 678.90, '2023-03-04'),
  (1, 56.78, '2023-04-17'),
  (2, 789.12, '2023-05-30'),
  (3, 345.67, '2023-06-12'),
  (4, 123.45, '2023-07-25'),
  (5, 456.78, '2023-08-07');


-- Inserir 20 dados fictícios na tabela tbl_Produto
INSERT INTO tbl_Pedido (id_cliente, preco_total, data_pedido)
VALUES
  (1, 456.78, '2023-10-02'),
  (2, 789.12, '2023-10-05'),
  (3, 234.56, '2023-10-08'),
  (4, 567.89, '2023-10-11'),
  (5, 123.45, '2023-10-14'),
  (1, 890.12, '2023-10-17'),
  (2, 321.09, '2023-10-20'),
  (3, 678.90, '2023-10-23'),
  (4, 90.12, '2023-10-26'),
  (5, 345.67, '2023-10-29'),
  (1, 12.34, '2023-11-01'),
  (2, 567.89, '2023-11-04'),
  (3, 890.12, '2023-11-07'),
  (4, 234.56, '2023-11-10'),
  (5, 678.90, '2023-11-13'),
  (1, 56.78, '2023-11-16'),
  (2, 789.12, '2023-11-19'),
  (3, 345.67, '2023-11-22'),
  (4, 123.45, '2023-11-25'),
  (5, 456.78, '2023-11-28');


-- Inserir 20 dados fictícios na tabela tbl_ItensPedido
INSERT INTO tbl_ItensPedido (id_pedido, id_produto)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 1),
  (5, 2),
  (6, 2),
  (7, 2),
  (8, 3),
  (9, 3),
  (10, 4),
  (11, 5),
  (12, 6),
  (13, 7),
  (14, 8),
  (15, 9),
  (16, 10),
  (17, 11),
  (18, 12),
  (19, 13),
  (20, 14);






-- TAREFA 1: Encontre o nome dos clientes que fizeram pedidos nos últimos 30 dias
SELECT *
	FROM tbl_Pedido
		WHERE data_pedido >= DATEADD (dd, -30, GETDATE());

-- TAREFA 2: : Liste os produtos que foram incluídos em pedidos com um preço total superior a R$ 200
SELECT nome_produto
	FROM tbl_Produto p
		INNER JOIN tbl_ItensPedido ip
			ON p.id_produto = ip.id_produto
				INNER JOIN tbl_Pedido pd
					ON ip.id_produto = pd.id_pedido
						WHERE preco_total > 200


-- TAREFA 3: Descubra o valor médio gasto por cliente em seus pedidos.
SELECT c.nome_cliente, AVG(p.preco_total) AS 'Média gasto' 
	FROM tbl_Cliente AS c
		INNER JOIN tbl_Pedido AS p
			ON c.id_cliente = p.id_cliente
				GROUP BY nome_cliente


-- TAREFA 4: Encontre os clientes que ainda não fizeram nenhum pedido
SELECT nome_cliente 
	FROM tbl_Cliente 
		WHERE NOT EXISTS (SELECT * FROM tbl_Pedido WHERE id_cliente = tbl_Cliente.id_cliente)

-- TAREFA 5: Liste os produtos mais vendidos (os produtos que aparecem em mais pedidos) juntamente com a contagem de pedidos em que cada um aparece
SELECT p.id_produto, p.nome_produto, COUNT(ip.id_pedido) AS total_pedidos
	FROM tbl_Produto p
		JOIN tbl_ItensPedido ip 
			ON p.id_produto = ip.id_produto
				GROUP BY p.id_produto, p.nome_produto
					ORDER BY total_pedidos DESC
GO
-- TAREFA 6: Retorne o nome dos clientes e a data do primeiro pedido de cada um. Ordenar pelo nome do cliente
SELECT c.nome_cliente, MIN(p.data_pedido) AS 'Data do 1º pedido'
	FROM tbl_Cliente c
		INNER JOIN tbl_Pedido p 
			ON c.id_cliente = p.id_cliente
				GROUP BY c.id_cliente, c.nome_cliente
					ORDER BY c.nome_cliente;
GO
-- TAREFA 7: Crie uma procedure que permita inserir clientes novos na tabela de “Cliente”
CREATE PROCEDURE InserirCliente
    @NomeCliente VARCHAR(75),
    @EmailCliente VARCHAR(75),
    @DataRegistro DATE
	AS
		BEGIN
			INSERT INTO tbl_Cliente (nome_cliente, email_cliente, dataregistro)
				VALUES (@NomeCliente, @EmailCliente, @DataRegistro);
		END;
	GO
EXEC InserirCliente
	@NomeCliente = '',
	@EmailCliente = '',
	@DataRegistro = '';
GO
-- TAREFA 8: Crie uma procedure que permita atualizar preço de produtos na tabela “Produto”
CREATE PROCEDURE AtualizarPrecoProduto
    @IdProduto INT,
    @NovoPrecoUnitario MONEY
	AS
		BEGIN
			UPDATE tbl_Produto
				SET preco_unitario = @NovoPrecoUnitario
					WHERE id_produto = @IdProduto;
		END;
GO
EXEC AtualizarPrecoProduto
    @IdProduto = 1, -- Substitua pelo ID do produto que deseja atualizar
    @NovoPrecoUnitario = 19.99; -- Substitua pelo novo preço unitário desejado
GO
-- TAREFA 9: Crie uma procedure que permita inserir novos pedidos na tabela de “Pedido”
CREATE PROCEDURE InserirPedido
    @IdCliente INT,
    @PrecoTotal MONEY,
    @DataPedido DATE
	AS
		BEGIN
			INSERT INTO tbl_Pedido (id_cliente, preco_total, data_pedido)
				VALUES (@IdCliente, @PrecoTotal, @DataPedido);
		END;
GO
EXEC InserirPedido
    @IdCliente = 1, -- Substitua pelo ID do cliente que está realizando o pedido
    @PrecoTotal = 50.00, -- Substitua pelo preço total do pedido
    @DataPedido = '2023-01-01'; -- Substitua pela data do pedido
GO
-- TAREFA 10: Crie uma procedure que permita deletar pedidos na tabela de “Pedido”
CREATE PROCEDURE DeletarPedido
    @IdPedido INT
	AS
	BEGIN
		DELETE FROM tbl_ItensPedido 
			WHERE id_pedido = @IdPedido;
		DELETE FROM tbl_Pedido 
			WHERE id_pedido = @IdPedido;
	END;
GO
EXEC DeletarPedido
    @IdPedido = 1; -- Substitua pelo ID do pedido que deseja deletar
GO
-- TAREFA 11: Crie uma procedure que liste todos os produtos agrupados por tipo
CREATE OR ALTER PROCEDURE ListarProdutosPorTipo
	AS
	BEGIN
		SELECT tp.nome_tip AS TipoProduto, p.nome_produto
			FROM tbl_TipoProduto tp
				INNER JOIN tbl_Produto p 
					ON tp.id_tipo = p.id_tipo
						ORDER BY tp.nome_tip, p.nome_produto;
	END;
GO
EXEC ListarProdutosPorTipo;
GO
-- TAREFA 12: Retorne o nome dos clientes que fizeram pedidos nos últimos 30 dias e o total gasto por cada cliente
SELECT c.nome_cliente, SUM(p.preco_total) AS total_gasto
	FROM tbl_Cliente c
		INNER JOIN tbl_Pedido p 
			ON c.id_cliente = p.id_cliente
				WHERE p.data_pedido >= DATEADD(DAY, -30, GETDATE())
					GROUP BY c.id_cliente, c.nome_cliente
						ORDER BY total_gasto DESC;
GO
-- TAREFA 13: Liste os produtos que foram incluídos em pedidos com um preço total superior à média dos preços totais de todos os pedidos. (Você deve identificar os produtos que foram adquiridos em pedidos cujo valor total é maior do que a média dos valores totais de todos os pedidos. Isso envolve calcular a média dos preços totais de todos os pedidos e, em seguida, selecionar os produtos associados a pedidos que excedam essa média de preço total.)
SELECT pr.id_produto, pr.nome_produto, pr.preco_unitario
	FROM tbl_Produto AS pr
		INNER JOIN tbl_ItensPedido AS ip 
			ON pr.id_produto = ip.id_produto
				INNER JOIN tbl_Pedido AS p 
					ON ip.id_pedido = p.id_pedido
						WHERE p.preco_total > (SELECT AVG(preco_total) FROM tbl_Pedido);
GO
-- TAREFA 14: Retorne o nome e o e-mail dos clientes que ainda não fizeram nenhum pedido
SELECT nome_cliente, email_cliente
	FROM tbl_Cliente c
		WHERE NOT EXISTS (SELECT 1 FROM tbl_Pedido p WHERE p.id_cliente = c.id_cliente);

