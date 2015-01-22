set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaERPItem.sql
**		Name: SP_G_PedidoVendaERPItem
**		Desc: Seleciona os registros da tabela Pedido Venda
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaERPItem]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaERPItem]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaERPItem]
	 @cdPedidoVendaERPSEQ	bigint	

AS

	-- Busca Itens Pedido ERP
	SELECT	 isnull(A.cdPedidoVendaItemERP,'') as cdPedidoVendaItemERP
			,B.dsProduto
			,A.dtAnoMesPedidoVendaItemEntrega
			,A.qtPedidoVendaERPItem
			,A.qtAbertoPedidoVendaERPItem
			,A.vrUnitarioMoedaPedidoVendaERPItem
			,A.vrTotalMoedaPedidoVendaERPItem
			,A.vrTotalMoedaAbertoPedidoVendaERPItem
			,(SELECT
					wkDominioCodigoReferenciado
			  FROM
					dbo.CodigoReferenciado (nolock)
			  WHERE
					vrDominioCodigoReferenciado		= A.cdIndicadorStatusPedidoVendaERPItem
			  AND	dsDominioCodigoReferenciado		= 'DMPESPINDICADORSTATUSPEDIDO'
			  )	as dsIndicadorStatusPedido
			,dbo.FN_FormatarValor(A.pcDescontoPontualidade,2) as pcDescontoPontualidade	

	FROM	 dbo.PedidoVendaERPItem  A (nolock)		  
			,dbo.Produto		     B (nolock)
			
	WHERE	A.cdProdutoSEQ = B.cdProdutoSEQ
	AND     A.cdPedidoVendaERPSEQ = @cdPedidoVendaERPSEQ
	
	ORDER BY B.dsProduto, A.dtAnoMesPedidoVendaItemEntrega
	
SET QUOTED_IDENTIFIER OFF

