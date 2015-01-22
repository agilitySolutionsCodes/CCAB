set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_PedidoVenda.sql
**		Name: SP_U_PedidoVenda
**		Desc: Efetiva a Gravação do Pedido
**
**		Auth: Convergence
**		Date: 16/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_PedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_PedidoVenda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_PedidoVenda]
	 @tmpPedidoVendaSEQ			BIGINT
	,@cdPedidoVendaSEQ			BIGINT	
	,@cdUsuarioUltimaAlteracao	BIGINT
AS

	-- Define Variaveis PedidoVenda
	declare @cdAgenteComercialCooperativaPedidoVenda	bigint
	declare	@cdAgenteComercialCCABPedidoVenda			bigint
	declare	@cdAgenteComercialRCPedidoVenda				bigint
	declare	@cdClienteFaturamentoPedidoVenda			bigint
	declare	@cdClienteEntregaPedidoVenda				bigint
	declare	@cdCompromissoCompraSEQ						bigint
	declare	@cdCronogramaSafraSEQ						bigint
	declare	@dtDigitacaoPedidoVenda						datetime
	declare	@dtEmissaoPedidoVenda						datetime
	declare	@cdTipoPedidoVenda							int
	declare	@cdModalidadePedidoVenda					int
	declare	@cdIndicadorStatusPedidoVenda				int
	declare	@cdIndicadorMoedaPedidoVenda				int
	declare	@vrTotalMoedaPedidoVenda					numeric(22,4)
	declare	@vrTotalAbertoMoedaPedidoVenda				numeric(22,4)
	declare	@cdPedidoVendaERP							varchar(30)
	declare	@cdFilialFaturadoraERP						varchar(30)
	declare @cdPessoaOrigemFaturamento					bigint

	-- Define Variaveis PedidoVendaItem	
	declare @tmpPedidoVendaItemSEQ						bigint
	declare @cdProdutoSEQ								bigint
	declare @cdCronogramaSafraVencimentoSEQ				bigint
	declare @qtPedidoVendaItem							numeric(22,4)
	declare @qtAbertoPedidoVendaItem					numeric(22,4)
	declare @vrUnitarioMoedaPedidoVendaItem				numeric(22,4)
	declare @vrTotalMoedapedidoVendaItem				numeric(22,4)
	declare @vrTotalMoedaAbertoPedidoVendaItem			numeric(22,4)
	declare @Fetch_tmpPedidoVendaItem					int

	-- Define Variaveis PedidoVendaItemEntrega			
	declare @tmpPedidoVendaItemEntregaSEQ				bigint
	declare @dtAnoMesPedidoVendaItemEntrega				datetime
	declare @qtPedidoVendaItemEntrega					numeric(22,4)
	declare @Fetch_tmpPedidoVendaItemEntrega			int
	
	-- Define Variaveis PedidoVendaItemCultura	
	declare @tmpPedidoVendaItemCulturaSEQ				bigint
	declare	@cdTipoCulturaSEQ							bigint
	declare	@qtPedidoVendaItemCultura					numeric(22,4)
	declare @Fetch_tmpPedidoVendaItemCultura			int

	-- Define Variaveis de E-mail
	declare @cdSolicitacaoEnvioEmailSEQ					bigint

	-- Busca Valor total do Pedido
	set @vrTotalMoedaPedidoVenda = 0
	select @vrTotalMoedaPedidoVenda = sum(vrTotalMoedaPedidoVendaItem)
	from tmpPedidoVendaItem
	where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	-- Busca Valor total em Aberto do Pedido	
	set @vrTotalAbertoMoedaPedidoVenda = 0
	select @vrTotalAbertoMoedaPedidoVenda = sum(vrTotalMoedaPedidoVendaItem)
	from tmpPedidoVendaItem
	where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
	
	-- Atualiza Pedido Venda
	
	IF NOT EXISTS (select 1 from PedidoVenda where cdPedidoVendaSEQ = @cdPedidoVendaSEQ)
	BEGIN
		RAISERROR ('5002 - Erro na Busca do Pedido de Venda para a Alteração',16,1)
		RETURN	
	END	
	
	SELECT 	@cdAgenteComercialCooperativaPedidoVenda	= cdAgenteComercialCooperativaPedidoVenda	
	       ,@cdAgenteComercialCCABPedidoVenda			= cdAgenteComercialCCABPedidoVenda			
	       ,@cdAgenteComercialRCPedidoVenda				= cdAgenteComercialRCPedidoVenda				
	       ,@cdClienteFaturamentoPedidoVenda			= cdClienteFaturamentoPedidoVenda			
	       ,@cdClienteEntregaPedidoVenda				= cdClienteEntregaPedidoVenda				
	       ,@cdCompromissoCompraSEQ						= cdCompromissoCompraSEQ
	       ,@cdCronogramaSafraSEQ						= cdCronogramaSafraSEQ						
	       ,@dtDigitacaoPedidoVenda						= dtDigitacaoPedidoVenda						
	       ,@dtEmissaoPedidoVenda						= dtEmissaoPedidoVenda						
	       ,@cdTipoPedidoVenda							= cdTipoPedidoVenda							
	       ,@cdModalidadePedidoVenda					= cdModalidadePedidoVenda					
	       ,@cdIndicadorStatusPedidoVenda				= cdIndicadorStatusPedidoVenda				
	       ,@cdIndicadorMoedaPedidoVenda				= cdIndicadorMoedaPedidoVenda				
	       ,@cdPedidoVendaERP							= cdPedidoVendaERP							
	       ,@cdFilialFaturadoraERP						= cdFilialFaturadoraERP		
	       ,@cdPessoaOrigemFaturamento					= cdPessoaOrigemFaturamento				
	FROM	
		tmpPedidoVenda
	WHERE
		tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
	
	UPDATE PedidoVenda
		set  cdClienteFaturamentoPedidoVenda		= @cdClienteFaturamentoPedidoVenda
			,cdClienteEntregaPedidoVenda			= @cdClienteEntregaPedidoVenda
			,dtDigitacaoPedidoVenda					= @dtDigitacaoPedidoVenda
			,cdTipoPedidoVenda						= @cdTipoPedidoVenda
			,cdModalidadePedidoVenda				= @cdModalidadePedidoVenda
			,cdIndicadorStatusPedidoVenda			= @cdIndicadorStatusPedidoVenda
			,cdIndicadorMoedaPedidoVenda			= @cdIndicadorMoedaPedidoVenda
			,vrTotalMoedaPedidoVenda				= @vrTotalMoedaPedidoVenda
			,vrTotalAbertoMoedaPedidoVenda			= @vrTotalAbertoMoedaPedidoVenda
			,dtUltimaAlteracao						= getdate()
			,cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
			,cdPessoaOrigemFaturamento				= @cdPessoaOrigemFaturamento
	WHERE
		cdPedidoVendaSEQ = @cdPedidoVendaSEQ

	IF @@ERROR <> 0  OR @@ROWCOUNT = 0
	BEGIN
		RAISERROR ('5003 - Erro na Alteração do Pedido',16,1)
		RETURN	
	END
	
	-- Atualiza Pedido Venda Item
	DECLARE CS_tmpPedidoVendaItem CURSOR FOR
	SELECT	 tmpPedidoVendaItemSEQ
			,cdProdutoSEQ
			,cdCronogramaSafraSEQ
			,cdCronogramaSafraVencimentoSEQ
			,qtPedidoVendaItem
			,qtAbertoPedidoVendaItem
			,vrUnitarioMoedaPedidoVendaItem
			,vrTotalMoedapedidoVendaItem
			,vrTotalMoedaAbertoPedidoVendaItem
	FROM	tmpPedidoVendaItem
	WHERE	tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	OPEN CS_tmpPedidoVendaItem
	FETCH NEXT FROM CS_tmpPedidoVendaItem
	INTO	 @tmpPedidoVendaItemSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@cdCronogramaSafraVencimentoSEQ
			,@qtPedidoVendaItem
			,@qtAbertoPedidoVendaItem
			,@vrUnitarioMoedaPedidoVendaItem
			,@vrTotalMoedapedidoVendaItem
			,@vrTotalMoedaAbertoPedidoVendaItem
						
	SET @Fetch_tmpPedidoVendaItem = @@FETCH_STATUS

	WHILE @Fetch_tmpPedidoVendaItem = 0
	BEGIN
	
		if exists (	select	1 
					from	pedidovendaitem 
					where	cdPedidoVendaSEQ = @cdPedidoVendaSEQ
					and		cdProdutoSEQ = @cdProdutoSEQ
					and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ)
		BEGIN
					
			UPDATE PedidoVendaItem
			SET	 qtPedidoVendaItem = @qtPedidoVendaItem
				,qtAbertoPedidoVendaItem = @qtAbertoPedidoVendaItem
				,vrTotalMoedaPedidoVendaItem = @vrTotalMoedaPedidoVendaItem
				,vrTotalMoedaAbertoPedidoVendaItem = @vrTotalMoedaAbertoPedidoVendaItem
				,vrUnitarioMoedaPedidoVendaItem = @vrUnitarioMoedaPedidoVendaItem
				,dtUltimaAlteracao = getdate()
				,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
				,pcDescontoPontualidade = dbo.FN_BuscaPontualidadePedido(@cdPedidoVendaSEQ, @cdCronogramaSafraVencimentoSEQ,2)
			WHERE
				cdPedidoVendaSEQ = @cdPedidoVendaSEQ
			and cdProdutoSEQ = @cdProdutoSEQ
			and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				RAISERROR ('5004 - Erro na Alteração dos Itens do Pedido',16,1)
				CLOSE CS_tmpPedidoVendaItem
				DEALLOCATE CS_tmpPedidoVendaItem
				RETURN	
			END
			
		END
		
		ELSE
		
		BEGIN
		
			INSERT INTO PEDIDOVENDAITEM
			(
				cdPedidoVendaSEQ
				,cdProdutoSEQ
				,cdCronogramaSafraSEQ
				,cdCronogramaSafraVencimentoSEQ
				,qtPedidoVendaItem
				,qtAbertoPedidoVendaItem
				,vrUnitarioMoedaPedidoVendaItem
				,vrTotalMoedaPedidoVendaItem
				,vrTotalMoedaAbertoPedidoVendaItem
				,cdPedidoVendaERP
				,cdPedidoVendaItemERP
				,cdFilialFaturadoraERP
				,cdIndicadorStatusPedidoVendaItem
				,wkRCPedidoVendaItem
				,wkClientePedidoVendaItem
				,dtUltimaAlteracao
				,cdUsuarioUltimaAlteracao
				,pcDescontoPontualidade
			)
			VALUES
			(
				@cdPedidoVendaSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@cdCronogramaSafraVencimentoSEQ
				,@qtPedidoVendaItem
				,@qtAbertoPedidoVendaItem
				,@vrUnitarioMoedaPedidoVendaItem
				,@vrTotalMoedaPedidoVendaItem
				,@vrTotalMoedaAbertoPedidoVendaItem
				,null
				,null
				,null
				,1 -- @cdIndicadorStatusPedidoVendaItem 1-Digitado
				,null
				,null
				,getdate()
				,@cdUsuarioUltimaAlteracao
				,dbo.FN_BuscaPontualidadePedido(@cdPedidoVendaSEQ, @cdCronogramaSafraVencimentoSEQ,2)
			)
			
			IF @@ERROR <> 0  
			BEGIN
				RAISERROR ('5005 - Erro na Inclusão dos Itens do Pedido',16,1)
				CLOSE CS_tmpPedidoVendaItem
				DEALLOCATE CS_tmpPedidoVendaItem
				RETURN	
			END
			
		END
		
		FETCH NEXT FROM CS_tmpPedidoVendaItem
		INTO	 @tmpPedidoVendaItemSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@cdCronogramaSafraVencimentoSEQ
				,@qtPedidoVendaItem
				,@qtAbertoPedidoVendaItem
				,@vrUnitarioMoedaPedidoVendaItem
				,@vrTotalMoedapedidoVendaItem
				,@vrTotalMoedaAbertoPedidoVendaItem
				
		SET @Fetch_tmpPedidoVendaItem = @@FETCH_STATUS				
		
	END		
	
	CLOSE CS_tmpPedidoVendaItem
	DEALLOCATE CS_tmpPedidoVendaItem
	
	-- Atualiza Pedido Venda Item 
	-- Zera Quantidades para os itens que não existem mais.
	update pedidovendaitem
	set qtPedidoVendaItem = 0,
	    qtAbertoPedidoVendaItem = 0,
	    vrTotalMoedaPedidoVendaItem = 0,
	    vrTotalMoedaAbertoPedidoVendaItem = 0
	where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)	

	-- Atualiza Pedido Venda Item Entrega (tabela temporaria)
	-- Zera Quantidades antes da atualização
	update tmppedidovendaitementrega
	set qtPedidoVendaItemEntrega = 0
	where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)	
		
	DECLARE CS_tmpPedidoVendaItemEntrega CURSOR FOR
	SELECT	 tmpPedidoVendaItemEntregaSEQ
			,cdProdutoSEQ
			,cdCronogramaSafraSEQ
			,dtAnoMesPedidoVendaItemEntrega
			,qtPedidoVendaItemEntrega
	FROM	tmpPedidoVendaItemEntrega
	WHERE	tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	OPEN CS_tmpPedidoVendaItemEntrega
	FETCH NEXT FROM CS_tmpPedidoVendaItemEntrega
	INTO	 @tmpPedidoVendaItemEntregaSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@dtAnoMesPedidoVendaItemEntrega
			,@qtPedidoVendaItemEntrega
						
	SET @Fetch_tmpPedidoVendaItemEntrega = @@FETCH_STATUS

	WHILE @Fetch_tmpPedidoVendaItemEntrega = 0
	BEGIN
	

		if exists (	select	1 
					from	pedidovendaitementrega
					where	cdPedidoVendaSEQ = @cdPedidoVendaSEQ
					and		cdProdutoSEQ = @cdProdutoSEQ
					and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and     dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega)
		BEGIN
					
			UPDATE PedidoVendaItemEntrega
			SET	 qtPedidoVendaItemEntrega = @qtPedidoVendaItemEntrega
				,dtUltimaAlteracao = getdate()
				,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
			WHERE
				cdPedidoVendaSEQ = @cdPedidoVendaSEQ
			and cdProdutoSEQ = @cdProdutoSEQ
			and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega

			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				RAISERROR ('5005 - Erro na Alteração do planejamento de Entrega do Pedido',16,1)
				CLOSE CS_tmpPedidoVendaItemEntrega
				DEALLOCATE CS_tmpPedidoVendaItemEntrega
				RETURN	
			END
			
		END
		
		ELSE
		
		BEGIN
		
			INSERT INTO PEDIDOVENDAITEMENTREGA
				(
				 cdPedidoVendaSEQ
				,cdProdutoSEQ
				,cdCronogramaSafraSEQ
				,dtAnoMesPedidoVendaItemEntrega
				,qtPedidoVendaItemEntrega
				,cdIndicadorPedidoVendaItemEntrega
				,wkRCPedidoVendaItemEntrega
				,wkClientePedidoVendaItemEntrega
				,dtUltimaAlteracao
				,cdUsuarioUltimaAlteracao
				)
			VALUES
			(
				 @cdPedidoVendaSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@dtAnoMesPedidoVendaItemEntrega
				,@qtPedidoVendaItemEntrega
				,1 -- @cdIndicadorPedidoVendaItemEntrega (1-Digitado)
				,null
				,null
				,getdate()
				,@cdUsuarioUltimaAlteracao
			)
			
			IF @@ERROR <> 0  
			BEGIN
				RAISERROR ('5005 - Erro na Inclusão do Planejamento de Entrega',16,1)
				CLOSE CS_tmpPedidoVendaItemEntrega
				DEALLOCATE CS_tmpPedidoVendaItemEntrega
				RETURN	
			END
			
		END
				
		FETCH NEXT FROM CS_tmpPedidoVendaItemEntrega
		INTO	 @tmpPedidoVendaItemEntregaSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@dtAnoMesPedidoVendaItemEntrega
				,@qtPedidoVendaItemEntrega
							
		SET @Fetch_tmpPedidoVendaItemEntrega = @@FETCH_STATUS
		
	END		
	
	CLOSE CS_tmpPedidoVendaItemEntrega
	DEALLOCATE CS_tmpPedidoVendaItemEntrega

	-- Atualiza Pedido Venda Item Entrega (tabela final)
	-- Zera Quantidades antes da atualização
	update pedidovendaitementrega
	set qtPedidoVendaItemEntrega = 0
	where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)	
		
	-- Atualiza Pedido Venda Item Cultura
	-- Zera Quantidades antes da atualização (tabela temporaria)
	update tmppedidovendaitemcultura
	set qtPedidoVendaItemcultura = 0
	where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)	

		
	-- Atualiza Pedido Venda Item Cultura
	DECLARE CS_tmpPedidoVendaItemCultura CURSOR FOR
	SELECT	 tmpPedidoVendaItemCulturaSEQ
			,cdProdutoSEQ
			,cdCronogramaSafraSEQ
			,cdTipoCulturaSEQ
			,qtPedidoVendaItemCultura
	FROM	tmpPedidoVendaItemCultura
	WHERE	tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ

	OPEN CS_tmpPedidoVendaItemCultura
	FETCH NEXT FROM CS_tmpPedidoVendaItemCultura
	INTO	 @tmpPedidoVendaItemCulturaSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@cdTipoCulturaSEQ
			,@qtPedidoVendaItemCultura
						
	SET @Fetch_tmpPedidoVendaItemCultura = @@FETCH_STATUS

	WHILE @Fetch_tmpPedidoVendaItemCultura = 0
	BEGIN
	

		if exists (	select	1 
					from	pedidovendaitemcultura
					where	cdPedidoVendaSEQ = @cdPedidoVendaSEQ
					and		cdProdutoSEQ = @cdProdutoSEQ
					and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and     cdTipoCulturaSEQ = @cdTipoCulturaSEQ)
		BEGIN
					
			UPDATE PedidoVendaItemCultura
			SET	 qtPedidoVendaItemCultura = @qtPedidoVendaItemCultura
				,dtUltimaAlteracao = getdate()
				,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
			WHERE
				cdPedidoVendaSEQ = @cdPedidoVendaSEQ
			and cdProdutoSEQ = @cdProdutoSEQ
			and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			and cdTipoCulturaSEQ = @cdTipoCulturaSEQ

			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				RAISERROR ('5005 - Erro na Alteração do Tipo de Cultura',16,1)
				CLOSE CS_tmpPedidoVendaItemCultura
				DEALLOCATE CS_tmpPedidoVendaItemCultura
				RETURN	
			END
			
		END
		
		ELSE
		
		BEGIN
		
			INSERT INTO PEDIDOVENDAITEMCULTURA
				(
				 cdPedidoVendaSEQ
				,cdCronogramaSafraSEQ
				,cdProdutoSEQ
				,cdTipoCulturaSEQ
				,qtPedidoVendaItemCultura
				,cdIndicadorPedidoVendaItemCultura
				,wkRCPedidoVendaItemCultura
				,wkClientePedidoVendaItemCultura
				,dtUltimaAlteracao
				,cdUsuarioUltimaAlteracao
				)
			VALUES
			(
				@cdPedidoVendaSEQ
				,@cdCronogramaSafraSEQ
				,@cdProdutoSEQ
				,@cdTipoCulturaSEQ
				,@qtPedidoVendaItemCultura
				,1 -- cdIndicadorPedidoVendaItemCultura
				,null
				,null
				,getdate()
				,@cdUsuarioUltimaAlteracao
			)
			
			IF @@ERROR <> 0  
			BEGIN
				RAISERROR ('5005 - Erro na Inclusão do Tipo de Cultura',16,1)
				CLOSE CS_tmpPedidoVendaItemCultura
				DEALLOCATE CS_tmpPedidoVendaItemCultura
				RETURN	
			END
			
		END
		
		FETCH NEXT FROM CS_tmpPedidoVendaItemCultura
		INTO	 @tmpPedidoVendaItemCulturaSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@cdTipoCulturaSEQ
				,@qtPedidoVendaItemCultura
							
		SET @Fetch_tmpPedidoVendaItemCultura = @@FETCH_STATUS
		
	END		
	
	CLOSE CS_tmpPedidoVendaItemCultura
	DEALLOCATE CS_tmpPedidoVendaItemCultura
	
	-- Atualiza Pedido Venda Item Entrega
	-- Zera Quantidades antes da atualização (tabela temporaria)
	update pedidovendaitemcultura
	set qtPedidoVendaItemcultura = 0
	where cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	and	cdProdutoSEQ not in (
							select
								cdProdutoSEQ
							from
								dbo.tmpPedidoVendaItem
							where
								tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
							and	qtPedidoVendaItem <> 0
							)	
		
		-- Exclui as tabelas temporarias
	delete from tmppedidovenda where tmppedidovendaseq = @tmpPedidoVendaSEQ
	
	delete from tmppedidovendaitem where tmppedidovendaseq = @tmpPedidoVendaSEQ
	
	delete from tmppedidovendaitementrega where tmppedidovendaseq = @tmpPedidoVendaSEQ
	
	delete from tmppedidovendaitemcultura where tmppedidovendaseq = @tmpPedidoVendaSEQ

	
	--Envio de Email para a Cooperativa, caso a alteração no pedido não tenha sido feita pela mesma.
	IF @cdUsuarioUltimaAlteracao not in (	select	cdPessoaSEQ
											from	Pessoa	
											Where	cdPessoaSEQ = @cdAgenteComercialCooperativaPedidoVenda
											union
											select  cdPessoaSEQ
											from	Pessoa
											where	cdEmpresaColaboradorPessoa = @cdAgenteComercialCooperativaPedidoVenda
											and     cdIndicadorTipoPerfilPessoa = 4)		-- Perfil Colaborador Agente
	BEGIN
	
		EXEC SP_I_SolicitacaoEnvioEmail_AlteracaoPedido
			 @cdPedidoVendaSEQ				= @cdPedidoVendaSEQ
			,@cdUsuarioUltimaAlteracao		= @cdUsuarioUltimaAlteracao
			,@cdSolicitacaoEnvioEmailSEQ	= @cdSolicitacaoEnvioEmailSEQ
			
	END
	
	