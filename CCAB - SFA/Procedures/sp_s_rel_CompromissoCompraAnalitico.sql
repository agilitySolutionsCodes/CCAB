if exists(select * from sysobjects where name = 'sp_s_rel_CompromissoCompraAnalitico' and xtype = 'P')
	drop procedure sp_s_rel_CompromissoCompraAnalitico
go

CREATE PROCEDURE sp_s_rel_CompromissoCompraAnalitico
(
	@cdCompromissoCompraSEQ bigint = null,
	@cdAgenteComercialCooperativaCompromissoCompra bigint = null,
	@cdCronogramaSafraSEQ bigint = null,
	@cdIndicadorStatusCompromissoCompra bigint = null,
	@cdIndicadorMoedaCompromissoCompra int = null,
	@cdPessoaOrigemFaturamento bigint = null
)
as

	if @cdCompromissoCompraSEQ = 0 set @cdCompromissoCompraSEQ = null
	if @cdAgenteComercialCooperativaCompromissoCompra = 0 set @cdAgenteComercialCooperativaCompromissoCompra = null
	if @cdCronogramaSafraSEQ = 0 set @cdCronogramaSafraSEQ = null
	if @cdIndicadorStatusCompromissoCompra = 0 set @cdIndicadorStatusCompromissoCompra = null
	if @cdIndicadorMoedaCompromissoCompra = 0 set @cdIndicadorMoedaCompromissoCompra = null
	if @cdPessoaOrigemFaturamento = 0 set @cdPessoaOrigemFaturamento = null

	select
		CompromissoCompra.cdCompromissoCompraSEQ,
		CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra,
		Agente.nmPessoa nmAgenteComercialCooperativaCompromissoCompra,
		Agente.cdPessoaERP cdAgenteComercialCooperativaCompromissoCompraERP,
		CompromissoCompra.cdCronogramaSafraSEQ,
		CronogramaSafra.dsCronogramaSafra,
		CompromissoCompra.cdIndicadorMoedaCompromissoCompra,
		CodigoReferenciado.wkDominioCodigoReferenciado dsIndicadorMoedaCompromissoVenda,
		CompromissoCompra.vrTotalMoedaCompromissoCompra,
		CompromissoCompra.vrTotalAbertoMoedaCompromissoCompra,
		CompromissoCompra.dtEmissaoCompromissoCompra,
		CompromissoCompra.cdIndicadorStatusCompromissoCompra,
		TipoCompromisso.wkDominioCodigoReferenciado dsIndicadorStatusCompromissoCompra,
		CompromissoCompra.cdAgenteComercialRCCompromissoCompra,
		AgenteComercialRC.nmPessoa nmAgenteComercialRCCompromissoCompra,
		CompromissoCompra.cdAgenteComercialCCABCompromissoCompra,
		AgenteComercialCCAB.nmPessoa nmAgenteComercialCCABCompromissoCompra,
		CompromissoCompraItem.cdProdutoSEQ,
		
		Produto.dsProduto + ' [' + 
		
			(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= produto.cdTipoProduto 
				AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'
			) + '] ' as dsProduto,
	
		Produto.qtEmbalagemProduto,
		CompromissoCompraItem.qtCompromissoCompraItem,
		CompromissoCompraItem.qtAbertoCompromissoCompraItem,
		CompromissoCompraItem.vrUnitarioMoedaCompromissoCompraItem,
		CompromissoCompraItem.vrTotalMoedaCompromissoCompraItem,
		CompromissoCompraItem.vrTotalMoedaAbertoCompromissoCompraItem,
		CronogramaSafraVencimento.dtCronogramaSafraVencimento,
		CompromissoCompraItem.pcDescontoPontualidade
	from
		CompromissoCompra Left Join
		Pessoa Agente on Agente.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra left join
		Pessoa AgenteComercialRC on AgenteComercialRC.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialRCCompromissoCompra left join
		Pessoa AgenteComercialCCAB on AgenteComercialCCAB.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialCCABCompromissoCompra left join
		CronogramaSafra on CronogramaSafra.cdCronogramaSafraSEQ = CompromissoCompra.cdCronogramaSafraSEQ left join
		CodigoReferenciado on dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA' and CodigoReferenciado.vrDominioCodigoReferenciado = CompromissoCompra.cdIndicadorMoedaCompromissoCompra Left Join
		CodigoReferenciado TipoCompromisso on TipoCompromisso.dsDominioCodigoReferenciado = 'DMESPINDICADORSTATUSCOMPROMISSOCOMPRA' and TipoCompromisso.vrDominioCodigoReferenciado = CompromissoCompra.cdIndicadorStatusCompromissoCompra left join
		CompromissoCompraItem on CompromissoCompraItem.cdCompromissoCompraSEQ = CompromissoCompra.cdCompromissoCompraSEQ left join
		Produto on Produto.cdProdutoSEQ = CompromissoCompraItem.cdProdutoSEQ left join
		CronogramaSafraVencimento 
			on	CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ = CompromissoCompraItem.cdCronogramaSafraVencimentoSEQ and
				CronogramaSafraVencimento.cdCronogramaSafraSEQ = CompromissoCompraItem.cdCronogramaSafraSEQ
	WHERE
		(CompromissoCompraItem.qtCompromissoCompraItem <> 0) and
		(@cdCompromissoCompraSEQ is null or CompromissoCompra.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ) and
		(@cdAgenteComercialCooperativaCompromissoCompra is null or CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra = @cdAgenteComercialCooperativaCompromissoCompra) and
		(@cdCronogramaSafraSEQ is null or CompromissoCompra.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ) and
		(@cdIndicadorStatusCompromissoCompra is null or CompromissoCompra.cdIndicadorStatusCompromissoCompra = @cdIndicadorStatusCompromissoCompra) and
		(@cdIndicadorMoedaCompromissoCompra is null or CompromissoCompra.cdIndicadorMoedaCompromissoCompra = @cdIndicadorMoedaCompromissoCompra) and
		(@cdPessoaOrigemFaturamento is null or CompromissoCompra.cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento)

go

