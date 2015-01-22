if exists(select * from sysobjects where name = 'sp_s_rel_PedidoVendaAnalitico' and xtype = 'P')
	drop procedure sp_s_rel_PedidoVendaAnalitico
go

CREATE PROCEDURE sp_s_rel_PedidoVendaAnalitico
(
	@cdPedidoVendaSEQ bigint = null,
	@cdAgenteComercialCooperativaPedidoVenda bigint = null,
	@cdCronogramaSafraSEQ bigint = null,
	@cdIndicadorStatusPedidoVenda bigint = null,
	@cdIndicadorMoedaPedidoVenda int = null,
	@cdClienteFaturamentoPedidoVenda bigint = null,
	@cdClienteEntregaPedidoVenda bigint = null,
	@cdPessoaOrigemFaturamento bigint = null
)
as

	if @cdPedidoVendaSEQ = 0 set @cdPedidoVendaSEQ = null
	if @cdAgenteComercialCooperativaPedidoVenda = 0 set @cdAgenteComercialCooperativaPedidoVenda = null
	if @cdCronogramaSafraSEQ = 0 set @cdCronogramaSafraSEQ = null
	if @cdIndicadorStatusPedidoVenda = 0 set @cdIndicadorStatusPedidoVenda = null
	if @cdIndicadorMoedaPedidoVenda = 0 set @cdIndicadorMoedaPedidoVenda = null
	if @cdClienteFaturamentoPedidoVenda = 0 set @cdClienteFaturamentoPedidoVenda = null
	if @cdClienteEntregaPedidoVenda = 0 set @cdClienteEntregaPedidoVenda = null
	if @cdPessoaOrigemFaturamento = 0 set @cdPessoaOrigemFaturamento = null

	select
		PedidoVenda.cdPedidoVendaSEQ,
		PedidoVenda.cdAgenteComercialCooperativaPedidoVenda,
		Agente.nmPessoa nmAgenteComercialCooperativaPedidoVenda,
		Agente.cdPessoaERP cdAgenteComercialCooperativaPedidoVendaERP,
		PedidoVenda.cdCronogramaSafraSEQ,
		CronogramaSafra.dsCronogramaSafra,
		PedidoVenda.cdIndicadorMoedaPedidoVenda,
		CodigoReferenciado.wkDominioCodigoReferenciado dsIndicadorMoedaCompromissoVenda,
		PedidoVenda.vrTotalMoedaPedidoVenda,
		PedidoVenda.vrTotalAbertoMoedaPedidoVenda,
		PedidoVenda.dtEmissaoPedidoVenda,
		PedidoVenda.cdIndicadorStatusPedidoVenda,
		PedidoVenda.cdClienteFaturamentoPedidoVenda,
		ClienteFaturamento.nmPessoa nmClienteFaturamentoPedidoVenda,
		ClienteFaturamento.cdPessoaERP cdClienteFaturamentoPedidoVendaERP,
		PedidoVenda.cdClienteEntregaPedidoVenda,
		ClienteEntrega.nmPessoa nmClienteEntregaPedidoVenda,
		ClienteEntrega.cdPessoaERP cdClienteEntregaPedidoVendaERP,
		StatusPedido.wkDominioCodigoReferenciado dsIndicadorStatusPedidoVenda,
		PedidoVenda.cdAgenteComercialRCPedidoVenda,
		AgenteComercialRC.nmPessoa nmAgenteComercialRCPedidoVenda,
		AgenteComercialRC.cdPessoaERP cdAgenteComercialRCPedidoVendaERP,
		PedidoVenda.cdAgenteComercialCCABPedidoVenda,
		AgenteComercialCCAB.nmPessoa nmAgenteComercialCCABPedidoVenda,
		AgenteComercialCCAB.cdPessoaERP cdAgenteComercialCCABPedidoVendaERP,
		PedidoVendaItem.cdProdutoSEQ,
		Produto.dsProduto,
		Produto.qtEmbalagemProduto,
		PedidoVendaItem.qtPedidoVendaItem,
		PedidoVendaItem.qtAbertoPedidoVendaItem,
		PedidoVendaItem.vrUnitarioMoedaPedidoVendaItem,
		PedidoVendaItem.vrTotalMoedaPedidoVendaItem,
		PedidoVendaItem.vrTotalMoedaAbertoPedidoVendaItem,
		CronogramaSafraVencimento.dtCronogramaSafraVencimento,
		PedidoVendaItem.pcDescontoPontualidade,
		
		(SELECT 
			wkDominioCodigoReferenciado 
		FROM  
			dbo.CodigoReferenciado 
		WHERE 
			vrDominioCodigoReferenciado	= PedidoVenda.cdTipoPedidoVenda
			AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORTIPOPEDIDO'
		) as dsTipoPedido,
		
		(SELECT 
			wkDominioCodigoReferenciado 
		FROM  
			dbo.CodigoReferenciado 
		WHERE 
			vrDominioCodigoReferenciado	= PedidoVenda.cdTipoProduto
			AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'
		) as dsTipoProduto,
		
		OrigemFaturamento.nmPessoa as nmPessoaOrigemFaturamento,
		OrigemFaturamento.cdPessoaERP as cdPessoaOrigemFaturamentoERP
		
	
	from
		PedidoVenda Left Join
		Pessoa Agente on Agente.cdPessoaSEQ = PedidoVenda.cdAgenteComercialCooperativaPedidoVenda left join
		Pessoa AgenteComercialRC on AgenteComercialRC.cdPessoaSEQ = PedidoVenda.cdAgenteComercialRCPedidoVenda left join
		Pessoa AgenteComercialCCAB on AgenteComercialCCAB.cdPessoaSEQ = PedidoVenda.cdAgenteComercialCCABPedidoVenda Left Join
		Pessoa ClienteFaturamento on ClienteFaturamento.cdPessoaSEQ = PedidoVenda.cdClienteFaturamentoPedidoVenda left join
		Pessoa ClienteEntrega on ClienteEntrega.cdPessoaSEQ = PedidoVenda.cdClienteEntregaPedidoVenda left join
		Pessoa OrigemFaturamento on OrigemFaturamento.cdPessoaSEQ = PedidoVenda.cdPessoaOrigemFaturamento left join
		CronogramaSafra on CronogramaSafra.cdCronogramaSafraSEQ = PedidoVenda.cdCronogramaSafraSEQ left join
		CodigoReferenciado on dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA' and CodigoReferenciado.vrDominioCodigoReferenciado = PedidoVenda.cdIndicadorMoedaPedidoVenda Left Join
		CodigoReferenciado StatusPedido on StatusPedido.dsDominioCodigoReferenciado = 'DMPESPINDICADORSTATUSPEDIDO' and StatusPedido.vrDominioCodigoReferenciado = PedidoVenda.cdIndicadorStatusPedidoVenda left join
		PedidoVendaItem on PedidoVendaItem.cdPedidoVendaSEQ = PedidoVenda.cdPedidoVendaSEQ left join
		Produto on Produto.cdProdutoSEQ = PedidoVendaItem.cdProdutoSEQ left join
		CronogramaSafraVencimento 
			on	CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ = PedidoVendaItem.cdCronogramaSafraVencimentoSEQ and
				CronogramaSafraVencimento.cdCronogramaSafraSEQ = PedidoVendaItem.cdCronogramaSafraSEQ
	WHERE
		(PedidoVendaItem.qtPedidoVendaItem <> 0) and
		(@cdPedidoVendaSEQ is null or @cdPedidoVendaSEQ = PedidoVenda.cdPedidoVendaSEQ) and
		(@cdAgenteComercialCooperativaPedidoVenda is null or @cdAgenteComercialCooperativaPedidoVenda = PedidoVenda.cdAgenteComercialCooperativaPedidoVenda) and
		(@cdCronogramaSafraSEQ is null or @cdCronogramaSafraSEQ = PedidoVenda.cdCronogramaSafraSEQ) and
		(@cdIndicadorStatusPedidoVenda is null or @cdIndicadorStatusPedidoVenda = PedidoVenda.cdIndicadorStatusPedidoVenda) and
		(@cdIndicadorMoedaPedidoVenda is null or @cdIndicadorMoedaPedidoVenda = PedidoVenda.cdIndicadorMoedaPedidoVenda) and
		(@cdClienteFaturamentoPedidoVenda is null or @cdClienteFaturamentoPedidoVenda = PedidoVenda.cdClienteFaturamentoPedidoVenda) and
		(@cdClienteEntregaPedidoVenda is null or @cdClienteEntregaPedidoVenda = PedidoVenda.cdClienteEntregaPedidoVenda) and
		(@cdPessoaOrigemFaturamento is null or @cdPessoaOrigemFaturamento = PedidoVenda.cdPessoaOrigemFaturamento)

go

sp_s_rel_PedidoVendaAnalitico

