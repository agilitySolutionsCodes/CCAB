set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_CompromissoCompraResumoDados_TMP
**		Name: SP_G_CompromissoCompraResumoDados_TMP
**		Desc: Seleciona o dados para a tela de resumo
**
**		Auth: Roberto Chaparro
**		Date: Mar 11 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CompromissoCompraResumoDados_TMP]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CompromissoCompraResumoDados_TMP]
END
GO

CREATE PROCEDURE [dbo].[SP_G_CompromissoCompraResumoDados_TMP]
	 @tmpCompromissoCompraSEQ		bigint
	 
AS

	BEGIN
	
		select	a.cdAgenteComercialCooperativaCompromissoCompra,
				(ltrim(rtrim(b.nmPessoa))) + '-' + ltrim(rtrim(b.cdPessoaERP)) as dsAgenteComercialCooperativaCompromissoCompra,
				a.cdCompromissoCompraSEQ,
				a.cdCronogramaSafraSEQ,
				c.dsCronogramaSafra,
				a.dtEmissaoCompromissoCompra,
				a.cdIndicadorStatusCompromissoCompra,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdIndicadorStatusCompromissoCompra
					and		dsDominioCodigoReferenciado = 'DMESPINDICADORSTATUSCOMPROMISSOCOMPRA'
				) as dsIndicadorStatusCompromissoCompra,
				a.cdIndicadorMoedaCompromissoCompra,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdIndicadorMoedaCompromissoCompra
					and		dsDominioCodigoReferenciado = 'DMPESPINDICADORMOEDA'
				) as dsIndicadorMoedaCompromissoCompra,
				a.vrTotalMoedaCompromissoCompra,
				a.vrTotalAbertoMoedaCompromissoCompra,
				a.cdAgenteComercialCCABCompromissoCompra,
				(ltrim(rtrim(d.nmPessoa))) + '-' + ltrim(rtrim(d.cdPessoaERP)) as dsAgenteComercialCCABCompromissoCompra,
				a.cdAgenteComercialRCCompromissoCompra,
				(ltrim(rtrim(e.nmPessoa))) + '-' + ltrim(rtrim(e.cdPessoaERP)) as dsAgenteComercialRCCompromissoCompra,
				a.dtUltimaAlteracao,
				a.cdUsuarioUltimaAlteracao,
				a.cdPessoaOrigemFaturamento,
				(ltrim(rtrim(f.nmPessoa))) + '-' + ltrim(rtrim(f.cdPessoaERP)) as dsPessoaOrigemFaturamento
		from	tmpCompromissoCompra a left join
				Pessoa b on a.cdAgenteComercialCooperativaCompromissoCompra = b.cdPessoaSEQ left join
				CronogramaSafra c on a.cdCronogramaSafraSEQ = c.cdCronogramaSafraSEQ left join
				Pessoa d on a.cdAgenteComercialCCABCompromissoCompra = d.cdPessoaSEQ left join
				Pessoa e on a.cdAgenteComercialRCCompromissoCompra = e.cdPessoaSEQ  left join
				Pessoa f on a.cdPessoaOrigemFaturamento = f.cdPessoaSEQ 
		where	a.tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ

	END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO