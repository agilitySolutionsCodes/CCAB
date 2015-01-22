if exists(select * from sysobjects where name = 'sp_s_rel_PedidoVendaItemEntrega' and xtype = 'P')
	drop procedure sp_s_rel_PedidoVendaItemEntrega
go

CREATE PROCEDURE sp_s_rel_PedidoVendaItemEntrega
(
	@cdPedidoVendaSEQ bigint
)
as

	select
		PedidoVendaItemEntrega.cdProdutoSEQ,
		Produto.dsProduto,
		Produto.qtEmbalagemProduto,
		PedidoVendaItemEntrega.dtAnoMesPedidoVendaItemEntrega,
		PedidoVendaItemEntrega.qtPedidoVendaItemEntrega
	from 
		PedidoVendaItemEntrega left join
		Produto on Produto.cdProdutoSEQ = PedidoVendaItemEntrega.cdProdutoSEQ
	where
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ and
		PedidoVendaItemEntrega.qtPedidoVendaItemEntrega <> 0

	order by
		Produto.dsProduto
go


