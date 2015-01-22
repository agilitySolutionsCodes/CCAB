if exists(select * from sysobjects where name = 'sp_s_rel_CompromissoCompraItem' and xtype = 'P')
	drop procedure sp_s_rel_CompromissoCompraItem
go

CREATE PROCEDURE sp_s_rel_CompromissoCompraItem
(
	@cdCompromissoCompraSEQ bigint
)
as

	select
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
		CompromissoCompraItem.vrUnitarioMoedaCompromissoCompraItem,
		CompromissoCompraItem.vrTotalMoedaCompromissoCompraItem,
		CronogramaSafraVencimento.dtCronogramaSafraVencimento
	from 
		CompromissoCompraItem left join
		Produto on Produto.cdProdutoSEQ = CompromissoCompraItem.cdProdutoSEQ left join
		CronogramaSafraVencimento 
			on	CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ = CompromissoCompraItem.cdCronogramaSafraVencimentoSEQ and
				CronogramaSafraVencimento.cdCronogramaSafraSEQ = CompromissoCompraItem.cdCronogramaSafraSEQ
	where
		cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ and
		CompromissoCompraItem.qtCompromissoCompraItem <> 0

	order by
		Produto.dsProduto

go