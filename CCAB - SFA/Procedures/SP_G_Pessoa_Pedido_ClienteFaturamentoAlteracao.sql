set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_Pedido_ClienteFaturamentoAlteracao
**		Name: SP_G_Pessoa_Pedido_ClienteFaturamentoAlteracao
**		Desc: Seleciona registros de um Cliente Faturamento (Pedidos)
**
**		Auth: Roberto Chaparro
**		Date: Abr 1 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_Pedido_ClienteFaturamentoAlteracao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_Pedido_ClienteFaturamentoAlteracao]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_Pedido_ClienteFaturamentoAlteracao]
	@cdPedidoVendaSEQ bigint

AS

	Declare @cdPessoaERP varchar(30)
	Declare @cdPessoaSEQ bigint
	
	-- Busco codigo ERP do Cliente de Faturamento do Pedido
	select 
		@cdPessoaSEQ = cdClienteFaturamentoPedidoVenda
	from 
		dbo.tmpPedidoVenda
	where 
		tmpPedidoVendaSEQ = @cdPedidoVendaSEQ
	
	-- Busca o codigo ERP da Pessoa
	select
		@cdPessoaERP = substring(cdPessoaERP, 1, len(cdPessoaERP) - 2)
	from 
		dbo.Pessoa
	where
		cdPessoaSEQ = @cdPessoaSEQ
	
	set nocount on
	
	select distinct
		 cdPessoaSEQ
		,nmPessoa + '-' + cdPessoaERP		as nmPessoa
	from
		dbo.Pessoa
	where
		substring(cdPessoaERP, 1, len(cdPessoaERP) - 2) = @cdPessoaERP
	and	cdIndicadorTipoPerfilPessoa			= 1 -- Cliente
	order by
		nmPessoa

	set nocount off

