SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaCompromissoCompra]
END
GO


CREATE PROCEDURE SP_J_AtualizaCompromissoCompra

	
AS

	DECLARE 
		 @Fetch_CompromissoCompra					int
		,@Fetch_CompromissoCompraItem				int

		,@cdCompromissoCompraSEQ					bigint
		,@vrTotalMoedaCompromissoCompra				numeric(22,4)
		,@vrTotalAbertoMoedaCompromissoCompra		numeric(22,4)
	
		,@cdCompromissoCompraItemSEQ				bigint
		,@cdProdutoSEQ								bigint
		,@cdCronogramaSafraSEQ						bigint
		,@cdCronogramaSafraVencimentoSEQ			bigint
		,@vrTotalMoedaCompromissoCompraItem			numeric(22,4)
		,@vrTotalMoedaAbertoCompromissoCompraItem	numeric(22,4)
		,@qtCompromissoCompraItem					numeric(22,6)
		,@qtAbertoCompromissoCompraItem				numeric(22,6)

		,@vrTotalMoedaPedidoVenda					numeric(22,4)
		,@qtPedidoVendaItem							numeric(22,6)
		,@vrTotalMoedaPedidoVendaItem				numeric(22,4)
		

	-- Cursor dos Compromissos
	DECLARE CS_CompromissoCompra CURSOR FOR
	SELECT	
		 cdCompromissoCompraSEQ
		,vrTotalMoedaCompromissoCompra
	FROM	
		CompromissoCompra 
	
	OPEN CS_CompromissoCompra
	FETCH NEXT FROM CS_CompromissoCompra
	INTO	
		 @cdCompromissoCompraSEQ
		,@vrTotalMoedaCompromissoCompra
					
	SET @Fetch_CompromissoCompra = @@FETCH_STATUS
	
	WHILE @Fetch_CompromissoCompra = 0
	BEGIN

		begin transaction Transacao

		-- Busca valor do Compromisso nos pedidos de Venda
		set @vrTotalMoedaPedidoVenda = 0
		select
			@vrTotalMoedaPedidoVenda	= isnull(sum(vrTotalMoedaPedidoVenda), 0)
		from
			dbo.PedidoVenda
		where
			cdCompromissoCompraSEQ			= @cdCompromissoCompraSEQ

		select
			@vrTotalAbertoMoedaCompromissoCompra	= @vrTotalMoedaCompromissoCompra - @vrTotalMoedaPedidoVenda
	
		if @vrTotalAbertoMoedaCompromissoCompra <> (select	vrTotalAbertoMoedaCompromissoCompra 
													from	CompromissoCompra
													Where	cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ)
		begin
				
			-- Atualizo o Compromisso
			update 
				dbo.CompromissoCompra
			set
				vrTotalAbertoMoedaCompromissoCompra = @vrTotalAbertoMoedaCompromissoCompra
			where
				cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
			
			-- Verifica Erro no Update
			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				rollback transaction Transacao
				PRINT 'Erro no Update da Tabela de Compromisso de Compra'
				CLOSE CS_CompromissoCompra
				DEALLOCATE CS_CompromissoCompra
				RAISERROR ('5002',16,1)
				RETURN
			END
			
		end

		-- Itens do Compromisso
		DECLARE CS_CompromissoCompraItem CURSOR FOR
			select distinct
				 cdCompromissoCompraItemSEQ
				,cdCompromissoCompraSEQ
				,cdProdutoSEQ
				,cdCronogramaSafraSEQ
				,cdCronogramaSafraVencimentoSEQ
				,qtCompromissoCompraItem					
				,vrTotalMoedaCompromissoCompraItem			
			from
				dbo.CompromissoCompraItem
			where
				cdCompromissoCompraSEQ			= @cdCompromissoCompraSEQ
		
		OPEN CS_CompromissoCompraItem
		FETCH NEXT FROM CS_CompromissoCompraItem
		INTO	
			 @cdCompromissoCompraItemSEQ
			,@cdCompromissoCompraSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@cdCronogramaSafraVencimentoSEQ
			,@qtCompromissoCompraItem					
			,@vrTotalMoedaCompromissoCompraItem	
						
		SET @Fetch_CompromissoCompraItem = @@FETCH_STATUS
		
		WHILE @Fetch_CompromissoCompraItem = 0
		BEGIN
			
			select
				 @qtPedidoVendaItem					= isnull(sum(qtPedidoVendaItem), 0)
				,@vrTotalMoedaPedidoVendaItem		= isnull(sum(vrTotalMoedaPedidoVendaItem), 0)
			from
				dbo.PedidoVenda			PED
			inner join
				dbo.PedidoVendaItem		ITE	on PED.cdPedidoVendaSEQ	= ITE.cdPedidoVendaSEQ
			inner join
			    dbo.CompromissoCompra   COM on PED.cdCompromissoCompraSEQ = COM.cdCompromissoCompraSEQ
			
			where
				PED.cdCompromissoCompraSEQ			= @cdCompromissoCompraSEQ
			and	ITE.cdProdutoSEQ					= @cdProdutoSEQ
			and ITE.cdCronogramaSafraSEQ			= @cdCronogramaSafraSEQ
			and ITE.cdCronogramaSafraVencimentoSEQ  = @cdCronogramaSafraVencimentoSEQ

			select
				 @qtAbertoCompromissoCompraItem				= @qtCompromissoCompraItem - @qtPedidoVendaItem
				,@vrTotalMoedaAbertoCompromissoCompraItem	= @vrTotalMoedaCompromissoCompraItem - @vrTotalMoedaPedidoVendaItem

			if @vrTotalMoedaAbertoCompromissoCompraItem <> (select	vrTotalMoedaAbertoCompromissoCompraItem
															from	CompromissoCompraItem
															Where	cdCompromissoCompraSEQ =	 @cdCompromissoCompraSEQ
															and     cdCompromissoCompraItemSEQ = @cdCompromissoCompraItemSEQ)
			begin

				-- Atualizo o Item Compromisso
				update 
					dbo.CompromissoCompraItem
				set
					 qtAbertoCompromissoCompraItem				= @qtAbertoCompromissoCompraItem
					,vrTotalMoedaAbertoCompromissoCompraItem	= @vrTotalMoedaAbertoCompromissoCompraItem
				where
					cdCompromissoCompraSEQ						= @cdCompromissoCompraSEQ
				and	cdCompromissoCompraItemSEQ					= @cdCompromissoCompraItemSEQ

				-- Verifica Erro no Update
				IF @@ERROR <> 0  OR @@ROWCOUNT = 0
				BEGIN
					rollback transaction Transacao
					PRINT 'Erro no Update da Tabela de Item de Compromisso de Compra'
					CLOSE CS_CompromissoCompraItem
					DEALLOCATE CS_CompromissoCompraItem
					RAISERROR ('5002',16,1)
					RETURN
				END
				
			end
			
			FETCH NEXT FROM CS_CompromissoCompraItem
			INTO	
				 @cdCompromissoCompraItemSEQ
				,@cdCompromissoCompraSEQ
				,@cdProdutoSEQ
				,@cdCronogramaSafraSEQ
				,@cdCronogramaSafraVencimentoSEQ
				,@qtCompromissoCompraItem					
				,@vrTotalMoedaCompromissoCompraItem	
						
			SET @Fetch_CompromissoCompraItem = @@FETCH_STATUS
					
		END
		
		CLOSE CS_CompromissoCompraItem
		DEALLOCATE CS_CompromissoCompraItem

		commit transaction Transacao
		
		FETCH NEXT FROM CS_CompromissoCompra
		INTO	
			 @cdCompromissoCompraSEQ
			,@vrTotalMoedaCompromissoCompra
					
		SET @Fetch_CompromissoCompra = @@FETCH_STATUS
				
	END
	
	CLOSE CS_CompromissoCompra
	DEALLOCATE CS_CompromissoCompra

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

