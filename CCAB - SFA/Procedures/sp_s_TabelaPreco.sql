if exists(select * from sysobjects where name = 'sp_s_TabelaPreco' and xtype = 'P')
	drop procedure sp_s_TabelaPreco
go


CREATE PROCEDURE sp_s_TabelaPreco
(
	@cdPessoaSEQ			bigint,
	@cdCronogramaSafraSEQ	bigint,
	@cdTipoProduto			bigint
)
as

	select
		Produto.cdProdutoSEQ,
		Produto.dsProduto,
		PessoaTabelaPrecoProduto.vrDolarPessoaTabelaPrecoProduto,
		PessoaTabelaPrecoProduto.vrRealPessoaTabelaPrecoProduto,
		CronogramaSafraVencimento.dtCronogramaSafraVencimento,
		PessoaTabelaPrecoProduto.cdPessoaSEQ cdCooperativa,
		Cooperativa.nmPessoa nmCooperativa,
		CronogramaSafra.dsCronogramaSafra
		,(SELECT 
			wkDominioCodigoReferenciado 
		FROM  
			dbo.CodigoReferenciado 
		WHERE 
			vrDominioCodigoReferenciado	= cdTipoProduto 
			AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'
		)as dsTipoProduto  
	from 
		PessoaTabelaPrecoProduto Inner Join
		Produto on PessoaTabelaPrecoProduto.cdProdutoSEQ = Produto.cdProdutoSEQ Inner Join
		CronogramaSafraVencimento on PessoaTabelaPrecoProduto.cdCronogramaSafraVencimentoSEQ = CronogramaSafraVencimento.cdCronogramaSafraVencimentoSEQ Left Join
		Pessoa Cooperativa on Cooperativa.cdPessoaSEQ = PessoaTabelaPrecoProduto.cdPessoaSEQ left join
		CronogramaSafra on CronogramaSafraVencimento.cdCronogramaSafraSEQ = CronogramaSafra.cdCronogramaSafraSEQ
	Where
		PessoaTabelaPrecoProduto.cdPessoaSEQ = @cdPessoaSEQ AND
		PessoaTabelaPrecoProduto.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ AND
		Produto.cdTipoProduto = @cdTipoProduto
	Order By
		Produto.dsProduto

go


