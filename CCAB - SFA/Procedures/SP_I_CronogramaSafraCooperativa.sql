/******************************************************************************
**		File: SP_I_CronogramaSafraCooperativa.sql
**		Name: SP_I_CronogramaSafraCooperativa
**		Desc: Insere um registro na tabela 
**
**		Auth: Roberto (Convergence)
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CronogramaSafraCooperativa]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_I_CronogramaSafraCooperativa]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_I_CronogramaSafraCooperativa]
(
	@cdCronogramaSafraCooperativaSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ					bigint			= NULL,	
	@cdPessoaSEQ							bigint			= NULL,
	@cdIndicadorSituacaoCooperativa			bigint			= NULL,	
	@wkCronogramaSafraCooperativa			varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao				bigint			= NULL	
)	
AS

	BEGIN 
	
		--Verifica se é alteracao
		IF @cdCronogramaSafraCooperativaSEQ IS NULL
		
			BEGIN
		
				INSERT INTO CronogramaSafraCooperativa
				(
					cdCronogramaSafraSEQ,				
					cdPessoaSEQ,
					wkCronogramaSafraCooperativa,
					dtUltimaAlteracao,	
					cdUsuarioUltimaAlteracao,
					cdIndicadorSituacaoCooperativa
				)
				VALUES
				(			
					@cdCronogramaSafraSEQ,				
					@cdPessoaSEQ,
					@wkCronogramaSafraCooperativa,
					GETDATE(),	
					@cdUsuarioUltimaAlteracao,
					@cdIndicadorSituacaoCooperativa
				)	 
				
				SELECT SCOPE_IDENTITY()		
			END
		
		ELSE
		
			UPDATE CronogramaSafraCooperativa SET 
			
					wkCronogramaSafraCooperativa		= @wkCronogramaSafraCooperativa,
					dtUltimaAlteracao			= GETDATE(),
					cdUsuarioUltimaAlteracao	= @cdUsuarioUltimaAlteracao,
					cdIndicadorSituacaoCooperativa		= @cdIndicadorSituacaoCooperativa
					
			WHERE
					cdCronogramaSafraCooperativaSEQ = @cdCronogramaSafraCooperativaSEQ
	
	END
	
GO
	
 






