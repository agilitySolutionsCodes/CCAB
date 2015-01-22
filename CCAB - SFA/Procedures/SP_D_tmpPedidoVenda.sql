set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_tmpPedidoVenda
**		Name: SP_D_tmpPedidoVenda
**		Desc: Exclui o registro da tabela tmpPedidoVendaItem
**
**		Auth: Roberto Chaparro
**		Date: Abr 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_tmpPedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_tmpPedidoVenda]
END
GO

CREATE PROCEDURE [dbo].[SP_D_tmpPedidoVenda]
	 @tmpPedidoVendaSEQ			bigint
AS

	-- Exclui a Tabela TMP de Itens
	DELETE
		dbo.tmpPedidoVendaItem
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	-- Exclui a Tabela TMP de Pedidos
	DELETE 
		dbo.tmpPedidoVenda
	WHERE
		tmpPedidoVendaSEQ =  @tmpPedidoVendaSEQ

	-- Exclui a Tabela TMP de Entrega
	DELETE
		dbo.tmpPedidoVendaItemEntrega
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		
	-- Exclui a Tabela TMP de Cultura
	DELETE
		dbo.tmpPedidoVendaItemCultura
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
			




