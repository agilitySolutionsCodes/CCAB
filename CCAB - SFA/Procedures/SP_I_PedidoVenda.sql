set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_PedidoVenda.sql
**		Name: SP_U_PedidoVenda
**		Desc: Efetiva a Gravação do Pedido
**
**		Auth: Convergence
**		Date: 16/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_PedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_PedidoVenda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_PedidoVenda]
	 @tmpPedidoVendaSEQ	BIGINT
	,@cdPedidoVendaSEQ	BIGINT	OUTPUT
AS

	-- Efetiva Tabela PedidoVenda
	INSERT INTO PedidoVenda
		(
		 cdAgenteComercialCooperativaPedidoVenda
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
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,cdPessoaOrigemFaturamento
		,cdTipoProduto
		)
	SELECT
		 cdAgenteComercialCooperativaPedidoVenda
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
		,(select sum(vrTotalMoedaPedidoVendaItem)
		  from tmpPedidoVendaItem
		  where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ) as vrTotalMoedaPedidoVenda
		,(select sum(vrTotalMoedaPedidoVendaItem)
		  from tmpPedidoVendaItem
		  where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ) as vrTotalAbertoMoedaPedidoVenda		
		,cdPedidoVendaERP
		,cdFilialFaturadoraERP
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,cdPessoaOrigemFaturamento
		,cdTipoProduto
	FROM
		tmpPedidoVenda
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	--retornos
	SELECT
		@cdPedidoVendaSEQ = SCOPE_IDENTITY()

	-- Efetiva PedidoVendaItem
	INSERT INTO PEDIDOVENDAITEM
		(
		 cdPedidoVendaSEQ
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
		,pcDescontoPontualidade
		)
	SELECT
		 @cdPedidoVendaSEQ
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
		,dbo.FN_BuscaPontualidadePedido(@tmpPedidoVendaSEQ, cdCronogramaSafraVencimentoSEQ,1)
	FROM
		tmpPedidoVendaItem
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ		   
			
	-- Efetiva PedidoVendaItemEntrega
	INSERT INTO PEDIDOVENDAITEMENTREGA
		(
		 cdPedidoVendaSEQ
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
		@cdPedidoVendaSEQ
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
		tmpPedidoVendaItemEntrega
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ			
 
	-- Efetiva PedidoVendaItemCultura
	INSERT INTO PEDIDOVENDAITEMCULTURA
		(
		 cdPedidoVendaSEQ
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
		@cdPedidoVendaSEQ
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
		tmpPedidoVendaItemCultura
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		
	-- Exclui as tabelas temporarias
	delete from tmppedidovenda where tmppedidovendaseq = @tmpPedidoVendaSEQ
	
	delete from tmppedidovendaitem where tmppedidovendaseq = @tmpPedidoVendaSEQ
	
	delete from tmppedidovendaitementrega where tmppedidovendaseq = @tmpPedidoVendaSEQ
	
	delete from tmppedidovendaitemcultura where tmppedidovendaseq = @tmpPedidoVendaSEQ

	-- Retorno
	SELECT
		@cdPedidoVendaSEQ as cdPedidoVendaSEQ
