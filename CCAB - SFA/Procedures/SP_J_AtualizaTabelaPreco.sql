SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_AtualizaTabelaPreco]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_AtualizaTabelaPreco]
END
GO


CREATE PROCEDURE SP_J_AtualizaTabelaPreco
		 @cdPessoaSEQ			bigint
		,@cdCronogramaSafraSEQ	bigint
	
AS

	BEGIN
	
		DECLARE @cdPessoaTabelaPrecoProdutoSEQ		bigint
		DECLARE @cdCronogramaSafraVencimentoSEQ		bigint
		DECLARE @vrDolarPessoaTabelaPrecoProduto	numeric(22,4)
		DECLARE @vrRealPessoaTabelaPrecoProduto		numeric(22,4)
		DECLARE @cdProdutoSEQ						bigint
		DECLARE @cdCronogramaSafraVencimentoREF		bigint
		DECLARE @Fetch_TabelaPreco					INT
		DECLARE @vrDolarPessoaTabelaPrecoProdutoCalc numeric(22,4)
		DECLARE @vrRealPessoaTabelaPrecoProdutoCalc	 numeric(22,4)
		DECLARE @pcCorrecaoPrecoTipoCulturaVencimentoCalc numeric(8,4)
		
		-- Busca Referencia do Valor Digitado (ultimo vencimento)
		SET @cdCronogramaSafraVencimentoREF = 0
		SELECT	TOP 1 @cdCronogramaSafraVencimentoREF = cdCronogramaSafraVencimentoSEQ
		FROM	CronogramaSafraVencimento
		WHERE	cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		ORDER BY cdTipoCronogramaSafraVencimento desc, dtCronogramaSafraVencimento desc
	
		-- Verifica Erro no Update
		IF @cdCronogramaSafraVencimentoREF = 0
		BEGIN
			PRINT 'Não há vencimento para o cronograma informado'
			PRINT @cdCronogramaSafraSEQ
			RAISERROR ('5002',16,1)
			RETURN
		END

		-- Defini Cursor para Atualização com base no Microsiga (Inclusao e Alteracao)
		DECLARE CS_PessoaTabelaPrecoProduto CURSOR FOR
		SELECT	cdPessoaTabelaPrecoProdutoSEQ,
				cdProdutoSEQ,
				cdCronogramaSafraVencimentoSEQ,
				vrDolarPessoaTabelaPrecoProduto,
				vrRealpessoaTabelaPrecoProduto
		FROM	PessoaTabelaPrecoProduto 
		WHERE	cdPessoaSEQ = @cdPessoaSEQ
		AND     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		
		OPEN CS_PessoaTabelaPrecoProduto
		FETCH NEXT FROM CS_PessoaTabelaPrecoProduto
		INTO	@cdPessoaTabelaPrecoProdutoSEQ,	
				@cdProdutoSEQ,	         
		        @cdCronogramaSafraVencimentoSEQ,		           
		        @vrDolarPessoaTabelaPrecoProduto,	                
		        @vrRealPessoaTabelaPrecoProduto	                  
						
		SET @Fetch_TabelaPreco = @@FETCH_STATUS
		
		WHILE @Fetch_TabelaPreco = 0
		BEGIN
		
			-- Verifica a Necessidade do Calculo
			IF @cdCronogramaSafraVencimentoSEQ <> @cdCronogramaSafraVencimentoREF
			BEGIN
			
				-- Busca os parametros de Calculo (Valor Base)
				SET @vrDolarPessoaTabelaPrecoProdutoCalc = 0
				SET @vrRealPessoaTabelaPrecoProdutoCalc = 0
				SELECT	@vrDolarPessoaTabelaPrecoProdutoCalc = vrDolarPessoaTabelaPrecoProduto,
						@vrRealPessoaTabelaPrecoProdutoCalc = vrRealPessoaTabelaPrecoProduto
				FROM	PessoaTabelaPrecoProduto
				WHERE	cdPessoaSEQ = @cdPessoaSEQ
				AND     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
				AND		cdProdutoSEQ = @cdProdutoSEQ
				AND     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoREF
				
				-- Busca os parametros de Calculo (percentual de desconto)
				if exists (	select 1 from CronogramaSafraVencimentoCooperativa a,
				                          CronogramaSafraVencimento b
							where a.cdCronogramaSafraVencimentoSEQ = b.cdCronogramaSafraVencimentoSEQ
							and   a.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
							and   b.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
							and   a.cdCooperativaSEQ = @cdPessoaSEQ)
				BEGIN

					-- Aplica a Regra da Cooperativa
					SET @pcCorrecaoPrecoTipoCulturaVencimentoCalc = 0
					SELECT	@pcCorrecaoPrecoTipoCulturaVencimentoCalc = pcCorrecaoPreco
					FROM	CronogramaSafraVencimentoCooperativa a,
					        CronogramaSafraVencimento b
					WHERE	a.cdCronogramaSafraVencimentoSEQ = b.cdCronogramaSafraVencimentoSEQ
					AND     a.cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
					AND     b.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					AND     a.cdCooperativaSEQ = @cdPessoaSEQ
					
				END
				ELSE
				BEGIN
				
					-- Aplica a Regra Generica
					SET @pcCorrecaoPrecoTipoCulturaVencimentoCalc = 0
					SELECT	@pcCorrecaoPrecoTipoCulturaVencimentoCalc = pcCorrecaoPrecoTipoCulturaVencimento
					FROM	CronogramaSafraVencimento 
					WHERE	cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
					AND     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					
				END
				
				-- Verifica se o Calculo é possível com os parametros (Dolar)
				IF @vrDolarPessoaTabelaPrecoProdutoCalc = 0 
				BEGIN
					SET @vrDolarPessoaTabelaPrecoProduto = 0
				END
				ELSE
				BEGIN
				
					-- Aplicar Regra Fechada com a Marisa (0 não tem preco, 1 mantem o preco, e diferente disso aplica o calculo)
					IF @pcCorrecaoPrecoTipoCulturaVencimentoCalc = 0
					BEGIN
						SET @vrDolarPessoaTabelaPrecoProdutoCalc = 0
					END
					
					IF @pcCorrecaoPrecoTipoCulturaVencimentoCalc = 1
					BEGIN
						SET @vrDolarPessoaTabelaPrecoProdutoCalc = @vrDolarPessoaTabelaPrecoProdutoCalc
					END
					
					IF @pcCorrecaoPrecoTipoCulturaVencimentoCalc <> 0 AND @pcCorrecaoPrecoTipoCulturaVencimentoCalc <> 1
					BEGIN
						SET @vrDolarPessoaTabelaPrecoProdutoCalc = @vrDolarPessoaTabelaPrecoProdutoCalc - ( @vrDolarPessoaTabelaPrecoProdutoCalc * (@pcCorrecaoPrecoTipoCulturaVencimentoCalc/100))
					END
					
				END
					
				-- Verifica se o Calculo é possível com os parametros (Real)
				IF @vrRealPessoaTabelaPrecoProdutoCalc = 0 
				BEGIN
					SET @vrRealPessoaTabelaPrecoProduto = 0
				END
				ELSE
				BEGIN
				
					-- Aplicar Regra Fechada com a Marisa (0 não tem preco, 1 mantem o preco, e diferente disso aplica o calculo)
					IF @pcCorrecaoPrecoTipoCulturaVencimentoCalc = 0
					BEGIN
						SET @vrRealPessoaTabelaPrecoProdutoCalc = 0
					END
					
					IF @pcCorrecaoPrecoTipoCulturaVencimentoCalc = 1
					BEGIN
						SET @vrRealPessoaTabelaPrecoProdutoCalc = @vrRealPessoaTabelaPrecoProdutoCalc
					END
					
					IF @pcCorrecaoPrecoTipoCulturaVencimentoCalc <> 0 AND @pcCorrecaoPrecoTipoCulturaVencimentoCalc <> 1
					BEGIN
						SET @vrRealPessoaTabelaPrecoProdutoCalc = @vrRealPessoaTabelaPrecoProdutoCalc - ( @vrRealPessoaTabelaPrecoProdutoCalc * (@pcCorrecaoPrecoTipoCulturaVencimentoCalc/100))
					END
					
				END
					
				-- Efetua Update do Preco
				UPDATE	PessoaTabelaPrecoProduto
				SET		vrDolarPessoaTabelaPrecoProduto = @vrDolarPessoaTabelaPrecoProdutoCalc,
						vrRealpessoaTabelaPrecoProduto = @vrRealPessoaTabelaPrecoProdutoCalc
				WHERE	cdPessoaTabelaPrecoProdutoSEQ = @cdPessoaTabelaPrecoProdutoSEQ

				-- Verifica Erro no Update
				IF @@ERROR <> 0  OR @@ROWCOUNT = 0
				BEGIN
					PRINT 'Erro no Update da Tabela de Preco - Recalculo'
					PRINT @cdPessoaTabelaPrecoProdutoSEQ
					CLOSE CS_PessoaTabelaPrecoProduto
					DEALLOCATE CS_PessoaTabelaPrecoProduto
					RAISERROR ('5002',16,1)
					RETURN
				END

				
			END
			
			FETCH NEXT FROM CS_PessoaTabelaPrecoProduto
			INTO	@cdPessoaTabelaPrecoProdutoSEQ,	
					@cdProdutoSEQ,	         
					@cdCronogramaSafraVencimentoSEQ,		           
					@vrDolarPessoaTabelaPrecoProduto,	                
					@vrRealPessoaTabelaPrecoProduto	                  
						
			SET @Fetch_TabelaPreco = @@FETCH_STATUS
					
		END
		
		CLOSE CS_PessoaTabelaPrecoProduto
		DEALLOCATE CS_PessoaTabelaPrecoProduto
		
		RETURN
		
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

