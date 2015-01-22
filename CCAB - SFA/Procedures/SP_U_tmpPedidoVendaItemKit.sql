set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpPedidoVendaItemKit.sql
**		Name: SP_U_tmpPedidoVendaItemKit
**		Desc: Altera um registro na tabela tmpPedidoVendaItem
**
**		Auth: Convergence
**		Date: 03/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpPedidoVendaItemKit]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemKit]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemKit]
	@tmpPedidoVendaSEQ			BIGINT 
   ,@cdUsuarioUltimaAlteracao	BIGINT
 
AS

	DECLARE	 @cdProdutoPai								bigint
			,@cdProdutoFilho							bigint
			,@qtComposicaoBaseProdutoKit					numeric(22,6)
			,@qtComposicaoProdutoKit						numeric(22,6)
			
			,@Fetch_Kit									int
			
			,@tmpPedidoVendaItemSEQ						bigint
			,@cdPedidoVendaItemSEQ						bigint
			,@cdPedidoVendaSEQ							bigint
			,@cdCronogramaSafraSEQ						bigint
			,@cdCronogramaSafraVencimentoSEQ			bigint
			,@qtPedidoVendaItem							numeric(22,4)
			,@vrUnitarioMoedaPedidoVendaItem			numeric(22,4)
			,@cdAgenteComercialCooperativaPedidoVenda	bigint
			,@cdPessoaOrigemFaturamento					bigint
			,@cdIndicadorMoedaPedidoVenda				int

			
			,@Fetch_ItemKit								int

			,@qtPedidoVendaItemKit						numeric(22,4)
			,@vrTotalMoedaPedidoVendaItem				numeric(22,4)


	DECLARE CS_Kit CURSOR FOR
	SELECT	 a.cdProdutoPai
			,a.cdProdutoFilho
			,a.qtComposicaoBaseProdutoKit
			,a.qtComposicaoProdutoKit
	FROM	ProdutoKit a
	WHERE	exists (	select 1 from tmpPedidoVendaItem b
						Where b.tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
						and   b.cdProdutoSEQ = a.cdProdutoPai)
	AND     a.cdIndicadorStatusProdutoKit = 1 -- Ativo
	
	OPEN CS_Kit
	FETCH NEXT FROM CS_Kit
	INTO	 @cdProdutoPai
			,@cdProdutoFilho
			,@qtComposicaoBaseProdutoKit
			,@qtComposicaoProdutoKit
	
	SET @Fetch_Kit = @@FETCH_STATUS
		
	WHILE @Fetch_Kit = 0
	BEGIN
	
		-- Define cursor com os produtos kit do pedido
		DECLARE	CS_ItemKit CURSOR FOR
		SELECT	 a.tmpPedidoVendaItemSEQ
				,a.cdPedidoVendaItemSEQ
				,a.cdPedidoVendaSEQ	
				,a.cdCronogramaSafraSEQ	
				,a.cdCronogramaSafraVencimentoSEQ
				,a.qtPedidoVendaItem			
				,a.vrUnitarioMoedaPedidoVendaItem
				,b.cdAgenteComercialCooperativaPedidoVenda
				,b.cdPessoaOrigemFaturamento
				,b.cdIndicadorMoedaPedidoVenda
		FROM	tmpPedidoVendaItem a
               ,tmpPedidoVenda b
		WHERE	a.tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and		a.cdProdutoSEQ = @cdProdutoPai
		and     a.tmpPedidoVendaSEQ = b.tmpPedidoVendaSEQ

		OPEN CS_ItemKit
		FETCH NEXT FROM CS_ItemKit
		INTO	 @tmpPedidoVendaItemSEQ				
				,@cdPedidoVendaItemSEQ				
				,@cdPedidoVendaSEQ					
				,@cdCronogramaSafraSEQ				
				,@cdCronogramaSafraVencimentoSEQ	
				,@qtPedidoVendaItem			
				,@vrUnitarioMoedaPedidoVendaItem		
				,@cdAgenteComercialCooperativaPedidoVenda
				,@cdPessoaOrigemFaturamento
				,@cdIndicadorMoedaPedidoVenda

		SET @Fetch_ItemKit = @@FETCH_STATUS
			
		WHILE @Fetch_ItemKit = 0
		BEGIN

			-- Verifica se o Produto Filho existe na TMP
			IF EXISTS (	select 1 from tmpPedidoVendaItem
						where cdProdutoSEQ = @cdProdutoFilho
						and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
						and   cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
						and   tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ)
			BEGIN
			
				-- Busca dados do Produto Filho		
				SET @tmpPedidoVendaItemSEQ = 0
				SELECT	 @tmpPedidoVendaItemSEQ = tmpPedidoVendaItemSEQ
						,@cdPedidoVendaItemSEQ = cdPedidoVendaItemSEQ
						,@cdPedidoVendaSEQ	 = cdPedidoVendaSEQ
						,@vrUnitarioMoedaPedidoVendaItem = vrUnitarioMoedaPedidoVendaItem
				FROM	tmpPedidoVendaItem
				WHERE	tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
				and     cdProdutoSEQ = @cdProdutoFilho
				and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
				and     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
				
				-- Verifica se o registro foi encontrado
				IF @tmpPedidoVendaItemSEQ = 0
				BEGIN
					CLOSE CS_ItemKit
					DEALLOCATE CS_ItemKit
					CLOSE CS_kit
					DEALLOCATE CS_Kit
					RAISERROR ('Erro na busca dos dados do produto filho',16,1)
					RETURN
				END

				-- Calcula Proporção do Produto Filho do Kit
				SET @qtPedidoVendaItemKit = (@qtPedidoVendaItem * @qtComposicaoProdutoKit) / @qtComposicaoBaseProdutoKit
				SET @vrTotalMoedaPedidoVendaItem = @qtPedidoVendaItemKit * @vrUnitarioMoedaPedidoVendaItem
			
				-- Efetua Update
				EXEC SP_U_tmpPedidoVendaItem
					 @tmpPedidoVendaItemSEQ				-- @tmpPedidoVendaItemSEQ	BIGINT
					,@tmpPedidoVendaSEQ					-- @tmpPedidoVendaSEQ BIGINT = NULL
					,@cdProdutoFilho					-- @cdProdutoSEQ	BIGINT = NULL
					,@cdCronogramaSafraSEQ				-- @cdCronogramaSafraSEQ	BIGINT = NULL
					,@cdCronogramaSafraVencimentoSEQ	-- @cdCronogramaSafraVencimentoSEQ	BIGINT = NULL
					,@qtPedidoVendaItemKit				-- @qtPedidoVendaItem	NUMERIC(22,4) = NULL
					,@vrTotalMoedaPedidoVendaItem		-- @vrTotalMoedaPedidoVendaItem	NUMERIC(22,4) = NULL
					,@vrTotalMoedaPedidoVendaItem		-- @vrTotalMoedaAbertoPedidoVendaItem	NUMERIC(22,4) = NULL
					,@cdUsuarioUltimaAlteracao			-- @cdUsuarioUltimaAlteracao	BIGINT = NULL

				-- Verifica se houve erro
				IF @@ERROR <> 0
				BEGIN
					CLOSE CS_ItemKit
					DEALLOCATE CS_ItemKit
					CLOSE CS_kit
					DEALLOCATE CS_Kit
					RAISERROR ('Erro no Update do Kit',16,1)
					RETURN
				END

			END
									
			FETCH NEXT FROM CS_ItemKit
			INTO	 @tmpPedidoVendaItemSEQ				
					,@cdPedidoVendaItemSEQ				
					,@cdPedidoVendaSEQ					
					,@cdCronogramaSafraSEQ				
					,@cdCronogramaSafraVencimentoSEQ	
					,@qtPedidoVendaItem			
					,@vrUnitarioMoedaPedidoVendaItem		
					,@cdAgenteComercialCooperativaPedidoVenda
					,@cdPessoaOrigemFaturamento
					,@cdIndicadorMoedaPedidoVenda

			SET @Fetch_ItemKit = @@FETCH_STATUS
			
		END
		
		CLOSE CS_ItemKit
		DEALLOCATE CS_ItemKit
		
		FETCH NEXT FROM CS_Kit
		INTO	 @cdProdutoPai
				,@cdProdutoFilho
				,@qtComposicaoBaseProdutoKit
				,@qtComposicaoProdutoKit
		
		SET @Fetch_Kit = @@FETCH_STATUS
		
	END
	
	CLOSE CS_Kit
	DEALLOCATE CS_KIT
		
	RETURN
		


		



 
