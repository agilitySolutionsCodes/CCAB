set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVenda_PrePedido.sql
**		Name: SP_G_PedidoVenda_PrePedido
**		Desc: Seleciona os registros da tabela Pedido Venda, para o Relatório de Pré-Pedido
**
**		Auth: Roberto Chaparro
**		Date: Jun 23 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVenda_PrePedido]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVenda_PrePedido]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVenda_PrePedido]
	 @cdAgenteComercialCooperativaPedidoVenda	bigint	
	,@cdCronogramaSafraSEQ						bigint 
	,@cdClienteFaturamentoPedidoVenda			bigint	
	,@cdClienteEntregaPedidoVenda				bigint	
	,@cdIndicadorMoedaPedidoVenda				int		
	,@cdPedidoVendaSEQ							bigint	
	,@cdIndicadorStatusPedidoVenda				int		
	,@cdPessoaOrigemFaturamento					bigint  

AS

	DECLARE
		@lsComando		varchar(max)

	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  			cdPedidoVendaERPSEQ '
		,@lsComando = @lsComando + '			FROM '
		,@lsComando = @lsComando + '				dbo.PedidoVendaERP '
		,@lsComando = @lsComando + '			WHERE '
		,@lsComando = @lsComando + '				cdPedidoVendaSEQ IN ( '


		,@lsComando = @lsComando + '		SELECT '
		,@lsComando = @lsComando + '	  		A.cdPedidoVendaSEQ'

		,@lsComando = @lsComando + '	  	FROM'
		,@lsComando = @lsComando + '	  		dbo.PedidoVenda	A (nolock)'
		,@lsComando = @lsComando + '	  	   ,dbo.Pessoa		B (nolock)'
		,@lsComando = @lsComando + '	  	   ,dbo.Pessoa		C (nolock)'
		,@lsComando = @lsComando + '           ,dbo.Pessoa      D (nolock)'
		,@lsComando = @lscomando + '           ,dbo.Pessoa      E (nolock)'
		
		,@lsComando = @lsComando + '		WHERE '
		,@lsComando = @lsComando + '		 	A.cdClienteFaturamentoPedidoVenda	= B.cdPessoaSEQ ' 
		,@lsComando = @lsComando + '		and	A.cdClienteEntregaPedidoVenda		= C.cdPessoaSEQ ' 
		,@lsComando = @lsComando + '        and A.cdAgenteComercialCooperativaPedidoVenda = D.cdPessoaSEQ '
		,@lscomando = @lscomando + '        and A.cdPessoaOrigemFaturamento = E.cdPessoaSEQ '

		
		IF @cdAgenteComercialCooperativaPedidoVenda <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdAgenteComercialCooperativaPedidoVenda = ' + convert(varchar, @cdAgenteComercialCooperativaPedidoVenda) + ' '
		END

		IF @cdPessoaOrigemFaturamento <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdPessoaOrigemFaturamento = ' + convert(varchar, @cdPessoaOrigemFaturamento) + ' '
		END

		IF @cdCronogramaSafraSEQ <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCronogramaSafraSEQ = ' + convert(varchar, @cdCronogramaSafraSEQ) + ' '
		END

		IF @cdClienteFaturamentoPedidoVenda <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdClienteFaturamentoPedidoVenda	= ' + convert(varchar, @cdClienteFaturamentoPedidoVenda) + ' '
		END

		IF @cdClienteEntregaPedidoVenda <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdClienteEntregaPedidoVenda	= ' + convert(varchar, @cdClienteEntregaPedidoVenda) + ' '
		END

		IF @cdIndicadorMoedaPedidoVenda <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorMoedaPedidoVenda = ' + convert(varchar, @cdIndicadorMoedaPedidoVenda) + ' '
		END

		IF @cdPedidoVendaSEQ <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdPedidoVendaSEQ = ' + convert(varchar, @cdPedidoVendaSEQ) + ' '
		END

		IF @cdPedidoVendaSEQ <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdPedidoVendaSEQ = ' + convert(varchar, @cdPedidoVendaSEQ) + ' '
		END

		IF @cdIndicadorStatusPedidoVenda <> 0
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorStatusPedidoVenda = ' + convert(varchar, @cdIndicadorStatusPedidoVenda) + ' '
		END

	select
		 @lsComando = @lsComando + '	  	)'
		

	exec(@lsComando)
	

SET QUOTED_IDENTIFIER OFF

