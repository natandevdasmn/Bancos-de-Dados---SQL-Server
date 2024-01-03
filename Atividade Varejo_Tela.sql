USE Atividade_Varejo
GO
-- INSERIR DADOS NA TABELA EQUIPAMENTOS
EXEC sp_InserirEquipamento
@IdTipEqui = 1,			-- 1 = Informática, 2 = Telefonia, 3 = Eletrodoméstico, 4 = Automotivo, 5 = Brinquedo
@NomeEqui = 'Mouse',
@PrecoEqui = 30.00
GO

-- INSERIR DADOS NA TABELA CLIENTE
EXEC sp_InserirCliente
@NomeCliente = 'Juan Pablo',
@Cpf = 7855456,
@DataNasc = '20000101'
GO

-- INSERIR DADOS NA TABELA VENDA
EXEC sp_InserirVenda
@IdCliente = 2,			-- CONSULTAR CLIENTES (SELECT * FROM tbl_Cliente)
@IdEquipamento = 2,		-- CONSULTAR EQUIPAMENTOS (SELECT * FROM tbl_Equipamento)
@IndPag = 0,			-- 0 = PENDENTE, 1 = PAGO
@Quant = 5
GO

-- CONSULTAR EQUIPAMENTO
EXEC sp_ConsultarEquipamento
@IdEquipamento = 1
GO

-- CONSULTAR CLIENTE
EXEC sp_ConsultarCliente
@IdCliente = 1
GO

-- CONSULTAR VENDA
EXEC sp_ConsultarVenda
@IdVenda = 2
GO

select * from tbl_Venda
select * from tbl_VendaPagamento

-- ATUALIZAR EQUIPAMENTO
EXEC sp_AtualizarEquipamento
@IdEquipamento = 1,		-- CONSULTAR EQUIPAMENTOS (SELECT * FROM tbl_Equipamento)
@TipoEqui = 1,
@NomeEqui = 'A',
@PrecoEqui = 50
GO

-- ATUALIZAR CLIENTE
EXEC sp_AtualizarCliente
@IdCliente = 1,			-- CONSULTAR CLIENTES (SELECT * FROM tbl_Cliente)
@NomeCliente = 1,
@CpfCliente = 1,
@DataNasc = 01012024
GO

-- ATUALIZAR VENDA
EXEC sp_AtualizarVenda
@IdVenda = 3,			-- CONSULTAR VENDAS (SELECT * FROM tbl_Venda)
@IdCliente = 1,			-- CONSULTAR CLIENTES (SELECT * FROM tbl_Cliente)
@IdEquipamento = 1,		-- CONSULTAR EQUIPAMENTOS (SELECT * FROM tbl_Equipamento)
@IndPagamento = 1,		-- 0 = PENDENTE, 1 = PAGO
@Quantidade = 2
GO

-- EXCLUIR EQUIPAMENTO
EXEC sp_ExcluirEquipamento
@IdEquipamento = 1		-- CONSULTAR EQUIPAMENTOS (SELECT * FROM tbl_Equipamento)

-- EXCLUIR CLIENTE
EXEC sp_ExcluirCliente
@IdCliente = 1			-- CONSULTAR CLIENTES (SELECT * FROM tbl_Cliente)

-- EXCLUIR VENDA
EXEC sp_ExcluirVenda
@IdVenda = 1			-- CONSULTAR VENDAS (SELECT * FROM tbl_Venda)

-- CALCULAR O VALOR TOTAL DA VENDA
SELECT DBO.fnc_CalcularValorTotalVenda (1)

-- CONSULTA PAGAMENTO VENDA
SELECT * FROM tbl_VendaPagamento

