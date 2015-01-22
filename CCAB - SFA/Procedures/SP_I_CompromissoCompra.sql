set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_CompromissoCompra.sql
**		Name: SP_U_CompromissoCompra
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_CompromissoCompra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_CompromissoCompra]
	 @tmpCompromissoCompraSEQ	BIGINT
	,@cdCompromissoCompraSEQ	BIGINT	OUTPUT
AS

	-- Efetiva Tabela CompromissoCompra
	INSERT INTO CompromissoCompra
		(
		 cdAgenteComercialCooperativaCompromissoCompra
		,cdAgenteComercialCCABCompromissoCompra
		,cdAgenteComercialRCCompromissoCompra
		,cdCronogramaSafraSEQ
		,dtEmissaoCompromissoCompra
		,cdIndicadorStatusCompromissoCompra
		,cdIndicadorMoedaCompromissoCompra
		,vrTotalMoedaCompromissoCompra
		,vrTotalAbertoMoedaCompromissoCompra
		,cdPessoaOrigemFaturamento
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		)
	SELECT
		 cdAgenteComercialCooperativaCompromissoCompra
		,cdAgenteComercialCCABCompromissoCompra
		,cdAgenteComercialRCCompromissoCompra
		,cdCronogramaSafraSEQ
		,dtEmissaoCompromissoCompra
		,cdIndicadorStatusCompromissoCompra
		,cdIndicadorMoedaCompromissoCompra
		,(select sum(vrTotalMoedaCompromissoCompraItem)
		  from tmpCompromissoCompraItem
		  where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ) as vrTotalMoedaCompromissoCompra
		,(select sum(vrTotalMoedaCompromissoCompraItem)
		  from tmpCompromissoCompraItem
		  where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ) as vrTotalAbertoMoedaCompromissoCompra		
		,cdPessoaOrigemFaturamento
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		tmpCompromissoCompra
	WHERE
		tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ

	--retornos
	SELECT
		@cdCompromissoCompraSEQ = SCOPE_IDENTITY()

	-- Efetiva CompromissoCompraItem
	INSERT INTO CompromissoCompraITEM
		(
		 cdCompromissoCompraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtCompromissoCompraItem
		,qtAbertoCompromissoCompraItem
		,vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoCompromissoCompraItem
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,pcDescontoPontualidade
		)
	SELECT
		 @cdCompromissoCompraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtCompromissoCompraItem
		,qtAbertoCompromissoCompraItem
		,vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoCompromissoCompraItem
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,dbo.FN_BuscaPontualidadeCompromisso(@tmpCompromissoCompraSEQ, cdCronogramaSafraVencimentoSEQ,1)
	FROM
		tmpCompromissoCompraItem
	WHERE
		tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ		   
		
	-- Exclui as tabelas temporarias
	delete from tmpCompromissoCompra where tmpCompromissoCompraseq = @tmpCompromissoCompraSEQ
	
	delete from tmpCompromissoCompraitem where tmpCompromissoCompraseq = @tmpCompromissoCompraSEQ
	
	-- Retorno
	SELECT
		@cdCompromissoCompraSEQ as cdCompromissoCompraSEQ
