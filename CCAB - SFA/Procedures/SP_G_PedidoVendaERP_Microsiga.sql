set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaERP_Microsiga.sql
**		Name: SP_G_PedidoVendaERP_Microsiga
**		Desc: Seleciona os registros da tabela Pedido Venda ERP para Exportação Microsiga
**
**		Auth: Roberto Chaparro
**		Date: Mai 19 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaERP_Microsiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaERP_Microsiga]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaERP_Microsiga]
	@cdPedidoVendaSEQ		bigint

AS

	select
		 A.cdPedidoVendaERPSEQ
		,isnull(convert(varchar, A.dtVenctoPedidoVendaERP, 112), '')		as DATA1
		,A.cdPedidoVendaERPUsuario										as NUMSFA

		,
		CASE isnull(convert(varchar, A.dtVenctoPedidoVendaERP, 112), '')
			 WHEN '' THEN '0'
			 ELSE '100'
		END	AS PARC1

		,
		CASE isnull(convert(varchar, A.dtVenctoPedidoVendaERP, 112), '')
			 WHEN '' THEN '003'
			 ELSE '001'
		END	AS CONDPAG,
		
		(select distinct B.pcDescontoPontualidade from pedidovendaerpitem B where B.cdPedidoVendaERPSEQ = A.cdPedidoVendaERPSEQ) as pcDescontoPontualidade

	from
		dbo.PedidoVendaERP A
	where
		A.cdPedidoVendaSEQ = @cdPedidoVendaSEQ


SET QUOTED_IDENTIFIER OFF

