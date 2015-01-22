SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaDadosProdutoKitMicrosiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaDadosProdutoKitMicrosiga]
END
GO


CREATE PROCEDURE SP_J_AtualizaDadosProdutoKitMicrosiga
	
AS

	BEGIN

		--Variaveis MICROSIGA
		declare
			 @cdProdutoPaiERP				varchar(15)
			,@cdProdutoFilhoERP				varchar(15)
			,@qtComposicaoBaseProdutoKitERP	numeric(22,6)
			,@qtComposicaoProdutoKitERP		numeric(22,6)
			,@cdRecnoMicrosigaERP			bigint

			,@cdProdutoSEQPaiERP			bigint
			,@cdProdutoSEQFilhoERP			bigint


		select
			 @cdProdutoSEQPaiERP			= 0
			,@cdProdutoSEQFilhoERP			= 0

		-- Variaveis de Comparação
		declare
			 @cdProdutoKitSEQ				bigint
			,@cdProdutoPai					bigint
			,@cdProdutoFilho					bigint
			,@qtComposicaoBaseProdutoKit	numeric(22,6)
			,@qtComposicaoProdutoKit		numeric(22,6)
			,@cdRecnoMicrosiga				bigint

		
		-- Variaveis SFA
		DECLARE @Fetch_Produto				int


		-- Defini Cursor para Atualização com base no Microsiga (Inclusao e Alteracao)
		DECLARE CS_ProdutoAtualizacao CURSOR FOR

		SELECT  
			SBG.BG_PRODUTO				as	cdProdutoPaiERP,
			SBH.BH_CODCOMP				as	cdProdutoFilhoERP,
			isnull(SBG.BG_XQUANT, 0)	as	qtComposicaoBaseProdutoKit,
			isnull(SBH.BH_QUANT, 0)		as	qtComposicaoProdutoKit,
			SBH.R_E_C_N_O_				as  cdRecnoMicrosiga
		FROM 
			DADOSAP8.dbo.SBG010 SBG,
			DADOSAP8.dbo.SBH010 SBH
		WHERE 
			  SBG.D_E_L_E_T_='' 
		  AND SBH.D_E_L_E_T_=''
		  AND SBG.BG_PRODUTO = SBH.BH_PRODUTO
		  AND SBG.BG_FILIAL  = SBH.BH_FILIAL



		
		OPEN CS_ProdutoAtualizacao
		FETCH NEXT FROM CS_ProdutoAtualizacao
		INTO	
			 @cdProdutoPaiERP				
			,@cdProdutoFilhoERP				
			,@qtComposicaoBaseProdutoKitERP	
			,@qtComposicaoProdutoKitERP		
			,@cdRecnoMicrosigaERP			
						
		SET @Fetch_Produto = @@FETCH_STATUS
		
		WHILE @Fetch_Produto = 0
		BEGIN

			-- Obtenho os IDs afim de compara-los à base de dados SFA (Pai)
			select
				@cdProdutoSEQPaiERP	= isnull(cdProdutoSEQ, 0)
			from
				dbo.Produto
			where
				cdProdutoERP = @cdProdutoPaiERP

			-- Obtenho os IDs afim de compara-los à base de dados SFA (Filho)
			select
				@cdProdutoSEQFilhoERP	= isnull(cdProdutoSEQ, 0)
			from
				dbo.Produto
			where
				cdProdutoERP = @cdProdutoFilhoERP


			-- Verifica se o Produto Pai foi informado/encontrado
			IF @cdProdutoSEQPaiERP = 0
			BEGIN
				PRINT 'Produto Pai não Informado/Encontrado'
				PRINT @cdProdutoSEQPaiERP
				CLOSE CS_ProdutoAtualizacao
				DEALLOCATE CS_ProdutoAtualizacao
				RAISERROR ('Produto Pai não Informado/Encontrado',16,1)
				RETURN		
			END

			-- Verifica se o Produto Filho foi informado/encontrado
			IF @cdProdutoSEQFilhoERP = 0
			BEGIN
				PRINT 'Produto Filho não Informado/Encontrado'
				PRINT @cdProdutoSEQFilhoERP
				CLOSE CS_ProdutoAtualizacao
				DEALLOCATE CS_ProdutoAtualizacao
				RAISERROR ('Produto Filho não Informado/Encontrado',16,1)
				RETURN		
			END


			-- Verifica se a Quantidade Composição Base é maior do que Zero
			IF @qtComposicaoBaseProdutoKitERP = 0
			BEGIN
				PRINT 'Quantidade Composição Base deve ser maior do que Zero'
				PRINT @qtComposicaoBaseProdutoKitERP
				CLOSE CS_ProdutoAtualizacao
				DEALLOCATE CS_ProdutoAtualizacao
				RAISERROR ('Quantidade Composição Base deve ser maior do que Zero',16,1)
				RETURN		
			END

			-- Verifica se a Quantidade Composição é maior do que Zero
			IF @qtComposicaoProdutoKitERP = 0
			BEGIN
				PRINT 'Quantidade Composição deve ser maior do que Zero'
				PRINT @qtComposicaoProdutoKitERP
				CLOSE CS_ProdutoAtualizacao
				DEALLOCATE CS_ProdutoAtualizacao
				RAISERROR ('Quantidade Composição deve ser maior do que Zero',16,1)
				RETURN		
			END
			

			
			-- Verifica se o registro existe no SFA
			IF EXISTS (SELECT 1 FROM dbo.ProdutoKit WHERE cdProdutoPai = @cdProdutoSEQPaiERP and cdProdutoFilho = @cdProdutoSEQFilhoERP) 
			BEGIN

				-- Busca Valores do SFA para Comparação
				SELECT	
					 @cdProdutoKitSEQ				= cdProdutoKitSEQ
					,@cdProdutoPai					= cdProdutoPai
					,@cdProdutoFilho				= cdProdutoFilho
					,@qtComposicaoBaseProdutoKit	= qtComposicaoBaseProdutoKit
					,@qtComposicaoProdutoKit		= qtComposicaoProdutoKit
					,@cdRecnoMicrosiga				= cdRecnoMicrosiga
				FROM	
					dbo.ProdutoKit
				WHERE	
					cdProdutoPai = @cdProdutoSEQPaiERP
				AND	cdProdutoFilho = @cdProdutoSEQFilhoERP

			
			
				-- Verifica se os Valores estao Diferentes do Microsiga
				IF	isnull(@qtComposicaoBaseProdutoKit,0)	<> isnull(@qtComposicaoBaseProdutoKitERP,0) or
					isnull(@qtComposicaoProdutoKit,0)		<> isnull(@qtComposicaoProdutoKitERP,0) or
					isnull(@cdRecnoMicrosiga,0)				<> isnull(@cdRecnoMicrosigaERP,0) 
				BEGIN
		
					-- Atualiza Registro no SFA		
					UPDATE 
						dbo.ProdutoKit
					SET	
						 qtComposicaoBaseProdutoKit		= @qtComposicaoBaseProdutoKitERP
						,qtComposicaoProdutoKit			= @qtComposicaoProdutoKitERP
						,cdRecnoMicrosiga				= @cdRecnoMicrosigaERP
						,dtUltimaAlteracao				= getdate()
						,cdUsuarioUltimaAlteracao		= 9999 -- sera assumido 9999 para o Microsiga
					WHERE 
						cdProdutoPai	= @cdProdutoSEQPaiERP
					and	cdProdutoFilho	= @cdProdutoSEQFilhoERP
				
					-- Verifica Erro no Update
					IF @@ERROR <> 0  OR @@ROWCOUNT = 0
					BEGIN
						PRINT 'Erro no Update do ProdutoKit'
						PRINT convert(varchar, @cdProdutoSEQPaiERP) + ' - ' + convert(varchar, @cdProdutoSEQFilhoERP)
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Erro no Update do ProdutoKit',16,1)
						RETURN
					END

					PRINT 'UPDATE - ' + convert(varchar, @cdProdutoSEQPaiERP) + ' - ' + convert(varchar, @cdProdutoSEQFilhoERP)
						
				END
				
			END
			ELSE
			BEGIN --//Inclusao
			
				-- Efetua a Inclusao
				insert into dbo.ProdutoKit
					(cdProdutoPai
					,cdProdutoFilho
					,qtComposicaoBaseProdutoKit
					,qtComposicaoProdutoKit
					,cdIndicadorStatusProdutoKit
					,cdRecnoMicrosiga
					,dtUltimaAlteracao
					,cdUsuarioUltimaAlteracao)
				values
					(@cdProdutoSEQPaiERP
					,@cdProdutoSEQFilhoERP
					,@qtComposicaoBaseProdutoKitERP
					,@qtComposicaoProdutoKitERP
					,1	--Ativo
					,@cdRecnoMicrosigaERP
					,getdate()
					,9999)	-- sera assumido 9999 para o Microsiga
				
						
				IF @@ERROR <> 0
				BEGIN
					PRINT 'Erro na Inclusao do ProdutoKit'
					PRINT convert(varchar, @cdProdutoSEQPaiERP) + ' - ' + convert(varchar, @cdProdutoSEQFilhoERP)
					CLOSE CS_ProdutoAtualizacao
					DEALLOCATE CS_ProdutoAtualizacao
					RAISERROR ('Erro na Inclusao do ProdutoKit',16,1)
					RETURN
				END

				PRINT 'INSERT - ' + convert(varchar, @cdProdutoSEQPaiERP) + ' - ' + convert(varchar, @cdProdutoSEQFilhoERP)
				
			END
			
			FETCH NEXT FROM CS_ProdutoAtualizacao
			INTO	
				 @cdProdutoPaiERP				
				,@cdProdutoFilhoERP				
				,@qtComposicaoBaseProdutoKitERP	
				,@qtComposicaoProdutoKitERP		
				,@cdRecnoMicrosigaERP	    
					
			SET @Fetch_Produto = @@FETCH_STATUS
			
		END
		
		CLOSE CS_ProdutoAtualizacao
		DEALLOCATE CS_ProdutoAtualizacao
		
		-- Verifica Exclusao do ProdutoKit
		-- (mudanca de status de liberado para NÃO caso o registro tenha sido excluido no Microsiga)

		-- Defino Cursor para Verificar registros Excluidos no Microsiga
		DECLARE CS_ProdutoExclusao CURSOR FOR
		SELECT	cdProdutoKitSEQ
		FROM	dbo.ProdutoKit a
		WHERE	NOT EXISTS (	SELECT
									1
								FROM
									DADOSAP8.dbo.SBG010 SBG,
									DADOSAP8.dbo.SBH010 SBH
								WHERE
									SBG.BG_PRODUTO = (select cdProdutoERP from dbo.Produto where cdProdutoSEQ = a.cdProdutoPai) collate SQL_Latin1_General_CP1_CI_AS
								AND	SBH.BH_CODCOMP = (select cdProdutoERP from dbo.Produto where cdProdutoSEQ = a.cdProdutoFilho) collate SQL_Latin1_General_CP1_CI_AS
								AND	SBG.D_E_L_E_T_='' 
								AND SBH.D_E_L_E_T_=''
								AND SBG.BG_PRODUTO = SBH.BH_PRODUTO
								AND SBG.BG_FILIAL  = SBH.BH_FILIAL)

		AND	cdIndicadorStatusProdutoKit	 = 1 -- somente registros ativos

		OPEN CS_ProdutoExclusao
		FETCH NEXT FROM CS_ProdutoExclusao
		INTO	@cdProdutoKitSEQ			           
						
		SET @Fetch_Produto = @@FETCH_STATUS
		
		WHILE @Fetch_Produto = 0
		BEGIN

	
			-- Atualiza Registro no SFA		
			UPDATE dbo.ProdutoKit
			SET	cdIndicadorStatusProdutoKit = 2
			   ,dtUltimaAlteracao = getdate()
			   ,cdUsuarioUltimaAlteracao = 9999 -- codigo microsiga
			WHERE cdProdutoKitSEQ	= @cdProdutoKitSEQ
				
			-- Verifica Erro no Update
			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				PRINT 'Erro na Exclusão do ProdutoKi'
				PRINT @cdProdutoKitSEQ 
				CLOSE CS_ProdutoExclusao
				DEALLOCATE CS_ProdutoExclusao
				RAISERROR ('Erro na Exclusão do ProdutoKit',16,1)
				RETURN
			END

			PRINT 'EXCLUSAO - ' + str(@cdProdutoKitSEQ) 

			FETCH NEXT FROM CS_ProdutoExclusao
			INTO	@cdProdutoKitSEQ			           
						
			SET @Fetch_Produto = @@FETCH_STATUS
						
		END	
		
		CLOSE CS_ProdutoExclusao
		DEALLOCATE CS_ProdutoExclusao		
		
		RETURN
		
	END

