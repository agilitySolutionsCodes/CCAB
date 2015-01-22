if exists(select * from sysobjects where name = 'sp_s_rel_CompromissoCompra' and xtype = 'P')
	drop procedure sp_s_rel_CompromissoCompra
go

CREATE PROCEDURE sp_s_rel_CompromissoCompra
(
	@cdCompromissoCompraSEQ bigint
)
as

	select
		CompromissoCompra.cdCompromissoCompraSEQ,
		CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra,
		Agente.nmPessoa nmAgenteComercialCooperativaCompromissoCompra,
		Agente.cdPessoaERP cdAgenteComercialCooperativaCompromissoCompraERP,
		CompromissoCompra.cdCronogramaSafraSEQ,
		CronogramaSafra.dsCronogramaSafra,
		CompromissoCompra.cdIndicadorMoedaCompromissoCompra,
		CodigoReferenciado.wkDominioCodigoReferenciado dsIndicadorMoedaCompromissoVenda,
		CompromissoCompra.cdPessoaOrigemFaturamento,
		OrigemFaturamento.nmPessoa dsPessoaOrigemFaturamento,
		OrigemFaturamento.cdPessoaERP cdPessoaOrigemFaturamentoERP
	from
		CompromissoCompra Left Join
		Pessoa Agente on Agente.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra left join
		CronogramaSafra on CronogramaSafra.cdCronogramaSafraSEQ = CompromissoCompra.cdCronogramaSafraSEQ left join
		CodigoReferenciado on dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA' and CodigoReferenciado.vrDominioCodigoReferenciado = CompromissoCompra.cdIndicadorMoedaCompromissoCompra left join
		Pessoa OrigemFaturamento on CompromissoCompra.cdPessoaOrigemFaturamento = OrigemFaturamento.cdPessoaSEQ
	where 
		cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ

go

sp_s_rel_CompromissoCompra 29