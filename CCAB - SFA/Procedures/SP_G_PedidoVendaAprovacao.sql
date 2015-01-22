set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaAprovacao.sql
**		Name: SP_G_PedidoVendaAprovacao
**		Desc: Seleciona os registros da tabela Pedido Venda para liberação CCAB
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaAprovacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaAprovacao]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaAprovacao]
	 @cdAgenteComercialCooperativaPedidoVenda	bigint  = null
	,@cdCronogramaSafraSEQ						bigint 
	,@cdClienteFaturamentoPedidoVenda			bigint	= null
	,@cdClienteEntregaPedidoVenda				bigint	= null
	,@cdIndicadorMoedaPedidoVenda				int		= null
	,@cdPedidoVendaSEQ							bigint	= null
	,@cdPessoaOrigemFaturamento					bigint  = null
	,@cdTipoPedidoVenda							int		= null


AS

	DECLARE
		@lsComando		varchar(max)

	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  		 A.cdPedidoVendaSEQ'
		,@lsComando = @lsComando + '	  		,A.dtDigitacaoPedidoVenda'
		,@lsComando = @lsComando + '	  		,A.dtEmissaoPedidoVenda'
		,@lsComando = @lsComando + '            ,A.cdAgenteComercialCooperativaPedidoVenda'
		,@lsComando = @lsComando + '	  		,(ltrim(rtrim(D.nmPessoa)) + ' + '''-''' + ' + ltrim(rtrim(D.cdPessoaERP))) as dsAgenteComercialCooperativaPedidoVenda'
		,@lsComando = @lsComando + '            ,A.cdPessoaOrigemFaturamento'
		,@lscomando = @lsComando + '            ,(ltrim(rtrim(E.nmPessoa)) + ' + '''-''' + ' + ltrim(rtrim(E.cdPessoaERP))) as dsPessoaOrigemFaturamento' 
		,@lsComando = @lsComando + '	  		,A.cdClienteFaturamentoPedidoVenda'
		,@lsComando = @lsComando + '	  		,(ltrim(rtrim(B.nmPessoa)) + ' + '''-''' + ' + ltrim(rtrim(B.cdPessoaERP))) as dsClienteFaturamentoPedidoVenda'
		,@lsComando = @lsComando + '	  		,A.cdClienteEntregaPedidoVenda'
		,@lsComando = @lsComando + '	  		,(ltrim(rtrim(C.nmPessoa)) + ' + '''-''' + ' + ltrim(rtrim(C.cdPessoaERP))) as dsClienteEntregaPedidoVenda'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorMoedaPedidoVenda'
		,@lsComando = @lsComando + '	  		,('
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorMoedaPedidoVenda'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORMOEDA'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorMoedaPedidoVenda'
		,@lsComando = @lsComando + '	  		,dbo.FN_FormatarValor(A.vrTotalMoedaPedidoVenda,2) as vrTotalMoedaPedidoVenda'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorStatusPedidoVenda'
		,@lsComando = @lsComando + '	  		,('		
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorStatusPedidoVenda'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMPESPINDICADORSTATUSPEDIDO'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorStatusPedidoVenda'

		,@lsComando = @lsComando + '	  	FROM'
		,@lsComando = @lsComando + '	  		dbo.PedidoVenda	A (nolock)'
		,@lsComando = @lsComando + '	  	   ,dbo.Pessoa		B (nolock)'
		,@lsComando = @lsComando + '	  	   ,dbo.Pessoa		C (nolock)'
		,@lsComando = @lsComando + '           ,dbo.Pessoa      D (nolock)'
		,@lscomando = @lscomando + '           ,dbo.Pessoa      E (nolock)'
		
		,@lsComando = @lsComando + '		WHERE '
		,@lsComando = @lsComando + '		 	A.cdClienteFaturamentoPedidoVenda	= B.cdPessoaSEQ ' 
		,@lsComando = @lsComando + '		and	A.cdClienteEntregaPedidoVenda		= C.cdPessoaSEQ ' 
		,@lsComando = @lsComando + '        and A.cdAgenteComercialCooperativaPedidoVenda = D.cdPessoaSEQ '
		,@lsComando = @lscomando + '        and A.cdPessoaOrigemFaturamento = E.cdPessoaSEQ '

		-- Situação para Liberação Pedido CCAB (1 - Digitado, 4 - Rejeitado pela CCAB)
		select
			@lsComando = @lsComando + '	AND	A.cdIndicadorStatusPedidoVenda in (2) ' 
		
		
		IF NOT @cdAgenteComercialCooperativaPedidoVenda is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdAgenteComercialCooperativaPedidoVenda = ' + convert(varchar, @cdAgenteComercialCooperativaPedidoVenda) + ' '
		END

		IF NOT @cdPessoaOrigemFaturamento is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdPessoaOrigemFaturamento = ' + convert(varchar, @cdPessoaOrigemFaturamento) + ' '
		END


		IF NOT @cdCronogramaSafraSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCronogramaSafraSEQ = ' + convert(varchar, @cdCronogramaSafraSEQ) + ' '
		END

		IF NOT @cdClienteFaturamentoPedidoVenda is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdClienteFaturamentoPedidoVenda	= ' + convert(varchar, @cdClienteFaturamentoPedidoVenda) + ' '
		END

		IF NOT @cdClienteEntregaPedidoVenda is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdClienteEntregaPedidoVenda	= ' + convert(varchar, @cdClienteEntregaPedidoVenda) + ' '
		END

		IF NOT @cdIndicadorMoedaPedidoVenda is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorMoedaPedidoVenda = ' + convert(varchar, @cdIndicadorMoedaPedidoVenda) + ' '
		END

		IF NOT @cdPedidoVendaSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdPedidoVendaSEQ = ' + convert(varchar, @cdPedidoVendaSEQ) + ' '
		END

		IF NOT @cdTipoPedidoVenda is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdTipoPedidoVenda = ' + convert(varchar, @cdTipoPedidoVenda) + ' '
		END


	select
		 @lsComando = @lsComando + '	  	ORDER BY'
		,@lsComando = @lsComando + '	  		A.cdPedidoVendaSEQ '
		

	exec(@lsComando)
	--print @lsComando
	

SET QUOTED_IDENTIFIER OFF

