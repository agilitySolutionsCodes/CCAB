set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_PedidoVendaItemEntrega.sql
**		Name: TR_PedidoVendaItemEntrega
**		Desc: Trigger de históricos da tabela PedidoVendaItemEntrega
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_PedidoVendaItemEntrega]'))
BEGIN
	DROP TRIGGER [dbo].[TR_PedidoVendaItemEntrega]
END
GO
 
CREATE TRIGGER [dbo].[TR_PedidoVendaItemEntrega] ON dbo.PedidoVendaItemEntrega
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
	INSERT INTO PedidoVendaItemEntregaHistorico
	(
		 cdPedidoVendaItemEntregaSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,dtAnoMesPedidoVendaItemEntrega
		,qtPedidoVendaItemEntrega
		,cdIndicadorPedidoVendaItemEntrega
		,wkRCPedidoVendaItemEntrega
		,wkClientePedidoVendaItemEntrega
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdPedidoVendaItemEntregaSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,dtAnoMesPedidoVendaItemEntrega
		,qtPedidoVendaItemEntrega
		,cdIndicadorPedidoVendaItemEntrega
		,wkRCPedidoVendaItemEntrega
		,wkClientePedidoVendaItemEntrega
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
