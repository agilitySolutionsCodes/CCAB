if exists(select * from sysobjects where name = 'sp_s_rel_CompromissoCompraResumoPorSituacao' and xtype = 'P')
	drop procedure sp_s_rel_CompromissoCompraResumoPorSituacao
go

CREATE PROCEDURE sp_s_rel_CompromissoCompraResumoPorSituacao
(
	@cdCompromissoCompraSEQ bigint = null,
	@cdAgenteComercialCooperativaCompromissoCompra	bigint = null,
	@cdCronogramaSafraSEQ	bigint = null,
	@cdIndicadorStatusCompromissoCompra	bigint = null,
	@cdIndicadorMoedaCompromissoCompra	int	 = null,
	@cdPessoaOrigemFaturamento bigint = null
)
as
	if @cdCompromissoCompraSEQ = 0 set @cdCompromissoCompraSEQ = null
	if @cdAgenteComercialCooperativaCompromissoCompra = 0 set @cdAgenteComercialCooperativaCompromissoCompra = null
	if @cdCronogramaSafraSEQ = 0 set @cdCronogramaSafraSEQ = null
	if @cdIndicadorStatusCompromissoCompra = 0 set @cdIndicadorStatusCompromissoCompra = null
	if @cdIndicadorMoedaCompromissoCompra = 0 set @cdIndicadorMoedaCompromissoCompra = null
	if @cdPessoaOrigemFaturamento = 0 set @cdPessoaOrigemFaturamento = null

	declare @CompromissoCompraStatus table
	(
		cdCompromissoCompraSEQ bigint,
		cdIndicadorStatusPedidoVenda int,
		dsIndicadorStatusPedidoVenda varchar(70),
		vrTotalMoedaPedidoVenda money
	)

	declare @ValorPorStatus table
	(
		cdCompromissoCompraSEQ bigint,
		Digitado	money default 0,
		Liberado	money default 0,
		Aceito		money default 0,
		Rejeitado	money default 0,
		Efetivado	money default 0
	)

	declare @ValorPorStatusTransicao table
	(
		cdCompromissoCompraSEQ bigint,
		Digitado	money default 0,
		Liberado	money default 0,
		Aceito		money default 0,
		Rejeitado	money default 0,
		Efetivado	money default 0
	)

	insert into @CompromissoCompraStatus
	(
		cdCompromissoCompraSEQ,
		cdIndicadorStatusPedidoVenda,
		dsIndicadorStatusPedidoVenda,
		vrTotalMoedaPedidoVenda
	)
	select
		CompromissoCompra.cdCompromissoCompraSEQ,
		PedidoVenda.cdIndicadorStatusPedidoVenda,
		StatusPedidoVenda.wkDominioCodigoReferenciado dsIndicadorStatusPedidoVenda,
		Sum(PedidoVenda.vrTotalMoedaPedidoVenda) vrTotalMoedaPedidoVenda
	from
		CompromissoCompra inner Join
		PedidoVenda on PedidoVenda.cdCompromissoCompraSEQ = CompromissoCompra.cdCompromissoCompraSEQ inner join
		CodigoReferenciado StatusPedidoVenda on StatusPedidoVenda.dsDominioCodigoReferenciado = 'DMPESPINDICADORSTATUSPEDIDO' and StatusPedidoVenda.vrDominioCodigoReferenciado = PedidoVenda.cdIndicadorStatusPedidoVenda
	where
		(@cdCompromissoCompraSEQ is null or CompromissoCompra.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ) and
		(@cdAgenteComercialCooperativaCompromissoCompra is null or CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra = @cdAgenteComercialCooperativaCompromissoCompra) and
		(@cdCronogramaSafraSEQ is null or CompromissoCompra.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ) and
		(@cdIndicadorStatusCompromissoCompra is null or CompromissoCompra.cdIndicadorStatusCompromissoCompra = @cdIndicadorStatusCompromissoCompra) and
		(@cdIndicadorMoedaCompromissoCompra is null or CompromissoCompra.cdIndicadorMoedaCompromissoCompra = @cdIndicadorMoedaCompromissoCompra) and
		(@cdPessoaOrigemFaturamento is null or CompromissoCompra.cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento)
	group by
		CompromissoCompra.cdCompromissoCompraSEQ,
		PedidoVenda.cdIndicadorStatusPedidoVenda,
		StatusPedidoVenda.wkDominioCodigoReferenciado

	insert into @ValorPorStatus
	(
		cdCompromissoCompraSEQ
	)
	select distinct
		cdCompromissoCompraSEQ
	from
		@CompromissoCompraStatus

	insert into @ValorPorStatusTransicao
	select
		CompromissoCompraStatus.cdCompromissoCompraSEQ,
		Digitado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 1 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Digitado end,
		Liberado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 2 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Liberado end,
		Aceito = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 3 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Aceito end,
		Rejeitado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 4 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Rejeitado end,
		Efetivado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda >= 5 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Efetivado end
	from
		@CompromissoCompraStatus CompromissoCompraStatus inner join
		@ValorPorStatus ValorPorStatus on ValorPorStatus.cdCompromissoCompraSEQ = CompromissoCompraStatus.cdCompromissoCompraSEQ

	delete from @ValorPorStatus

	insert into @ValorPorStatus
	select
		cdCompromissoCompraSEQ,
		sum(Digitado) Digitado,
		sum(Liberado) Liberado,
		sum(Aceito) Aceito,
		sum(Rejeitado) Rejeitado,
		sum(Efetivado) Efetivado
	from @ValorPorStatusTransicao
	group by
		cdCompromissoCompraSEQ

	update ValorPorStatus
	set
		Digitado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 1 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Digitado end,
		Liberado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 2 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Liberado end,
		Aceito = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 3 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Aceito end,
		Rejeitado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda = 4 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Rejeitado end,
		Efetivado = case when CompromissoCompraStatus.cdIndicadorStatusPedidoVenda >= 5 then CompromissoCompraStatus.vrTotalMoedaPedidoVenda else Efetivado end
	from
		@CompromissoCompraStatus CompromissoCompraStatus inner join
		@ValorPorStatus ValorPorStatus on ValorPorStatus.cdCompromissoCompraSEQ = CompromissoCompraStatus.cdCompromissoCompraSEQ

	select
		CompromissoCompra.cdCompromissoCompraSEQ,
		CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra,
		Agente.nmPessoa nmAgenteComercialCooperativaCompromissoCompra,
		Agente.cdPessoaERP cdAgenteComercialCooperativaCompromissoCompraERP,
		CompromissoCompra.cdCronogramaSafraSEQ,
		CronogramaSafra.dsCronogramaSafra,
		CompromissoCompra.cdIndicadorMoedaCompromissoCompra,
		CodigoReferenciado.wkDominioCodigoReferenciado dsIndicadorMoedaCompromissoVenda,
		CompromissoCompra.vrTotalMoedaCompromissoCompra,
		CompromissoCompra.vrTotalAbertoMoedaCompromissoCompra,
		CompromissoCompra.dtEmissaoCompromissoCompra,
		CompromissoCompra.cdIndicadorStatusCompromissoCompra,
		TipoCompromisso.wkDominioCodigoReferenciado dsIndicadorStatusCompromissoCompra,
		CompromissoCompra.cdAgenteComercialRCCompromissoCompra,
		AgenteComercialRC.nmPessoa nmAgenteComercialRCCompromissoCompra,
		CompromissoCompra.cdAgenteComercialCCABCompromissoCompra,
		AgenteComercialCCAB.nmPessoa nmAgenteComercialCCABCompromissoCompra,
		isnull(ValorPorStatus.Digitado, 0) Digitado,
		isnull(ValorPorStatus.Liberado, 0) Liberado,
		isnull(ValorPorStatus.Aceito, 0) Aceito,
		isnull(ValorPorStatus.Rejeitado, 0) Rejeitado,
		isnull(ValorPorStatus.Efetivado, 0) Efetivado
	from
		CompromissoCompra Left Join
		Pessoa Agente on Agente.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra left join
		Pessoa AgenteComercialRC on AgenteComercialRC.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialRCCompromissoCompra left join
		Pessoa AgenteComercialCCAB on AgenteComercialCCAB.cdPessoaSEQ = CompromissoCompra.cdAgenteComercialCCABCompromissoCompra left join
		CronogramaSafra on CronogramaSafra.cdCronogramaSafraSEQ = CompromissoCompra.cdCronogramaSafraSEQ left join
		CodigoReferenciado on dsDominioCodigoReferenciado = 'DMESPINDICADORMOEDA' and CodigoReferenciado.vrDominioCodigoReferenciado = CompromissoCompra.cdIndicadorMoedaCompromissoCompra Left Join
		CodigoReferenciado TipoCompromisso on TipoCompromisso.dsDominioCodigoReferenciado = 'DMESPINDICADORSTATUSCOMPROMISSOCOMPRA' and TipoCompromisso.vrDominioCodigoReferenciado = CompromissoCompra.cdIndicadorStatusCompromissoCompra Left Join
		@ValorPorStatus ValorPorStatus on ValorPorStatus.cdCompromissoCompraSEQ = CompromissoCompra.cdCompromissoCompraSEQ
	where
		(@cdCompromissoCompraSEQ is null or CompromissoCompra.cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ) and
		(@cdAgenteComercialCooperativaCompromissoCompra is null or CompromissoCompra.cdAgenteComercialCooperativaCompromissoCompra = @cdAgenteComercialCooperativaCompromissoCompra) and
		(@cdCronogramaSafraSEQ is null or CompromissoCompra.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ) and
		(@cdIndicadorStatusCompromissoCompra is null or CompromissoCompra.cdIndicadorStatusCompromissoCompra = @cdIndicadorStatusCompromissoCompra) and
		(@cdIndicadorMoedaCompromissoCompra is null or CompromissoCompra.cdIndicadorMoedaCompromissoCompra = @cdIndicadorMoedaCompromissoCompra) and
		(@cdPessoaOrigemFaturamento is null or CompromissoCompra.cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento)


GO

sp_s_rel_CompromissoCompraResumoPorSituacao