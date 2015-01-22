set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_CompromissoCompra_Moeda
**		Name: SP_S_CompromissoCompra_Moeda
**		Desc: Seleciona registros da Moeda de um Compromisso de Compra
**
**		Auth: Roberto Chaparro
**		Date: Abr 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CompromissoCompra_Moeda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CompromissoCompra_Moeda]
END
GO

CREATE PROCEDURE [dbo].[SP_S_CompromissoCompra_Moeda]
	 @cdAgenteComercialCooperativaCompromissoCompra		bigint
	,@cdCronogramaSafraSEQ								bigint
	,@cdPessoaOrigemFaturamento							bigint

AS


	select
		CCP.cdIndicadorMoedaCompromissoCompra as cdIndicadorMoedaCompromissoCompra
		,(
		SELECT 
		wkDominioCodigoReferenciado
		FROM
		dbo.CodigoReferenciado
		WHERE
		vrDominioCodigoReferenciado = CCP.cdIndicadorMoedaCompromissoCompra
		AND	dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA'
		)	as dsIndicadorMoedaCompromissoCompra
	from
		dbo.CompromissoCompra CCP
	where
		cdAgenteComercialCooperativaCompromissoCompra	= @cdAgenteComercialCooperativaCompromissoCompra
	and	cdCronogramaSafraSEQ							= @cdCronogramaSafraSEQ
	and cdPessoaOrigemFaturamento						= @cdPessoaOrigemFaturamento




