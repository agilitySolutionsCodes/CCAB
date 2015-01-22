if exists(select * from sysobjects where name = 'sp_s_rel_PedidoVendaItemCultura' and xtype = 'P')
	drop procedure sp_s_rel_PedidoVendaItemCultura
go

CREATE PROCEDURE sp_s_rel_PedidoVendaItemCultura
(
	@cdPedidoVendaSEQ bigint
)
as

	select
		PedidoVendaItemCultura.cdProdutoSEQ,
		Produto.dsProduto,
		TipoCultura.dsTipoCultura,
		PedidoVendaItemCultura.qtPedidoVendaItemCultura
		
	from 
		PedidoVendaItemCultura left join
		Produto on Produto.cdProdutoSEQ = PedidoVendaItemCultura.cdProdutoSEQ left join
		TipoCultura on TipoCultura.cdTipoCulturaSEQ = PedidoVendaItemCultura.cdTipoCulturaSEQ
	where
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ and
		PedidoVendaItemCultura.qtPedidoVendaItemCultura <> 0

	order by
		Produto.dsProduto
go


