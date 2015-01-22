if exists(select * from sysobjects where name = 'sp_s_rel_PedidoVenda' and xtype = 'P')
	drop procedure sp_s_rel_PedidoVenda
go

CREATE PROCEDURE sp_s_rel_PedidoVenda
(
	@cdPedidoVendaSEQ bigint
)
as

	select
		PedidoVenda.cdPedidoVendaSEQ,
		PedidoVenda.dtDigitacaoPedidoVenda,
		PedidoVenda.cdCompromissoCompraSEQ,
		PedidoVenda.vrTotalMoedaPedidoVenda,
		PedidoVenda.dtEmissaoPedidoVenda,
		PedidoVenda.cdIndicadorStatusPedidoVenda,
		TipoPedido.wkDominioCodigoReferenciado dsIndicadorStatusPedidoVenda,
		PedidoVenda.cdAgenteComercialCooperativaPedidoVenda,
		Agente.nmPessoa nmAgenteComercialCooperativaPedidoVenda,
		Agente.cdPessoaERP cdAgenteComercialCooperativaPedidoVendaERP,
		PedidoVenda.cdAgenteComercialRCPedidoVenda,
		AgenteComercialRC.nmPessoa nmAgenteComercialRCPedidoVenda,
		PedidoVenda.cdClienteFaturamentoPedidoVenda,
		ClienteFaturamento.nmPessoa nmClienteFaturamentoPedidoVenda,
		ClienteFaturamento.cdPessoaERP cdClienteFaturamentoPedidoVendaERP,
		PedidoVenda.cdClienteEntregaPedidoVenda,
		ClienteEntrega.nmPessoa nmClienteEntregaPedidoVenda,
		ClienteEntrega.cdPessoaERP cdClienteEntregaPedidoVendaERP,
		PedidoVenda.cdCronogramaSafraSEQ,
		CronogramaSafra.dsCronogramaSafra,
		PedidoVenda.cdIndicadorMoedaPedidoVenda,
		TipoMoeda.wkDominioCodigoReferenciado dsIndicadorMoedaCompromissoVenda,
		PedidoVenda.cdPessoaOrigemFaturamento,
		OrigemFaturamento.nmPessoa dsPessoaOrigemFaturamento,
		OrigemFaturamento.cdPessoaERP cdPessoaOrigemFaturamentoERP,
		
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
		) as dsTipoProduto
		
	from
		PedidoVenda Left Join
		Pessoa Agente on Agente.cdPessoaSEQ = PedidoVenda.cdAgenteComercialCooperativaPedidoVenda left join
		Pessoa AgenteComercialRC on AgenteComercialRC.cdPessoaSEQ = PedidoVenda.cdAgenteComercialRCPedidoVenda left join
		CronogramaSafra on CronogramaSafra.cdCronogramaSafraSEQ = PedidoVenda.cdCronogramaSafraSEQ left join
		CodigoReferenciado TipoMoeda on TipoMoeda.dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA' and TipoMoeda.vrDominioCodigoReferenciado = PedidoVenda.cdIndicadorMoedaPedidoVenda Left Join
		CodigoReferenciado TipoPedido on TipoPedido.dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOPEDIDO' and TipoPedido.vrDominioCodigoReferenciado = PedidoVenda.cdTipoPedidoVenda Left Join
		Pessoa ClienteFaturamento on ClienteFaturamento.cdPessoaSEQ = PedidoVenda.cdClienteFaturamentoPedidoVenda left join
		Pessoa ClienteEntrega on ClienteEntrega.cdPessoaSEQ = PedidoVenda.cdClienteEntregaPedidoVenda left join
		Pessoa OrigemFaturamento on PedidoVenda.cdPessoaOrigemFaturamento = OrigemFaturamento.cdPessoaSEQ
	where 
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ

go

sp_s_rel_PedidoVenda 26
