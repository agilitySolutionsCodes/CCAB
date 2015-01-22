if exists(select * from sysobjects where name = 'sp_s_rel_PedidoVendaItem' and xtype = 'P')
	drop procedure sp_s_rel_PedidoVendaItem
go

CREATE PROCEDURE sp_s_rel_PedidoVendaItem
(
	@cdPedidoVendaSEQ bigint
)
as

	select
		PedidoVendaItem.cdProdutoSEQ,
		Produto.dsProduto,
		Produto.qtEmbalagemProduto,
		PedidoVendaItem.qtPedidoVendaItem,
		PedidoVendaItem.vrUnitarioMoedaPedidoVendaItem,
		PedidoVendaItem.vrTotalMoedaPedidoVendaItem,
		CronogramaSafraVencimento.dtCronogramaSafraVencimento,
		PedidoVendaItem.pcDescontoPontualidade
	from 
		PedidoVendaItem left join
		Produto on Produto.cdProdutoSEQ = PedidoVendaItem.cdProdutoSEQ left join
		CronogramaSafraVencimento 
			on	CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ = PedidoVendaItem.cdCronogramaSafraVencimentoSEQ and
				CronogramaSafraVencimento.cdCronogramaSafraSEQ = PedidoVendaItem.cdCronogramaSafraSEQ
	where
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ and
		PedidoVendaItem.qtPedidoVendaItem <> 0

	order by
		Produto.dsProduto

go