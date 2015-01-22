set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaERPItem_Microsiga.sql
**		Name: SP_G_PedidoVendaERPItem_Microsiga
**		Desc: Seleciona os registros da tabela Pedido Venda ERP Item para Exportação Microsiga
**
**		Auth: Roberto Chaparro
**		Date: Mai 19 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaERPItem_Microsiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaERPItem_Microsiga]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaERPItem_Microsiga]
	@cdPedidoVendaERPSEQ		bigint

AS

	select
		 isnull(convert(varchar, dtAnoMesPedidoVendaItemEntrega, 112), '')		as ENTREG
		,cdPedidoVendaERPItemSEQ												as ITEMSFA
		,vrUnitarioMoedaPedidoVendaERPItem										as PRCVEN

		,(
		SELECT
			cdProdutoERP
		FROM
			dbo.Produto	PRO
		WHERE
			PRO.cdProdutoSEQ = ERP.cdProdutoSEQ
		)	as PRODUTO

		,qtPedidoVendaERPItem													as QTDVEN

	from
		dbo.PedidoVendaERPItem	ERP
	where
		cdPedidoVendaERPSEQ = @cdPedidoVendaERPSEQ

	

SET QUOTED_IDENTIFIER OFF

