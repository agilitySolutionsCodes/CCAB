if exists(select * from sysobjects where name = 'sp_s_rel_CompromissoCompraParcela' and xtype = 'P')
	drop procedure sp_s_rel_CompromissoCompraParcela
go

CREATE PROCEDURE sp_s_rel_CompromissoCompraParcela
(
	@cdCompromissoCompraSEQ bigint
)
as

	select
		CronogramaSafraVencimento.dtCronogramaSafraVencimento,
		CompromissoCompraItem.pcDescontoPontualidade,
		Sum(CompromissoCompraItem.vrTotalMoedaCompromissoCompraItem) vrTotalMoedaCompromissoCompraParcela
		
	from 
		CompromissoCompraItem left join
		Produto on Produto.cdProdutoSEQ = CompromissoCompraItem.cdProdutoSEQ left join
		CronogramaSafraVencimento 
			on	CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ = CompromissoCompraItem.cdCronogramaSafraVencimentoSEQ and
				CronogramaSafraVencimento.cdCronogramaSafraSEQ = CompromissoCompraItem.cdCronogramaSafraSEQ
	where
		cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ and
		CompromissoCompraItem.qtCompromissoCompraItem <> 0
	group by
		CronogramaSafraVencimento.dtCronogramaSafraVencimento, CompromissoCompraItem.pcDescontoPontualidade

go