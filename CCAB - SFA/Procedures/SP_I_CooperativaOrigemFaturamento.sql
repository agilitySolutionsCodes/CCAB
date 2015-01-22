/******************************************************************************
**		File: SP_I_CooperativaOrigemFaturamento.SQL
**		Name: SP_I_CooperativaOrigemFaturamento
**		Desc: Insere um registro na tabela 
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 25/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CooperativaOrigemFaturamento]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_I_CooperativaOrigemFaturamento]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_I_CooperativaOrigemFaturamento]
(
	@cdCooperativaOrigemFaturamentoSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ					bigint			= NULL,	
	@cdCooperativaSEQ						bigint			= NULL,
	@cdOrigemFaturamentoSEQ					bigint			= NULL,
	@cdIndicadorSituacaoOrigemFaturamento	bigint			= NULL,	
	@wkCooperativaOrigemFaturamento			varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao				bigint			= NULL
)	
AS

	BEGIN 
	
		--Verifica se é alteracao
		IF @cdCooperativaOrigemFaturamentoSEQ IS NULL
		
			BEGIN
		
				INSERT INTO CooperativaOrigemFaturamento
				(					
					cdCronogramaSafraSEQ,                 
					cdCooperativaSEQ,                     
					cdOrigemFaturamentoSEQ,               
					cdIndicadorSituacaoOrigemFaturamento, 
					wkCooperativaOrigemFaturamento,       
					dtUltimaAlteracao,                    
					cdUsuarioUltimaAlteracao             					
				)
				VALUES
				(			
					@cdCronogramaSafraSEQ,                 
					@cdCooperativaSEQ,                     
					@cdOrigemFaturamentoSEQ,               
					@cdIndicadorSituacaoOrigemFaturamento, 
					@wkCooperativaOrigemFaturamento,       
					GETDATE(),                 
					@cdUsuarioUltimaAlteracao 
				)	 
				
				SELECT SCOPE_IDENTITY()		
			END
		
		ELSE
		
			UPDATE CooperativaOrigemFaturamento SET 
			
					wkCooperativaOrigemFaturamento			= @wkCooperativaOrigemFaturamento,
					dtUltimaAlteracao						= GETDATE(),
					cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao,
					cdIndicadorSituacaoOrigemFaturamento	= @cdIndicadorSituacaoOrigemFaturamento					
					
			WHERE
					cdCooperativaOrigemFaturamentoSEQ = @cdCooperativaOrigemFaturamentoSEQ
	
	END
	
GO
	
 
/*
	Teste
	
	[SP_I_CooperativaOrigemFaturamento] @cdCooperativaOrigemFaturamentoSEQ = 6,										
										@wkCooperativaOrigemFaturamento = 'Teste',
										@cdUsuarioUltimaAlteracao = 4,
										@cdIndicadorSituacaoOrigemFaturamento = 2

*/





