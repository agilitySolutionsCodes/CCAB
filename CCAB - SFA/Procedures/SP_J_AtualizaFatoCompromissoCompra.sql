SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaFatoCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaFatoCompromissoCompra]
END
GO


CREATE PROCEDURE SP_J_AtualizaFatoCompromissoCompra
	
AS

	BEGIN
	
		-- Efetua Truncate na Tabela
		TRUNCATE TABLE FATO_CompromissoCompra
	
		--Variaveis Cursor CompromissoCompra
		DECLARE @cdCompromissoCompraSEQ		bigint
		DECLARE @cdPessoaOrigemFaturamento	bigint
		DECLARE @cdAgenteComercialCooperativaCompromissoCompra	bigint
		DECLARE @cdAgenteComercialCCABCompromissoCompra	bigint
		DECLARE @cdAgenteComercialRCCompromissoCompra	bigint
		DECLARE @cdCronogramaSafraSEQ bigint
		DECLARE @dtEmissaoCompromissoCompra datetime
		DECLARE @cdIndicadorMoedaCompromissoCompra bigint
		DECLARE @vrTotalMoedaCompromissoCompra numeric(22,4)
		DECLARE @vrTotalAbertoMoedaCompromissoCompra numeric(22,4)
		DECLARE @Fetch_CompromissoCompra int		
		
		-- Variaveis Cursor Produto
		DECLARE @cdProdutoSEQ bigint
		DECLARE @qtProduto int
		DECLARE @Fetch_Produto int
		
		-- Variaveis Cursor Vencimento
		DECLARE @cdCronogramaSafraVencimentoSEQ bigint
		DECLARE @dtCronogramaSafraVencimento datetime
		DECLARE @qtVencimento int
		DECLARE @Fetch_Vencimento int
	
		-- Variaveis Compromisso Item
		DECLARE @cdCompromissoCompraItemSEQ bigint
		DECLARE	@qtCompromissoCompraItem numeric(22,6)
		DECLARE	@qtAbertoCompromissoCompraItem numeric(22,6)
		DECLARE	@vrUnitarioMoedaCompromissoCompraItem numeric(22,4)
		DECLARE	@vrTotalMoedaCompromissoCompraItem numeric(22,4)
		DECLARE	@vrTotalMoedaAbertoCompromissoCompraItem numeric(22,4)
		DECLARE @Fetch_Item int
	
		-- Variaveis FATO
		DECLARE	@dtVencimento1CompromissoCompra datetime
		DECLARE	@dtVencimento2CompromissoCompra datetime	
		DECLARE	@dtVencimento3CompromissoCompra datetime
		DECLARE	@dtVencimento4CompromissoCompra datetime
		DECLARE	@dtVencimento5CompromissoCompra datetime
		DECLARE	@dtVencimento6CompromissoCompra datetime
		
		DECLARE @qtCompromissoCompraItem1 numeric(22,4)
		DECLARE @qtCompromissoCompraItem2 numeric(22,4)
		DECLARE @qtCompromissoCompraItem3 numeric(22,4)
		DECLARE @qtCompromissoCompraItem4 numeric(22,4)
		DECLARE @qtCompromissoCompraItem5 numeric(22,4)
		DECLARE @qtCompromissoCompraItem6 numeric(22,4)

		DECLARE @vrUnitarioCompromissoCompraItem1 numeric(22,4)
		DECLARE @vrUnitarioCompromissoCompraItem2 numeric(22,4)
		DECLARE @vrUnitarioCompromissoCompraItem3 numeric(22,4)
		DECLARE @vrUnitarioCompromissoCompraItem4 numeric(22,4)
		DECLARE @vrUnitarioCompromissoCompraItem5 numeric(22,4)
		DECLARE @vrUnitarioCompromissoCompraItem6 numeric(22,4)
		
		DECLARE @vrTotalMoedaParcela1CompromissoCompra numeric(22,4)
		DECLARE @vrTotalMoedaParcela2CompromissoCompra numeric(22,4)
		DECLARE @vrTotalMoedaParcela3CompromissoCompra numeric(22,4)
		DECLARE @vrTotalMoedaParcela4CompromissoCompra numeric(22,4)
		DECLARE @vrTotalMoedaParcela5CompromissoCompra numeric(22,4)
		DECLARE @vrTotalMoedaParcela6CompromissoCompra numeric(22,4)
		
		DECLARE @qtAbertoCompromissoCompraItem1 numeric(22,4)
		DECLARE @qtAbertoCompromissoCompraItem2 numeric(22,4)				
		DECLARE @qtAbertoCompromissoCompraItem3 numeric(22,4)
		DECLARE @qtAbertoCompromissoCompraItem4 numeric(22,4)
    	DECLARE @qtAbertoCompromissoCompraItem5 numeric(22,4)
		DECLARE @qtAbertoCompromissoCompraItem6 numeric(22,4)
				
		DECLARE @vrTotalAbertoMoedaParcela1CompromissoCompra numeric(22,4)
		DECLARE @vrTotalAbertoMoedaParcela2CompromissoCompra numeric(22,4)
		DECLARE @vrTotalAbertoMoedaParcela3CompromissoCompra numeric(22,4)
		DECLARE @vrTotalAbertoMoedaParcela4CompromissoCompra numeric(22,4)
		DECLARE @vrTotalAbertoMoedaParcela5CompromissoCompra numeric(22,4)
		DECLARE @vrTotalAbertoMoedaParcela6CompromissoCompra numeric(22,4)
		
		DECLARE @qtSomatoriaCompromissoCompraItem numeric(22,4)
		DECLARE @vrSomatoriaMoedaCompromissoCompraItem numeric(22,4)
		DECLARE @qtSomatoriaConsumidaCompromissoCompraItem numeric(22,4)
		DECLARE @vrSomatoriaMoedaConsumidaCompromissoCompraItem numeric(22,4)
				
		-- Defini Cursor do cabeçalho do compromisso de compra
		DECLARE CS_CompromissoCompra CURSOR FOR
		SELECT	 cdCompromissoCompraSEQ
				,cdPessoaOrigemFaturamento
				,cdAgenteComercialCooperativaCompromissoCompra
				,cdAgentecomercialCCABCompromissoCompra
				,cdAgenteComercialRCCompromissoCompra
				,cdCronogramaSafraSEQ
				,dtEmissaoCompromissoCompra
				,cdIndicadorMoedaCompromissoCompra
				,vrTotalMoedaCompromissoCompra
				,vrTotalAbertoMoedaCompromissoCompra
		FROM	CompromissoCompra
		
		OPEN CS_CompromissoCompra
		FETCH NEXT FROM CS_CompromissoCompra
		INTO	 @cdCompromissoCompraSEQ
				,@cdPessoaOrigemFaturamento
				,@cdAgenteComercialCooperativaCompromissoCompra
				,@cdAgentecomercialCCABCompromissoCompra
				,@cdAgenteComercialRCCompromissoCompra
				,@cdCronogramaSafraSEQ
				,@dtEmissaoCompromissoCompra
				,@cdIndicadorMoedaCompromissoCompra
				,@vrTotalMoedaCompromissoCompra
				,@vrTotalAbertoMoedaCompromissoCompra
						
		SET @Fetch_CompromissoCompra = @@FETCH_STATUS
		
		WHILE @Fetch_CompromissoCompra = 0
		BEGIN
				
			-- Inicializa varial de Produto
			SET @qtProduto = 0				
				
			-- Defini Cursor dos Produtos
			DECLARE CS_Produto CURSOR FOR
			SELECT	distinct cdProdutoSEQ
			FROM	CompromissoCompraItem
			WHERE	cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
			AND     qtCompromissoCompraItem <> 0
			
			OPEN CS_Produto
			FETCH NEXT FROM CS_Produto
			INTO	 @cdProdutoSEQ
			
			SET @Fetch_Produto = @@FETCH_STATUS
			
			WHILE @Fetch_Produto= 0
			BEGIN
			
				-- Conta o numero de produtos do compromisso
				SET @qtProduto = @qtProduto + 1
			
				-- Inicializa a Variavel de vencimento
				SET @qtVencimento = 0
				
				-- Inicializa Variaveis do Item
				SET @dtVencimento1CompromissoCompra = NULL
				SET @dtVencimento2CompromissoCompra = NULL
				SET @dtVencimento3CompromissoCompra = NULL
				SET @dtVencimento4CompromissoCompra = NULL
				SET @dtVencimento5CompromissoCompra = NULL
				SET @dtVencimento6CompromissoCompra = NULL
					
				SET @qtCompromissoCompraItem1 = 0
				SET @qtCompromissoCompraItem2 = 0
				SET @qtCompromissoCompraItem3 = 0
				SET @qtCompromissoCompraItem4 = 0
				SET @qtCompromissoCompraItem5 = 0
				SET @qtCompromissoCompraItem6 = 0
		 
				SET @vrUnitarioCompromissoCompraItem1 = 0
				SET @vrUnitarioCompromissoCompraItem2 = 0
				SET @vrUnitarioCompromissoCompraItem3 = 0
				SET @vrUnitarioCompromissoCompraItem4 = 0
				SET @vrUnitarioCompromissoCompraItem5 = 0
				SET @vrUnitarioCompromissoCompraItem6 = 0
		
				SET @vrTotalMoedaParcela1CompromissoCompra = 0
				SET @vrTotalMoedaParcela2CompromissoCompra = 0
				SET @vrTotalMoedaParcela3CompromissoCompra = 0
				SET @vrTotalMoedaParcela4CompromissoCompra = 0
				SET @vrTotalMoedaParcela5CompromissoCompra = 0
				SET @vrTotalMoedaParcela6CompromissoCompra = 0
		
				SET @qtAbertoCompromissoCompraItem1 = 0
				SET @qtAbertoCompromissoCompraItem2 = 0
				SET @qtAbertoCompromissoCompraItem3 = 0
				SET @qtAbertoCompromissoCompraItem4 = 0
				SET @qtAbertoCompromissoCompraItem5 = 0
				SET @qtAbertoCompromissoCompraItem6 = 0
				
				SET @vrTotalAbertoMoedaParcela1CompromissoCompra = 0
				SET @vrTotalAbertoMoedaParcela2CompromissoCompra = 0
				SET @vrTotalAbertoMoedaParcela3CompromissoCompra = 0
				SET @vrTotalAbertoMoedaParcela4CompromissoCompra = 0
				SET @vrTotalAbertoMoedaParcela5CompromissoCompra = 0
				SET @vrTotalAbertoMoedaParcela6CompromissoCompra = 0
		
				SET @qtSomatoriaCompromissoCompraItem = 0
				SET @vrSomatoriaMoedaCompromissoCompraItem = 0
				SET @qtSomatoriaConsumidaCompromissoCompraItem = 0 
				SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = 0
			
				-- Defini Cursor dos Vencimentos com base na campanha do Compromisso
				DECLARE CS_Vencimento CURSOR FOR
				SELECT	 cdCronogramaSafraVencimentoSEQ
						,dtCronogramaSafraVencimento
				FROM	CronogramaSafraVencimento
				WHERE   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
				ORDER BY dtCronogramaSafraVencimento
		
				OPEN CS_Vencimento
				FETCH NEXT FROM CS_Vencimento
				INTO	 @cdCronogramaSafraVencimentoSEQ
						,@dtCronogramaSafraVencimento
				
				SET @Fetch_Vencimento = @@FETCH_STATUS
				
				WHILE @Fetch_Vencimento = 0
				BEGIN
			
					-- Apura Quantidade de Vencimento
					SET @qtVencimento = @qtVencimento + 1
				
					-- Defini Cursor dos Itens
					DECLARE CS_Item CURSOR FOR
					SELECT	 cdCompromissoCompraItemSEQ
							,qtCompromissoCompraItem
							,qtAbertoCompromissoCompraItem
							,vrUnitarioMoedaCompromissoCompraItem
							,vrTotalMoedaCompromissoCompraItem
							,vrTotalMoedaAbertoCompromissoCompraItem
					FROM	 CompromissoCompraItem 
					WHERE	cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
					AND     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					AND		cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
					AND     cdProdutoSEQ = @cdProdutoSEQ
					
					OPEN CS_Item
					FETCH NEXT FROM CS_Item
					INTO	 @cdCompromissoCompraItemSEQ
							,@qtCompromissoCompraItem
							,@qtAbertoCompromissoCompraItem
							,@vrUnitarioMoedaCompromissoCompraItem
							,@vrTotalMoedaCompromissoCompraItem
							,@vrTotalMoedaAbertoCompromissoCompraItem
				
					SET @Fetch_Item = @@FETCH_STATUS
					
					WHILE @Fetch_Item = 0
					BEGIN
				
						-- Consolida valores Produto
						IF @qtVencimento = 1
						BEGIN
						
							SET @dtVencimento1CompromissoCompra = @dtCronogramaSafraVencimento
							SET @qtCompromissoCompraItem1 = @qtCompromissoCompraItem
							SET @vrUnitarioCompromissoCompraItem1 = @vrUnitarioMoedaCompromissoCompraItem
							SET @vrTotalMoedaParcela1CompromissoCompra = @vrTotalMoedaCompromissoCompraItem
							SET @qtAbertoCompromissoCompraItem1 = @qtAbertoCompromissoCompraItem
							SET @vrTotalAbertoMoedaParcela1CompromissoCompra  = @vrTotalMoedaAbertoCompromissoCompraItem
							SET @qtSomatoriaCompromissoCompraItem = @qtSomatoriaCompromissoCompraItem + @qtCompromissoCompraItem
							SET @vrSomatoriaMoedaCompromissoCompraItem = @vrSomatoriaMoedaCompromissoCompraItem + @vrTotalMoedaCompromissoCompraItem
							SET @qtSomatoriaConsumidaCompromissoCompraItem = @qtSomatoriaConsumidaCompromissoCompraItem + @qtAbertoCompromissoCompraItem
							SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = @vrSomatoriaMoedaConsumidaCompromissoCompraItem + @vrTotalMoedaAbertoCompromissoCompraItem

						END

						IF @qtVencimento = 2
						BEGIN
						
							SET @dtVencimento2CompromissoCompra = @dtCronogramaSafraVencimento
							SET @qtCompromissoCompraItem2 = @qtCompromissoCompraItem
							SET @vrUnitarioCompromissoCompraItem2 = @vrUnitarioMoedaCompromissoCompraItem
							SET @vrTotalMoedaParcela2CompromissoCompra = @vrTotalMoedaCompromissoCompraItem
							SET @qtAbertoCompromissoCompraItem2 = @qtAbertoCompromissoCompraItem
							SET @vrTotalAbertoMoedaParcela2CompromissoCompra  = @vrTotalMoedaAbertoCompromissoCompraItem
							SET @qtSomatoriaCompromissoCompraItem = @qtSomatoriaCompromissoCompraItem + @qtCompromissoCompraItem
							SET @vrSomatoriaMoedaCompromissoCompraItem = @vrSomatoriaMoedaCompromissoCompraItem + @vrTotalMoedaCompromissoCompraItem
							SET @qtSomatoriaConsumidaCompromissoCompraItem = @qtSomatoriaConsumidaCompromissoCompraItem + @qtAbertoCompromissoCompraItem
							SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = @vrSomatoriaMoedaConsumidaCompromissoCompraItem + @vrTotalMoedaAbertoCompromissoCompraItem

						END

						IF @qtVencimento = 3
						BEGIN
						
							SET @dtVencimento3CompromissoCompra = @dtCronogramaSafraVencimento
							SET @qtCompromissoCompraItem3 = @qtCompromissoCompraItem
							SET @vrUnitarioCompromissoCompraItem3 = @vrUnitarioMoedaCompromissoCompraItem
							SET @vrTotalMoedaParcela3CompromissoCompra = @vrTotalMoedaCompromissoCompraItem
							SET @qtAbertoCompromissoCompraItem3 = @qtAbertoCompromissoCompraItem
							SET @vrTotalAbertoMoedaParcela3CompromissoCompra  = @vrTotalMoedaAbertoCompromissoCompraItem
							SET @qtSomatoriaCompromissoCompraItem = @qtSomatoriaCompromissoCompraItem + @qtCompromissoCompraItem
							SET @vrSomatoriaMoedaCompromissoCompraItem = @vrSomatoriaMoedaCompromissoCompraItem + @vrTotalMoedaCompromissoCompraItem
							SET @qtSomatoriaConsumidaCompromissoCompraItem = @qtSomatoriaConsumidaCompromissoCompraItem + @qtAbertoCompromissoCompraItem
							SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = @vrSomatoriaMoedaConsumidaCompromissoCompraItem + @vrTotalMoedaAbertoCompromissoCompraItem

						END

						IF @qtVencimento = 4
						BEGIN
						
							SET @dtVencimento4CompromissoCompra = @dtCronogramaSafraVencimento
							SET @qtCompromissoCompraItem4 = @qtCompromissoCompraItem
							SET @vrUnitarioCompromissoCompraItem4 = @vrUnitarioMoedaCompromissoCompraItem
							SET @vrTotalMoedaParcela4CompromissoCompra = @vrTotalMoedaCompromissoCompraItem
							SET @qtAbertoCompromissoCompraItem4 = @qtAbertoCompromissoCompraItem
							SET @vrTotalAbertoMoedaParcela4CompromissoCompra  = @vrTotalMoedaAbertoCompromissoCompraItem
							SET @qtSomatoriaCompromissoCompraItem = @qtSomatoriaCompromissoCompraItem + @qtCompromissoCompraItem
							SET @vrSomatoriaMoedaCompromissoCompraItem = @vrSomatoriaMoedaCompromissoCompraItem + @vrTotalMoedaCompromissoCompraItem
							SET @qtSomatoriaConsumidaCompromissoCompraItem = @qtSomatoriaConsumidaCompromissoCompraItem + @qtAbertoCompromissoCompraItem
							SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = @vrSomatoriaMoedaConsumidaCompromissoCompraItem + @vrTotalMoedaAbertoCompromissoCompraItem

						END

						IF @qtVencimento = 5
						BEGIN
						
							SET @dtVencimento5CompromissoCompra = @dtCronogramaSafraVencimento
							SET @qtCompromissoCompraItem5 = @qtCompromissoCompraItem
							SET @vrUnitarioCompromissoCompraItem5 = @vrUnitarioMoedaCompromissoCompraItem
							SET @vrTotalMoedaParcela5CompromissoCompra = @vrTotalMoedaCompromissoCompraItem
							SET @qtAbertoCompromissoCompraItem5 = @qtAbertoCompromissoCompraItem
							SET @vrTotalAbertoMoedaParcela5CompromissoCompra  = @vrTotalMoedaAbertoCompromissoCompraItem
							SET @qtSomatoriaCompromissoCompraItem = @qtSomatoriaCompromissoCompraItem + @qtCompromissoCompraItem
							SET @vrSomatoriaMoedaCompromissoCompraItem = @vrSomatoriaMoedaCompromissoCompraItem + @vrTotalMoedaCompromissoCompraItem
							SET @qtSomatoriaConsumidaCompromissoCompraItem = @qtSomatoriaConsumidaCompromissoCompraItem + @qtAbertoCompromissoCompraItem
							SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = @vrSomatoriaMoedaConsumidaCompromissoCompraItem + @vrTotalMoedaAbertoCompromissoCompraItem

						END
						
						IF @qtVencimento = 6
						BEGIN
						
							SET @dtVencimento6CompromissoCompra = @dtCronogramaSafraVencimento
							SET @qtCompromissoCompraItem6 = @qtCompromissoCompraItem
							SET @vrUnitarioCompromissoCompraItem6 = @vrUnitarioMoedaCompromissoCompraItem
							SET @vrTotalMoedaParcela6CompromissoCompra = @vrTotalMoedaCompromissoCompraItem
							SET @qtAbertoCompromissoCompraItem6 = @qtAbertoCompromissoCompraItem
							SET @vrTotalAbertoMoedaParcela6CompromissoCompra  = @vrTotalMoedaAbertoCompromissoCompraItem
							SET @qtSomatoriaCompromissoCompraItem = @qtSomatoriaCompromissoCompraItem + @qtCompromissoCompraItem
							SET @vrSomatoriaMoedaCompromissoCompraItem = @vrSomatoriaMoedaCompromissoCompraItem + @vrTotalMoedaCompromissoCompraItem
							SET @qtSomatoriaConsumidaCompromissoCompraItem = @qtSomatoriaConsumidaCompromissoCompraItem + @qtAbertoCompromissoCompraItem
							SET @vrSomatoriaMoedaConsumidaCompromissoCompraItem = @vrSomatoriaMoedaConsumidaCompromissoCompraItem + @vrTotalMoedaAbertoCompromissoCompraItem

						END
						
						FETCH NEXT FROM CS_Item
						INTO	 @cdCompromissoCompraItemSEQ
								,@qtCompromissoCompraItem
								,@qtAbertoCompromissoCompraItem
								,@vrUnitarioMoedaCompromissoCompraItem
								,@vrTotalMoedaCompromissoCompraItem
								,@vrTotalMoedaAbertoCompromissoCompraItem
					
						SET @Fetch_Item = @@FETCH_STATUS	
						
					END		
					
					CLOSE CS_Item
					DEALLOCATE CS_item		
					
					FETCH NEXT FROM CS_Vencimento
					INTO	 @cdCronogramaSafraVencimentoSEQ
							,@dtCronogramaSafraVencimento
					
					SET @Fetch_Vencimento = @@FETCH_STATUS
					
				END
				
				CLOSE CS_Vencimento
				DEALLOCATE CS_Vencimento
				
				-- Insere Registro na Fato Compromisso
				INSERT INTO FATO_CompromissoCompra
					(	 cdCompromissoCompraSEQ
						,cdCompromissoCompraItemSEQ
						,cdProdutoSEQ
						,cdAgenteComercialCCABSEQ
						,cdAgenteComercialCooperativaSEQ
						,cdAgenteComercialRCSEQ
						,cdEstruturaEmpresaSEQ
						,cdMoedaSEQ
						,cdCampanhaPortalSEQ
						,dtEmissaoCompromissoCompra
						,dtVencimento1CompromissoCompra
						,dtVencimento2CompromissoCompra
						,dtVencimento3CompromissoCompra
						,dtVencimento4CompromissoCompra
						,dtVencimento5CompromissoCompra
						,dtVencimento6CompromissoCompra
						,qtCompromissoCompraItem1
						,qtCompromissoCompraItem2
						,qtCompromissoCompraItem3
						,qtCompromissoCompraItem4
						,qtCompromissoCompraItem5
						,qtCompromissoCompraItem6
						,vrUnitarioCompromissoCompraItem1
						,vrUnitarioCompromissoCompraItem2
						,vrUnitarioCompromissoCompraItem3
						,vrUnitarioCompromissoCompraItem4
						,vrUnitarioCompromissoCompraItem5
						,vrUnitarioCompromissoCompraItem6
						,vrTotalMoedaParcela1CompromissoCompra
						,vrTotalMoedaParcela2CompromissoCompra
						,vrTotalMoedaParcela3CompromissoCompra
						,vrTotalMoedaParcela4CompromissoCompra
						,vrTotalMoedaParcela5CompromissoCompra
						,vrTotalMoedaParcela6CompromissoCompra
						,qtAbertoCompromissoCompraItem1
						,qtAbertoCompromissoCompraItem2
						,qtAbertoCompromissoCompraItem3
						,qtAbertoCompromissoCompraItem4
						,qtAbertoCompromissoCompraItem5
						,qtAbertoCompromissoCompraItem6
						,vrTotalAbertoMoedaParcela1CompromissoCompra
						,vrTotalAbertoMoedaParcela2CompromissoCompra
						,vrTotalAbertoMoedaParcela3CompromissoCompra
						,vrTotalAbertoMoedaParcela4CompromissoCompra
						,vrTotalAbertoMoedaParcela5CompromissoCompra
						,vrTotalAbertoMoedaParcela6CompromissoCompra				
						,qtTotalCompromissoCompraItem
						,vrTotalMoedaCompromissoCompraItem
						,qtTotalConsumidaCompromissoCompraItem
						,vrTotalMoedaConsumidaCompromissoCompraItem
						,dtUltimaAlteracao
						,dsUsuarioUltimaAlteracao	)
				VALUES
					(
						 @cdCompromissoCompraSEQ
						,@qtProduto
						,@cdProdutoSEQ
						,-1 -- @cdAgenteComercialCCABCompromissoCompra (não é informado no compromisso de compra)
						,@cdAgenteComercialCooperativaCompromissoCompra
						,-1 -- @cdAgenteComercialRCCompromissoCompra (não é informado no compromisso de compra)
						,@cdPessoaOrigemFaturamento
						,@cdIndicadorMoedaCompromissoCompra
						,@cdCronogramaSafraSEQ
						,@dtEmissaoCompromissoCompra
						,@dtVencimento1CompromissoCompra
						,@dtVencimento2CompromissoCompra
						,@dtVencimento3CompromissoCompra
						,@dtVencimento4CompromissoCompra
						,@dtVencimento5CompromissoCompra
						,@dtVencimento6CompromissoCompra
						,@qtCompromissoCompraItem1
						,@qtCompromissoCompraItem2
						,@qtCompromissoCompraItem3
						,@qtCompromissoCompraItem4
						,@qtCompromissoCompraItem5
						,@qtCompromissoCompraItem6
						,@vrUnitarioCompromissoCompraItem1
						,@vrUnitarioCompromissoCompraItem2
						,@vrUnitarioCompromissoCompraItem3
						,@vrUnitarioCompromissoCompraItem4
						,@vrUnitarioCompromissoCompraItem5
						,@vrUnitarioCompromissoCompraItem6
						,@vrTotalMoedaParcela1CompromissoCompra
						,@vrTotalMoedaParcela2CompromissoCompra
						,@vrTotalMoedaParcela3CompromissoCompra
						,@vrTotalMoedaParcela4CompromissoCompra
						,@vrTotalMoedaParcela5CompromissoCompra
						,@vrTotalMoedaParcela6CompromissoCompra
						,@qtAbertoCompromissoCompraItem1
						,@qtAbertoCompromissoCompraItem2
						,@qtAbertoCompromissoCompraItem3
						,@qtAbertoCompromissoCompraItem4
						,@qtAbertoCompromissoCompraItem5
						,@qtAbertoCompromissoCompraItem6
						,@vrTotalAbertoMoedaParcela1CompromissoCompra
						,@vrTotalAbertoMoedaParcela2CompromissoCompra
						,@vrTotalAbertoMoedaParcela3CompromissoCompra
						,@vrTotalAbertoMoedaParcela4CompromissoCompra
						,@vrTotalAbertoMoedaParcela5CompromissoCompra
						,@vrTotalAbertoMoedaParcela6CompromissoCompra				
						,@qtSomatoriaCompromissoCompraItem
						,@vrSomatoriaMoedaCompromissoCompraItem
						,@qtSomatoriaConsumidaCompromissoCompraItem
						,@vrSomatoriaMoedaConsumidaCompromissoCompraItem
						,getdate()
						,'QlikView'	)		
					
				IF @@ERROR <> 0
				BEGIN
					PRINT 'Erro na Inclusao do Item'
					PRINT @cdCompromissoCompraSEQ
					CLOSE CS_Produto
					DEALLOCATE CS_Produto
					CLOSE CS_CompromissoCompra
					DEALLOCATE CS_CompromissoCompra
					RAISERROR ('Erro na Inclusao do Produto na Base do SFA',16,1)
					RETURN
				END
				
				FETCH NEXT FROM CS_Produto
				INTO	 @cdProdutoSEQ
				
				SET @Fetch_Produto = @@FETCH_STATUS
				
			END
			
			CLOSE CS_Produto
			DEALLOCATE CS_Produto
				
			FETCH NEXT FROM CS_CompromissoCompra
			INTO	 @cdCompromissoCompraSEQ
					,@cdPessoaOrigemFaturamento
					,@cdAgenteComercialCooperativaCompromissoCompra
					,@cdAgentecomercialCCABCompromissoCompra
					,@cdAgenteComercialRCCompromissoCompra
					,@cdCronogramaSafraSEQ
					,@dtEmissaoCompromissoCompra
					,@cdIndicadorMoedaCompromissoCompra
					,@vrTotalMoedaCompromissoCompra
					,@vrTotalAbertoMoedaCompromissoCompra
							
			SET @Fetch_CompromissoCompra = @@FETCH_STATUS
					
		END
		
		CLOSE CS_CompromissoCompra
		DEALLOCATE CS_CompromissoCompra
		
		RETURN
		
	END

