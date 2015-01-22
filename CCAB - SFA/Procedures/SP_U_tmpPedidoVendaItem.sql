set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpPedidoVendaItem.sql
**		Name: SP_U_tmpPedidoVendaItem
**		Desc: Altera um registro na tabela tmpPedidoVendaItem
**
**		Auth: Convergence
**		Date: 03/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpPedidoVendaItem]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpPedidoVendaItem]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpPedidoVendaItem]
	 @tmpPedidoVendaItemSEQ	BIGINT
	,@tmpPedidoVendaSEQ BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@cdCronogramaSafraVencimentoSEQ	BIGINT = NULL
	,@qtPedidoVendaItem	NUMERIC(22,4) = NULL
	,@vrTotalMoedaPedidoVendaItem	NUMERIC(22,4) = NULL
	,@vrTotalMoedaAbertoPedidoVendaItem	NUMERIC(22,4) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
 
AS

	declare @cdCompromissoCompraSEQ bigint
	declare @vrUnitarioMoedaCompromissoCompraItem numeric(22,4)

    -- Obtem o compromisso de compra
    set @cdCompromissoCompraSEQ = 0
    select @cdCompromissoCompraSEQ = cdCompromissoCompraSEQ
    from tmpPedidoVenda
    where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
 
	--Obtenho o Valor Unitário
	set @vrUnitarioMoedaCompromissoCompraItem = 0
	select
		@vrUnitarioMoedaCompromissoCompraItem = CCI.vrUnitarioMoedaCompromissoCompraItem
	from
		dbo.CompromissoCompraItem	CCI
	where
		CCI.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
	and	CCI.cdProdutoSEQ = @cdProdutoSEQ
	and CCI.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

	--atualização
	UPDATE tmpPedidoVendaItem SET
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		,cdProdutoSEQ = @cdProdutoSEQ
		,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
		,qtPedidoVendaItem = @qtPedidoVendaItem
		,qtAbertoPedidoVendaItem = @qtPedidoVendaItem
		,vrTotalMoedaPedidoVendaItem = @qtPedidoVendaItem * @vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoPedidoVendaItem = @qtPedidoVendaItem * @vrUnitarioMoedaCompromissoCompraItem
		,vrUnitarioMoedaPedidoVendaItem = @vrUnitarioMoedaCompromissoCompraItem
		,cdIndicadorStatusPedidoVendaItem = 1 -- @cdIndicadorStatusPedidoVendaItem (1 - Digitado)
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 tmpPedidoVendaItemSEQ = @tmpPedidoVendaItemSEQ
 
 
