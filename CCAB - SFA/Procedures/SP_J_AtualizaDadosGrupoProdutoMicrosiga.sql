SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaDadosGrupoProdutoMicrosiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaDadosGrupoProdutoMicrosiga]
END
GO


CREATE PROCEDURE SP_J_AtualizaDadosGrupoProdutoMicrosiga
	
AS

	BEGIN

		--Variaveis MICROSIGA
		DECLARE @cdGrupoProdutoERP			varchar(30)
		DECLARE @dsGrupoProdutoERP			varchar(70)
		DECLARE @cdRecnoMicrosigaERP		bigint
		
		-- Variaveis de Comparação
		DECLARE @cdGrupoProdutoSEQ			bigint
		DECLARE @dsGrupoProduto   			varchar(70)
		DECLARE @cdRecnoMicrosiga			bigint
		
		-- Variaveis SFA
		DECLARE @Fetch_GrupoProduto	  	    int

		-- Defini Cursor para Atualização com base no Microsiga (Inclusao e Alteracao)
		DECLARE CS_GrupoProdutoAtualizacao CURSOR FOR
		SELECT	LTRIM(RTRIM(BM_GRUPO))						as cdGrupoProdutoERP,	-- Código do Produto
				LTRIM(RTRIM(BM_DESC))						as dsGrupoProduto,		-- Descrição do Produto 
				R_E_C_N_O_									AS cdRecnoMicrosiga		-- Recno no Microsiga 
		-- FROM	DADOSAP8..SBM010 
		FROM BDTSWK301.DADOSAP8.dbo.SBM010  

		WHERE	D_E_L_E_T_ = ''			-- Trazer os registros Ativos do sistema
		
		OPEN CS_GrupoProdutoAtualizacao
		FETCH NEXT FROM CS_GrupoProdutoAtualizacao
		INTO	@cdGrupoProdutoERP,			           
		        @dsGrupoProdutoERP,			           
		        @cdRecnoMicrosigaERP        
						
		SET @Fetch_GrupoProduto = @@FETCH_STATUS
		
		WHILE @Fetch_GrupoProduto = 0
		BEGIN
		
			-- Verifica se o registro existe no SFA
			IF EXISTS (SELECT 1 FROM GrupoProduto WHERE cdGrupoProdutoERP = @cdGrupoProdutoERP) 
			BEGIN

				-- Busca Valores do SFA para Comparação
				SELECT	@cdGrupoProdutoSEQ		= cdGrupoProdutoSEQ,
						@dsGrupoProduto   		= dsGrupoProduto,
						@cdRecnoMicrosiga		= cdRecnoMicrosiga
				FROM	GrupoProduto
				WHERE	cdGrupoProdutoERP = @cdGrupoProdutoERP
			
				-- Acertar conteúdo NULL (verificar)
				
				-- Verifica se os Valores estao Diferentes do Microsiga
				IF	rtrim(ltrim(isnull(@dsGrupoProduto,'')))	<> rtrim(ltrim(isnull(@dsGrupoProdutoERP,''))) or
					isnull(@cdRecnoMicrosiga,0)					<> isnull(@cdRecnoMicrosigaERP,0)
				BEGIN
		
					-- Atualiza Registro no SFA		
					UPDATE GrupoProduto
					SET	dsGrupoProduto			= @dsGrupoProdutoERP,
						cdRecnoMicrosiga		= @cdRecnoMicrosigaERP,
						dtUltimaAlteracao		= getdate(),
						cdUsuarioUltimaAlteracao = 9999 -- codigo microsiga
					WHERE cdGrupoProdutoSEQ			= @cdGrupoProdutoSEQ
				
					-- Verifica Erro no Update
					IF @@ERROR <> 0  OR @@ROWCOUNT = 0
					BEGIN
						PRINT 'Erro no Update do GrupoProduto'
						PRINT @cdGrupoProdutoERP + ' - ' + @dsGrupoProdutoERP
						CLOSE CS_GrupoProdutoAtualizacao
						DEALLOCATE CS_GrupoProdutoAtualizacao
						RAISERROR ('Erro no Update do GrupoProduto',16,1)
						RETURN
					END

					PRINT 'UPDATE - ' + @cdGrupoProdutoERP + ' - ' + @dsGrupoProdutoERP
						
				END
				
			END
			ELSE
			BEGIN --//Inclusao
			
				-- Verifica se o Codigo do Grupo de Produto foi informado
				BEGIN
					IF isnull(@cdGrupoProdutoERP,'') = '' 
					BEGIN
						PRINT 'Codigo do Grupo de Produto do ERP não Informado'
						PRINT @dsGrupoProdutoERP
						CLOSE CS_GrupoProdutoAtualizacao
						DEALLOCATE CS_GrupoProdutoAtualizacao
						RAISERROR ('Código do Grupo de Produto do ERP não Informado',16,1)
						RETURN
					END
				END
		
				-- Verifica se a Descricao do Grupo de Produto foi informada
				BEGIN
					IF isnull(@dsGrupoProdutoERP,'') = ''
					BEGIN
						PRINT 'Descrição do Grupo de Produto não Informada'
						PRINT @cdGrupoProdutoERP
						CLOSE CS_GrupoProdutoAtualizacao
						DEALLOCATE CS_GrupoProdutoAtualizacao
						RAISERROR ('Descrição do Grupo de Produto não Informada',16,1)
						RETURN			
					END
				END
		
				-- Efetua a Inclusao
				INSERT INTO GrupoProduto (	
										cdGrupoProdutoERP,
										dsGrupoProduto,
										cdIndicadorStatusGrupoProduto,
										cdRecnoMicrosiga,
										dtUltimaAlteracao,
										cdUsuarioUltimaAlteracao
									)
					VALUES (			@cdGrupoProdutoERP,
										@dsGrupoProdutoERP,
										1,		-- Situação = 1-Ativo
										@cdRecnoMicrosigaERP,
										getdate(),
										9999	-- sera assumido 9999 para o Microsiga
							)
						
				IF @@ERROR <> 0
				BEGIN
					PRINT 'Erro na Inclusao do Grupo de Produto na Base do SFA'
					PRINT @cdGrupoProdutoERP
					CLOSE CS_GrupoProdutoAtualizacao
					DEALLOCATE CS_GrupoProdutoAtualizacao
					RAISERROR ('Erro na Inclusão do Grupo de Produto na Base do SFA',16,1)
					RETURN
				END

				PRINT 'INSERT - ' + @cdGrupoProdutoERP + ' - ' + @dsGrupoProdutoERP
				
			END
			
			FETCH NEXT FROM CS_GrupoProdutoAtualizacao
			INTO	@cdGrupoProdutoERP,			           
				    @dsGrupoProdutoERP,			           
			        @cdRecnoMicrosigaERP        
					
			SET @Fetch_GrupoProduto = @@FETCH_STATUS
			
		END
		
		CLOSE CS_GrupoProdutoAtualizacao
		DEALLOCATE CS_GrupoProdutoAtualizacao
		
		--- Verifica Exclusao do Grupo de Produto 
		--- (mudanca de status para inativo caso o registro tenha sido excluido no Microsiga)
		
		-- Defini Cursor para Verificar registros Excluidos no Microsiga
		DECLARE CS_GrupoProdutoExclusao CURSOR FOR
		SELECT	cdGrupoProdutoSEQ
		FROM	GrupoProduto a
		WHERE	NOT EXISTS (	SELECT 1 FROM BDTSWK301.DADOSAP8.dbo.SBM010 b
		-- WHERE	NOT EXISTS (	SELECT 1 FROM DADOSAP8..SBM010 b
								WHERE b.BM_GRUPO = a.cdGrupoProdutoERP collate SQL_Latin1_General_CP1_CI_AS
								AND    D_E_L_E_T_ = '')
		AND		cdIndicadorStatusGrupoProduto = 1 -- somente registros ativos
		
		OPEN CS_GrupoProdutoExclusao
		FETCH NEXT FROM CS_GrupoProdutoExclusao
		INTO	@cdGrupoProdutoSEQ			           
						
		SET @Fetch_GrupoProduto = @@FETCH_STATUS
		
		WHILE @Fetch_GrupoProduto = 0
		BEGIN
	
			-- Atualiza Registro no SFA		
			UPDATE GrupoProduto
			SET	cdIndicadorStatusGrupoProduto = 2,
				dtUltimaAlteracao = getdate(),
				cdUsuarioUltimaAlteracao = 9999 -- codigo Microsiga
			WHERE cdGrupoProdutoSEQ	= @cdGrupoProdutoSEQ
				
			-- Verifica Erro no Update
			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				PRINT 'Erro no Update do GrupoProduto'
				PRINT @cdGrupoProdutoERP + ' - ' + @dsGrupoProdutoERP
				CLOSE CS_GrupoProdutoExclusao
				DEALLOCATE CS_GrupoProdutoExclusao
				RAISERROR ('Erro no Update do GrupoProduto - Exclusão',16,1)
				RETURN
			END

			PRINT 'EXCLUSAO - ' + str(@cdGrupoProdutoSEQ) 

			FETCH NEXT FROM CS_GrupoProdutoExclusao
			INTO	@cdGrupoProdutoSEQ			           
						
			SET @Fetch_GrupoProduto = @@FETCH_STATUS
						
		END	
		
		CLOSE CS_GrupoProdutoExclusao
		DEALLOCATE CS_GrupoProdutoExclusao
		
		RETURN
		
	END
