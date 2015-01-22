set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpPedidoVenda_Alteracao.sql
**		Name: SP_I_tmpPedidoVenda_Alteracao
**		Desc: Insere um registro na tabela tmpPedidoVenda - somente para Alteracao
**
**		Auth: Convergence
**		Date: 02/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpPedidoVenda_Alteracao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpPedidoVenda_Alteracao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpPedidoVenda_Alteracao]
	 @cdPedidoVendaSEQ		BIGINT
 
	,@tmpPedidoVendaSEQ		BIGINT	OUTPUT
AS
 
	-- Apaga Temporaria
	delete from tmpPedidoVenda where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	
	delete from tmpPedidoVendaItem where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	
	delete from tmpPedidoVendaItemEntrega where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	
	delete from tmpPedidoVendaItemCultura where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
  
	--Insere na tmpPedidoVenda
	INSERT INTO tmpPedidoVenda
		(
		 cdPedidoVendaSEQ
		,cdAgenteComercialCooperativaPedidoVenda
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
		,cdAgenteComercialCCABPedidoVenda
		,cdAgenteComercialRCPedidoVenda
		,cdClienteFaturamentoPedidoVenda
		,cdClienteEntregaPedidoVenda
		,cdPedidoVendaERP
		,cdFilialFaturadoraERP
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,cdPessoaOrigemFaturamento
		,cdTipoProduto
		)
	SELECT	 cdPedidoVendaSEQ
			,cdAgenteComercialCooperativaPedidoVenda
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
			,cdAgenteComercialCCABPedidoVenda
			,cdAgenteComercialRCPedidoVenda
			,cdClienteFaturamentoPedidoVenda
			,cdClienteEntregaPedidoVenda
			,cdPedidoVendaERP
			,cdFilialFaturadoraERP
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao
			,cdPessoaOrigemFaturamento
			,cdTipoProduto
	FROM	
			PedidoVenda
	WHERE
			cdPedidoVendaSEQ = @cdPedidoVendaSEQ

	--retornos
	SELECT
		@tmpPedidoVendaSEQ = SCOPE_IDENTITY()

	--Insere na tmpPedidoVendaItem
	INSERT INTO tmpPedidoVendaItem
		(
		 tmpPedidoVendaSEQ
		,cdPedidoVendaItemSEQ
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
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		)
	SELECT
		 @tmpPedidoVendaSEQ
		,cdPedidoVendaItemSEQ
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
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		PedidoVendaItem
	WHERE
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ
			
	-- Efetiva PedidoVendaItemEntrega
	INSERT INTO tmpPedidoVendaItemEntrega
		(
		 tmpPedidoVendaSEQ
		,cdPedidoVendaItemEntregaSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,dtAnoMesPedidoVendaItemEntrega
		,qtPedidoVendaItemEntrega
		,cdIndicadorPedidoVendaItemEntrega
		,wkRCPedidoVendaItemEntrega
		,wkClientePedidoVendaItemEntrega
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		)
	SELECT
		@tmpPedidoVendaSEQ
		,cdPedidoVendaItemEntregaSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,dtAnoMesPedidoVendaItemEntrega
		,qtPedidoVendaItemEntrega
		,cdIndicadorPedidoVendaItemEntrega
		,wkRCPedidoVendaItemEntrega
		,wkClientePedidoVendaItemEntrega
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		PedidoVendaItemEntrega
	WHERE
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ
 
	-- Efetiva PedidoVendaItemCultura
	INSERT INTO tmpPedidoVendaItemCultura
		(
		 tmpPedidoVendaSEQ
		,cdPedidoVendaItemCulturaSEQ
		,cdPedidoVendaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdTipoCulturaSEQ
		,qtPedidoVendaItemCultura
		,cdIndicadorPedidoVendaItemCultura
		,wkRCPedidoVendaItemCultura
		,wkClientePedidoVendaItemCultura
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		)
	SELECT
		 @tmpPedidoVendaSEQ
		,cdPedidoVendaItemCulturaSEQ
		,cdPedidoVendaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdTipoCulturaSEQ
		,qtPedidoVendaItemCultura
		,cdIndicadorPedidoVendaItemCultura
		,wkRCPedidoVendaItemCultura
		,wkClientePedidoVendaItemCultura
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		PedidoVendaItemCultura
	WHERE
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ

	--retornos
		SELECT
			@tmpPedidoVendaSEQ as tmpPedidoVendaSEQ

