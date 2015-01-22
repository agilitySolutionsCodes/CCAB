set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_PedidoVenda.sql
**		Name: TR_PedidoVenda
**		Desc: Trigger de históricos da tabela PedidoVenda
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_PedidoVenda]'))
BEGIN
	DROP TRIGGER [dbo].[TR_PedidoVenda]
END
GO
 
CREATE TRIGGER [dbo].[TR_PedidoVenda] ON dbo.PedidoVenda
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
	INSERT INTO PedidoVendaHistorico
	(
		 cdPedidoVendaSEQ
		,cdAgenteComercialCooperativaPedidoVenda
		,cdAgenteComercialCCABPedidoVenda
		,cdAgenteComercialRCPedidoVenda
		,cdClienteFaturamentoPedidoVenda
		,cdClienteEntregaPedidoVenda
		,cdCompromissoCompraSEQ
		,cdCronogramaSafraSEQ
		,dtDigitacaoPedidoVenda
		,dtEmissaoPedidoVenda
		,cdTipoPedidoVenda
		,cdModalidadePedidoVenda
		,cdIndicadorStatusPedidoVenda
		,cdIndicadorMoedaPedidoVenda
		,vrTotalMoedaPedidoVenda
		,vrTotalAbertoMoedaPedidoVenda
		,cdPedidoVendaERP
		,cdFilialFaturadoraERP
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdPessoaOrigemFaturamento
		,cdTipoProduto
	)
	SELECT
		 cdPedidoVendaSEQ
		,cdAgenteComercialCooperativaPedidoVenda
		,cdAgenteComercialCCABPedidoVenda
		,cdAgenteComercialRCPedidoVenda
		,cdClienteFaturamentoPedidoVenda
		,cdClienteEntregaPedidoVenda
		,cdCompromissoCompraSEQ
		,cdCronogramaSafraSEQ
		,dtDigitacaoPedidoVenda
		,dtEmissaoPedidoVenda
		,cdTipoPedidoVenda
		,cdModalidadePedidoVenda
		,cdIndicadorStatusPedidoVenda
		,cdIndicadorMoedaPedidoVenda
		,vrTotalMoedaPedidoVenda
		,vrTotalAbertoMoedaPedidoVenda
		,cdPedidoVendaERP
		,cdFilialFaturadoraERP
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,cdPessoaOrigemFaturamento
		,cdTipoProduto

	FROM
		inserted
