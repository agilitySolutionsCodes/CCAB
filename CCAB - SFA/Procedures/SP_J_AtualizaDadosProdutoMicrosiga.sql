SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaDadosProdutoMicrosiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaDadosProdutoMicrosiga]
END
GO


CREATE PROCEDURE SP_J_AtualizaDadosProdutoMicrosiga
	
AS

	BEGIN

		--Variaveis MICROSIGA
		DECLARE @cdProdutoERP				varchar(30)
		DECLARE @dsProdutoERP				varchar(70)
		DECLARE @dsUnidadeProdutoERP		varchar(30)
		DECLARE @qtEmbalagemProdutoERP		numeric(22,6)
		DECLARE @qtPesoLiquidoProdutoERP	numeric(22,6)
		DECLARE @qtPesoBrutoProdutoERP		numeric(22,6)
		DECLARE @wkProdutoERP				varchar(255)
		DECLARE @cdRecnoMicrosigaERP		bigint
		DECLARE @cdGrupoProdutoERP			varchar(30)
		DECLARE @cdTipoProdutoERP           int
		
		-- Variaveis de Comparação
		DECLARE @cdProdutoSEQ				bigint
		DECLARE @dsProduto   				varchar(70)
		DECLARE @dsUnidadeProduto   		varchar(30)
		DECLARE @qtEmbalagemProduto   		numeric(22,6)
		DECLARE @qtPesoLiquidoProduto   	numeric(22,6)
		DECLARE @qtPesoBrutoProduto			numeric(22,6)
		DECLARE @wkProduto   				varchar(255)
		DECLARE @cdRecnoMicrosiga			bigint
		DECLARE @cdGrupoProdutoSEQERP		varchar(30)
		DECLARE @cdTipoProduto				int
		
		-- Variaveis SFA
		DECLARE @Fetch_Produto				int
		DECLARE @cdGrupoProdutoSEQ			bigint

		-- Defini Cursor para Atualização com base no Microsiga (Inclusao e Alteracao)
		DECLARE CS_ProdutoAtualizacao CURSOR FOR
		SELECT	LTRIM(RTRIM(A.B1_COD))						as cdProdutoERP,		-- Código do Produto
				LTRIM(RTRIM(A.B1_DESC))						as dsProduto,			-- Descrição do Produto 
				LTRIM(RTRIM(A.B1_UM))						as dsUnidadeProduto,	-- Unidade de Medida do Produto 
				(A.B1_QE * B5_QE1)							as qtEmbalagemProduto,	-- Quantidade por embalagem 
				A.B1_PESO									as QtPesoLiquidoProduto,-- Peso Liquido 
				A.B1_PESBRU									as QtdPesoBruto,		-- Peso Bruto 
				' '											as wkProduto,			-- Observacao do Produto
				A.R_E_C_N_O_								AS cdRecnoMicrosiga,	-- Recno no Microsiga 
				LTRIM(RTRIM(A.B1_GRUPO))					AS cdGrupoProdutoERP,	-- Codigo do Grupo de Produto
				CASE A.B1_TIPO
					WHEN 'PA' THEN  1
					WHEN 'AT' THEN  2
				END                                         AS cdTipoProduto        -- Tipo de Produto
		FROM	DADOSAP8..SB1010 A,
		        DADOSAP8..SB5010 B 
		-- FROM	BDTSWK301.DADOSAP8.dbo.SB1010 A,
		--		BDTSWK301.DADOSAP8.dbo.SB5010 B
		WHERE	A.D_E_L_E_T_ = ''			-- Trazer os registros Ativos do sistema
		AND		A.B1_TIPO in ('PA','AT')	-- Trazer todos os Produtos do Tipo "Acabado"
		AND     A.B1_FILIAL = B.B5_FILIAL
		AND     A.B1_COD = B.B5_COD
		
		OPEN CS_ProdutoAtualizacao
		FETCH NEXT FROM CS_ProdutoAtualizacao
		INTO	@cdProdutoERP,			           
		        @dsProdutoERP,			           
		        @dsUnidadeProdutoERP,	           
		        @qtEmbalagemProdutoERP,	             
		        @qtPesoLiquidoProdutoERP,             
		        @qtPesoBrutoProdutoERP,			             
		        @wkProdutoERP,			            
		        @cdRecnoMicrosigaERP,
		        @cdGrupoProdutoERP,
		        @cdTipoProdutoERP
						
		SET @Fetch_Produto = @@FETCH_STATUS
		
		WHILE @Fetch_Produto = 0
		BEGIN
		
			-- Verifica se o registro existe no SFA
			IF EXISTS (SELECT 1 FROM Produto WHERE cdProdutoERP = @cdProdutoERP) 
			BEGIN

				-- Busca Valores do SFA para Comparação
				SELECT	@cdProdutoSEQ			= cdProdutoSEQ,
						@dsProduto   			= dsProduto,
						@dsUnidadeProduto   	= dsUnidadeProduto,
						@qtEmbalagemProduto   	= qtEmbalagemProduto,
						@qtPesoLiquidoProduto   = qtPesoLiquidoProduto,
						@qtPesoBrutoProduto		= qtPesoBrutoProduto,
						@wkProduto   			= wkProduto,
						@cdRecnoMicrosiga		= cdRecnoMicrosiga,
						@cdGrupoProdutoSEQ		= cdGrupoProdutoSEQ,
						@cdTipoProduto          = isnull(cdTipoProduto,0)
				FROM	Produto
				WHERE	cdProdutoERP = @cdProdutoERP
			
				-- Busca o codigo ERP do Grupo de Produto
				SET @cdGrupoProdutoSEQERP = ''
				SELECT	@cdGrupoProdutoSEQERP = ISNULL(cdGrupoProdutoERP,'')
				FROM	GrupoProduto
				WHERE	cdGrupoProdutoSEQ = ISNULL(@cdGrupoProdutoSEQ,0)
			
				-- Verifica se os Valores estao Diferentes do Microsiga
				IF	rtrim(ltrim(isnull(@dsProduto,'')))				<> rtrim(ltrim(isnull(@dsProdutoERP,''))) or
					rtrim(ltrim(isnull(@dsUnidadeProduto,'')))		<> rtrim(ltrim(isnull(@dsUnidadeProdutoERP,''))) or
					isnull(@QtEmbalagemProduto,0)					<> isnull(@QtEmbalagemProdutoERP,0) or
					isnull(@QtPesoLiquidoProduto,0)					<> isnull(@QtPesoLiquidoProdutoERP,0) or
					isnull(@QtPesoBrutoProduto,0)					<> isnull(@QtPesoBrutoProdutoERP,0) or
					rtrim(ltrim(isnull(@wkProduto,'')))				<> rtrim(ltrim(isnull(@wkProdutoERP,''))) or
					isnull(@cdRecnoMicrosiga,0)						<> isnull(@cdRecnoMicrosigaERP,0) or
					rtrim(ltrim(isnull(@cdGrupoProdutoSEQERP,'')))	<> rtrim(ltrim(isnull(@cdGrupoProdutoERP,''))) or
					isnull(@cdTipoProdutoERP,0)                     <> isnull(@cdTipoProduto,0)
				BEGIN
				
					-- Verifica se a Descricao do Produto foi informada
					BEGIN
						IF isnull(@dsProdutoERP,'') = ''
						BEGIN
							PRINT 'Descrição do Produto não Informada - Update'
							PRINT @cdProdutoERP
							CLOSE CS_ProdutoAtualizacao
							DEALLOCATE CS_ProdutoAtualizacao
							RAISERROR ('Descrição do Produto não Informada - Update',16,1)
							RETURN			
						END
					END
		
					-- Verifica se a unidade do produto foi informada
					BEGIN
						IF isnull(@dsUnidadeProdutoERP,'') = ''
						BEGIN
							PRINT 'Unidade do Produto não Informada - Update'
							PRINT @cdProdutoERP
							CLOSE CS_ProdutoAtualizacao
							DEALLOCATE CS_ProdutoAtualizacao
							RAISERROR ('Unidade do Produto não Informada - Update',16,1)
							RETURN		
						END
					END
				
					-- Verifica se o Grupo de Produto foi informado
					BEGIN
						IF isnull(@cdGrupoProdutoERP,'') = ''
						BEGIN
							PRINT 'Grupo do Produto não Informado - Update'
							PRINT @cdGrupoProdutoERP
							CLOSE CS_ProdutoAtualizacao
							DEALLOCATE CS_ProdutoAtualizacao
							RAISERROR ('Grupo do Produto não Informado - Update',16,1)
							RETURN		
						END
					END
					
					-- Verifica se o Quantidade de Embalagem foi informado
					--  Inibido até a verificação do problema pela Marisa
					BEGIN
						IF isnull(@QtEmbalagemProdutoERP,0) = 0
						BEGIN
							PRINT 'Quantidade de Embalagem do Produto não Informado - Update'
							PRINT @QtEmbalagemProdutoERP
							CLOSE CS_ProdutoAtualizacao
							DEALLOCATE CS_ProdutoAtualizacao
							RAISERROR ('Quantidade de Embalagem do Produto não Informado - Update',16,1)
							RETURN		
						END
					END
				
					-- Verifica se o Grupo de Produto informado está cadastrado no SFA
					BEGIN
						IF NOT EXISTS (	SELECT	1 FROM GrupoProduto
										WHERE	cdGrupoProdutoERP = @cdGrupoProdutoERP)
						BEGIN
							PRINT 'Grupo do Produto não cadastrado no SFA - Update'
							PRINT @cdGrupoProdutoERP
							CLOSE CS_ProdutoAtualizacao
							DEALLOCATE CS_ProdutoAtualizacao
							RAISERROR ('Grupo do Produto não cadastrado no SFA - Update',16,1)
							RETURN		
						END
					END
				
					-- Busca novo codigo de Grupo de Produto no SFA caso o mesmo tenha sido alterado
					IF rtrim(ltrim(isnull(@cdGrupoProdutoSEQERP,''))) <> rtrim(ltrim(isnull(@cdGrupoProdutoERP,'')))
					BEGIN
					
						SET @cdGrupoProdutoSEQ = 0
						SELECT	@cdGrupoProdutoSEQ = cdGrupoProdutoSEQ
						FROM	GrupoProduto
						WHERE	cdGrupoProdutoERP = @cdGrupoProdutoERP
						
						IF @cdGrupoProdutoSEQ = 0
						BEGIN
							PRINT 'Erro na busca do codigo do Grupo de Produto no SFA - codigo ERP'
							PRINT ltrim(rtrim(isnull(@cdGrupoProdutoERP ,''))) 
							CLOSE CS_ProdutoAtualizacao
							DEALLOCATE CS_ProdutoAtualizacao
							RAISERROR ('Erro na busca do codigo do Grupo de Produto no SFA - codigo ERP',16,1)
							RETURN
						END
						
					END
		
					-- Atualiza Registro no SFA		
					UPDATE Produto
					SET	dsProduto				= @dsProdutoERP,
						dsUnidadeProduto   		= @dsUnidadeProdutoERP,
						qtEmbalagemProduto   	= @qtEmbalagemProdutoERP,
						qtPesoLiquidoProduto   	= @qtPesoLiquidoProdutoERP,
						qtPesoBrutoProduto		= @qtPesoBrutoProdutoERP,
						wkProduto   			= @wkProdutoERP,
						cdRecnoMicrosiga		= @cdRecnoMicrosigaERP,
						cdGrupoProdutoSEQ		= @cdGrupoProdutoSEQ,
						dtUltimaAlteracao		= getdate(),
						cdUsuarioUltimaAlteracao = 9999, -- sera assumido 9999 para o Microsiga
						cdTipoProduto           = @cdTipoProdutoERP
					WHERE cdProdutoSEQ			= @cdProdutoSEQ
				
					-- Verifica Erro no Update
					IF @@ERROR <> 0  OR @@ROWCOUNT = 0
					BEGIN
						PRINT 'Erro no Update do Produto'
						PRINT @cdProdutoERP + ' - ' + @dsProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Erro no Update do Produto',16,1)
						RETURN
					END

					PRINT 'UPDATE - ' + @cdProdutoERP + ' - ' + @dsProdutoERP
						
				END
				
			END
			ELSE
			BEGIN --//Inclusao
			
				-- Verifica se o Codigo do Produto foi informado
				BEGIN
					IF isnull(@cdProdutoERP,'') = '' 
					BEGIN
						PRINT 'Codigo do Produto do ERP não Informado - Insert'
						PRINT @dsProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Codigo do Produto do ERP não Informado - Insert',16,1)
						RETURN
					END
				END
		
				-- Verifica se a Descricao do Produto foi informada
				BEGIN
					IF isnull(@dsProdutoERP,'') = ''
					BEGIN
						PRINT 'Descrição do Produto não Informada - Insert'
						PRINT @cdProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Descrição do Produto não Informada - Insert',16,1)
						RETURN			
					END
				END
		
				-- Verifica se a unidade do produto foi informada
				BEGIN
					IF isnull(@dsUnidadeProdutoERP,'') = ''
					BEGIN
						PRINT 'Unidade do Produto não Informada - Insert'
						PRINT @cdProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Unidade do Produto não Informada - Insert',16,1)
						RETURN		
					END
				END
				
				-- Verifica se o Grupo de Produto foi informado
				BEGIN
					IF isnull(@cdGrupoProdutoERP,'') = ''
					BEGIN
						PRINT 'Grupo do Produto não Informado - Insert'
						PRINT @cdGrupoProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Grupo do Produto não Informado - Insert',16,1)
						RETURN		
					END
				END
				
				-- Verifica se o Grupo de Produto informado está cadastrado no SFA
				BEGIN
					IF NOT EXISTS (	SELECT	1 FROM GrupoProduto
									WHERE	cdGrupoProdutoERP = @cdGrupoProdutoERP)
					BEGIN
						PRINT 'Grupo do Produto não cadastrado no SFA - Insert'
						PRINT @cdGrupoProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Grupo do Produto não cadastrado no SFA - Insert',16,1)
						RETURN		
					END
				END
				
				-- Busca codigo do Grupo de Produto no SFA
				SET @cdGrupoProdutoSEQ = 0
				SELECT	@cdGrupoProdutoSEQ = cdGrupoProdutoSEQ
				FROM	GrupoProduto
				WHERE	cdGrupoProdutoERP = @cdGrupoProdutoERP
				
				IF @cdGrupoProdutoSEQ = 0
				BEGIN
					PRINT 'Erro na busca do codigo do Grupo de Produto no SFA - codigo ERP - Insert'
					PRINT ltrim(rtrim(isnull(@cdGrupoProdutoERP ,''))) 
					CLOSE CS_ProdutoAtualizacao
					DEALLOCATE CS_ProdutoAtualizacao
					RAISERROR ('Erro na busca do codigo do Grupo de Produto no SFA - codigo ERP - Insert',16,1)
					RETURN
				END
			
				-- Verifica se o Quantidade de Embalagem foi informado
				-- Inibido até a verificação do problema pela Marisa
				BEGIN
					IF isnull(@QtEmbalagemProdutoERP,0) = 0
					BEGIN
						PRINT 'Quantidade de Embalagem do Produto não Informado - Update'
						PRINT @QtEmbalagemProdutoERP
						CLOSE CS_ProdutoAtualizacao
						DEALLOCATE CS_ProdutoAtualizacao
						RAISERROR ('Quantidade de Embalagem do Produto não Informado - Update',16,1)
						RETURN		
					END
				END
				
					
				-- Efetua a Inclusao
				INSERT INTO Produto (	cdProdutoERP,
										dsProduto,
										dsUnidadeProduto,
										qtEmbalagemProduto,
										qtPesoLiquidoProduto,
										qtPesoBrutoProduto,
										cdIndicadorLiberadoPedidoProduto,
										cdGrupoProdutoSEQ,
										wkProduto,
										cdRecnoMicrosiga,
										dtUltimaAlteracao,
										cdUsuarioUltimaAlteracao,
										cdTipoProduto
									)
					VALUES (			@cdProdutoERP,
										@dsProdutoERP,
										@dsUnidadeProdutoERP,
										@qtEmbalagemProdutoERP,
										@qtPesoLiquidoProdutoERP,
										@qtPesoBrutoProdutoERP,
										2,		-- Liberado = 2-não
										@cdGrupoProdutoSEQ,	
										@wkProdutoERP,
										@cdRecnoMicrosigaERP,
										getdate(),
										9999,	-- sera assumido 9999 para o Microsiga
										@cdTipoProdutoERP
							)
						
				IF @@ERROR <> 0
				BEGIN
					PRINT 'Erro na Inclusao do Produto na Base do SFA'
					PRINT @cdProdutoERP
					CLOSE CS_ProdutoAtualizacao
					DEALLOCATE CS_ProdutoAtualizacao
					RAISERROR ('Erro na Inclusao do Produto na Base do SFA',16,1)
					RETURN
				END

				PRINT 'INSERT - ' + @cdProdutoERP + ' - ' + @dsProdutoERP
				
			END
			
			FETCH NEXT FROM CS_ProdutoAtualizacao
			INTO	@cdProdutoERP,			           
				    @dsProdutoERP,			           
			        @dsUnidadeProdutoERP,	           
			        @qtEmbalagemProdutoERP,	             
			        @qtPesoLiquidoProdutoERP,             
			        @qtPesoBrutoProdutoERP,			             
			        @wkProdutoERP,			            
			        @cdRecnoMicrosigaERP,
			        @cdGrupoProdutoERP,
			        @cdTipoProdutoERP        
					
			SET @Fetch_Produto = @@FETCH_STATUS
			
		END
		
		CLOSE CS_ProdutoAtualizacao
		DEALLOCATE CS_ProdutoAtualizacao
		
		--- Verifica Exclusao do Produto 
		--- (mudanca de status de liberado para NÃO caso o registro tenha sido excluido no Microsiga)
		
		-- Defini Cursor para Verificar registros Excluidos no Microsiga
		DECLARE CS_ProdutoExclusao CURSOR FOR
		SELECT	cdProdutoSEQ
		FROM	Produto a
		-- WHERE	NOT EXISTS (	SELECT 1 FROM BDTSWK301.DADOSAP8.dbo.SB1010 b
		WHERE	NOT EXISTS (	SELECT 1 FROM DADOSAP8..SB1010 b		
								WHERE  b.B1_COD = a.cdProdutoERP collate SQL_Latin1_General_CP1_CI_AS
								AND    D_E_L_E_T_ = ''
								AND    B1_TIPO IN ('PA','AT'))
		AND		cdIndicadorLiberadoPedidoProduto = 1 -- somente registros ativos
		
		OPEN CS_ProdutoExclusao
		FETCH NEXT FROM CS_ProdutoExclusao
		INTO	@cdProdutoSEQ			           
						
		SET @Fetch_Produto = @@FETCH_STATUS
		
		WHILE @Fetch_Produto = 0
		BEGIN
	
			-- Atualiza Registro no SFA		
			UPDATE Produto
			SET	cdIndicadorLiberadoPedidoProduto = 2
			   ,dtUltimaAlteracao = getdate()
			   ,cdUsuarioUltimaAlteracao = 9999 -- codigo microsiga
			WHERE cdProdutoSEQ	= @cdProdutoSEQ
				
			-- Verifica Erro no Update
			IF @@ERROR <> 0  OR @@ROWCOUNT = 0
			BEGIN
				PRINT 'Erro no Update do Produto - Exclusão'
				PRINT @cdProdutoERP 
				CLOSE CS_ProdutoExclusao
				DEALLOCATE CS_ProdutoExclusao
				RAISERROR ('Erro no Update do Produto - Exclusão',16,1)
				RETURN
			END

			PRINT 'EXCLUSAO - ' + str(@cdProdutoSEQ) 

			FETCH NEXT FROM CS_ProdutoExclusao
			INTO	@cdProdutoSEQ			           
						
			SET @Fetch_Produto = @@FETCH_STATUS
						
		END	
		
		CLOSE CS_ProdutoExclusao
		DEALLOCATE CS_ProdutoExclusao		
		
		RETURN
		
	END

