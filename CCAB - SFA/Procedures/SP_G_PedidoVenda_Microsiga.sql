set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVenda_Microsiga.sql
**		Name: SP_G_PedidoVenda_Microsiga
**		Desc: Seleciona os registros da tabela Pedido Venda para Exportação Microsiga
**
**		Auth: Roberto Chaparro
**		Date: Mai 19 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVenda_Microsiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVenda_Microsiga]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVenda_Microsiga]
			


AS



	DECLARE
		@lsComando		varchar(max)

	select
		 @lsComando = '					SELECT '

		,@lsComando = @lsComando + '		 cdPedidoVendaSEQ '
		,@lsComando = @lsComando + '		,convert(varchar, dtEmissaoPedidoVenda, 112)			as EMISSAO '
		,@lsComando = @lsComando + '		,cdIndicadorMoedaPedidoVenda	as MOEDA '

		,@lsComando = @lsComando + '	  	,('		
		,@lsComando = @lsComando + '	  		SELECT'
		,@lsComando = @lsComando + '	  			left(cdPessoaERP, len(cdPessoaERP)-2)'
		,@lsComando = @lsComando + '	  		FROM'
		,@lsComando = @lsComando + '	  			dbo.Pessoa			(nolock)'
		,@lsComando = @lsComando + '	  		WHERE'
		,@lsComando = @lsComando + '	  			cdPessoaSEQ		= cdClienteEntregaPedidoVenda'
		,@lsComando = @lsComando + '	  	)	as XCLIENT'

		,@lsComando = @lsComando + '	  	,('		
		,@lsComando = @lsComando + '	  		SELECT'
		,@lsComando = @lsComando + '	  			left(cdPessoaERP, len(cdPessoaERP)-2)'
		,@lsComando = @lsComando + '	  		FROM'
		,@lsComando = @lsComando + '	  			dbo.Pessoa			(nolock)'
		,@lsComando = @lsComando + '	  		WHERE'
		,@lsComando = @lsComando + '	  			cdPessoaSEQ		= cdClienteFaturamentoPedidoVenda'
		,@lsComando = @lsComando + '	  	)	as XCLIFAT'

		-----

		,@lsComando = @lsComando + '	  	,('		
		,@lsComando = @lsComando + '	  		SELECT'
		,@lsComando = @lsComando + '	  			right(cdPessoaERP, 2)'
		,@lsComando = @lsComando + '	  		FROM'
		,@lsComando = @lsComando + '	  			dbo.Pessoa			(nolock)'
		,@lsComando = @lsComando + '	  		WHERE'
		,@lsComando = @lsComando + '	  			cdPessoaSEQ		= cdClienteEntregaPedidoVenda'
		,@lsComando = @lsComando + '	  	)	as XLOJAENT'

		,@lsComando = @lsComando + '	  	,('		
		,@lsComando = @lsComando + '	  		SELECT'
		,@lsComando = @lsComando + '	  			right(cdPessoaERP, 2)'
		,@lsComando = @lsComando + '	  		FROM'
		,@lsComando = @lsComando + '	  			dbo.Pessoa			(nolock)'
		,@lsComando = @lsComando + '	  		WHERE'
		,@lsComando = @lsComando + '	  			cdPessoaSEQ		= cdClienteFaturamentoPedidoVenda'
		,@lsComando = @lsComando + '	  	)	as XLOJAFAT '

		,@lsComando = @lsComando + '		,CASE cdTipoPedidoVenda WHEN 1 THEN 3 WHEN 2 THEN 2 ELSE 3 END as XTPPED '
		,@lsComando = @lsComando + '        ,15.35 as XDESPER '

		,@lsComando = @lsComando + '	FROM'
		,@lsComando = @lsComando + '		dbo.PedidoVenda '
		,@lsComando = @lsComando + '	WHERE '
		,@lsComando = @lsComando + '		cdIndicadorStatusPedidoVenda = 5 '  --Liberado para o Microsiga
		,@lsComando = @lscomando + '    AND cdPessoaOrigemFaturamento IN (SELECT cdPessoaSEQ from dbo.Pessoa (nolock) where cdPessoaERP = ' + '''9999''' + ' ) ' --Somente Origem CCAB vai para o Microsiga.

		,@lsComando = @lsComando + '	ORDER BY'
		,@lsComando = @lsComando + '		dtUltimaAlteracao'



	exec(@lsComando)
--	print @lsComando
	

SET QUOTED_IDENTIFIER OFF

