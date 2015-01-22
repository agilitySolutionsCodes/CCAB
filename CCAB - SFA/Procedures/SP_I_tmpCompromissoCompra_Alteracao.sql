set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpCompromissoCompra_Alteracao.sql
**		Name: SP_I_tmpCompromissoCompra_Alteracao
**		Desc: Insere um registro na tabela tmpCompromissoCompra - somente para Alteracoes
**
**		Auth: Convergence
**		Date: 08/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpCompromissoCompra_Alteracao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpCompromissoCompra_Alteracao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpCompromissoCompra_Alteracao]
	 @cdCompromissoCompraSEQ		BIGINT
 
	,@tmpCompromissoCompraSEQ		BIGINT	OUTPUT
AS
 
	-- Apaga Temporaria
	delete from tmpCompromissoCompra where cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
	
	delete from tmpCompromissoCompraItem where cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
	
	--Insere na tmpCompromissoCompra
	INSERT INTO tmpCompromissoCompra
		(
		 cdCompromissoCompraSEQ
		,cdAgenteComercialCooperativaCompromissoCompra
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
	SELECT	cdCompromissoCompraSEQ
			,cdAgenteComercialCooperativaCompromissoCompra
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
	FROM	
			CompromissoCompra
	WHERE
			cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ

	--retornos
	SELECT
		@tmpCompromissoCompraSEQ = SCOPE_IDENTITY()

	--Insere na tmpCompromissoCompraItem
	INSERT INTO tmpCompromissoCompraItem
		(
		 cdCompromissoCompraItemSEQ
		,tmpCompromissoCompraSEQ
		,cdCompromissoCompraSEQ
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
		)
	SELECT
		 a.cdCompromissoCompraItemSEQ
		,@tmpCompromissoCompraSEQ
		,a.cdCompromissoCompraSEQ
		,a.cdProdutoSEQ
		,a.cdCronogramaSafraSEQ
		,a.cdCronogramaSafraVencimentoSEQ
		,a.qtCompromissoCompraItem
		,a.qtAbertoCompromissoCompraItem
		,(case c.cdIndicadorMoedaCompromissoCompra
			when 1 then b.vrRealPessoaTabelaPrecoProduto
			when 2 then b.vrDolarPessoaTabelaPrecoProduto
			else        b.vrDolarPessoaTabelaPrecoProduto
		  end )as vrUnitarioMoedaCompromissoCompraItem
		,a.vrTotalMoedaCompromissoCompraItem
		,a.vrTotalMoedaAbertoCompromissoCompraItem
		,a.dtUltimaAlteracao
		,a.cdUsuarioUltimaAlteracao
	FROM
		CompromissoCompraItem a,
		PessoaTabelaPrecoProduto b,
		Compromissocompra c
	WHERE
		a.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
    and a.cdCompromissoCompraSEQ = c.cdCompromissocompraSEQ
	and	b.cdPessoaSEQ = c.cdAgenteComercialCooperativaCompromissoCompra
	and	a.cdCronogramaSafraSEQ = b.cdCronogramaSafraSEQ
	and	a.cdProdutoSEQ = b.cdProdutoSEQ
    and a.cdCronogramaSafraVencimentoSEQ = b.cdCronogramaSafraVencimentoSEQ
	

	--retornos
		SELECT
			@tmpCompromissoCompraSEQ as tmpCompromissoCompraSEQ

