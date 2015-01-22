if exists(select * from sysobjects where name = 'sp_s_rel_PedidoVendaParcela' and xtype = 'P')
	drop procedure sp_s_rel_PedidoVendaParcela
go

CREATE PROCEDURE sp_s_rel_PedidoVendaParcela
(
	@cdPedidoVendaSEQ bigint
)
as

	select
		CronogramaSafraVencimento.dtCronogramaSafraVencimento,
		PedidoVendaItem.pcDescontoPontualidade,
		Sum(PedidoVendaItem.vrTotalMoedaPedidoVendaItem) vrTotalMoedaPedidoVendaParcela
	from 
		PedidoVendaItem left join
		Produto on Produto.cdProdutoSEQ = PedidoVendaItem.cdProdutoSEQ left join
		CronogramaSafraVencimento 
			on	CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ = PedidoVendaItem.cdCronogramaSafraVencimentoSEQ and
				CronogramaSafraVencimento.cdCronogramaSafraSEQ = PedidoVendaItem.cdCronogramaSafraSEQ
	where
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ and
		PedidoVendaItem.qtPedidoVendaItem <> 0
	group by
		CronogramaSafraVencimento.dtCronogramaSafraVencimento, PedidoVendaItem.pcDescontoPontualidade

go