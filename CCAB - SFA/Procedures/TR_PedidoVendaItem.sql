set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_PedidoVendaItem.sql
**		Name: TR_PedidoVendaItem
**		Desc: Trigger de históricos da tabela PedidoVendaItem
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_PedidoVendaItem]'))
BEGIN
	DROP TRIGGER [dbo].[TR_PedidoVendaItem]
END
GO
 
CREATE TRIGGER [dbo].[TR_PedidoVendaItem] ON dbo.PedidoVendaItem
AFTER INSERT, UPDATE
AS
 
declare
	@cdTipoEventoHistorico		int
 
	IF EXISTS (SELECT * FROM deleted)	-- Alteração
	BEGIN
		select
			@cdTipoEventoHistorico	= 2
	END
	ELSE
	BEGIN
		select
			@cdTipoEventoHistorico	= 1
	END
 
	--inserção
	INSERT INTO PedidoVendaItemHistorico
	(
		 cdPedidoVendaItemSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtPedidoVendaItem
		,qtAbertoPedidoVendaItem
		,vrUnitarioMoedaPedidoVendaItem
		,vrTotalMoedaPedidoVendaItem
		,vrTotalMoedaAbertoPedidoVendaItem
		,cdPedidoVendaERP
		,cdPedidoVendaItemERP
		,cdFilialFaturadoraERP
		,cdIndicadorStatusPedidoVendaItem
		,wkRCPedidoVendaItem
		,wkClientePedidoVendaItem
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,pcDescontoPontualidade
	)
	SELECT
		 cdPedidoVendaItemSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtPedidoVendaItem
		,qtAbertoPedidoVendaItem
		,vrUnitarioMoedaPedidoVendaItem
		,vrTotalMoedaPedidoVendaItem
		,vrTotalMoedaAbertoPedidoVendaItem
		,cdPedidoVendaERP
		,cdPedidoVendaItemERP
		,cdFilialFaturadoraERP
		,cdIndicadorStatusPedidoVendaItem
		,wkRCPedidoVendaItem
		,wkClientePedidoVendaItem
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,pcDescontoPontualidade

	FROM
		inserted
