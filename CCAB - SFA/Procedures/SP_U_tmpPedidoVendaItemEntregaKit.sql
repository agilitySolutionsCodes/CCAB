set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpPedidoVendaItemEntregaKit.sql
**		Name: SP_U_tmpPedidoVendaItemEntregaKit
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpPedidoVendaItemEntregaKit]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemEntregaKit]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemEntregaKit]
	@tmpPedidoVendaSEQ			BIGINT 
   ,@cdUsuarioUltimaAlteracao	BIGINT
 
AS

	DECLARE	 @cdProdutoPai								bigint
			,@cdProdutoFilho							bigint
			,@qtComposicaoBaseProdutoKit					numeric(22,6)
			,@qtComposicaoProdutoKit						numeric(22,6)
			
			,@Fetch_Kit									int
			
			,@tmpPedidoVendaItemEntregaSEQ				bigint
			,@cdPedidoVendaItemEntregaSEQ				bigint
			,@cdPedidoVendaSEQ							bigint
			,@cdCronogramaSafraSEQ						bigint
			,@dtAnoMesPedidoVendaItemEntrega			datetime
			,@qtPedidoVendaItemEntrega  				numeric(22,4)
			,@cdAgenteComercialCooperativaPedidoVenda	bigint
			,@cdPessoaOrigemFaturamento					bigint
			,@cdIndicadorMoedaPedidoVenda				int
			
			,@Fetch_ItemKit								int

			,@qtPedidoVendaItemEntregaKit				numeric(22,4)

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
		SELECT	 a.tmpPedidoVendaItemEntregaSEQ
				,a.cdPedidoVendaItemEntregaSEQ
				,a.cdPedidoVendaSEQ	
				,a.cdCronogramaSafraSEQ	
				,a.dtAnoMesPedidoVendaItemEntrega
				,a.qtPedidoVendaItemEntrega			
				,b.cdAgenteComercialCooperativaPedidoVenda
				,b.cdPessoaOrigemFaturamento
				,b.cdIndicadorMoedaPedidoVenda
		FROM	tmpPedidoVendaItemEntrega a
               ,tmpPedidoVenda b
		WHERE	a.tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and		a.cdProdutoSEQ = @cdProdutoPai
		and     a.tmpPedidoVendaSEQ = b.tmpPedidoVendaSEQ

		OPEN CS_ItemKit
		FETCH NEXT FROM CS_ItemKit
		INTO	 @tmpPedidoVendaItemEntregaSEQ				
				,@cdPedidoVendaItemEntregaSEQ				
				,@cdPedidoVendaSEQ					
				,@cdCronogramaSafraSEQ				
				,@dtAnoMesPedidoVendaItemEntrega	
				,@qtPedidoVendaItemEntrega			
				,@cdAgenteComercialCooperativaPedidoVenda
				,@cdPessoaOrigemFaturamento
				,@cdIndicadorMoedaPedidoVenda

		SET @Fetch_ItemKit = @@FETCH_STATUS
			
		WHILE @Fetch_ItemKit = 0
		BEGIN

			-- Verifica se o Produto Filho existe na TMP
			IF EXISTS (	select 1 from tmpPedidoVendaItemEntrega
						where cdProdutoSEQ = @cdProdutoFilho
						and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
						and   dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega
						and   tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ)
			BEGIN
			
				-- Busca dados do Produto Filho		
				SET @tmpPedidoVendaItemEntregaSEQ = 0
				SELECT	 @tmpPedidoVendaItemEntregaSEQ = tmpPedidoVendaItemEntregaSEQ
						,@cdPedidoVendaItemEntregaSEQ = cdPedidoVendaItemEntregaSEQ
						,@cdPedidoVendaSEQ	 = cdPedidoVendaSEQ
				FROM	tmpPedidoVendaItemEntrega
				WHERE	tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
				and     cdProdutoSEQ = @cdProdutoFilho
				and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
				and     dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega
				
				-- Verifica se o registro foi encontrado
				IF @tmpPedidoVendaItemEntregaSEQ = 0
				BEGIN
					CLOSE CS_ItemKit
					DEALLOCATE CS_ItemKit
					CLOSE CS_kit
					DEALLOCATE CS_Kit
					RAISERROR ('Erro na busca dos dados do produto filho-Entrega',16,1)
					RETURN
				END

				-- Calcula Proporção do Produto Filho do Kit
				SET @qtPedidoVendaItemEntregaKit = (@qtPedidoVendaItemEntrega * @qtComposicaoProdutoKit) / @qtComposicaoBaseProdutoKit
			
				-- Efetua Update
				EXEC SP_U_tmpPedidoVendaItemEntrega
					 @tmpPedidoVendaItemEntregaSEQ		-- @tmpPedidoVendaItemEntregaSEQ	BIGINT
					,@tmpPedidoVendaSEQ					-- @tmpPedidoVendaSEQ BIGINT = NULL
				    ,@cdPedidoVendaSEQ					-- @cdPedidoVendaSEQ BIGINT = NULL
					,@cdProdutoFilho					-- @cdProdutoSEQ	BIGINT = NULL
					,@cdCronogramaSafraSEQ				-- @cdCronogramaSafraSEQ	BIGINT = NULL
					,@dtAnoMesPedidoVendaItemEntrega	-- @dtAnoMesPedidoVendaItemEntrega	BIGINT = NULL
					,@qtPedidoVendaItemEntregaKit		-- @qtPedidoVendaItemEntrega	NUMERIC(22,4) = NULL
					,@cdUsuarioUltimaAlteracao			-- @cdUsuarioUltimaAlteracao	BIGINT = NULL

				-- Verifica se houve erro
				IF @@ERROR <> 0
				BEGIN
					CLOSE CS_ItemKit
					DEALLOCATE CS_ItemKit
					CLOSE CS_kit
					DEALLOCATE CS_Kit
					RAISERROR ('Erro no Update do Kit-Entrega' ,16,1)
					RETURN
				END

			END
									
			FETCH NEXT FROM CS_ItemKit
			INTO	 @tmpPedidoVendaItemEntregaSEQ				
					,@cdPedidoVendaItemEntregaSEQ				
					,@cdPedidoVendaSEQ					
					,@cdCronogramaSafraSEQ				
					,@dtAnoMesPedidoVendaItemEntrega	
					,@qtPedidoVendaItemEntrega			
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
		


		



 
