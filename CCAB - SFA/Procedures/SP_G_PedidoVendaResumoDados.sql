set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaResumoDados
**		Name: SP_G_PedidoVendaResumoDados
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaResumoDados]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaResumoDados]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaResumoDados]
	 @cdPedidoVendaSEQ	bigint
	 
AS

	BEGIN
	
		select	a.cdAgenteComercialCooperativaPedidoVenda,
				(ltrim(rtrim(b.nmPessoa))) + '-' + ltrim(rtrim(b.cdPessoaERP)) as dsAgenteComercialCooperativaPedidoVenda,
				a.cdPessoaOrigemFaturamento,
				(ltrim(rtrim(h.nmPessoa))) + '-' + ltrim(rtrim(h.cdPessoaERP)) as dsPessoaOrigemFaturamento,
				a.cdCompromissoCompraSEQ,
				a.cdCronogramaSafraSEQ,
				c.dsCronogramaSafra,
				a.dtDigitacaoPedidoVenda,
				a.dtEmissaoPedidoVenda,
				a.cdTipoPedidoVenda,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdTipoPedidoVenda
					and		dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOPEDIDO'
				) as dsTipoPedidoVenda,
				a.cdModalidadePedidoVenda,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdModalidadePedidoVenda
					and		dsDominioCodigoReferenciado = 'DMESPINDICADORMODALIDADEPEDIDO'
				) as dsModalidadePedidoVenda,
				a.cdIndicadorStatusPedidoVenda,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdIndicadorStatusPedidoVenda
					and		dsDominioCodigoReferenciado = 'DMPESPINDICADORSTATUSPEDIDO'
				) as dsIndicadorStatusPedidoVenda,
				a.cdIndicadorMoedaPedidoVenda,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdIndicadorMoedaPedidoVenda
					and		dsDominioCodigoReferenciado = 'DMPESPINDICADORMOEDA'
				) as dsIndicadorMoedaPedidoVenda,
				a.vrTotalMoedaPedidoVenda,
				a.vrTotalAbertoMoedaPedidoVenda,
				a.cdAgenteComercialCCABPedidoVenda,
				(ltrim(rtrim(d.nmPessoa))) + '-' + ltrim(rtrim(d.cdPessoaERP)) as dsAgenteComercialCCABPedidoVenda,
				a.cdAgenteComercialRCPedidoVenda,
				(ltrim(rtrim(e.nmPessoa))) + '-' + ltrim(rtrim(e.cdPessoaERP)) as dsAgenteComercialRCpedidoVenda,
				a.cdClienteFaturamentoPedidoVenda,
				(ltrim(rtrim(f.nmPessoa))) + '-' + ltrim(rtrim(f.cdPessoaERP)) as dsClienteFaturamentoPedidoVenda,
				a.cdClienteEntregaPedidoVenda,
				(ltrim(rtrim(g.nmPessoa))) + '-' + ltrim(rtrim(g.cdPessoaERP)) as dsClienteEntregaPedidoVenda,
				a.cdPedidoVendaERP,
				a.cdFilialFaturadoraERP,
				a.dtUltimaAlteracao,
				a.cdUsuarioUltimaAlteracao,
				a.cdPedidoVendaSEQ,
				a.cdTipoProduto,
				(
					select	wkDominioCodigoReferenciado
					from	dbo.CodigoReferenciado
					where	vrDominioCodigoReferenciado = a.cdTipoProduto
					and		dsDominioCodigoReferenciado = 'DMESPTIPOPRODUTO'
				) as dsTipoProduto


		from	PedidoVenda a left join
				Pessoa b on a.cdAgenteComercialCooperativaPedidoVenda = b.cdPessoaSEQ left join
				CronogramaSafra c on a.cdCronogramaSafraSEQ = c.cdCronogramaSafraSEQ left join
				Pessoa d on a.cdAgenteComercialCCABPedidoVenda = d.cdPessoaSEQ left join
				Pessoa e on a.cdAgenteComercialRCPedidoVenda = e.cdPessoaSEQ left join
				Pessoa f on a.cdClienteFaturamentoPedidoVenda = f.cdPessoaSEQ left join
				Pessoa g on a.cdClienteEntregaPedidoVenda = g.cdPessoaSEQ left join
				Pessoa h on a.cdpessoaOrigemFaturamento = h.cdPessoaSEQ
		where	a.cdPedidoVendaSEQ = @cdPedidoVendaSEQ

	END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO