set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_PedidoVendaItemCultura.sql
**		Name: TR_PedidoVendaItemCultura
**		Desc: Trigger de históricos da tabela PedidoVendaItemCultura
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_PedidoVendaItemCultura]'))
BEGIN
	DROP TRIGGER [dbo].[TR_PedidoVendaItemCultura]
END
GO
 
CREATE TRIGGER [dbo].[TR_PedidoVendaItemCultura] ON dbo.PedidoVendaItemCultura
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
	INSERT INTO PedidoVendaItemCulturaHistorico
	(
		 cdPedidoVendaItemCulturaSEQ
		,cdPedidoVendaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdTipoCulturaSEQ
		,qtPedidoVendaItemCultura
		,cdIndicadorPedidoVendaItemCultura
		,wkRCPedidoVendaItemCultura
		,wkClientePedidoVendaItemCultura
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdPedidoVendaItemCulturaSEQ
		,cdPedidoVendaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdTipoCulturaSEQ
		,qtPedidoVendaItemCultura
		,cdIndicadorPedidoVendaItemCultura
		,wkRCPedidoVendaItemCultura
		,wkClientePedidoVendaItemCultura
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
