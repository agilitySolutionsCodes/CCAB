set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_U_LiberaPedidoMicrosiga
**		Name: SP_U_LiberaPedidoMicrosiga
**		Desc: Efetua a liberação de Pedidos para a CCAB
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_LiberaPedidoMicrosiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_LiberaPedidoMicrosiga]
END
GO	

CREATE PROCEDURE [dbo].[SP_U_LiberaPedidoMicrosiga]
	 @arPedidoVenda					varchar(max)
	,@cdUsuarioUltimaAlteracao		bigint
AS


DECLARE 
	 @DELIMITADOR	VARCHAR(100)
	,@S				VARCHAR(8000)


Declare		 
	 @cdAgenteComercialCooperativaPedidoVenda	bigint
	,@cdAgenteComercialCCABPedidoVenda			bigint
	,@cdAgentecomercialRCPedidoVenda			bigint
	,@cdClienteFaturamentoPedidoVenda			bigint
	,@cdClienteEntregaPedidoVenda				bigint
	,@cdPessoaOrigemFaturamento					bigint
	,@cdCronogramaSafraSEQ						bigint
	,@dtDigitacaoPedidoVenda					datetime
	,@dtEmissaoPedidoVenda						datetime
	,@cdTipoPedidoVenda							int
	,@cdModalidadePedidoVenda					int
	,@cdIndicadorMoedaPedidoVenda				int
	,@vrTotalMoedaPedidoVenda					numeric(22,4)
	,@cdPedidoVendaSEQ							bigint
	,@cdPedidoVendaERPSEQ						bigint
	,@FETCH_PedidoMicrosiga						int

Declare
	 @cdPedidoVendaSEQParcela					bigint	
	,@cdCronogramaSafraSEQParcela				bigint
	,@cdCronogramaSafraVencimentoSEQParcela		bigint
	,@vrTotalMoedaPedidoVendaParcela			numeric(22,4)
	,@vrTotalMoedaAbertoPedidoVendaParcela		numeric(22,4)
	,@dtCronogramaSafraVencimento				datetime
	,@nroParcela								int
	,@FETCH_Parcela								int
	
declare
	 @cdProdutoSEQItem							bigint
	,@cdCronogramaSafraSEQItem					bigint
	,@cdCronogramaSafraVencimentoSEQItem		bigint
	,@DataItem									datetime
	,@qtPedidoVendaItem							numeric(22,4)
	,@qtAbertoPedidoVendaItem					numeric(22,4)
	,@vrUnitarioMoedaPedidoVendaItem			numeric(22,4)
	,@vrTotalMoedaAbertoPedidoVendaItem			numeric(22,4)
	,@pcDescontoPontualidade					numeric(8,4)
	,@FETCH_Item								int

declare
	 @dtAnoMesPedidoVendaItemEntrega			datetime
	,@qtSaldoPedidoVendaItemEntrega				numeric(22,4)
	,@qtPedidoVendaERPItem						numeric(22,4)
	,@FETCH_Entrega								int

	SELECT 
		@DELIMITADOR = ','

	IF LEN(@arPedidoVenda) > 0
	BEGIN
		SELECT
			@arPedidoVenda = @arPedidoVenda + @DELIMITADOR 
	END

	CREATE TABLE 
		#ARRAY
	(ITEM_ARRAY	VARCHAR(max))

	WHILE LEN(@arPedidoVenda) > 0
	BEGIN
		SELECT 
			@S = LTRIM(SUBSTRING(@arPedidoVenda, 1, CHARINDEX(@DELIMITADOR, @arPedidoVenda) - 1))
	   
		INSERT INTO 
			#ARRAY 
			(ITEM_ARRAY) 
		VALUES 
			(@S)

		SELECT 
			@arPedidoVenda = SUBSTRING(@arPedidoVenda, CHARINDEX(@DELIMITADOR, @arPedidoVenda) + 1, LEN(@arPedidoVenda))
	END

	-- Atualiza Pedidos
	UPDATE	PedidoVenda
	SET	cdIndicadorStatusPedidoVenda = 5, -- Liberado para o Microsiga
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao,
		dtEmissaoPedidoVenda = getdate()
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusPedidoVenda in (3) -- Aceito pela CCAB

	IF @@ERROR <> 0
	BEGIN
		PRINT 'Erro no Update do Pedido de Venda - Atualiza Pedidos'
		RAISERROR ('Erro no Update do Pedido de Venda - Atualiza Pedidos',16,1)
		RETURN
	END
	
	UPDATE	PedidoVendaItem
	SET	cdIndicadorStatusPedidoVendaItem = 5, -- Liberado para o Microsiga
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusPedidoVendaItem in (3) -- Aceito pela CCAB

	IF @@ERROR <> 0
	BEGIN
		PRINT 'Erro no Update do Pedido de Venda Item - Atualiza Pedidos'
		RAISERROR ('Erro no Update do Pedido de Venda Item - Atualiza Pedidos',16,1)
		RETURN
	END

	UPDATE	PedidoVendaItemEntrega
	SET	cdIndicadorPedidoVendaItemEntrega = 5, -- Liberado para o Microsiga
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorPedidoVendaItemEntrega in (3) -- Aceito pela CCAB

	IF @@ERROR <> 0
	BEGIN
		PRINT 'Erro no Update do Pedido de Venda Item Entrega - Atualiza Pedidos'
		RAISERROR ('Erro no Update do Pedido de Venda Item Entrega- Atualiza Pedidos',16,1)
		RETURN
	END

	UPDATE	PedidoVendaItemCultura
	SET	cdIndicadorPedidoVendaItemCultura = 5, -- Liberado para o Microsiga
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorPedidoVendaItemCultura in (3) -- Aceito pela CCAB
	
	IF @@ERROR <> 0
	BEGIN
		PRINT 'Erro no Update do Pedido de Venda Item Cultura - Atualiza Pedidos'
		RAISERROR ('Erro no Update do Pedido de Venda Item Cultura- Atualiza Pedidos',16,1)
		RETURN
	END
	
	-- Gera Pedidos Microsiga
	DECLARE CS_PedidoMicrosiga CURSOR FOR
	SELECT	 cdAgenteComercialCooperativaPedidoVenda
			,cdAgenteComercialCCABPedidoVenda
			,cdAgentecomercialRCPedidoVenda
			,cdClienteFaturamentoPedidoVenda
			,cdClienteEntregaPedidoVenda
			,cdPessoaOrigemFaturamento
			,cdCronogramaSafraSEQ
			,dtDigitacaoPedidoVenda
			,dtEmissaoPedidoVenda
			,cdTipoPedidoVenda
			,cdModalidadePedidoVenda
			,cdIndicadorMoedaPedidoVenda
			,vrTotalMoedaPedidoVenda
			,cdPedidoVendaSEQ
	FROM	PedidoVenda
	WHERE   cdPedidoVendaSEQ in ( select ITEM_ARRAY from #ARRAY)
	AND     cdPedidoVendaSEQ not in (select cdPedidoVendaSEQ from PedidoVendaERP)

	OPEN CS_PedidoMicrosiga                                
	FETCH NEXT FROM CS_PedidoMicrosiga
	INTO	@cdAgenteComercialCooperativaPedidoVenda
			,@cdAgenteComercialCCABPedidoVenda
			,@cdAgentecomercialRCPedidoVenda
			,@cdClienteFaturamentoPedidoVenda
			,@cdClienteEntregaPedidoVenda
			,@cdPessoaOrigemFaturamento
			,@cdCronogramaSafraSEQ
			,@dtDigitacaoPedidoVenda
			,@dtEmissaoPedidoVenda
			,@cdTipoPedidoVenda
			,@cdModalidadePedidoVenda
			,@cdIndicadorMoedaPedidoVenda
			,@vrTotalMoedaPedidoVenda
			,@cdPedidoVendaSEQ
				
	SET @FETCH_PedidoMicrosiga = @@FETCH_STATUS
			
	WHILE @FETCH_PedidoMicrosiga = 0
	BEGIN 
	
			-- Atualiza o Saldo de Entrega nos Itens
		UPDATE	PedidoVendaItemEntrega
		SET		qtSaldoPedidoVendaItemEntrega = qtPedidoVendaItemEntrega
		WHERE	cdPedidoVendaSEQ = @cdPedidoVendaSEQ
		
		IF @@ERROR <> 0
		BEGIN
			PRINT 'Erro no Update do Pedido de Venda Item Entrega - Atualiza Saldo Entrega'
			CLOSE CS_PedidoMicrosiga
			DEALLOCATE CS_PedidoMicrosiga
			RAISERROR ('Erro no Update do Pedido de Venda Item Entrega- Atualiza Saldo Entrega',16,1)
			RETURN
		END

		-- Define as Parcelas (quebra dos pedidos)
		DECLARE CS_Parcela CURSOR FOR
		SELECT	distinct PED.cdPedidoVendaSEQ
						,PED.cdCronogramaSafraSEQ
						,CRO.dtCronogramaSafraVencimento
						,PED.cdCronogramaSafraVencimentoSEQ						
						,sum(isnull(PED.vrTotalMoedaPedidoVendaItem,0))
						,sum(isnull(PED.vrTotalMoedaAbertoPedidoVendaItem,0))
		FROM	PedidoVendaItem PED,
				CronogramaSafraVencimento CRO
		WHERE	PED.cdPedidoVendaSEQ = @cdPedidoVendaSEQ
		AND     PED.cdCronogramaSafraVencimentoSEQ = CRO.cdCronogramaSafraVencimentoSEQ
		AND     PED.qtPedidoVendaItem > 0
		GROUP BY PED.cdPedidoVendaSEQ, PED.cdCronogramaSafraSEQ, CRO.dtCronogramaSafraVencimento, PED.cdCronogramaSafraVencimentoSEQ
		ORDER BY 1,2,3
		
		-- Inicializa o numero da Parcela
		set @nroParcela = 0
						
		OPEN CS_Parcela
		FETCH NEXT FROM CS_Parcela
		INTO	 @cdPedidoVendaSEQParcela					
				,@cdCronogramaSafraSEQParcela				
				,@dtCronogramaSafraVencimento		
				,@cdCronogramaSafraVencimentoSEQParcela
				,@vrTotalMoedaPedidoVendaParcela			
				,@vrTotalMoedaAbertoPedidoVendaParcela		
				
		SET @FETCH_Parcela = @@FETCH_STATUS
		
		WHILE @FETCH_Parcela = 0
		BEGIN 
		
			-- Conta Parcela
			set @nroParcela = @nroParcela + 1
		
			-- Insere Cabeçalho do Pedido Microsiga
			INSERT INTO PedidoVendaERP
				(	 cdPedidoVendaSEQ
					,cdIndicadorStatusPedidoVendaERP
					,dtVenctoPedidoVendaERP
					,vrTotalMoedaPedidoVendaERP
					,vrTotalAbertoMoedaPedidoVendaERP
					,cdPedidoVendaERP
					,cdFilialFaturadoraPedidoVendaERP
					,dtUltimaAlteracao
					,cdUsuarioUltimaAlteracao
					,cdPedidoVendaERPUsuario
				)
			VALUES
				(	 @cdPedidoVendaSEQParcela
					,5 -- Liberado para o Microsiga
					,@dtCronogramaSafraVencimento
					,@vrTotalMoedaPedidoVendaParcela
					,@vrTotalMoedaAbertoPedidoVendaParcela
					,null
					,null
					,getdate()
					,@cdUsuarioUltimaAlteracao
					,ltrim(rtrim(@cdPedidoVendaSEQParcela)) + '-' + ltrim(rtrim(@nroParcela))
				)

			IF @@ERROR <> 0
			BEGIN
				PRINT 'Erro no Insert de Pedido Venda ERP - Cabeçalho Pedido Microsiga'
				CLOSE CS_PedidoMicrosiga
				DEALLOCATE CS_PedidoMicrosiga
				CLOSE CS_Parcela
				DEALLOCATE CS_Parcela
				RAISERROR ('Erro no Insert de Pedido Venda ERP - Cabeçalho Pedido Microsiga',16,1)
				RETURN
			END
				
			-- Define o codigo do Pedido no ERP
			SELECT
				@cdPedidoVendaERPSEQ = SCOPE_IDENTITY()
				
			-- Define os Itens do Pedido com base na Entrega
			DECLARE CS_Item CURSOR FOR
			SELECT	 ITE.cdProdutoSEQ
					,ITE.cdCronogramaSafraSEQ
					,ITE.cdCronogramaSafraVencimentoSEQ
					,ISNULL(CRO.dtCronogramaSafraVencimento,PED.dtDigitacaoPedidoVenda) as DataItem
					,ITE.qtPedidoVendaItem
					,ITE.qtAbertoPedidoVendaItem
					,ITE.vrUnitarioMoedaPedidoVendaItem
					,ITE.vrTotalMoedaAbertoPedidoVendaItem
					,ITE.pcDescontoPontualidade
			FROM	PedidoVendaItem ITE
					,CronogramaSafraVencimento CRO
					,PedidoVenda PED
			WHERE	ITE.cdPedidoVendaSEQ = @cdPedidoVendaSEQ
			and     ITE.qtPedidoVendaItem > 0
			and     ITE.cdCronogramaSafraVencimentoSEQ = CRO.cdCronogramaSafraVencimentoSEQ
			and     ITE.cdPedidoVendaSEQ = PED.cdPedidoVendaSEQ
			and     ITE.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQParcela
			ORDER by 1,2,4
		
			OPEN CS_Item
			FETCH NEXT FROM CS_Item
			INTO	 @cdProdutoSEQItem							
					,@cdCronogramaSafraSEQItem					
					,@cdCronogramaSafraVencimentoSEQItem		
					,@DataItem									
					,@qtPedidoVendaItem							
					,@qtAbertoPedidoVendaItem					
					,@vrUnitarioMoedaPedidoVendaItem			
					,@vrTotalMoedaAbertoPedidoVendaItem	
					,@pcDescontoPontualidade		
					
			SET @FETCH_Item = @@FETCH_STATUS
			
			WHILE @FETCH_Item = 0
			BEGIN 
			
				-- Busca as Informações de Entrega
				DECLARE CS_Entrega CURSOR FOR
				SELECT	 dtAnoMesPedidoVendaItemEntrega
						,qtSaldoPedidoVendaItemEntrega
				FROM	PedidoVendaItemEntrega
				WHERE	cdPedidoVendaSEQ = @cdPedidoVendaSEQ
				and     qtSaldoPedidoVendaItemEntrega > 0
				and     cdProdutoSEQ = @cdProdutoSEQItem
				Order by dtAnoMesPedidoVendaItemEntrega
				
				OPEN CS_Entrega
				FETCH NEXT FROM CS_Entrega
				INTO	 @dtAnoMesPedidoVendaItemEntrega
						,@qtSaldoPedidoVendaItemEntrega
			
				SET @FETCH_Entrega = @@FETCH_STATUS
				
				WHILE @FETCH_Entrega = 0 and @qtPedidoVendaItem > 0
				BEGIN 
				
					-- Define a Quantidade do item conforme a entrega
					IF @qtPedidoVendaItem > @qtSaldoPedidoVendaItemEntrega
					BEGIN
						SET @qtPedidoVendaERPItem = @qtSaldoPedidoVendaItemEntrega
					END
					ELSE
					BEGIN
						SET @qtPedidoVendaERPItem = @qtPedidoVendaItem
					END
					
					-- Atualiza a Quantidade
					SET @qtPedidoVendaItem = @qtPedidoVendaItem - @qtPedidoVendaERPItem
					
					-- Insere O item
					INSERT INTO PedidoVendaERPItem
						(	 cdPedidoVendaERPSEQ
							,cdProdutoSEQ
							,dtAnoMesPedidoVendaItemEntrega
							,qtPedidoVendaERPItem
							,qtAbertoPedidoVendaERPItem
							,vrUnitarioMoedaPedidoVendaERPItem
							,vrTotalMoedaPedidoVendaERPItem
							,vrTotalMoedaAbertoPedidoVendaERPItem
							,cdIndicadorStatusPedidoVendaERPItem
							,cdPedidoVendaERP
							,cdPedidoVendaItemERP
							,cdFilialFaturadoraPedidoVendaERP
							,dtUltimaAlteracao
							,cdUsuarioUltimaAlteracao
							,pcDescontoPontualidade
						)
					VALUES
						(	 @cdPedidoVendaERPSEQ
							,@cdProdutoSEQItem
							,@dtAnoMesPedidoVendaItemEntrega
							,@qtPedidoVendaERPItem
							,@qtPedidoVendaERPItem
							,@vrUnitarioMoedaPedidoVendaItem
							,(@vrUnitarioMoedaPedidoVendaItem * @qtPedidoVendaERPItem)
							,(@vrUnitarioMoedaPedidoVendaItem * @qtPedidoVendaERPItem)							
							,5 -- Liberado para o Microsiga
							,null
							,null
							,null
							,getdate()
							,@cdUsuarioUltimaAlteracao
							,@pcDescontoPontualidade
						)
						
					IF @@ERROR <> 0
					BEGIN
						PRINT 'Erro no Insert de Pedido Venda ERP Item - Itens Pedido Microsiga'
						CLOSE CS_PedidoMicrosiga
						DEALLOCATE CS_PedidoMicrosiga
						CLOSE CS_Parcela
						DEALLOCATE CS_Parcela
						CLOSE CS_Item
						DEALLOCATE CS_Item
						RAISERROR ('Erro no Insert de Pedido Venda ERP Item - Itens Pedido Microsiga',16,1)
						RETURN
					END
												
					-- Atualiza Saldo da Entrega
					Update	PedidoVendaItemEntrega
					Set		qtSaldoPedidoVendaItemEntrega = qtSaldoPedidoVendaItemEntrega - @qtPedidoVendaERPItem
					Where	cdPedidoVendaSEQ = @cdPedidoVendaSEQ
					and     cdProdutoSEQ = @cdProdutoSEQItem
					and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQItem
					and     dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega

					IF @@ERROR <> 0
					BEGIN
						PRINT 'Erro no Update do Saldo de Entrega - Itens Pedido Microsiga'
						CLOSE CS_PedidoMicrosiga
						DEALLOCATE CS_PedidoMicrosiga
						CLOSE CS_Parcela
						DEALLOCATE CS_Parcela
						CLOSE CS_Item
						DEALLOCATE CS_Item
						RAISERROR ('Erro no Update do Saldo de Entrega - Itens Pedido Microsiga',16,1)
						RETURN
					END
				
					FETCH NEXT FROM CS_Entrega
					INTO	 @dtAnoMesPedidoVendaItemEntrega
							,@qtSaldoPedidoVendaItemEntrega
				
					SET @FETCH_Entrega = @@FETCH_STATUS
					
				END
				
				CLOSE CS_Entrega
				DEALLOCATE CS_Entrega
				
				FETCH NEXT FROM CS_Item
				INTO	 @cdProdutoSEQItem							
						,@cdCronogramaSafraSEQItem					
						,@cdCronogramaSafraVencimentoSEQItem		
						,@DataItem									
						,@qtPedidoVendaItem							
						,@qtAbertoPedidoVendaItem					
						,@vrUnitarioMoedaPedidoVendaItem			
						,@vrTotalMoedaAbertoPedidoVendaItem		
						,@pcDescontoPontualidade	
						
				SET @FETCH_Item = @@FETCH_STATUS
				
			END
			
			CLOSE CS_Item
			DEALLOCATE CS_Item				
							
			FETCH NEXT FROM CS_Parcela
			INTO	 @cdPedidoVendaSEQParcela					
					,@cdCronogramaSafraSEQParcela				
					,@dtCronogramaSafraVencimento	
					,@cdCronogramaSafraVencimentoSEQParcela	
					,@vrTotalMoedaPedidoVendaParcela			
					,@vrTotalMoedaAbertoPedidoVendaParcela		
				
			SET @FETCH_Parcela = @@FETCH_STATUS
			
		END

		CLOSE CS_Parcela
		DEALLOCATE CS_Parcela
		
		FETCH NEXT FROM CS_PedidoMicrosiga
		INTO	@cdAgenteComercialCooperativaPedidoVenda
				,@cdAgenteComercialCCABPedidoVenda
				,@cdAgentecomercialRCPedidoVenda
				,@cdClienteFaturamentoPedidoVenda
				,@cdClienteEntregaPedidoVenda
				,@cdPessoaOrigemFaturamento
				,@cdCronogramaSafraSEQ
				,@dtDigitacaoPedidoVenda
				,@dtEmissaoPedidoVenda
				,@cdTipoPedidoVenda
				,@cdModalidadePedidoVenda
				,@cdIndicadorMoedaPedidoVenda
				,@vrTotalMoedaPedidoVenda
				,@cdPedidoVendaSEQ
					
		SET @FETCH_PedidoMicrosiga = @@FETCH_STATUS
		
	END
	
	CLOSE CS_PedidoMicrosiga
	DEALLOCATE CS_PedidoMicrosiga

	DROP TABLE #ARRAY

SET QUOTED_IDENTIFIER OFF

